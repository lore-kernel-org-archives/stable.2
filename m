Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9AA3E4C95;
	Fri,  5 Jun 2026 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671859; cv=none; b=mkI8cI16TDnBn69LhZf/F3l/o9KpJ32DuzjxGuC3g/aoV3fRMQGyse/R2iG2uyNsokpI3rJsvQ2L2gHe3ajHD/tc+CJPiy/mxgSHF07Be5PohKIvmyKiOQ+bFp3jxcBxJHzv/7T0o0tPEgxIXnwCIegCUPPwskDUtQETFDCW1Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671859; c=relaxed/simple;
	bh=ovoYKAB4bYO0m3MdYKhDhzH0Kl5OSVG7wH1T3RYngcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvS1leIj2GiVEQBSoTcAu22PV3Pzg54rm+oIH29wsDQgsrCpVd0aSbvg6QQr0FKVGYFjZGt4Wv9+kZzENe4ElbIuzL9pB9IrVlvaik+55xLeTH7O7VsCoh3rRcpx3JW/kIAQyS1+Bjg1iExPQHujvp+LvOg1jEmcRXmM+WMESs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HfT4ihdL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HfT4ihdL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BF41F00893;
	Fri,  5 Jun 2026 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780671858;
	bh=ovoYKAB4bYO0m3MdYKhDhzH0Kl5OSVG7wH1T3RYngcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HfT4ihdLgkO9AHGm8VX+cEqicZhNwchUSNhXCuad2gbNbKmjJ2eKkaBN1iC/mO+c4
	 wvU79aEULSrvCw7te/tllY4qkYq2mLx+YlyuI7W6Q5HZXPsMHZ48Nir8IFe2+9aqdk
	 2aRc1++c7EG0NgQzxfJDxaUSLGfPsz9JNEkDrjbs=
Date: Fri, 5 Jun 2026 08:35:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: vishalmimani008@gmail.com
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
	stable@vger.kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, digetx@gmail.com
Subject: Re: [PATCH] usb: gadget: tegra-xudc: drain EP pipeline before DMA
 unmap
Message-ID: <2026060510-parsnip-tray-1381@gregkh>
References: <6a226993.a5745248.34e478.a9cd@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a226993.a5745248.34e478.a9cd@mx.google.com>

On Thu, Jun 04, 2026 at 11:15:47PM -0700, vishalmimani008@gmail.com wrote:
> RnJvbTogVmlzaGFsIEt1bWFyIDx2aXNoYWxtaW1hbmkwMDhAZ21haWwuY29tPgpEYXRlOiBGcmks
> IDUgSnVuIDIwMjYgMTQ6MDg6NTQgKzA5MDAKU3ViamVjdDogW1BBVENIXSB1c2I6IGdhZGdldDog

<snip>

Something went wrong :(
