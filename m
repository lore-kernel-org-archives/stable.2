Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EAA4A4990
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999607; cv=none; b=tOwRwbwZNcM9eDO+9TEy2FzksbGRe4I1W70NF6pFA2W8xVARfmSQjNHgcLcjrSt8IevIZthrDUnsQz6PMVQIpfFt2HQ3fFI7cDRHO9DN4z052MRKhVufxLVe56mA6mhGpQC4UdOoj0Hc+RoL6Dvet0sJfZ9KB4XKz62Xr89+atU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999607; c=relaxed/simple;
	bh=fpBLmgxXsUTMAxMvhlHGt2eiOf23VOCv+d+5hDTfupM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NU5hYX7Yic3UjJC+RmZQDy7FUzFyXjiKCMQmTutnYllSgnwbH5TDVaxinE/UykpD7CfKxgbsLqPvb0LGKJhpc+OGRGtTeJScOyGUZGLzcNHwcuIPAtLgNOOig8UacaDVCTrctp9Uo0xgbsqwQoSAT4zJ/s6SuF3xXwBPRkyxVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxKv6jfI; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxKv6jfI"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso3658061a91.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999605; x=1790604405; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OiGmBjrOtgjkXABDPlqRosHtZi2K9f2nnRWisetnxbk=;
        b=RxKv6jfIzQef28U8fv2T3lEj6nEnI2ecfrfv5FvxWCuWroevzrGLxrlwtxDXt29L+I
         0B8j5b7N2fz7u1DbCkUl8abI3Li8a9mAIJWI6O/JyA+9zrejH4rTA9Wz6iNAop3BvT31
         bQxth/c/oKzMkioiy7RcALEXVikKIDxwiKiClnWABvXAC6YMBDy+VfWI4ZaijeUHBd8s
         GsriBXERapWbFTNxrDInrKHyiLxCo5OHBPA+JieXK7sDYU2JsWaw4NH5LbWAQSa8uSJA
         jX3MLasQmn/2FPI4bB1KDZRxP4eGsiWlhkgJOXeH+vzXHnVc7NPMciZLLqPXrJNt+DnR
         KiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999605; x=1790604405;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OiGmBjrOtgjkXABDPlqRosHtZi2K9f2nnRWisetnxbk=;
        b=CbKu1J4+0LDV5/3fGcoYfHZGFY8mNHZ33DMVuy4bY83sFVuFn9tee/6pqqqQMeu1+a
         np50hW6UTnYw0c8SMYne/FU6zif1mxMfZSEzg1kML9+zSqxdDRn47S2T5I+jVc8ojWez
         Oh/WOg+tWroI71KChdX4lFr7tIJx6rnQY740JIm93nwIptTejvLhlnPyMrFbJ9qSLwB9
         39HsJ89qprUBV50sUrwxCOiJqO/MfbzfvhsRjGUy2y+6TUFJ3puFvBvHYLppA+m8HFRn
         X23IPFboi9ukLGiVijkGc6O497Y9zIszqOazoCSOFyqccX2GleRs0uMwq5HXeH+eTq8x
         4JBw==
X-Forwarded-Encrypted: i=1; AKwUvBzWGjaGX7RMfIWt4HkHjQ2PrfGfgDRhYakTn/FHsG+oGVvG8AkyMAmfX5X2aUVqFJb7R2HBC9o=@vger.kernel.org
X-Gm-Message-State: AFuF++nBn7kARhggFCCRGJimgdF2LaaTC81xllX8YfNCvSgZ8LZPOaX/
	fnWw6f4nZVhV7Q53MZOxu9pqiOvbDvVfdQGbQlpGUtvcKa6yPZUEJ1mPqrW0UHM24yb6/f7Xcmw
	CGQkBRw==
X-Received: from pjblc7.prod.google.com ([2002:a17:90b:1587:b0:39d:9543:35b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3909:b0:39e:248e:fdeb
 with SMTP id 98e67ed59e1d1-39e54d10e41mr16431189a91.19.1789999605212; Mon, 21
 Sep 2026 07:06:45 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:20 -0700
In-Reply-To: <20260825183924.237727-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822190224.3788887-1-nicoyip.dev@gmail.com> <20260825183924.237727-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999885970.741699.14696191820725166112.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: Take SRCU in kvm_zap_gfn_range()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 26 Aug 2026 02:39:24 +0800, Chengfeng Ye wrote:
> kvm_zap_gfn_range() walks memslots and rmaps and may drop mmu_lock to
> reschedule. Callers that do not already hold kvm->srcu (or slots_lock)
> can race with memslot deletion: synchronize_srcu_expedited() does not
> wait, kvm_free_memslot() frees the old slot and its rmap, and the zap
> resumes on freed memory.
> 
> The VFIO noncoherent-DMA path hits this by zapping the entire GPA
> space without SRCU. KASAN reported:
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86: Take SRCU in kvm_zap_gfn_range()
      https://github.com/kvm-x86/linux/commit/b59a87c1ba3c

--
https://github.com/kvm-x86/linux/tree/next
