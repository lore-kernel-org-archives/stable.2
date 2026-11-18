Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007996;
	b=KSn/7GLkfG1n5NXbLwq0hewb3bng9mYCVJIbTiDhiatnzo7U4vFypeSAPpULuE6SJalC
	 D7V+SV44GFn+G8qVt5MqFGas7Zx+MuEsF0Nprw8l0leNX+oDqKmCh2mg/y8ZoIsN2yhHQ
	 nNnuVrjJin+pZxZsPHKazw8O3gA0qnXZEdFxz4o1Ey8P1cuZ2t7AzGbJdwbHedupmqa0e
	 u+eTzTjXm88+bCisQAtblAfhyIdAgnJiy4twtNeEO72s7AkwPO+nCJzWixKtt9zF5si7n
	 aiAVujKK2VEycRrAGnm6OZLlgv4zDjqSZaep1FQXo9JKrLQHLscCUt+DI6g124F787A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XvTSmuMfFY3q/sfZxdJtMgP+cT08HPhiF656C8De+nA=;
	b=XxEolVwLDs1w+97JzKtLdj2NHIbryS7PF2k/c5D0noIgvcC38w5uGiMMI5KyBnRo477o
	 8SCXb2Ppv+S6ZYl+BYINaSpx2HXZqLMY12Esp0OW6ZCY3L6AWqnX9UvNaTur2vHowJxWG
	 YZEVJxxAPEUD8H1ArICqMkzEjk1vXvLTOnLUVHzTz4dFNu38SfzKiWGrQk2supfKdSTnB
	 kHZ2AVjZvrEJ6WtHYXRNM0CUJhLjJFbrVCjbkr/k8OfCRKD/xrueDSKUqj5+CqatMT+zN
	 DChVywOKzmloT8WfUOygYgKnnBxD32ObwQHx2aJ5RvROJ6sw8klQvO5KLTAym9us/XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FzwMzYhc;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331F606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A331F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FzwMzYhc
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so7483445e9.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795007994; x=1795612794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XvTSmuMfFY3q/sfZxdJtMgP+cT08HPhiF656C8De+nA=;
        b=FzwMzYhcOT68fh1Wfkw/Jzn6y+7K05F9ZpQ/2KPnIs8uL74CgV6RR8vKA87xNjbUeP
         eIILtRAyJVotot4NT+3E4wX/5/i1i2WxkZf8hbBafe5/GGDRr3AmH/LlZm9LpJ2T75KH
         P+aoDvuZxiCmjg2pKO+Tmk6DCU7sviVtr84tDxJd/+TVsaLYGbrOykAE6f4/AonVzpyM
         w37IgqE1CsCOsxt+7Mr2kVDICqRAKCA3ixoFspv7SWOzRqE+gUxbgSo3mIKH7v1jRy+D
         WlQF3Oq/TTxlaMOQEiPhLyW3Pgg9ewrbhkxJo2DRoTsUb/yoZylw3vqgNl14NpeZ0KQp
         RM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795007994; x=1795612794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XvTSmuMfFY3q/sfZxdJtMgP+cT08HPhiF656C8De+nA=;
        b=U2Mdn3umVONw8lupTa3EhrHDbkGag+9vLaZBwrpAdO1q/jDWAyPDc41ndmPSVi0OBt
         D2KT+07Mx1KbGQA5pzy8u4jJ4r3+Co0Unm67I7CWZF+z4V2Y+ux9/ssZ6RBIYNTSjLPq
         JLLmznou4N2OjZe5oqMtoCrttlUcc71DHxVuSdlCl3o10OB22or5OqqxYG6Jdb/ynCxW
         Sk1FI8AMvKR1C7wmp8/MJqH7WOxR7ag/FNJo1K9VI4ig32RjQ1Xif78jKo87eLca6glG
         LFW+tB2wZigAiQOk1/c9IKMuf2Qf81/BT9Vu0QhxRg2PHU9e5SLDIWlG3KrJZV4isHI0
         jobg==
