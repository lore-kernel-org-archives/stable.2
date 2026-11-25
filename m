Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625722;
	b=s4Pu8nBi2bFj15NuRa5uxHnPoRYfinHx6+2Xq0QVuPZj6orrAQH+rQKOpFK3+ux6KzUB
	 HrciE66FuAWTegfnDA+b4CtI5gW5QYceDI/Le4ticEQg+n+IMek6FriCjgqXQG5MKKZ3N
	 U+fEu9ls45+OB9qHE51+hHbCA3G+634/5UH7yFDFcWVaVdzrtucKBDU1NRRGlJTEGSLF2
	 x1P/kbCTy8n7IJnHme9KyQVm39fNcJ/4N45kAp/PCXE4Xht3HUupriUvKNtAejAFBagf1
	 5+oPyr8Tlk9gkOOqfX9Jw9RSyYczRNAN5/aJU1C0uhDQU+JpNfqYFCULeu++qwcatWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625722;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=X7jRmwNGH0pvJPT4iczLREYaGgA2/WmZOYdGXzrhRpo=;
	b=RB2Bhk/XKcifeZVfXMQszgo+hMot/hhXeSZhNwnGQDWONE0M8JfJOd7LkHYRpRTIPNnF
	 LevwxWR42qoaOuMzJ3QPf2f9lBo8jGPfr+7hphOuBER2yWZKVkYGdOXFkhS6XJuGRLEMT
	 z8BANl78sokgM4SKFbwYgiz+lxM0898rNN5pB36uSHcq4KiAXr+zcO6DfM6PxK1qoyC0j
	 kpPQGY7Bnd7Zk2t8G6O0asJ1yHgXA5j+cLMPBkUEVwQlcDrdFHF2eQAuuW46dTOOq821q
	 aFVAEXb2d5Y5uUWh5Cbu8Oz9h5ONcqkdPTv/o8LVgM30kIpjV+ARr5i1qOMPK8kW3FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWU7inY0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB3606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWU7inY0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7B71F000C0;
	Wed, 25 Nov 2026 16:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625722;
	bh=X7jRmwNGH0pvJPT4iczLREYaGgA2/WmZOYdGXzrhRpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cWU7inY0bB/h8sAoM6FNtqRKDsDYyzkCahjlmnrVOygr4mizjVN34FFGWavwCvj1S
	 DOY2vq8C5T4MF221wlf03xQDDFbvbDrPfvj/+MLoXldBLneS8i00X+3ybHvODpeviR
	 BiNTzcB9nfgqbBTaIdnBX62GH1J7W/kE7RqdC57xFtpNvC0bxvjWU4swdgekrHuqpP
	 yXOVsX1fO/0djD3VdqLqZTAvNPR5bC9FgTKF8xrVBiOIKIsM6UwIifXH0d/O8MiD1Y
	 02ARZbV/8mqV3fTItsbYWuzRGRtLQeWDs+tjk6sm874Q9kmdERxh8mQmHVM0dkywc7
	 yu2PcGSoVsBPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tim Menninger <tmenninger@everpuredata.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] pNFS: avoid repeatedly cancelling I/O for the same lseg
Date: Wed, 25 Nov 2026 11:55:20 -0500
Message-ID: <20261125165503.900689-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112558-pacific-polka-65e6@gregkh>
References: <2026112558-pacific-polka-65e6@gregkh>
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
[ sashal: Adapted to a tree without striping or device-specific cancel: the bitmap has one bit per mirror (sized by mirror_array_cnt, indexed by idx) instead of per mirror stripe. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 11 +++++++++++
 fs/nfs/flexfilelayout/flexfilelayout.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index c6bc831b95413..841b916f9515a 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -11,6 +11,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/nfs_page.h>
 #include <linux/module.h>
+#include <linux/bitmap.h>
 #include <linux/sched/mm.h>
 
 #include <linux/sunrpc/metrics.h>
@@ -267,6 +268,7 @@ static void _ff_layout_free_lseg(struct nfs4_ff_layout_segment *fls)
 {
 	if (fls) {
 		ff_layout_free_mirror_array(fls);
+		bitmap_free(fls->cancelled_stripes);
 		kfree(fls);
 	}
 }
@@ -553,6 +555,12 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
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
@@ -2201,6 +2209,9 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg)
 
 	for (idx = 0; idx < flseg->mirror_array_cnt; idx++) {
 		mirror = flseg->mirror_array[idx];
+		/* Do not cancel a stripe again while this lseg drains. */
+		if (test_and_set_bit(idx, flseg->cancelled_stripes))
+			continue;
 		mirror_ds = mirror->mirror_ds;
 		if (IS_ERR_OR_NULL(mirror_ds))
 			continue;
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index 1d4294c6a7ec4..4757aa633d1ea 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -99,6 +99,7 @@ struct nfs4_ff_layout_segment {
 	u64				stripe_unit;
 	u32				flags;
 	u32				mirror_array_cnt;
+	unsigned long			*cancelled_stripes;
 	struct nfs4_ff_layout_mirror	*mirror_array[];
 };
 
-- 
2.53.0

