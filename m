Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501490;
	b=tixXseWnAsoB9iXfvhhe36W+K6F6sON8O4QJNVe3Hdpqjiu0YjhErVXAK/XeMG8zx+AP
	 Sg9BekGRCIM8qiO2gzPXXtZsT1i4jjn0iiTzp6pOqfYFU6md735EGsAuKvU6XePi/AXsQ
	 jS9UgQkAQZXNVplejapBb5Z0PaYqT+4P8CqVEHsYDsCG65q7QPx9Ct3pbS82QyEpfeTHc
	 hgHLhIiDpPsDvOks+9UJPfOCvMQxe+rNnwPQRiMdysZ1kakAbvwUr7xYeWpEf+MuzE/Gx
	 rVDGXAu+3QahftFSOOv/07Wy1YYQQ6tmFCz7xLDv6+zRgoqZiH3ejOdB7CCRQ+xEecQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=TiOSNZMdnqqChU7eCmFOfWFFqcm5VOjZEu4im1R13jg=;
	b=i386G29hSzsRICGp+vK3tHsiKSfUYvx8iYS00LzEayMqszCGDiDN5fJUymiJQKLLjcEK
	 KSmQjTgOcuJ80L8m5g+jHFG0jq0sAXGsBLO/WVmq72vErziJDh8+iK0+Wh/T+iFYR781E
	 0w9nl8PqpJwUBrwV+HsdflH57Pcqz+AjZxb3qLSYnRBwBmYQBktBAwUZw+Iin8xDapCVO
	 YCaeaGRt5O7azpilo/645cV6Y/2iK10Pl/W5VGiH/0ReHGpYwQKCdVuJ2KiHmOA+4G6mR
	 xC9yAWn2jnLuTsfaeUPOcSD6lleKAmabaJYaauEd8CTXgdshA7PzsdWijk1l9mhTE3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YQ2yPgUk;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8C606A322
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FA8C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YQ2yPgUk
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab868fe362so3365970a91.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792501490; x=1793106290; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TiOSNZMdnqqChU7eCmFOfWFFqcm5VOjZEu4im1R13jg=;
        b=YQ2yPgUkImKwegXLNDHIcOX5JNJ/5SLVpdvaMABJpkZMluLNOhHThjsFMwD/G+Jk+I
         shoEJu/zVkAvDY8UoDqp+o424Rkv8BlJO1EQJ2gxFh7kiwFDLcLrgxhIOfUUrhvQyjJ5
         nVKeHcAnqJbWISOBFNHYp7hyRcFxu7W5CYER2mmEX30YScCcF2uc9JCPrr/zb8V7SifC
         sBNzOEa/UxaMBVw63a/wZa2/3zabZuvNothwnoHPQRNj8eViTxRtxkbHBKuO5klMZgzi
         6dqXe3PxAp+Me/1byDOnk+SQEJwSQrZRNkWi7mB26/B1iH/wI49G+lkDHvxIsFpMqWYA
         lR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501490; x=1793106290;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TiOSNZMdnqqChU7eCmFOfWFFqcm5VOjZEu4im1R13jg=;
        b=fQTkcBtPs+ehQU+SxslvpDuuGUYJ8EJUP9VNhR23MS368ts1JQLsQWX9RCgkw8S7KK
         8bFgMq3V/OxjpSQUUnpmky5AotQG/9XsIESwBy9Nh9Vwm7b2ISWN6BWKjUrEEnma8v3w
         PhN+X/PUeBD/+FAmDgeOASjr25ewD2VNcSDayeN4Z1v2NPzp01HYYZm7L+x+TdzoVwVH
         ZLl+HTupfbpmxJo6paNqpXjQh1gc2cehRfTMfZRpQWq+2CFoKeTyO2cVA9WCnih8tN/Y
         /sQveQVaEY5bUqz+jJVkmqp/eeCleJyvDJ6y4LeYAQOKL1e9fJFp4RUjDdgmRAVqRdP7
         IH1A==
