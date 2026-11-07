Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061780;
	b=PcAK/dwt4tywnmqPgBJgqcWP4KXkfRYT7fjrxg5mzQiHlBM4a/55qVI8aJ0kBnmQeokh
	 H6CDgmGebJp3AGJXaJUU6cdydQo45VUgRE6Rzij1TmY3POczl9kQP2QpY693mWwKkF6bD
	 J1IeoHci9ojwDC+STn1fhFmGBp6g01PcPG55+r0K2c9GRpz0T+LRCdu16guXFF87F2F65
	 IyarQMGo9GsB19hAG/w6vvjKWDeQW8vtKSNQOnzuSMfepa3Q+bjf8gj8N18rhPRo6Xnd5
	 mSR+qH8H7dJhpFGyCimavfmyt2IYzSHVfMXqfOGRSU0yWF9pfhQ73auahdWfOZQp0iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3dXl7wt3Wtr9bQ+8tYZgD1ECFz6gOrwU7uaUhW6BoWg=;
	b=u0Pqjla1Ytcxf85qZGzoknEWZHAoIJ0gp5ATbwm6YxtfRLYfiPJaLkZHR3Tg+vgXaSWz
	 IE3K41JHY4AoDDoYR+OuJFp8GTdQoMVNhw9BvL2zoU5X8mBi7RGuTZWqI1bNHHVwnFO1l
	 bCtkd6QgEARRPKzXXbDn9BDSwzyc281dVlIENhcZgfsAEqCJtb0q3jw2rZbqhApVwIhVo
	 GtHaS95/fy84byiLugr82nKCbEN0nPHSkWXj/1Ayj389ILbTNcKjvtzPOWYxyZUv4uBBs
	 Fw+IFh+n1b5I5KJQkJBKmH5iEEK7a4bjzMOvhz8Wo20zkie/5b6n4oEwBxr3H6ecDOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stellman-greene.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zfh/MtD8";
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FE606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 655FE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zfh/MtD8
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-54f873cbe2aso7129501cf.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794061779; x=1794666579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3dXl7wt3Wtr9bQ+8tYZgD1ECFz6gOrwU7uaUhW6BoWg=;
        b=zfh/MtD8ztu0dJ9foI/Vtgbii6S4vWw0w8hBj+PkD7mtEYPPXVtOAZbliDJhHCalq0
         veixSZktShTlEXSRNhfE0XwoxV3xxM+2utd0OIauL3aevtfl32zdBdLLGYZAaVBym6oH
         yr6aqaqeYUWTW/mHaM8ewuwFrJOiiPz7kZ0vz0u4t5v8bc9gKKDpjeB0MQA8OUTrOV0I
         dP9Rovu3jVBGHgXWPnE3OMhg2JOL4co1z+uQh2J8yP9PX2o9CBSjkzWW03unP3CrU605
         2bv6NBHyBcZ1+M5BlsuP9EuvVcnZOg0bbg4VQvGOK7A9bPBGWCHHFBxSXFfY88+oFCPn
         DS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794061779; x=1794666579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3dXl7wt3Wtr9bQ+8tYZgD1ECFz6gOrwU7uaUhW6BoWg=;
        b=Cu8L8UJWzaVXWO9dXNOQ7PKtsYsmDmditNYwc3fTpBv2Tz9N0rBp669synWDIgEKb7
         nZPg633fBNJMYTLqsYxCM0IfCZZU9wtV23+hK+iivLggd3Z7jlSPvvL24tAzvOJIVSBo
         KSnORiDE6iz58vzL7ar0n7XtN8PwlOFywM7r/mF9haDduwSgTExdW2rfqpbuJbSPM8Dz
         luQIuUKWXwd+OG8Krik1/9BmJqegn0JzQUGMgwSYDUmAX4oScnEhkR3rcNxG5IZDZk9p
         myYQiKSsrKEcv5RFsekPLG/lZcWwAfMmGi+CrwtRmEl6BJ2YVQRbQgpX2a6BQ0an2znl
         6qdg==
X-Gm-Message-State: APuU4Z9A5ZWvJex6qXp3i+0yKYUvLUKY9s0ae/+1+ufTrB3saRof8DOe
	OeLoO+zjcjwj63dYw2JfrZ793ZG2bEP8UW+FpbM/23Sh4XoC2GrOgLPVJuCe7+tDCZI=
X-Gm-Gg: AYBFou32/GAHdwVlH8hZlmwqk+7a5m7LK/AkNh9/Q8JShjxALSdfKh6epn8SeDgQX6b
	T5Goh6pIv5A5Mu6NaU3WAW+JQhEJramOB24GJGNfDU0lTa7EWViRNhvHPrnzsxkz0DGAkIBs2Pd
	m71sk4XkkK+ALkZnnn4sBFvG2ziackN7Pl+x/Lip2b67W+2wUGA1Qurn7FzBWkWU1sTyjdccwt1
	4YkpKrj3T1f1OBO1VEA7NlU3BaQ4+1FocbGK2Vy18MMLK4zZbzyJOVfoktwL7rv0oHwf9KFS3fQ
	mpxWHepGz3WmXy6TiveoMpoad9waLxp/tsnxrapMOLjFJDlbG93HCtqSRGIlF1Ns2ZJAXmNkE+G
	ix++JzNxIg1S42bPNi6V+JVbmi1rINabvhkQSBFG4BLvYduZ7M2nuUiO29FjJ1lum0P/T1t9GyK
	EIRQ5OnYPsZ95c1wLTwPj3Z/X0tlI9QBda+dxz8ZHwJBPVxGshH42hzrPba/ztMZ29c5MVRtuuA
	dK7vg3WvjdhbJoc+2ox21G449xgMakigZnkb/17LsJobA0xvDb9aOve0KJkcsUk4ukOhipjligK
	tyd4tYdUvzv/6F+jb2QlfuF/X76Z4JpsJnApdRPWfRo13p/34SdnFkns84DilL3MNeCYev7DO+/
	nBsCjuVPxusCZ7fWkhKzLTC39qwZmBekvuMpSINM7Dlmy9l/Wddm04DdVtHyV7TVqwxDLDfFtdO
	lYmW0vly+6OwIbe9p2/Zy8EF5H460=
X-Received: by 2002:a05:622a:1a83:b0:536:5004:6347 with SMTP id d75a77b69052e-54e13e755c7mr86566681cf.25.1794061779194;
        Sat, 07 Nov 2026 06:29:39 -0800 (PST)
Received: from Mac.mynetworksettings.com ([2600:4041:5c28:200:397b:6557:89ab:c2a8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ebe8303c3sm15070066d6.16.2026.11.07.06.29.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 06:29:38 -0800 (PST)
Sender: Andrew Stellman <stellman@gmail.com>
From: Andrew Stellman <astellman@stellman-greene.com>
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH 5.15.y] nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()
Date: Sat,  7 Nov 2026 09:29:36 -0500
Message-ID: <20261107142936.61911-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061319-failed-5.15-d1512773a0d5@kernel.org>
References: <20261107061319-failed-5.15-d1512773a0d5@kernel.org>
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
index 10aed1c449..29fe84cda7 100644
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

