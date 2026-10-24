Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792830551;
	b=QcXx/Og0aOV6/2LGwPCFlabRu7kBbL06I0ZAaqfRb1JqJqg5cfpO8RSlWx4MyJ71HTwO
	 70Tm+Db30klZWBGrdKgxrx+ySBBiuBAL/qH1eOaoBtmcuQM4nG71GBt0DWs1Z86HlmkSw
	 VaVa9PRSJVUQt//PQTmSfRuTRrSqo37d5+4ROU8V6nordMusi9O6rPJnLpsdskxWLEtZt
	 BnU268TDJLtoI7Ltq+FASrIOg4Ky+E0e8zlyfUkFYchMcRcgRU0RvHFGbc58N48FKUE1y
	 MwCCNqnsE5eCt7Yz+AqotJK8gqRafuy3nBjT9guCvQb+q7Qg2vmbmeNepTrNklVYzeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792830551;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type;
	bh=reH4bAkcleqLDuf8Qi9J6CPbOw5lcJORWlppYC9ksdc=;
	b=PxcP6m+bih1Z9Ohw5oqrds3WEXt1AcF0p7Nrpawd/4d05ImJegQ0DmQLoy64uNR7ZWzY
	 6Pw75RGK4VxntNXGl/lrn7DbD8c4/FuFQiQQYsCGq8/xDr5Lw2/gcCI3mJyVPHqTBNqdH
	 B2KbLv/G64dIwfsqaEgCR/8APje6MR+cVqOlFaxsZ4azYeyGd5kk9aiX2QFDLC6MypHWA
	 Gf186F8cEif1B+5/awf+t+k1wp8k/tnD3ajvzVYWmN9PKHkpdHxekJhc1YU5pxPqh+Hsd
	 7Op5AYJxi7ck7RYDj+AGewj8IId8QkIH04W7UD+SH6pdHJFsQ3XWF4X3BSXYlcfjVFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720B606A321;
	Sat, 24 Oct 2026 08:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2720B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Evan Severson <eseverson@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Alexander Wetzel
 <alexander@wetzel-home.de>, linux-wireless@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: reinstate IEEE80211_TX_CTL_AMPDU flag
 in ieee80211_tx_prep_agg()
In-Reply-To: <CAPoPjSd_CedgO6ghSs-vX-O599vVQyEaEniWfz0QpmfmV2YGCA@mail.gmail.com>
References: <20261023110052.650519-1-toke@toke.dk>
 <CAPoPjSd_CedgO6ghSs-vX-O599vVQyEaEniWfz0QpmfmV2YGCA@mail.gmail.com>
Date: Sat, 24 Oct 2026 10:29:06 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87mrs3pkml.fsf@toke.dk>
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

Evan Severson <eseverson@gmail.com> writes:

> Tested on the QCA9563 AP from the report with stock ath9k. With a
> station held in power save under downlink load, the TID froze in 5 of
> 5 runs without this patch and in 0 of 8 with it.
>
> Tested-by: Evan Severson <eseverson@gmail.com>

Great, thanks for testing!

-Toke
