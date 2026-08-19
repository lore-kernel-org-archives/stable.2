Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CC53DAAAC
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124608; cv=none; b=MtghyPJLPWqfyMhyoz20HSbnPlVxwc95O1Yk9M6QaiBZJdg85rayAYlEqzSEjtG9YySDQqvwptk4ZBOHyVAoWbb5ldBATcULDLwl9zsZPOUZGrnViJ2OYL8qjMWUTUCuzBWXBYLRFuyztfdHOQekT5Ewpyj5679DeSCGUp7NWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124608; c=relaxed/simple;
	bh=GGtPTtcQWizU11SSmnc+IYnNvEAWboBRbaVrPQV674M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkT8HwmBD7hZD3WpMQkhudijdntsY1fcBBklanuTFVninPXkTWVUI0hIi3So5Te5TR1KvGz7qY6ivadk2XD2/I0emEd80EQfVrSUmMOXAhhU+CPcOln+MYWFq8yJGxCVO98AT1y7weCar7ryPmE/TP/1FCUIEuScDBNxhLHEQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=GNfjxiNx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l1cYT2+8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="GNfjxiNx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l1cYT2+8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D25E0EC016E;
	Wed, 19 Aug 2026 03:30:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 19 Aug 2026 03:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787124605; x=1787211005; bh=jPrufRMNc2
	KSJzZkU2nUPPPJTyfead0nWh46FySp9qc=; b=GNfjxiNxeTebAVHy71mWkyanF4
	igSk2NdL2dTFtNxEZciijkfnYF68+no9e9V0+ep4TS1uJ/CliKL2XF3BXm4IP0Y1
	1L3NiQbRxtNd20fmkFVr8BvMMTWV5R0qOl8dGYgaAwQurEqghbLC7hBZA2s8qTSG
	PR9dMRx3RgjuNdSYqypmR/dDvIM6pYeDazuvFZx8PaIedi31GHrW9wJ03pemEH6V
	44MPiKBmhagSMeJtbCI9LupqpOv3iAp0E25i27/ZvrEVoCywaen3qEi8virxuACF
	+BtdivpkjCo6z24LtzdrvVSA/wzpM8eNNLZFKTgo+0iOtMD7OQrlbVib/gSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787124605; x=1787211005; bh=jPrufRMNc2KSJzZkU2nUPPPJTyfead0nWh4
	6FySp9qc=; b=l1cYT2+8BGl1gxBA5IML8AbJba5gTPnZFZccN9w8xxH8avUBK6i
	DqQ/rxLDtMz43C8vQMwFQ60l8FFBvL2aW7Dgdl4nrCbsJPnAurdwPrC9rIWLTH9P
	+/9KWdynUw/e+/Wgl9mHz52gNWqT5YtGz9uoSbP5TyzcmKwh/adSZg/VHgdwG+Ic
	lGXfA1e1kC51n06C/s6THeoTNB/MXfvaSbkq8f2D1aN/c60ZWZKKcEIi5MLfS4es
	Fjgf8i7F/HWzCV3FZhwKtc7DnGxbY+TSNKfGifD6H/weXiTafqlZdr9hyWRlESu5
	45O3FHu6xy+NqZZGMa0p+1Dmh/LUaVlqMGg==
X-ME-Sender: <xms:fVuFasSy5XToA2ZMPIMGjqzzQIjRycXWLoeDgOebRzJoJU89uUuG3g>
    <xme:fVuFarVyxxvRlPZgP9N7zp56FnGtd4cj6PfWmjuk9Q_inSbSOJEf6BgmCKZ9fWuum
    d6Xw-whd7gs0CfDCcpQtRFdZJJHsZKNt5_JtVyQScP-GpMA>
