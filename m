Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792928535;
	b=Pc37FpGZI0WBRxbx17txihev2o/7otM6N19TeHxUhgG6FlM3eM4SLB8XoQpAxrP4sMmt
	 YwUjrNBxizvV7TvV7ziAVKU2yAaTw8Utgll+VvXM6vg9X3XdL5WK9Mp6TiD5deozGhpBo
	 nRxo/eBT0i9klIsRfyPoOyX7T2Jk6aS61jn0vX1Gx/bSQWzDNcEOyUufHzNemPdrHc4tc
	 weWHs4AOOcvUJKO+JR3bMijyoMlUBah+fW8M2p5PSOppX1oqw/0HPKigRA+LscRBK3pyZ
	 onfzplgsEBLqBFTzT20GbQ/b6l9ju0rqiGJWuW686ccAZWnFr/eroiojoEdsyj2zIyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792928535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eKGclNvWgUqyUYzP51bT4mzycc6IKVIeGzeiBZdeKY8=;
	b=aVQdzpZ2kWZ/BqBuii+UtM63bRAld5zkYQySDKZxvYzBe2tR85XutneOTRPPNGGqIe/X
	 jLwXT8J++/2TrVxSB5PX3E1/hSVz2/W5TPxXhABA6eBSEGTPYPprmWJXhIY0qIpi/HwiC
	 Fwo4xMC/7bfB6R9hArLCwWvwmMx5urueFfgHXSA29Dt0cwW4ym3YrFCKIaRbs75gWFp+1
	 wnQhMgKCwBJoWgpDdaPQeI/RIm2L7tPs9mSyFrB47CIXwfbdQ7/eACY7e6de+pXYD91R5
	 KmTY4pCaEO4n60Q9sSVQpJLy4byKnISJcfb1Kfi6wk1m1JtIAbZXIbyKZHej8qaV18Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=U8j+IzmY;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B11606A325
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 11:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10B11606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=U8j+IzmY
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso1687144a91.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792928534; x=1793533334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eKGclNvWgUqyUYzP51bT4mzycc6IKVIeGzeiBZdeKY8=;
        b=U8j+IzmYH/pXSKWVIUwus2HUH+rGH8aZ4T8suJNpGewLFnCD7J5rvzI0HfSiYCPSVZ
         UU4CkEMO9Qqy2W5QvDKlmwHH/tbrDBUXcW+av3RsVX87Yr76Pcq2W4fqtINnH9Dj0YAt
         PMT1xCU8sCW8NDrXZD7L89UuKvknbqIDeWPRU0pyXxNlktk/2pQo/MiFFoAFQc/QXQJm
         CkiPrXK0z/fSuNwg/322gb5PCMGD1njFA5/U9v7Uy42Xg5UcrgXotJ4/DNDnAPW2vh4m
         oQWEI0QnVs/dLN9i8IBZti+bNhXgdtmXhofpsOoPgmWMCSXUEn8tr/h9gmkuOJw2jxJg
         U2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792928534; x=1793533334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eKGclNvWgUqyUYzP51bT4mzycc6IKVIeGzeiBZdeKY8=;
        b=BDi5aNcfRTPIfhRE16ToSyqqv+FxRlXRg+/GGZ9S2ArDBi7QRrc1M4kXAP5lKtqbF7
         c+w7AGm6ohnARCkrQfo/0HaS4g1atmWf+yhuwtM6bIKRzDJRkneMA7TGRtrbGM6kHkeL
         I8lQ21R7Bo5xt75gbhDdpyjZQs5QDSGNhI7l7iSWV7Y3Rw4vLuaEXfJPGCp3SWh4D4pB
         38iRSKnsVPwTGXa4RcPE9m3xnRlmV5e6EXEI7j9RRw2vhT9u1CbQ4lwZk2ztlJfYGZTs
         R4VMsj8Boac7BLJ+s0K6QuPMdiIzA5M4mcvMrZYtkPG3nJktzle7vez9HzHlp4/kBVSr
         2S4g==
