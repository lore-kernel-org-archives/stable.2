Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAEA2F8EA1
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022739; cv=none; b=N8itu5EFyiApRVvAGQL21mLHCEcS4KChvmG1FCoj4BTefyv06ey/1uZtu3TURPWKESPPBO06c1vnB7kfu8Wi2jc0MVOmTmnzAbnx9d73l7pW+PdSbVvHGMRH62Dtgw47fez8GBclx9tz9IW7COzT4Tizy/6ihvskSi5G9MRuL7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022739; c=relaxed/simple;
	bh=UEF1hMWQl5k9GsCr+BF/8xWb9NeyY/uAyveoWZEAxR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+96qlSgXSZ/zMf/I6ZIIUTyQgETCY2CSDiXFK8moqC34RSfGXWltPP8NI+31q7Qwzg2zTANxy30aDF0RzbRLhWV+OoL2SrPcJOguYFlkoOijWK1CgsnKzlFZmR5arw51xnAqCdkFsqk+GaH5p6Va6JRtUA0xp/wS3t1KNi/4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lg/kpRor; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg/kpRor"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1461373f8f.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786022732; x=1786627532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bD4V/l6TaOwztjPNNJTucq6Cem66jlGJZTYeeEAXsMM=;
        b=Lg/kpRor5VfZ+1J0vpDFDN5yHAWO4EN3jBOzQ9brjEKnzmDHBwSZQb2jtRovlEwc0f
         gdEgjDSld3lqVVabVN80ZVm5gcTgEplgot2u5lWx0gnn/eQJnOPR9yBR1bB/Zwfo32sV
         8bdW1WOT971LNoGZRVDy6xdDuBvowe+IOrBezTHTw7PootgAV9/QcW5Spb6I3ewLLMSc
         sVymLEbtqh3adtzttT6MqKo3xDlDDrRaV+RLlbn6M3TX4q4Eq3teDdQoovkVqejWToGj
         WAT7diwvVV4g/YLTcieGsKOgGd44Y6s9dVv07TGP+s4qh7SXXtpLAJTAp+ZxSCZyPWEt
         tkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786022732; x=1786627532;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bD4V/l6TaOwztjPNNJTucq6Cem66jlGJZTYeeEAXsMM=;
        b=jupemwkqdDVkoF2EGrEcbiRENYcuixMUpm9OLnnoFc3zzUV4BLibv2nTHzK47iA65X
         8AWIMLvN1Yr/syLXiSr2XxCqSTPXb3ECpfXdRndUAS7HoewR5zI0TffSU62bxpbG9sCd
         2ZqsGxoEvSSWbiC9rCgJtLBpyWXyWifrhdrqbZXIwvMwHH+nCEeiXK9Guabn+urgT4/1
         E0475aWelqCVBImUw07FZ5SEY84qSABQiG9WOfVyWLL1yhgyfjk2K2Iju1imfxREgmgJ
         mRir0GTJIDlfwI/DoBJ0Db5ayqZFloauXlwDfe38X/v573xs+TRWPoZQyxeJSD98yoQS
         2fQQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJ9GUhTEvwj6209losx1uGHNFwxZx4ob1uNSUi+KgY/j/KRk8ea3gym6A+0nRiwCTr4Xi3yO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMoLfq6zKahmIbtFHt5cfYVuKhkZM4/+d/NFobJfq/Dkv4mMm
	fi/Y1a1g+7vU5LSx2VQ3o+oiM/Sdf4HBBHsdHmKPAdl7IyaQBMoK6pFv
X-Gm-Gg: AR+sD104Yt1Zx1vRFPJUkcMdprd13/rcvElLbyJwNnFAL8Xhu3dAglU/MkXEvC4E1we
	1IyN89LnosNLairNGUhTg0O32VXYP9TlGN9UAnP1Q2g0sL21+MlKZHakITM38THHfsLlUUlinUk
	+I1GUuXwmy6853ylO6CBhu6/q0ujc2vwVAPfCC27nMNWx+z+cAFu+sd4VfbJS0O2qtNK+RRjyIc
	EoO8U6xKrOOLFyCFzs+vJxe6CamiazXfDaPtdCGcKuJm3dFIKOv/K1doGbOOVIOI/9GrdTDzzMY
	fyWkFCpV5qE3JBEVjEQRJqpHpf/NFHUPI0bBW13hp9rkwLWE415tkbt6xygFHA6f3ugX5aYj7AO
	ibBWOH1C/gVhLNISQQbToGTYtb2Je7NtcBxlTvo5JluGRyx+UK+OJx9BbP9RSE8DScgjJnO6Zrt
	n+cul+bk81TW+CEXty2v3Jnawlgjk7DRh/dPwtnvS5GG1F7c/JAhrdv4jKHkdUqjGMY9t9FZOTN
	p6BMY+TPoijRkwBUD2HEe8mLg==
