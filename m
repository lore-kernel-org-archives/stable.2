Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061789;
	b=D2Ahsvs550Q3iah86BQqrvJxeBstJIkeNQEvSXik2IZ0TOZOZ5OuT5CDAPR32cg8Q6jg
	 TWy8gsp8Nu8tM3j/rQCS5Tk4mCGkysUW2zXn1p7s07NQGt7Ht1kXc4Ua8GkV65tfFGHni
	 cUsHCNIyU/DJ7HKyzt80/u0LhXverlAzNQh3dQSFkmlUSwghphTTa1UjTjeHGMNFx2aoj
	 GJ49SsgYki2W38qOKq/2evh2wcOHtFf0KGf9afAs+bitc4D8n8edMvAWGO3IUH4S5g5/L
	 mHDUPnLNA9xROndwnsATvERVd99rwsOfVWa1gvqRWDhoLm4psWGb/FLn6Ak+xRtiIVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oG5CSN/7HKEfV51yrEHslVOPRlMVCHP5zsYnkfwFfEk=;
	b=WCEq8N+GedWqAnJQB+YGvJLcQA+enygvM1ljqu1TZSMDnJgh3eDhFh2H1i/SagAypf7S
	 hZUBSQ9+Sy2DKiTd1wqjtU9u/pyhM4BHSQj8panGU50yvAhv0dCx/W6/KJbN3hGjDU2vJ
	 fYdI4+Hfri3fexHEJiryEUsHl+EG5anaUTkNQBqA8ZVxsiL9zOSLV2bHsRxhSU+aHiyj3
	 pUOLu1gkOJY2j7m/RiGBULuh0GPcFs6NfuXIwbRF67thkbotFqhTqDq9eIV/czcCWMTGR
	 OcqRe61xZHLT8ZY1m81cStUi8CUpAmL94q3cZcaRnmtIzsJpDbHls7TmxP9G7uaMdMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stellman-greene.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Inllwmv0;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD77606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DD77606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Inllwmv0
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91c9cfd8b1bso18241526d6.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794061788; x=1794666588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oG5CSN/7HKEfV51yrEHslVOPRlMVCHP5zsYnkfwFfEk=;
        b=Inllwmv08yOOLdc47N4geLAweHLjebniR3lRVBm0MI0VYQMAZaUTCcUSwcvRd6JCCH
         OFDGjlKljNlY7E+ERInzbkkiknbAuceDhMYqsJVHynhSRu+e/wKgBA86b9U/BB9aV4ml
         M1XzAWUYbeKp/0aLqx9UpabUOYrkur4oF9xITCUkr6DUNTSy0olWDSMnCjRDWJrojfoW
         rI3S+uOkG2r83xDd3tPHaxXQDZPMPidgmfwmt7TQql2ZGMQMvEo/m3m1r0ZaIuj2a7pf
         Er3iUCYLoJmDqjaBN1aoQpphk97LnNTbHcL3g46JydmhQNBXR6vqk3vEQg+n2FFkPv2k
         /khQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794061788; x=1794666588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oG5CSN/7HKEfV51yrEHslVOPRlMVCHP5zsYnkfwFfEk=;
        b=m2cJHVCh7dPUfp8YvE4pnivLG5hMmGukcQstrQmon7FzLLI3WILsfgcTYjx2CNabRr
         3Dc3eDMgoTJCTNHiy8gPh1UYbDrpJ5bJBQMw/VO29mraPXoEoV3YZUyBFhtj6VnygOnb
         ES3RM0ncjQQt8/I6QTWhly8+z3p7sgNbYPdE7lNmQqTlVGybpMqIOBaZHPGBxLkNTyke
         DjImWt+0smyjmIawdibG1lpIFF23yw2XQoAMWOPG1zS2yFNKn6yPrYkWTfd8ChSJJWNU
         oger/KtFzc+X5IRb61eVOYxgnXznX2XTuLqfGXS8a92JAUnP15PCnIEXTCCz8kZqclS2
         mIkg==
X-Gm-Message-State: APuU4Z8tU//lpDT6iEr1nK3M9sjG7cjO7p7RyPCJNRYrVaX/t6KLk+Aa
	7SqOAxRQOHC9EJaD6hRd3g3JLHSDQJVBvG+yJCHbT3ydEBcG3jHWg9HL0tI67aN64NM=
X-Gm-Gg: AYBFou15yiFhLe0CDbmh25S5YUEBihi/iZAskD9tE8uwBujeLM3crOirovxbWXpSwzm
	0Lu+AS4L1gHSccEd495sxC8x1zQ1b6jhJkRfDWr0uf7KrZf9PuV7QfWCbyXtmyL8+Tlqkb+LPX8
	YwGabvJyJvLWxOUWhaBxAF5TM7L+OyXkGV1G0EsEJMq4TnbpaLd5QdX1RMCTadDrRd467cdywGu
	C7ojrE/e1yoZct6Cw9MhPaSiEyL/tYIIy9n9ooaTwJXCiKkYE+tooxXGO7ZgnQAudPJYiy8LZlN
	sYI4rDk5MwwWTDYiXH+fnR9W/6DBpDbv6X/4vWdW4Rvt1NXXFPq9pI5M+uJn4LkLQYR5M8AKxzq
	FE4IdkERo3QIk8XFbtwXuhi3Oo+8K4IaXqBNJFyDkO1DVsnRjuHYLt8dzPy/+PceAtnOPpPw2/P
	sGlJGn4dsmNjFNY/tko+bjAkzLrsL/ceCufLPEfdM5wHwAE9r023IfpVZgpLLr8m7Xao4jIathW
	KN/1gIFWmAOgMknDoDJeE7VzP9Schx1Hv1WtmPNRrA/IBNuBlp4CB6gtzHjKgRcHAUlOnMkqgc2
	HCDIg9IsGONq6yy4lrmj1ykH2chpPyRWZvh0gfWLtZL9bQsKEAJjftIrgrnxgWWE6pWTzjgj9+v
	jRNKfq97IAy+basVRBbM8e18E6UUMjKZOZiGmaLOM+uoJtBwVIc4Rah7haQEexYdHb3qbogyVb8
	axnABmA3RehxAGltMHxkg8fZDI8HE=
X-Received: by 2002:a05:622a:514e:b0:536:6ff1:7568 with SMTP id d75a77b69052e-54e1517261amr85327071cf.60.1794061788084;
        Sat, 07 Nov 2026 06:29:48 -0800 (PST)
Received: from Mac.mynetworksettings.com ([2600:4041:5c28:200:397b:6557:89ab:c2a8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e26f1bd64sm46794341cf.23.2026.11.07.06.29.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 06:29:47 -0800 (PST)
Sender: Andrew Stellman <stellman@gmail.com>
From: Andrew Stellman <astellman@stellman-greene.com>
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH 6.18.y] nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()
Date: Sat,  7 Nov 2026 09:29:46 -0500
Message-ID: <20261107142946.62044-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051535-failed-6.18-d1512773a0d5@kernel.org>
References: <20261107051535-failed-6.18-d1512773a0d5@kernel.org>
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
index 2b03bce27..47a9c4cbb 100644
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

