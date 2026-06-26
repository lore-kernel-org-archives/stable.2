Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E02FD69E
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466933; cv=none; b=By9UEq1wrySD9bgHasG586wubO+5z+ez2qBENVwHDfz13qJW6uxGIcODQIfMRTNnlONBI8W1IRaN9RLRfJ6PmlOb5rQYXZBEDpkvzc3NL3zRkMsSq5TcMTq3PdUDU1KHGnXNvhkjwbAhQDv7q8INHygNwXhbNU9wAD4ipUSXa0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466933; c=relaxed/simple;
	bh=xChD5ko7xj9WKHYq63ZmwYEcWbmEkWAXhQ5x+ZVZ8Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef+sSQd+7DC9ZgSQeBRbBT3pec6aMIYlnR7z9r9bnVoEen1ZpGjnGlneq3905AvsYseysG7cGOu01E37MMTIPTrtpWe6MBu/076/A46KdKQJMJMtABCAOmxcXq4lIJUfdexKoB7NLscegExyJQi9nTJOcVUW95/WxXmO94dbMIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ga2ay2ev; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ga2ay2ev"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-46f8562013bso199660f8f.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782466930; x=1783071730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i57MYdMXpilBWj0slexli9uFmzGeK180L7PM67C9CYU=;
        b=Ga2ay2evjcb46l2x/sQbH1EfMH4VBvZigfqGdL9AAaJcWkpBETNryoP8sYi0+suSnu
         ddTvC/P5ZoCjuLewhlOWiWS8SyRlhzMC68JqVm6LpBw18REftY03G4AGr48vSpJN+F+p
         mXJUtjUKD9vZxdBiBylMmoKtE64gIG2Xvrc8nA4KfgjiTCAq4jIzYXAmgSkN46ImmQaR
         iuTsBShNuETBUP5M3KmKZIFHcJd/F8pdS4uQAeFLLd4EmBp7iH2xG7YIq5eMX7Cx3jhd
         ZmgxG4cdhHA2QRbpfS89HfBbom2tZPreQGG8cdkg4t9ulNjBS+NCCg9tzjlS0nJ+7NAl
         3oMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466930; x=1783071730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i57MYdMXpilBWj0slexli9uFmzGeK180L7PM67C9CYU=;
        b=NEC9FrwpnC27o8k1WytKMBl2FhxVSXEXr0C9xN9ADlI24Qhcwle3v11lferIH0Oq1M
         Oh6xquSCZJFdG5tHuv6K30DaXpl3buSxLo0vLe0piEttjm9ev4+t3Q6MgjQLHKv1ey9q
         QWewmzm/asIK+01AKKgL8gnoNFxjgp+KFQ2/vpPDY2/dDiTXH5RTQwJtAhaNSpKyU08a
         +cnJnI48GSywsXoh5qnPCVOgh/a1Iq7dPNcNdsxy+mHT7XjroCvkW/JgKe/l4ae/fYol
         umT7a0oovxak/pKqhMHDEiDAdWyqLqy+aOvYEChZQvvNbcBOMHxsbTwv5/lEkZANZGLT
         xKBg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/kZNFO06byMBNz+tp2psfQGAU57GgvJKxc9VmDi37zrLovCoBEZW+htb9q537wENfAkBBDjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkxd42g65N6qltamYo1PkXV0T70EqVs1CSARxZqnWBm/U79x1b
	WxkOnOEro0/GkgXu9VncAXy2iEd8Zpt3paGWfd4/BvNSI+jU3KASosT9l0OHJSerp4s=
X-Gm-Gg: AfdE7ck+nYG2deLaatMlqwFeb/Z3qwgEo16IAlhts8mhg120IcXznBiOXcQ68LRqc7v
	x/cLN13UkasMG39IUK/NkzcbraIJraMNY8Hwu/4bnmj4PWKCtr3ckpMlpJK6skXqMPTD+FXVydf
	9K08Y7lN7L+Aih1C6yAE4jwjeo9yI0WV/K25FhTe7V/dLtsKuCH9tIv5llDCL6dbK9bl2dnEr+V
	Eie19wrM7fzh8ChKgZizlv/ZvL2AbMap5MhxcxJE0gla50Pz9R7kWABlTn91dze1jylNEcQlP7Q
	i6C1xNO5Hk+9KEL7oiqW46CFWFtsGLN8HrorNzU3VyE+v7co3P6w/w9V/tO+m8cmchIgrZr/JbS
	2HnFgpMQP6pjAIZ0NIP6yS6LbAzL4srCbkDRrVh7HO8K+xF5yhu6R1q9Vu9RCBGp5M91bCwNSmW
	MdDmt79nm/PJnRxyE=
X-Received: by 2002:a05:6000:461d:b0:446:db72:e8ec with SMTP id ffacd0b85a97d-46dc1a9181amr10448749f8f.23.1782466930592;
        Fri, 26 Jun 2026 02:42:10 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279b734sm24794053f8f.30.2026.06.26.02.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:42:10 -0700 (PDT)
Date: Fri, 26 Jun 2026 11:42:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/4] powerpc/watchdog: use sys_info_with_filter() to
 avoid duplicate backtraces
Message-ID: <aj5Jb1VPqfOLlCBQ@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-4-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625152558.7450-4-include@grrlz.net>

On Thu 2026-06-25 15:25:57, Bradley Morgan wrote:
> The powerpc watchdog prints all CPU backtraces itself. When the watchdog
> mask contains only SYS_INFO_ALL_BT, stripping that bit leaves zero and
> sys_info(0) falls back to kernel_sys_info.
> 
> Use sys_info_with_filter() so an explicit all_bt mask does not request
> the global default.
> 
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -418,11 +421,12 @@ DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
>  
>  		xchg(&__wd_nmi_output, 1); // see wd_lockup_ipi
>  
> +		si_mask = READ_ONCE(hardlockup_si_mask);
>  		if (sysctl_hardlockup_all_cpu_backtrace ||
> -		    (hardlockup_si_mask & SYS_INFO_ALL_BT))
> +		    (si_mask & SYS_INFO_ALL_BT))
>  			trigger_allbutcpu_cpu_backtrace(cpu);
>  
> -		sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
> +		sys_info_with_filter(si_mask, SYS_INFO_ALL_BT);
>  		if (hardlockup_panic)
>  			nmi_panic(regs, "Hard LOCKUP");

I thought more about it and it is even more complicated.

Even if we prevent the duplicated output with sys_info_with_filter()
here. Then nmi_panic() might still trigger it once again.

We could say that this patch is a step in the right direction and
fix the other problem later. But I am not sure. We might need
a completely different approach and this is just a step aside.

And there is another problem in the panic() code. I am going to
comment in it in the 4th patch.

Best Regards,
Petr
