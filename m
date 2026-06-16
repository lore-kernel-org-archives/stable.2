Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C73D41C318
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603690; cv=none; b=aKXLOuvoYymtKPFFtEY512qQCRlX0rT1AGMqT7+8Md6UeZZ8xVGrjwO5320SEhq+gd9bemSYfNtkiZqlyyDeOP6MYoxuuby5bThMxeQoEKmB9yTZXSzrj/fKjXqRN3jfZGqiepx98lysbnIWFGsvdXcl3L1+JRA7Q54qWu9wZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603690; c=relaxed/simple;
	bh=pU6gTMl7X9kwGR53DOfrBr86LhHw/3eOco4gmQF/7L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=km3tAvdvKXQ/zvLFMfJtyxEGs+vASYtFS6hY4AvPeV9mOXAS7NQjr1qiQPwc+mj1Efi/7I6nEDoHtmu0Pt8Zpk7+zq7bwepD+GtQxuYXw+Z/P+wGBskCQ5g4SIurMfzQEElGN0SXDtPOmNeXdNKSAXFgsTlQ04FbbF2nu4rb0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=fVUZeGrh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MNXAexrD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="fVUZeGrh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MNXAexrD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B9A73EC0188;
	Tue, 16 Jun 2026 05:54:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 16 Jun 2026 05:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781603688; x=1781690088; bh=1QWE1n2xwG
	AgXNs8551c0iCCcKqA3L0pxqjCZoShq44=; b=fVUZeGrhORkmAK2GgpcWujapsK
	ODsffN3sIsS4TDCHDWhvKutxVv7kOcBh1ODIjIlgaMMF0FjXLS6lj2GOXZhgVvNW
	xNWP+zxKr/qzb4iALq/6eloKL5eh3raIJYEfaHJFxWEBbrPK9Y8HthjE4dgKWvP1
	mrB4Vp6Njx2b64vgoLh6CIaVYmK3Wm9nbRtmmcxSWDAfHS+B1gsMD7ONSgUgQylx
	42S8I3F+n1zQ+0ybZoZFfwC2jmkl4Tps2t7DEPQH6UuwSlSiYv5TbW2rDm3FT5a5
	wGLknvrhhEx+5CeYByr8MplTdekSkR3WBah2PfUF2Nl/o/qJk5/Y8lX5TaPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781603688; x=1781690088; bh=1QWE1n2xwGAgXNs8551c0iCCcKqA3L0pxqj
	CZoShq44=; b=MNXAexrDAemjl27gJJdZnRM5lR8774/Ikhqtjn61iWkS6eOyr0m
	WDCi5rHf0Pa1Tt41A6f1QX2UZni9dojeqwkp8fGYW+KRtkKyAyIa9tKJG7REd4oa
	P/Cscl9UdHwzmOMfoZ/aEcjvPPO6eKkFFfRMkIwYLtEe//oJMmb8A2DljLPn44BC
	Qt/dRuxmCUsgaxpyuQcldrTvBgo4YuQ+k8Moiik5QirhKDvfa9mmhAVo+F+cbUu2
	ISzElFPo9tjityEMfLb5ZpsOFdqhuRJfwS/RI18rTWjyZKziCvi9Zmj16RaH8J3W
	idHJw/KiThmmd0Bn6Jzg9iIwoIOvPme0y1g==
X-ME-Sender: <xms:aB0xahkBchyogKtsmZzwJAc_S-MvZYvoNanl5FfSRbDCiGuF-Ky_bg>
    <xme:aB0xaiA1E2uZPHSmCm7fXuk4xwVWyqzyQNFG_tGcAF1FqYWzzcxft1WVT1spdAxxO
    Xd51anVPpO4d1N0jf4mujdUSTzG0mmDSk5PBzvv0V6OM1B5aw>
X-ME-Received: <xmr:aB0xarDm0rG1Pb0P5ndcFrne2Tzi6WPuNw-cFqbFl355831YQGTQsRHn>
X-ME-Proxy-Cause: dmFkZTEZGO/pP2+J+TXYi4CmYH0Pasm7UaNBgVGxK82OOl/H/7HRJRTMQmK5BJt3QOPxhl
    Po+M/DiAq9ngT7MahLNwXaNcph7RM/TPZ6tZgKnCHnJO5NDf8zMIVWVsq+hZZykxYHWYXT
    fPk0T7AWS95i1GArZr5wez7U4yj6XRwbQF20zTEhd5GNzhk1wDx6sEBRaLz3ItpCF40I0U
    dYxzrG21meY9HDNN8t39MOI4C1F0RYvyZC0W5hyk7giByPsNCsDsosyBt0aqpm2YP+lOD+
    wHo4PXlpDJ+x5XpjL26I+E0pQ6bxmFloi14uFFIhkA8gfuC1yDpMl9XWjt1xzxuqVU6RLE
    QL8bX8+yYB9y1XnZ0BseaR+v1nTa7srYT1+QbmL+v+JxplI+LsQDAOSJq8wWG7NM7C8Tfi
    ejvTAjr402vBVq/k5FoZuoR1p20KVczRGIAZFWS1jLDfXe/4aXL86APYJji9VfW/2QYXyO
    4P/J4IVQyrY8zhRNg5PSeyKsTCep4zB1tZptX+MxtcdvK1qeX/5pgKyqn+EhT9iX8UTUGF
    DCvqaL30Z6Fj4Jdqoqgz3TFUVVpX7Cc9D4m3vE5APBGkyp4D6ZuEr+MgP3Qn0dC4TxiPfS
    VkW4vl+cL8+wg5RnYaePMkaXDM+wIC3gXv3iRp17U2DaxGNUgfzbmrLL86yA
