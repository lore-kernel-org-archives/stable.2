Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625444;
	b=gy7ihi58L4MSEBFec+N6my1XUN2WYQmBRBV7sD5+5CJPKAwU2VQ3Ajx462Icqw16Rywj
	 08aiWOjPvWSLcBjcrqaO9qsTK8QY6zFAv23OOmSxdlNgT+hYsjAbnsuwktjS+MXRsf1iZ
	 Adtrmjy7MREt/4sTs73oRQa78eVVTj7PU50tceMc+9jLr+cA5t1sGCD2oXIzT1ZO5NYUQ
	 pY41xxauyXqDlMnVM0Bt167Qfvs/OY8TuhhWs0dzJroY3VUU4x7ndkaa+YbQGsj0wElc0
	 Auk8q2UVAEDJzK1NXvt/lULpZoxILVrpNXKHE2BIWtDWSacCas/ilsq0XFtZ+MZARaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625444;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7LEDRSRhjGg5Hlp28sLTf5iiT7XNHqs4kdaashD3E8s=;
	b=kt4ajJ7C+6K56xfY3pQ6XmFJh/FNi4doY/tksYlAu9YL0MUQtuVTF0tHbnjqxQTFQx2p
	 PBnIiirjkPsgPjkuUcB0KuMVyewU9tI82JMtUBUQN4u7XsrVHoRjLloVm9nqcl4T8cV5X
	 awTwVcd1zw13FcA17/h/NIT7rPot9RNOD/I/5DXUV/DVeO3Ji7QcAsbviLRoWDpcoeJD3
	 zAh9x5159+TtM9DHQzT7lz0ZZ5ZD0BS6avV4rSk9Xvf4032NCTYLA4J/CJx0XHG+pXno3
	 GAkS72v5nljPxJEFYtsNfaMETmocM7Y891ErT6TbOdpA3S0scGeIkeIXyCZ5BnWPjRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTkaSxIK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CAA606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTkaSxIK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EF61F000D4;
	Wed, 25 Nov 2026 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625444;
	bh=7LEDRSRhjGg5Hlp28sLTf5iiT7XNHqs4kdaashD3E8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RTkaSxIKvgrQtD3p6sX8jKa/rt6EF+z4CSexu1Q4ca5Xi/JmB2n0mfc0QDDcioNgq
	 QQWg6ZGB+Os93LIIuTzgmVNtuWlh58UrzmqeyMlCQ9Usj/Imt+Q/lOgJol84iXi+t5
	 wtiKpYOFQFuG4Kahwy0qpTsCiE2QfcpNGZ1m8MEKwLRe6vtqcE1yJpzxepKxS4V6uZ
	 VNG8sMVgRs5Q6MDsLZele4FBqYbV7GualaFdXq+EPIWa6MOfLbD8iD1DWjvpuBLrmS
	 C8zNSaKv1kgM9QGxRtlAgaPA/ldbTy6ff3gHB7krQfb+1Tj8zjLdmsZkmndyWnDGDw
	 FyB/pt9vpksRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tim Menninger <tmenninger@everpuredata.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] pNFS: avoid repeatedly cancelling I/O for the same lseg
Date: Wed, 25 Nov 2026 11:50:42 -0500
Message-ID: <20261125165025.883267-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112558-afoot-retread-cd75@gregkh>
References: <2026112558-afoot-retread-cd75@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tim Menninger <tmenninger@everpuredata.com>

[ Upstream commit 9e28836b480c66cca4c3d391177f5b3a50927f7d ]

Commit b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if the layout is
recalled or revoked") added I/O cancellation when a layout segment is
invalidated while outstanding references remain.

The invalid segment stays on the layout's segment list until those
references drain. Subsequent scans can find it again and repeatedly
invoke the layout driver's cancel_io() callback. For flexfiles, this
cancels matching RPC tasks and disconnects data server RPC clients.
During RPC/RDMA data server recovery, repeated cancellation can cause a
reconnect loop that consumes essentially all client CPU and prevents
forward progress.

Record cancellation requests per mirror stripe in the flexfiles layout
segment. Each stripe is cancelled at most once, regardless of how many
times the invalid segment is encountered. A per-stripe bitmap rather
than a single per-segment bit preserves the ability to cancel I/O to a
different device after an earlier device-specific cancellation.

Cancellation is best-effort. An RPC that has already passed the
layout-validity check may not yet be visible to the cancellation
scan. Such I/O retains its lseg reference and remains subject to
the normal RPC completion and recovery paths. Suppress repeated
cancellation and disconnect requests without changing the existing
lseg lifetime and deferred layout-return accounting.

This reproduced on 6.8.0, 7.0.0, and 7.4.0-rc1. It was tested on
7.4.0-rc1 with sustained pNFS/flexfiles I/O over RPC/RDMA while
restarting the NFS service on a data server. Without it, repeated
cancellation led to a reconnect loop and no workload recovery. With it,
the client recovered after the data server returned.

Fixes: b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if the layout is recalled or revoked")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
[ sashal: Adapted the cancelled-stripes bitmap to the single-stripe layout here: it is sized by mirror count and indexed by mirror idx, since there is no devid argument or per-stripe loop in cancel_io. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 11 +++++++++++
 fs/nfs/flexfilelayout/flexfilelayout.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 83e78513e2ef1..f5c297893fe56 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -11,6 +11,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/nfs_page.h>
 #include <linux/module.h>
+#include <linux/bitmap.h>
 #include <linux/file.h>
 #include <linux/sched/mm.h>
 
@@ -300,6 +301,7 @@ static void _ff_layout_free_lseg(struct nfs4_ff_layout_segment *fls)
 {
 	if (fls) {
 		ff_layout_free_mirror_array(fls);
+		bitmap_free(fls->cancelled_stripes);
 		kfree(fls);
 	}
 }
@@ -588,6 +590,12 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		fls->mirror_array[i]->report_interval = be32_to_cpup(p);
 
 out_sort_mirrors:
+	fls->cancelled_stripes = bitmap_zalloc(fls->mirror_array_cnt,
+					       gfp_flags);
+	if (!fls->cancelled_stripes) {
+		rc = -ENOMEM;
+		goto out_err_free;
+	}
 	ff_layout_sort_mirrors(fls);
 	ret = &fls->generic_hdr;
 	dprintk("<-- %s (success)\n", __func__);
@@ -2254,6 +2262,9 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg)
 
 	for (idx = 0; idx < flseg->mirror_array_cnt; idx++) {
 		mirror = flseg->mirror_array[idx];
+		/* Do not cancel a stripe again while this lseg drains. */
+		if (test_and_set_bit(idx, flseg->cancelled_stripes))
+			continue;
 		mirror_ds = mirror->dss[0].mirror_ds;
 		if (IS_ERR_OR_NULL(mirror_ds))
 			continue;
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index 1561e9ceab534..143c183cb19f2 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -106,6 +106,7 @@ struct nfs4_ff_layout_segment {
 	u64				stripe_unit;
 	u32				flags;
 	u32				mirror_array_cnt;
+	unsigned long			*cancelled_stripes;
 	struct nfs4_ff_layout_mirror	*mirror_array[] __counted_by(mirror_array_cnt);
 };
 
-- 
2.53.0

