Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061778;
	b=ZMhSyVqi06EEu4KydGUUdIhP/8Wp4XgOyqEgJmTfsE77jjvSXulObQ18+yDviL5sz3lU
	 yXttv8VmWlKEew/J0WaYK1VDWjcMB/rvSR3CfodTx7qvNTS6ZBLvkqja3CBtKFaFeNbDL
	 t+AyfhLHcra92nd0CnBOBISQUIkMe81uZoiM+++wPUwUoTa9/VXkmiF9C1xKdBM3sAqh7
	 gz9L0F/wfvVPlVSDiC2pMe94JuooReSa6wXDY0hvjMuIwkSZlih5y6IdtoprzhVcr9L8K
	 D6qMMO3NATRPDEYOtkCkT2pLG94rBqoCdkXuyT6cVPh9XEcuAHw3JVxTBUB/zfY5PNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/ZenuoC9OmeaAiuNgdh5rfHODfjs7/GCGB3kY8t+JKw=;
	b=0r44iC99U8OhcjxovcuugCPoWjVnwYR9sARgdzEgM9qRvOZzlldl7xL9yAHQ/LnN7uRF
	 Rsecp4C7mwThlNHcpGMsZoI0gareFTMnykiihbC0P2HyvYENIZqlVn67ykBH1SSESbmGk
	 bD387kVAb6yyMA6z9INPK57KSH6esS6X+2/rFRXxzQ6Zbg2YhZY9qvJVzzzz+IcTJcaEH
	 3/EJaO4azFeSIK0hiBk6SzMI5IhRExKHexPpmW/JipX1FJAPLSWq9iRa134sAV6UDbTy8
	 ua6SDGTnR0GtMP8khhYkBvZfEkDoPQzNHpFqFzxROPylQbPpGxocYeRyJlRB8dBY0mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stellman-greene.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MvEu5FBd;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C2C3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MvEu5FBd
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-535179e995bso16705721cf.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794061776; x=1794666576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ZenuoC9OmeaAiuNgdh5rfHODfjs7/GCGB3kY8t+JKw=;
        b=MvEu5FBdtFqSSr0Jk9gvPl4hHxPpK119lhes6fkLKOD5WsZjRJu+L0eqn17SF0sPY1
         qi89zInGQfo6cXR6owvWANPYOHGUK/uHxNFaZ3Y/ASL3O+FriBCEthNbGn3c2spj5yiR
         H8Vmq3N26vPFv0MUlHMky2rCtwvz+Hbd1oYtgerrWOWf5EUQlqs6tf4QB6ZcfhH1PDjJ
         jDBzFOtTfU3oYJMeDSFdjsf0X15UIx9FdTFQeU7Kta72vZvY3WHwQYOHI9+2ZwwS9cjA
         IDs179EUOQL8DSzreupaDGb277N0L2cT7hv+dGCDgR9BwW2uMIodEeE2m6EZ4OFVLDyP
         SkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794061776; x=1794666576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZenuoC9OmeaAiuNgdh5rfHODfjs7/GCGB3kY8t+JKw=;
        b=zqGHNBvi8bfc3n51kpnZQosqcI9sSYE3Jm/6V4cBkQUpxFuh5VKDKNaPFimy5HAQaQ
         iZYCMAiKDICW6JAngBKe4nyiUj9a2VRhdDMjQYVwY3Q3OOCF7JW6Vfh+1zKjWhnfAwtc
         mCfiAnOD64Ll9kyEPLxPd+xFQ7TAtiTjzfySh2Gh8jhqWEzla3Br9xmqSuo6f9MLB9xe
         vjm8sRzh9NnwnORDTKcl27pv1sMoyPKP/MsiU247IbOzVfh1VhM4mVsDq6XAjPuvueCm
         aHVFLySPe4wAwFr795oKBu5km/EsVkkRWYtudwPUdwMfXUmv/n6rNNMm7WpDjcHOoUUb
         Sqwg==
X-Gm-Message-State: APuU4Z+X5+D4vzxu7mgMShn4MSz0sfAu1l4IP+qMEJzQT3R6O2DPvEt7
	Pm5HLoz/W/wtlVsZamZUrK3HpGTnOGrZO+uAdKIUG00bm3Ajm8Jf2kQlECXOn1Iqd98=
X-Gm-Gg: AYBFou3pMYLIJVLvu+5c8G2yPm2IO2ZfVWpPDct78ZJP08n6jVxeY0JRk9xTQizXeem
	OEYCSCmLOqKkAYmjodk0lMmmGp8FHYp6iWlofCaq+ZdTyn2U5XgR35rs5iVjWzLhRx9aKo5kjmA
	+BnxWcrM0FzPTRUKZ1LCD71PbPQZ3FGY9bAW8BmghfTDrJJTJnKC+VJms3XYgBJbn/VkKpzJmUT
	fc9pnpfa4s3U+OXeyEhE8Hm8al6z7H5qofkA/8yHPv078ttx82t28QrsCotnNIcgacs4gFdIqzp
	bdt0snf42gCOniPlH0XA8Cm4ym14kYC/7GxWM/0NUGGesCXtqNU60WPgVW50F72SwflH2qcWtcq
	UEV4UcNiWACnUDNfTNLt5vYCFFgIDoiuQmduvIgGh/qzr1d6NXSG4h+reERdThlWK/O/ZpaxGJY
	M48pM/KQTtFQdLlEmLUhIspm971tVN50FN/r4UX0bty8xOfeuj8OMjg29AmKoZEbY62GO35bjEk
	1Jth+gyad2Z0MAUCMwT92pm2WmfeCs0kbeSDsBpU33EUdB31Tzfe1E8vU+sRJmzqiEXn9s4vrLM
	rn4zASKAr31lZP+/Lx4V3aI3gbsWYooSVQmQoTquB+XEbZ1QpNhgnGO55xktweAxqWQhaRXjI/M
	lG+1FbQqluP1h0SNmiqbGARq576MCLQeI9kINCkoccJdyBFfAcr61tdxqjcf+O/5wr1lTi5f7UZ
	QwlgRxMYEfSBVPOV5NEz9IOuAViCI=
X-Received: by 2002:a05:622a:5447:b0:545:de78:a6f0 with SMTP id d75a77b69052e-54e1426ad0emr90108041cf.41.1794061776266;
        Sat, 07 Nov 2026 06:29:36 -0800 (PST)
Received: from Mac.mynetworksettings.com ([2600:4041:5c28:200:397b:6557:89ab:c2a8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ebe8303c3sm15067946d6.16.2026.11.07.06.29.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 06:29:35 -0800 (PST)
Sender: Andrew Stellman <stellman@gmail.com>
From: Andrew Stellman <astellman@stellman-greene.com>
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH 5.10.y] nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()
Date: Sat,  7 Nov 2026 09:29:28 -0500
Message-ID: <20261107142928.61744-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107063019-failed-5.10-d1512773a0d5@kernel.org>
References: <20261107063019-failed-5.10-d1512773a0d5@kernel.org>
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
index 5ce6aa4103..8be39d7789 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -862,7 +862,8 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 	}
 
-	if (off + len > rsp->queue->dev->inline_data_size) {
+	if (off > (u64)rsp->queue->dev->inline_data_size ||
+	    len > (u64)rsp->queue->dev->inline_data_size - off) {
 		pr_err("invalid inline data offset!\n");
 		return NVME_SC_SGL_INVALID_OFFSET | NVME_SC_DNR;
 	}
-- 
2.43.0

