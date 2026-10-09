Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A866349A3B2;
	Fri,  9 Oct 2026 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539964; cv=none; b=sWV0gxfevwrtn9jdAW5cfbPLF7WfKE1E9PmAZGvswZMR9ROcnzALUlvOe6M3A6gqvnbkmvOnAqjVfvZaVgf3MBQqXVMAYyuhYst4rX5a2BUN/QwZCEVVxnRfUsVZmaY2MUy4Ie83f/5BkHcSZ/iBDNB3DytT33adzCbxaAxs+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539964; c=relaxed/simple;
	bh=4rSBv6j+p64MEbael4++2nOAnWY7UOnZUp4W9ZTneSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXOeKXZ/QHb/BQrcQOKlsAEFj3xHbpEVVFbxJZI9VSZW/mIVqYYia1P4gTU+zANvOw/OMbOWFKZm7T5UM7eHK+T8YLqaZTm3EmOD5RibGGGAxB74rgrT7fdVZcAzud7QiyVQ4jRdnpGTStzYkY3TZA2KLbo1wTGecyw6XYLhdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG2Rznme; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG2Rznme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE08A1F000FF;
	Fri,  9 Oct 2026 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791539963;
	bh=zo4rSyJTBdFYoyHjHQT4prtqurSOLp6WwHKReMDQm+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UG2RznmeV4f2xTeo6pbG4SYqL0MOKuZnbHUXxM34U2phMUKqukFiyVpv2LClqw7Zi
	 fE1zItan727wQjBVbMHt5ZOQPL/XJ58ZUDQQn3oL+YiYnGrusn3ZpK9s8S0ihoAPGJ
	 tZkEQRE716M8RlrpJDLFOj5G/oUWQUdhD5C5KGD44gGJ2YKyUcqofOT3dnRAik1Q4y
	 Khbqos0B3CBXPAeb+wQJ/sT1jU4va7M5+r1pEXnzaXrK3p3dLSgn6wkBNrCxPdkyjO
	 P9rza1ZIxEJujcgvuozaA/Gd5oGUVp7A9Z3OLLe2N9k2N9caEYLdNhHXqMOzPlXsIU
	 Y9DKsyMv3ZkVw==
Message-ID: <b6f367b6-a267-49c4-8df1-e3e155b59af2@kernel.org>
Date: Fri, 9 Oct 2026 11:59:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aoe: pull in the headers each received packet type reads
To: Christoph Hellwig <hch@infradead.org>, Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261007-b4-aoe-short-packets-v1-1-db5155f7bb9c@toxicpanda.com>
 <asdpwPEpGFxfLDNz@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <asdpwPEpGFxfLDNz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/08 12:00, Christoph Hellwig wrote:
> Can we plus just kill the aoe driver given how buggy both the driver
> and the protocol is instead of playing whack-a-mole?

+1

-- 
Damien Le Moal
Western Digital Research
