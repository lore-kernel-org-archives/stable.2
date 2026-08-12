Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D4383325
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518724; cv=none; b=KwEJpkZqRsVx2pz8Iv320B7vpaaJjjkPDGrdkmGNEtHZ38oqLHBs3cT98ZAd424R7LqVl48dANCnmFQliWxP2cglGYn/63OGr5/t2zAy3EhrSPH1blspzVq7OztU3TLs9rnVgDhFTUuK5KFh1Tz9FpEAfxHzssZvVgmdbyRRruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518724; c=relaxed/simple;
	bh=CrI3OpLHSAxsqbXODPZW/jZ+7VMhhwpc3Rou7vBDeMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpxhoGE/1hdai8hxBFbDEcASQ1Rh3cMh/C/EwMMW086CDnKvaM79vA5ydarV0f8OF4d+Q+2T7KzGEc08POpSWg8OkHgOA15bL0BZiooGHI6SgkbLriFufNojkGxG/KhlssKREWTzbsztE96t4XGgGYmn5vHFPlWGvsF1QDUqUGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRMeopLZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRMeopLZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4956242332dso5280005e9.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786518721; x=1787123521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ouvszPao5Ux2F9c5s8+eYsNl8h500okHC9m4E2BNeLw=;
        b=MRMeopLZ1A2AxQfOeEBz9AbetH9wL5zAPzjdhxqQLjvd84l9XEgpmZYV5IxPVtJBAi
         ly8Y4fga0wyQawn82I9h5eeehMzmfUeIhqf9Yc4BUnh38PJe63Sg4RmA3KFFShHd5ca9
         v3g3jBRnSTWAE9X5KV5eMIrjDCCnwGUesxdH2wFYPyQOuDinuu4oD4faxS2xRjmQRsdJ
         cJMyn7ytGMXOJqHaO2svL1LIC/dZtdeJDi0UTucHuEzheUYea4rOUtP27zBSOTBMPhZt
         X4zT+ty2Zv1JNh52faDbak17fVuhpWjoGN2lcBlzHKTm8/f6B2QTIq2pG3eZUSKP3B2A
         ZqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786518721; x=1787123521;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ouvszPao5Ux2F9c5s8+eYsNl8h500okHC9m4E2BNeLw=;
        b=rur+W0DyYsXQMF25truGZHUcuDQeiA0jIe/QPqFfRbvjbGIVSttMCrE/V9taAuZTag
         yjv7RJYVpoY6s0+r9KIOU72c6/gw95frLPtMlp6z9+eRPHZSro6CdYBO14cq9Uby7q4G
         7yG1xjNp5zeh4188+lMOOfHxuqOo9beXlTTC8xqsVaApS5+qQMLv4YxH3IJbDy2fpx8t
         FRNhET/nOE/Tcrlp8oiXwAt+bYFXkSLIPXS2JTVrQVVC6Um0mjFpMp9qBiQdvcBtHIuq
         1lJ9pPqOBH74K/+0tKrAJuWjbHU00fmaDN8jK3sWLdnjRZpnUakk7iVMhn1xvKnBn19h
         lnhw==
X-Forwarded-Encrypted: i=1; AHgh+RrsQuHJeQhDbX4ci86J3Tsv/qP6Iw/QqwH/fp5m4pH8ahhXrYH4HhlCfXO3Tp6g4XRyw+LltO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUHdGB5oz1VM2IiFpBRQnVtt+xWWnVUmsWm8Bd8RotIQBPcVk
	EJ0b9rrnXA6ZQaoZxUL4aGFvz0aI5jKjk98alW9IKKCGcxA5jsRCDKqE
X-Gm-Gg: AR+sD11dABaZ3LY2fHMjY+KARlxAeWoansfTdSl/5SIphL5FIThM6sg907d39GM55ww
	EzsED1mdebu2pGCSEDCe5e+oXMgkFQYrao6iAGBy/Psv+wZKS8yceTNRr3KMbR2/8aPkIaDZWk6
	1J5Ph5h8cKkEiFMb+izO2w6+C0DB5soKdgNvXqskmR+6HDtHU8bp4KZTSt9jWVyrCEPj2OtgS6M
	s1SFrssYVxndcPrQ8C/bPCJ7pa+GuuKpJwzQMc2k8wAWr9TD1vFi7GHbOdKa65ZvsF1aIASVW89
	/IwOBzO85GKlNaSoQWtc4Rr3uRi4ntxGHtC+QiOfQFTxzb1lL5iCZ1rAAh6gEIrTx1qNmFODvUa
	AMJxkiwWJjWmf8ezOMdUSPNqaDpMavt0G9kACSmbWDTJTPQ1hyGvM2OV9E0v6Xl1jNsFXhZKa2G
	/ww8yP5BTgGNuxghIvbQt4y7veOF/v6zq21GQiylhYoqtfZkOIZh7IOD2mLofnSBJW32lRxyFtN
	QdwxGkyrSP3uoQeBUEX4ytHHA==
