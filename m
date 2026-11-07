Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047256;
	b=D4sw5N8E1puzNi4dy9uuLfs0+S+w0EobnrvAu9asnVys2nOawHnGW4alBPWtXpLSXUpH
	 fE/f1TqhSnVphobJ6AcO886o6vFA8O2DQnP8Xx1K4t39xypd7qASn+kEEYAQF+CEgv6ud
	 UGF6SvTXNOfEMMOMSn/bFwhahY+A9Z24TSZKvZaZv6v+IF4+UsM6FdeT4o7vGIZFo5mQ7
	 6WY4HaiADh/7PiZDmpAKYW5axRR4HaNljzl68GY/VWN8fgYDFYPX/pclce+6hfzImQzNB
	 jYgJymtwwGq6NN2T4luoA9WPsYRtX7M5Umeh7Ip+me76CoPkRWtOAHZD4YZuiJCbwhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047256;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RwAKhYVF6JAXeNZZ0CLNhJ4LgSO4KMeQGb6YuS9sKlo=;
	b=2KoEtb7VVSetnIfPs46oTndbU9F2rGf7tslaiBfLfpJ8UknNuHldhZDEev9+ddQcnpAg
	 vH0hwMXNPmbIkBxd/LYAn6nNLNyWyW9wTRTp0gh7DZKrKMA25I9dv4VqL6WLBvh0LcKzU
	 RmGp0pLzjQJgnTLS+X9609zscPiyqx9lBpCdzqFLue0UXzo631ogCSnsGJIA5u0YEQNBD
	 SeMlvGpm8QduMzPgref0XkMyzASo8iKEUDTXsQY/5nnkVbjKwE941U1ggjsSCq0UOATBH
	 ZamCpYRXZGTDKKcll91EI8VEPh+IKNZfWsTibijNE9u8ocIEpLnX+DF5kM7nSaY4OrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyK1hHoJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33897606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyK1hHoJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474311F0089F;
	Sat,  7 Nov 2026 10:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047255;
	bh=RwAKhYVF6JAXeNZZ0CLNhJ4LgSO4KMeQGb6YuS9sKlo=;
	h=From:To:Cc:Subject:Date;
	b=kyK1hHoJA4nZx3HQUbRKkVm4BA1oe3b94/cZL1D21dSemoY+XSPIB0LWAvgBSjp+6
	 7oVHqqTKOZ3f344vbJXJ54bOB5JqcUvoyGfyrDkrWKTX9gvORM1EgTsS6BLj1XV5ih
	 FEPi+FM47jQogc84qwjF6SJBKfJeJ2BBA0EcEB7CwlQyIjcvXhZzaazhXqninjd75B
	 7T/SL8ydDg2Fa/40kn6/63GUfSWIA1pUwOsOkCvEgA3Elj5I1voakaQxZ6nxdKk6Jh
	 8A7JX0lg6EKIx4rmj3G+hxXLyzd+CCmPuXse6d7Mt7rRD2ImSjQEnmxcwi8TrPeF6p
	 obrcUYGKCJj2Q==
From: Sasha Levin <sashal@kernel.org>
To: astellman@stellman-greene.com,
	hexlabsecurity@proton.me,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:34 -0500
Message-ID: <20261107052734-failed-6.12-d1512773a0d5@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d1512773a0d539669440bd9f6d050b8e12923b5f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052734-failed-6.12-d1512773a0d5@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




