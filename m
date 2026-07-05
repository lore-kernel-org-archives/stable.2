Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA03815DE
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260079; cv=none; b=m4+1Uc7dAM4EGj8STauYLfFEDapGZmSBw9N9bGmKLJWvJ1qzWBvWY5fvverJLn3eOEgVvw+NgX/SsnWmlmP1Z9owoe02l5vxtQ9vt5xCU17jtAgOx6tDLi3c4q+ulEnZWP8HKPc6b5c71stI/r5QeRuePrlSLrvxlELea8pj+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260079; c=relaxed/simple;
	bh=WHgNWmVQnoujGBRCer0G2pGDU8mNGaS9JIG9zfXBwfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYc7jeXXnMQU4eDSTCiLI+pIDY6qQ3FQGIyjSVf8vAz8DF633pAAIYOvQ53WBIGUibWvd/I8aeWfACIHMmSbyOjeeUFl6kpOMjtUdSQe5rd+Q9fSV0uvYd2qGiQWZUJ1DbYsz+B4ZEKv73CbjJGs13aUPtbpT0gz0nccOVzrV4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjPGj/oP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjPGj/oP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07731F00A3A;
	Sun,  5 Jul 2026 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260078;
	bh=4Zmyz1OHyluuz4QJkTukADxyXz0Lp+7sWjgp40rkQB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gjPGj/oP6cC7I9H8NT1B5BP3xS8ls5lGBUvglTQ/QV89Ay1uAXD+wqEF7pwmhAN0F
	 DNVc4WiFqEFp42weqdRZTAFskHMZhu3LXytXUIe6WngUwBwyTfn51nNR3JeNdFuL2l
	 vzVeY5j6tsFtcaEY0PNrzN9eAQWeib1UzNHpRrP7cJOiqTcAB4Pm72tf+RAtmTe+RM
	 R//4M67P8zStOOV/wQ+7gVixrwFE4vPD9rrIoRnw+toE2EK09bDoujJHzOkoqTvsjl
	 Pp2XqD/8P6R9/AQShuKqKF5TkQwFVBacydJ3Z7dLdmKrIWs/UUhISiEqLwmw4VH8GD
	 kN2YzBc+JY3lQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] NFSv4/flexfiles: reject zero filehandle version count
Date: Sun,  5 Jul 2026 10:01:16 -0400
Message-ID: <20260705140116.1746651-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070243-trimness-trickle-088e@gregkh>
References: <2026070243-trimness-trickle-088e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 2c6bb3c40bc24f6aa8dfbe6fe98c3ad6389203f2 ]

ff_layout_alloc_lseg() decodes the filehandle-version array count
from the flexfiles layout body. The value is used as the count for
kzalloc_objs(), and the current code only rejects NULL.

A zero count yields ZERO_SIZE_PTR, which can be stored in
dss_info->fh_versions even though later flexfiles paths assume that at
least one filehandle version exists.

Reject fh_count == 0 before the allocation, matching the existing zero
version_count validation in the flexfiles GETDEVICEINFO parser.

A QEMU/KASAN run with a malformed flexfiles layout hit:

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:ff_layout_encode_ff_layoutupdate.isra.0+0x15f/0x750
  ff_layout_encode_layoutreturn+0x683/0x970
  nfs4_xdr_enc_layoutreturn+0x278/0x3a0
  Kernel panic - not syncing: Fatal exception

The patched kernel rejects the malformed layout without KASAN/oops/panic,
and a valid fh_count=1 regression still opens, reads, and unmounts cleanly.

Cc: stable@vger.kernel.org
Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 42c73c647a27fe..98536d2dad5e1f 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -460,6 +460,10 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		if (!p)
 			goto out_err_free;
 		fh_count = be32_to_cpup(p);
+		if (fh_count == 0) {
+			rc = -EINVAL;
+			goto out_err_free;
+		}
 
 		fls->mirror_array[i]->fh_versions =
 			kcalloc(fh_count, sizeof(struct nfs_fh),
-- 
2.53.0

