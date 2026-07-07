Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8724E2EEE95
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 03:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394450; cv=none; b=ZKNtTF09BqxUEqoARFZEwoTXfZg7H2HOIhJO29EDDIMxa1XZLqFrT66wsG4h5PseZSMzOv+CQV6S6UvmLkyZPF5S8huEdji0JNZ4E3u1cjlOuzeCJwDiNMtWFSdHpTWWfkl8sIGhoWb6CrJLB73b+14udqu+ys2eS4u/xLyxVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394450; c=relaxed/simple;
	bh=dQV/CiU/iqAz99nUMSlO2Rjk3UDc96lFE+tP58d/mbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fmec9GVmdZadwrALpUuFLinKA2kSVTEJxoTKET4403eVCwfir2aNa3/TpOP/yo6uMnUwZlSIblJDt6easSG4nFLr2mUVVeQHMRG0iOm12juQQOF/AjnEqnqhRdUnXatuMNhnmMWIp9zSRt5xeMFmlZBpFgqF2cRnm0dY8cUvOVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nhoward.dev; spf=pass smtp.mailfrom=nhoward.dev; dkim=pass (2048-bit key) header.d=nhoward.dev header.i=@nhoward.dev header.b=v3EGpege; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=hz6HQmJl; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nhoward.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nhoward.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nhoward.dev header.i=@nhoward.dev header.b="v3EGpege";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="hz6HQmJl"
DKIM-Signature: a=rsa-sha256; b=v3EGpegeBYyTx2MZ2j+4meSc14Q1y2Vr5xF5bnNhC9ruC7NzLVy6lxdeofAK+9qXX2nRQ7vYtvuqPWccRMx5AXD5KLA15N9b3AnkDLRQET5yLG+E0129c2J5iMPM08XU5uVorAVjvgczhx4pWV0NTba8rtucQfw8f1HUOKM79kTR0TFcLeTRQ74A2RLQqpTyvTaBdeWQo1B+kUyKWTqTjxp1L7QJzvPVEOsTVaM1Qufp8+806DKMvnCJFyxAzSvKxxUHjgGnC/6xL3rtXytegoSQ3bBtWmGODgrRx8aFjP3Bohp4W2YnD+9d1LMfAPZb8po3BtOLnnD8javjNNGV+Q==; s=purelymail3; d=nhoward.dev; v=1; bh=dQV/CiU/iqAz99nUMSlO2Rjk3UDc96lFE+tP58d/mbM=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=hz6HQmJlQz7UQNgnl5W4nUpl24+nQIPXmZG5G1/pQlb7y1R+iDfh+E2t5tZ81Gb3hxcNcOjejpKxvkZAehLxMmOsK3EsfONsmkRK/22otUgxpTWdUz7MOyxeiaCCBGoPHdjzj5kqY8OB+82y1ivb+G79y9nNdYD4irZODYH+/o6ttNS+QGXPWJi1bcPWJZ2W6VGZ13WVCDGAHSJRQwJP0lgGEMs9k7kDcUHTJhUTTdUC2mFlo1Z00bV7RyDQfvycWnswKOkp18q9yq3Wy+ctyRlMmBYdM6DPQsgsIEiow0nFmqTDhDWvX8YrF7Ah0w44etGG07ep2xvKhsej2HPLMw==; s=purelymail3; d=purelymail.com; v=1; bh=dQV/CiU/iqAz99nUMSlO2Rjk3UDc96lFE+tP58d/mbM=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 823466:39853:null:purelymail
X-Pm-Original-To: stable@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1306190242;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 07 Jul 2026 03:20:28 +0000 (UTC)
Date: Mon, 6 Jul 2026 23:20:26 -0400
From: Nathan Howard <kernel@nhoward.dev>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Yingjie Cao <yingjcao@sigvoid.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: only accept IBSS channel switch from our
 own BSSID
Message-ID: <akxwel29T0_gvu8Z@gpu1>
References: <20260623090437.13198-1-yingjcao@sigvoid.com>
 <c3fd8617849368e579a56c4397b7ee8624ef27ad.camel@sipsolutions.net>
 <9201d828365fa2b11fb6a83d1ff66365435a9072.camel@sipsolutions.net>
 <ajrfKAmdZnPPkGKE@gpu1>
 <b7dab24792025a5a95b719ef7d508fb109859ec1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7dab24792025a5a95b719ef7d508fb109859ec1.camel@sipsolutions.net>

On Mon, Jul 06, 2026 at 10:53:33AM +0200, Johannes Berg wrote:
> On Tue, 2026-06-23 at 15:31 -0400, Nathan Howard wrote:
> > 
> > So, what's the litmus test?
> 
> I don't know, tbh.
> 
> > I've been watching this list for some time
> > now.  I've seen (what appears) to be an ushering of distrust brought
> > on by llm's.  This also seems to have come into prominence within the last 6 or
> > so months.  I understand the cautious approach, but what if one's been
> > working diligently (and quietly), and has spent many hours studying and
> > preparing a driver series (for oneself and submission to the kernel)?
> > I've always done well by doing my homework the hard way.  But now,
> > submissions are met with skepticism... that the work must have been
> > assisted-by if the person doesn't have a track record.  How should one defend
> > his work (I'd rather not share credit with a machine when my work is my own)?
> > To be clear, my question is sourcing from what I've seen to be trending
> > more recently whereby several submissions have been ?softly? tagged as assisted-by.
> > Maybe they were, but my point still stands.  Kindly provide guidance.
> 
> I'm convinced that if you've actually done the legwork you could defend
> the work you've done. If you're willing to go on the record saying you
> _didn't_ use an LLM I'm even going to believe it.

This sounds reasonable.

> 
> But if someone's sending "critical security fix that needs security@
> involvement" across a wide spectrum of places then yes, I'm going to be
> highly sceptical they actually know what they're doing on any individual
> one of the issues.
> 
> Like here. OK, this one didn't go to security@, and it's not even a
> wrong fix, but doing "Cc stable", Cc'ing half the world and not
> following up *at all* are all bad signs.

As does this.  Thank you for the guidance.

