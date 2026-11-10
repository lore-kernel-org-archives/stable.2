Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273782;
	b=Evb2i8N0p4ItA16HVBM3Dxucb8X/LJh4Mm8Zeg7UtJtyKQYc92gJf/MlSht1gf5J70bl
	 LUBMyXRBILgTl9SRBgApHLvBaZ/V/8bU2P9+jyyiwoR6IZoQhx0mJY2clhVqSYMJkk1Ud
	 DBka9p7mM+y+LLkby7XcRLUJiAhhFD5Bn/44Z6hFR4ilkUI4iW0JHwtXnRbvkhw/YtX32
	 Mcku7DFX8h6/j5tzs3UXFmSwWnUdkdyDt6kZPjTSbfge29CqEaeAtIRj4RE/+50wAosRc
	 8a52CPY5LDDOy7MCFwdyGSqWomrDOz6A6VDiGfguKgOcoopqa5W2NUkdeneC0XnZusQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273782;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KB/8KMwzkVhASBAcdj0uvm6/gPoxKzC6cX7uFpLP1vM=;
	b=sabemk50ElTrgQigplc/Sf6Np1e2OXLyZWCnf/57sM2t5VHZU4pN9eUfmI8Ieg9gFPEG
	 P5upIWjjVB/xIvV0l/BRCjdx3Kb4GGMmApVHusNvwUwDY8uNl7N/tPEKXnei6OM8ohSJt
	 Tw8CVEryVIOMkcT+FUc9RqADOfcL1ULJGcGeIm+QUEd02C/5iwV2MxnXOnF+Hxn2b6xOC
	 nC9oZC0a0rbqBD1IDen4odxVMEgr96qlWCSDcirvoOwHnfvb3ud6X9H9OhDR5gXDcpUzr
	 UBpRTjD7FDkI7baN8AuOUGCwFMyJyWhDR4Bov6L/DR+q4Dk9W4AzOJwl1N2TMVEUHQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDnC2oXq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C760A6F6A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDnC2oXq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A856C1F00921;
	Tue, 10 Nov 2026 01:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273782;
	bh=KB/8KMwzkVhASBAcdj0uvm6/gPoxKzC6cX7uFpLP1vM=;
	h=From:To:Cc:Subject:Date;
	b=WDnC2oXqg7Bf4uKUkhHWyiiBqS+zylTIqYrKJEcL+5V/HuC/VSHdhP/OWFjx6GWym
	 9RfwOpRXFxmHd3axiLz7NlAJGLKaGz+hSvbvSXHeC0rEudy1D4UTAxeZhNvCj44Ait
	 +gBseg6wA5kgx2uPh6wGEY6Dc5susrab8/4+3cO/C8GRwZkxgiKFeQgJjdg5PQzpc1
	 6aKeo4/UbRAZYgxRmhbMkDWPIoFM/IzSMbfRvUQjp6tGFp1hOcU6z495D2zywn6oOx
	 OzKvE5m7eXpaUJt0as+rxT81iGiGNYUEtKqaU7HpCfSHreHyOM228xhN3L61o4rOfM
	 HpqLAOJeH+TBw==
From: Sasha Levin <sashal@kernel.org>
To: daejun7.park@samsung.com,
	djwong@kernel.org,
	hch@lst.de,
	p.raghav@samsung.com,
	cem@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xfs: cap the block count of xfs_iomap_write_direct() at one extent" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:23:00 -0500
Message-ID: <20261109202300-failed-5.15-66d1ce09ebd7@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 66d1ce09ebd72709f8d739630c39f440445173fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202300-failed-5.15-66d1ce09ebd7@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 66d1ce09ebd72709f8d739630c39f440445173fd Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Thu, 29 Oct 2026 11:23:02 +0900
Subject: [PATCH] xfs: cap the block count of xfs_iomap_write_direct() at one
 extent

xfs_iomap_write_direct() reserves blocks for the whole count in an
unsigned int. For a pNFS layout the client chooses that count, and an
RW LAYOUTGET for 16 TiB wraps the reservation and shuts XFS down.

xfs_bmapi_write() maps at most XFS_MAX_BMBT_EXTLEN blocks here, so cap
the count at that. nfsd asks again for the rest. The other callers get
the same mapping as before.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Suggested-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Pankaj Raghav <p.raghav@samsung.com>
Fixes: 527851124d10 ("xfs: implement pNFS export operations")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_iomap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 99d48081c5ac3..c3465204b8d52 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -285,6 +285,14 @@ xfs_iomap_write_direct(
 
 	ASSERT(count_fsb > 0);
 
+	/*
+	 * xfs_bmapi_write() maps at most XFS_MAX_BMBT_EXTLEN blocks in one
+	 * mapping, so don't reserve blocks for more. A pNFS layout range
+	 * comes from a client, and its block count may not even fit the
+	 * 32-bit reservation. The caller maps the rest with a later call.
+	 */
+	count_fsb = min_t(xfs_filblks_t, count_fsb, XFS_MAX_BMBT_EXTLEN);
+
 	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
 					   xfs_get_extsz_hint(ip));
 	if (unlikely(XFS_IS_REALTIME_INODE(ip))) {
-- 
2.53.0




