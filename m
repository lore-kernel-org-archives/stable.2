Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642101;
	b=xgXSGH2yZejjrT31HM8R8aNOpU1B0ozG5ZhlyNELpf+8dOxfJbDnC1Qp/+L0nXdJYe3l
	 RPHzEjMRNxpwas+GicbRgv8QDg719WDFGocSc8tz0RgNXtn8kWcJ+0NpOw4MB7Charw9O
	 poQxOCSCR7ZwE6aDyf0bjTR+TdU8DeiDITyvhqJf3s6UoRNBaMc7J5Mgu6N4Jd6nOcpmt
	 97u2xCLtB8CH2cawW+83z7FW6gFYijTpXVX+FHBiYp55+diGgapAcLx92/kj7o93nEXkF
	 DSJhMHJMvNKPBlB+7E1EIWbWN101oLNvU3dTd0UYr9TBg2sfgRnFaQkhgdZ5i3XTGLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=U4l9yfaXeZlkaGd151Z0zPjN7E7u16Al8j7C9HAa63o=;
	b=ELEdxFlZMEEkDIIspPO/hRjM3fKn5mSgqvGbQwl3mJpZJV+Qv/U10/gfMZpCum5P9amS
	 OVkekl5LeduNDfuCEHnkZsf3SFZwCRf21+gvA/QJi6CyN/iDaefos79thCApywNG77V9n
	 ZhiFnnlgzWOIS1xlTZU5OkfXitR9iJTPfEL2EqZVLw52OmcoQqxWEPHwbCKMjygwVlthd
	 FLUbkMwpJpOoGnoIF2OZMDxOgkiOhndrn3h+GCUuNoj/Kh6aITIIsTFtRtoS/+V8ZIqcw
	 MmDbL4go63w2m7XVOu+DIpYFy6+tRxUJehXkRYec20KcAtNOhzJK7nY8UdkqoyQWagA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BIrDgVS2;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FF7606BA54
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6FF7606BA54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BIrDgVS2
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ade5b3ae97so2721860a91.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 09:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793642100; x=1794246900; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4l9yfaXeZlkaGd151Z0zPjN7E7u16Al8j7C9HAa63o=;
        b=BIrDgVS2z3qzeQ5pQ9I0pkMVnSSs0kJP9FikYmDOjk06hi8F2fPQhmScTZLO8L0cWw
         gFOZBG+8fjryAVdYL9Kb6Iodfp6dzzbEmoYHWsXO4RuMayVLbEdpu7n24yXahK+CdH/M
         zkxM3jjnKKMDEdiZLa0dq3TzRM8R8fi9WpalpJznZ8vjNrchHYu/fVg1CXxkKI3ReeDU
         Z7HjomKzwm1J2I4ZTS0tR9I01uAQK0SCHfwnG3YwTxFMMakluHg9GkHKwNFybZgAmWRz
         quSSdtKHvknwDRVRGsSz02E3xVggKpyR7+GACSqx16g4vwPX14MSicxrX/JszWiyh9gp
         hs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642100; x=1794246900;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4l9yfaXeZlkaGd151Z0zPjN7E7u16Al8j7C9HAa63o=;
        b=HPx2yUKbkjC8qgo/zKnRjdMk0lhHXRhZ7yQuNzPirWqv5n7kj0MPVjiporHYDz9DW4
         SjRysjEc/TaMSXSeOZTBl6Z8IAEwRfKw9vp5/DV9i+L9ezylfyLINZjIHKIJK4agodSB
         40KaD/EAsD29Hqu1isambcLVCymPnHa7SsTNYoKWuw2SIUjkkPMqymed8tehhY07xtZ6
         DBdGDZwa4Gnpkk5iqUTJcPji1lhr5a6fL9HlQf9sPE5uX6i4/ZeQF6Dk9zj8YLPQLkse
         VDG0XfRv5fjhR+3s69N+TJpy0HTYmcoeEhDPfzchT7lwMvgrttiosBTFP44yiRjs7utI
         1eqg==
X-Gm-Message-State: APuU4Z/Zb73z0DoPHQLQvRKx7Cqp3IUYKJuJ+8JOZQV1epO6SZgzrFaO
	mE6k8t/Wd9NUOsMbiTXrtIyg0Tln7YznuF1eFmGs0JAky9gepgGzLVtwUc1mvvJunGIR72bZnBx
	WUU+DVw==
X-Received: from pjbfh11.prod.google.com ([2002:a17:90b:34b:b0:3a9:ccc3:cbae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a4c:b0:3a4:7195:ecba
 with SMTP id 98e67ed59e1d1-3ae8972d1d8mr4920521a91.20.1793642099792; Mon, 02
 Nov 2026 09:54:59 -0800 (PST)
Date: Mon, 2 Nov 2026 09:54:59 -0800
In-Reply-To: <2026-10-30-1-daily-reply-0006-kvm-nested-ept-gva-6-12@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030103713.573783-1-doebel@amazon.de> <2026-10-30-1-daily-reply-0006-kvm-nested-ept-gva-6-12@kernel.org>
Message-ID: <aujOc5ybL-lZEW8v@google.com>
Subject: Re: [PATCH 6.12.y 0/3] Backport nested EPT violation GVA bit fix
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	Bjoern Doebel <doebel@amazon.de>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 30, 2026, Sasha Levin wrote:
> > Backport of commit 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT
> > violation GVA_IS_VALID/GVA_TRANSLATED bits") to 6.12.y, with its two
> > dependencies.
> 
> Same as for the 6.18.y series: KVM x86 opts out of stable by default
> (Documentation/process/maintainer-kvm-x86.rst), and none of the three commits
> carries Cc: stable or a Fixes: tag.
> 
> Bjoern, could you get Sean or Paolo to ack this series (and the matching
> 6.18.y one) on the thread? I will pick both up once they have.

Acked-by: Sean Christopherson <seanjc@google.com>
