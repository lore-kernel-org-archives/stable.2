Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.79.88.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636571;
	b=IL6ns5EWUL48S8tpHer/KHaxE7PjONKfTNTVwDZskZ+ZDX+ArJtpgXmLyfjQ0MV2bwZ7
	 kQOUxDJaxgP2sAJYryKD8oJIoCq9I8I8KFIgUt0hCQpASlM2mEwZWYgVr8BjHi2RouiAR
	 RZBQUmBekbFvMUXQ+rdue/dtQd1xKnk9bVddn//1BNdy9+tdcK0INe/m6bEfgk3SmWZJF
	 wcPCF433AyQYWBKYwbc4dSxTL1rTFPUuV9EzbNTNlcLj6ygvo5S/rfAQGXqVlKWpCPxs8
	 oS5bwGI+J9ez0jQOEfvYbWALXEurt6WwQSUAklfgCN8avUlI9z86jTLM9OSz+XlNkcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636571;
	h=DMARC-Filter:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=27Tb0qhQlQalXZDEt6xbp3JoRCL6Z2oxUYWSYn9VaaU=;
	b=Th3vgycEZLWIUHIFPSd4+x6b0OI1TXAAEEeYHkzdI0AiEQWdT8wzCSdUiUom83OvksFf
	 JTQ3wy5+2sfoo+1RNXOQc5bkTnwVSTzyQ0+aUNLpcjOjPyEEZ80TRoF68W1JVBf9Dvwqs
	 ibX/ETUezusttzwBmI7cbQLKCrNKEy6D0qUTRjhg9wDrog/aNQtWvXzpnkJ54N+hgP57K
	 z4YMTVGmMPIBKnecB7G67JmvFTbIxviClufizsgKul2Q4QtSFctq2XvSUe8KYaAdFH5ny
	 lG/Rpw1QOg4eGJR929+XdkrXkaX1P2+04rPh0BIqOxA0VbQLTr09tD5i0Y+sll3RCNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lwn.net;
	spf=pass smtp.mailfrom=lwn.net;
	dkim=pass header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=SSoTtWg4;
	arc=none smtp.remote-ip=45.79.88.28
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A7606ABA1;
	Mon,  2 Nov 2026 16:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E0A7606ABA1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=SSoTtWg4
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AD23440430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1793636570; bh=27Tb0qhQlQalXZDEt6xbp3JoRCL6Z2oxUYWSYn9VaaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SSoTtWg4Pr2yMa+pV4NRa1ThzhgcN6lsRz8xgPloudzV8wOS1OdcaN8MKVa8Fj/w7
	 j0tAJzNdWOtZru6fuPgUDin0z1cFRW524vOBkrZ3zREZnleLWFWn7BQt+LEj57Bcny
	 Q6IscgK00I8i0B7HJYn2UDjq6tpuySNreiiojkTk1hcxb7PiCxoNAS7E2/KuAC1QZ4
	 TUIY9L1r6DLdKbGjfGvtpBrrX8jDcPm2Jl6bMofk86aRktFSLtwdMvJYH3RygEd/Oa
	 o1hEDwJ8QZDRO1Hp6EEV6LIOfokecNjznNrbLrghI9X4fqbqkzHKGfTkZguFHEJ/a3
	 SRGUdXEHwMWvg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AD23440430;
	Mon,  2 Nov 2026 16:22:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Bradley Morgan
 <brads@mainlining.org>, SJ Park <sj@kernel.org>, Kees Cook
 <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4] docs: stable-kernel-rules: drop rules the stable
 trees do not apply
In-Reply-To: <20261020142537.3533510-1-sashal@kernel.org>
References: <20261020142537.3533510-1-sashal@kernel.org>
Date: Mon, 02 Nov 2026 09:22:49 -0700
Message-ID: <87h5hzciee.fsf@trenco.lwn.net>
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

Sasha Levin <sashal@kernel.org> writes:

> The stable trees do not apply the 100 line limit or the exclusion of
> theoretical issues, and they require a fix to be correct and tested
> rather than obviously correct. Drop those rules.
>
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: SJ Park <sj@kernel.org>
> ---
> v4:
>  - Split out of the agents skills series, where this was patch 3/7 of v3:
>    https://lore.kernel.org/r/20261016152828.3765695-4-sashal@kernel.org
>  - No other changes.
>
>  Documentation/process/stable-kernel-rules.rst | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied, thanks.

jon
