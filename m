Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118134;
	b=l7fJ4LLxnJmX7qCCBwPc9RHL+KEHfQ6u2VV+LoEmDsy+wbSXq31hAGEr40OJVL0Ma3rH
	 gmDYloAnoUMWiMWA2eywiT57canadiwDdibYAcaKDk0kHdhY5yOKL/O73Hv1QADvWMGSX
	 4WLZ2M8qOuA3Rm8O8Qql63wEVXdDVMqNUBzau9BWOAxhApcHtdDD9koFNd9NPmTlN+brv
	 8tsYt7ODOeHPoScv2aKgIbhBg9wCegV/fHxd7XD9YYi3BmBbANa4h5FkV5T5eiJfVST+X
	 +eSOpb+bJuyOQrQ/jhsRkgYrz0pXxqGn6rfndhI7xdoUW/GiWI4FSZ6VojPe3EN8TSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=1rdLpGOdPiVaYichAmiV+HhfkwVpdUkenG+R9qH/YbU=;
	b=XVvYhgFFBmyLPY2KZEjRdq+BSCABnC/qId4XHbyoVLQqsRW28497csNisI6B7YcBz93A
	 t11UfLcCaRBdI0HM0mXwSZ+2aru7AWOqXeFw5NPCB8Udxnl2kHv14/1UwLxcRhLu07lTY
	 rj1P978O+nxK9ED+uDn7Pj3x2AWPmtZo/woy+Aa6lPn7/mSPzBm4yvfij16dDuMzMZi7u
	 TYmJWX6Pikqi6lZnR+kXIWblQHL4UwsD6jPyE+yTgyXl79isbWpza+AhnUjnKTELT725b
	 kxJRheX0JVMY6t0fzJ6mpOqdrAdW3dQTNP0DNHwLhoMqrXLKpg2bj/f+3O0ys+YTb5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ojT8056X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F96606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9F96606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ojT8056X
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso36418767b3.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793118133; cv=none;
        d=google.com; s=arc-20260327;
        b=MED55YUP7jz+MSSakcTmecpwomJmcsnqv+lDn90YSvVgwE5mEltxRZlVQPzfHt10IC
         x2YgCNGAHx62ppfSVJkRKJcuj7BSj/jj6bsU0Hbq31FzAY88fnutXgCjF0axwtNi0ZIW
         cko7rbmluULrBuM1tPMmITcLk0+rSmXLkd6bvFmMkNRHewR2r23QavZkuq5pJ6ViczVB
         nMrWNaAb4nqvCGtvnhJZ1hk54t2kg1q9Y4h5V9RaPt/X4cJh9dQ3J456uXViu9pqB4HW
         p3D6+h9krNmyNw2e9Lhf91GJBLVgWa+JdlKAL2/UHNaJJpVgOCm6BhKB2nSWvtMMMD4T
         dEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1rdLpGOdPiVaYichAmiV+HhfkwVpdUkenG+R9qH/YbU=;
        fh=B0RRjYVwxCQb7ZvOU5vqvRHb7twlsfDViTt1uFFHBHY=;
        b=XCKvFSeda/mfDCM0Rlgr0vlSpJBQq8kXJtPt3LWtqhpgeXEqkO8WrF3WD2zQWqSkS4
         CnZpKIb/HFX+K6P4a2oYc1NXMvFxTC8rmKA+j22yVsHkEhoadt/50yYGG3T42J3PJHkN
         f7NsqUERWc5Aa7KKHACq1FAp0k46nI7ghZwmAkUpfpCRQ0s6sd7xm+xZ1YHLyfgiKO7w
         S3a+bA0hF7GiL0UvJfqSMs6opdMWeMiR4ycLztsCJnaDj5DVNvD1jKy+7FLCqW8t+GHq
         ODG0w/weaLZN0M77p/iVlF5TDqWWp1/U05q3Oghbjjn3I5KCPEfkjN6uRJ9ZqQDd+HV6
         5qaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793118133; x=1793722933; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1rdLpGOdPiVaYichAmiV+HhfkwVpdUkenG+R9qH/YbU=;
        b=ojT8056XaWIE5tAJULqg8MFCtqI2PkKXedZdnmIwjDNx/gjdgoJFOYgr60aavlYget
         NAph7/TMSvyiX2/+G3WXKQEkd3e1zFb33LVIAvGMHQMyXXL0izVm1ASM7Y+M8XXTvzSY
         BUzGvYSB4BDmOhIdESLK59JnOefu+zKnOjL1FGkj60Qb6spc5fcaAA7pWcaRG3MOx60u
         tP9sUY1jo8Ud5wu6gKiyPGHwpfDLUiyKAyvPk2XguE6nN/deiikto7XBHpiM+q65pEHu
         RHN+oxpmvgdzMgReZhMbCFXcEt9tUwhH3hoUrasBe6SBx8sVaKes6Ik2x6Dib5DJ7YDC
         Njjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118133; x=1793722933;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1rdLpGOdPiVaYichAmiV+HhfkwVpdUkenG+R9qH/YbU=;
        b=eWcOYNKYxc5BOlCT1k/fEw3/GebnDvjAphFyDrPyGt6V4UvEJ3WWNZRAUviX9/cXuA
         9Q9uiS7eglFTtVE0ffiR86XZ2yICjtAmmLo3ioTUG+na30NVReQ/pu7YtHYfyyf0rBpR
         1++ITY2w3Qdb4vBNVjzbMoPcGAkRIBld511Q17TamnqjFGCFyhr/kp741fkGdVZJLMxF
         nGhwx9s5+BrPmDcMXEOacyzsBMd/y2/MawwrP5E1I58T078heD+I7QTc8JlDb/QIlucn
         cQNKYpdJnUZMJD+QG/VdrWvgNH4ROfGc4tAv7qpZpHmaaBgKKM3vej8y8sGheRnvb1yY
         kJOw==
