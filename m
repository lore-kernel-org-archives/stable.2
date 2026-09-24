Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A03E7BCC;
	Thu, 24 Sep 2026 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291875; cv=none; b=fzb+umYNSyOF2+KMEdLORI/8o9btRSGN+OGVovZZAfSxjmnE7a+20eIqIkpruIHWOaLiqfiybtpVRrSdwQAZPcw/NM3Xc2l25V1QK/ZD/6t0vd8sPpIkOfzIP4R+xUiykp0Zs20n/3JPqwaJSBwDJIitskaeifFSDAlv/fiqv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291875; c=relaxed/simple;
	bh=r37+e0dh3/Jf+/sV6I4N0uWhgQXrQi0HnMIftUzmUzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnteIiDhVCCElyCb7OUf9AV8dPzfliNGx1GeANatATZmh3bIeZTee4bS5Ox64Sw03VBAdclrJAV7mp7WHjnXhIbGh/J2jrlGXDx5dIi9CwjPA0E/mpR8Ukn8JsIyr2r+PEmdXXRjUp27oshLS9JTq/2VXpabqeFt94v66QdfzZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=gfiYt4Bh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AI8jySSI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="gfiYt4Bh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AI8jySSI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5A9B51D0012D;
	Thu, 24 Sep 2026 19:17:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 24 Sep 2026 19:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790291871; x=
	1790378271; bh=EkIBzmmhG1qNHEaj05MzODGJ1wqq2yv0z+g9/Um+w3s=; b=g
	fiYt4BhK4DTyYOkkX22mOIS6BtPaz8ef37LEUW+1i8VQX20sRizfVM5vTutJ6IoG
	0ewaRriMf6wqUe+3j8Dqyh/GTag+a+C4fEEQ3SVZztcXCHmpkelpiI2rB3q2apTN
	tQUQQDx1tUViEVcUrXnhlBcqzRDYM3Zl453ffyJ9rDcRCmVNhS9cRx7TBTI1USq5
	4LG3WA5iXRwP1VYRA/E2ANK9ztE1Ww1ESUsG/mpnK8T6XsFTdmMnVGBjDSciayNt
	OzKQwzAa9ZN0fbg/SoXbWnNZPL5cBg/3pDCNMfNzV3t7n6AgSjBEDB+joDOFEP/y
	pdjxNbDoN7QlKEXlEKvJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790291871; x=1790378271; bh=EkIBzmmhG1qNHEaj05MzODGJ1wqq2yv0z+g
	9/Um+w3s=; b=AI8jySSIPhknOivQkd8TQ1xquNo/7OkV8Y10hcChA/HRbq95/ey
	9bZR1x81deKQNKmfQm6+jmPbypUbc2GjNcu/WpAB25oP/5DHsUnZmBG9ipVpATOB
	BjrqoRYJvNAseMcU2H+baahMZH1KpvYgkvR0FYQlfH152zphOt+ut1J3+bEJ/p45
	WZYCHTun08f8ZqS2hEX2Wlo0RDIu0e2+jl6JlhQz/WDZu1TB5ONZcp2JWmzPmjFo
	TB/RO4G32LeDkHzkbXRvrmFU1XVlAz7Zfs0LCH2l+SVAv9TPYdgnebhCVhOfIR1a
	nD16o2NDgtREoS5iLXrCoPD5k4ASzfWgVaQ==
X-ME-Sender: <xms:nq-1at5Q6u9-MVK3GCF856cRI-oP__T6KfxSFGz6y6bZnCI9Nxg9Gg>
    <xme:nq-1amUwqgosLN5yyNiy3G3pvTrR1lZ5OaHx18Hz4VYev1yYYMT2sKe9uFL_-kkw_
    Nn075gljRdmaCdVAr0A2-Pv5C1K06-G1hKLDugQsRyog_W5opA0IWg>
