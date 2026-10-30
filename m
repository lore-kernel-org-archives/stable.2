Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394745;
	b=XT1Frb+7Dca1srZPJQxk/jOKkDLGFilmUiQEog1ldNENS5hp1uuc7aqf9BDHdp4cJkEB
	 EOULeWCB/73MTlxsZfQGnRcwBGtjPr4cjmbU+bAwBa1ScsU+E39kgm9QeBN/6hKfU7e+L
	 JShmFDW6tdBgw9er9Wan8nS4aSkfXL8POLSm6UlqiU9l6XGgd9q3OoWOXMUMDt+FJBHSv
	 ZpKaDJpwIis3X3YxfcwZuPn9mnzEjgAUkWbBoKzirRFmxjgyu355imt59RpVkt7eFlgx3
	 Ik8Dn3DeXzCAsXkr/ACCm2ELIIe+jJrK8KFzzc+BF3BqHv8nYYNarqPtEMPKGkAlaPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=FaBKDSZurFDBrV6Nw++HxcBhs9Np8w6Jcz9bdCkkKak=;
	b=RLtnxp17ghXHXaWIDXXnXFpoCUpROv4KbQd0mZsgEuxrvp8HV8jgQtTE2ltN6JbzYSpT
	 6RHAXUJB3hXKb/1vG/xur3YBdJkJepD2ztr+yNaaSP7WT59SfdZrueeVgcMGheEt+x1X3
	 dFdnwH33Ta/O1Z+pCYD0Tot3jNf/ja9rSewHySCw9YUovwoGT3TTGA82wSy2ydVzhCr31
	 uJ+eYaJk326Wj5gs9cYD6bxRWtyPKTuBmCK1ofO/Mq3BrhlvpYm98AbfSBBNIckuHiIcF
	 u7qhzAABMpOWj56+xo/ziuYmog3oPNb/TfNqx82B30Wl+zVDprrnsYHgGUYIEl1i2eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="a789mJP/";
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC63606A31E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 21:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABC63606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a789mJP/
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so1681270a91.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793394744; x=1793999544; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FaBKDSZurFDBrV6Nw++HxcBhs9Np8w6Jcz9bdCkkKak=;
        b=a789mJP/L010wTflRpqG+m0KAfDFeMS2dNFRgqrwWd6ACJMAZ72SCb5s2p5J0MbZxE
         0UVmA4ridzFKPfOnTB4MgsuXm9OIMpoYKIZXog2YlWOqfJkWIeB0Bye9iz0p47McN9Ly
         ovdtyeJOws6GdfjNkF7x/zU3ccQjbArWVXAN5qnuTH258+1j7bZJrUAAJ5w+gm4aqAc5
         ejlLb9I4Ts1KZZmW0wmDR/VO1A0H6cEJuUll8ndNMTMDrrm8UMeJB6q41wWknSRPJPJB
         yDw4vcwfW39iy+AZl0wW1P3QLTVRdqzyClkRA+GGWlwPLcpubB5u25vY92H3tRv4VC7i
         kZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394744; x=1793999544;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FaBKDSZurFDBrV6Nw++HxcBhs9Np8w6Jcz9bdCkkKak=;
        b=BdRJPcGHyj48An1NYVpToLMcV2kOoEs1+IILtxcvt4pL6C/0mJH0iAqq8RP4mgSo98
         NF+CXsUAyc3iaWd/ltmBqyRBzgYUptsS10XaHql20SHlBqXA/szwMVB+ftyM3Cr/vJSL
         4VuP4NqZwcj1zzrA9bfbd/mHGJRLQ44pqdFusXKvHq38ruIqNoC0gR8sjYx3Kn75jdkX
         saRdwAYQci+eaO21R9mscxCnPlME7xHdyCManAt9TOx2AJ53xRujxHZJt9Dr5ezPNAzj
         h2dPChCQR6HY9CpnXxhN72ldwrLiwSNMvRlAdYA6hQ29BHHkF5m1H5YXPDXPqiGVETy+
         0KSg==
X-Gm-Message-State: AFq9FYJakJJP9r0K/ZTFjRxgDXX+ap+YNexmuwTJFE3tiGcpxFfaC7ym
	/8JOhoCX6HaV887ZAcmIKwRn2yqg7cwoEIQuDXqNFnZaWFZD0+qpWNiCMcJcFxc5QBSVlAmy91D
	zayxWIg==
X-Received: from pjbgz11.prod.google.com ([2002:a17:90b:ecb:b0:3ab:2813:f1c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ec5:b0:3ac:a203:e0a5
 with SMTP id 98e67ed59e1d1-3ae897eb741mr3059575a91.11.1793394743896; Fri, 30
 Oct 2026 14:12:23 -0700 (PDT)
Date: Fri, 30 Oct 2026 14:12:23 -0700
In-Reply-To: <2026-10-30-1-daily-reply-0005-kvm-nested-ept-gva-6-18@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030103643.573356-1-doebel@amazon.de> <2026-10-30-1-daily-reply-0005-kvm-nested-ept-gva-6-18@kernel.org>
Message-ID: <auUINwzMTjKCrzZA@google.com>
Subject: Re: [PATCH 6.18.y 0/3] Backport nested EPT violation GVA bit fix
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	Bjoern Doebel <doebel@amazon.de>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 30, 2026, Sasha Levin wrote:
> > Backport of commit 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT
> > violation GVA_IS_VALID/GVA_TRANSLATED bits") to 6.18.y, with its two
> > dependencies.
> 
> KVM x86 opts out of stable by default (Documentation/process/maintainer-kvm-x86.rst),
> and none of the three commits carries Cc: stable or a Fixes: tag.
> 
> Bjoern, could you get Sean or Paolo to ack this series (and the matching
> 6.12.y one) on the thread? I will pick both up once they have.

I've seen them and they're on my todo list.  I'll try to look at them early next
week.
