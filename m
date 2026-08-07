Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE18286D70
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111903; cv=none; b=XhNHZJbnBH6pig0aSX0n02Dc7+fyCpXmud6bugb3xEstyK5JcHsCnOw2/LYltsoEUIh7hqkIKhJzST1aLPyrK5TqV9b6p8RFftZFGxephtKXeWgzvKTTXxO8f0vnAZXZCNAsV0nOyVwDNroGzrHUmyITVFVUOtxaHOfiqsfvBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111903; c=relaxed/simple;
	bh=wSxVRXPayQFZL2Or1DKkVoNQv3x5/H2PNAbaoULWcZo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IsbqILwxfJ95ZUDls8Gjz6YLcT6YqWc5UYPL5F3SO1Bp94I4ygjbFI3P73rWxIl9qAIAj18o/OCH1hD6EvGXuWRu4hcjvTPFAeBx3k5nQyLy2gNUPTI2sSr6R3SQTeBdbV51Zu7cM3LmV0A/kdc+gTUJ4ENRB1XFb8qwRKXfadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FWFmE14O; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWFmE14O"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb733fc5024so4772529a12.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786111899; x=1786716699; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cUK/CN4zZCrXo07AjY1uCS28FEvZBeq6g3hx3cmp4/s=;
        b=FWFmE14Ohz45mULgq6PuY8BGn8Jp3iWlAIhAPkbJ8G5Y8GbpQzCeg9hoEOghN3C7AE
         Mse++8Vr0vyuGDsneH9/czaB/MLpm9CDUlIR06utX9lK6lbcHhk8Dn9XAc21S+gckogk
         F0a4OPkYdE7FYxAShEUrNA2Si9jpjyjKthRU1WZY5LbD5aST8CE8RLLcKl6zQgV6Dv3P
         sak1IG8e5HmPCP7FltN534ICgHNlmNzn/6OedgOaKGMbjU55AnQJF//bccZ6Ne0W1zvm
         z8z5nniHFYXTScxuRPo30zmarRwYQ/AhzWPuZ+DvS11/oOmXmx1ZtqdSPXSVdFhgkIjS
         RZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786111899; x=1786716699;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cUK/CN4zZCrXo07AjY1uCS28FEvZBeq6g3hx3cmp4/s=;
        b=OyEl2ZNxXsjuxjI2ZFqGjWrL4m3ChPEBjxuwCRPvon1KmxHVHVGFL4k17UWgDA1I8Z
         hOj6y0IkcOcVK8sZY4VdZRLRMp33Su3kKBYqxLzCxo1r5ZhvpX02SRTlTkwxDVWeq6xU
         kx1cPqc5jumaq6pkq+1KI7S/4EdOG6H8t2W/GBFF+/XqPyNVQckmRjzaeBCaxnmBncSq
         vhey+d7hAlo5uncjSQkwTyuukpzBjfHmG0foDHgauLkO3Y3ijaxJcyO+xUPBKWXGAlgo
         DIfcWgPgf1kUeeRyz5OGHnXnM1CGOrA9Ty7lo0lcxiBhN69kC3Prn8I4LH8jC4+fIChe
         s/qg==
X-Forwarded-Encrypted: i=1; AHgh+RqlFUavGYoJLSaBA0SraMz81vrjDSXz6WfurfTL99BeAFdhOE0iSU556V6w87IWJfLGWcbMNmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbUMrfHD1peswalSeu3I2q5QnuNUnjhPzg5G+GUEoC6UzxGXiw
	K3mQQ5SWlYiwkbCa3k0YLjG+DWqoGiSW+2tarVxp6yFv43Jc5E2wWVKr3L6z6CTg+sweNmfdo8F
	nizmOOg==
X-Received: from pgjx8.prod.google.com ([2002:a63:fe48:0:b0:c9a:ddfd:b879])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9595:b0:3c4:36ef:3dc9
 with SMTP id adf61e73a8af0-3cb85e45aa3mr29843874637.17.1786111898994; Fri, 07
 Aug 2026 07:11:38 -0700 (PDT)
Date: Fri, 7 Aug 2026 07:11:38 -0700
In-Reply-To: <20260807071934.786879-1-zeng_chi911@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807071934.786879-1-zeng_chi911@163.com>
Message-ID: <anXnmvp2_Rj62huS@google.com>
Subject: Re: [PATCH] KVM: Remove the kvm debugfs directory if kvm_init() fails
From: Sean Christopherson <seanjc@google.com>
To: Zeng Chi <zeng_chi911@163.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zengchi@kylinos.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 07, 2026, Zeng Chi wrote:
> From: zengchi <zengchi@kylinos.cn>
> 
> kvm_init_debug() creates the "kvm" debugfs directory along with all of
> the VM/vCPU stat files, but none of kvm_init()'s error paths removes it.
> If kvm_vfio_ops_init(), kvm_gmem_init(), kvm_init_virtualization() or
> misc_register() fails, the directory is leaked, and none of kvm_init()'s
> callers invokes kvm_exit() on failure, i.e. nothing papers over the
> leak.
> 
> The stale /sys/kernel/debug/kvm directory isn't just cosmetic: a
> subsequent attempt to load KVM makes debugfs_create_dir() fail with
> -EEXIST, after which kvm_debugfs_dir holds an ERR_PTR and all stat
> files are silently never created again.  Worse, the leaked stat files
> reference file_operations and stat data that live in the KVM module; if
> the module is unloaded after the failed initialization, reading the
> stale files is a use-after-free.
> 
> Remove the debugfs directory in the error path, mirroring kvm_exit().
> 
> Fixes: 2b0128127373 ("KVM: Register /dev/kvm as the _very_ last thing during initialization")
> Cc: stable@vger.kernel.org
> Signed-off-by: zengchi <zengchi@kylinos.cn>
> ---
>  virt/kvm/kvm_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 45e784462ec6..8a503ac1adbd 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -6553,6 +6553,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
>  err_gmem:
>  	kvm_vfio_ops_exit();
>  err_vfio:
> +	debugfs_remove_recursive(kvm_debugfs_dir);
>  	kvm_async_pf_deinit();
>  err_async_pf:
>  	kvm_irqfd_exit();
> -- 

Already posted (twice) and applied:

https://lore.kernel.org/all/20260706095910.39798-1-leixiang@kylinos.cn
