Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048025;
	b=08meVQGc4DzWnSzGTkbZemFprVjgTB8i8rnzkBHpsVN2HtfiCO16sa1e6k1jZpuGq8nz
	 7Q5GJ1I7Iu9QbQo+anh9hq8eO+ndyGXIXLS4nvC6sprxIz0io7ENzUulUrUZ+eC9a40d5
	 6vZY3MoFS3bCGyANDvUSdlkKL/PXo+VHCTRgCrEysQeUdSV/ddwygu7Jba9ILa0vH6W0l
	 yX7mHOyUTKAg45hQqbieI6G1A8Yni9icxdwLFfcdSRM9+HgHDRyk/J5pfQ+AkBgwZvv3q
	 CtbeEYHffQ/j1d4YbJ79Z/TTP1FReQdxgvwH7MrU6zwKDHUC8U4XhVaZ2s3hDYfmC2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048025;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JQfdx1gF3wzNdnHvS+CnYyWaZhihPdO+/hk/KEFmiKA=;
	b=vtw8hSdQXcNeqxauC3/cxw2NxbaqLgRzLulJleVtaYWu2KdPGwKSsiw/6EXcXwVseU5r
	 ApD7aEFClidihUwUAo8BAJNNyW1+4FwzrvFZ6RPqJTQVOeNbeEGDTBhp15x2TV+BUHMXX
	 Zm4imZ3f82tQ6BHCJQmOwjGkEV7WOiNjd2w3zAl84KfBRqJnQsPPhWOBs+RpGNfJIERa6
	 3u7Ed38RrKvVshlUyNwY4lu++S7gTpXkynWB73P9RGVupUuM2SdYpmGGbvetKgri8Eot2
	 6BnVbBugH81Ngfq8DenrASj2Kz22kbZFwadCA7lHuhKIxRU1Hg3OEPdJe5fJBd9so6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFBhn9IC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E5606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFBhn9IC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021641F0089F;
	Sat,  7 Nov 2026 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048025;
	bh=JQfdx1gF3wzNdnHvS+CnYyWaZhihPdO+/hk/KEFmiKA=;
	h=From:To:Cc:Subject:Date;
	b=EFBhn9ICjgKdYpYSqVChBQ1BeBK8u1R9OA6fKFd2a3EiVAPFX8xAUEm40VO+0fYwp
	 8is3d0wT9jY+v2cI+W773OecMhOFd/siggn5nwryHoBl9bA71dTRABf3xrgBYFTF+T
	 oNr5IaSNCWMrFcXLj4rw1+zmk1YeXBs5jx1Xbm4/dvwtMyAiVAfv7XILaqe5ondysZ
	 rVY8zIILuYx5tuIepEVVi9h0R/V7ym5zNYpSUjth69BGToQy9trcXCTn27/AheD3n5
	 bfeKCCMtsMsZTQ6mAGIFTFnSkPF08I7ad2VsUdM2zkrizEPcQM6+NeYVkBEr4rMstd
	 X8ahB6mkroFqQ==
From: Sasha Levin <sashal@kernel.org>
To: astellman@stellman-greene.com,
	hexlabsecurity@proton.me,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:40:23 -0500
Message-ID: <20261107054023-failed-6.6-d1512773a0d5@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d1512773a0d539669440bd9f6d050b8e12923b5f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054023-failed-6.6-d1512773a0d5@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d1512773a0d539669440bd9f6d050b8e12923b5f Mon Sep 17 00:00:00 2001
From: Andrew Stellman <astellman@stellman-greene.com>
Date: Wed, 21 Oct 2026 01:07:48 -0400
Subject: [PATCH] nvmet-rdma: fix out-of-bounds write in
 nvmet_rdma_map_sgl_inline()

nvmet_rdma_map_sgl_inline() bounds the host-supplied in-capsule SGL
offset with "off + len > inline_data_size", evaluated in 64-bit
arithmetic. off is taken straight from the host SGL descriptor
(le64_to_cpu(sgl->addr)) and len is promoted to 64-bit, so the sum
wraps: an off within len of 2^64 makes it small and the check passes.
off is then used as page_idx = off / PAGE_SIZE to index the fixed-size
rsp->cmd->inline_sg[] array (NVMET_RDMA_MAX_INLINE_SGE entries), so a
crafted offset yields an out-of-bounds scatterlist index that is written
through in nvmet_rdma_use_inline_sg().

The mapping runs while handling a received capsule, before the command
executes, so a remote RDMA peer can reach it (the Connect capsule is a
write and takes this path on a queue that has no controller yet). The
host controls only the low bits of the resulting displacement, so the
expected impact is an out-of-bounds write that faults the target
(remote denial of service).

This wrap was reported, with a KASAN reproduction, on linux-nvme in May,
and the check below was suggested in that thread. The fix that was
applied, 48c0162f647b, reworked how the offset is mapped but kept the
original check, and its page index turns a wrapped offset into an
out-of-bounds index into inline_sg[].

Reject the offset before it can wrap.

Found independently by static analysis with AI assistance, not
reproduced at runtime.

Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data")
Fixes: 48c0162f647b ("nvmet-rdma: handle inline data with a nonzero offset")
Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Closes: https://lore.kernel.org/all/LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me/
Suggested-by: Keith Busch <kbusch@kernel.org>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 075ab58d8c884..ebf4a7bde524b 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -864,7 +864,8 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
-	if (off + len > rsp->queue->dev->inline_data_size) {
+	if (off > (u64)rsp->queue->dev->inline_data_size ||
+	    len > (u64)rsp->queue->dev->inline_data_size - off) {
 		pr_err("invalid inline data offset!\n");
 		return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
 	}
-- 
2.53.0




