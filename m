Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243991;
	b=NxmFqd/CGjiqijD340NTk1/x/F+8qg8eCOf1Tgop//d2VkHeVrMYN5Jk008P1HrbgroN
	 1x9XtG3hlFwuKBMPbiWJUmHPwPVofQwhol/Agg1wu0XPsdJQ1sSsD3Iet/R7Et2riv6ov
	 P99ej+cZA1zQKHWCFBbF9DDgEQwDklUOElN2LbCWXPEFALsqOOdEyBZRBVCggx8YZFXqj
	 K+066zEyxN6rhw4rARf5HUWWfh4la167xF52Nb9pRGIEMxmlWZuH/cB8Nm4d8wnRraIxC
	 q7h3a/UduO1CNPIUp2BiOOA0QkEgjcO37FMUK9Tb3qlnkxOg51Aaylah23W9JpE7AAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243991;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+2ygg8rU+IWIhzbpsE6kcg9CdBafbiOfaAIfHAcdeGg=;
	b=pod0oIcnA323vjwEudqSbp6/rsHW2UiazNb9O0WEHfZLB8k9lik+6cg2AOpM5E/DugpC
	 bhbH20g2UbugXefqZfWe6SX1nyNQohwlCCxl4KmpBrQ4JVN7Jklxyjun1c5atmR20am6d
	 r24MDnI6B09+CLz1lQg1OIPD+jbBpxx7DWioR32AE4ESGtGyJT6jFa/x9GRrGCyW8HJvo
	 3crvVj4+vkulLxFA8Rmgo2PVZYte2h2JrE/hFyb30vA3QSrcIOLoCT+2kkD6JxUBhWyNm
	 cBiMBbC14XubEkDeYkpRrEauU4KRxFfxmgRiasem0tICB6GGTvQv5vi+Mk8ehqSRZ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWOb9FDG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6B606A31C;
	Thu, 29 Oct 2026 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWOb9FDG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F521F01825;
	Thu, 29 Oct 2026 03:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793243990;
	bh=+2ygg8rU+IWIhzbpsE6kcg9CdBafbiOfaAIfHAcdeGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cWOb9FDGh7+avtTheoRyl8Jxy/64qVHs0q0lamCpeQlyIYUlm+/HPIE0JEzHOrl26
	 1sE3k+aesFQ5jlxAuuUSrYZJagoaeLp6TNxqTsZpvW/cYcWkbRfzUuSwwkTxLvEDhu
	 g5pf9V+qcrFR8Suy67UU3sQv60LGIwlTMJQvYzSs33pp6nxh39IbUVeJ42niFgI4Ze
	 /cu2OTzAXtFGy5/0g7gNXb57WCb1Q+h8OhRc4/HVrt/+DxqT4GlB0KMkFo2CqtdAy2
	 /QoBnvz44RMlTv1rzaJq6Y6UzUx2/cdzZKaTE4EOFyGooPWNJbo3pNgqVNcXRP6qFg
	 FdkFvKc60HvSQ==
Date: Thu, 29 Oct 2026 03:19:47 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Prashant Malani <pmalani@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/chrome: cros_usbpd_notify: check ACPI
 companion
Message-ID: <auK7U9gFbAYq19Mf@google.com>
References: <20261028051200.145621-1-yaojiale02@163.com>
 <20261028051200.145621-3-yaojiale02@163.com>
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
In-Reply-To: <20261028051200.145621-3-yaojiale02@163.com>

On Wed, Oct 28, 2026 at 01:12:00PM +0800, Jiale Yao wrote:
> The ACPI probe installs a notification handler through the device ACPI
> companion without checking that the companion exists. A force-bound
> platform device can therefore cause a NULL pointer dereference.
> 
> Return -ENODEV before allocating probe resources when the companion is
> missing.
> 
> Fixes: 7e91e1ac60bb ("platform/chrome: cros_usbpd_notify: Amend ACPI driver to plat")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

I'll queue this after -rc1 comes out.
