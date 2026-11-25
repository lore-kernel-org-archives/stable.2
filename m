Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625905;
	b=RUzT+G2/F4urmeKXGZZv+IwKGZUqD4VCiA4MfnoF7kdpCtFilceSBvgZcTKYwpRhZgLJ
	 rFryzbRkBalRUAvrsdWf/ff1/xvuze9/K6XGn9NzmFMXQKdOJWrzjlxMV8YNkt9GgETKZ
	 o5ADc4lQcqjv0z1NCSIZzDa2JycAPfm5j54AniiCKyFvdhO9gil+7lTykUxjZATPVcKJZ
	 DUGTW3vGuZzvalu8QigYfZMjG+t9Ft/kBoaDUZNOOqXo2G8ne8BoL58Q1ENQnJ2bwCjsn
	 Jqzi3262GOVtzE+9mhzm19C/OqAtcESjFdVkJCiEH9U8+UuIOuFsxrMzvtYmS5qVMZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625905;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bzXZ9FGw86w+nDTWJA4P7gF3eNDyS96sJgwUKvRQO3k=;
	b=gw8HK0N0vUUQ25q/3fX9ufAZk12+TMhiRFfqoHG2V21kmIZtdkDpCAS4ljFswiEY5aU3
	 IojSoQHvjGICMWjpPQEwdkVddidkbMe4tuojOcwXWsiNDn0gnrvirJiaMo8tEx/dlQMnD
	 fsJJwiC2dJY5rlRkEnBQJ7auTZQtz11QVXr9klj6k7GiRT+VBQ0zTqvrgl8VRhNkUyqi4
	 oJG3lmveIQ08vUj1sqo3LS6Ddl+vnfW8rDkHxnwugdNyn+Dk4o4X4IYzBkvjSZuFWesnT
	 tMzN2/lKg4kW0F1kLbbOPJZafOh4azMevY4AkCMbpXikLvbqmg8B7fFzC5MdGoFp2sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9WwiInX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B6606A331
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9WwiInX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6391F000C6;
	Wed, 25 Nov 2026 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625905;
	bh=bzXZ9FGw86w+nDTWJA4P7gF3eNDyS96sJgwUKvRQO3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m9WwiInXX+RMzuNUgRkC4k3VICoZxPz7YLSSOo9oehzcD/YGwldMnEVX5FIgopCjS
	 Mo5/zeeRL+/SlbVjHaTHS1aektb3TUQcFUIx/7FVSAIwELO3fXmOz8LoAjiMJkKMIx
	 kWZuSgdDq5xQieR/VAerDY/JUhRuSyFrzJcCC7Dw1rFzRU/GUVRO8BW02yowq+LM0z
	 Y2oY63WPb5V9DCNOtTt3tGag1/fRZqXeTzxlniVTyoBAjuitAAU6o7g6a/xznkC+bq
	 CU846+Q/YxILYlNoS2jsT3P14LIAAxOu+K4iJRGFkb+i3VU7jqesNEmOc0A3ZM8O7q
	 NpDOKpMjNTQQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tim Menninger <tmenninger@everpuredata.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] pNFS: avoid repeatedly cancelling I/O for the same lseg
Date: Wed, 25 Nov 2026 11:58:23 -0500
Message-ID: <20261125165805.915532-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112559-dairy-rocklike-b00b@gregkh>
References: <2026112559-dairy-rocklike-b00b@gregkh>
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
[ sashal: adapted cancelled_stripes bitmap to one bit per mirror, since this tree has no per-stripe dss_count and ff_layout_cancel_io() takes no devid, and dropped __counted_by and a differing include context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 11 +++++++++++
 fs/nfs/flexfilelayout/flexfilelayout.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a9945db35ec81..d7436c98a9b32 100644
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

