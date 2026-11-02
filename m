Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631316;
	b=wzCZ4Bc2AU6q7chLE2csO3xDClJCwNf4RDlXSnmD1Js0BeO5x7LzI/f2WXwhzwjrmiCG
	 zaWHBvGO/G1LsFEaxa72qJeYbotQFeheIJyEEKcfNNb0eEStcgUAtwOWDapiaEic6M15E
	 P4u2bHvOoqkF0+o3KyndHGqdDATWcd5AIDAKv0efj0+FTGbPF77iBwFvQAWy8EGZNAKLG
	 CR3Zss0QZ7gkNHYrSNQ+7O/VNhyovRhh5HErVE4mMfF7crWfi8Vh5+OmDb+nmhZkAB60w
	 yQVGvlYtMcqXBrCjP4MNQeH5XnKxi2EiUq3/uHrEl2syuwgOnyLTBMPNmuTIelSADQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631316;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AY0v1jj+Lfw9X7v3boXRH5QP+ChZJNYF3majuLHichI=;
	b=qIlxRKKgBbGeZe2V49VATm54Rc8oM7klT8gSBnbydWcpoYPwCVxnD52AJCDx+iexy3aA
	 +9e5QefpwsmX7ne4x+venG+zOXUOaR0ipoKixDeX9+C10dwfGPj5bK5wjNA180/6N+WWE
	 VqJPkucooA781zr5aotYhA6suzx2c1lcmjbLsO0vcZi82S17p+r3tJH/PkEMPcrfFOa/c
	 EvWWcaEOXsWGRNf9e0dw3eX/bZsAEyoY7OHmUiyfb1c8zqXhs3qI+ucywfplAqLLjmh/M
	 IAAtRQgq0uLLWasgEYlJYZonbRWIyzasQWtmNB/vemGSUIyc6kU4oRlsvZ0O60Wt4Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMcrXPrR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6E132606A33D;
	Mon,  2 Nov 2026 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMcrXPrR
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B49AF1F00A17;
	Mon,  2 Nov 2026 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631316;
	bh=AY0v1jj+Lfw9X7v3boXRH5QP+ChZJNYF3majuLHichI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RMcrXPrRIWgnhvODEQJmURlgvykhtSC0hwl6bHGO3DHh6qL0OddixVQhw/wpsUiX1
	 zeGT5GtZibo4OguzLItLAJi+VXMTsVLeEYkFG4WwWia6+Lo9nnH66feYXJtdt6juwq
	 l9HUuG0s9ITlaaYCcvJ6X6kZhqx/g08Pw5UpsKBKKSFKFTAClGTCfyI3XJqLX2uKgC
	 yL5T9/rkSQZa2seSAjhRNyAiimAqop+AzparLq6+2GpkfZdi1fE4W2wLkBasmBdSM+
	 nk2vvDAjNxk9emGuuLq7YcVXR1l3bBqJJnDRN/iBus6yTEhpkyUJCw+CMJH4S7rHZB
	 lrMJTGeRDXytQ==
Date: Mon, 2 Nov 2026 15:55:10 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Kent Gibson <warthog618@gmail.com>
Cc: Adrian Ambrozewicz <aambrozewicz@nvidia.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
	Jia Jia <physicalmtea@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 6/7] gpiolib: cdev: don't report a failed line read as
 an edge
Message-ID: <fymge7c237d6kqizljn5ppyqz4bn65cbfzkjakt76mmtgd3dse@hk664lcwt6yb>
References: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
 <20261029-gpiolib-chip-removal-v4-6-aambrozewicz@nvidia.com>
 <20261030111435.GA76958@rigel>
 <20261030123109.1935475-2-aambrozewicz@nvidia.com>
 <20261030134639.GA94733@rigel>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030134639.GA94733@rigel>

On Fri, Oct 30, 2026 at 09:46:39PM +0800, Kent Gibson wrote:
> On Fri, Oct 30, 2026 at 02:31:10PM +0200, Adrian Ambrozewicz wrote:
> > On Fri, Oct 30, 2026 at 07:14:35PM +0800, Kent Gibson wrote:
> > > > Fixes: 61f922db7221 ("gpio: userspace ABI for reading GPIO line events")
> > > > Fixes: 73e0341992b6 ("gpiolib: cdev: support edge detection for uAPI v2")
> > > > Fixes: 2068339a6c35 ("gpiolib: cdev: Add hardware timestamp clock type")
> > >
> > > How did you determine that?  Those commits are where the associated blocks
> > > of code were first added - not where the problem first exhibited.
> > 
> > From the hot-plug case in the message: a driver's ->get() error has
> > reached these checks since each was added. Removal is newer, as you
> > say.
> > 
> > > The failure mode you are addressing was added by
> > > commit d83cee3d ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU").
> > > Prior to that gpiod_get_raw_value_commit(), and gpiod_get_value_cansleep()
> > > and gpiod_get_raw_value_cansleep() that wrap it, wouldn't return the error
> > > that you are handling.
> > >
> > > Could you bisect to confirm?
> > 
> > Confirmed: with gpio-sim and delayed IRQ threads, a falling edge
> > during removal reads as falling on the parent of commit d83cee3d2bb1
> > ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
> > and as rising on it, 10 of 10 each.
> > 
> > A test chip whose ->get() returns -EIO gives a rising edge on that
> > parent and on gpio/for-current, none with this patch. pcf857x and dln2
> > already returned such errors at commit 61f922db7221
> > ("gpio: userspace ABI for reading GPIO line events").
> > 
> 
> Ok, so the driver ->get() itself may return an error if the physical chip
> has gone away.  Hadn't considered that path.
> 
> Could you update the commit message to better describe that case?
> 
> > I would use Fixes: 61f922db7221 for ->get() errors and d83cee3d2bb1
> > for removal. Is that OK?
> 
> Not sure - I'll defer to Bart on that.
>

Rule of thumb is: the Fixes tag should point to the commit until which
backporting of this patch makes sense. I'd say your proposal is fine.

Bart
