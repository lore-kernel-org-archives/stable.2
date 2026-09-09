Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F805427FD;
	Wed,  9 Sep 2026 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953482; cv=none; b=Vh2HVgwAVNCKW611S+81PKjXLMcF7SNz3BDswEywijmRozH6r0b+9Y6MBMNwGBUYxP4VQEqs9CA9S7RPpkyVGu5707t/jmSdq6QRxbamz7YBFS56s8fOatSmY3hoQYZHRoPzhyaIII/EHqhMJBrtgVDZBw5X9efQ2sBbMSfRTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953482; c=relaxed/simple;
	bh=CXSTc4aPWBj1nAoQ++08gguReR4HielAKPMJkcyXlSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YQPq5R5wTp/y2GgPoZLSHuWRPntdQYenJinlLcp6+E2CU2sOV8C/ap4ixcbgnEIXQeW6ktzlBFv06avpKAKUd8RDGYHEi6HMDk58FzpdZuwi7rdYZlYK/eBrm8CW1i2LxrxFWArsjkCw0bGiSFagojyd04Ehip8/sYCZnzhuIU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmSUhMv0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmSUhMv0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7531F00A3D;
	Wed,  9 Sep 2026 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953480;
	bh=Y3K94U6nWZUzIFTjfoB84YzsIYwmTnR5/k0fa7b89sQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LmSUhMv02BaNN+e9O5o8ioXxKCSy7LH7FYMsv/aN/DzfsHY1OvWHTVveihWz+nlb/
	 JJXoFTrGu/cW7sOadUQdQaoQc0E+8fvL9EnfbB6YCQz3Bs/ZRX1Omyj+kpNNCL1tAw
	 MSjNdAI3JZbYqQXHQ3Rj4OIiiKwAu2aWFif3JqfJqddzkNyXIy1wL1ICME0A3fZwgP
	 MhizTnWxTorTxyvWTFmqUBmE9Nry91LnJnjwjCe3xxTb34EAwsmgHj8Jvf7YePbmM1
	 l1K7rcs682iEQwZu9vhLYGONdiwMRGJDZTnOhPInhYLjUpNqujfmEzuyxmvSpL8BpG
	 RdzKM93/amsgQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, "Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, "Eric W. Biederman"
 <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
In-Reply-To: <20260909095518.GL776954@noisy.programming.kicks-ass.net>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain> <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home> <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
 <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
Date: Wed, 09 Sep 2026 13:31:17 +0200
Message-ID: <871pb21x16.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 09 2026 at 11:55, Peter Zijlstra wrote:
> On Wed, Sep 09, 2026 at 11:08:31AM +0200, Thomas Gleixner wrote:
> Now, I have deleted and rewritten this tail end at least twice now. And
> I *think* I'm agreeing with you. Let me explain:
>
> It all hinges on D-E and H-I.
>
> D-E is a UNLOCK+LOCK hand-over, which is not quite the same as
> RELEASE+ACQUIRE. Specifically, we have:
>
>   RELEASE+ACQUIRE: RCpc,  only the CPUs involved agree on the ordering
>   UNLOCK+LOCK:     RCtso, the hand-over is store-ordering

Yes. I should have argued with UNLOCK+LOCK instead. My bad.

> So while earlier I was arguing with RCpc in mind, in which case D-E
> completely goes away and we can consider B-G' to be one big critical
> section from the PoV of a third CPU (our posix_timer_fn() one). In this
> case we can push A down and G up and have them cross.

Correct.

> *However*, since these are locks, we actually have D-E be UNLOCK+LOCK,
> which is RCtso and that *does* impose store order, so A stores must
> happen before G stores

Yes. That was my thinking, but I obviously expressed it incorrectly.

> Combine with H-I, which has a data dependency from the LOAD to the LOCK
> and thereby constraints later LOADs, those sigqueue loads that come
> after I must in fact observe the A stores.

Right. I guess it's worth to document that somewhere at least in the
change log of this patch.
