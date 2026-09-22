Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5D3C1D58;
	Tue, 22 Sep 2026 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092880; cv=none; b=UBW51D+IIeaqI3KKjmXNsQRBLLWNbxcN0XWUSAs9gkMmhFGillZlqDuQyk+KFsoYUA13A4iDLA4TA5DemNwXprM+mjN6RvExUdXZRpxUd5GK1e214X6JGFi+6Z/ulO2VvUALrGJyh7OYxBZg8fNARuWucRKsqwQBZq2pfoquKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092880; c=relaxed/simple;
	bh=1BHDXP9SPa86TCNoGFU/GPnUzSH1ghF5dYA779LFE3U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mJOGmjvif4xJlO/I6Q6sw8fg1bEUJB6TC8QWbFuA7oeSEs9HOww77NlA+yCD2Peo5RAlmaxgMAugVKoe36Icwl+/LAy3Vv1o7Iu2rXDqM39gqNjdlukY9Urn6DvDln/A7XWzRLWPDOsuLhIq+2S3WQdZ5OSgUoFC0QV34vflNIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=serow.io; spf=pass smtp.mailfrom=serow.io; dkim=pass (2048-bit key) header.d=serow.io header.i=@serow.io header.b=Zbq76+3P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S7GwnU19; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=serow.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=serow.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=serow.io header.i=@serow.io header.b="Zbq76+3P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S7GwnU19"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B71637A011A;
	Tue, 22 Sep 2026 12:01:17 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-03.internal (MEProxy); Tue, 22 Sep 2026 12:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serow.io; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790092877;
	 x=1790179277; bh=1BHDXP9SPa86TCNoGFU/GPnUzSH1ghF5dYA779LFE3U=; b=
	Zbq76+3PvnXmDd4Pce0gfTYk2ZYQaOpxyjU8jzkxS1C0r6BPDc6/7+SFb7Mx2N4D
	5JzSQ/VrmMr2lVChJnV/jE/ciUhYLFm2WAJrfGno4Gw1NtvMi6km04s/X1mBEVx/
	dW7OqYbW4EwBsV3oq5ZkwtcVUgFu7DyQ+3zk0T74T8N8vjeIV/Ck4H3Opoy8s+Ap
	X2xPa3+atSunXcRsBUMUXiijQtzJEwnIEGgkc9Z0a9rDCsBXS7G5d+Uq8bCXhJm1
	oD48s/ixprbF5wy6rf5TOjSFQnAbaWkw9lWD7qMZn4hBw3fx/Whb6Z5eZ/diL8IM
	+JDSNspyJwbAlUrioOPLhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790092877; x=
	1790179277; bh=1BHDXP9SPa86TCNoGFU/GPnUzSH1ghF5dYA779LFE3U=; b=S
	7GwnU198JLRCb1RYhTluCJB/pRR4qaAhusyy/Hh/W+8jDpY5Sefiqu1Zrr8qypUd
	i6v09M/lhzKDxxna0aIdkPZYrsdjSg8aP98kVH/FIG7YbcnbyaND4XhWzCgIxLBA
	F1ee/kNsCIMr5wNkY2T1kYVKHaW9wWc01YehDlbZmu5lc/UNLOu2FshbFc0biSpd
	uZoWy3lAtXzgzksA/uxTKucCAT3HSAcx5l+ARE4hm07uD9BawyjaRG3rDCR/AwcX
	KQ0tQzk7/UXzWeE8uzMPv0wpEPKoZZqTS6c+bRHvoV5Ayiben+tNZgBXjfm3Ox4F
	8fXanlISCDjbhpSpUQ5nw==
X-ME-Sender: <xms:TKayasjU9gzu4YipKB2vH2NiQ7YoaYy2L4Wk7oUyomLF2YFPFE2Kag>
    <xme:TKayav0cM7xm54za7sQ-0oIPbJAgVEERkPGfQg6st07pDJJMIJYrW_yBkypnoIRhF
    OnvDOd4EslM2dBWMlRXJNbrh81fJkYKGunhcIrD7VoA6uVVBSwsmoY>