X-Forwarded-Encrypted: i=1; AKwUvBxkufOFBikvq5jV12RdJkR2r9wic8xbqLnhu/qf+K2epwTSO+1dejBnt2FqZ2vqgHYX3jB4Les=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7oU7oyeFg+TD92BVUPPu14b5t/+Sb/tX3QXR6tjnBDptyg1rw
	md5cqG3fiDZLxGeMJxTVZBgQKpuqBagrmejydShK8uCBBiss1LeSsrQIdAKYCDE4rdGtByNDkR4
	h+K+lHtp7SUqCGCsvKJdj/3Yzuqr9Gt0=
X-Gm-Gg: AYBFou2TUWpffs/oxVFcNQ0nvEmw/5kexrNjyXxh/xza/xVtEWBkvnNXDHTwoCxuCIp
	4Sef5d5Uy2ja/00MaENnNoaw0Ope4knaZjL+Wx1iuv1UZ/QknZUQdl7wikDfdGxfZqv6ZkZcZhy
	hHsu7bEqWfYJrl/zffK/HZIcUR1WzWAueli7IGfT/Cy+fHF4ZWRsYRBuEzWbatSMIM8Ic6x/ABF
	7NlH8rDVvH4hpag6vmBO3V9pSMuCGvK5q9uWnvJhP7v0zE66ApkwHvkRAU+tkGlzbLtv9QEmgRs
	NhTSg+wtp3/PxUPvW3T7j1lr8Qra/U8BjKFa8owCN5A6hngcNldcV7l/TeA+0TdBzMCeJW/VA5M
	V5AL7PGFwTtPMtRKMuNG5//2TNahCcIom6u2JtdKBk7JdKBjhD8eN/ZYsMg==
X-Received: by 2002:a05:690c:7108:b0:8a0:76e8:c738 with SMTP id
 00721157ae682-8b1667b96bfmr81615047b3.0.1793118132815; Tue, 27 Oct 2026
 09:22:12 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027024609.117371-1-lgs201920130244@gmail.com> <c04f2ba8-fc83-4118-a26a-76ea8cbee518@kernel.org>
In-Reply-To: <c04f2ba8-fc83-4118-a26a-76ea8cbee518@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 28 Oct 2026 00:22:02 +0800
X-Gm-Features: AclHuK_iX4SH8qBhnH28MTM8xZlzfsclFjVNEOpTxXSJI2-mCXDyAbwNghV1urs
Message-ID: <CANUHTR_VjDZiG=igkaiy=Pj-gLKchTwA-OvJ4KjVoC-nDX3YTg@mail.gmail.com>
Subject: Re: [PATCH] mfd: hi655x-pmic: fix IRQ action memory leak on removal
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, John Stultz <john.stultz@linaro.org>, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 27 Oct 2026 at 23:27, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 27/10/2026 03:46, Guangshuo Li wrote:
> > hi655x_pmic_remove() currently removes the regmap IRQ chip before
> > removing the MFD child devices. regmap_del_irq_chip() disposes the
> > child IRQ mappings and removes their IRQ descriptors.
> >
> > The hi65xx-powerkey child registers interrupt handlers using
> > devm_request_any_context_irq(). During child device removal, the
> > device-managed cleanup calls free_irq(), but the corresponding IRQ
> > descriptors are no longer available. As a result, the allocated
> > struct irqaction objects referenced by irq_desc->action are not
> > freed, causing a memory leak.
> >
> > Remove the MFD child devices first, allowing their device-managed
> > IRQ handlers to be released while the IRQ mappings are still valid.
> > Then remove the regmap IRQ chip and its IRQ domain.
> >
> > This issue was found by our static analysis tool under development.
>
> More of postings by bot ignoring any feedback.
>
> Best regards,
> Krzysztof

Thank you for your feedback, and I apologize if our recent submissions
gave the impression that we were ignoring your previous comments.

We did take your earlier suggestions into account and subsequently
submitted a patch series accordingly.

For the more recent patches, however, since they address issues in
different drivers, we thought it would be more appropriate to submit
them separately rather than group them into a single series.

We certainly did not intend to disregard your feedback. We appreciate
your time and guidance, and we will be more careful with our future
submissions.

Thank you for your understanding.

Best regards,
Guangshuo Li
