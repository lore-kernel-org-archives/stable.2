Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006755;
	b=ZkPnaqZTbR1yTqkonw14V5SvXj3tszXH5k3MnXKuBoGAJPxjPBI+EBljrQAH/FUCvFZi
	 tYxdwn7nIrEl1kQ1+SyqKOEDoEFTDGBH45/kVhw3dH7AItZu9b7zSdjxFFePJcsec5tLt
	 Iyp8aS2FPeGWeXIkPfVB2odChpRYvrTTwNGqEbNHHft+PQHkgFgPZ4j4twshApPv4r8rL
	 aSv0kTw0LOPOLj22x7a7PXu1QmoW5m+L6LzR6EhvhPRWnZiZ9yWPLZh89n5hyaX0BNnZ9
	 PHiSzxASlfmUIow//cTlhE5xkf6eGa3csqYNCHUZygJiXr2kkddjFfeA0TFLn9NUxgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xV6SX5EGiGjtkdhAIi5UEb7NqFrGHjtbz3buhHPyzGY=;
	b=GSzF+TkBw+5nirrjJChwxTfSGtBhisVHwYwRqrZrEAi8lXhtoiOppoGsbXzWIsy8tWgQ
	 4vCuCs/294BhkvmaXPnToaXfm/z0KKKs241r6OioyXsjcQ/8Ox5w0AOgHRz+wGNwxFmZ5
	 cLK4gSe55gCwXPR4cTZg4dxvVkj4Fjil/5F8UVRxEXv89H3uBPGqaF1k05IoVSg3um3ae
	 W5HUr8uJlpWouQHWJ5SdQrgyMDwahmjaeRdxVa8x2GY30cwfwfcHJ6vqj6tDL/vaHEK4J
	 qmEk59zmg0+mFWoLE9qLpmK3U8GvcI1iPa6e/3udRMmihEk4gYyiFvb6Muzij68ho2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WiS4Pj7W;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2B606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1C2B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WiS4Pj7W
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dee593f18so785026f8f.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795006753; x=1795611553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xV6SX5EGiGjtkdhAIi5UEb7NqFrGHjtbz3buhHPyzGY=;
        b=WiS4Pj7Wv+udGYtZHm2LbkFKbZxxeUir4cmqmN4Xc15StELrxcZz3IqJs9sBNj1SV5
         k+JsdyNDD7mmer6LwnNzCJ3NsbdOf94o0qxo6Jc9pcyEJxeM5ioUqrcFA9vqxibZ0J2o
         a7fn2brMmX5EJEf4p5W7FM20vCGWwKxy5u12x1de9Dx12pyk16Ew2l7IRN90alNrrW7K
         EUlrHC2tA3rFXnXyA4pIUg2kOVwu85EY4pAkVe/87CeDgVgdAEt+bOdy9v/fG/gbIJpV
         cB4c3VveUMYyMN2Ca1sfohiAL6ct+gK3Dy0MNkOh6656BTTW14/qA4sNDzBdoShj6nCx
         mXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006753; x=1795611553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xV6SX5EGiGjtkdhAIi5UEb7NqFrGHjtbz3buhHPyzGY=;
        b=eIozuhIRNFPCMfthFfThmPh3nun/NoxG8fWMG+8D0rrkcg/1tMNvPEzdMLcwWfzbeP
         J//Nyfc3fZbCf446Ojb4qLzWr3pFdOA6Vwc5DtxZczG852DeSy72FWVzOijKxyUThbWO
         17ztQEDZFLrv2QTLOPKGEizGyuI9U8/Bz3jGLJloHrStZ9XyqHZIRwFUUtDtjXns/K/+
         hdIfSLPae2YI+oJR4ELGiX6GmznE0gNqsQ0HPQvPu5ca6iapJGFItAFYuH61vFkEaA7x
         Iv9ymarMqATrIfPYLB6QVp7PmbxjsoXnAT86PDeNJChOTRkcgadEw5NnVPDiT+XWW8xI
         NMuw==
X-Forwarded-Encrypted: i=1; AL+hErEEMcH8z1OtlvZbniEsoMljWjd31SGcva6R+qawYiba8xZaqD+wpWFBmDGWOjxGiNuVTpllu1I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yE4WHZgqnV7rbEFTTguELtOO1UeMdy4rn/yhc3Voh+44xlsk8
	QQnIinBiaI/6wZmE3va58FUu1AY+8za3hlCgf0cLgXlDSLmfptPiCJ1D
X-Gm-Gg: AZFdTZewjybc0IzCZIyDfpI6v+2JUXpGMDmMT4KWzvbRIDMAU0FiFcC0F06r/jgxqz+
	senC+U+uGx8G0IyoarTPrkWnrth/1J85cJb3e2uVb/6iiSfQATIWBwmvK6H3tfOtw4RCduzyVIr
	7BIRAQTRwwZevyFRuMyuyfsjRgR2xNzq4WlE4pso1XTz96hwwM4NL9MNZUbCAjsJJHt70F0JsVY
	0S8F5QKcnIUA3CJ0eVMWpEhXxja5Z8I+556bluUPnn9BJ88nIFiRQMP3A9iKWreVZwpxuQUDZMy
	xpxpNIMaQV/w/FSG8wv61YRsmj0jLp6Gf9fM7tpcHIdQDVJLPmZjkJ07wl2mxCk7Gc/+fjNHIBm
	Ht/lft9bKxzycL2eyhKaLufex7eKBJL/F9SDIxRRElsZ83tgVQysNMhFq8AfLVpzOSW8lkMTA71
	2Qz/l1yDJ0J7tEoEq8VcK46vcfEclaztDSooWENoHg/J1APR9TZZA2iuHOHnFLJTs18P5iekKEd
	w0C7KquwqHybpSaMzeDPhFkfrh2EHHo02e0bPews42mIDTsZ96oY4wwAvIb/PvqHobS4cr7lC94
	zVnrqE8IhdOiL3cyDgJNRcIAfANCsEqHvWdEunydD2yVFG0UOLmGsngabUCD/23NRGZV1t9ieD9
	QkeZB
X-Received: by 2002:a05:6000:1a8d:b0:48e:f10:ceb8 with SMTP id ffacd0b85a97d-4a63833975emr5859543f8f.11.1795006753058;
        Wed, 18 Nov 2026 04:59:13 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a655db6d45sm4609457f8f.33.2026.11.18.04.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:59:12 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: linux-rdma@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Abdifatah Suruur <suruurism@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] IB/hfi1: clear VM_MAYWRITE on read-only STATUS mmap
Date: Wed, 18 Nov 2026 15:58:48 +0300
Message-ID: <20261118125848.26160-1-suruurism@gmail.com>
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
Content-Transfer-Encoding: 8bit

hfi1_file_mmap() rejects a writable mapping of the device status page,
but leaves VM_MAYWRITE set in the VMA flags. Userspace can map the page
read-only and then upgrade it to writable with mprotect(), bypassing
the check and writing to a device-owned status page.

Clear VM_MAYWRITE on this path, as the RTAIL and SUBCTXT_EGRBUF cases in
the same function already do.

Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 680364fda856f..779dbe32c69da 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -492,6 +492,7 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 			ret = -EPERM;
 			goto done;
 		}
+		flags &= ~VM_MAYWRITE;
 		memaddr = kvirt_to_phys((void *)dd->status);
 		memlen = PAGE_SIZE;
 		break;