X-ME-Received: <xmr:fVuFapELYQAlM089eaYjcmaKNVcT56FukrM7NHNM2lDcHbsyMZreYhcsU3WTlcGXedu6PY1OjnrbuuujXon_O7qKx5jqN0u9BXfLygoXudE>
X-ME-Proxy-Cause: dmFkZTECqnig7X5laIrvhMug4DmjWOyGM+PgzMfRpnNqZgZu6tQ+DkwtXcBD1f8fjOdTeR
    h3YjD9KprTG+cxq3rsMtM67fDrNpomFoea2Ekdz4SzdAtC2bBmt8hicKXH+QbZxR36X+dT
    /9x01QRQTMBmwRzkM2gbcbAbcz//8Uny9FaH8+06x9tNx8IbR5WWhq61z5rQQ6JMyMMi/f
    i3rQz+UMA3fLv1N6Q5ROW3MnaTWpI7LdS4ghBvX5e/tGFphORcUdA7zWe4Fun5xazNKFqp
    pAR4xR8sfWwM07LgO2BkxARo4yunVQFi17GrHOEhsyR6b6PRyVezLpR9fb0qA3zH6BKYL9
    ty+59YQh7cYNvz2YKB2DHWGoTk3DBv5p2rcBDPTUlbo5o9RYb6iEbXpa9kbRc6kLwDabVz
    P4JFLYzeHlO24A5Rh4uWc9WegBTEbBH/dlVauQ7PtYNVxsOwAw6WGMg6YnE5HUn7GdptjA
    0FqokadMjFNzH3R3igdrEqdkAMH4uCz58AfG9p8YUP567y8dasSPJF7rgBsz1242u8lDa5
    StWCuAHKsUbPJQqg9AfUK2s5P3FNqP32eYX1MvF2DHUvfxxdajwHWmZfK2hBUgc4c7+c18
    iO+MZrRrW4sH+jgyQIOdOTtE9JxhvkIpszRkpB9CGt5XY2z0ph/EvSss5mKg
X-ME-Proxy: <xmx:fVuFamcEYewIOH0oB4L6DUGaFJrHldS_b9BxzpsQ2VO8-N6jy-oIsQ>
    <xmx:fVuFaqp30PmkOLdM8HuE53PGuRUfHHZZbmybgyYfikPVfNtseEqYQA>
    <xmx:fVuFavAtaLiZd-TeMgi9nGPJPGrBOAa91-hc6iG3kS1IjFlsLzPxKg>
    <xmx:fVuFardQ0RPQe9GufvaT6syOP2pSSe80HphiBXulDveldfDnP0iFaw>
    <xmx:fVuFalaIUF4wUqNRNyV_biiLQ_gTKYvTY324naGElWfN1tH6TB8VMpvP>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 03:30:04 -0400 (EDT)
Date: Wed, 19 Aug 2026 09:29:59 +0200
From: Greg KH <greg@kroah.com>
To: Tien Phan <tienpp@gmail.com>
Cc: security@kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix use-after-free of DRC slot in nfsd4_sequence()
Message-ID: <2026081912-shove-schematic-d7a7@gregkh>
References: <20260819054326.1265334-1-tienpp@gmail.com>
 <2026081931-disrupt-flatbed-5de4@gregkh>
 <CALjHmwND53Gdy0xMaPNMtvBP5=9KQ7M9-E2S+W1wweQw30tEmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjHmwND53Gdy0xMaPNMtvBP5=9KQ7M9-E2S+W1wweQw30tEmw@mail.gmail.com>

On Wed, Aug 19, 2026 at 04:17:26PM +0900, Tien Phan wrote:
> Thanks Greg,

Please do not top-post :(

> This was AI-assisted (the vuln was found by our automated analysis agent
> "Sentinel", and the reproduction harness + fix were drafted with AI help; I
> reviewed and verified it and take responsibility).
> 
> Sending v2 now with Reported-by:/Assisted-by: trailers.
> 
> Happy to adjust the wording/format if you'd prefer a specific form.

LLMs love to be chatty and say things that are not needed and add
unneeded comments.  Just like this changelog and patch contains.

Please reword them to be sane.

thanks,

greg k-h