X-ME-Proxy-Cause: dmFkZTGZK6nRv/cWj1JAervq2HUjZNYdf1ALSojhw2bph6pxt8KAy7u2nJagTsH/t8+j6+
    sXxdyBted5V4lyH1RUoCShfASvA+Bjl/NVP7ntodf1n/GCXoAIK+oQxXGugjLrgv2KJhpa
    9OPZOh4usGD88VP1Nbd/d/2VT5NRClzuW9miF97VpGZ9V9HRFbIdR1wT+gFbhr4XsW6Spm
    94Nm3xKltOsL9NllXGz0xN/nfi+ef67IrCwVXkjpjL6Aevp0JkH4Ky7SrITnHagv++WuLA
    eMfKbFmVNbaxxb7S1hE/ZrIsIWbetB+KaHUofcfwmj+XtwN8bz1u+qaCTKrLaOD82sF4Ej
    q5ad/dcvYFKfzE5S4dClNqxJoq3cGwrBBTn167X83vJ2H0hVl23mrc/zdvVw+MJgHZIZEV
    R2DZUKwNM+YJ7dJV7oDiXUvB2weg2E75m+DPf90VkE5JyqSPsXgm73uBo74NEIwxQiQ1GT
    YoQJ8BInX3iScnqUgI6oJcJ6Cf807S98GalT0cLkpC/cJq5dIpxDUsw74h4yqNi2YTXUAj
    xVj0kHUUFGPUpIGBF3ka3lyMLpoQyMYX3iNjBSoom8HrIh7v17Ih8KjZGSh6xBUvtCD0KO
    E8fSI5RKVIQz+95R0TltxRvhHNrlOQxApmO9DicnNoDDiBYr9kCbhMvCNNDg
X-ME-Proxy: <xmx:TKayamYj5uYTklu7kmBHqBaYZFrKvlq6El9p1PZFfgt4otgBRI2b5g>
    <xmx:TKayahiI0VTYIZGXxnU8bc19GDgnGvCbypmgL4xZoGkmuqjsQju2Ag>
    <xmx:TKayageQNW3PaItIg0riv4BPyZmePByUpiCopAmn2en0vQKcdb7R7w>
    <xmx:TKayaokbE8qgAQPdXZugMmscIMiWVMfitblTbff89SE2g-N0b1vJCQ>
    <xmx:TaayasSnUawkpPIwBzmSZzFjYvGTuimC-GdwqrlYj93u_i5oBxhy4d0U>
Feedback-ID: ia6364811:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D2D632CC0091; Tue, 22 Sep 2026 12:01:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 10:59:22 -0500
From: "Grant King" <gking@serow.io>
To: "Sasha Levin" <sashal@kernel.org>, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>
Cc: linux-input <linux-input@vger.kernel.org>,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Linux Stable" <stable@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Antheas Kapenekakis" <lkml@antheas.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jann Horn" <jannh@google.com>
Message-Id: <dd81d216-cab7-41fb-b678-ba235ef603c0@slotpi16m74>
In-Reply-To: 
 <2026-09-22-daily-reply-0005-re-hid-asus-nkey-regression-report@kernel.org>
References: <069bd866-4eb0-4c42-bcf4-6983ba59aa49@slotpi16m74>
 <2026-09-22-daily-reply-0005-re-hid-asus-nkey-regression-report@kernel.org>
Subject: Re: [REGRESSION 6.18.48 -> 6.18.49] hid-asus: ROG N-Key keyboard dead, also in
 6.12.y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 at 15:39, Sasha Levin <sashal@kernel.org> wrote:
> If you can confirm the keyboard comes back on the GA403UV with that
> commit on top of 6.18.49, I would like to have that before it goes out.

Will do. I am building vanilla 6.18.49 with e82ae34af29e910 on top now,
and will let you know as soon as I have tested it.

Grant
