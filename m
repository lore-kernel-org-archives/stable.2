Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436114;
	b=4zW9/mmBdZHN4Aej8dPQi9Yggmwr8NjOZ1n26DGalnDe854HLdgAnr/zLKaf1kIHPCnT
	 h9oQxY+a6GnfSK8Odr3QS5oTAbOZHo7GJ9NxU/xm1EE4m8wOZg8mdDcvgU0yqlVTN202+
	 dHdgw5UX8fXCfbnuFstdaD76xwK9xZ6j2lve3hBMTaFzKGlIw+qJEQ0gX4IWuFITjWvQ2
	 Rn1m1kXy0dYBy4Fwe+8uBYDyEsr6w0xQvuaedxWQQKug/TdrS/7h8SVgyvEz0ZzFVG6N+
	 XQ9eyDW4FZx1nlpxQACNobANbM5vJDtaNFc42OloP8r2yuWxvT7QCMWPUjR5hXpK9Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436114;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=78bE4Ellr1i3XQW6TTPvGswuyz5drWs9Sc9H0dy0gGo=;
	b=4WMh+0NNAZ/KYH0wOITSP83KNwfEvf8e/RysSvujPBpd/n0gjtlcKoZDG7WLyrhAJyh+
	 rxE3L4K/FhgKPgO2icd4KFv4R7mVWiRXgilbypO1zmIBC0nOs3VeGVMz3lKe8/CuzY1NA
	 eS5zKBqReD9kGdLvPWWW4lAqiAEjCmOCxsJJS9krl4aNknHXb37FLt9FT4rpKIDyTPGYd
	 CA9bB3kKGrlhPVL6TRn0wevGHoXhye2L079kIYlurjpr0hmG2yjgH7qyPjfaUCA2FLZRE
	 Iv0KdiruvYzdPYZtC6izZHL4nA1MA/+6psBg0ed3VXXRrx88e/VGhvIXhOap9UfG9sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=EsOQ0YMM;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBAD606A31A;
	Sat, 31 Oct 2026 08:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DBAD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=EsOQ0YMM
Received: from hawking.lan (ntp.lan [10.0.1.1])
	by www.nmnhosting.com (Postfix) with ESMTPSA id 0F2C2401D6;
	Sat, 31 Oct 2026 19:41:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1793436107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=78bE4Ellr1i3XQW6TTPvGswuyz5drWs9Sc9H0dy0gGo=;
	b=EsOQ0YMMa9j8jRi/VEaKb9RgsXY82OYrC9R2f1Lrb5L3UY6QKuUf2WDoUbPAopD4nG1tOD
	ssh3M+a3F7HIPIZeMSUXJ3Ugu6/+FCAaJnlRCkXdXHiK5HV1cM4V8FQ02Qx20gTXczp1On
	1sCBWmKBYpHPkK6nWsPVW61Fduc4/z5XrhLeX2agSbuelIjcLdNPomhjLtDo+Zp6zEqn/h
	ig+8Gakyc3ZG/32N+DLqYH/rtFyGchei92kuHBngU9splW3rNV2uideDG5KH9pFh5ZbPqn
	o6BT14Ionej6I/rrIcAPfBSFBK9S+naDdsV/CEVVbLAsFCV4Dk4blHyzZDrLXA==
Message-ID: <7c8bd6660a0bf47c169ae6a803b57e459ad41bbb.camel@d-silva.org>
Subject: Re: [PATCH rtw-next v7 2/4] wifi: rtw88: sdio: Track running state
 and cancel TX worker on stop
From: Alastair D'Silva <alastair@d-silva.org>
To: Luka Gejak <luka.gejak@linux.dev>, linux-wireless@vger.kernel.org, 
 Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jernej Skrabec
	 <jernej.skrabec@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 31 Oct 2026 19:41:46 +1100
In-Reply-To: <aa2500ed53d315edb7d6622dac3350fdd92b879b@linux.dev>
References: <20261031033526.474710-1-alastair@d-silva.org>
	 <20261031033526.474710-3-alastair@d-silva.org>
	 <aa2500ed53d315edb7d6622dac3350fdd92b879b@linux.dev>
