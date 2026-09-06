Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6434EF1F
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788708922; cv=none; b=kJynGY8Dt0nNe6aMkqG1dw4ytme39OfcAAYLCXERq0liCJUO+kgl4p9YW2NMMxBC/+yX5FVqml+Kf3JXX2ZqcIcCW1Yu2TCGEod77FrnBF6n9U6FM2T8MqkzGXrIUc6c7I3Co+2JRX+mpv3SbtsJxZaMODpmtk6L52bwTqmv9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788708922; c=relaxed/simple;
	bh=mHkg3OOBY3ed2aStFwj3DHFBqnzRUWTxscXnNKi2jYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5mea6HMDGaiYXid8tlNzQLI4k3CzSOzTxMmmKwW+IbtoF/hQRAr1KVsopkUjebZEqCWXQQIAGCiauhE/wI+CNsImlhrzDoyvz2rTOn4cggmcTotPH4YcZDMf5hH00QLgZb/DIcDzi6grPx+dGEjE7OwWeqGe2rpRGTfbhb1wI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4XI4fnp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4XI4fnp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4C91F00A3A;
	Sun,  6 Sep 2026 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788708918;
	bh=poA8LqxahR+1K10b6C2vIluhGwGnT/RrcpnY55UIr5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R4XI4fnpo5RSzO+z6qgQV0qkpWUWz6ioLNr3qForxlHxRNzVj5YNgzppNsF1XU9J5
	 YLC4U5CQ+JcolkP93YNshAG+Y0oxLoT1baqnuxv7ptX7tgh61TjHsAwXQ6HyncWO6u
	 AsvIdmGAqx5nktPiyE/sbKR3uuzNLzjg3b4Gbi1lem6XvS57DQOcTx/8+b3nBbGsXS
	 Jo3ABdWNE02C6KkddBuf6Yjet3yPI6C23lW65ynLgs/5q4fVAARdvXFkK+I+BPyss1
	 3K3Ts3boUFwo9REpUFZ+16XxECt3qnPXLRBNhe/NytSqmMcYv5BH8ar1dln+I23D32
	 vK+FOktQwkqmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ceph: bound num_export_targets array for mds info v2/v3
Date: Sun,  6 Sep 2026 11:35:15 -0400
Message-ID: <20260906153515.1477827-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090336-mashing-extended-23ed@gregkh>
References: <2026090336-mashing-extended-23ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit a3eb169ee297aa99670ba927c659990bd1e453f3 ]

ceph_mdsmap_decode() in fs/ceph/mdsmap.c reads num_export_targets from
each per-mds info record and advances the decode cursor by
num_export_targets * sizeof(u32) without first checking that many bytes
remain. The only upper-bound check that catches a runaway cursor
(*p > info_end) is gated on info_v >= 4, because info_end is left NULL
for info_v 2 and 3. When the monitor sends an MDS map whose per-mds
info version is 2 or 3 with an oversized num_export_targets, the cursor
moves past the message front buffer and the later export-targets loop
calls the unchecked ceph_decode_32() on out-of-bounds memory.

A kernel client processes CEPH_MSG_MDS_MAP from its monitor session
(net/ceph/mon_client.c dispatches it; fs/ceph/super.c routes it to
ceph_mdsc_handle_mdsmap(), which sets end to the front buffer bound and
calls ceph_mdsmap_decode()). A malicious or compromised monitor, or an
on-path attacker on an unsigned/unencrypted messenger session, can
therefore drive an out-of-bounds read in the client kernel; on x86_64
with KASAN it is reported as a slab-out-of-bounds read in
ceph_mdsmap_decode(). The decoded values land in the internal
info->export_targets[] array, so the consequence is a kernel
out-of-bounds read, not an information leak to the attacker.

Impact: a malicious or compromised Ceph monitor sending an MDS map with
a per-mds info version of 2 or 3 and an oversized num_export_targets
field triggers an out-of-bounds read in the CephFS client kernel.

Add a ceph_decode_need() for the export-targets array before advancing
the cursor, so the bound is enforced for every info_v >= 2, not only
info_v >= 4. This mirrors the count-then-need idiom already used for
m_data_pg_pools later in the same function.

Compute the export-targets byte count with size_mul() and reuse that
checked length when advancing the cursor, so the attacker-controlled
num_export_targets multiplication fails closed on overflow rather than
relying on the later kcalloc() guard.

Cc: stable@vger.kernel.org
Fixes: d463a43d69f4 ("ceph: CEPH_FEATURE_MDSENC support")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ omitted the newer-kernel-only adjacent `u32 target` local absent from Linux 5.10. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mdsmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 9699de85a15e2..4f05ac84b867a 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -3,6 +3,7 @@
 
 #include <linux/bug.h>
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -122,6 +123,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
 	int err;
 	u8 mdsmap_v;
 	u16 mdsmap_ev;
+	size_t export_targets_len;
 
 	m = kzalloc(sizeof(*m), GFP_NOFS);
 	if (!m)
@@ -219,8 +221,11 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
 		*p += namelen;
 		if (info_v >= 2) {
 			ceph_decode_32_safe(p, end, num_export_targets, bad);
+			export_targets_len = size_mul(num_export_targets,
+						      sizeof(u32));
+			ceph_decode_need(p, end, export_targets_len, bad);
 			pexport_targets = *p;
-			*p += num_export_targets * sizeof(u32);
+			*p += export_targets_len;
 		} else {
 			num_export_targets = 0;
 		}
-- 
2.53.0

