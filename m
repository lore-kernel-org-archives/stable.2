Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C4427F8A
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799403; cv=pass; b=YuamT0L3Gt64alicxXTU9GHy9cuNny+XpeB04KpcQQ0BjcHc7v685Cnznboi0OuK+SPgI+lG3Q89Aa0Hxar1LuqINUYk9u9iZIoVnWgklxybGlN1EzWYQwt0ygAOPDZpU1GqTRomlZdtpHv51hP2bHDEa7xwSJ/PKEfQupG+lU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799403; c=relaxed/simple;
	bh=EZGNhcqgUnwW83gGUkPBKpJaBHTzmSvMT2dUzM+pahE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fm1/VB8f1zdOIm+pakNozDH6i2vp61fcc72BzvrVOeCZq6B7iVwLG6F14v6+NAx4K520zx4fisohaGLaoTohTpxUWsxHm/lmKIa7n+ct0ISo5YrqtKUJiw8PuAt16RGM8V/DqW353reeZfTpmfLwT3q5Q51u69sLF60zq1pGCgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hO80INum; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6jXOynr; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hO80INum";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6jXOynr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784799399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwXX7ybw59MrEfjW46n2RiydBB+VMvfOqfK+ooS7ixs=;
	b=hO80INumXOt9E74IB5fWffWDWDWoirDka7wVmLL0K78E7qO+aosquw6X8s1LEfj/t/nno7
	5ZAP7fLPVtJ0TjYU1F2MsUf0WDD3J111zoXFGbFIOpP//fAfZvOLaP5jwn8gKehP8X8hVo
	0Oo3gQaKgs1JT7OsDPjjJbIEOA+atPQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-Xeky9X5wPGK2SiFP9U3EhQ-1; Thu, 23 Jul 2026 05:36:37 -0400
X-MC-Unique: Xeky9X5wPGK2SiFP9U3EhQ-1
X-Mimecast-MFC-AGG-ID: Xeky9X5wPGK2SiFP9U3EhQ_1784799396
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47485fde05aso280585f8f.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784799396; cv=none;
        d=google.com; s=arc-20260327;
        b=CBzJDSsSXOdhiMPOknjYG7a9WSfBw2XCaLERG55V3gmsGr0rOTSz8M06g8k3SthsDf
         W0bQ6A4eKi7OIR+hwU6vjR5AFmP43ud5iOjMkJp5vZyRkkkZBhWp/Ib5hGcN1dtAeLYy
         FhyyzByPiAVzONH4Lqm5cx+X18ZLz03+HV57lTvjah46JkzYuj0lyXKsGf0VrugW84E7
         +anfBIt8ZUjwpmZsRtHPcd9XKcub5fV7F/jzukDbRL/SCTcPTGMinFcwtg0LVcxk27uM
         QGaRdpfyWp2yL6x1j21yK4W9K7gl9dFx1KyLkHh2NtFC7HMdHCxV5DrcnGZAD55E5pem
         CgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AwXX7ybw59MrEfjW46n2RiydBB+VMvfOqfK+ooS7ixs=;
        fh=rtCgIQeZe2MMyAivY3/D6ZfaR7Glltc3vdDD99O+++k=;
        b=MHXUpUMGPJdRYR2pV4K2hpb0s2EFeYCzd6+HaYTaiDCm9l0ioEMtdFeh2MftWvR7xI
         TPPLzLN9I1tTjUGPRhr46DxpQH/SVhhGZouX1jBFVAMpUpNnNCDyQSRiAzF+VM01UvNx
         mjiwX7pVcQwkimHkSuTip0ywLFR1hU3Wxnu8TY8YljyNsa7uDi9KTQJkSeWEt9wPfLGD
         r7kGJmYwva0YUfwclg2gsXiIo6Kq4QCx23Zihtxoci6Ff93idyqpp8isx/i6IJzu2qlo
         YWULcQ+Dxv/VAN1D+AKfwPjYD761VztsS6evepAsgAmouMVrjplsPGqlC0XG398RywPo
         ux5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784799396; x=1785404196; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AwXX7ybw59MrEfjW46n2RiydBB+VMvfOqfK+ooS7ixs=;
        b=a6jXOynrBOGX00bgKV3qyHzWnjkz3RpvFTTutDG7IWNRQ+zGRbJaa3gwzjSfal34DY
         tQjfqm3fRwl5FccmVBJ/a62Z8WEgE/XO3aslXLTSY+W20H4THlketCHRQszj3HZzqDsL
         RnIRfeGpyW8NHVnNRXSfgjMvTp5IAOj8k8WyjvZnGuaBmD3klIris0I0crYLafyxsU/f
         FrYsuCj08J8sXpBPYadTPO3qLRWZrst7/rRrn6UggjXUE+Ht55rgkRqboBvDkUZmxWgI
         0/lafQI3p0x6HDqxPxDDQiZVGmEkBVvL69w03DQNM74pO88hb9cIIUI83zUrSTEf6o36
         isnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784799396; x=1785404196;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AwXX7ybw59MrEfjW46n2RiydBB+VMvfOqfK+ooS7ixs=;
        b=tG4kZtw0nWbOddyiqNKDU9X6kPC5gpIEV4w0eD2tYXlIMuIr7/qrN1gB3Fi6aNk25I
         FcFDp0xa3WVmGGFiuClxyk1ZajUPoeFbWA4roD9/DoxEjynNI074Nu8LFACNxM8K1rAK
         skhK6IAdxzyiOBbQJqr3r7utJ1gmc5jvOLMjQ+fGwDYszYGwax7sjRewedT8fmQLbjHO
         6f+XmKvuRl2jLL+dY+rWyPGko3cRe+j5TlRaTw9q+WWfNB+kpEyvrzpIOmuePpD08GEs
         1M4sRYMHNJfdQQTnlVtm7O376VCJuwuqg/8YbqJ2+LGGILbQHQMWLanf8hiLrReJNgdL
         7KTg==
