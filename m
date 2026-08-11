Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20C2D7DEF
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415470; cv=none; b=DxwHU2DZgQi09Zj21aKlYAL6NLYGEojzYVBnDnJI3j32dlaGmNew4p+L3ZDvkeTGkYSati90iBTWNeBZRrEm7yMm8v06r24G2JU106DsAphRuaZySZUt4GZH3qDjQo4IeUICXN+ViJAonDrBFZ9cdyFufqriSoHpa3gltI64HpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415470; c=relaxed/simple;
	bh=/hwwtmwhIYxD/dt7K/Yf5LixT75qog8deovAcYfNIbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lr8cKdWsOnfyaYrLZlxu1iZEyXg0XGwHxKRo0udsdt380iqYILeXsDEJh3r2woqADwCSFr243H8vMXsj0fwS2c3KyF9nvrqvFJS/6opBc3iEMgdcU14myN2d57mamnAYCp9kVwuITZJvhAd9ZGQj/MlnTopx1cyciy8szEkbV4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0uVEVXCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0uVEVXCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400C51F000E9;
	Tue, 11 Aug 2026 02:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786415468;
	bh=sS3WEUHApkR45JEvmEPM5LMLaJaLmmMbhFhx7/BCtwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0uVEVXCDqU0uYJpcrYZhXL03YkC2depvHB51l5sgVr6phh3b0XhleVMhUO06TSlDN
	 ODxmcCxv8l4B/P8C5jyOOpHnAa3C/lqiTJTC2kpkCABlF6KwMSxi0ZsnAMj5hexCee
	 62M+mtukbvMcwgwGPo8Ehsd6ID8ciQY1LvmRsIoc=
Date: Tue, 11 Aug 2026 11:29:36 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergio Callegari <sergio.callegari@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
Message-ID: <2026081106-pebbly-cahoots-37a7@gregkh>
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>

On Mon, Aug 10, 2026 at 03:17:43PM +0200, Sergio Callegari wrote:
> Hi again,
> 
> after having looked a bit more thoroughly into the matter, and having gone
> through the relevant commits that introduced and subsequently modified the
> AMD backlight brightness code paths, I would like to suggest reverting
> commit
> 
> 1191285ecb4233e5bf907da7e9394d7999055566
> 
> from the 7.1 stable series.

It needs to be reverted in Linus's tree first, otherwise the regression
will be hit when you update to 7.2.

thanks,

greg k-h
