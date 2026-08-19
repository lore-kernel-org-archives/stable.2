Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6483CC32D
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118785; cv=none; b=BysUWhIYEnJxzFSSVFbS+MuH4gnD/dh1ThqJ+FBqN8Bjdv4FGwcHjw+6kTVEh+ompDg0cfv9pB9txfGQXSnxIlCKOIOv8XTBvJE8NyTgXLRJhiBILcczbjyu5s3Rr4BjWDdXbTM4jqMdxj2g6iSQ5Est+a6kU09kxLIU3d+Sts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118785; c=relaxed/simple;
	bh=C9F6rK/fNCzoit7jlGshCSh17C4kznVf2T7V/Seu99M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYGYiK/39jIvlgsOh3fYmHMaJygxaAe8Y0y9RzWKaU5gppR0ln6sYRzzUZ6J7IVJyknF0QTTmKGHFPSigmvXFA7jVXMtVb2oNScJdSMKqq9xcoyTKfl2FusRof2FFcxw2hDtCzSzeSp7X9+uAlavJGcTkV2Mo6ehL8PNMrPRNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ALeEvwUS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JxI49oyU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ALeEvwUS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JxI49oyU"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4428A1400146;
	Wed, 19 Aug 2026 01:53:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 19 Aug 2026 01:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787118781; x=1787205181; bh=twLiJohGda
	+0b6jQDJj8T+9bfbfCuuoYSP6cpNt1Uqc=; b=ALeEvwUSxytUU0yX/pM5u47Msc
	3hIycaFm1PblteYOLqsFx6pap/CEajc8CMENUesIUxE3NFbpDL24DmpriT+HOvCJ
	sNevvgvYxfWBHAca5N2/FgM9bJQO207Nr4k9dH6U21yRooxcrI5S21uZho2P1m9a
	/7ZtQu/rdAYHE+73/w8cmpalMZFjR23C8cAzeUUiKvyTvDbR82oJYR2flGbJfiWF
	HP251h4L5nbBqOXd33Tn1UCHD7ZVCIwJeAv3fUaRuPLCCKSAxt+cGS2hq8acqKBo
	PKNVqoR0aQmncZ1Nmpu4HYPRqL/knFiodtPciZrs7z+OFEonvYD39H9eWlkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787118781; x=1787205181; bh=twLiJohGda+0b6jQDJj8T+9bfbfCuuoYSP6
	cpNt1Uqc=; b=JxI49oyUZAeUP83L02AleAe7n9YBx3G3M8UIwJd4yuCP5S5ut+Q
	sx7lfcsPQqenrZPNJqfPsBzwnwO94O9SztY4C0hOS8vjA9aj79fgInTD9iiAx6Dw
	FYTaHDzWErNni7lePDBXc4MUldFAj+ogoq3M18++Lie9waxvrVJ1EJS5tcbMZ6pN
	M/cPXsVNFk7PJOCsnVJc4TSs0xVSNxJXrgeoUd9PUAlfswuttsVkLS0W7Nk1kQ5z
	UyLi7RaSp2o/w4AuBJ04jj3ppvLf2PjZa3lUuK7VXLCdCu4xK7eB6orMzGmhjjbj
	2i4xaLt7sWQn/tFTwncUdKGreyWUvIoJxyw==
X-ME-Sender: <xms:vUSFajUrA-dO9z1NAsU5qi03-L70PL3HZ380EaSDuRiQZ6K9ix00_Q>
    <xme:vUSFatJAtTK8Q3hHuLERAiLw8MuQSXbXNTeKgLMB-yBCcX2Cp2cEj_w0bdIlSn_rE
    sTsO3yiu_PiDwpo1ODMjBIZm3zyxuNOcjZYmtiOtFiVn63q>
