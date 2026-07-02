Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AED4CA264;
	Thu,  2 Jul 2026 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001642; cv=none; b=sNyM3bc7n6souV9blghRJYUehvFjViU8k8vUEV1yTobTF8Or6lk5gK2qUnnxEcL3neiyq1w115HV12K+XxghB/b5OQtbpzDnCuCBT9V7e2CRXIcLw5ZsIZYOGiEb+lF4O1PiQx/YvlPqB3OyEt52UFWqnHSQnA+58FKZ5eJoQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001642; c=relaxed/simple;
	bh=R98QZzYpDR41aXFD47w3kHfUzVNIU5IUGG2s/zcV2As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovgUKMegcYSoxWNA+n+rewnIk0iKwEdlBohw4LWTVjSg5bIro99fV+ZPWr5xrGG6rEeyUqFZD3aNffyOH9TZ6MfcwGWI+qrC3gX2tiiwkykqxE6zDYO1H7AdipfovFVD85vJyeaoslFax0ZVSGXrqoYUVn8rcP/a7ouY77ozONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yaCzakvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yaCzakvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCDB1F000E9;
	Thu,  2 Jul 2026 14:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783001632;
	bh=22NrB53quUcL92USbBtWlF+xpexlIHtl2vYI1OOtmKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yaCzakvI2ONHSQhFmcWi+I3WBUkfJSvEKMpe6DJ5uj8d45bflUf/FCSZVKjGlq6T9
	 zHEc+fukuaOhNBr6ZSk/G0hvYQuZQ19gOpx1j8sSuI8OsVy0sBsQ88zOjp2CnNUvDt
	 44CAMBARDqaXB82rV1ZP1CjWaI7fmif+nnrtZeQA=
Date: Thu, 2 Jul 2026 16:14:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: stable@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Eric W. Biederman" <ebiederm@aristanetworks.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] net: add missing ns_capable check for peer netns
Message-ID: <2026070244-trustable-cresting-2d80@gregkh>
References: <20260617-sprain-dye-86c242ac@mheyne-amazon>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-sprain-dye-86c242ac@mheyne-amazon>

On Wed, Jun 17, 2026 at 08:26:39AM +0000, Maximilian Heyne wrote:
> The upstream commit 7b735ef81286 ("rtnetlink: add missing
> netlink_ns_capable() check for peer netns") doesn't apply on older
> stable kernels due to refactoring. Therefore, this patch is an attempt
> to implement the same capability check just directly in the respective
> interface types.

Why not just take the upstream commits instead?  That's simpler over
time than a one-off patch.

thanks,

greg k-h
