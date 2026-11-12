Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478373;
	b=YLdb88NMITBdbOgJYVJkRDo23CBZAGLaXvatZDa+bXH+QmzLjJxlH+QqdKLlSZZhsyCa
	 3zGH53z6tbZQRWnAkgeJYrtmdoVoznSnjpsGQGe/v1e4Pwn1q4lb7HLrQ34bYxru4yLYA
	 2TWi66++1EEnGiTR/ak2b5RCsYvyVUbrSa/7Bd8TBG8Rr6Y8IYwLyCCLut4JCqEtRD6Y/
	 skRihK2vGih1V6pW/JVG2IJtiQUnJnZRwue4d+opTheuZGdt7r+j8ReQcO4cbwyMuku6f
	 ewrb2ePYsq/+WS0GwCiXngneMKdad3UjAIUIUuaAn6lXQbCqZsbrmG3jn2fXjj38Ljw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478373;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ip9Dxs0sYbFXHCE6CxfvB1y+SDLjjMSFRURq8FVjzis=;
	b=tM2ohh+w8IoMzZACL/ekIibz/7L04ZDMGVMx57/SZAzWFluo0FipjJKDwkQWlNecu89o
	 uP2J6i0aKcmusM1ZEOEkBmMjaHbHLTda094PP4lIECz9o3KxEAb+GTEXI+4a2EeLZiNnK
	 uIscck3flioK4VegzqL+Ry+8RakREbMzBs+y+cePUcpvscU7xPwX1BWMhTH2ftnpwwotj
	 ckeAW8sN5IWVup03QC8zpr3ZLYTqM7suJLs0p1mTbL31ckI8mjFPxEpqy1H6xN2xneOE6
	 edbvUpMCMsYmo0J2o1Wvg//AvpzRZWszPkEFpjvlxrQQ+D2f0zYgnR/CUYyW6906UtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcItnwEX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6528606A323;
	Thu, 12 Nov 2026 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcItnwEX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D171F00A06;
	Thu, 12 Nov 2026 10:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478373;
	bh=ip9Dxs0sYbFXHCE6CxfvB1y+SDLjjMSFRURq8FVjzis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lcItnwEXFmSJUby1NaJtwM/8xq26NL8agso9Uv1U8m0Yigf7ByM69N8wer9yOxExz
	 sAQ/O5I0J9JnOUsnML0lYdlqCMj3/9A1xO44++LZG7gIpBqwDCemltKYk0jsOaoZub
	 6Km4ybQia6mS4dMKGHbiAsycEqFnCjwtfV4r6Iey6g2LWh3VazkpigpSlkBn14NVZk
	 8dgCh04HRrmMTqlJlThaHjH+pV0d1zGXQQqvSVp2kIUeKckDgYbHhENyMcrddgnQIO
	 5o6spUZEvdFGAUW6RTf3/9hFqdtTdv02zW44zunc9B9gmNByfR4u1VKbqautBSO7En
	 kiW18vZGnMD7g==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xRRnX-00000001Smb-0br8;
	Thu, 12 Nov 2026 11:12:51 +0100
Date: Thu, 12 Nov 2026 11:12:51 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial core: fix use-after-free after driver module
 unload
Message-ID: <avWRI-3HpjoDnIYU@hovoldconsulting.com>
References: <20261112100541.348390-1-johan@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112100541.348390-1-johan@kernel.org>

On Thu, Nov 12, 2026 at 11:05:41AM +0100, Johan Hovold wrote:
> Deregistering a uart driver frees the driver uart state including the
> tty ports themselves.

I apparently forgot the colon after "serial" in Subject. Perhaps it can
be added when the patch is applied.

Johan
