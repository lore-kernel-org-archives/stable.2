Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039342;
	b=i1qPXW/pb5qH19eNfIyLDFtgJoD1FOlJl8UWgv7p+l9YWNM3spICUYBJXOg1UAcVXM/A
	 W1IE2I214Stq8aEOWKpmYWZTvqQRLkPXOexB/HIPO/DTPOMLghWadAeh00jicLxQcLFie
	 GspPkR+CoyBNoc5QqiS8zzolaePhJpd3h1ndNZuNilV3ym3nihAwbmTt4JTBhTT6ChgMV
	 4eDQizMGZ3W6TWUFPG6BlnJUYRsXifbTzxydTAXsKO9b1igu4+Dz9MziRQC6B4KDkS13f
	 zu12hSjGnLAOgQ6ojgQqO7gFOdIheGp77AoBDKyqFPwCwoQAVzQiXjBTyC4x1gaTsUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039342;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=JNbK+3JtDqoK1DC4+sM6KcHPLLUlIMyOj7/0GNQRg9o=;
	b=p9cTl5PiL2GWngk2NuZesyHEJAA1zVLNEAxbEqUudybaQrZBLL+6miU9jQzEyAWVfzYo
	 30tD/TfpdZZqJOVJzAYnE6EWNBV2At1q+nLjTjD6+lMrLm1q5dsjvyx9uQEohZx9NG7mH
	 f4SxFGBFNMEB2XYcgk8FSnZj9BDwYTn4AtfZPJqGjH9Mq1SY6ppBmptk5EFXyZ1bvXlM+
	 mlLECnuVYeuyseHh8jy1xhe+lJLUTd4AmT/7VyCopt1kqiQogdw33OWT+yxqzq+lDMikm
	 F6TvviaRZg+kTqWYBZadTHJ0yxdu2PpE9Mpmx3zrBmGv+h0HbfQFtx51FaoS+B27iCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5AWqwya;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ED5606A320;
	Wed, 18 Nov 2026 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5AWqwya
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADC21F000C6;
	Wed, 18 Nov 2026 22:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039341;
	bh=JNbK+3JtDqoK1DC4+sM6KcHPLLUlIMyOj7/0GNQRg9o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h5AWqwyaLkpnx1Dat2WKTSuLfiHi2KKRnny+PfMi6vomGWtyHxq7/5MMXMyNwN4wz
	 4iIxrzRE+l9skcBvpEYX2jzyU7UwdQ30WFFTy6uAWrBU2qVuzA3iO8BqmoO67As3Y/
	 i5PR4K8fV5ZZIkxosqxZT3OMLTp4v21ssHudFCvuOnHWjJxfqHDhODbkddAdDRVZpL
	 LSU4WIreeu/eG/bXskVbkjO6Mo8mmRyXy9lgF2XQTFh3SOqzM3zQvWUYvNfmRpcZTR
	 30LppC9Meek5+6l1ZSIt4kx9rXSBQtYQFGDel2jd5RvoL40bWBDXjRa79EUPcRJen2
	 LVt22gQIuF0ww==
Message-ID: <bb65c26d-06de-4d4e-9eaa-9e8a48df4a3e@kernel.org>
Date: Wed, 18 Nov 2026 23:02:15 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 4/7] mptcp: push queued data on passive TFO subflows
 becoming established
Content-Language: fr
To: netdev-bot+sashiko@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, dmytro@shytyi.net, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 mason@kernel.org
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-4-bf7656de653e@kernel.org>
 <179495458816.3136.11667924714644178222@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179495458816.3136.11667924714644178222@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 17/11/2026 23:29, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:

(...)

>> Without this patch, and before the
>> earlier commit "mptcp: arm the rtx timer if a push leaves data behind",
>> this data was not sent:
>>
>>   server-tfo-write-before-3rd-ack.pkt:24: error handling packet: Timed out waiting for packet
>>
>> Since this earlier commit, this data is sent, but only when the MPTCP
>> retransmission timer fires, here after one second, as the tests increase
>> its interval:
> 
> [Severity: Low]
> Which tree is "mptcp: arm the rtx timer if a push leaves data behind" in?

Arf, I forgot to remove that when I cherry-picked this fix. That's a
detail, it's a fix pending on the MPTCP ML, not applied yet:


https://lore.kernel.org/20261113-mptcp-cmason-fixes-v1-7-9205b77e9a2f@kernel.org

There is no dependency: in this tree, the data was never sent, as
described for the case "before this earlier commit". I suggest ignoring
that, it's not directly linked, and this patch will come soon.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

