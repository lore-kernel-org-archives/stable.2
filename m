Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654612;
	b=1MQe5FxUfpY4J1Ke8gaI+uCx8ieR/ilBP47IdJawwmwH4KpttWovR1jirZD8TqmAvgy/
	 QK+gpJMPTnCP8fePA2lad+8l3Tj+wXPsTND/xeJyH1BQA9gp/n3BjfU6+RAZHLe3I9RvU
	 omk5UPnlXqS2jQoVV811XLqAxnFfSVcv8SsFKSWDcOiWuUSuWFAdAhQJoyGwoP+aqiWT6
	 7MePRHJJjkfjafqXgPUN2IYV2Ai0LLTQygpw1TYWIE9kH7CxSFod70G71JyVuq+WQ38HY
	 7icdcDw/ef1K5vZzYshUk4q4EAYL7VCwFzPturZ2FbRVg5ZptOr2x4L7QHdEGtBRdqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5DpYvnCuMI3yPgcDnrdR2yXHOcHCjxXFPFiwuk+v6Tw=;
	b=1CaSxMlwYXR3JMyPFuaOUPTeRa2Pf1diFTrz3rcvoZNpRRMJ81ctc0IaFf+qAzYghQkw
	 jnffn7wb8iY6uzxjNOQpuVgyEKrLfmhK1chdgr4kGxVJlZ0eyUrSPpNro6xnIpZsV74Ss
	 3Y4pNU5BwJqnH21j2pxqA2Wn+MukTuzD2H/0DXlo/DqJdQrXsLYdQC1sY0fiRTMDkAE3u
	 NMg4AOJo49UixZSALXO4tXZJcGAgVcWTiB9LfYlPMShC3tpPzcmvwYzqWgZDBAyI390eS
	 N8ZELIBiix3pPVhRtenPWhPJblLDOzPfWJ722dR96zXUyYiFxowVLs3f8EF5YVd0Maw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AGBghq0p;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A70606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 07:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1A70606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AGBghq0p
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3550dd02c9cso150690eec.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792654611; x=1793259411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5DpYvnCuMI3yPgcDnrdR2yXHOcHCjxXFPFiwuk+v6Tw=;
        b=AGBghq0paxJTb+IknsDDvqSPcW7e7FKb+NxGLsbOJav45qiCDCwhrXXUkcmYCeu3LP
         zXoG4r+VbhcTwKE0Kkr25IeH145YqnRkdRazChHW6qmGMDEX8Rl81dwLAKJnLUsre+fj
         93RUenDQHl3ABRbM0mSkJm6UPbU7sEOLRf6IUlsDz0ScETYtMWcuV1BOxPF0puBcRAJx
         4REJEr1GOGCcYNREtDTKKHWelAJWfZb8PP1oLx6hh/eQE+FsSr75dPI06f3nEaWomDPx
         cMwg1Yqgg+l8RA+2UemexZrIcGeaJenNiSBlvcnup9yu1JUkDUxH5rrVq+2yIJEZ818x
         +gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792654611; x=1793259411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5DpYvnCuMI3yPgcDnrdR2yXHOcHCjxXFPFiwuk+v6Tw=;
        b=wDIa4jpxGNCnZlICoEeODvaCAVL2NSIIH2eOa8MfkVJfkjuUsz9DRrQF3K0n3wQmcy
         lVVmtnpP0URuB9rj/NRZOeb2KYOeaQFEiIeQnrr+n0bWxYpJoT+4B8JPuYjeVkoxsWlh
         mKZSrLjqyR86jbC79GAdCjnjnTjKE8XDFmZsC8Yjl0HKa9XWL3a00MCK8bhMEncNZEf5
         Niyo6aa7+UUa6eDgHE10pFcRLq70B8FTWj3/yIMz8QoJlLGmcNgt9gpHXeUfYpVIeZ05
         ugWlk6emdxCOu68an0/hriZXhIMXrcoo7wFiwEhyBNlK5rYqgODgRUYUL8OXCSqoetpY
         aA+A==
X-Forwarded-Encrypted: i=1; AKwUvBwA5BhV/duFt5z9/7fZZGenDZlvtZ+jJCDJrf7au76MLvkalPb3bRmDvplvZdlops1CBMT/Oe4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaVqudA8xKj2TNtTnTw5rhB4coy7OT3VurDzNIK0TDrvJsP4Se
	3nGDSu8lM/ao2BBQquwaCB0Z5TZ8ibvalKb/HzW0pDX7Amldub1eXAJYLOPOrgDEQ5s=
