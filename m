Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B9399007;
	Mon, 20 Jul 2026 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542313; cv=none; b=Hk0axwSB6fbfZrS1TX5BaNn8Jasof2oXlWUMh1pM9UTMZ14VDn3I+hv38yl+qmCTq0pAwXUGg5XpvRJgUpOW3dwvzEJcQXS5c4QXX+YIxA5KVXRjnQvEYR/KmVyRJKgJ5oE+5s94gU9MK3R88cLEKuMcuZ/vKepDQUGHpHqQetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542313; c=relaxed/simple;
	bh=DewHG13sUWC7dIhfFvBcDvyz9zU9ThsJoF2f4+913QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUO0G+x+gSLmjpoQBojdTHzcdcYbFAc3IHhytdtGnaUV8ORDYMFLBSgQrnQ+9SQLYfMJBO6I0rfUi+pZZVSkU1vUzR2v8OCOnn/XwUiJIeZsvJre3/OvdYxcYOAkre+bga7OYGHOTyvrnCtVlF0g87/4Fg+D3eD2h+BskB0JURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVEnz2ec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVEnz2ec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9033A1F00A3A;
	Mon, 20 Jul 2026 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784542301;
	bh=dbm6A8rAyWLjLJX3rbi1Bn9V1WupYEoffrCvgsjM+sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NVEnz2ec5EMP0aXv914FPIV+OGPSj9DOh0NKq4hyYH2wGFyhPWAv+I9fN9lIMol6d
	 5U8nlax0pKLlxgW0fplKnC0iYlb9yGDRNkEb8gPWxhKiuNdHGzyw+gbHtxDMbtpxmk
	 AOToUof/CGIo8yXUQ8Nz4Ce6SL/gDnj/cZ9WP3R3ztmK9154SHhJ964lEdALLxdnk/
	 QDP5bDtE+/AJOXn3ROupmWkCgwCIxCdiw59XBfeVx2h0bsx3XDrx9qtlw7mAUqTmp0
	 jTvlfElidWxtRnhnQrv2MfGRZvbI1njGCg1bqJaZGxfoUIyQqen3WX4ci2HMZM94jb
	 vFy7MU122hJhw==
Date: Mon, 20 Jul 2026 11:11:38 +0100
From: Simon Horman <horms@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: port100: reject frames whose declared length
 exceeds the received data
Message-ID: <20260720101138.GC19108@horms.kernel.org>
References: <20260711123651.32595-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711123651.32595-1-doruk@0sec.ai>

On Sat, Jul 11, 2026 at 02:36:51PM +0200, Doruk Tan Ozturk wrote:
> port100_recv_response() passes the URB transfer buffer to
> port100_rx_frame_is_valid(), which checksums le16_to_cpu(frame->datalen)
> bytes of frame->data. datalen is a 16-bit field supplied by the device
> and is never checked against the number of bytes actually received
> (urb->actual_length), so a device reporting a datalen larger than the
> received frame makes port100_data_checksum() read out of bounds past the
> transfer buffer.
> 
> Reject a response whose declared frame size does not fit the received
> length before validating it.
> 
> Found by 0sec (https://0sec.ai) using automated source analysis; the
> missing bound is evident from source. Compile-tested.
> 
> Fixes: 562d4d59b8a1 ("NFC: Sony Port-100 Series driver")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, I do not believe the issues raised in the AI-generated review of this
patch on sashiko.dev should impede the progress of this patch. Rather, I
think those issues can be considered in the context of possible follow-up.
