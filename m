Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061787;
	b=oMBKlkA2xsttYoL5WF9pRwQvNywFKT5llj9dWdP4HtmoMjLP4UromUe1+fzjInkK9fE7
	 kNUZAoV6yC9vEXzaWNaof6d79xAE6wvAYvRY8+Xy2BIo2l/uGOjBOXUFRm2vJ0D9OEzj8
	 t7rkiZhx6lkUiQiY+12yx/iOVDidi85a5NufH0DWzU+AhG+/pKiKoCGzRbR3C8jGtYyAM
	 l66AmnL4B+3/YxA73F7h0s+3iZUYohO2BTorxOWGvyyG+ls0HQcMeN/UXeEStL7uHcHO8
	 27PfxMuo6otbtkcilQPjcPqKNeSv6ENNkXjYjheBbP/sLpIIEdTGkulkR2OSWQi5uVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9hA5Sh0Ef97KNn4ubQX3fxD/qa1TRj1FVF3pVAipkEY=;
	b=yKnOj7BN/6oIthzXvhre3H3gpI1veHsv6kRmvdVJsnR/X+43eHmLWpRga77v9ZYCP66C
	 8PJllWZuV1PxKLJVQtYJq2gDMOqP8ygxDjRmLYj9QNpfVPOhDdQMWNlKHKvkrg45EPpxG
	 SvKbZCTWi/1zhssS+xOs/nohnyAl0ixe8+W02Q97k0HfT8zkA6TTzAVNG4EEQu7Xg5YTs
	 naN0BgjHuGfCnOr03IUYzeEz5TmEk6YXuvWX/WSzccoCEBNbJeClbAkgrR3I43DYv4cTy
	 xz/6Qz7q/W18RI8cu4CfVu1hhgJlFz9gtEzzbzvbbCNwlLGPuWxCRW1O9Kb03T7MuQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stellman-greene.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XSBcVB55;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29197606A334
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29197606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XSBcVB55
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91ec08f71daso2319156d6.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794061786; x=1794666586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9hA5Sh0Ef97KNn4ubQX3fxD/qa1TRj1FVF3pVAipkEY=;
        b=XSBcVB55bNWAEbPdKwME/BB8rcZTIWBhs2MgVYfW775v0Qi7outUA1JzJCzE/YjeVH
         PL/fsHXNCMAr5OJjOp5bHYCeSh8R3J2IphZ3n+1soD/jboz2KRnTk9BBmEyYjnb5c7V2
         NT7VBQiypdzR0sBEv7/9aOwNH8U1Fq44hXj4eDWJV80FXJQyrfyDGoojYM/9PeE3h20r
         +01vcGMIFFn72h0KbqNlvH8weVraD5X6+YbyK5xVYAda/xbnAtLUHzyviJAnZzCBWj+O
         gv0ZqpSGpGJQwoYzLDuGmDqWe3IzR1EJeh8UxxJgpJsZrEQZ8ZeH3ADhniRO8ULvCyCR
         O3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794061786; x=1794666586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9hA5Sh0Ef97KNn4ubQX3fxD/qa1TRj1FVF3pVAipkEY=;
        b=OefpZ9yCgyKLK4aQyfoWwhyHqu6HCr6HcOCjJlRtDvlfFgikaW96sUNaipUaayFAAC
         i6YcYbZHt1vhUfRvtnEPc2KmwYx8VyCQgp+l0mJ5sygOVJFzGP0pAcFfgAK6bdfa9pUO
         Y4vmq3u0k5mRdqA4+EWOoCLljt6tmAv7CKw9is1VWKxHYhP8b2U5cKQkwMTJ1mtLgZp4
         fsFt13Oz6gSr7AisJmWEkY0vqb5KDJnze5rVW9J9CG0oLPA52SuiPdqG/lWYrd4dFwGy
         DIdWzoh0h3AG/ZLx64Ko/BdsreuRGEsqeyFblH6UT+mAPnSZ9pd6krZYukQyp4IsV5Kq
         ZWvQ==
X-Gm-Message-State: APuU4Z9oF7rCcYg+A5ZndXN4iBACimrAbVGExQ5oB4btKm2m1TVFpWdn
	8jezcWk0qyvBLG7enfC5cG+2fQ2UncLl+TPTrBsapYRPSR3l1psNdf1+g0VPKulhEjM=
X-Gm-Gg: AYBFou38fzgezpAZ63vkUs9K+YNVdMaOhC1t0eKCGn1MgVCYi7F6z07DagkJdaX+kk/
	d9Mn9w+HxT2GHV/kSboblE/eNnz7GRwYxAGsPlEdajcOKQN6VIUKdS4mKHDSbawGrDgMjKyNRwT
	KAIuvDvtc2Clna99LOtyYrU7coxhaPhrSPkklp3dIDizhyIS6SxqhXiiT7WJKX8EpAMOfOrMJD6
	qNDK7+lg651V1rwTHO0NDKU0JwXqL9DdOBbeKhDQIZYWUF1Yeo0s/zIbogF1tewPAy6+XcXLLlK
	0H+pEiX982mZg6yREOtMSAHtSBwrT3lUoPf/YoCHtx+9p6yWjcqfXqISSZEFlIazViSlQ1Az/0p
	hu3+rCt8rHaHhjz0C5tDgm03v8960ikKKytmyKCCl0ffVFR7D6DEeb8feHDNxAWqh9CbD5LQqjF
	6PKCuua7G9/lB2W4amREE5AWeUJiEAzKrgxf/BlMfNpgj2+M9ocUYTdL/bz7KJK66/d904zj+Ws
	YSZ708mZhF6Fy8WzD1LsJeFW/x0NoVUXA4C9YYa0K5EjXxv1kE6mYzs8v9C/POqUsWJDjyvWyxZ
	WNcFzbZepJJiPS3KlOPiZwssbWdMM51NhsIIwQmhRsWIM40PgV3/Lk1CK400dGv6NU7JrP78xP9
	JFFkksMYsMo76OlUvntk+ytpPaIXphQN5ikZWSD0EmXHf7+FDulOeu5u4jkDRT2yeW4OLKbGiT/
	bXZAVDihAKCeVUjIP3yqWujlTcG4Yk
X-Received: by 2002:a05:6214:2389:b0:91c:996a:7fc2 with SMTP id 6a1803df08f44-91ea9742dd6mr76443006d6.15.1794061785995;
        Sat, 07 Nov 2026 06:29:45 -0800 (PST)
Received: from Mac.mynetworksettings.com ([2600:4041:5c28:200:397b:6557:89ab:c2a8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91eb577ba71sm28129156d6.32.2026.11.07.06.29.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 06:29:45 -0800 (PST)
Sender: Andrew Stellman <stellman@gmail.com>
From: Andrew Stellman <astellman@stellman-greene.com>
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH 6.12.y] nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()
Date: Sat,  7 Nov 2026 09:29:44 -0500
Message-ID: <20261107142944.62016-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052734-failed-6.12-d1512773a0d5@kernel.org>
References: <20261107052734-failed-6.12-d1512773a0d5@kernel.org>
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
index c5227d267..974d0dc3d 100644
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
2.43.0

