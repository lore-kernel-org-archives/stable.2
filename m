Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794550361;
	b=jCsULNAJ3b7CukuqJE2/67sPLw7Ve/+FnMHHDhK8yFMFC9VZYNVzujtrVlVzRep6FO8X
	 xV4ufQYpfvJHji+anotNBISrO+v1T+M+H+KFa3GzxDP5ZOyvhZYlK24CId9xidVSac8Am
	 UztPkSS4FJa4vP3WainHW51MyvbSgWiBmaNqVZZrieDK6qM052YTn5iAvbjI0U6/FEmtP
	 F8LdhmsOojzNpCWd4OTPfFdC7QQLLreyJJE1OT8BtSdIp8jZQZpQTvZ3+kScEzJ4NYDad
	 JW4+AK0H7iT6pTWgvXpEQDUy8v9kL4e2ENDBiiqWVQ/ZQqUs2+Nr4PjV/Lgpxv2jteg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794550361;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Y8vK4GNpDT6oK8SjBLJeX5KA6KP9CWbkq+lGHNznzAY=;
	b=f+4ZYf+gccQuDTgWGoVL7AJi6JC2YUugWdXxNsqOCHsHwYjdT3evih/Gi1n5/DglpSYY
	 kDMEW7/IyG1n5SZM6NuNquC9WdQypGMDMwSrRlLuOCXna8U60EkloxQsFdydBzFm0IZ2K
	 zsmwxqiOY4n2sRNxm3Lz3okNlgC6VsDdWywIruCXXBvRiTWtFPcLgsq5nx2l25l/N5f+q
	 ulqyx2KZPocC4eh/eZz8hdJrah8YK7lQdDiA/9z4EFHlr+RXF6X3CnaXCoOxKTW6FfgvI
	 ccbBWVn9QtjsP8h6XpaMRy4WqeWGyOiLuKKAESFnKCKyoTvEKZ5loigiDpjsa+uOXlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9+x+pI2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3B606A31C;
	Fri, 13 Nov 2026 06:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9+x+pI2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FBE1F000C5;
	Fri, 13 Nov 2026 06:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794550361;
	bh=Y8vK4GNpDT6oK8SjBLJeX5KA6KP9CWbkq+lGHNznzAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F9+x+pI2/BWW+SUvzKCRfyqVKSox9PbIRvKa5HcaW69Fm8H5UFELgUVuDYdDYpTNu
	 xdtdvtbEqTa5ZYXZkR4M7bC2eEAiXPC92tSWPR/NH5742J2m6/zVxHw5U5/SD2M9iZ
	 4i8wPvr1EvSFOxBuvR8/mF86ynUZ5Rq/xDV86SRkYXLdI/siIECVaysS823xiB8rLg
	 oaaUG9qsxdZ7YkvTG2bPuTaXp++HsfmakkFfAb9Ru4d9B72XmOLNRvwnAOl1TCIxqu
	 bY1qam1QZM5yMaJMC7eFAV2duh+Hwl8gU5DSPd87cotKyesFMc9wzmq3hPNDKL8Kvg
	 5Tgsw2tMv0aiQ==
Date: Fri, 13 Nov 2026 06:12:37 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Chad Aldreda <ca@modelmiser.com>
Cc: Dan Callaghan <dcallagh@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Sami =?iso-8859-1?Q?Ky=F6stil=E4?= <skyostil@chromium.org>,
	chrome-platform@lists.linux.dev, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/chrome: cros_hps_i2c: fix use-after-free in
 release() after unbind
Message-ID: <avaqVeJWzupa__xr@google.com>
References: <20261110123230.1251547-2-ca@modelmiser.com>
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
In-Reply-To: <20261110123230.1251547-2-ca@modelmiser.com>

On Tue, Nov 10, 2026 at 12:32:40PM +0000, Chad Aldreda wrote:
>  static int hps_release(struct inode *inode, struct file *file)
>  {
> -	struct hps_drvdata *hps = container_of(file->private_data,
> -					       struct hps_drvdata, misc_device);
> -	struct device *dev = &hps->client->dev;
> +	struct hps_drvdata *hps = file->private_data;
>  
> -	pm_runtime_put(dev);
> +	mutex_lock(&hps->lock);
> +	if (!hps->removed) {
> +		hps->open_count--;
> +		pm_runtime_put(&hps->client->dev);

I realized we can use `hps->client` directly to tell whether the device has
detached (i.e., set `hps->client` to NULL in hps_i2c_remove()).

Could you respin the patch to use `hps->client` instead of the `removed`
flag?
