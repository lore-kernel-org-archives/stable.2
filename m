Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437545;
	b=FxLH2M0iTjPENv6K7g2PT2jeyZSkTszpRnZagPSgBjOREiwzrHLXFM5X+HVzF6Xy/qIr
	 JN5QhEqdEyViWxIP7VWKo+GdR8eQW7BtZUTORwygcNXfIEEeR6TMSCFlBXAGGoxK7BGFy
	 uWHqajGBNZvYRzHTB8fI5xjhRzJQsqs7TmFRVMyFno6CL3YzNd/ymVHZ/+9vsv1SfmgLP
	 +MS4l7vy+Duu8PaRkB2XAYID9XK5MpfMPYvMEAb6fKq6+VSpeTle1S8g3HxAwEPTNt7Br
	 tR/VWh+zDe8+LKM1LWhu4LSrH7GhXaQ0ZQG0u7es9qAtowC/47EjpI/xWYwaSt6O4tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437545;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vNr43py3jVhF0oOcIVZ0foVFHSm6HunoXjUgiLBI4mM=;
	b=Ic7aYlf/UhOwuhrayNFDUB+xxYdsyXeoOeRx3bi2sYbu3hViEdJVmapRqlji1+1IJjte
	 sj1/tcDltPYQ1Go7OrhLTf6eF86u+BPq627y/Tg6ymPQYArv/46fG+9gQko6wew/qDLOS
	 eDdJBtnckfaG6f/uAZW2jXHtkFRR8o2mxKsQFkw2JDtND9kobXCCuo9Od0TlG+ubSZRs5
	 Sh169sRLSXVHgwvGgNHvJQfYfEwxZKS+bRV/DgXAbZnO/tJTXQ5H2O7Bn/Tl5FyMTuIcQ
	 0UnaHAs93ZHzg7h3472Ypc09EqEUWn29fI6smo5toCCCfIACP7mkV3Tnn88KAv1iwtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B99606A32E;
	Mon, 19 Oct 2026 19:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9B99606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Nerijus =?utf-8?B?QmVuZMW+acWrbmFz?= <nerijus.bendziunas@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "John W .
 Linville" <linville@tuxdriver.com>, Simon Wunderlich
 <sw@simonwunderlich.de>, Oleksij Rempel <linux@rempel-privat.de>, Kalle
 Valo <kvalo@kernel.org>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH ath-next v4 6/8] wifi: ath9k: count spectral samples in
 the driver's own RX stats
In-Reply-To: <20260916173429.403889-7-nerijus.bendziunas@gmail.com>
References: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
 <20260916173429.403889-7-nerijus.bendziunas@gmail.com>
Date: Mon, 19 Oct 2026 21:19:03 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y0btv6qg.fsf@toke.dk>
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
Content-Transfer-Encoding: quoted-printable

Nerijus Bend=C5=BEi=C5=ABnas <nerijus.bendziunas@gmail.com> writes:

> ath_cmn_process_fft() is shared by ath9k and ath9k_htc, but it casts
> common->priv to struct ath_softc to reach the rx_spectral_sample_good
> and rx_spectral_sample_err counters. On ath9k_htc common->priv is a
> struct ath9k_htc_priv, a much smaller structure, and with
> CONFIG_ATH9K_DEBUGFS the increment lands far past the end of that
> allocation, once per FFT sample.
>
> Store a pointer to the driver's struct ath_rx_stats in struct
> ath_spec_scan_priv and count through it. Both drivers pass their own
> stats to ath9k_cmn_spectral_init_debug(), and both print them in the
> shared recv debugfs file, so the two counters now also work on
> ath9k_htc. Without debugfs the pointer stays NULL and nothing is
> counted, as before.
>
> Fixes: 03224678c013 ("ath9k: add counters for good and errorneous FFT/spe=
ctral frames")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nerijus Bend=C5=BEi=C5=ABnas <nerijus.bendziunas@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
