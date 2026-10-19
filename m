Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437506;
	b=KEOjvkIVWwJ5uUERmWVDIZYJ4U/d8nQR1Pj4Xv6B3e/d4N/WLk69SiRedQ1VG51/HXFx
	 wI/VgRqu6cSWcvdtLCilk5+sp9GtsF5r+yqllu/8na+cbwvSzGLg2Cp+v+p8ftvUDcwvF
	 DD1peFu8K7Dsn3h2xb/f6zhDXr6SLgEAR82rjhTL5Lph6kImIuxgMmS+2/Dp1l05sN8Q4
	 +U+AYaRa2E9nnk4Fe/26e9+0b8BorG5BLEhOT/LcDGE8grFfp2MAhiKI69jSh7lINT6nK
	 BHxWu6Rgvvg0qZr6z7e+zvV7JxmEKaykaytIQtiCJN6pUnVFwLq2P6rX/d1rSfdQNiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437506;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=E4+RLvIW9NIbsFzgbxK9FVikQGanMQmR9W30bubHgg0=;
	b=bUXchy/DaXIozBru/qaEycHIhdE4Emqs49FQ8LFUqNxfmsZCDPJD3wMaXKabJRHrAh8O
	 YEaRA0p9Ac6ei9zg9AR0Edi/Kte1XLtYJlUKJZS+lEQ8GxGuL2SAPN5nffefYPBmYUag0
	 kO8b65H9UYFNRBR+wGRmVjtNyFb+Bs5KtqKg+Mb+/t3B0/GOW5qKA+8CBgZLUzHYcwupV
	 kU6obbMKhO5t3GS/CZlXRkPjOfHuYv4c6j8IdG3L/eNdmTYrok2CGu9UeDLXeuHaStI+L
	 Pc4ytE6NW7L/0f9yJiMpHywX9FOBweRBeP8AOka2Dw/DTviPHjchnTY8Yex5fIosW/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780D606A319;
	Mon, 19 Oct 2026 19:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9780D606A319
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
Subject: Re: [PATCH ath-next v4 2/8] wifi: ath9k_htc: fix the byte count of
 a full RMW buffer flush
In-Reply-To: <20260916173429.403889-3-nerijus.bendziunas@gmail.com>
References: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
 <20260916173429.403889-3-nerijus.bendziunas@gmail.com>
Date: Mon, 19 Oct 2026 21:18:23 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87a4o9wlc0.fsf@toke.dk>
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

> ath9k_reg_rmw_buffer() sizes a full-buffer flush with
> sizeof(struct register_write), 8 bytes, instead of
> sizeof(struct register_rmw), 12 bytes. ar9271_hw_pa_cal() queues
> exactly 15 read-modify-writes, so the AR9271 PA calibration has been
> losing its last five writes since the buffer was added.
>
> The corrected command is 192 bytes, three full 64-byte USB packets,
> and the firmware ends a command only on a short packet, so the device
> stops answering WMI on the first interface open. Send the whole buffer
> on a full flush and cap it at 14 entries; 15 is the only count within
> the buffer's reach that fills whole packets.
>
> Fixes: 8badb50cfab6 ("ath9k_htc: add new WMI_REG_RMW_CMDID command")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nerijus Bend=C5=BEi=C5=ABnas <nerijus.bendziunas@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