X-Gm-Message-State: AFq9FYJYifdeNLUYJOv3f3bjJ7mmyHLFFnKBM+SQB8xvN9lesEdO6sTd
	kZpMs0fYVJrBYOT//ZLGu7L6zrahwoV1971A1lJBQshEdy/BxOzlaUUBDHeguynipj3OXsC6zZP
	aK69ngw==
X-Received: from pjdn34.prod.google.com ([2002:a17:90a:2ca5:b0:3ab:c22:1eb0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e85:b0:3ac:aa8d:19eb
 with SMTP id 98e67ed59e1d1-3acee29585cmr8240994a91.3.1792501489305; Tue, 20
 Oct 2026 06:04:49 -0700 (PDT)
Date: Tue, 20 Oct 2026 06:04:47 -0700
In-Reply-To: <20261019214611.404880-1-yosry@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019214611.404880-1-yosry@kernel.org>
Message-ID: <atdm23p9cUTG7_MX@google.com>
Subject: Re: [PATCH 6.18.y] KVM: SVM: Stop toggling virtual VMSAVE/VMLOAD on
 intercept recalc
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Kevin Cheng <chengkev@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <david.laight.linux@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Luiz Capitulino <luizcap@redhat.com>, 
	Matt Fleming <matt@readmodwrite.com>, Pedro Falcato <pfalcato@suse.de>, 
	Rik van Riel <riel@surriel.com>, Mike Rapoport <rppt@kernel.org>, Tal Zussman <tz2294@columbia.edu>, 
	andrew.cooper3@citrix.com, gregkh@linuxfoundation.org, sashal@kernel.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 19, 2026, Yosry Ahmed wrote:
> From: Yosry Ahmed <yosry.ahmed@linux.dev>
> 
> [ Upstream commit 55780d8a1dcc93d2c4b33c565ada88df12c9f206 ]
> 
> Virtual VMSAVE/VMLOAD enablement (i.e.
> VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK) is set/cleared by
> svm_recalc_instruction_intercepts() when the intercepts are cleared/set.
> This is unnecessary because the bit is meaningless when intercepts are
> set and KVM emulates the instructions. Initialize the bit in vmcb01 base
> on vls, and keep it unchanged.
> 
> This is similar-ish to how vGIF is handled. It is enabled in init_vmcb()
> if vgif=1 and remains unchanged when the STGI intercept is enabled (e.g.
> for NMI windows).
> 
> This fixes a bug in svm_recalc_instruction_intercepts(). The intercepts
> for VMSAVE/VMLOAD are always toggled in vmcb01, but
> VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK is toggled in the current VMCB, which
> could be vmcb02 instead of vmcb01 if L2 is active.
> 
> Virtual VMSAVE/VMLOAD enablement in vmcb02 is separately controlled by
> nested_vmcb02_prepare_control() based on the vCPU features and VMCB12,
> and if intercepts are needed they are set by recalc_intercepts().
> 
> The bug is benign though. Not toggling the bit for vmcb01 is harmless
> because it's useless anyway. For vmcb02:
> 
> - The bit could be incorrectly cleared when intercepts are set in
>   vmcb01. This is harmless because VMSAVE/VMLOAD will be emulated by KVM
>   anyway.
> 
> - The bit could be incorrectly set when the intercepts are cleared in
>   vmcb01. However, if the bit was originally clear in vmcb02, then
>   recalc_intercepts() will enable in the intercepts in vmcb02 anyway and
>   VMSAVE/VMLOAD will be emulated by KVM.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Link: https://patch.msgid.link/20260110004821.3411245-3-yosry.ahmed@linux.dev
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Fixes: 5a1a726e68ff ("KVM: x86: Use KVM_REQ_RECALC_INTERCEPTS to react to CPUID updates")
> Reported-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
> Closes: https://lore.kernel.org/linux-mm/arY1Wq6R9OY20ans@pcnci.linuxbox.cz/
> Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
> [ yosry: The bug is not benign. Since 5a1a726e68ff, a vCPU restored into
>   L2 (e.g. on live migration) recalculates intercepts with vmcb02
>   loaded, leaving vmcb01 with neither VMLOAD/VMSAVE intercepts nor
>   virtual VMLOAD/VMSAVE, so L1's VMLOAD/VMSAVE corrupt host memory. ]
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
