Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5F41D206;
	Fri,  7 Aug 2026 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099380; cv=none; b=R0SHjkNskBJHtR2T0z7zSPH9aTGGTjXDf1TItrhTek4OjfaTzZYrHFX1MNtTLwOCBWirUVYEerRP2hoQA4+4WjTIz8MoF+FkPMyG37Hx7iIrJ39xHQ1nsEEatGDdyZ1sQoW5Uj2xCWCg2V5fyiLJcDu8LOmbhid0NnxwZtz2sbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099380; c=relaxed/simple;
	bh=hLZnEGgoUnmCpVM2b9YH19E8aPgtVW/sHhuV/o9Czl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uv2WCJPDSATPIZi5UWm+fuAVuG7oU3tOGFxmUfUny5xTTQMy63wfgrtLDo0hoxjuEnB1N+OBQaL/583auzOrBzItym40Ll0gbCGozRR/ktFld31Yy2mTZ52nPA/3NWLLzoJBVaNnMThhxXOj9CN8agVmoPpvJJuzxDKomxcDYSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwEWI+Sg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwEWI+Sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE451F000E9;
	Fri,  7 Aug 2026 10:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786099375;
	bh=0ubMx73RyrMuL1RsZe+QO50m7c2wIr+B9zDqg8dBcT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gwEWI+SgFR633SkQ1IrjSgP+mSLn88LgYo71++vEWeANwqaYEhMNAIfgQh1Sa30Wu
	 KgqCLcBs6u071ZCy6j+gFwsqvLwhfvRmOwyQrA7YTCs4Ybn6mbvBbo4PUQjGldmo9g
	 q42rnb6FwSnJ4yhA2Dl+FkjwwIZ4qeZSRKW+6RJ71K6tSZbWtfUcsAOp+H/UqzBUr0
	 kxUjGXs/OuM+ArsgULx0hPc5gZq2Zkvy6osMXRuOu/W1w2HSM27UG5OWwt4upb68CD
	 3Vjz7aOciWgVbGqNSr4pJDAp3digj0W6eOJoKAeIdHLSYMHK9y/FVDzt+jGdaevjBx
	 azLg+SZzP0oaA==
Message-ID: <cb5e974f-136c-4231-8262-078aef2fe156@kernel.org>
Date: Fri, 7 Aug 2026 13:42:52 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] media: microchip-isc: do not touch WB registers
 when not streaming
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
 <20260803-balki-isc-prefix-fixes-v1-v4-5-f625d6aa0ae1@microchip.com>
From: Eugen Hristev <ehristev@kernel.org>
Content-Language: en-US
In-Reply-To: <20260803-balki-isc-prefix-fixes-v1-v4-5-f625d6aa0ae1@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 13:20, Balakrishnan Sambath wrote:
> isc_s_awb_ctrl() called isc_update_awb_ctrls() unconditionally, writing
> the white balance registers even when the device is runtime suspended;
> on many ARM platforms accessing the unclocked registers is an external
> abort. The write was also done without awb_lock, racing isc_awb_work(),
> which holds it so the DMA done IRQ cannot latch a half-updated pipeline.
> 
> Write the registers only while streaming and not stopping, under
> awb_lock, and update the profile there. The isc->stop check covers the
> window where isc_stop_streaming() has gated the clocks but vb2 still
> reports streaming. Otherwise the new values stay cached and
> isc_configure() programs them at the next stream start.
> 
> Fixes: 4e52889f48fe ("media: atmel: atmel-isc-base: expose white balance as v4l2 controls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---

Reviewed-by: Eugen Hristev <ehristev@kernel.org>
