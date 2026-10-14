Received: from mta1.migadu.com (out-246.mta1.migadu.com [95.215.58.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C824E49CF54
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969183; cv=none; b=VcUuC8YGLi1PDrEPAm6bmQ1b1jFwsXJNEIDid27Q41DS1Bq2L1wrimVtDowvpreEuL0bJB2KmSpT+/GHNaLHjB5Vi2Wpmt9ubDCJ0Rs4/xSh3lOsDXdwBLYYwxiit567XYm1x6Uc7Vct0Zk1syl9xNvdP273rWreQA9rHFMuKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969183; c=relaxed/simple;
	bh=lEgnOh+QOt0L+POknI3R02rkeloFCY0tO55f0aJGrWM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=TBH0BOvKDa4hX0yh7WjBlB5MYxoYPxzichFbpjiFLZZkDSpPR2LSUtZCBqIZOjfxQcCZKKa1djjWV+gmXiepjdU9Z0Cc03novYH1K7hP3mjeDx2YzeYENRL1bCrwvyFDyVCKSyVrlmg0lMZjqDHhYR4zpwZpsHR463IakdZHF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b+9e9XcY; arc=none smtp.client-ip=95.215.58.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b+9e9XcY"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lEgnOh+QOt0L+POknI3R02rkeloFCY0tO55f0aJGrWM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791969179; v=1; x=1792573979;
 b=b+9e9XcYMpI/2OMtdrcxDX6Dznj/oJRo4NJZjS0xRJ+HqVy5m8L1v2SpbGanE9L6EZdYc4J7
 8EfHHTJW6O8edLjjOJOnvpcTo5DMYi2zNkZHMzCNmPs4bcm97X5oC5wds7byYtTBP2/YZ/2+TeH
 GLcSb0xAxkr+fyZ3XukqvZBY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f7a90f2c0ebdc97f;
	Wed, 14 Oct 2026 09:12:59 +0000
X-Mizu-Trace-ID: f7a90f2c0ebdc97f
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 09:12:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <602ff65a1384f1649c49dcab2d17975e17c29d7c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH rtw-next v6 2/4] wifi: rtw88: sdio: Track running state
 and cancel TX worker on stop
To: "Alastair D'Silva" <alastair@d-silva.org>,
 linux-wireless@vger.kernel.org, "Ping-Ke Shih" <pkshih@realtek.com>,
 "Kalle Valo" <kvalo@kernel.org>
Cc: "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Ulf Hansson" <ulfh@kernel.org>,
 linux-kernel@vger.kernel.org, "Alastair D'Silva" <alastair@d-silva.org>,
 stable@vger.kernel.org
In-Reply-To: <20261014074426.2183095-3-alastair@d-silva.org>
References: <20261014074426.2183095-1-alastair@d-silva.org>
 <20261014074426.2183095-3-alastair@d-silva.org>

Hi Alastair,

October 14, 2026 at 9:44 AM, "Alastair D'Silva" <alastair@d-silva.org> wr=
ote:

>  static void rtw_sdio_stop(struct rtw_dev *rtwdev)
>  {                                                                     =
                       > -     rtw_sdio_disable_interrupt(rtwdev);
> +     struct rtw_sdio *rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;    =
                         > +
> +     sdio_claim_host(rtwsdio->sdio_func);
> +     scoped_guard(mutex, &rtwsdio->irq_lock) {
> +             rtwsdio->running =3D false;
> +             rtw_sdio_disable_interrupt(rtwdev);
> +     }
> +     sdio_release_host(rtwsdio->sdio_func);
> +
> +     cancel_delayed_work_sync(&rtwsdio->tx_handler_data->work);
>  }

One thing about that cancel. The delayed work is the back pressure retry:
rtw_sdio_8723bs_reschedule_tx() re-arms it with queue_delayed_work() when
a page shortage parks a frame, and rtw_sdio_tx_kick_off() re-arms it with
mod_delayed_work() for every new frame. On 8723bs the frames that fill th=
e
software FIFO past the watermark also stop the matching mac80211 queue
(ieee80211_stop_queue() in rtw_sdio_8723bs_stop_tx_queue()), and
rtw_sdio_start() undoes neither that nor tx_queue_stopped[]. The flag is
cleared in rtw_sdio_init_tx() and in rtw_sdio_8723bs_wake_tx_queue(), and
the second of those only runs after a write has gone out.

So a stop that lands while an access category is held back leaves the
queue stopped and its frames parked in rtwsdio->tx_queue[] with no work
queued to come back for them. It recovers as soon as anything transmits
on any queue, because that kicks the worker again and the handler walks
all queues, so I could not make it a permanent wedge. It does mean an
idle link can sit on those frames for a long time. Would it be worth
re-arming the worker at the end of rtw_sdio_start(), or clearing
tx_queue_stopped[] and waking the queues there?

Best regards,
Luka Gejak
