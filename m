Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA037FF6F;
	Fri, 21 Aug 2026 04:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286446; cv=none; b=knR1ZyegNtzBycsfW1KTzKDjZkMHNkl4S3t3UfZm4eC26Ekpwyr+6JeRgQqTZe6/VWEon/Im21w/rfUPZUEo4iTfg6gi57mzg6D5NsaBly1S88YQQIrKywm9JYD0doq9yLiIi1gNAjZ4Iwr2zVbWg5Ag/MaKRqrTW557VZz7a+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286446; c=relaxed/simple;
	bh=dCHLsmWErhw9Ipqzit/IVQ8o3ra1UPHw3u0POVB+m5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5GLBuZ7BYH3SqiMMd0AQlczfktU39yz4K1VDwUFs4y3VB0UZ92xQVHn2WxmaHVfb2iyDsH4ONN6sY28awJNrm7GfMdHqVeJjIEw/abdxin+BXhUc6bP+exw1nl5nWPnfAvRiKan/q9Xx8OSPfR/EK3ba73t0Y0r3PVFyPJLwZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EiILEnsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EiILEnsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEE11F00A3A;
	Fri, 21 Aug 2026 04:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787286444;
	bh=dCHLsmWErhw9Ipqzit/IVQ8o3ra1UPHw3u0POVB+m5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EiILEnsyatZIRmss3ThdBrdcZHoRP5eSkeaWAhHOS/1r2nRSRbFLizecXn2e8Tgdk
	 1ASN1g/hBbAPxO7+LX8yKuZ2jCRkLD/1pakj6QA4d8WogE5qSVoIkdlPBdvpAiHzv4
	 0z4fse6fPsYsULh/YN4skPFrVb5Tq7AiIOvU0V6g=
Date: Fri, 21 Aug 2026 06:25:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tahera Fahimi <taherafahimi@linux.microsoft.com>
Cc: stable@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, raminwo0202@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, apais@linux.microsoft.com
Subject: Re: [PATCH V1] xfrm: prevent policy_hthresh.work from racing with
 netns teardown
Message-ID: <2026082106-widget-steed-ece0@gregkh>
References: <20260820211418.1409602-1-taherafahimi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820211418.1409602-1-taherafahimi@linux.microsoft.com>

On Thu, Aug 20, 2026 at 02:14:18PM -0700, Tahera Fahimi wrote:
> [ Upstream commit 29fe3a61bcdce398ee3955101c39f89c01a8a77e ]

No it is not :(

