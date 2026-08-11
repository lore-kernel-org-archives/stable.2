Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA7415F31
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786436474; cv=none; b=jBswZ/b0/05bFSgiSmh3Wk1WhwQneFcHvNRAXAcmwwJKV8HIN8ojqlJMokhmR1CAxq/gdxn3fbKdBTieAyGJ1PzU1QRXRTyxNUh+Dxdt5dEYRQNTpIZrMADhaSMJomv9EGUma76dhZFLs90jPNUztx/akqjtbifyiGWuZqh2Ka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786436474; c=relaxed/simple;
	bh=Dkmbdh2ognbJLDvpaxMc8rYRxPmKmy9BFi7VABC3oPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHDb0enQNABK20m4sAApEYdBjkrJWii6ezjJJcyMIs8vBS2qQAb7kfdPpdRal7Ia2/ppMkmRAh0+nhEMedgfymRn2Oy2kYeO8B7UXsmcDAr5RCpIjckAeznrI19SuC0Sl/TCGBfyPSzaNzPnk7figfmqfdx51m6xanmgl0/Y7OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vo7S6ALI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo7S6ALI"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so30781005e9.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 01:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786436469; x=1787041269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PsVqbXfj6KXdZCKzed0xiDF5HlCoWH45JjgsepkCfGY=;
        b=Vo7S6ALIG5hH4bquBI/cbDA0HCUS6Wnb7Txkoj9IVFG4t1VcRkLWGeAozSDvkLM2L0
         HZ5IHXWgEBF293CXH9HQeStYd4vcLnUUYN7iN1Z9eK/hjx5CUUIWxwnpZy7aRM+L32O6
         pAqSqPV+TlJt2gOXN6qy6geV5yALvIc2RTxYg7rTEaBhb04jqp1Wln5HtQmW6pxwSVaA
         vugHhY9M+HzU90u5398FEWeH2lIILCFx2w8LUNWEY/ebi4iAfuaj3TPMO+MnZHas+AV+
         W7Z4rjLNImEeCDhdsoj33+yS61BVpCo5c6CgO6cpd+XsKB9iZ4igkVjj9UeyJqeN8puE
         VGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786436469; x=1787041269;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PsVqbXfj6KXdZCKzed0xiDF5HlCoWH45JjgsepkCfGY=;
        b=VUyvUGHVQ/0cBoBfpbJjMA/9f8JIcDxmDLlsY64+W5yfxZOhJcXkK53KuqHOWbvwX+
         CdDMWzew/TPjZXHBCEBphriRnAXpjV94dAuTzYht16gUWKUfpFpahZ2HlnAuIzASKrmw
         aauFFjJlLANoyVed6dPflqHA1KlAxZ1Ivrn2kY8bb4B3CaKgyrlQUub8GNHfk5LNJk+f
         Y9oAvonJTsL6NKxcc9pe7H0DgKsxSnFvlaIAOYh1PvFCHO+3BlUgFyT/ItnVuEImpTP0
         k5Urqs2nze7fZ/iMUK6LGQwFGsqwrWL/iQJfAkXJACt4JjhadWDI8TtajSqKXw7SBrIJ
         BjXw==
X-Forwarded-Encrypted: i=1; AHgh+RqsktrNYg9jIucRjFf2H5cOSwf+aDRCzLmhEvQu4FUyXTgDuEkl0ujFXBUxCaYA3CKFPsNwUKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlmwBg831xs/cXxtqiRENGMxk/Xt6lxYF1CMtcLLl1sAa7mRkK
	kKbao8AR9qZNl7vNn5s97qPZt4Szo3B0yY67XgmGZ+eA8kU9eP++OhsT
