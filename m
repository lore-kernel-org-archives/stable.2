Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677796;
	b=hhgpvTCWvjejKXOf+/dd6jg6/jGj4UTX6RzhPvoDxEMl2XjpOyTteBtakMGpksYCimg3
	 vid+8OuYrp7e24itFFK4v6fCuwo3mkya77brSwu2aN9tW/lKEKKzmSm8R1jE+pcHQDpaV
	 t20O28HrVycmk3gCuskSN5zADNEj65hR4egTIZTWZLyd6sNj1JSdx+vPnc3U3sFzANcQd
	 xQ4DBFh7UQtGNGgsUXH8hXtQKobDDVldq9XpkD5rvOm1okeVr/8K0VaXJv0SQB6cyrjpZ
	 4n4Ed0/vgibmgj9bwlQhtzgO6s8ziaze1n06WrOVaLBHoVuov6barbffFnGrqY6bAUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677796;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=3olqN/jhrVTIQZR2WSJp/V5JDwf51XSwdDE1X7q/uVY=;
	b=3G4ReXxoHfbuJTYSlrcGDiUUAehQOs+GcmSjZ4vBlLiyTDgtVApjswRH86ioeld1VNc7
	 7HsSweXlvfflNw5+OheUx5/c7+edpenzTvg383FPQpmmsoHombYc5ZW1I0+AnLFWo1nXc
	 9mF+CoCs75ZJmg+BkXyQLe5fvexKxcyRDCRwSAUg/64sBVrwKngFNVw6AQaURGtRrsP8u
	 b35+c1DD9ACugFKUVjR8mxfwXPvy4e3EZEaVtkaY1HIEZIppzXgG5oqUmbsAnIiXFlTqc
	 iw92amS51fwxfSPKIfT2SZCQtIL3fXLHy7EcNH6aCiJhpTEPIEk62TilIPtiLS+JfKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wO8yxDfG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB0606A321;
	Thu, 26 Nov 2026 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wO8yxDfG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BBF1F000C4;
	Thu, 26 Nov 2026 07:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795677796;
	bh=3olqN/jhrVTIQZR2WSJp/V5JDwf51XSwdDE1X7q/uVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wO8yxDfGaqlb8/FWNBpmATxLglqMIAN/vdi8ogyYyXFwr+p4F6M9VfIxTLZauLd8K
	 Lm22ldSHjzm7OIQxP7LT4F+xE8Wkc7/XcuvkN21nzw9oICARirQKAqCI0kieTH+RIp
	 mLNT4bVLj3W91olSZ+Zc9etud9s0Gah4Wsx2uPIo=
Date: Thu, 26 Nov 2026 08:23:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 6.12.y] Backport request: 49b18315be4e ("bpf: Add NULL
 check for dynptr in bpf_verify_pkcs7_signature")
Message-ID: <2026112606-given-undesired-21d8@gregkh>
References: <CAMcAce_-0AGJYyRiSNheFsH7SB_A7-aoJr-DybzKGcVrAX8Bww@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMcAce_-0AGJYyRiSNheFsH7SB_A7-aoJr-DybzKGcVrAX8Bww@mail.gmail.com>

On Thu, Nov 19, 2026 at 12:39:33AM -0500, 梓川咲太 wrote:
> Hi Stable Maintainers,
> 
> Please consider backporting upstream commit:
> 
>   49b18315be4e590fae0fc39c87d46c87e9ec903c ("bpf: Add NULL check for dynptr
> in bpf_verify_pkcs7_signature")

Not a valid git id