X-ME-Received: <xmr:nq-1an9s-CwHqdZ72zMfS2DOa65i3Lt2hdhIomF7dfkHfr09xnYm-h7LuvdFNp63i21ZKx9yoEJBz7ajhLQ-Jw2Z0Xk0RQ>
X-ME-Proxy-Cause: dmFkZTEmnFfhaopq8cy1ZF5DbDxloBLOWH5DGQyfgzbPpBh517TTO5P5ao/xK/agP3KgdL
    2ClF8MXx7KeuwQIDtbdx0kjaZTef2YxHXClHx7WuW2F5TJRkcI+XIiCt4iPNB2i2FdNwEo
    Zk5BEKVPpHT6aoBk44qQUhkvtwe3vZnjebt2/+Qucus6YhDpKpXtf2J0dJyxHMwPv07YUX
    f4p6/jqRFxvOc7xdZ/9dqSOuSVzGTEGBFlfwdDyXUDl8AsxKaHtVMtp/gqMtFJmVWAr8Bh
    5J65rc9gaaHgNNkKOE67UyVxcrlIQMgaLRl6gCBJ9Lg1H6xfUaydXylq04MFVyhnmAMvPg
    hlQJYQ/onQNi7dQHQfbOBmyuF8LpsJS6WSAsWhjZ8G8YRQQ7SRerc0ogbhBKakNzc/sM2B
    1YQMzebfHG8xVUvtoIbogTHDROBqYYP2fcqgc2f8wCnRjDQSxP/pabMAMqFDyQ7xE2EG8N
    k5Cd7zNjglZEtfKZx+/4I7vJhHOAPp7yF6VUIFEhkfkp7ZhWGRscAbi3kp7DgVnZUqfQ/l
    HDWSmPwpPAnkrSFEvQnmFaMqC98jZBdA+9JlhtLwHsPWDR4XtnCRIULlWLGZIo7XZ0Tap8
    kxVBNBnGCi0zqEkSb4gph+eSI6eqskoFiSowNszUEbDMali9PEsZHlYfeDAQ
X-ME-Proxy: <xmx:n6-1aqkygZmbC4JVLuEC9NQqWEidnUVPr9nsZavygkYFX9HtDtRhIA>
    <xmx:n6-1atX6ZFRHSYgFhay3TtY5fSMPhbhgqn2RYQRYy1ELaHZC3FcPnQ>
    <xmx:n6-1avFUVyBQXwzdyi2d8QdmpEvYfoSnOiNomv2axwBIiIbsrgDGQw>
    <xmx:n6-1apdtwbwNJH3l0v75vUh8vl8nEulzh28cpZU98ZL3GbN9ba8Dlw>
    <xmx:n6-1an0ucwozN6PoQPe2OwYly5JgCXjg8i_Qj7MvSEhygMpItgv_aayo>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 19:17:49 -0400 (EDT)
Date: Fri, 25 Sep 2026 08:17:46 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	stable@vger.kernel.org
Subject: Re: [GIT PULL] firewire fixes for v7.3-rc5
Message-ID: <20260924231746.GA344870@sakamocchi.jp>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	stable@vger.kernel.org
References: <20260924032636.GA314300@sakamocchi.jp>
 <CAHk-=wjRVQhcCGHCA9LL6oPf5CQe2Sw2ru_Bm-qJz_bp-dZVmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRVQhcCGHCA9LL6oPf5CQe2Sw2ru_Bm-qJz_bp-dZVmg@mail.gmail.com>

On Thu, Sep 24, 2026 at 06:07:48AM -0700, Linus Torvalds wrote:
> On Wed, 23 Sept 2026 at 20:26, Takashi Sakamoto <o-takashi@sakamocchi.jp> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-7.3-rc5
> 
> That's actually not a signed tag.
> 
> Can you please re-do it with the proper pgp signing?
> 
>                Linus

Oops. Indeed, the tag is never signed. I overlooked a mistake when updating
my local tool to create releases. Thank you for pointing it out.

I correct the tag with my signature, and pushed. Would you please apply it
to your tree, instead?


The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-7.3-rc5

for you to fetch changes up to c6b51091cafff9ce6c03c1416aa13864d17ab97c:

  firewire: cdev: fix back-transition for iso_resource_auto client resource (2026-09-23 09:20:17 +0900)

----------------------------------------------------------------
firewire fixes for 7.3-rc5

Fix a race in the cdev layer that can cause a fw_iso_resource_auto object
to transition back to a previous state. This can happen when a file
descriptor is closed while the work item for the object is running. The
race can leak several memory objects, including client object itself.
This fix should be applied to 7.2 kernel or later.

----------------------------------------------------------------
Takashi Sakamoto (1):
      firewire: cdev: fix back-transition for iso_resource_auto client resource

 drivers/firewire/core-cdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


Thanks

Takashi Sakamoto
