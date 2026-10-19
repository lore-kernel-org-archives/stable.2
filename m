Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437427;
	b=rZ+QVMJgsWnvPmqgrJusQ4iXIQMWVl3iuM/N23JSsg5stjkx95auW+0HxoUcyPHbkqmE
	 fVdMb3WK/W5SpFwo1e3rIztQ7w0cxg2QdiamTzDb4N5EsLZiSLjOdZLfmWnYbXydevmlP
	 4aaYBqBVHOB6a8U+HDcvy0wMF4cGnEhx89QW3VoEZTKAQrzhrzcdx6cyqQm4PRH+fSbN6
	 QDy026DClAqRY1+y+zpshRB2fuJxPv7p97fkt/taUejvJKZW8x/aOB/dBzbrnC2cySA/6
	 Oc0yQTMmuVu55UD6aEvdsWQzcutYC40cfuTWkXeLFsvTPNlwERcOEVdxcifprrdFdOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437427;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mCK4mRWoRhRA4f2Dg/Jnz5HIQpW7OjKBm4cWFf6QZic=;
	b=hTZtZ0l2d1J/WSQKCYsMLvWdbKU0Egml6neY5H8A4EOBoLc5V1Cx63RNdGw299dOF2ij
	 UOQcPm2xlsL+/Z9i3VVbxQTD0U+akRlUS899kAzh6xXrMoBQxRg90WQ/KBAVM1HcCwxTL
	 8eLOjycpb2e/fuOHR5/7m3A+B/iVUBi9V3mSAvTXjkRhjHIBHGg7SnYs3DoUI1h0AEdRe
	 t834V0QAz6NFKneQVEoiEUMC2hyk6cCo1MlyBbgmhVzTsDxSUgugRBIQ/P9MrZjucGVSg
	 D+2FQL9uHBCpMSOboyMrkVGJ77vISeiRgcchXlo8QRo4wJnH2Dv1ppygOzohnOWGvsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC144606A31A;
	Mon, 19 Oct 2026 19:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC144606A31A
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
Subject: Re: [PATCH ath-next v4 1/8] wifi: ath9k: return an error from a
 failed multi-register read
In-Reply-To: <20260916173429.403889-2-nerijus.bendziunas@gmail.com>
References: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
 <20260916173429.403889-2-nerijus.bendziunas@gmail.com>
Date: Mon, 19 Oct 2026 21:17:01 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87cxt5wlea.fsf@toke.dk>
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

> ath9k_multi_regread() logs a failed or timed-out WMI read and still
> copies its result buffer to the caller, so the caller gets
> uninitialised stack data for every register it asked for. The MIB
> counters in ath9k_hw_update_mibstats() then take arbitrary jumps, and
> an EEPROM read at probe fails on the checksum rather than on the read.
>
> Give the multi_read op a return value, return the WMI error from
> ath9k_multi_regread(), and check it: skip the counter update and fail
> the EEPROM fill when the read did not happen.
>
> Fixes: 09a525d33870 ("ath9k_htc: Add multiple register read API")
> Assisted-by: LLM
> Signed-off-by: Nerijus Bend=C5=BEi=C5=ABnas <nerijus.bendziunas@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
