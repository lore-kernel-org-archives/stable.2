Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A60D3DA7D6
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373202; cv=none; b=XG088/lWsyyDrma0wxFIdJK7fUeIpm5mN+bPXKMjkjX71mLw7j9wT4OEJnbF2W47U/DsP9i+nXtzwzckaFQcLAjiPfGDydsHq1TqxBPws5Pg/vHIUpKziVFvoywQlGB/170N2SGXFlIR1yxPBM/QqjC6ncax8KGjufyFQzqi5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373202; c=relaxed/simple;
	bh=GtoQA9ZjPrcGOfipPb9IUUp6ZG9jXfqV0icQkIbgXTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1//FcROutQIloOdy8zOlvHovw9qREhFnc5DCnkyN+whYxhtNZhK8I1iZHaRU4fw4Mxx3OTr+VR403PpX08EH+GRIQJYFJZcbdAuiuLpJpZ3yUcvxN9oANFF+JLUX5PRJahOVKmWnpn6Q6HTl3o4UrBRpRTprrY8CZaEENAAOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJN3+M3S; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJN3+M3S"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-482e4998d28so1077866f8f.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 11:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373198; x=1788977998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u7qs3hNn4LB9d6bKk0MOq7GzVE03yw7eE/Je5YMCtBo=;
        b=lJN3+M3SS3OzJ7tyPwIdhgmAg813hp7IVtB1KVPtZ1S2VYWOEh3pKWqReRQWwVzPWm
         gU57YhI7u8vWntvLgGP3MEHsqC0e3Z0n4PreTTuoqvEADpbaGTBy1ZhxbtL6w7V/LQNN
         zlszoUbhLgtMpp30tOm9AiTsNpQbIzP1TAuiXp4bQvUMft9/0I8yTW6kHLu/E58n6Vob
         HO+xI716sTlWGHO2kiCGAn6hhB0w5AZ+Pq4M80ThC4t/ntSRghq/EFXBF31x4BbowSWR
         zPLTrh7fA2h9bRzDGWfBdwGfMBO37i9lJDTiJoPo2n7DehVIscoXNu139rPa7MNez/OA
         T7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373198; x=1788977998;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u7qs3hNn4LB9d6bKk0MOq7GzVE03yw7eE/Je5YMCtBo=;
        b=LXMJwkevULG6ZTxBnNPyb1AmZn/2zV/SCNyqqQfOwecD0PGn1bF8/IZ7pMWSVpKdsA
         UZpnyge21W9p/hoQinCTJfhiyE9DNGaO6pOrb++qzd4h/gubadwq3+yK51yOQptzucCh
         FvDwV3oPooEVIsb8g1Fg8pbTUE62RA47XL1f2IPBRVIA3ugY7Xmt19HAA45Y5pgYqauD
         eEDhucujwBMklnLOJyQh3g5jMh3vKSjgbIdz+4b8aeo+08qi3T06SU+PSsLMIopiZf8T
         qr5uuzyDOe5NqxOqeMBXwo4mEzWKWHLwEYE5/6hb7p/FqTZOpbkwUJXnMECCMhMec3/5
         Su7Q==
X-Forwarded-Encrypted: i=1; AKwUvBypLVN/nXHLZUrSkPG5pb3Gr5r5YUCre4bdx47dWzM+KYbag7ps6eT5rs67bNkxA53hoD1LCaQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nA42sraSOZbr7VgQf1gsQtpAp0dqMES65I9173heCDzH9iajWk
	1xld/NBqUZk+PdPJYfVqCxQVhxPn5f8fQUCpvNjRUcnGuQjrTEBdOTYs
X-Gm-Gg: AYBFou0K3kK9jNT+Bhh7drG1YRc3YZXTcnf2gcck1iqJiTvCxoVH/lXsyPfrkYGWQZC
	95BK0Dxrqb0s5XgRP07TJt9BvMQsfZvUoQ30KprJZg2W7SoK/RYtC61ogXufzBtHWdv6BP/r1to
	ZspY1GsQJW6MeD2jdPmAD4p7ewLPbe8VFPBeMui4QL+VxKAC2xYY4xioZ35A5+gRDagQz2hnQKw
	12vQvkj9S/1KT4kisCdV7XGJ64Ug+bW0V/AocmBKp/jbgMLG/vzRJBQ0JVqgqvqtRtUjFmasCIN
	gk2M+0ZWyozNesHyvPcUdK6x4hqLy2NwWl3OpBrFxFvaErPpKxGgM6VPGlLjb3nJMJAtUNRUDW9
	N5Vzl04yYZ+es9TkiDySbGKV27r/Z1SgRvLv05JYSN+br9bjcnOyFuFLrrc/R3CUxlztmMFBAXf
	s4HCcmhuQvJggiuah3MFJXqIABjf+VK2sNvNO1MrUyXfmYc/FwyuGhQMups2oMdYisOinqHkqXK
	BOX8QSJdi0DfbrWP6gqQBx6+w==
X-Received: by 2002:a05:600c:4f88:b0:499:d366:f572 with SMTP id 5b1f17b1804b1-49ce58388demr100657795e9.10.1788373197777;
        Wed, 02 Sep 2026 11:19:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee3b0af8sm10644075e9.0.2026.09.02.11.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:19:57 -0700 (PDT)
Date: Wed, 2 Sep 2026 19:19:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] xor: add missing vzeroupper to AVX code
Message-ID: <20260902191956.0834eaa3@pumpkin>
In-Reply-To: <20260902162359.GA2497@quark>
References: <20260831212248.213805-1-ebiggers@kernel.org>
	<20260902133706.GA21538@lst.de>
	<20260902162359.GA2497@quark>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 09:23:59 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> On Wed, Sep 02, 2026 at 03:37:06PM +0200, Christoph Hellwig wrote:
> > On Mon, Aug 31, 2026 at 02:22:48PM -0700, Eric Biggers wrote:  
> > > Since the AVX optimized XOR code uses YMM registers, execute vzeroupper
> > > before returning from it.  This is needed to avoid degrading the
> > > performance of any later SSE code that may happen to be executed.
> > > 
> > > Fixes: ea4d26ae24e5 ("raid5: add AVX optimized RAID5 checksumming")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > ---
> > > 
> > > This didn't get taken through the x86 tree.  Andrew, it seems you're
> > > taking patches to lib/raid/.  Can you apply this one?  
> > 
> > Can we do kernel_avx_{begin,end} instead of having to open code
> > and document this everywhere, please?  
> 
> Again, there are cases in the kernel where both AVX and SSE are used
> within a single kernel-mode FPU section, or where a CPU feature check
> occurs within the section and one or the other is used.  So that
> abstraction will not work as-is, and it would be different from all
> userspace code as well.  If you'd like to try to refactor everything you
> can try to do so, but let's not block fixing these bugs first.
> 
> Also, AVX != "vzeroupper is needed".  The relevant thing is the width of
> the registers used.  There is 128-bit AVX code.

It also depends on the instruction encoding used for 128-bit AVX code.
If the VEX encoding is used the high bits of the ymm registers get cleared
(rather than preserved) and you get different delays.
Flipping to/from VEX encoded 128bit instructions adds delays on some cpu.

Yes, it is all a mess....

David

> 
> - Eric
> 