X-Gm-Gg: AYBFou2V9p6FY0z/xBCbnqC+EXgjvNioEA1S0iLT9AdMI1NqFiHwgTBjUCH71aHHuCP
	hL2iM6Y5c+t8pk6MB8+fJ6EHEQhHqQzn9m+o69bt+TPLhBOdITc3K8a7eFUdzFOIDluWo43odg1
	DgK31e7y0IWAF1DHFLwaE39NxB7+nnTc57AN8+mlnwyjaSCgBAT4gl8Q4dI21LxAiWd5Pr4gris
	B5oOv6J0DEhM+kS0VfBPSKkf44fbzsJOZa6QFNLOtkZnzIW3M8ZgKtSRCLi/Ik3xvATQNYtdzSO
	V62Hgsccd6mmuGxaxzv8g1BCQ5qe7YKQE96O4RZQtrYmGKbuDn7N7JFMoia0lRxDLtJOinLYEvm
	bioBoYGuHFr8cR4ZBJQODQ7Gj08YfhLl8p2djATalkrZFRvLJgwIDTp79zzDmYcq4wP+jLTSy0q
	qKY93ek8IGTOe1mbSPA5QZ7LaEFT1B4Ns6Eka3Rs8evbbL55i4CB5is1b0zdOiKR1jLKELSxm3b
	hu1BAJu3zHYYrCLxfq7Wu8bzxb+HrQBnmqV/VA714vNX8SGQ9otNDFU
X-Received: by 2002:a05:693c:811a:b0:368:8792:720 with SMTP id 5a478bee46e88-36887a14b77mr4373527eec.1.1792654611029;
        Thu, 22 Oct 2026 00:36:51 -0700 (PDT)
Received: from archbook.lan ([14.1.89.164])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-368ca323effsm4486672eec.7.2026.10.22.00.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:36:50 -0700 (PDT)
From: Brad Drury <drury.brad@gmail.com>
To: qchcio@gmail.com
Cc: amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
Date: Thu, 22 Oct 2026 15:36:38 +0800
Message-ID: <20261022073638.724414-1-drury.brad@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015095713.20560-2-qchcio@gmail.com>
References: <20261015095713.20560-1-qchcio@gmail.com> <20261015095713.20560-2-qchcio@gmail.com>
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

Hi Maciej,

I tested this patch on a second MacBookPro11,5 (Radeon R9 M370X, Verde,
1002:6821, subsystem 106b:0149). Here the dGPU is a headless PRIME
offload GPU and the panel is on i915. The kernel is linux 7.3-rc7, with
amdgpu rebuilt from that tree with this patch on top and nothing else
changed in amdgpu (amdgpu.si_support=1 radeon.si_support=0,
mem_sleep=deep).

Without the patch, VRAM is at 0 after boot and every S3 resume fails
with "ring gfx test failed (-110)".

With it, amdgpu logs "PCI CONFIG reset" and "GPU posting now..." at
load, and VRAM ends up at 0x000000F400000000. I then ran four S3 cycles:
two on battery and two on AC, from 9 minutes to 13 h 19 min asleep.
After each resume the GART table was still at 0x000000F400000000 and
the kernel log showed no ring timeouts, -110 errors or GPU recovery.
After the last (overnight) resume, DRI_PRIME=1 glxgears (radeonsi) and
vkcube (RADV) ran, and VA-API H.264 encode (VCE) and decode (UVD) both
worked through ffmpeg.

One thing I noticed: on 2 of the 4 resumes, about a second after
resume, vce_v1_0_stop() logged:

  amdgpu 0000:01:00.0: VCE busy: VCE_STATUS=0x2, SRBM_STATUS2=0x80

VCE encode worked straight afterwards, so it doesn't seem to break
anything. I didn't see it in about 11 resumes with a local workaround
that kept VRAM at 0, so it may come with the new layout, but I haven't
looked further. Mentioning it in case it's known.

This supersedes the gmc6 patch I sent on 20 Oct for the same failure:
https://lore.kernel.org/amd-gfx/20261020-gmc6-writes-only-v3-v1-1-70730a302504@gmail.com/

Tested-by: Brad Drury <drury.brad@gmail.com> # MacBookPro11,5, Radeon R9 M370X

Thanks,
Brad
