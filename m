Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF5D207A20;
	Mon, 20 Jul 2026 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590362; cv=none; b=iOTd4udIAVvZpr7/QHNbIidDxE11g87RAzgXGZZZ1KYujAGfLgKfI+FrqpA3wu1lkwTbW92hN4ynzPaxCncclbPM+OAY9dRIY1K8BC3PfreM7vRS6/mc4E+3YdKXhUtUReS4o7CbvDGEvFMNSRdxQMnBLrwM8uKL3sg/+YrmiG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590362; c=relaxed/simple;
	bh=sYfSv0JFyAVNsBuCybevWdTdUKCGplASfGi5PevtwbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3FMKHt7BE+N6RbX6t/x2dAFr2Gy7c40Cs2DJJ7bOwR78VGDqZZAeOJ93shfhsTdUHMuCfF1uYrOSf6OFkoD75XaDGpiQI3B6CI+CSWV6ffgrqLBgDFkRob64Wlu0ggnmdtfyeA/0FJFTUaw7+uMIQmlM0IPkdwC1yuFkKlj2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqvARPqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqvARPqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686051F000E9;
	Mon, 20 Jul 2026 23:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784590360;
	bh=Dgp5Zh+mCjW8qPmI0oeBk+2vJWlq2PIXHElh+EPe7W4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WqvARPqiDdU7qwcZq2jN6jdBMiZrlhZOfsK+b4AoCn7VrWvsFyYzG1APGdklgp06K
	 MBkSRNETqo0BKpiZxMPwC1NS6jC14ha/c/QzVYCWCU9hmUxaCsWgMR7oRPJyf4nyvB
	 pbd2YpR/qG3Ju4tYdS20T5WSrm+nB0p8+G0uQEDGTH9mJUssH7wX8ejyU3vm9MvSu9
	 HAE+iNeD7Vvbt0To6UVvegKw3VSLUmeQI68bGhR++NjLgkyvrqBe55POIpqVSTDPuq
	 NVuoqZ1X/e4oACmhBaRpoQ6+YkMoq5JHZ3Yn0DjcDFz1lASJG4g/v6OaBZljBaiNSn
	 9CRhK2uEPddZw==
Date: Mon, 20 Jul 2026 16:32:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Wu <12321260@zju.edu.cn>
Cc: Simon Horman <horms@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>,
 netdev@vger.kernel.org, shenjian15@huawei.com, salil.mehta@huawei.com,
 andrew+netdev@lunn.ch, "David S . Miller" <davem@davemloft.net>,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] net: hip04: quiesce tx coalesce timer before teardown
Message-ID: <20260720163239.3d8b9f88@kernel.org>
In-Reply-To: <4631C8F9-598D-4114-AD88-BEC5D8617BB6@zju.edu.cn>
References: <20260703050133.2445155-1-fanwu01@zju.edu.cn>
	<20260709124309.1557255-2-horms@kernel.org>
	<4631C8F9-598D-4114-AD88-BEC5D8617BB6@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jul 2026 13:34:24 +0800 Fan Wu wrote:
> Thanks for the v1 review. The updated patch fixes the PHY teardown ordering
> and IRQ lifetime issues: hip04_remove() unregisters the netdev, running
> .ndo_stop and phy_stop(), before phy_disconnect(), and frees the devm-managed
> IRQ before free_netdev().
> 
> The remaining NULL tx_desc cleanup in hip04_free_ring() and RX refill
> failure paths are independent pre-existing error-path issues. I will address them 
> in separate patches rather than expanding this teardown fix. In particular, the
> RX fix must preserve the old descriptor mapping until a replacement buffer is
> successfully allocated and mapped.

If the patch matters you need to repost it, it wasn't processed in time