X-Received: by 2002:a05:6000:29ce:b0:47f:7c4c:8144 with SMTP id ffacd0b85a97d-47fec523d1fmr18139537f8f.10.1786022732116;
        Thu, 06 Aug 2026 06:25:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79a7302sm6663653f8f.1.2026.08.06.06.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:25:31 -0700 (PDT)
Date: Thu, 6 Aug 2026 14:25:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
 ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 vladimir.murzin@arm.com, will@kernel.org, yang@os.amperecomputing.com
Subject: Re: [PATCH v2 13/20] arm64: percpu: Add infrastructure for
 preemptible this_cpu_*() ops
Message-ID: <20260806142527.0c784b42@pumpkin>
In-Reply-To: <9c3feb9d-3111-4f37-90f7-3ad3c2e094c7@kernel.org>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
	<20260804170503.3513916-14-mark.rutland@arm.com>
	<7df18d5e-886e-43d1-b53d-52a1d08aba49@kernel.org>
	<d600d0db-5109-4386-9a49-955be74cc432@kernel.org>
	<anRuT1Psmar9mW5L@J2N7QTR9R3>
	<9c3feb9d-3111-4f37-90f7-3ad3c2e094c7@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 13:32:52 +0200
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 8/6/26 13:21, Mark Rutland wrote:
> > On Wed, Aug 05, 2026 at 08:47:08AM +0200, David Hildenbrand (Arm) wrote:  
> >> On 8/5/26 08:45, David Hildenbrand (Arm) wrote:  
> >>>
> >>> FWIW, in a recent discussion on some prototype hacking [1] we saw some overhead
> >>> in micro-benchmarks that would really hammer on a path that would now do a
> >>> preempt_disable()+preempt_enable().
> >>>
> >>> Switching from preempt_disable() to preempt_enable_no_resched() made it turn to
> >>> noise. Of course, that has other undesirable impacts, and I am not sure if we
> >>> are in the territory of code layout changes affecting the numbers.
> >>>
> >>> Just mentioning it as some data point.  
> >>
> >> [1] https://lore.kernel.org/linux-mm/20260630174852-mutt-send-email-mst@kernel.org/  
> > 
> > Thanks for the pointer.
> > 
> > IIUC in those cases you're using preempt_disable() .. preempt_enable()
> > directly, not this_cpu_*(), right?  
> 
> It was purely preempt_disable/preempt_enable experiments without any percpu stuff.

Did you check that preempt_enable() isn't likely to speculatively execute the
schedule() call.
Even if you write:
	if (unlikely(a == b))
		function();
the compiler tends to generate a forwards branch around the function call.
Since the branch is likely to be assumed 'not taken' the cpu will
speculatively execute the function.
Adding a non-empty else clause (eg an asm() comment) should get the function
call out of line and hopefully not speculatively called.

This is likely made worse because the condition is reading the full 64bits
of a location that has just had 32bits written.
This almost certainly has to wait for the write to 'drain' from the store
buffer before the read can be done from the D-cache.
(A read of the same/smaller size might be snooped from the store buffer.)

I'm not sure of the mis-predict penalty for a typical arm cpu.
I see ~20 clocks on a Zen-5 for a simple (value in register) one, here
I suspect an extra 5-10 clocks get added because of the memory accesses.

	David


> 
> > 
> > If so, patches 5 and 6 of this series [2,3] might have an impact, but I
> > wouldn't expect a significant change unless you're calling
> > preempt_enable a lot.
> > 
> > Please beware that it's not safe to use preempt_enable_no_resched()
> > UNLESS it is immediately followed by a call to schedule(). That's not
> > documented today (and I couldn't find a good reference), so more folk
> > are likely to be tempted to use it...  
> Yes, that's also why we abandoned that (including for various other reasons :) ).
> 
> preempt_enable_no_resched() helped to identify that the preempt_enable() was
> really causing the noticeable overhead, not the other minor stuff we added on
> some hot paths.
> 

