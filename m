Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795075384;
	b=e86kCs1DCImo0yv0NChioKIstWq8AWQVSgkcVGGMO6Wb0/YEPhv60mO03XIrFv5YaROe
	 wsMb80PWq3M5E/gakgsDX3YA7NxQf+puKVU/Z0Ykr39Ips2RXiYmpRTzoocXQFCl0i+2a
	 neBP/5mvc2PJswKVQwNHM8rnegw9/bu+4lyqDi453/dafRkcWD8+urdsS6/bysrDQ31fl
	 Ci6RmZy/dBGM44hsFYfoNX82d+ZHt5SLL8vxCjc5Vr8jHz5DuWb5h5zLLzPRmHNFhdL2w
	 owFQbsNClGlj0cAB6Ty4y9HqCnQEYpZq96bbt+MS0+UunUrIwm5d8RpGDEGFxqH7AhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075384;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HLwTOkZME4+q/IRqHLheQVJBWbOBTtkaYUd1FwN2NEs=;
	b=F4XTG2BfurqSs4teJN7YoppA94S9cfGTRK5sfO6AYxNAG0e/pIWNMPlMsSAcZO5lGYNH
	 IvKrGMnx/vjVmthgaV8rNjRpp99MYqW+JRvyi2JMd/YKfd3DtHz25BCiBPps1AcuQ/ZQO
	 2IEx5EZXVITf9L9hfAe8dsOojz+5Ui/wfchni+7XemaaVoMRXiri8NNIlVQn9wTbfUH/e
	 GleL2xyZ3vfh594+irakIS5Sv5lY478pOJJ+hw+ujRerqDEvgzMUOHCKzgB58A0cTYBh5
	 SRynmz1jgZW0VIDhepDEz2+anfakQrhpxw2JP5XFMKb9C4EhSH/ObS1YBCx1Y2vb+uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=H1qypOyo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816C606A320;
	Thu, 19 Nov 2026 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=H1qypOyo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FD31F000C5;
	Thu, 19 Nov 2026 08:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795075384;
	bh=HLwTOkZME4+q/IRqHLheQVJBWbOBTtkaYUd1FwN2NEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H1qypOyoPH/0JEYteoo0AxE4edeunSMtU4MhG2RmUA3Y3LWLOF0zbcsILSDzCLiJB
	 gd45j5Phm3Ydfpp/ZDLxFbTpmjfYg1M5b0oTp0EfwPQaYY7XXwEXYtuhxoQsrg90zW
	 BfaNY0ZIvss8pGCWOW4YX2xTLy+JGEK4JfcQvrVA=
Date: Thu, 19 Nov 2026 09:03:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: workflows@vger.kernel.org, stable <stable@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: Can we get stable patches in a digest mode?
Message-ID: <2026111940-rimmed-swampland-2546@gregkh>
References: <20261118101248.6b90b25f@gandalf.local.home>
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
In-Reply-To: <20261118101248.6b90b25f@gandalf.local.home>

On Wed, Nov 18, 2026 at 10:12:48AM -0500, Steven Rostedt wrote:
> Hi,
> 
> With all the AI patches that have been coming my way where I apply them and
> they have a Cc to stable a new issue has arose. As AI finds bugs from the
> beginning of time (when the code was first introduced decades ago) these
> patches are applicable to go back through all the currently maintained
> stable releases.
> 
> Each release a patch is backported to will be emailed out. Thus, if you
> have a fix that affects all stable releases, you will get an email for each
> of those releases:
> 
>   5.10, 5.15, 6.1, 6.6, 6.12, 6.18, 7.3
> 
> That is 7 emails for a single fix that went upstream. When I have 20 AI
> fixes of old code, that means I'm likely to get 140 emails for them. To
> make matters worse, some of these fixes will have dependency patches that
> get backported as well, and I get emailed on those too!
> 
> I actually like to know what patches are being backported to stable. But
> honestly, I don't care which stables they are being backported to. It would
> be really nice to have a way to say "this patch is being backported to
> these stable releases" and not a separate email for each release.
> 
> Now I want to say I really appreciate the time that Greg and Sasha spend on
> doing these backports, and I hate to ask them to do any more work than they
> already do. But because I get so many emails for stable backports I tend to
> ignore all of them as there are too many of them to see if there is an
> issue where one of them should not be backported.
> 
> Yesterday I added a filter to simply filter out the stable patches into
> their own folder, but that means I'm pretty much guaranteed to ignore them
> completely.
> 
> Does anyone else have any ideas on how to improve the situation without
> causing too much work for anyone?

Sasha had a script that would do this for the patches in the queue, I'll
dig it up and see if I can get it to work next week.  But that would
just cause one-message-per-patch showing that it was applied to multiple
queues (note, 5.10 and 5.15 are going end-of-life in 10 days, so that
will cut down on the "noise" as well) so it might help out some, but not
a huge lot.

thanks,

greg k-h
