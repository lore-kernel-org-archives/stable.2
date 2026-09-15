Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7F3DA7E3;
	Tue, 15 Sep 2026 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442656; cv=none; b=IzvdTmlNayOirTCRheBCYMyRUsyhc/zB0ZES4+aoPUJ/vSsMaZW+BEA2jLTRmUpuezKYD+XCt32XBMtsrUFYRy1iaqKMleKO5AcdNWOnlnZc4Ecu1EFztM/9vJ5NKOFFzSeD7klaCFVqyWu1doQMtEcWlo+ellFEepFIO2S21J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442656; c=relaxed/simple;
	bh=YV4VsAk58aB1jHdx+aID0OkjxWVPNJSiSi3oS+wEaT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzRVtNjQ+E1LNsXbzrorQ2R1BTnnj06RFpHyOimqRQwLRi2aH9GUmuJu+bjcbXA+YI6u5pLL2GcCxbEfSvBYpbFSdIpkq74FElPkk/3oiQUfjM5OniRTRZN7U66FYNdpBWKtVb3HoMB7qDBKPaPk5HC7ijaCdVU+c/jTFpOzv50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuEy9FLa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuEy9FLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED241F000FF;
	Tue, 15 Sep 2026 03:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442653;
	bh=PCYPRnOCU03XYsY0hvT3ARBnbQgi8jhjgMGsXmro27c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NuEy9FLay1uXp4QTUi6XLnvpqOqc12yKnyYOonytso3dWZVV7zZ67utiuvV43zkkB
	 I9+zQJWeBGKNWbU2LCtWZpgYMUn9H4FuehOMAdMT75whUy9/AjtucXBpHccolwjaB7
	 ODY/Wcdxq7UWIGGS0wdv7LuM4Fzu136z7+d9612FMWcWH6FBPK+x53A1kEeKEP9s3z
	 TG+iT2UbGzZq87SFu9IEgGMuOjtv+wjccPJR5jrB6wZ15N8Joh+6whxs00DTd0XZMj
	 pAJwCS+lApVLP7bZN8ZYMJXuhm282FR88TlasS991yME23hgl8Gr8M58JMfEh+9fFL
	 AZThR1J3DmzNA==
Message-ID: <0d24bc04-a9e2-4aeb-8199-428c657a3b34@kernel.org>
Date: Tue, 15 Sep 2026 10:24:09 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_inic162x: remove dangerous broken driver
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Jeff Garzik
 <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org
Cc: stable@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <20260915014714.41274-1-enelsonmoore@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260915014714.41274-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/15 8:47, Ethan Nelson-Moore wrote:
> The sata_inic162x driver was labeled as "very experimental" in
> commit bb9696192826 ("libata: make it clear that sata_inic162x is
> experimental") due to data corruption issues, but not marked as broken.
> Since then, no changes have been made to it that could fix these
> issues. Since the driver was not marked as broken, and the message
> about potential data corruption is only visible in the code and dmesg,
> it is possible that someone could enable the driver without realizing
> its potential for data corruption. Remove the driver to protect users'
> data.
> 
> Fixes: 1fd7a697a37b ("sata_inic162x: finally, driver for initio 162x SATA controllers, take #2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

The normal approach would be to first deprecate the driver, and then remove it
(some time later, generally one year). But given the broken nature of this
driver, and since there was no fixes (beside cosmetic/API changes) since 2013
when the warning was added, I have no problem with outright removing it. So:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