Autocrypt: addr=alastair@d-silva.org; prefer-encrypt=mutual;
 keydata=mQINBGactvoBEADBFM2HqfQUUM4j40ZQPyYzmnM8S6zrycO0ipDDPMs7nZMzyzGzOdqfS
 VB/tuYvZOOKVWzJuWJ5aT/YyHx54r3L+D5hTkEG0sXPVJky3yTS9sbHEMSLBHb8TVVuhPVPuieV4g
 Nkqg5POMTidk8xAw50WpV++tUlewXVSciehnuCQPXhXMP7FcCh4uO8LdN7E8m7ir1LafKTFfoWPah
 KVT8NGG9r+ucrFcN5F+VnHxTDaI68yRPkNdtUWmp22wIX1KwDCtKFrndYO4p5Hv2hlDKomsuIIHHn
 muQGRwuh0xpf0nVJNF8ETZHMzxQLfo3e/HvxBFOTkwY9w7CuuQFZchbhS0I3PfmGT0+jiNcdfqjDC
 fPPB5uhy+DkR6wO72vuwFYUrpU2mdliDSdKEtWBHulnXMJjpBOXetfIwhI8G2dTVg59lN5i9DvJZc
 7y1Sp+qfZQ4P9qpYZyQEKR4GNDOdnm6F2LW2cZkcyAU/Ii765zdDMTQMIzZNSxT/FcDd0K1voTNRl
 QHbQw+kmIMhzSv2JefcC9oNbE0XYzcBDNP5T3O/4itOQ90GCKQEPAbIPeBjlQif7kkyvo/H6yv4s9
 duuK7zbJD9AID/+KGLkpU3p68VDB/C2ZSb9rQz3p1CJNSfsX/CPk7sPqA7RKZ4a2B0hSJ2pJCncNZ
 KXtMlkkm/FmewARAQABtCdBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz6JAl
 EEEwEKADsWIQTQGemDFwqYyU/dBWv75AdnjVo60gUCZpy2+gIbAwULCQgHAgIiAgYVCgkICwIEFgI
 DAQIeBwIXgAAKCRD75AdnjVo60qHZEACJnLfpS71Hk8bX0CLCNJ5wgqdZD3pBHEdbv9Ux9kRlZp4a
 ZFwlg9ltwBjl2dZP3PLtD9xQdsdYKVippKd5a7ZZC2y81oDaHjeC9LnPYn8+ce3mGE/+gRyoNfToY
 N06DeUNJKSlZ9t11UIqZCgfp12u16/Yrigy8C4ihEeHXlLhNX6JkeJR5gsHXJnC7vSuMZY+Qz2R72
 ZidWg+cd2WDMGop5sbTvc+55q94A7vTMlWzaix5HdbEUA3sd2U0dMBju5QodRGGhDQMcCu64TydRD
 MtMzzOk9ThJ036ze3HASWGOppyQmaw58k+XNzbHlr9Sc1LsFUNF7zpWXac2rzlywbyRAdFIT/TC76
 hy9zOkwIo2nwA/tdIwLx1j0UZPpAMQmcDUvJqZh6sE+fv6HN0yMPr+sSYJmriMt8Z6leCEHQXOHVI
 SI5z5FvV3coMmHYRq6aXpfs/8SLiYgkV3B0HE/E18Y3j1OkeLYoqIH1VfzQZeCSL/S77NYvk60/MV
 1HFSyqLdUR3uWZI4uZzoEcMoB0GX33uCTp2Ntc00+wSntwekCUQLCMLUb7dZrbpVuobHoWWtkiD2I
 uE5kAiaVwwwzM0BUwiM6VzVoKbeECz93rdsNtwoDqM0NtzoISC46H/BKVQ9mRNXDO4ThEBpJ4H2Tn
 mPNRYYcR0u2mNy1EJII04w==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


