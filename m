Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BDD30B50C;
	Fri, 17 Jul 2026 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273278; cv=none; b=ahhBeHqv5YwAzmId1Gv+sEejmRcIkLa1uxcyE24fV1aQs+lUnF0Rjy1lkthh4z9NOlh8Iu95T1r59fjmPq0Ye9xmK48Y21jIqOvVWjmDOO45I12tOQ/h6yX1e+mlSezXArplW5J8fJHdNn/at48AR58fgAgx5KSPYOgKR/+KIW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273278; c=relaxed/simple;
	bh=s8zP1T0NL8XqSr3VbHmrcIJ81JR4RdHZOzGGP90wQnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBIp9IC86NHcGb9XyZNy9RMg2zJzrIh/PcTYajoJ4eDPYYwQRG/4bPNiTWWVHJtO3kTveNfrJAYksP/QNF1fwe6xsQEJuH7EMGL71R1wMfThWPPBQ8Z6Ld4X4S7+TG4dyVALtP5eiGqQ3ARifWlybRF7JQk/r39fV6MZrQmsUEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=URxXQRE7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TKGvCaem; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="URxXQRE7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TKGvCaem"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D08E11D000DD;
	Fri, 17 Jul 2026 03:27:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 17 Jul 2026 03:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784273275; x=1784359675; bh=ov05dwqPiT
	QXEGSFLNCB0PVReZIcBs04J4OkXWRRwvo=; b=URxXQRE7KCDPWIy9XU0l4z0zjj
	kcv836jj95Ru+QRBO5t/7HYxhqVAskHDv8KYE99ddfJED+KbaEeysnHLn4A8EOmp
	i9QNgE97gZFYr/LzijQWIZp9hytmSswCv43tBl+5VYSjqyfVaBAy/A+yEGrIlAu2
	kFBmcQgTkfMuRGIODSZZHHe4boynduvA6EeBuVJjl94NIxNI3hd+klLvBrLC096Q
	RQ9vqtU6ZnmyvE28fBUnEyLTPd11vRW3BtVltSHUk9HMgyKQuPQsrPM4w3MCeXNM
	MA3l4yGmERzNUlF1MoWU8uhiFHPO/VF2WcZpqNFpGt96M0dBOlTESTmq0yfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784273275; x=1784359675; bh=ov05dwqPiTQXEGSFLNCB0PVReZIcBs04J4O
	kXWRRwvo=; b=TKGvCaemc+WXS+7Igh+dl647fSKm0jJleoeFmIwQX5um+JMlIbX
	NEreXIs5i6bChy2vVjC3Ej9tMMXgh71V43Qe+LTVSntBTTGPBXaBM4S4Uge3Q1YH
	5T6CkBwTv8VS29hcMqr361RamxQGy18loaK19m2vjGOjOsDcXf6glqLzwn47ik7q
	9t4ije4/yLZXmWT/ro1lTlyXW99w2oxB1xiWsH6wxgJZKoajsN3DUi/kJFiXkAEj
	Q0glQNxioDb9s+8dGPA8wgFAa6brfSxRb12CXD5EVhzfS4iTTkw2O1hpzFO5hqF8
	2emyPV5Gqbvt/UrkeqsfHkbjBX9uKjFNWDA==
X-ME-Sender: <xms:e9lZajpqEFCPB_SyMSJN5G2guYKM9YVnmbAbu6QxfHlR92k56Tmpkg>
    <xme:e9lZaqDWxVDPvmd1QoROC_FsCpM-VrRHwRuxTDpROKcc6LcXkXfvd2vLykNSFlgmo
    9E8DZArW6L31hyKPntWFqX0EjJXoNeXBGcQWxwYoWJg_VZvuiA>