X-ME-Received: <xmr:vUSFaurbi5MEc_akBxoPRx-6sQfGPAjDJbprzEdVFSOdQ_iNhMZm2TQIoGTYyml1PPI1hJN5GJNbjKgOlrWD3OeaMOd3JXiFOqH0295VHW0>
X-ME-Proxy-Cause: dmFkZTECNPgly61bmjkAXp5PpSATttoTu9uTDSDZboDjsjXGNe1bLsh9iGtiLxlNNaqDgf
    qQEyAGstrF17dvGXbu9dbbe3HY1fVm86W5qz85UQ5W5w0frEnZTiOc0ckaIduJVtF0rBGj
    MwtYI1f9wxtugayuxbLxyMG0NycwimHpw9BgU0o0IriNy1H3njOx0bjE1AFqbs94ZQj79d
    qWoEJ8uA8Vuh3v8x8hMIkHnSUQAKBLtHsENQRbT57XCJpjkdK/9lmifX5DkpGWBpZ0+ULZ
    kKblscpQWrrBvBs9A/20hCHIuTBCR+PlFyOKtmoEJlAas3haucvG0sv/U3+WZkJRzIJmZy
    rlus2EKW7+JTF4hJ6+UC8jYLd2uWBLIX9AaEigfYGXyRLy8vdT1JHGLp5FFP0dJ97yEfH7
    rMrAhT0zqgYcsnUgE6RhhheaeKzwdTDLrRhiRjrcbKqolMkh1AMLOt4PnzA1OOu4sBb+0r
    /nmfLhmGYrrOPseJYo4RvwqyPKw7pnxgXEDQbVq7TAjgnJyjBUvtDipu/28dsRF8xDG/0a
    saUtNwJ2s/qiT5+Yi0EJ3emHvCf2uglcrXd2lBNe4fBYMlxVRmOhgwfoa5GHwVfj9BhfRH
    k96DEY68QBVOEAUwI5TAQdfVAw4s4Zr3d75L8izUA6LPyoNLDOtGmVcAB0xA
X-ME-Proxy: <xmx:vUSFakyw10xx2zSgavOZ_Suh7reDHcx_oZR1pJhtPJ7i_9wh7zVCow>
    <xmx:vUSFaitm47duWtIglFmgZcVfhBoAWXMgeigjaRWm_-cxeS9ffjIR6g>
    <xmx:vUSFat2gq2WDKBvom1gmHefs2JU-oKpYpdPuROE2o1Be2UWr5BU1_g>
    <xmx:vUSFaqAtRuuzguY-Vk-sySktJ-8mDGiGiSb_xT9u36k1eQ1cmjVU3A>
    <xmx:vUSFarddL6jRdZ0hyASSbPTQ_ohSwvLgYsAYc_DYyzsQneXmgtqlTbxE>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 01:52:59 -0400 (EDT)
Date: Wed, 19 Aug 2026 07:52:05 +0200
From: Greg KH <greg@kroah.com>
To: Tien Phan <tienpp@gmail.com>
Cc: security@kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix use-after-free of DRC slot in nfsd4_sequence()
Message-ID: <2026081931-disrupt-flatbed-5de4@gregkh>
References: <20260819054326.1265334-1-tienpp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819054326.1265334-1-tienpp@gmail.com>

On Wed, Aug 19, 2026 at 02:43:26PM +0900, Tien Phan wrote:
> nfsd4_sequence() loads the slot addressed by the client-supplied
> seq->slotid, bounded only against se_fchannel.maxreqs:
> 
> 	if (seq->slotid >= session->se_fchannel.maxreqs)
> 		goto out_put_session;
> 	slot = xa_load(&session->se_slots, seq->slotid);
> 
> When the client acknowledges a slot-count reduction, the handler frees
> every slot in [se_target_maxslots, maxreqs):
> 
> 	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
> 	    slot->sl_generation == session->se_slot_gen &&
> 	    seq->maxslots <= session->se_target_maxslots)
> 		free_session_slots(session, session->se_target_maxslots);
> 
> but never checks that the slot it just loaded lies outside that range.
> A malicious NFSv4.1 client can pick seq->slotid >= se_target_maxslots
> (still < maxreqs, so the bound above passes) and, once the DRC slot
> shrinker has lowered se_target_maxslots below maxreqs, issue two SEQUENCE
> calls on that high slot: the first aligns slot->sl_generation with
> se_slot_gen, the second satisfies the reduce-ack condition and calls
> free_session_slots(), which kfree()s the very slot still referenced by
> the handler.  The slot is then written (slot->sl_seqid = seq->seqid,
> slot->sl_flags, cstate->slot = slot) and used for DRC caching -- a
> use-after-free write.
> 
> Reject a slotid that falls within the range about to be freed before
> freeing it, so the handler never operates on a freed slot.
> 
> Found with an in-tree KASAN harness driving the real free_session_slots()
> on a live slot xarray (KASAN: slab-use-after-free, write of size 4).
> 
> Fixes: fc8738c68d0b ("nfsd: add support for freeing unused session-DRC slots")
> Cc: stable@vger.kernel.org # 6.14+
> Signed-off-by: Tien Phan <tienpp@gmail.com>

Did you forget an Assisted-by: tag here?

thanks,

greg k-h
