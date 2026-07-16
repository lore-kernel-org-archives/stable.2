Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC173D7D67;
	Thu, 16 Jul 2026 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193452; cv=none; b=ShFn6CXlePJWFMAUAZxFTaVkSHiqwIKTBGhtKPH0bEpa7hnF5+EKr6OjJhRLqcZ5IyjC/JLzPNlnE6F1aulWLVLVkcj4VB8DzswiUGDnxslVUlvycVc21bdSOo80FFzH++riEwUQcShz5PNO2e0YoclotDMQIt8h1r35wzNs3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193452; c=relaxed/simple;
	bh=SoD7BMBlClWlAgJmMy9kCc+SBMGbq3PDbje7Iyy86OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUBQ+fwDP7edyI1dMvwunu9oGQ0gmmjPCuvwd7Y0dfngpnrfDHw3F2ZFkLeolSKYJKpfwGuPaUOMFXt89sdZ8wFlI/WYnWPGeTxi9HRDg9hOp8jGjM30QKFwXcFqnEQXVER2uhiOwn35fjgigTqofYkyj5D4r46ArGoUK1/Ycfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jri74q5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jri74q5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44C31F00A3A;
	Thu, 16 Jul 2026 09:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784193451;
	bh=ZyDE5K1/+hOMLkO+AeM4B//yXxZ3kvQOvIVMC+ad/6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jri74q5djWQv4tB2KgXzMQYg5LidNbOZr9Y3NelgBZrdiMiTQXj+cQWrBabMvQ7U7
	 zE9ycIwYvAgLxttCHq2DdfLd+OdcuXozUZxp3aQ+RWzTM8ON4a6/0YbOD5HYl1Q6nW
	 gKllglM9Fi1JawGLaLgqAMvudTOr8gSdLsrt2n8D9FifZhuigQCO8lpBm9IaXRoLoa
	 hX4ag7FqZ7B48xBcEi1scP6FwXrctQlPEQLZaJe++uI0Ye0wv0MTbBzcttbytsOoA2
	 4WJdnF71X0WN8gTRz6pg4BlVaiDYxISZo6FOGRnK9qsTlI2TmtMr+Bw0Np20uInyqW
	 XvVbZ6xGx5EcQ==
Date: Thu, 16 Jul 2026 10:17:26 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, richardcochran@gmail.com,
	david.laight.linux@gmail.com, aleksander.lobakin@intel.com,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net v5] rtase: Workaround for TX hang caused by hardware
 packet parsing
Message-ID: <20260716091726.GC95246@horms.kernel.org>
References: <20260709103456.83789-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709103456.83789-1-justinlai0215@realtek.com>

On Thu, Jul 09, 2026 at 06:34:56PM +0800, Justin Lai wrote:
> The hardware performs packet parsing before packet transmission.
> Parsing incomplete IPv4, IPv6, TCP, or UDP headers may trigger a TX
> hang because the hardware parser expects additional protocol header
> data that is not present in the packet.
> 
> The hardware performs additional PTP parsing on UDP packets identified
> by destination ports 319/320 at the expected UDP destination port
> offset.
> 
> If such a packet has transport data smaller than RTASE_MIN_PAD_LEN,
> the hardware parser expects additional packet data and may trigger a
> TX hang.
> 
> To avoid these hardware issues, the driver applies the following
> workarounds.
> 
> Drop malformed packets that may trigger this hardware issue before
> transmission.
> 
> For IPv4 non-initial fragments, the hardware does not check the
> fragment offset before parsing the expected transport header location.
> As a result, these packets are still subject to transport header
> parsing even though they do not contain a transport header. If the
> transport data is shorter than the minimum transport header required
> by the hardware parser, pad the transport data to the minimum
> transport header length required by the hardware parser. Packets that
> also match the hardware PTP parsing conditions continue to follow the
> corresponding workaround.
> 
> For IPv6 fragmented packets, neither of the above hardware issues
> occurs because the hardware only continues packet parsing when the
> IPv6 Base Header Next Header field directly indicates UDP. Packets
> carrying a Fragment Header do not continue through the subsequent
> packet parsing stages.
> 
> For packets identified for hardware PTP parsing, pad the transport
> data so it reaches RTASE_MIN_PAD_LEN before transmission.
> 
> Fixes: d6e882b89fdf ("rtase: Implement .ndo_start_xmit function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, the AI-generated reviews of this patch on both sashiko.dev and
https://netdev-ai.bots.linux.dev/sashiko/ flag issues. However, I do
not believe they should impede progress of this patch.

