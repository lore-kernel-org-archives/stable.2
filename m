Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997339;
	b=ny1XWYI2N0Ll9hdE5Yze3uF18PO/OD3nWBsX2zls1JFD7yKpgnSlcb63gQkAfmYT5xLd
	 LDErUqAFweGH6vof8nD63cFFzJTLXJrxJMabjCR812I0uiB1pTNbNbkPrrHPwKgd5KnFT
	 OTscdxNr2Otk/0OfiI4SiE64gkcQrMaTOllX5hxt6GlHgIydfa3+RroEaS0oi7bIInCH6
	 EkzR50EOQhinQTIo2Z4D/kUJ24Bn6/X3DIpVXTvRG84qQJ3EkwhNU0C5cy+bsdMSbgfrT
	 JK8E/tgaiSLUtcqtrUkFutyu7CQ6Cq89tzDJ1loq/WGZSz/FtoumEc0LS2pJJxZuPEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997339;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=Ej5ViQLjc0HeyXNxFhpTSJoKBBRXm9gCVJ/qysZMi6g=;
	b=t56uDtZSrRQbYpkPAk4cdntWNsU64oySOIFRX0YJK/eoetU51SVSX51ojoht1bpbNUzB
	 77Jq0OcRN7QtDkylOujIdCc+OvTE9tRHym78JV6UYSmxmaRZYlcNcf9Q/p1c1qmT7wwpm
	 1UNgW9cU9bGNhimg7cos3O1NptbhOzaDs9OBTJIZ+VG/jnsmL9Q99oZwdhFWNTExvKoIR
	 w5BaHPMfKv58GpP98314djrIQMy/476SZy373PP5zOc3RUKLy2OI19XXQDgsYRMy36h8a
	 nd9CYLe++Rb9ReYRNN3FAA9rpDMjvvZ0TtGQCrYnlZ0JWsfxCW5xqpT25Md/aGPxT4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCGr5zRS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4DB606A326;
	Fri,  6 Nov 2026 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCGr5zRS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485ED1F008A3;
	Fri,  6 Nov 2026 20:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997338;
	bh=Ej5ViQLjc0HeyXNxFhpTSJoKBBRXm9gCVJ/qysZMi6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XCGr5zRSLpT6x5RIcnePNDxij6ETnBJeYK/oKzyoyoA6I5yfAlhzaksmTFVEKKptW
	 ve30u0xR4IRFK2bdk3o/2sdFlmG2x6KbYqXAdXYplMyP5GUzBxoyZj5s+8tJVn0vwQ
	 4KN8XLqBlAl/4ECcD27tA+aw3ftlBFMpZso78CFsj5q7UnLeRA8J++gLZwCnZwnv0F
	 H4md1xkptFmaCYeExQ/nF1eJeLrVTyge2uWsdzycyZwUNTi9N5/l2e7EAE2T8Sp1kj
	 CK8DADkOEe9wgckwLhtLrHfiLH4egCd5kJ28Z1iAxpNhkkU8F00sHk+MhgG3KD5RhD
	 MEABmrJ6lAERg==
From: Thomas Gleixner <tglx@kernel.org>
To: Mani Tofigh <mt4022@columbia.edu>, Mani Tofigh via B4 Relay
 <devnull+mt4022.columbia.edu@kernel.org>, John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 Srikanth Aithal <Srikanth.Aithal@amd.com>, Borislav Petkov <bp@alien8.de>,
 K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org,
 tz2294@columbia.edu, stable@vger.kernel.org
Subject: Re: [PATCH] clocksource: Use the clocksource under test for the
 skew check timeout
In-Reply-To: <d16c6038-f03a-4e1b-9691-1ae36650f39c@columbia.edu>
References: <20261102-clocksource-skew-timeout-v1-1-4ff412918591@columbia.edu>
 <878q39y8da.ffs@fw13> <d16c6038-f03a-4e1b-9691-1ae36650f39c@columbia.edu>
Date: Fri, 06 Nov 2026 21:35:36 +0100
Message-ID: <87zevlwvdz.ffs@fw13>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 05 2026 at 15:22, Mani Tofigh wrote:
> On 11/3/26 3:20 PM, Thomas Gleixner wrote:
>> So your reproducer does:
>> 
>>    while true; do echo 0 >/sys/devices/system/cpu/cpu1/online; echo 1 >/sys/devices/system/cpu/cpu1/online; done
>> 
>> right?
>> 
> Yes, but on a kernel booted with clocksource=jiffies.

I did so too and it did not happen within a couple of hours :(

>> Can you and Srikanth please run that on top to validate that we don't
>> end up with that?
> I ran my patch with your delta in the same guest and it holds up well.
> No hang and no "stalled" warning (even though the remote read timed out
> a lot during the loop).
>
> Do you want the delta in v2? I can carry it as a separate patch from you
> or fold it into mine, whatever you prefer.

Just fold it in. It makes sense in that context.

Thanks,

        tglx