X-Forwarded-Encrypted: i=1; AHgh+RoxHjOnh8fsmov6R9hKnmxrX05FssXiQvvSOUJsQGNxexV7rLGuBObe4gUnyv6aGsCerZ7IEBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/G8hlTfmcO0gzJV/v9BaYH9gYk605xMSLyoGCuMk6VimcNzTd
	jJosZSz5VD/MmVZ5JdEvG2oMGYc0AFHZ1j1t4Lxyv05eZWfy31Ks9tcVabY/x9RDDgzL1HvXnL4
	XPMlmeOe9wgzmMK6wFAUM+Dg2OMyxZCsliOOjxNyphg1pbjWAcw4E8lbojJdJPRjerGm97uRTK8
	pHZiQww1SLy1zSqDuCytKKSLwgFWrqw3xt
X-Gm-Gg: AR+sD11Ej8HdX4mN5VE/cltZ2zXWv7r8A6+S4ysosybdqs4YSdaRmWVW3e5ivWVcHOa
	O/eT1MDFk8WyVVk36CfyDUtNJSmj9D5SJ/PQ2f6DB+6KlfbHZLuL+cISuq+TUo5LnyunSOO0BW7
	vZGD+9rtBrvhZ7cQyyT4RBDjjGoygSEUMQmNQhhdIaszdgzoMNK+BJHcTllQhFtfmWjnqC057CT
	kV5Qa7MiB6G/0qFT3l/6sz1b/2wP/WcZCD276ZylpMASDBlL5dG/iTSJzlN
X-Received: by 2002:a5d:64c5:0:b0:47d:ecaa:3f60 with SMTP id ffacd0b85a97d-47f8dc84a2emr2656906f8f.46.1784799396104;
        Thu, 23 Jul 2026 02:36:36 -0700 (PDT)
X-Received: by 2002:a5d:64c5:0:b0:47d:ecaa:3f60 with SMTP id
 ffacd0b85a97d-47f8dc84a2emr2656866f8f.46.1784799395678; Thu, 23 Jul 2026
 02:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amG2CyrA-yEUmHqV@google.com>
In-Reply-To: <amG2CyrA-yEUmHqV@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Jul 2026 11:36:21 +0200
X-Gm-Features: AUfX_mwJVC1sF_eo_yIblF02erkmt4YDe-alY26DWSfQQO-NWTWBUMYS85TGj0c
Message-ID: <CABgObfaKqT0gMUB_XRP5DW5HmpgaoTgmD-A8_zQVG2Vp5xZE4g@mail.gmail.com>
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related issues
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il gio 23 lug 2026, 08:36 Sergey Senozhatsky
<senozhatsky@chromium.org> ha scritto:
>
> > Sasha, Greg,
> >
> > this is the backport to 5.15 for the above CVE.  The fix was relatively
> > simple upstream but only due to years of refactoring and cleaning up
> > of the code; fixing from scratch is not really feasible so start by
> > applying the patches that are needed.
> >
> > Please apply this instead of v1, due to a missing line in the last
> > patch.  Sorry about that.
>
> Sorry for the noise, has this series stuck?

It had a regression and while there was a suggestion about how to fix
it, nobody had time to verify it.
(https://lore.kernel.org/kvm/20260630223723.83727-1-zcgao@amazon.com/)

Stable releases, especially the older ones, are best effort. If you
want them to be free of these vulnerabilities, please contribute to
that effort with backports and tests.

Paolo