X-Gm-Gg: AR+sD13LlN3xlfSWB1aZJC+p5Y6J3Ts2khNhu94FtCVUK6QHp2XcoZ/+wMYZ+PIdfka
	Fs8LAjmcf86Wl1X3GcEtgfZKp0WDTew+WvclHOwBDwx9/c2sTzkhrYS8I3dUF3sebmsKeOq7JVR
	0eOihLE/kVBcsEVomJBNzNY7JQlqXA48uOyeivBiA/LQfTOI4V7TwVlL6VppUwIdCwwcF7Kb0FB
	n3E/30PymCCzov60QaaGLzPZM0BS913rQgWXac8qdtHTCOmhwp59Yrty74ZLmdloltfRI/CI95o
	VBI1zRH71j1xg5l7Ugk8xSFAr68Z7Lpj6WjB9dj77szH2qy9rqondjY5dFfmTVQ/Pg+8spXaMi6
	gWmqiE3DXP27EEbILW8r5xq/Syi9j43eUWTjgvKhQHrPz+/vW/Vb5UJWHWJBrxrZWfr5BMUd65X
	TXzDlbzHvuwUVkL9SRqg/12pto9wV9xkGBasIEfNivHzST+5LF1+0aiDzwVXwZjmTUuax0ikGC8
	Jf/CVvW8Ze3BbKDAklx3BCkPg==
X-Received: by 2002:a05:600c:3b9e:b0:499:795a:c60b with SMTP id 5b1f17b1804b1-499795ac6e4mr7851195e9.19.1786436468951;
        Tue, 11 Aug 2026 01:21:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499740dbb03sm50158035e9.8.2026.08.11.01.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:21:08 -0700 (PDT)
Date: Tue, 11 Aug 2026 09:21:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Jason Andryuk <jason.andryuk@amd.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, Penny Zheng
 <penny.zheng@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
Message-ID: <20260811092107.37ef648b@pumpkin>
In-Reply-To: <20260810144706.GC57095@yaz-khff2.amd.com>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
	<20260806160159.230453-3-jason.andryuk@amd.com>
	<20260810144706.GC57095@yaz-khff2.amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 10:47:06 -0400
Yazen Ghannam <yazen.ghannam@amd.com> wrote:

> On Thu, Aug 06, 2026 at 12:01:57PM -0400, Jason Andryuk wrote:
> > On a virtualized system, the number of nodes does not have a
> > relationship to the number of roots.  A Xen PVH dom0 can calculate
> > roots_per_node as 0, which crashes with a divide by zero in:
> > 
> >     if (count++ % roots_per_node)
> > 
> > On a virtualized system, default the value to 1.  The issue is seen with
> > Xen, but it could affect other systems.
> > 
> > Fixes: 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>  
> 
> I agree with the idea with some minor feedback below.
> 
> > ---
> > X86_FEATURE_XENPV is only for PV, but this is observed with a PVH dom0.
> > ---
> >  arch/x86/kernel/amd_node.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> > index ea553267e5fa..c5025e5291b6 100644
> > --- a/arch/x86/kernel/amd_node.c
> > +++ b/arch/x86/kernel/amd_node.c
> > @@ -286,6 +286,11 @@ static int __init amd_smn_init(void)
> >  		return -ENOMEM;
> >  
> >  	roots_per_node = num_roots / num_nodes;
> > +	if (roots_per_node == 0) {  
> 
> Can be '!roots_per_node'.
> 
> > +		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> > +			pr_err(FW_BUG "Error detecting roots per node.\n");
> > +		roots_per_node = 1;
> > +	}  
> 
> I don't think this is necessarily a Firmware bug.
> 
> Likewise, it can be a 'warning' rather than 'error'. I interpret 'error'
> as something known to be incorrect. This was my position before on this
> topic. But the various contrary reports changed my mind (even if they
> come from virtualization).
> 
> Furthermore, I think 'warning' is more appropriate. It says "We found
> something unexpected. We're letting you (the user) know about it. And
> we'll mitigate it to avoid an error."
> 
> Anyways, I just wanted to write out some thoughts since this topic has
> come up a few times.
> 
> Possible rework for the above change:
> 
> 	if (!roots_per_node && !cpu_feature_enabled(X86_FEATURE_HYPERVISOR)
> 		pr_warn("Expected at least 1 root per AMD node.\n");
> 
> 	roots_per_node = max(roots_per_node, 1);

I'd not add the max(), just;
	if (!roots_per_node) {
		roots_per_node = 1;
		if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR)
			pr_warn("Expected at least 1 root per AMD node.\n");
	}

David

> 
> In any case, we should just go with a simple fix for the virt cases.
> 
> I think we could even do away with caching the 'root' devices. But
> that'll be another rework/cleanup.
> 
> Thanks,
> Yazen
> 