On Sat, 2026-10-31 at 07:10 +0000, Luka Gejak wrote:
> Hi Alastair,
>=20
> Thanks for the new version. One comment below.
>=20
> October 31, 2026 at 4:35 AM, "Alastair D'Silva" <alastair@d-silva.org> wr=
ote:
>=20
> > diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c
> > b/drivers/net/wireless/realtek/rtw88/sdio.c
> > index e39284b71837..253467250ee6 100644
> > --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> > +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
>=20
> [ ... ]
>=20
> > @@ -1069,20 +1072,38 @@ static int rtw_sdio_start(struct rtw_dev *rtwde=
v)
>=20
> [ ... ]
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 sdio_release_host(rtwsdio->sdio_func);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 queue_delayed_work(rtwsdio->txwq, &rtwsdio->t=
x_handler_data->work, 0);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0}
>=20
> I brought up this rearm on v6, but looking at the callers again I think i=
t
> may run a bit too early. rtw_sdio_start() is called from rtw_power_on(),
> so the worker can start on whatever is parked before rtw_core_start() is
> done with the device:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtw_core_start()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtw_power_on()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtw_hc=
i_start()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 <- worker queued here
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtw_fw=
_send_general_info()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtw_co=
ex_init_hw_config()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtw_sec_enable_sec=
_engine()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(RTW_FLAG_R=
UNNING, rtwdev->flags)
>=20
> The parked frames got their TX descriptor in rtw_sdio_tx_write() before
> the stop, with the macid and sec type of that session. So if I read it
> right, after an interface down/up or an idle IPS cycle they can go out fo=
r
> a station that is gone, and maybe even before rtw_sec_enable_sec_engine()
> has run. Resume from WoWLAN looks similar, rtw_wow_stop() starts the
> HCI while the WoWLAN firmware is still loaded and rtw_wow_swap_fw()
> follows right after.
>=20
> PCI drops what is left in its rings in rtw_pci_stop(), through
> rtw_pci_dma_release(). Maybe doing the same here would be safer, purging
> rtwsdio->tx_queue[] with ieee80211_purge_tx_queue() and clearing
> tx_queue_stopped[] with a wake of those queues, instead of the rearm.
> What do you think?

Agreed, your trace of the callers makes it clear that re-arming in
rtw_sdio_start() is too early and risks transmitting frames with stale
TX descriptors from the previous session (or while WoWLAN firmware is
still loaded).

Purging rtwsdio->tx_queue[] and waking any stopped AC queues in
rtw_sdio_stop() after cancel_delayed_work_sync() is much cleaner and
matches rtw_pci_stop(). Since rtwsdio->tx_queue_stopped[] is indexed by
enum rtw_tx_queue_type while ieee80211_wake_queue() takes the mac80211
AC index, I propose doing the following in rtw_sdio_stop() (and
dropping the re-arm from rtw_sdio_start()):

	cancel_delayed_work_sync(&rtwsdio->tx_handler_data->work);
	for (i =3D 0; i < RTK_MAX_TX_QUEUE_NUM; i++)
		ieee80211_purge_tx_queue(rtwdev->hw, &rtwsdio->tx_queue[i]);
	for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
		queue =3D rtw_tx_ac_to_hwq(i);
		if (rtwsdio->tx_queue_stopped[queue]) {
			rtwsdio->tx_queue_stopped[queue] =3D false;
			ieee80211_wake_queue(rtwdev->hw, i);
		}
	}

>=20
> The stop/start cycling in the cover letter was also run on 7.2.10, where
> tx_handler_data->work is still a work_struct and the 8723BS HISR mask is
> not there yet, so I guess the board ran a backport. Was this version run
> on the board as posted?
>=20

The test board's base kernel is an Armbian sunxi64 build (versioned
7.2.10-edge-sunxi64 by Armbian). For the test run, rtw88_sdio.ko was
built directly from the rtw-next sdio.c/sdio.h (including delayed_work
and RTW_SDIO_HISR_CLEAR_MASK) with our patches applied, and only
rtw_is_8723bs() stubbed to false so rtw88_sdio.ko matched the struct
rtw_dev layout of the board's existing rtw88_core.ko. For v8 I will
build and load the full rtw-next drivers/net/wireless/realtek/rtw88/
module set on the board so it runs completely unmodified as posted.

--=20
Alastair D'Silva
0493 18 5566
