Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971003;
	b=DCQiXweiTGERiSsGsSEhMH6etIfrX7qkHqUc+iEijJXV10i7AkiqAK4H2xH+CFaRCejb
	 X31M5VEKG6oVljAmB41YwG2Vbn1HLpsnSR4JZfH4AvWutSHGFoPctWPYKZ23qk4R8PF7l
	 /12R5PRmx8bV+T1pWbbDLF9fOxMoKa3Rwu0PUX+YmOdoMpwdRf3/jI3kZKOQ0kZ3Dk3gt
	 v31XL05pr7Seeta8V2FbsINp/kanpCaQ6E/gfsFWaQ/7ijGv0qng2hObt+MwNPOMRUz+u
	 t9Evr1b3NbNeK7OgvvKryt7MzZOJVc2BvIeAi910zjVoF9gc3h4WTdQLfRMOpuswI3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971003;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1p9GvmdqaJ/2jVCTd0uLxqCS1aIuvSbf6zTG4PdIbAo=;
	b=Km7NljnBEqtFm1/dtDl19q2vcC023FZAuH+IeQIC6YPDNrd/1ZIW5jlDX1sXiE31i4I9
	 qE6EnOPRVKF2vfnQ7+kFwSazwWd0UiNEj+ynDuNM0l4Cd1BVwD2p2yuOhIhbAkb47wleg
	 iQYNbhryU8TiS+T8HfFELXVBgUnh9wMHQAeln8C/BywfQiVnQsGx2wfiFOLZSs0g/T9Gg
	 IJcN/O0j57HyoUvpkjS5GIpPVPzMO/+I1ZQDh5PWviu6qI2DqmNE5xXx1/IyhNMjSrHPm
	 Xj0cu6rLfDDthYqSgWvcXgbBDTRHyIvudJXr51Mrg+GzenJhI0D8Nrmx31HuE7b0F6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MT2IzcAJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C42606A330
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MT2IzcAJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6A41F01825;
	Sun, 25 Oct 2026 23:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971002;
	bh=1p9GvmdqaJ/2jVCTd0uLxqCS1aIuvSbf6zTG4PdIbAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MT2IzcAJM4SW5LCcLYS3STwcdc/SN7ga+5XJ5yBe/ge5n2AmDxnt2xR1dGUkGU3eL
	 kYzTmVuSllcpPtLcJMI+0qIrT8eJNqw1y8GTZ/w3uGIiHODuW3M/Jxzabc1IrSRpab
	 /FeAO58hNVFNZQPvJzpNBaYEuhHVw/ZqCxKXDXMzNwPR8NoGt2lMHy1W/aKdWsaZSc
	 Fx/QvO6htLt3dPrx4nFuPsF7Y0P+WvFlblCJ2LGPs6k91JeyDdvddXKSULMTiqHwAX
	 KyTPNC//Es2cHyVdsOpcOdcK3bg9P4VIj3YVL1IapH0I26CUchdOb80pytg8oR1RrY
	 0KBGIUQ4tHCbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
Subject: Re: [PATCH v2 5.10.y] net: bonding: fix use-after-free in bond_xmit_broadcast()
Date: Sun, 25 Oct 2026 19:29:49 -0400
Message-ID: <2026-10-25-1-daily-reply-0003-bonding-xmit-broadcast-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025084505.83046-1-steffen.pfendtner@kernelscan.io>
References: <20261025084505.83046-1-steffen.pfendtner@kernelscan.io>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> found, and transmit the original skb to the last up slave seen only
> after the walk has finished. The original skb is consumed exactly
> once and not touched afterwards, however the list changes during
> the RCU walk;

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
