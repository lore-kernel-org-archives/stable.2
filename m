Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5A4E8DEB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063396; cv=none; b=AxkwTCxG4z2HYECTay7TNirf05ZXGlu6KYCKgnlwIuXOqtfWaXJniMcGkXb6ACjdvfMLY9HtwNlw9dv9iVxiYGGr9iqM1678dIGzn8j+A4DuB6WRPwMurhUQD3Gl7iG1ZHz3BtSlaLd4sFIB1MPg05g7p9Ew34zQ79f+l1OTbgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063396; c=relaxed/simple;
	bh=Hnl4tV2+zlRVS8jH+hoUh25vGbRAPT8G7ev5Zi2Sr5M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt/++/YzHed0aSp/9nzMTi/jVCnVVXmjLUVqdbb2YZYQSfMeeAOLed0QyLucjA6VqyEPaEat1dfNG/n8E7B/ketA6zlADtGNwbzmEH9TsQiQsY2xtZC+OMDgqSEHGCAOeAR7dngeN7vU6oNK3fgLoNngm+kFiVZZ6QTLxrhelsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=p4y+ywHo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QYo2seVl; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="p4y+ywHo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYo2seVl"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F0775140011C;
	Tue, 22 Sep 2026 03:49:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 22 Sep 2026 03:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1790063383; x=1790149783; bh=Tw2q6I+yhf
	CoXtfkvZiR+dMOVQ90WLTBvocpJlzqf30=; b=p4y+ywHoyB24A93tQZQcvzj7Z2
	BjEzCs3Yo8+aqbeeb/w21JFzHpvH+pnPVISLRWLa6L6/77ifT7j4RX1h2yardGUr
	qCZFW/ooNJaaqUxqQKIMwogYSjJT7pA4IRAIVV3RXENW777pakQdCurXXocb9SpS
	+xFDQZUmDUIsMsNaq/2law8NvVkIoVs5Eh0LLO98Gnge8Ha2JCm4I74cw0ZTwKAl
	ad1Aj0fuOjQ+VgoifuhqktTWnGSp+YW5fL1pAcuHYa8ZtvFDGMHQz1328IrD0jJs
	Iq9IK38KdJarxFH8icAcKbLzONHS5XUls4617PcuPchNnTNfl/LvRjpuIkOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790063383; x=1790149783; bh=Tw2q6I+yhfCoXtfkvZiR+dMOVQ90WLTBvoc
	pJlzqf30=; b=QYo2seVlccm3yiQjim0pFqLPy0twDajzanqHEqNkNXXgu+x+4Ls
	6V56RFHywo+g+2Zg57SBCKUmF/T0psFh+SmI3bjx7YnmwRk5PVc8GexqYiJSfuyr
	JYHBkaAtJB4gD+qylOwL8xeIar394Pb9N6vuHnNynZbWvMCPxHSNBwx5JlK160Uo
	br8exfug/AjSYaVvBT+RS8tE7ID3YOVew7vdkJ6H2TrkddRAAksCW/fbAtpUq78+
	gXxJRtD/GNFB7u9ukQWBLu99BgnoxprHDnLCesSp7CrMfBqUJq1IizgG4Sjw/4sv
	K/bBtCxEP49iolcv0K6+8+H9UEbzNk3lUjg==
X-ME-Sender: <xms:FzOyavpz8bjH5buUxSWEbzq8atCrNolSnO36JGsp5lYMGmv2NrufWg>
    <xme:FzOyavqcDDydO0BlRkmYbupJOnbNbZsUPWl8EM6PEp5xj9Odc3wnnSL1qBqYeEJ4Y
    o3UeDmXVxalUDOqEQxD29fIlGT_tc_0wNAvlRsnLU0WAFNgj_2PuKMD>
X-ME-Received: <xmr:FzOyap1oKJ1FmAQ8H48e5yz_h_gnS9e7-JobH6JIm-Q4Oi9mfK5hSz8wmbA8>
X-ME-Proxy-Cause: dmFkZTEOqaYt+44f3CWzq0hX8yqa3T6mRYLOotjyURIgOMM3VEqv18v5Ew4OgUe+bGJ5ts
    FuoCmxOd8/tl+IqP6OdzF6iuOgEimDJxS1uyxwi6kUCTv8rhVpglG/zQJskO4mJoJ+KkPS
    zGMw+CfC/dYUOcpw6ojRqDeh9OGy/sa3dL+IHKTte8nvpR5X6SiJ91Ku0Jock3yZhTNmL9
    vYE3Ob/7ouX7zdZ7kRdlSgYAxJIWyptIFLLto94Cr92jahQbcuZVMNaEEJC/jFX271C3Hp
    1nlYGC6xMG3SX8MDhrlVOt7ynKjyFzztviCxN8C9CR5z3L7RA7GjNjT9vy0qaRhYK2nPIF
    BZu61sO2ymsQGf/9/SdDeKM45JoY5Nhm6ERGj+tFtCt/AFKE3ZFdASMHmRqjzmx4tlnUDG
    3k4xcSj3NBTIORO45e0vhLVKU1ghXqWNrvAt9k5eLxhyc89haenhKD8e+XObe0NiXAXLaN
    +ElhcNjFKwN1u/OJf4ITPMR35PEzvXTd0UM0yZPa2atpcEkVOCY3Cd1ph1OtPNRU280lNY
    mFXtyQsjH/gxO1pVVA6WU/IH9IiA+cLDKNuFDNS8u+3gUbl4EvXd9B8FBkXN1djwdBAEno
    LcUAZ9PA5SK6pzc4kS53JiKDO78JwfqWggQ0U2UVnkxfV/38IDoWG50Uif8w
X-ME-Proxy: <xmx:FzOyauDhx_ZZYa9zFzPS_ToouPi4PDWAzwopsfo_MysyV8IgjWjlGA>
    <xmx:FzOyahfqUAwd8cAc2j1tPLdVeA6MD6ad-2_7XQYAbyG7aKBItEn6RA>
    <xmx:FzOyajhBkE1nguKdOGnL-xxDzxlwrYIBINZrnh1dOBDX-Z2MwBXXrg>
    <xmx:FzOyaprHOCzy3gfQazi7BGXw7AZPanEh4g6l6mJPSAI8T1cgJttGJA>
    <xmx:FzOyarcJxCeZEga5oM9SHUJeHgpQMNrJ6uX7ZnBfq0Mdqe86__3Lw41m>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 03:49:43 -0400 (EDT)
Date: Tue, 22 Sep 2026 09:49:41 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: Patch "xfrm: propagate extack to all netlink doit handlers" has
 been added to the 5.10-stable tree
Message-ID: <arIzFfvyTnZnz-XZ@krikkit>
References: <20260921193130.1793731-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921193130.1793731-1-sashal@kernel.org>

2026-09-21, 15:31:29 -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     xfrm: propagate extack to all netlink doit handlers
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

alongside:

xfrm: add extack to verify_sec_ctx_len
xfrm: add extack support to verify_newsa_info
xfrm: add extack to verify_one_alg, verify_auth_trunc, verify_aead
xfrm: avoid RCU warnings around the per-netns netlink socket

You're backporting all this stuff to avoid a completely trivial
conflict on the nlmsg_unicast call in the context for d1ebd9081879? :/

I'd say skip the backport if it's that much trouble, but of course
someone's LLM will come up with an "exploit" and a stupid name for the
bug. meh.

-- 
Sabrina
