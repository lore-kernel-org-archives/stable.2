Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061783;
	b=YPEcvJUTSLuCWtU58qzq5AYURFxCH40zLIQB4G5ZTh0gzBlNZG8fpXHxbaqNONtKke2b
	 G/50Tg7CMWh+NSb+l18mdnkO3uXiD54tEmtSy/bN7R+sdNqXaXzrzGqtbO8KVC8+F8FP8
	 RE5CMIJUOHeOLupGFZpJS8QeVM6NAAvIvGNXZ0il93BKOwBuFKsJiXyefHX7Jmlow6mke
	 H1npBChOUbmkXMvGOlPV8pgXgYn1zSCs0x45UxWsYxFyN3Cf3pqiwFil7wXiKHtYzk3n6
	 i+vhrJzn1ZlZaxko+2HsifRDOvIi7ydiSIAVAVg6Tk3nMsyiU8qCRZgkJEEBhz/HPmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=envJoJ9R8JXDgidxnGQ9ix8YkGksaPR+QBhomUAEfcE=;
	b=HgPEsdKP07Gi6eB4CZWK3xTD30U/gJcOAXK+qp2EMBXZyTjyHVFbKFwVz7kKoSuqP2eP
	 KNJ0bVHhqnrfFt/mRrxe5HnIOUkRWnWz2bJ0+SdxxcId4c9tEAFMBBnG2Tq5T1z0z+5EK
	 Azv2aQ/skm0rTVfwB7nM9w+slEpjgFdp2AzEM6YRw8x8RAvMvNmwWfgtIsA0BvQKlxHAc
	 gWYW+XqM/CA2FEugmq7k7GE8re7qrahsmiLoXLTtko39tgLAlS/G3eLUSvSIRH2Pg1e7Q
	 CumyP48Iij84Un4WxkbFsE7t0qFsULZ6chX5S+y77q7mUpBK8EdFZlGY6zsneCwTxaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stellman-greene.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W4EQ3asV;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F39606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4F39606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W4EQ3asV
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5364d86f7f0so19422051cf.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794061782; x=1794666582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=envJoJ9R8JXDgidxnGQ9ix8YkGksaPR+QBhomUAEfcE=;
        b=W4EQ3asVn5iblLn9SxRLaezjC+0Yd/9sRB3NIyLMbIZ+sttuehu946U4raQd4UvxtD
         He0qUUaNG/5OhO4jYS4kCn9h0B0Yeb9T1y0ee4cYehzjCryqXS4Y8PQGO0/pFzSLf5dN
         sldj+vTO7LEmJR/Kp+ESOp8tbjM954dVMJmR6VuNG3Y5oWHgp+rqSD2y5HY9mQ7BbYt0
         lapPaP2n0P5rUFaKcH55RIYPt8K6i3dk6JgrYadhbxhZw0v0hF1SB+yw72tzgzqHnlTM
         gJDLGENT2vVztcBJDxE8/6u9WO3NrKSuM1RZQwqTmSe4798svo7rRUFS+891JeeVN/Nl
         njiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794061782; x=1794666582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=envJoJ9R8JXDgidxnGQ9ix8YkGksaPR+QBhomUAEfcE=;
        b=SXHFQaVUgV2ztTkWaLSWHjt/EXFL0aCiCsysoe08KczRBtVXEPjPtEFB7ckE6b1NuY
         0gKFIIIHjX7s9jCQewzE3HM0snBvfH2+3fcnskd1QGD8jAj9X39Mf7UsRgEQf0NYIotb
         M7E8U8zbzv8SoRp+j/V5pKdCNSdsNwdRk71vEP5KNmQYqlScnps7puSwfcRybkn4WIhj
         ePDdxJ1pLbD5pQcfH9gGri4WUTr7IRmGqOwenIl45zV0WQN0e7RO2Rtk0PZripnnRjUN
         d0PEtdDJjJb4ggQhHREwMbf5BWbuzwpCR5Zdh5XQsSJM4xB5siwP542LeEL75cm3S4Me
         80kw==
X-Gm-Message-State: APuU4Z9a2upJNACGfhquwktdIWtzEhjufG2GDU37mxgbNljSpBD/ywyI
	9lBj1iy53fnPdK3T63EpcRAgCpxk+Myz2KM4UhjNBlBF9+9g6nGaEijzIuGB4AocsHY=
X-Gm-Gg: AYBFou3I0X1OVMlYHNJF9Ug40h8BYuErROeSous0P0xwHf/81+PyQyxdnMM/zAVt+Iv
	2zXNXLG8eEPS57zOcnWwQlu6aewq460d0FixYu3/fFjqfg2iFj+1SdcqWRpRmMgG/GSXgOvl8mO
	oYXys4RWErvgeiO2OxmRAZXTRaYFMzCze1HSSgTBT3ryfiF64vuLI9gVLRKfVIZ0NF08M+yNt8S
	/IibWO10BiTBmA4Xy3khxBRioMcEI5lDakYQu54ppzGL70qxJTajvOlwye3BI4A3qOeu9oLf/Zv
	pWvJE+/cIv55EkyW8tuc2TtfZa2SaG2ktpxmLVhaos7NLNlw4pwZg7GWCSIuXzbAF3JQxE3o3SA
	qxz8p3uVdKl6RVuXgHNQM7G21NwTlAaRoel2bx/6Q+ihJTqEXqzYlDy0SyLniyePgLK3IM+6+hJ
	4cnKyvO+32eX2zq7iVHH0g9pVYMG/EwDCzarjrI6ZT3tTgabWU926oDCwzzoSAEB9kqLz/XLcje
	oefhKu2hreb0lWvMJRm+V7Wfy7tadmGQ9QGNGWNI7CEl1jfP79GUhmmlU9qnvSZU3S2f6WGkpbV
	+n3UU13WjJ1aS848Jdqhllp7KXouSJyhYK5JwfDFU1qfchJbsYAlJ2hcinehVslQ7gi6d38DDls
	XbXCE2Rqi7WgjaUfRdEt5UuuXlOnx0in34xcbgqXQ+itOCULggDEUPJWPhSmt1U82tyUUX4nnWx
	CToSta0n1MIraJ8fqd+OJdTLpOQLQ=
X-Received: by 2002:a05:622a:248b:b0:54a:b619:951e with SMTP id d75a77b69052e-54e0fdf3562mr86417701cf.6.1794061781604;
        Sat, 07 Nov 2026 06:29:41 -0800 (PST)
Received: from Mac.mynetworksettings.com ([2600:4041:5c28:200:397b:6557:89ab:c2a8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e230dabcdsm47866531cf.1.2026.11.07.06.29.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 06:29:41 -0800 (PST)
Sender: Andrew Stellman <stellman@gmail.com>
From: Andrew Stellman <astellman@stellman-greene.com>
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH 6.1.y] nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()
Date: Sat,  7 Nov 2026 09:29:39 -0500
Message-ID: <20261107142939.61952-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055626-failed-6.1-d1512773a0d5@kernel.org>
References: <20261107055626-failed-6.1-d1512773a0d5@kernel.org>
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

[ Upstream commit d1512773a0d539669440bd9f6d050b8e12923b5f ]

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
index 380c0aea8..7104540e3 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -865,7 +865,8 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
-	if (off + len > rsp->queue->dev->inline_data_size) {
+	if (off > (u64)rsp->queue->dev->inline_data_size ||
+	    len > (u64)rsp->queue->dev->inline_data_size - off) {
 		pr_err("invalid inline data offset!\n");
 		return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
 	}
-- 
2.43.0

