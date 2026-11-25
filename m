Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624874;
	b=ixt5rW9vRH9JxEm3dvYA/BIY+S2DuO8BHDrofDYTlpnMt1xmAY4RIjw0Gql1Agdfy2vR
	 PjdyO5nHwZfeWSFHtJaIJhNdsF8FXx3nWGQHrUdAG2VUAV+VH1BdT93uysqGB8af733nl
	 b8yZ0qRWeXnEqnqQxJPZtpgKniZxFYbNFJDlQpXQVBXPJ7fFwWEIhkiCOhYMV1wR3iXSI
	 LikBR6ziq5zOVOnussWRqGsPuNLC3AHvH4FZI5v+VDjuJUaPvy0qKXgzThw4hNTa67VLf
	 pzZqzaXqs9dCuTEwisC6vhg4z1jMeZrf8yz518HG0gxEah3KwlaLJGLJtsi4yrkIRWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Fo/+Ljnciwqw8sjAEYwJ1FczAkXTOZ98S1aIwDrptoI=;
	b=Ys0lLIaJP4WjLrTmmt29jH5ufAiA5GtimrmhVOkYH2Gct3qFnEy3vSbR8/AIWPNc8oSa
	 kh+GQuWxcMV5kJyxiil2Nhxa27s+wEtnaprWNL4/DWuPTlvTjlnhDvAobj2VfNDL6rIWo
	 BXuvgxmunlydmI046v7owIAcBH7fieW7BU0OzxwruOW//v4l1WHjYkc728+7dS0mE99CL
	 eyOr7eS1VhQIXu3GFJxgbz1F/txkMOhOX1/LXnfJo0oai3doagarPY6gBy9KzHOELM2H1
	 stqNRMmAMXT4HHoxI0o955WFHWSRA2zfV9lTN4xZp48cDLIzny756GK46GoG5FKeLVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9UsOCbn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48CA606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9UsOCbn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E2D1F000D2;
	Wed, 25 Nov 2026 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624874;
	bh=Fo/+Ljnciwqw8sjAEYwJ1FczAkXTOZ98S1aIwDrptoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m9UsOCbnuM3PDi497Zqa953AoAYE3j514LmnXp5O4vG28b+j7H9BK5/bkn+MagX9v
	 T3kuVgh3QO5qNwxP3AmL8CgcImg2hQ9wfKPVc4MOS2Hh9DMjZh+dGrawcnA5cPJcPY
	 6a3udJw/aqPysgrwyBtcUHzOJwNzluPuSSuss3yso/5nI9EqMu+o0Vfky+aGLijx12
	 0VDQeWlMNv40Pnl/tcXQ/QCiE1f3avkdWYHZ1Fz8VTdO+NPtDc+u8VbB2BS/vy4elt
	 JFn3Ip8PQ3h8Hq8oW6k8Imk6ZwvxGHUJrlqJAmu6H/4GhtX/Eh4cJ98IxbSpPOxtQq
	 ejb2DNLE0V34A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tim Menninger <tmenninger@everpuredata.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 3/3] pNFS: avoid repeatedly cancelling I/O for the same lseg
Date: Wed, 25 Nov 2026 11:41:09 -0500
Message-ID: <20261125164026.827651-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125164026.827651-1-sashal@kernel.org>
References: <2026112557-foothold-septic-e646@gregkh>
 <20261125164026.827651-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 12 ++++++++++++
 fs/nfs/flexfilelayout/flexfilelayout.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 9e1a78d7d6336..1c88bdc600ae7 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -11,6 +11,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/nfs_page.h>
 #include <linux/module.h>
+#include <linux/bitmap.h>
 #include <linux/file.h>
 #include <linux/sched/mm.h>
 
@@ -340,6 +341,7 @@ static void _ff_layout_free_lseg(struct nfs4_ff_layout_segment *fls)
 {
 	if (fls) {
 		ff_layout_free_mirror_array(fls);
+		bitmap_free(fls->cancelled_stripes);
 		kfree(fls);
 	}
 }
@@ -653,6 +655,12 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
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
@@ -2587,6 +2595,10 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg,
 			if (devid && memcmp(&mirror->dss[dss_id].devid, devid,
 					    sizeof(*devid)) != 0)
 				continue;
+			/* Do not cancel a stripe again while this lseg drains. */
+			if (test_and_set_bit(idx * mirror->dss_count + dss_id,
+					     flseg->cancelled_stripes))
+				continue;
 			rcu_read_lock();
 			mirror_ds = rcu_dereference(mirror->dss[dss_id].mirror_ds);
 			if (IS_ERR_OR_NULL(mirror_ds) ||
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index 19b833f547416..7b0d625b06a70 100644
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

