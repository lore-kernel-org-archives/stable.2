Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A65C4315A;
	Wed, 22 Jul 2026 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733188; cv=none; b=ISfbJz0PwuoVlSroN27J6cP9PBSXTu2ackCe81ZflaRzV8X46aNqmfNPBKyjMHAPtKUJO9oc1TWyjXIfDtTbWhXl6lvzvl0TKF94sW1NBzA/m7fKKtfSCKjt9ZI6//S9UGprxYg9TAZN6FRdANHuMSBc4P4GnXXhW49Q8t7owBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733188; c=relaxed/simple;
	bh=m9trUnR4dBBYxmRnQU/Yv79OKE5xa7ig6bqgKmqOEyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+eSs2XXSWUUG02q+E21pe++UJJM90PNWBvBPb/iIAtUfT3EKFM2wWEGmY2ZJgtW0runIX5iUtwciKffGmBt9zGEFiUKpuHIHGOrFA6Uz2LL1StSGehSBTutcigjhw3RDEBjWfvqZQavzx3uJjKo1Go7tGEzuOCmCeSHvx6aJI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlsJFjOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlsJFjOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FBF1F000E9;
	Wed, 22 Jul 2026 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784733186;
	bh=CdvrZC3DTk1xoDygI32uKfJ+XHbG+XPHXKdsPWJkktw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZlsJFjOEqgoYZe3107NxweDyYZlJBBv/VAqKctNP3Bhgab10RBi/veineZ1QhWIaB
	 oj9Mck53nZ1/pA5lebemP4DJ4RVWNW9BRDZ/fQLBFcUECRdrfprojSPBHBQNnJoezN
	 imDGjDHQkGjPQ5rM7ogtRGDX2z2SyIhuAUWZv42Wo3/8iY2pLsvybytPB2vJ1XJleN
	 D5jOAFHhCMrXFBTuLlfOq6hMvDc9KiyIKz+FpUgDfEYNgUJycSmUUhrC517B/XSTyp
	 6MvahAgC0wnie2lbl9+DQxb5h04rMDDRW4gEoCx07O9Fpv+3FBtA7ZYhjhg/yK2VjQ
	 YyDMnt2S/Ty1g==
Date: Wed, 22 Jul 2026 16:13:02 +0100
From: Simon Horman <horms@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] mctp: serial: handle zero-length frames to
 prevent rx buffer overflow
Message-ID: <20260722151302.GE418547@horms.kernel.org>
References: <20260715082021.46315-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715082021.46315-1-doruk@0sec.ai>

On Wed, Jul 15, 2026 at 10:20:21AM +0200, Doruk Tan Ozturk wrote:
> The MCTP serial receive state machine reads a frame length byte in
> mctp_serial_push_header() case 2 and validates it upper-bound-only:
> 
> 	if (c > MCTP_SERIAL_FRAME_MTU) {
> 		dev->rxstate = STATE_ERR;
> 	} else {
> 		dev->rxlen = c;
> 		dev->rxpos = 0;
> 		dev->rxstate = STATE_DATA;
> 		...
> 	}
> 
> A length of zero passes this check, so rxlen is set to 0 and the state
> machine advances to STATE_DATA. In mctp_serial_push() STATE_DATA, the
> incoming byte is stored and rxpos incremented before the terminator is
> tested:
> 
> 	dev->rxbuf[dev->rxpos] = c;
> 	dev->rxpos++;
> 	dev->rxstate = STATE_DATA;
> 	if (dev->rxpos == dev->rxlen) {
> 		dev->rxpos = 0;
> 		dev->rxstate = STATE_TRAILER;
> 	}
> 
> With rxlen == 0 the "rxpos == rxlen" terminator can never fire (rxpos is
> already 1 on the first data byte), so subsequent bytes are written past
> the end of the fixed 74-byte rxbuf, which is the last member of the
> netdev private area. Every following data byte is an attacker-controlled
> 1-byte out-of-bounds heap write, and the overflow continues until a
> frame (0x7e) or escape byte resets the parser -- effectively unbounded.
> 
> Reaching this requires CAP_NET_ADMIN to attach the N_MCTP line
> discipline and bring the resulting mctpserialN netdev up, after which
> the bytes arrive via the tty receive path.
> 
> Route a zero-length frame straight to STATE_TRAILER instead of
> STATE_DATA. The trailer/framing bytes are still consumed, and the frame
> resolves to a zero-length skb that the MCTP core rejects; the parser
> never enters STATE_DATA with rxlen == 0, so the out-of-bounds write can
> no longer occur.
> 
> KASAN, on a frame of 0x7e 0x01 0x00 followed by data bytes (before this
> change):
> 
>   UBSAN: array-index-out-of-bounds in drivers/net/mctp/mctp-serial.c:370
>   index 74 is out of range for type 'u8 [74]'
>   BUG: KASAN: slab-out-of-bounds in mctp_serial_tty_receive_buf
>   Write of size 1 at addr ... by task kworker/u16:0
>    mctp_serial_tty_receive_buf
>    tty_ldisc_receive_buf
>    flush_to_ldisc
>   Allocated by task 152:
>    alloc_netdev_mqs
>    mctp_serial_open
> 
> v2: route zero-length frames to STATE_TRAILER instead of STATE_ERR so
>     the trailer/framing bytes are still consumed (Jeremy Kerr).
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> Fixes: a0c2ccd9b5ad ("mctp: Add MCTP-over-serial transport binding")
> Cc: stable@vger.kernel.org
> Suggested-by: Jeremy Kerr <jk@codeconstruct.com.au>
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Reviewed-by: Simon Horman <horms@kernel.org>