X-ME-Received: <xmr:e9lZakqzSwE0WZLljzkPD_d3c95jS4StU1l_i8KpNBrgBcoznGtgg88-o-78xdIIk8c4dyNmaKDpxX56OMDkv9Mm7w>
X-ME-Proxy-Cause: dmFkZTEyWUvUivhHubgnuywq76ZBUFI+iKcAUd9XptajDdfqI90y12kSYu2GEY0v4WRp1Z
    GXeyzBRWyCXsYv2m3cct2Id5P987uzSKNwJnG4BzDE8+Xjs9ZpJYF/z6UNO7TmODQbyyXd
    P2phYKx6v20vcOGysaglCOGTM4QfoVc050tHmolP0HYSCz5v4gFqZdp3dAuVK8pXMDPLeg
    URG+IQLFfMluORBbrQvPpWMyaW7Q5RF5AYKmnl2OEstSH1bISKYzqROKTB6WplYhZUJEy9
    SiljPWhHGh56mOUuoOLYtYXNgoLM/Zp0ovuL44mT9sWzlQ3wDgrxtVAMeHCbpx2fP6AFED
    8OmAskRa/lvxdwNvnYUm8ydtBOhDVp/7ytQIf0CohvcOiQg65/8mcQ65CByRC+p6bfkxrV
    9/jPdrFd6PYf6T8DU3Pa96v/VemDZi26fDJ8KPbsOKdy2ETyEu3dpcNhH8k2ipt6Ry0SKk
    +Slykd0ZqJUXsm+ybMBUMtrw+Ssof8KmyRTBWPsJ9Nj/nu+tNInQEgQy2INFyNFMj5dG24
    /DHruwXMaJ0y7WeBFtR7rwndw/pAYbrDIpdbF0tPdOaGM5X7Wy424yCGo6p0T4C6eCyjUh
    1dAUvTrnbe6ndjZuGyomWGKbBAlNzV5tKgFqOt4RAdsb2txJiL+Eu9mKG3KQ
X-ME-Proxy: <xmx:e9lZalDnvIulDkSMCW7SqkwfO9bksdmHUjknRcD6N1EbW-chmtJZvw>
    <xmx:e9lZavX8xoGg-_T70MdT2ANIM_p50I5noW0mmWb2rP3FXXkKZxWWgA>
    <xmx:e9lZanD2QMzh6dLZdaAdTLAZ5lOK5ppV-zMotnCf4VhG_WrpNM07jw>
    <xmx:e9lZaseSfDjXfanU04x-lh8OXJFNuPK5EZhTRsj2icQdle5TgtHZTw>
    <xmx:e9lZaoyKP0bXMmegZh-ASN9zIlswvJFdQ4f3Yq5Qz_KMpvzW19kp764z>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 03:27:55 -0400 (EDT)
Date: Fri, 17 Jul 2026 09:27:49 +0200
From: Greg KH <greg@kroah.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: stable@vger.kernel.org, linux-media@vger.kernel.org,
	laurent.pinchart@ideasonboard.com, hansg@kernel.org,
	mchehab@kernel.org, Jay Chooi <jay@robocurve.org>
Subject: Re: uvcvideo: deadlock when async control drops the last PM
 reference from the status-event path
Message-ID: <2026071747-exposure-owl-c4f0@gregkh>
References: <CAL+2LXtmekL+oc8e48uUXL_2SXvfCc_v7MrHJ6JDh9usRHu0sQ@mail.gmail.com>
 <CANiDSCukMqtarMGb3F0Nf3TfTB7TxHDeWu776StV+0q5q1VSVQ@mail.gmail.com>
 <CAL+2LXvV66O_qvbrHeFyHGjreyart277PgfKVK7jKfJ-MXihbw@mail.gmail.com>
 <CANiDSCttWrSLoftLWPtx7XxYaQ7PRV2+Y0tvir2qaE77PMG1-w@mail.gmail.com>
 <2026071726-gopher-onshore-61ca@gregkh>
 <CANiDSCs9T2iDaptLnv4g1ZxNyRQqTzNCD=Ay2uRQoPeSaGv+GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCs9T2iDaptLnv4g1ZxNyRQqTzNCD=Ay2uRQoPeSaGv+GQ@mail.gmail.com>

On Fri, Jul 17, 2026 at 09:07:12AM +0200, Ricardo Ribalda wrote:
> Hi Greg
> 
> No worries, thanks for the update.
> 
> Is there a public page where we can see the status of patches
> (queued/rejected) so we do not have to bother you?

Nope, not really, that would take more effort to set up and maintain
that it would be to just keep the mboxes locally as I currently do :)

And normally we do stay on top, this summer it's been a bit harder due
to massive conference travel combined with massive amounts of patches
being tagged for this -rc1 window.

thanks,

greg k-h
