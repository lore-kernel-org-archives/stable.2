Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C2409624
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959591; cv=none; b=uZmAGCQx7rXZqeezM/ThruV+NCK6G7ZR9BUfnHh2gqLtzASfcnKyGuQwYrjgbomw+xKO69GklJzv47N0PsIClzIsPe6fJSGRrcXn6j4iW8ct4gU/i47+T87xA0ZdkyLeOz5dGv+CG69em6mOVDg94rCfN8RJacQN8UNJpjO5mek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959591; c=relaxed/simple;
	bh=8aKYsiqHb+e0EBWQSXGieX25f0W/ula19ldTW0J4XxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7ak4huH7Nyp3ELCFQzdZkLjcRxereLm9psnRqyAWt+6I+0fAslcn2ojdx8nqjy/NoAevA+02RoLw/5pcQXYPhrDn7xVoJwfC6SqoVdsOTR1gM8HinMLSPWT2tFNO+owI7cHKlstJH8n6cvhLzTbECXnFYiHXiYp8HEaqNJDE1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QycgO+id; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QycgO+id"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso26733635e9.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 09:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783959587; x=1784564387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z6q8XmEubJ3GvXQaxRj4lMsNn/x2kGXa807Wdz3pI08=;
        b=QycgO+idv1TwB1WzxRkPikXDWlxUOiX+pOqino3h9N2fDfShWxg57tmjJoWCTB/qUB
         XLbZ7/PoTLQCAYU6c7iB4rDybH7FlLFt+BA9piuoQ28JB0bSZ3ay37M1ob+tBcGSIqh+
         /tb/qEiZB1ZiLXATIakSUK1+d5uvFbO9LjY/j8gdW16JThFMXTXhXgPboYJn8aDwdSNG
         naNCJ3Ugx1UEkbfiHmD4PNT2tenAH+GLp72eK8VVep5tebiPB3nmUh0HKRaKvM6OW1Os
         NO7kcxUUBE1sxvjBngdk7hGEgCZwJjQjCzP5hgi5gTgIOEabdcWqp49xgDIDFSGhbzAD
         pFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959587; x=1784564387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z6q8XmEubJ3GvXQaxRj4lMsNn/x2kGXa807Wdz3pI08=;
        b=L77PETVtFv6n6BjOaN4FLlWE6A/IrAnJ7kYBKMwsr/AGsD8T++mFccMCYIaE2rTkxD
         6tskhD12VAFk4HmLBHRJLknKjXWCKhtJuyPrT00iClg4vTxkatDFdXcRJcrWcIzMBwoH
         /Z8o3QHatxxZLUluvkZARq5GW2G1NFTfai8475OIvGUhj8tQXQo1Y/+ncCiioEl4hSYW
         Pob7yRVYQPFoW5QOiU2j1CsZMkVKCBKf/P82YgCmymva79JorNkF52hMYylWreoM/YPD
         AmfGL+NgVGZzzfrLJ2n1EGvOF3L5llj7yOK9OKRaIkr1pkNaH7aQJdl+sJcXovrKnttn
         hY0w==
X-Forwarded-Encrypted: i=1; AHgh+Rr7JGxarWZT5VKIpDVjRQVPGZOEDWnOZIm5ICDnaZ1fah1R6hdaB6AW/7L3uOX0ejgyPj4bktI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMQQzcMzreoEJii7Koyjpy7+0QDAoZTlbxtvaYTZqcWqLiTREK
	+gmLmCSXIRocR+TjqMJQwK6G1gQ3GHUpl2kzYO4OeIDRko0w6AHXQjg=
X-Gm-Gg: AfdE7cn056JvaEkHAN4S231gPLTplDNMjp7SJHa8dFAtluxLUAWgn8m8eM5Sj5rHDxv
	p2gRwpa888FsIRUD15DUhYUn6pV63x7FGpxMYD6N6LXPTc+M+RYoGKGO+ama50rbYLyJSOom7k6
	DiMktRSSicvtyt6N0rk6bQbd5/BIOxj2mslB8hMig9z7B7Snrphn5OD91eaZFSNxlwA0QtaqMZY
	g70NJ5IiJzDNfN0FFJanZOhW3LGFSGHIckj1Jn6hRqwcrKyCIIdNoNspbUafFWS3iqyD2n/217X
	JnizXyKC8O1YhJ8sdeBCOXmzCcQo4zphZql/bZ+e6GTeHOY0ZTS2vig2/lnxd+Q9KlIJMNWt4YJ
	BlWr6yCjVm74vhVwxFc01Boakt6qpX8bvQlmm98yoC4gMocVH72oiBWB5MvIGgJNsCf+llp7xMR
	isJIpDXiVYnlD8FWcwcp6DPY0S1BVxaR7FGcGYyOT+g7TBbGD9SFuRyDW6it6yO5AbDA==
X-Received: by 2002:a05:600c:3143:b0:492:5e22:ef18 with SMTP id 5b1f17b1804b1-493f87ebbbemr104433225e9.9.1783959586422;
        Mon, 13 Jul 2026 09:19:46 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:ceac:ba6c:1653:e93a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a974csm554519f8f.18.2026.07.13.09.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:19:46 -0700 (PDT)
Date: Mon, 13 Jul 2026 18:19:40 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	MOKUNO Masakazu <mokuno@sm.sony.co.jp>, stable@vger.kernel.org,
	Geoff Levand <geoffrey.levand@am.sony.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
Message-ID: <alUQHB7VvXIABLHb@lithos>
References: <20260711130931.740719-3-thorsten.blum@linux.dev>
 <ik6jukrj.ritesh.list@gmail.com>
 <alT_fEu9AtQT9PxU@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alT_fEu9AtQT9PxU@linux.dev>

On 13 Jul 17:08, Thorsten Blum wrote:
> On Mon, Jul 13, 2026 at 06:08:56PM +0530, Ritesh Harjani wrote:
> > Thorsten Blum <thorsten.blum@linux.dev> writes:
> > 
> > > If lv1_put_iopte() fails in dma_ioc0_map_pages(), the error path
> > > decrements iopage but keeps using the failed mapping's offset. As a
> > > result, it repeatedly tries to invalidate the failed IOPTE slot and
> > > leaves the already installed IOPTEs valid.
> > >
> > > Recompute offset and invalidate the installed IOPTEs instead.
> > >
> > 
> > Nice catch! I wonder how did you catch this?
> > Do you have ps3 console where you somehow ran into this ;)
> > Or was it a manual inspection?
> 
> I do have a PS3 somewhere, but I stumbled upon this while reading and
> trying to understand the code.
> 
> > I wonder whether PS3 consoles are still being used?
> 
> Not sure.
> 

Yes, indeed, they are :-) But I'm not sure on how to test or inject the
error path, so I can't add anything useful to that. Beside, thanks for
keeping an eye on the good stuff.

> > > Fixes: 6bb5cf102541 ("[POWERPC] PS3: System-bus rework")
> > 
> > Looks like this was from 2007.
> > 
> > However, the change looks good to me. So:
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> Thanks,
> Thorsten
> 

Regards,
Florian
