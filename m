Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051021;
	b=rZOLwG5ab/GodJWgLUHAo0beA2wESHV7STc9tXDUtXqKRrEYTrMYVW+XRXJbYT8nI2D4
	 7yDFSOH8rLQAJXEJAjYgCX/ip8JrZcGBm6tDJhcaLQ0rwchu/1NoF17eyY5smfauYT3IS
	 b3gu3vAkLMWSs6zACZE39d+ma4pOvYXz2DzQCg+T5XnkXj9opLtaK5kvEbNUvo6DGYXL+
	 g5Nz12GqH81hcOqC9rLdDTe5wzc2r1UlV9xVqYfS0+IinG+xnbIjQ613eSzg0SAnNt3qG
	 kaWJTj/msGtyNQ4tQuwwpgkwwrPDGRH2SajDqBGx1M1vnqL/ZJHLypJ2/I56tVe0GsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051021;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4pvWud9GuUunORnnnaVRmHpgN2YOMsCGc6TfRwq2ysw=;
	b=Fo5rfGAyVOSa0X9G99vmTWQnJ5RvcTfyx0YxosSQtz2J+1kjf9tm28JhJ8d0FZ96P/kp
	 6mhoneG/8B+6yYhPj/4VR7TUW2y0GNGcKxMf+Fw4k09PbnRoHrzTF0Ff/nHZG9kNvpKXm
	 PHVObBxRtMIOXvrJLDr3FZvP7dAJ2swFEtlfjOuXGVypLsTQZ5D085w1H7uMR2dpOos0p
	 keOrwGuk9sbApTaBBZ1NTzRzdIrY2ojFngvoM81FTcXtKFeAY3gaXzjuaVgtDKdUYsTHA
	 Q6/tWGCEVMhxH5rx8RKWz0Hzn6la+yxTN6rbSDZZ+Juh6P14M7XQms9RuEnIKB2TB/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4KJ+OKU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B16606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4KJ+OKU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4B71F0089F;
	Sat,  7 Nov 2026 11:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051020;
	bh=4pvWud9GuUunORnnnaVRmHpgN2YOMsCGc6TfRwq2ysw=;
	h=From:To:Cc:Subject:Date;
	b=W4KJ+OKUnbadqbRoX3s27Qg95JVAqvfJI39vJaXfCUVhHleS7oCOVmOTIvSRmxiW/
	 KEj9mf7HUbQKrapykq7S3xVHC9DqQUGmqAGApICukryz9Vyt2CPkyYkRbWhaXdzzhU
	 MRHdy5tvpPeNa39YaBwEimGGU4xzQge0f5GCnpQnn+2QW7k5LLdKuC/Fpx1zp4ZC3/
	 vxymr2tn00oauXrbjt90sqHi3oq/MllI6S513Gdx1PJBzamfuMkO308s2cTXeItbqO
	 0Nc/FPvEpJsrMD0Nlva5scFwWxbSnTr5KejXm8lyiihwI8ZMjzwJX4j7fXDV38YWCq
	 Gcb4o06UsE8qA==
From: Sasha Levin <sashal@kernel.org>
To: astellman@stellman-greene.com,
	hexlabsecurity@proton.me,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:30:19 -0500
Message-ID: <20261107063019-failed-5.10-d1512773a0d5@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d1512773a0d539669440bd9f6d050b8e12923b5f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107063019-failed-5.10-d1512773a0d5@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




