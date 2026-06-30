Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972944B693
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853071; cv=none; b=ZbHJB/QETUlQW625WFRVT4hvaGKSMm2SUEolAYxcQb8s7pARBL191P6oDQYFOkDHkig9Fz7+orJAmyAononkCl16QCA5FY6xLCOXAIz3Jy/vDtJnxc3D76LqUuVtiHs43tWW34ofZkk9OqKCO4+xfaymyuG04pQIYzKgR+CLJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853071; c=relaxed/simple;
	bh=tki8VYOorrL7Vh2P/GhEe6UqvDv1psdAe9UhD9ggn0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKktuyBvzcJIw7G1xSdV8w+e0WUp+vGyv+0E44uk6OaCGKLM75+NHoCB+sw3BlPB4KTbO4+Jp0uzRVkajv3bB+N1cWGF1e/0FiaZnwqB8VB5NON2/G0qxFIgkuJuZWS8VFscxOCFHFTI1DBSiXgxACk0T0dz1cq3E5SGQZWe7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UwaKNwoT; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UwaKNwoT"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e51d3d83cso205347485a.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782853069; x=1783457869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+IJodXzk6nIKTwEHgsn4EfzwEPSclnTV/6cyemr0hQ=;
        b=UwaKNwoTNQ4yh1q4/sOwnEh8nbMAnQuRNK5UaNzfkulZ+TQWZRtoYR6IbpzBkxVl1Y
         R8xaphWVkot1fA01WHVK1RYNVip1jzzLv73dwVgWQwu5zyHgYTG/7ySxc4l3V8dS+IGq
         e1mLfvmX2JGyxlzmzLMnqv2LkO9MGUlwoHW1Fa5IL/Yl+74j2bFipkwcrw5rL8Q4rJYk
         gtLaW0HEQXgjpUkO+3AXrefKDeJH6AoF9ScZ8HBH40Lv2ZWETLLxO/Cux6oPs9ZDR5xI
         hqhQM1UDvWNBbl3cuJALJd3dCxmtTXdPAbDzV5Ijy6Jh9BVFsu3MQ239zlePeozDpxp0
         r4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782853069; x=1783457869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+IJodXzk6nIKTwEHgsn4EfzwEPSclnTV/6cyemr0hQ=;
        b=fR22DvZAcBkD7J1BKEHv6G4AZg0u73gl+1+gnPT0qaqNXbH243PVwZzKADM2cS+C4N
         XGDgTEo1aodSLpPTMjYcedCcyMGwdS6i8W6J39Q4uXVLZaIe+lI3OBSvmB4NV4LY2Exa
         ARi40T7p/jRb4fDYBgcL+d89yTPiEY0e9Kc7tYo4L441A4ZdHcat5SU3fJU3saUK61S7
         elot4x0AG2dfJbGUqLPV246RtaNQ9dz2Q7D9+W8EaK903QhNUDm1IE6kDZOfGGf7TA1T
         3Ybnu/7igFJLl02tTANhczn+HXz6+C3sC8aQzgue6ugOHTKCrtfvk2Qv/M4quaF1+/Uf
         5YiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cw4LLuRxY+FEyWcmeu4/lBkqytlLFttyEJF0mmdpaqeOvQE2euemwryWqXwAcW8whhcFKaWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc9tG0dEMG0yxe3bOG3qIyVPflOrlterW+tvRD5sEL3loPm0I9
	ZJtDuUJxEsaqGN10DtvrcdJyYZIJS8G8dRykjRQFl4b23TRcN66RvSEwHS3DBpRcXBw=
X-Gm-Gg: AfdE7cl0N39ARjNGfqOzZ+4ueAg+dM5xDndrPzCG9ttnldudtZwmYz3bqzUAaTJE67o
	Ep/FcSY/ooLEJbqVdaSJFU/O3JvCMr2wRBs8wXxfOHg0Gr/Obttlyr0NE0mayPl3XRggcMHnzMf
	UJegqDORoEqgaCqpcBeQ0fPvQ8j5Yda74YaJ1u6h7YYG4B70OrqpbxVj4sAgJtj1eHRFeqce46U
	EVrQM2pWjaRRayN7nmM/8NcoGjED+53ijfFM03Ilc02HBI4P2rYXWYwa0qQodEm5UyRJYSsHOZJ
	aVPKqH1Mb/nHQjWsC2tDjEHueAwShRuaG6ZLBpOas7cffC5pwVfW4oH8nLiMoJBWKSfr7lPnCb5
	Sucfzw3GIV/edbguYu5crlVkXAkhCTwKYl81dCH9Jf+ctpwut2iDVganyT1BxtNpUkSUVmdUPKN
	BXsbR1f8u7KjPJcnR4dPS75PYoiMOs9176tvzQHlQj035O8JOTG90Zd8Jw3xbxreS6NG/4
X-Received: by 2002:a05:620a:40d3:b0:92e:4a4a:4478 with SMTP id af79cd13be357-92e6d840616mr373996485a.31.1782853068602;
        Tue, 30 Jun 2026 13:57:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e622e7473sm348604085a.25.2026.06.30.13.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:57:48 -0700 (PDT)
Date: Tue, 30 Jun 2026 16:57:43 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rppt@kernel.org, vbabka@kernel.org, mgorman@techsingularity.net,
	hannes@cmpxchg.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmstat: fold stranded per-cpu node stats when a
 node comes online
Message-ID: <akQtx7zhP7pxNCiy@gourry-fedora-PF4VCD3F>
References: <20260627202243.758289-1-gourry@gourry.net>
 <20260627161007.81e4533ce561c2951a69f927@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627161007.81e4533ce561c2951a69f927@linux-foundation.org>

On Sat, Jun 27, 2026 at 04:10:07PM -0700, Andrew Morton wrote:
> On Sat, 27 Jun 2026 16:22:43 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> > +		struct per_cpu_nodestat *p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> >  
> > -		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> > +		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> 
> and that's a lot of items.
> 
> I guess the overall loop count won't be large enough to cause issues,
> but it's large!
> 
> Perhaps there's some simple test we can do on the per_cpu_nodestat to
> avoid the inner loop?  Perhaps might need to add a field for this?
>

I took a look, but that would involve adding another per-cpu field and
then making sure all the races on that field are respected as well.

Not sure it's worth it for such an extremely rare event.

I can try to get clever on the folding logic if you'd like, let me know.

> btw, "for(int i..." is allowed nowadays.  It'll make this code nicer, IMO.
> 

Otherwise i can send you a respin for this.

> And... Sashiko seems to have found a pre-existing issue:
> 	https://sashiko.dev/#/patchset/20260627202243.758289-1-gourry@gourry.net
> 

Incoming patch for this shortly.  Pretty trivial.

~Gregory
