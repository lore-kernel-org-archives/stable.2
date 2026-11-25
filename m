Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625159;
	b=Swv3I8xHcokei+8SaHHVCe90bc9H8OKJK7ZCds+M3QiwtFnI7AbLCeGJH5gwwCMEOijX
	 B5/BeQ0XmM8J6XlC5wiiBMBWsFQ7xAJpbYMD8DMxSP7jM1E7yoYrubtXF6s4SGBBucr97
	 g/Vwb+ASekhfEv7lN/8EzAPotJE4JVFEhBbkGnaPln0GOIR48i0uTIJG5Gx2piqXSTkcm
	 /oxRXR/WLeNFiQG8Fyo2vHj4w5FppmN/mZ0hNcaaTnGGJdis2qJNcOnrBQA+kbPYqoUS2
	 CpKOpSQbHiqTQ/abys2RBj3JWUvd1EELDkv9q5ixweveb6tV8oSwXvsxZd0EJ2grJPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625159;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cqUwYW0Z9r3mpmMKIs2i/vz9aPZFdEcomWRwyQfhIrw=;
	b=NqeHbQAGgO2rhxJRbcPIfLcnSMzRO4fhz63Dh3Aw6d11gZ+LA9BX901pmmxzVFOjEkih
	 R3mhyYjL63FUmRDdBmxNz/2tmSdoofYHaoE/qwjNCXbfvHRmtTOLm2WEruN7TpvXn7lZf
	 49D7m2TLE/JbboDckL+/96VS1wSEEvkc+oG/duZVubBS+WyGDIsagCCDp/f9/Hd5coucT
	 w8hmp36D50XYOiyIT+euVPuN599MjQzAbvzbUJKjOJmOXsXa6oHsp9E6U8qOJj1pPCsTQ
	 OfKULZ9T4WCUdoB8WQT/CVCnB+H/SvJdRYd4z0OKlx4/Bo/jV1YPz7rTTDLfPbZH6TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akKUnKjI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B62606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akKUnKjI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6CF1F000D0;
	Wed, 25 Nov 2026 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625158;
	bh=cqUwYW0Z9r3mpmMKIs2i/vz9aPZFdEcomWRwyQfhIrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=akKUnKjIZoCN73KNP3/u4FUqji3cmAsYqw4UW3FEw5X7amhtULmHkWeCPOjFfd8Nd
	 oh2THq8j58oRhWu51mnr0UkD53KUVgqazp88rkrh3uizwbbjoUHAy6JTSvp9CNXnWr
	 qxlPqwSjVwHydu38XeCPHCehOVl0WyCbMIkLGn6L2ROV45K6vd/KkQAbtYPIsQr1wA
	 rv5x4enUa4FS/g9PuV1kQw5ROLxo+hWFJ1cxW6WmEqpdPz1BKbqUKsQJUuO2/M+W8G
	 5RWWCxinnH3KySSAhGyKvyddOprbiCy/JEQhCJAGqfiTVEppMlHqLEoZy93377b8an
	 MNatp+SD2m+jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tim Menninger <tmenninger@everpuredata.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] pNFS: avoid repeatedly cancelling I/O for the same lseg
Date: Wed, 25 Nov 2026 11:45:56 -0500
Message-ID: <20261125164533.860584-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112557-unbolted-power-ae17@gregkh>
References: <2026112557-unbolted-power-ae17@gregkh>
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
[ sashal: Adapted the ff_layout_cancel_io() hunk to this tree's older one-argument version with no devid filter or RCU, placing the cancelled_stripes guard after the mirror_ds check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 12 ++++++++++++
 fs/nfs/flexfilelayout/flexfilelayout.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index f45508bd30f6e..48c769f05b8a2 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -11,6 +11,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/nfs_page.h>
 #include <linux/module.h>
+#include <linux/bitmap.h>
 #include <linux/file.h>
 #include <linux/sched/mm.h>
 
@@ -337,6 +338,7 @@ static void _ff_layout_free_lseg(struct nfs4_ff_layout_segment *fls)
 {
 	if (fls) {
 		ff_layout_free_mirror_array(fls);
+		bitmap_free(fls->cancelled_stripes);
 		kfree(fls);
 	}
 }
@@ -652,6 +654,12 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		fls->mirror_array[i]->report_interval = be32_to_cpup(p);
 
 out_sort_mirrors:
+	fls->cancelled_stripes = bitmap_zalloc(
+		fls->mirror_array_cnt * dss_count, gfp_flags);
+	if (!fls->cancelled_stripes) {
+		rc = -ENOMEM;
+		goto out_err_free;
+	}
 	ff_layout_sort_mirrors(fls);
 	ret = &fls->generic_hdr;
 	dprintk("<-- %s (success)\n", __func__);
@@ -2548,6 +2556,10 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg)
 			mirror_ds = mirror->dss[dss_id].mirror_ds;
 			if (IS_ERR_OR_NULL(mirror_ds))
 				continue;
+			/* Do not cancel a stripe again while this lseg drains. */
+			if (test_and_set_bit(idx * mirror->dss_count + dss_id,
+					     flseg->cancelled_stripes))
+				continue;
 			ds = mirror->dss[dss_id].mirror_ds->ds;
 			if (!ds)
 				continue;
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index ec69cd1c3ae96..311df9306b055 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -109,6 +109,7 @@ struct nfs4_ff_layout_segment {
 	u64				stripe_unit;
 	u32				flags;
 	u32				mirror_array_cnt;
+	unsigned long			*cancelled_stripes;
 	struct nfs4_ff_layout_mirror	*mirror_array[] __counted_by(mirror_array_cnt);
 };
 
-- 
2.53.0