X-Received: by 2002:a05:600c:68d4:b0:499:49f2:bb86 with SMTP id 5b1f17b1804b1-4997c0f2251mr25830855e9.6.1786518720600;
        Wed, 12 Aug 2026 00:12:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aaae7acsm51161185e9.4.2026.08.12.00.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:12:00 -0700 (PDT)
Date: Wed, 12 Aug 2026 08:11:58 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Mario Limonciello"
 <mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
 <x86@kernel.org>, <linux-kernel@vger.kernel.org>, Penny Zheng
 <penny.zheng@amd.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
Message-ID: <20260812081158.41b8b205@pumpkin>
In-Reply-To: <36a2840c-c91e-410c-809c-aff768dddbf2@amd.com>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
	<20260806160159.230453-3-jason.andryuk@amd.com>
	<20260810144706.GC57095@yaz-khff2.amd.com>
	<20260811092107.37ef648b@pumpkin>
	<36a2840c-c91e-410c-809c-aff768dddbf2@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 17:23:47 -0400
Jason Andryuk <jason.andryuk@amd.com> wrote:

> On 2026-08-11 04:21, David Laight wrote:
> > On Mon, 10 Aug 2026 10:47:06 -0400
> > Yazen Ghannam <yazen.ghannam@amd.com> wrote:
> >   
> >> On Thu, Aug 06, 2026 at 12:01:57PM -0400, Jason Andryuk wrote:  
> >>> On a virtualized system, the number of nodes does not have a
> >>> relationship to the number of roots.  A Xen PVH dom0 can calculate
> >>> roots_per_node as 0, which crashes with a divide by zero in:
> >>>
> >>>      if (count++ % roots_per_node)
> >>>
> >>> On a virtualized system, default the value to 1.  The issue is seen with
> >>> Xen, but it could affect other systems.
> >>>
> >>> Fixes: 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>  
> >>
> >> I agree with the idea with some minor feedback below.
> >>  
> >>> ---
> >>> X86_FEATURE_XENPV is only for PV, but this is observed with a PVH dom0.
> >>> ---
> >>>   arch/x86/kernel/amd_node.c | 5 +++++
> >>>   1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> >>> index ea553267e5fa..c5025e5291b6 100644
> >>> --- a/arch/x86/kernel/amd_node.c
> >>> +++ b/arch/x86/kernel/amd_node.c
> >>> @@ -286,6 +286,11 @@ static int __init amd_smn_init(void)
> >>>   		return -ENOMEM;
> >>>   
> >>>   	roots_per_node = num_roots / num_nodes;
> >>> +	if (roots_per_node == 0) {  
> >>
> >> Can be '!roots_per_node'.
> >>  
> >>> +		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> >>> +			pr_err(FW_BUG "Error detecting roots per node.\n");
> >>> +		roots_per_node = 1;
> >>> +	}  
> >>
> >> I don't think this is necessarily a Firmware bug.
> >>
> >> Likewise, it can be a 'warning' rather than 'error'. I interpret 'error'
> >> as something known to be incorrect. This was my position before on this
> >> topic. But the various contrary reports changed my mind (even if they
> >> come from virtualization).
> >>
> >> Furthermore, I think 'warning' is more appropriate. It says "We found
> >> something unexpected. We're letting you (the user) know about it. And
> >> we'll mitigate it to avoid an error."
> >>
> >> Anyways, I just wanted to write out some thoughts since this topic has
> >> come up a few times.
> >>
> >> Possible rework for the above change:
> >>
> >> 	if (!roots_per_node && !cpu_feature_enabled(X86_FEATURE_HYPERVISOR)
> >> 		pr_warn("Expected at least 1 root per AMD node.\n");
> >>
> >> 	roots_per_node = max(roots_per_node, 1);  
> > 
> > I'd not add the max(), just;
> > 	if (!roots_per_node) {
> > 		roots_per_node = 1;
> > 		if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR)
> > 			pr_warn("Expected at least 1 root per AMD node.\n");
> > 	}  
> 
> I prefer this because it puts the special handing inside the check. 
> David, you dropped ! from X86_FEATURE_HYPERVISOR - did you mean that? 

No, C&P typo in the email client.

David

> The intent was to only warn if real hardware doesn't match the expectation.
> 
> Really, I just want to get this fixed.
> 
> Thanks,
> Jason

