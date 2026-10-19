Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437570;
	b=aof2ltXUhQBSysh6fz4CMx/m21Y/mzDJ8f7gam+MFBpmcudDPNU4QIMZsZTqIsDhrIly
	 +l6Hl/eRNHsOloCgRlzOK+/DiAB5Bzu0vU6D1C3CIwC+K2aDn6+ekKgc9gR3QIX76ovco
	 Zc3z9R8SQs+iLSNU4MAk6tKuEoDgrTeviQ9tpRTNSzQHSqVyHReHjN0kAHSUKEsko5R46
	 5TbdCF1mXfJi+gLCR7TlJrMTukZ3hdJvsbcLThy6zyLp/Y1VRnb1+BRGEDJIeZiOPDifo
	 u+/sgtJK+e0MOOOywSt55ubYmu8ViEZnlxlWL6joCNYxSxHC6NLrqOgxrW6FJImXL0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437570;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tJbQdYVAiS56TOxEOBzln50FzZ0HF0nlRdW35jrejtU=;
	b=OZZd+Guy5lKIPgnhyQXt3EdVRyOhBE6CdCRyG39X6/vDxBX7pbPmE4SyHMMkJSd5KzRX
	 4pWMN73afQvLMklz9VbdcjuUGDR5DxGkSL+RQfuM81EMAmGIfAGfziIV/dUVfdbkvq0xB
	 hXiaswKGWLTyA6ZOLbvU4e7uVcqToF9wDr5mZ14rAmDKkdgKJAT7PPYuRUiriLe3wliXX
	 meXgXa/4oMFfBoZ+QK2SPOP0VFyfk0EOMfR14nVSaOTU8gI3Dhbb8OFF78jPpZKKIaAsr
	 HBsbxEyTYDzROvqHBIwPg4JbN2cvEci21nHegboHnsGEmOL4brgfIlRzdwl15mPHRFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB4A606A327;
	Mon, 19 Oct 2026 19:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FB4A606A327
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
Subject: Re: [PATCH ath-next v4 8/8] wifi: ath9k_htc: derive the PHY error
 filter bits from software state
In-Reply-To: <20260916173429.403889-9-nerijus.bendziunas@gmail.com>
References: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
 <20260916173429.403889-9-nerijus.bendziunas@gmail.com>
Date: Mon, 19 Oct 2026 21:19:27 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87se21v6ps.fsf@toke.dk>
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

> ath9k_htc_calcrxfilter() reads the RX filter back from the device to
> preserve the PHY error bits a spectral scan may have set. When that WMI
> read times out it returns all ones, and the recalculated filter forwards
> every PHY error to the host with no scan running.
>
> Set the two bits from the spectral mode instead. A mode written to
> spectral_scan_ctl now sets them at the next filter update, not only at
> the trigger.
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Assisted-by: LLM
> Signed-off-by: Nerijus Bend=C5=BEi=C5=ABnas <nerijus.bendziunas@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
