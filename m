Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891527;
	b=RgcoVFtcZvQH4cHLk+JlblVAeSEkdkWEWQDWCeb0uu9LWhQrI5Z+ueKP10PVBobJJ88M
	 OKNyEd81tv/DBuZ6hYkuXfcuMwyP+DYxF0JpC6qerrBYrO5DhaHt5vWIzcaCSB6CDWgaR
	 rGeCulzJEUHLHvkc98bdpWcse9wctfkZoQsreSkdGwBOFSpGTZpf3cyc+m4d84eEJiuFm
	 bjQRxiwhhiLWxU4Kf8WcHd0It9H9uIGGfb04vW1XFb46Ybd6espG9zKWo7QffJ1RTZBQM
	 TohjlFrPKJOADqi+vrm8ALAhxLCnHqgTu+jqE58zS2xWAwhkPCWFdgWK7e6aife61ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=s0nutuVUph4b6cXq4/OVubQ7e7mF9JBGs/elhgXlqrs=;
	b=IYIDjjsfF7x8Z/NnfS1XwHZKm4umVOGYMPvsedgLqfgaA3rfXxHaBjO9Jiy+GxJXO9IU
	 1shvIZUr299hAwXyaI8I/lcs6NZFOtqLqlj+7gvgJn1lFxhE+UI7lP03STuOdesUT0zU7
	 s9hY/yndZ0KGHnJAcDTu/sVJJurjq/oBWt58iOY7K9vNB/LBLeZtfepIms9X7cI7ZvIOb
	 9bnZSyjS/BYFIAkIU4SUe/5z/u1aJMnYjaEghh891HvKtYQ5JEMc7ISh7/AYxlbinkPpA
	 XJFWWcISxoOjGtpYNAoh5o9FnEuOQ5leQxQ3jP+2wCMS+zc0p1T6mcP7z/Gl0pULd0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nZ0gBNSu;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B25606A333
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05B25606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nZ0gBNSu
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdacb64970bso1085995a12.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 07:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793891526; x=1794496326; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s0nutuVUph4b6cXq4/OVubQ7e7mF9JBGs/elhgXlqrs=;
        b=nZ0gBNSuYgqf8EAWhmN7bt5KB3cTZJE6rzFbV23i2K+jJL+pR/nNN2Gn0dqdN+Svm1
         xi/Q9zDLg7NMc+Juc1iX6Q/vflM4iZ7JXAXB8WBItuma9Fsqn8Om/iPGKwJFW3ec2xx6
         XslZuR4ngC7ieOZe0bqCXK1x+weoDxxVyyCbRcQbZkQ7hmsAUnIgWm92l+s2LzWst9hw
         ImUtWts4H/smfCS+4UlEp53WVNULBjW1Mi23sHQddtRz/14FjB6BJ2Bbaym5q3ebbZ5a
         9KeZR5npQhM7fdtfQcOeDa99DxC+ukC3UUeAdWAFMtKZLLGV1GJ5xJpYnfB+RwLLLGYn
         Wm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891526; x=1794496326;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0nutuVUph4b6cXq4/OVubQ7e7mF9JBGs/elhgXlqrs=;
        b=Oq04s+Sz39sP4DLdjl/1BGCUYG/BYJDG8XXQDJNYABc7FZtG3j5UTzSo0uJWtMJ28C
         OP9kS4SoW6xL2uVo6DBt06WFvt4mhPWWtfvAMj8/njo55PhA27+Cx3CytAqhPIOFBerF
         FuldtR0u3jc5gEyC+wGYosGNiRhpqCDED0Fj7AJ2mQ+CY77C+JOppF0OSotRONyNC+YK
         0xviRw1oARE7HCpUTeG/GBvNZ6j2EzgyMxOl1U2/fkhp538EjI2+GshHcoptyU/+4+Nz
         q1X/aCPl3nm6xpTTghAcUz7aj1n+tq6Hz6HHHLF9wQCyes3bF/EQQWuz1Pta1hPDnqZ/
         Bu5Q==
X-Gm-Message-State: APuU4Z8lMt/rDSDMRsOUgBFi8HTeqJH2QnBdvGVNEpRVOaPvBZQFly9g
	ZstdRZ7mZANTvemzglCKjdQ+V43VAX9NMkoHl65kmFpSoy4Cue4xN3ANivEebvQufVerKN4qiYy
	3u9N7FQ==
X-Received: from pgbx16-n1.prod.google.com ([2002:a05:6a02:63d0:10b0:cc9:f793:b980])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7487:b0:3e2:1a24:fb82
 with SMTP id adf61e73a8af0-3e9289586ecmr16267365637.16.1793891526076; Thu, 05
 Nov 2026 07:12:06 -0800 (PST)
Date: Thu, 5 Nov 2026 07:12:05 -0800
In-Reply-To: <20261105121320.2093899-1-xiaoyao.li@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026110458-starch-scroll-7508@gregkh> <20261105121320.2093899-1-xiaoyao.li@intel.com>
Message-ID: <auycxaqAdcO01eT-@google.com>
Subject: Re: [PATCH 6.12.y] KVM: VMX: Preserve negative return value in
 vmx_handle_exit() with bus lock detected
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 05, 2026, Xiaoyao Li wrote:
> [ Upstream commit cef48693da1e964e9f192bfc16cd0ed287c48337 ]
> 
> Preserve the negative return value from __vmx_handle_exit() when a bus
> lock is detected, instead of always overwriting it with 0.
> 
> The purpose of bus_lock_detected handling is to force a userspace exit to
> inform userspace that a bus lock happened. The negative return value can
> achieve this purpose, and changing the negative value to 0 fails to return
> an error to userspace. So, preserve the negative return value.
> 
> Fixes: fe6b6bc802b4 ("KVM: VMX: Enable bus lock VM exit")
> Cc: stable@vger.kernel.org
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260805034602.5B2BB1F000E9@smtp.kernel.org/
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Link: https://patch.msgid.link/20260819094903.3060020-7-xiaoyao.li@intel.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---

Conflict on the exit_reason field due to lack of 7172c753c26a5 ("KVM: VMX: Move
common fields of struct vcpu_{vmx,tdx} to a struct").

Acked-by: Sean Christopherson <seanjc@google.com>