X-Forwarded-Encrypted: i=1; AL+hErH7m/yLtnuEFHtldrilF6hZfKMsbMNejbBxoq8ltSwMVTVX18Xok6nWaz6MmBHQUYgxz7751fo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8S1nvj+JvySZl8G50neiOyDOzpraCFRWxGnSsQ9OcaFA7LTSlW
	OmdylVvjZR79RlxSrHUfFKJuWEs8BUw1hyiNcFR6Ats3iu23pI4VCmXn
X-Gm-Gg: AYBFou2bLd/W4zWbaKi3EIUPQDsA9e3o8Acedo8lYbv4uMf1Zag049mWmGGz1HuaCPH
	Q+HNQ6ooHkDbhFygdNLDEH+dSfhOJi49Bp4+bXBq/Wvp2PTWwY3/bobTjJ7NqkewoturNTmL9U4
	JfvZtlCmcc90zr45YpFBH1WvcEUsuH5skiULx/ifOkUum8mJq5vnaYunR44ZapBacnTY5ecgqj/
	m2boJONQlBatIew9hbhXYiGeVwstWwvlssUispBfurzhWuLfmQgELLE+/4dpe/dYY8wEnx7Ckee
	T0x+c8I1K2M4UmiobtavdRgOAQPXjAM7+tlvymEzL9K0Wo885eLPgVLCz4V+/Ea9nAYQfbm6PkZ
	S4rtJEXY13LBtm8lPzNVctaoeMQPV4kwQxoSZfqG9pSQplcwBBvMPZtdBHtt/Yc+WkDSqTMIhCo
	x1LrkI8lUIAL5uSrWxrTzRtKCSwy4lB9UIFrki8N3pz9462rhxBUMWM20xgQi5QSjwCYTO4zli8
	bQxX+DClgJK6mUtFGE6EIobVlqHbv9qoVKkzvvY5pctdDP41rx1sABYFTOFg3H3oSmahSi0kI/1
	Wqeyv6+940wWimDP78UeCPdcVCgRtod3FMDSLTYTiEYvdEqvvomlCuXW+AwMm1NjNUv81B3W0M7
	ThP4r8ynqGxGEd0YPFt9Te2QDNA==
X-Received: by 2002:a05:600c:4f56:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb7da12aa6mr53734285e9.10.1795007993903;
        Wed, 18 Nov 2026 05:19:53 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7e513c28sm24342875e9.0.2026.11.18.05.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:19:53 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: linux-rdma@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Abdifatah Suruur <suruurism@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] IB/hfi1: reject writable SUBCTXT_EGRBUF mmap
Date: Wed, 18 Nov 2026 16:19:47 +0300
Message-ID: <20261118131948.28748-2-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118131948.28748-1-suruurism@gmail.com>
References: <20261118131948.28748-1-suruurism@gmail.com>
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

hfi1_file_mmap() clears VM_MAYWRITE for the SUBCTXT_EGRBUF mapping, but
never checks whether the caller requested VM_WRITE in the first place.
A caller can pass PROT_WRITE to mmap() and get a writable mapping of
the read-only shared eager receive buffers, unlike RCV_EGRBUF which
rejects the request with -EPERM.

Add the missing VM_WRITE check, matching the other read-only mmap cases
in this function.

Fixes: 12220267645c ("IB/hfi: Protect against writable mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 680364fda856f..6de12a276a605 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -525,6 +525,10 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		is_vmalloc = 1;
 		break;
 	case SUBCTXT_EGRBUF:
+		if (flags & VM_WRITE) {
+			ret = -EPERM;
+			goto done;
+		}
 		memvirt = uctxt->subctxt_rcvegrbuf;
 		memlen = uctxt->egrbufs.size * uctxt->subctxt_cnt;
 		flags &= ~VM_MAYWRITE;