X-ME-Proxy: <xmx:aB0xahGYbBqGU5gVYIOEE9kDPRQaT7ZZF-gzV--1REAqpYxiEC4xww>
    <xmx:aB0xaq6YA6GQVRSnimo5YAtDUAfPs0EWXyve4bCQXUF5V_aPuS8s_w>
    <xmx:aB0xagTW_K5PWbrSjFIsAwJeify_abi93ZAhbsFdHs4rHgWwZF3wHQ>
    <xmx:aB0xat5IWrBT1CbBbCMV0pFuzoRBMzZ3AEfRm47kpwuaag6JZfFTCg>
    <xmx:aB0xaqasrRCkdSnHLLDH8osD877by5bkXAngJTbFNDUY7T-XDy6VGTyF>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 05:54:47 -0400 (EDT)
Date: Tue, 16 Jun 2026 15:23:37 +0530
From: Greg KH <greg@kroah.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>, stable@kernel.org,
	Nicholas Carlini <npc@anthropic.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 5.15.y] nfsd: fix heap overflow in NFSv4.0 LOCK replay
 cache
Message-ID: <2026061626-ladder-unwired-2bd4@gregkh>
References: <2026032010-shredding-stargazer-b481@gregkh>
 <20260320113941.3971332-1-sashal@kernel.org>
 <919817c7-2684-455b-8f62-14e31d2b5eb1@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <919817c7-2684-455b-8f62-14e31d2b5eb1@oracle.com>

On Tue, May 12, 2026 at 02:43:57PM +0530, ALOK TIWARI wrote:
> Hi,
> 
> On 3/20/2026 5:09 PM, Sasha Levin wrote:
> > From: Jeff Layton<jlayton@kernel.org>
> > 
> > [ Upstream commit 5133b61aaf437e5f25b1b396b14242a6bb0508e2 ]
> > 
> > The NFSv4.0 replay cache uses a fixed 112-byte inline buffer
> > (rp_ibuf[NFSD4_REPLAY_ISIZE]) to store encoded operation responses.
> > This size was calculated based on OPEN responses and does not account
> > for LOCK denied responses, which include the conflicting lock owner as
> > a variable-length field up to 1024 bytes (NFS4_OPAQUE_LIMIT).
> > 
> > When a LOCK operation is denied due to a conflict with an existing lock
> > that has a large owner, nfsd4_encode_operation() copies the full encoded
> > response into the undersized replay buffer via read_bytes_from_xdr_buf()
> > with no bounds check. This results in a slab-out-of-bounds write of up
> > to 944 bytes past the end of the buffer, corrupting adjacent heap memory.
> > 
> > This can be triggered remotely by an unauthenticated attacker with two
> > cooperating NFSv4.0 clients: one sets a lock with a large owner string,
> > then the other requests a conflicting lock to provoke the denial.
> > 
> > We could fix this by increasing NFSD4_REPLAY_ISIZE to allow for a full
> > opaque, but that would increase the size of every stateowner, when most
> > lockowners are not that large.
> > 
> > Instead, fix this by checking the encoded response length against
> > NFSD4_REPLAY_ISIZE before copying into the replay buffer. If the
> > response is too large, set rp_buflen to 0 to skip caching the replay
> > payload. The status is still cached, and the client already received the
> > correct response on the original request.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc:stable@kernel.org
> > Reported-by: Nicholas Carlini<npc@anthropic.com>
> > Tested-by: Nicholas Carlini<npc@anthropic.com>
> > Signed-off-by: Jeff Layton<jlayton@kernel.org>
> > Signed-off-by: Chuck Lever<chuck.lever@oracle.com>
> > [ replaced `op_status_offset + XDR_UNIT` with existing `post_err_offset` variable ]
> > Signed-off-by: Sasha Levin<sashal@kernel.org>
> 
> 
> This patch does not appear to be queued in 5.15.y yet, although
> it is already present in 5.10.y and 6.1.y.
> 
> Could this please also be queued for 5.15.y?
> It seems it may have been missed inadvertently.

Odd, I did miss it, now added, thanks!

greg k-h
