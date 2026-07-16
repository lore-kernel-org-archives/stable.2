Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22353B7B76;
	Thu, 16 Jul 2026 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202081; cv=none; b=ROmThAWPsP2n8xRmv6RCLCxoFYOMMRbEEXW2FHRLzj3loxrBsgDAInkpzsgm3ykWxYkZUl8/gigr7VdJk5bWkujFIuEREVjqMIe+NVoll6KlcsAGXK7r43TehYuedA/c73hqJoRWhhNEPL0VvKmm8AsBrJoJFilrRL4ezXQZuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202081; c=relaxed/simple;
	bh=0UmkqwZURdtWHsOhOBMXQJKIFyNusAcmGEShjzYlDUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8biKycKaMvv5ReFrm3ePXyqImTFoU9ZfwafBtxAgyVLqw+0jrBZOi6v3na24IK5mJs3hp3Fl6gnsOSfRfDja04160UQxuRxyhwd2nJ3GkGrykAJnwHDpJvK6MAhxoL5GiyiS/fPtrTl8dG3bVmgFfchmFDdt4TH0Ng5U6Ru9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLQCsOvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLQCsOvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082831F000E9;
	Thu, 16 Jul 2026 11:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784202080;
	bh=grDZaGyfnFIbl0HnHUmAoC7mK+T4iKzmAUaf8qnyAes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SLQCsOvntAMnb0LHNIOyGpgp4PodvokR8+JjWhIjwgv9tnm/PZNswwn/dajUDlUyh
	 e7bRtGoK9Yrc08H9CtcxBE4uMaRv5AVSrElNZ5o/phNWImRMzF6B4V3KBXILJqcKpL
	 Zo9LCNODyfT8ifoqrUa9amfFcSfxa48SafSMcScYTZVcir1A/G80F1mFGZGHIdeolT
	 Ii2AkXpWUTS2KPoXFG/J4wTvE9SCEkwQW0A+Aj7SwXsDqGgMFSAcL9BsfMxEjI9u+G
	 p/zwjdWb3elZnjA7aLWAceBn1p3y1AQWNO9bnllmjVrYtuSGKwlipuDvnzMg1BLAqU
	 3dOAlQ+D0kQpw==
Date: Thu, 16 Jul 2026 13:41:17 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: jz4780: Cache clock rate at probe to prevent CCF
 prepare_lock deadlock
Message-ID: <aljCGkhZEQHzZVSW@zenone.zhora.eu>
References: <c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
 <alf7rSWaLBO8WBkR@zenone.zhora.eu>
 <36148F30-156F-4E74-8765-D718F6FE7E76@goldelico.com>
 <aliLbNJ51Ns0dIHX@zenone.zhora.eu>
 <9421BB47-EFC8-4D82-989F-82A84FE46749@goldelico.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9421BB47-EFC8-4D82-989F-82A84FE46749@goldelico.com>

On Thu, Jul 16, 2026 at 10:33:56AM +0200, H. Nikolaus Schaller wrote:
> > Am 16.07.2026 um 09:43 schrieb Andi Shyti <andi.shyti@kernel.org>:
> > On Thu, Jul 16, 2026 at 07:44:20AM +0200, H. Nikolaus Schaller wrote:
> >>> Am 16.07.2026 um 00:07 schrieb Andi Shyti <andi.shyti@kernel.org>:
> >>> On Fri, Jul 10, 2026 at 08:58:35AM +0200, H. Nikolaus Schaller wrote:
> >>>> Fix a severe AB/BA deadlock between the Common Clock Framework (CCF)
> >>>> and the I2C adapter lock, which triggers when an I2C-controlled clock
> >>>> generator (like the Si5351) is registered or modified under the CCF.
> >>>> 
> >>>> During a clock frequency change, the CCF acquires its global 'prepare_lock'
> >>>> mutex and calls i2c_transfer() to update the chip registers, stalling
> >>>> for the adapter's I2C bus lock.
> >>> 
> >>> I don't think caching the clock rate once at probe is safe.
> >> 
> >> Ok, valid point to discuss.
> >> 
> >> 
> >>> If the controller clock rate changes afterwards,
> >>> jz4780_i2c_set_speed() will keep using the stale cached value and
> >>> calculate incorrect bus timings.
> >> 
> >> But: is clock rate ever changed during operation? Usually it is defined
> >> by the device tree constant.
> > 
> > That's what you are saying in your commit message.
> 
> The Si5351 clock generator driver is connected through this i2c bus. And that
> is referred to by "when an I2C-controlled clock generator (like the Si5351) is 
> registered or modified under the CCF".
> 
> Only then, this bug faces surface. Because that driver changes it's clock through
> sending i2c commands which also ask for the lock.

If you make a claim in the commit message, I expect the code to
support it.

You say that the clock rate can change, but then you store it
only once at probe time. That immediately suggests that later
rate changes will be ignored by the transfer path.

> But again: how would you solve this?

It's not my role to give you a solution. I'm just commenting on
what I see.

Besides that, is that an issue you have encountered yourself? Is
it a frequent issue?

Thanks,
Andi
