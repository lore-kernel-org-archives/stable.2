Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437559;
	b=G+VO8ovqcqkdbcTTWPeaRoXtrzGEUO+NgNYIGX+kZRn93HPbABJltvsxq6yMZg8KBEtH
	 qU5ny3teLNNqONenyreK8gGgKeWEJaAIjA2Wv2l3k4OrPBDQptGn68X+CpjlzHrSvOcJX
	 khVKj/qMN7LYgOB26FwnoizCyxlT/o/jFuIqCcJ3gWP/mlCC7lgxB5h0ovecXtLkXnf0X
	 qL3Bec2y4o8peMhLlzSM/gJ88BQzXQZnplbwycSYQDgx1ZmhcE/dAwe5LaT0mqFVh0AjK
	 /1kB4UsdJTX7lwzJv3c7H1cuVxheh50zoq45Sa5nTaUt+6SW2nMXMzuIeNyvkxvtinA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437559;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ckuXx3CX9DISlY35qKsG4MF79s3gKI7DPutbVzkjR2c=;
	b=ds7uvGNq79WXoMQ7wnhfWA2nj1HEwgJ6umLhWGxmELRyEA/lutclrXw9U8XdthntHRRx
	 OGt37t93Shc7gCF/nH4avafx47zN79OHQMxn1eBk17j57225/yXU78u+ApA6KKgWoljyp
	 w3ApV9//jL/wi1AZR5+DyF8+2vIXpbgSB2sycZkGK7eyf2AzypOZ2MNjm6T6cmBZMoCaa
	 vI2ckb+WnOcijhSCZZNC3R5ICVOxSKzNz+CGscNEEWVHKJipibA1XvV+IAWJbbxW3DIZJ
	 zreV5j+Y6wt4nyFuzHB4FZlItVIldtK8xFGe4IvKl84NpHZYlZZNPf+S03RzmcSFxqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226360A2602;
	Mon, 19 Oct 2026 19:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7226360A2602
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
Subject: Re: [PATCH ath-next v4 7/8] wifi: ath9k_htc: pass CRC-tagged
 spectral samples to the FFT parser
In-Reply-To: <20260916173429.403889-8-nerijus.bendziunas@gmail.com>
References: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
 <20260916173429.403889-8-nerijus.bendziunas@gmail.com>
Date: Mon, 19 Oct 2026 21:19:17 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87v76xv6q2.fsf@toke.dk>
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

> The AR9271 firmware reports a frame that failed its CRC as a CRC error
> even when the PHY error bit is set too, so spectral samples received
> under interference reach the host as CRC errors, and the host passes
> only PHY errors to the FFT parser. ath9k reordered the same check in
> commit 3a325565c7fa ("ath9k: reorder error codes for spectral"); the
> firmware never followed.
>
> While a scan is active, also pass a CRC error frame of FFT report size
> to the parser, with the PHY error code it expects. The parser rejects a
> frame without the spectral bit in its trailer. A monitor interface with
> FIF_FCSFAIL no longer sees those frames.
>
> Fixes: 83fb287ecd8a ("ath9k_htc: process rx spectral packets")
> Assisted-by: LLM
> Signed-off-by: Nerijus Bend=C5=BEi=C5=ABnas <nerijus.bendziunas@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
