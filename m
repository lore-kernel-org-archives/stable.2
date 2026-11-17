Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.125.139.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920356;
	b=EfMnW1VoPMpo/7q/MW5U1L5QrTTep64CziKbe1mwq5LaBEDCVuMSaVHLk/mIARe0OiS7
	 pV3ldcjU3jm16eQ+O0H9vdEFA1W4r5RCqLeCGqv4SaPogz3x9fyYH1Lfe/BX22R50/LpQ
	 3Y1GCqm0DMQlTqbk5U92FQEk3f1XZD5NxsJvS3kfFdm2T5KJEgjvRHBFd3cZKSiWqMQ39
	 e+pcR/Mfd2IuEqpAUVrbNTkpGjGG3F5UXSDVhBxCP3jfC2HJ6hmxwthuDxvTb2TocufpV
	 6vH0RPXp3p8urgZoEXxACsvMfDM+FgrWLQnqiPRvwjZTrMmHMcle0mdpEtmzgh/rW9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920356;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=zmYS0GN2id4S6B9+p+P2ma3OGfmv55Yw6pTtpNz0ax4=;
	b=NkOB6MQL9EiqPyyYlxY+addxFwGFzPwiDUWd8dexcru0TsG13LDz4GdsZZ9Dd9Zd8/SC
	 j7rOpYp7F+iE4P6RHFh6s+DiONCbOjlqlQ2BtBVQeahkVg0exgSvUpjfx2Umi2DmGFgKZ
	 +RZ24ngWwX3yw12QiwCJKPV5Td2/O10v2ePCPfuup9E6Gjy0nG0h9NhLhmWIrqx00bLnY
	 UiACvUdxArq2xj+zueTBDpcmby6uEkE5RKJE76ekNl6Y2tS/x1NnFuFwHoD7d0jAQ3I/s
	 u9LmwUaa1A7W8L7BDpNWGgCxxiYg61p78HvD76ZbzXTfBjw8QTvvUBlmcJiikk2sdnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sony.com;
	spf=fail smtp.mailfrom=sony.com;
	dkim=pass header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b="EeaW6eC/";
	arc=none smtp.remote-ip=211.125.139.72
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [211.125.139.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A0606A31C;
	Tue, 17 Nov 2026 12:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B15A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=EeaW6eC/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1794920355; x=1826456355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zmYS0GN2id4S6B9+p+P2ma3OGfmv55Yw6pTtpNz0ax4=;
  b=EeaW6eC/EbFjunxFlqaH8Tuft+l3gPU6ph1RHJ30ekqy6IZ+oKahways
   TWJTrAw5V8K7xaSuDdlHzGlmpcGmoFiSVKTFkmO2dNsOrS2fgJ/iv9AxH
   OLjDY5FJAqb4XY7JgZC1vNvE4wyZYNOYH3oM/QJ3G/0DB8fGk4CTb0mut
   9zObfJJAGd/6o3QYUfX6pzSasQJXcXrLdm7bmmf+SqgBsIYGde1tdR8qB
   NQMnm266rzMcav9ZGxcisMEiIKPRv6/LgGrNPzvDEyCuY984gQUqp3UPk
   yqIQnyTpof+N4SNk0XmLbkj/cJXbI3bK7Y81aMSoCBRtGzGmKo3gANArA
   g==;
X-CSE-ConnectionGUID: c/I+vDC6Sy+G05IzU+pv9A==
X-CSE-MsgGUID: g7CjE6mCQEmV/pX59xn13g==
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Nov 2026 21:59:13 +0900
X-CSE-ConnectionGUID: o/EHE8gRSzCh9O+gy3ZboA==
X-CSE-MsgGUID: PGkxXTqkTACjjzKTNEoReg==
X-IronPort-AV: E=Sophos;i="6.27,166,1786978800"; 
   d="scan'208";a="85562380"
Received: from unknown (HELO jpc00229873) ([IPv6:2001:cf8:1:519:0:dddd:790b:411f])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Nov 2026 21:59:13 +0900
Date: Tue, 17 Nov 2026 21:59:12 +0900
From: Naoki Matsumoto <naoki.matt.matsumoto@sony.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, regressions@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	chenchangcheng <chenchangcheng@kylinos.cn>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, Sasha Levin <sashal@kernel.org>
Subject: Re: [REGRESSION] 5.15.y, 5.10.y: media: uvcvideo: please backport
 5b9c75c794ce
Message-ID: <avxPoIvOXcFZayI0@jpc00229873>
References: <avxKOmxCBLF+7qdT@jpc00229873>
 <CANiDSCuX1+ehTGN=HNuLL9YBTt8tUw6fJ2D1JqfePQGaz+QOzA@mail.gmail.com>
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
In-Reply-To: <CANiDSCuX1+ehTGN=HNuLL9YBTt8tUw6fJ2D1JqfePQGaz+QOzA@mail.gmail.com>

Hello Ricardo

On Tue, Nov 17, 2026 at 01:42:00PM +0100, Ricardo Ribalda wrote:
> Thanks a lot for your email. I believe I already asked stable to
> cherry-pick this
> https://lore.kernel.org/stable/20260323-uvc-backport-bpi-v1-1-5b62c6798ccf@chromium.org/
> 

Oh sorry. Yes, it's a totally same report. I will watch also one.

Regards,
Naoki