X-Forwarded-Encrypted: i=1; AKwUvBw7/tESE06YqGISqIVPX+UPgNoTxYS42b+cuvj85xHbhr9iyPX+tjJ+9fYtK91YtWdHzz4lfPc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8kE2nGO5/7HbVQFQwsp2l/WI/Mch3YvdNeH1RyLnFMSnsc4ml
	EBF315Wyng0EOyGOWXf5YOWhFyOtDU2ZWHR2A7NMxIbfrscjKXAEjikKwE5xvFYT4Fk=
X-Gm-Gg: AYBFou3MJQAJWgjV501JfU+PTqBqSmpfv7xkg3Gt7qKEMGL956wDV6ZwC2ynHgX8W+m
	KwSLqGf2ynuYoolnNrd2broJmQWVCLCGHuP6YHPU/Z+FCdgLqlRn18fuDmu33A3D3u7MK68zaNm
	ZiOib+9pUI2zac9Ypc/EnSAEWQ1v1luadHInWOV9aJixpOSRSz0579/Lwb+RH6RY+Sw80xlWRGz
	7gKJr0Zzobtw9YNjJlG6yMaKqssbBWeZ5dqh8btYPCDb3zpN0tRFvWdG9lUxWwkd1eOL4bdlyrI
	lnJH+vzybmRxovQKRXl7CDoJVBo0GcrS5yTVyiNlwY2OGjPtT1vvDxMnCyIofR6IQUv/MPj1Pm4
	s9jy6yhzvC3kKxFdmrN/llpbJIhzrXP5PpSdZKRJOtW3lV/l+xqCD7RkirpA/b24FnwvDYIvXS3
	bh8RdxA6zDwAjsuNJK7iO3kyV7bt+qTr33oS62lieDeG3jC5HHELpqw1UMZb2/GhR7lHJ1Fr4VI
	PLIRJY/8twnLB9twNjaoLOWJfvlInq7vaMXCAeu1PzG+W+wScmDR0QqYfJiMP8h2n7ROP1MZZKV
	RSZo8nsVnKEMqqrhPqPl5p/9Vp++lh6pKtHkg2x3+oAfLBxD5iLTNxhKsU/MtG9Biw==
X-Received: by 2002:a17:90b:57e5:b0:3ac:a7ee:6770 with SMTP id 98e67ed59e1d1-3ade9b2f223mr3775889a91.7.1792928534279;
        Sun, 25 Oct 2026 04:42:14 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:dba3:be57:a674:a67f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32e38sm5219705a91.2.2026.10.25.04.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 04:42:13 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH 2/2] RDMA/srp: drop a truncated SRP_RSP
Date: Sun, 25 Oct 2026 20:41:55 +0900
Message-ID: <20261025114155.4007867-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025114155.4007867-1-yhlee@isslab.korea.ac.kr>
References: <20261025114155.4007867-1-yhlee@isslab.korea.ac.kr>
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

srp_process_rsp() reads the whole 36 byte SRP_RSP header, the tag, the
credit delta, the flags, the status, the residual counts and the two data
lengths, without ever checking how many bytes the target actually sent.
Its two siblings, srp_process_cred_req() and srp_process_aer_req(), both
refuse a message shorter than their header.

A short response therefore makes the initiator parse whatever the receive
IU happened to hold from an earlier response, since the IUs are reused, and
act on a stale tag, status and residual count.

Refuse it the same way the siblings do. A conforming target always sends at
least the header, because a response shorter than that carries no tag to
complete a command with.

Fixes: aef9ec39c47f ("IB: Add SCSI RDMA Protocol (SRP) initiator")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index a85d28b95306a..d891029087b7e 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1946,6 +1946,12 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp,
 	struct scsi_cmnd *scmnd;
 	unsigned long flags;
 
+	if (byte_len < sizeof(*rsp)) {
+		shost_printk(KERN_ERR, target->scsi_host, PFX
+			     "dropping truncated SRP_RSP (%u bytes)\n", byte_len);
+		return;
+	}
+
 	if (unlikely(rsp->tag & SRP_TAG_TSK_MGMT)) {
 		spin_lock_irqsave(&ch->lock, flags);
 		ch->req_lim += be32_to_cpu(rsp->req_lim_delta);
-- 
2.43.0

