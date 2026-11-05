Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793855958;
	b=4vQBzsZt9FvUrkNbgUn8uQ4kVHk/L0UaapacnXalGymA4aUnzhiPHfjSyTNBV4qvc97a
	 eXnyK3Iev4mO06BFoiPmbjSLAq94VP3f0PbNp64i+AaeOtCBOhT2RKCH6KR46J4z+1oOl
	 VrwwTp2DvUxL9Woc+D/1CgbEl7I8Rk8UNR4dxnw0Gvv30twUQne+rrKjcS9jbTgkTVk14
	 s3BFenE8SfpFpv+o0S98KUrttFGgxIVmEHm5ERcDtwVcc9B0eUaA6FtK+5PExX8UIP1g7
	 gT1/yTCIq7MuKUe5DQCWmneUFoBwGFgwawai0sE8M7suryOnwJq96TBLhNR+ubGLlTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855958;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=fOCYY6s4NWFJAtXADmmsBtaGwYYG3CP3GVT6+oHGss4=;
	b=gvCbC7DaXZjoVo5xCDGCvJA4odEKz6i3hxUUrHh4Y4yFuLYGuQirI3s7TYlJkM7mDLst
	 7xv3Hi5o0cq4/5EHjxNbEwnqHDWh2dseE5/Np7XlrCOBQw5+2dmMUuMfaShBq2b9pmfKl
	 j2z19Lo7RMhdXDudBWVJNo4tLElosE1ZyP7lVtnx1m7atk8hmZVBPBFbnurk5Tpkf1emM
	 hlN+Gkf+ANge6eSwxdsSIFAOkl/unO725PulX57sZVAkFN37CbxGC/PuNjUdWUdpCECWA
	 et9nWFxepdDLt9l+6rO9QF1O1aQywOw3OzLQZB5aYLu0zktYLyw7Iz5I1iwwtySCCTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=EDYxslUQ;
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF54606A32F;
	Thu,  5 Nov 2026 05:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF54606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=EDYxslUQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793855955;
	bh=fOCYY6s4NWFJAtXADmmsBtaGwYYG3CP3GVT6+oHGss4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EDYxslUQbO01HBCp/ixmJKShdGoiXZTMP9+Vll/sNFsk6h11qqe+XwZ+6qxPOCfa8
	 tf5r68QKO3IwSt1Q1PkjyBB7xXCcPuFADrPUmaVDYRxJnu5CPVf54q+avuxr5HJM0P
	 oDJalrYvOce34ImZ9Gsm3A1ydY5yEnHFM0JvRtYF9kvdhihB1KTZFoz4D3BK/5AZ/X
	 ZQ2oVKI4EzR2TNuTWPfiY6uMN5HT+dLEsqVQ1fUeYnLUunafRDOIQq4DDCkr9WS0xO
	 nDjeVOC1KDk2ZchRKkiv/gb4ViKzoIM6Oz+XetODn/xtG0+G8e7wGk1Vt5DLiCO8dq
	 gYsKnkWq2WuPA==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EAF2664698;
	Thu,  5 Nov 2026 13:19:14 +0800 (AWST)
Message-ID: <2dff7406f6bbcb188f70c4caf7193fb5f0fb8e82.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] gpio: aspeed: Preserve the pending G7 interrupt
 status on control writes
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Billy Tsai <billy_tsai@aspeedtech.com>, Linus Walleij
 <linusw@kernel.org>,  Bartosz Golaszewski	 <brgl@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Ryan Chen	 <ryan_chen@aspeedtech.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 05 Nov 2026 15:49:14 +1030
In-Reply-To: <20261104-gpio-aspeed-irq-status-v1-2-9805645f856d@aspeedtech.com>
References: 
	<20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
	 <20261104-gpio-aspeed-irq-status-v1-2-9805645f856d@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-04 at 11:58 +0800, Billy Tsai wrote:
> On G7 each line has its own control register, and its interrupt status
> bit (bit 12) is write-1-to-clear. aspeed_g7_reg_bit_set() updates a
> field by reading the control register, replacing that field and writing
> the value back. When the line's interrupt is pending, the status bit
> reads as 1 and is written back as 1, so updating an unrelated field
> such as the interrupt enable, trigger type, direction or debounce
> selection also clears the pending interrupt.
>=20
> Mask out the status bit when composing the value to write, so it is
> written as 1 only when the status field itself is being set to ack the
> interrupt.
>=20
> Fixes: b2e861bd1eaf ("gpio: aspeed: Support G7 Aspeed gpio controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
