Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794641128;
	b=2PQCkm/Ne+mQlvwJ63MfELJuUtcSG2xHfP0PrBdrgC3C2/r4Zeh2ACPdjoffpTSgdR+e
	 IOrkFt+MRtwuuwRmqggQWQ3kw78aDD4XhuCW8+h2159fv8s1ZnDP5XXwCltDiVyXN5u0D
	 qbSN0kCJTKoBT2R4CdHaJ+lTZzWEBGAIv72wrYX3wumIcv5eYZRfT+UHRDChx+VTHPigq
	 xUMETYUqc4OOw6NiVbcqPzRffJUP/HsSBTuQ6Mrha1JvflkEDB+NIDGyGs1LjEPNd/AUg
	 F8Mil8BvIF3DVgqx/1YVHkxLePXjmDbslQnNGa0ZIwcFkbjbapCQeedOiOtnILRrK3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794641128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=FOpOMGwOLM8SRhOfI4bc8Q6VvL2aj4ajoW8MlVZKv38=;
	b=Lh3XsQS8fXocHcPtkUnCulDWvJPC74jnYTeRYFy6XleY8bBP5vcVhsSRyqQX3OT7gu07
	 kZv4AMj7SKYNhc/YzRGsYO6xlXWUYoyLgIAz204jbMmU3sYg09+jwuWW97Zeo8bVbA2Lx
	 Tji9TXiK0ugKsI7qSIliOygKqBOhvyo5hBKbeuu7dc0IRrik15lu1MYTo/cvGcvTB8rCV
	 CWOmxnJbqsO9Q9QlQRJ9FedSb6sxYAbvurYtc2fcJ7uLIrroLktUBKNoyfl5xiK7jFzlE
	 AM0mzqGw7vG6ubZGZoz/1hRWYGVXtlqG6Lri6epAXPwZ6osMoZ63aIsAR9sYLfYED8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=uEaDDz95;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE0E606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 07:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DE0E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=uEaDDz95
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-94961d90b79so63599885a.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 23:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794641126; x=1795245926; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FOpOMGwOLM8SRhOfI4bc8Q6VvL2aj4ajoW8MlVZKv38=;
        b=uEaDDz957LMgBdwavvtEYSujZ3m5D5PlEFFjYhpsPN7/NU/fwtpxznRDJ92m+i2WH/
         efCyf2vhCjQtXdPvaHbwridlNUQX53P6T2z4p17qPmGEb8H4z9w2Uq+mpCSPirx60vEI
         lgr9asU901PFNiNytOagMNaOy+cHb8To1w+7eP7DlF1kJHXsWfBYgkxhxHvD7mlDp49r
         Qr9hv0Ft7bA6ygSZUr5EVSIWkqCLdX1spYhWA9zMUXdP5+H5C9rNqLDP2X/AlMYKmIXt
         cJDyvWYErmX9LSQag3EZfnxW9NIaQBDg6BGaayzP5haJQnqaAPPkCbYpP0KTPN1BjKZh
         Ytbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794641126; x=1795245926;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FOpOMGwOLM8SRhOfI4bc8Q6VvL2aj4ajoW8MlVZKv38=;
        b=To7YSvKfMkPJtKd1aktH8HV0oytVR6+A7r2psRe9MBSdOD8MOqIzqG8lstazrdw6y6
         YjgGotPAgM70bZNtSR8hqfyruFGQLDI1Zo//ua8pWtp+PuMpsOzUuGdfAzPWfdLH1z2n
         p79EoYkRA3ky/1LxxRH3E7RJhmoNipSTqw7c2busoQ7M3iQ2fuyjpBfpKX+ZxOzmdNNe
         v+BgbREoxJhrt3RyTTKE3fQEPgPA99+yiof7SeYLTSReXuoDsMURHQINLkbJeMJiQQtK
         XvNEV87OZ5dTML5A783L6XWUcNjazJqwc1e1O148B2ozY6VR1cXKAigyM2KlgCOFtvGC
         NKqQ==
X-Forwarded-Encrypted: i=1; AL+hErGmHPNniDT/j5DFYiZrHsfCLQPwBM/zeL5g+Ab7w4Z05sgR1kLztYfCa3Rx0Yj1I1yYmly2xQs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oWFfFZ31puCHW1swzEPuGKRH4zzzipjpvIL3Hccf+a+GuybAJ
	Fnpmi2ZXvEmelxVKTkMhI3ScYrd4II+6SugEhrZ5O9OD7HNnVPoqEkck/iGMmKE6SSLhKftLX8P
	jIZc6
