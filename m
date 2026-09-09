Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405E4A9D40;
	Wed,  9 Sep 2026 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949220; cv=none; b=peTwuhhkSKyeVJTJ+2xerVHFgz+GyzFefXXDp0b/FT+BqLBeOIKU3WoEU74Hrl2ZpkkigB3yAu5NdKkAS4klB6F/yVBAi112r7sa7gUfTt4ZgNQQv8uiJgxLRGbrGI6JOnMgEqh0FJ1lEOXXmYP/yR4QFNOvZkRAKgQAB37MyYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949220; c=relaxed/simple;
	bh=mBPR4cecML1kh6RTYb53KQpz2q3r7URs5G4kBDlwPhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZCMqpZ2t5zceWndn7PXGMT3OfABXtA7OKnwbAyUieNhzPup4aBxaj0XnxOwLOwjSfZdCwFKIfuBMeyBz6dw8/xvVq8YvRzCSNMtFd9HZ46lcnktdkwLuohGBdDTPgke0Fqq053BSpAGOiy8thWzqDlec0PMDGaTMDYumH8EM/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fAid1gGw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fAid1gGw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8+z6Ftb8zC9qlYEEPdn0U4Tt9KrgEhALmOxawMxUgN8=; b=fAid1gGwDlR5OM76t/5g3RX/H5
	r0tF/i2ohl9vRjCk3fDh6aUp+92blksfcBlKyBYS3GLkMMv0n46lTWaSS272ebtRsEaiOvR2uMRno
	VXBC8U2MfOBBHRCEPKU+QtiPhrP38CBWbzbmw241NbmAczHZ/Dc0297WSAxKqwgCUZfq4u9j9+7Sh
	5xS+Bna/YSREG48FsjgJjHTiLtSKDx7NqcyBgMfFbnv5Aky/pJVtDAXZXIoIYJzhKLI4XggybX5BB
	+5GojnB51qlgFLjQOnVEiWF4oySm/jgR0jTX811JeoSFXz/c0N/mzMpeKWtJTDXN4CHGBwtJpvzmW
	dtGwfHyg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4FPX-00000003u71-3skG;
	Wed, 09 Sep 2026 10:20:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D866E30036F; Wed, 09 Sep 2026 12:20:09 +0200 (CEST)
Date: Wed, 9 Sep 2026 12:20:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <20260909102009.GQ788244@noisy.programming.kicks-ass.net>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain>
 <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home>
 <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
 <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909095518.GL776954@noisy.programming.kicks-ass.net>

On Wed, Sep 09, 2026 at 11:55:19AM +0200, Peter Zijlstra wrote:
> D-E is a UNLOCK+LOCK hand-over, which is not quite the same as
> RELEASE+ACQUIRE. Specifically, we have:
> 
>   RELEASE+ACQUIRE: RCpc,  only the CPUs involved agree on the ordering
>   UNLOCK+LOCK:     RCtso, the hand-over is store-ordering
> 

For those that case: UNLOCK+LOCK is RCsc on all architectures except
Power.
