Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424896;
	b=nC6AlB/Noz+c23WAIkqHgYholwE8jnhAwPaucSi6HNINr7DFclTvMKkUv2zmrLlr6Nuw
	 TiLEKCY5/9yK56YZALanXdehRHIjXZOzW/QepWhERTj+XMUI6lfDKEv3giRu9uu1z89tR
	 1JCJT4UDXRY38Ipl+i+9ujMhl8o63o2OyDq5WNNAiA074mp8hsQfXk7sVy6oREckNnYa9
	 W/NZXNTZMo5+9yRq230GdR1zGX9Da42A9koLxTMlk9OrLNZ4Wjf/UBE3SYvg9dB1LTt+D
	 2Aj+LVmZxuaBkCDHs5rGKzyhROzBOVK1X/FmXhMj6VULGMjbt5r+Uc74qDLIFTdXYwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424896;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Cm+fBf1IRChCh1IsPLW0+0K746awLXczpRLim5f3EBk=;
	b=tj0sNk1/9Vh1o5UutyGzfXMHkkYIJA9Kz4p0jZXKh1q5CvYEfaY697WcHlkNObhjpIzb
	 LFjKj+rVV6+3RKfhBnaM5NbF8YEZhKBvMmDwxi+1xQzwzqFj6tPuskr9RO+tVGqNyTgFp
	 XYHLkxGWzNafSJpYqUiGNBYHGfTo7UmmKi423jtb6D0meNoHIDmRqEJ6s/BWrs0qgcDVL
	 W+r2yLotb4HRCQB3ik7tGY6tNm+9n04NlHBCM/P7QjrwI+MCJGJjTZrLKgTj+KwEpuBiX
	 TtEduYV81uCzr8oPL1nqCKI0nWSvcaeePs/Dnfwe9sfDH0+i+NrONAJk65vGGc4vXEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ykNNjMPx;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208C60874B9;
	Mon, 19 Oct 2026 15:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8208C60874B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ykNNjMPx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Cm+fBf1IRChCh1IsPLW0+0K746awLXczpRLim5f3EBk=; b=yk
	NNjMPx4Zmvgamm9xATgCbSUri9eVqZWrEbnukIkhUCRki04Gvf4Bk2cuoHOOWv972G52yyOBjmv4K
	nhvbRkBzQAvPZ7uD9B5H5WnuRGursLTxK2SsigV7gSCvEgMJmmH4rl2Frrx+Bv2aYJC4hkTG71o75
	73zYmZuFI2f7PbY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xIpaX-00BfHG-Rg; Mon, 19 Oct 2026 17:47:49 +0200
Date: Mon, 19 Oct 2026 17:47:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
	=?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Grzeschik <mgr@kernel.org>,
	Jijie Shao <shaojijie@huawei.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net v3 3/3] net: fealnx: bound card_idx to prevent
 out-of-bounds access
Message-ID: <c6925855-4309-448b-8e03-165df8ad4bac@lunn.ch>
References: <20261019134136.104932-1-r.zhambakiev@prosoftsystems.ru>
 <20261019134136.104932-4-r.zhambakiev@prosoftsystems.ru>
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
In-Reply-To: <20261019134136.104932-4-r.zhambakiev@prosoftsystems.ru>

On Mon, Oct 19, 2026 at 01:43:03PM +0000, Жамбакиев Радий Рикардинович wrote:
> From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
> 
> card_idx is a static counter that is incremented on every
> probe. It can overflow and wrap to a negative value, which
> then indexes options[] and full_duplex[] out of bounds.
> Large values also no longer fit in the 12-byte boardname[]
> buffer.
> 
> Bound card_idx to 99999, the largest value that still fits
> into boardname, and fail the probe for any card beyond that.
> 
> fealnx is an old driver that cannot be tested properly on
> real hardware, so a minimal best-effort guard was chosen
> over a larger rework.
> 
> Found by Linux Verification Center (linuxtesting.org)
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>

Please drop the Fixes: when you repost to net-next. This is one of
those theoretical fixes which never happens and nobody cares about, so
there is no need to backport it to stable.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
