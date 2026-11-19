Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124736;
	b=yXGBdDO6YGIGDbCHc1jwduK4aSbigf22TKYH45wx8OBEAlHgBlGBYIVLgWT7ucWvcb96
	 o9XxmqHEeGMWyiRmdgrzPxveeVD28EvQ9hg3g7wvwDuER4CQH3tyDjmEeU9dqqS7LzAke
	 P5RWkrYmJPvMLeScFHkpuacJ5Gdiuyk+zcSyKN4Ec4WOMVekhbG9ZNBaLZOyST2f0L5Tw
	 IFS8YIn9V4/rsXBVmO35cgvGWzhnGNRWIk5Jv7b84XAjhOY24sXF6cY9nSLza0PKqErMJ
	 RW9sz8E0V8ktxxuoOHamxURj+f9eYOwl/brO0rBqJJkoJbuiTTF61NaiOvKmurVOZZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124736;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=kbeXVApitcBkF8I6bKixq+m46Px2A/GzS7KtCTTzmrQ=;
	b=LvXPnKAKnWecL3XjoEb3bISXlGvOG9ZKFiCI6fE02yb9NUZMvk0Gp25/3UcBwKX5Veuk
	 4jBa87dfsVRgidhLEnPt4uCdl4MJubQrDPmOeWZBik/54RaXY+4PFF8oNv5LKG0Ceihoz
	 2Dh0Z5HMzcMGR8xzVvf49I4dV+lPXFKyaD0Eyxh2tKg2FcC3KdvSZiSLnpZvm2pMhEUCA
	 vixdBMDvil4YdAfUnibJ7s/Ro5UW6bwU4UVNAuJuiZD3PDkJW2vLOVq0+OK+PxACBvtg+
	 67v6tXbw3MVCBBBduNhlbb184FepOe/BxbziBIazNVTgOwl4xtw3meVIfHLrN3uIo5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTqnEUhd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF452606A32A;
	Thu, 19 Nov 2026 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTqnEUhd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53F51F000D1;
	Thu, 19 Nov 2026 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124736;
	bh=kbeXVApitcBkF8I6bKixq+m46Px2A/GzS7KtCTTzmrQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=cTqnEUhdSy8RGtP4FGmsgG+DoKm+Jrt/mN9wIeO1f9UcpgGF7REucqMOK5PyZY3es
	 JrsntaoxddRUzixKlWLz9XdoXkFxeF7Vj8mVieRCZyTWwZgMQM+glOX8GYzu3ubxIN
	 A8ZGF/3xiWAzFsoqupdzkTwIe/2SqsivLW8zsJCLmxif5a6QSkjUJWmclLShXnhWco
	 UgzvGyjEYzPZGDfeUKihHQrbL3Le2Jq37k7O+wvJj5zxLbfoAuKXR9kDWRkYehOmL8
	 WcJp7PgiIUgAVeWVNBroAVfEu5LZ7cKpYoqZBa3sdOLzxd9GrpAQceQ9FQEvYCpCyg
	 fgVfMhijnCFvw==
Date: Thu, 19 Nov 2026 22:45:33 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Even Xu <even.xu@intel.com>
cc: bentiss@kernel.org, sammiee5311@gmail.com, 
    srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Rui Zhang <rui1.zhang@intel.com>
Subject: Re: [PATCH v3] HID: intel-thc-hid: intel-quickspi: validate GET
 REPORT response size
In-Reply-To: <20261028075512.597589-1-even.xu@intel.com>
Message-ID: <rrpsr3so-9193-352s-7q57-013pnq5opp9s@xreary.bet>
References: <20261028075512.597589-1-even.xu@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 Oct 2026, Even Xu wrote:

> From: HyeongJun An <sammiee5311@gmail.com>
> 
> quickspi_handle_input_data() copies GET_FEATURE and
> GET_INPUT_REPORT responses into qsdev->report_buf. The response length
> is derived from data supplied by the controller, but was not checked
> against the destination buffer size.
> 
> Adjust qsdev->report_buf_size to store the data length of report buffer,
> reject responses that exceed it before copying. This prevents an
> oversized response from overflowing report_buf. The rejected response
> does not complete the GET REPORT request, so quickspi_get_report()
> follows its existing timeout path.
> 
> Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI protocol implementation")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> Signed-off-by: Even Xu <even.xu@intel.com>
> Tested-by: Rui Zhang <rui1.zhang@intel.com>
> ---
> Change log:
> V3:
>  - Correct the data size used in the get report check

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