X-Gm-Gg: AYBFou04H2wWl9j96+JZeYRecFCXo3eR59CzDovYjgdXuWuurT1WnJFKoThtz8Nbsar
	ad+wr9/rTWrxIHnUDNeeZbcw3Aj8r+SPKXbjQaRw46M/Z72x3O/aOkEZaH/fkHp34z3vNf6r0CY
	HdcYmIwiSuMyo62lH+rjQRvK1rfEDxI0RhjkOhtGJD9WxVvG7+qHe8VRjDtA8RvRWNveCOgpYDI
	KJ/bH8pIy0HXaBbjxzYkHl527ORpWEwK38ncgldoyfQCrOEmTSy2o6oyCN28CXRqj1evKcFeuq7
	tySOHMvz/YagVyeosQW6dBiit8UgZlrZ9yA2/wXUXtfF8cnkQSUfdN04AyBH/1VEJ4YksxmVHkX
	0rNn0gGWA6zAkuLAmYI5717t90aropYLcXeBoSHeoza9xiMFFehpf5tECSpdUaFzWisBj8V6roZ
	5PlBnJb+JFLP9StMm93t5/WW2UWx1KzaQIF/YYA8OYgcpG4g7P0+5M3xmhFLKyBlQNclyyQEqHf
	AOY8HXNpqpN67WTz5s5vlQdnk5KR1GTzIeEk/SUnr9Vxr3RD+Ox1NkVztzcNEKDzeApKXmmk24I
	ICwVz51CbKTgfD5pe8jfs1kD2BhFf6dpEC+ldJ1D+J+yK/TrFYPHM1zcR9ms+1ZLHMXoMNeacGp
	yQRqzQnA=
X-Received: by 2002:a05:620a:2a06:b0:93e:b0c3:388d with SMTP id af79cd13be357-9494b9432demr830714785a.11.1794641126492;
        Fri, 13 Nov 2026 23:25:26 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c803abbsm351077885a.7.2026.11.13.23.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:25:26 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, leon@kernel.org, 
 akpm@linux-foundation.org, david@kernel.org, kas@kernel.org, 
 dave.hansen@linux.intel.com, bp@alien8.de, rppt@kernel.org, 
 stable@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
In-Reply-To: <20261114002027.GE3706007@nvidia.com>
References: <20261113195536.2660763-1-gourry@gourry.net>
 <20261113200303.GA395967@nvidia.com>
 <179460249376.482102.14669935557901467762.b4-reply@b4>
 <20261114002027.GE3706007@nvidia.com>
Date: Sat, 14 Nov 2026 02:25:25 -0500
Message-Id: <179464112539.482102.8723246686117488051.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-13 20:20 -0400, Jason Gunthorpe wrote:
> On Fri, Nov 13, 2026 at 03:41:33PM -0500, Gregory Price (Meta) wrote:
> > On 2026-11-13 16:03 -0400, Jason Gunthorpe wrote:
> > > On Fri, Nov 13, 2026 at 02:55:36PM -0500, Gregory Price (Meta) wrote:
> > > > HMM can grant ordinary device write access to a userspace shadow stack.
> > > > On x86, pte_write() is true for a shadow-stack PTE, so a populated page
> > > > can be returned with HMM_PFN_WRITE without taking a CPU write fault.
> > > 
> > > I'm not sure I understand this? The pte is writable but you don't want
> > > only DMA to write to it?
> > >
> > > Is there something special on x86 that makes the shadow stack pte
> > > non-writable by the CPU?
> > >
> > 
> > Some of the context is here:
> > https://lore.kernel.org/all/20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org/
> > 
> > We had a similar issue with migration, but this should handle the DMA
> > case as well.
> > 
> > It's "technically writable" but the kernel is supposed to prevent that.
> 
> Bah, it's not writable at all. The CPU PTE has write disabled and
> someone thought it was a good idea to make pte_write() return true
> because the CPU allows writes through a special instruction on this
> special PTE? So now all the places like this think its writable, when
> it really isn't.
>

I completely missed this, that will teach me to trust pte_write() I
guess... what a bizarre design choice.  I'm sure there's "reasons".

> You could also fix this by having something like pte_real_write() or
> whatever that doesn't lie about the write bit in the PTE :|
> 

or rename pte_write() to pte_fake_write() instead and restore
pte_write() to its former truthful glory

:| indeed

> The patch is still fine, in that it matches what everything else does,
> but I'd include these details someplace..
> 

Thank you for taking a closer look, I think Andrew's changelog
adjustment is an improvement if you're ok with it.

-- 
~Gregory

