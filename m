Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A7049D589
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399215; cv=none; b=FRsnPWy8XXeAfsNyvOzI8EwlCaKC94dlJHOMsTuUN67MkGJdZ8jPLxBA7COzpxwYQWr2Wnq51TjNHjCzFbOci5a7uqX0lV1JR0no6o182CKmCUywuKrLbQ5uHnBlnOWantQZUYH8BH3WeJ1e51beky4YS3iqEXHtDKPd4ROnhTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399215; c=relaxed/simple;
	bh=cy3Ua8MM9A2x9HjTJezL/FV7SFefbt/v8MEXoHPBQwA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QWJ+8BKIlPnT4+ncuoGPk3ZKDGYgzl3B1q33WRH3VQ95vSXQRe7wdNYLcdGq/m5gJjouv7GCkid7tEiJ00yi1GpKANwNpMovAkWyMZmfSmXCksblEqVLjhw4hXOY+BMKu7zu+aAtSYj29BYGGZMz0IJU0aJSqXunnlIUyFsOWaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=willbush.dev; spf=pass smtp.mailfrom=willbush.dev; dkim=pass (2048-bit key) header.d=willbush.dev header.i=@willbush.dev header.b=SZyFW1jX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jS2xAGn4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=willbush.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willbush.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willbush.dev header.i=@willbush.dev header.b="SZyFW1jX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jS2xAGn4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E98D71D000BB
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 04:40:08 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 04:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willbush.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1792399207;
	 x=1792485607; bh=L4Ow+hRf7Ev0Ou+3g1fetpg5NPLpYNBVh1UJ3evSwDA=; b=
	SZyFW1jXH94GZwCB2EsofhQ0fZ6DBXG7o2LDDPzYDN8PnCOKQIMDhpecf2SAK405
	eAxour2rDYk1xzJhOQx7/vmYf2PWqznvazaJkDpmWYwmdNeswMfQzgeSf1KI4Nzu
	ZTR+W8HXeAWqLDocAJryIGb4huLclnwhik8gOjMBtM8tXsglArUZMbTIVzSRn4Sq
	KjtriuSKbYsz3jx2TJBIFS9GOsAUosH7If48wnP1SuZX+0R+BeWklWD6VFWTWQP0
	pahpeY3rFXnBNrX98Xua0tJHEZG7zdTwbnoveElNcSmnraxzCsrTEsgVh8SyCRB3
	GhcV9aG3TYG+hJYt2wcyww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792399207; x=
	1792485607; bh=L4Ow+hRf7Ev0Ou+3g1fetpg5NPLpYNBVh1UJ3evSwDA=; b=j
	S2xAGn4aKu/PBegt9JRBOoNRY9JNmLXxYswh+FBrXBQKZAAUvbMT62oF+n40NCwZ
	oT3R3vjIPenzBdw8NU7aC5iN/ECEixIHk44EC3iTTYY+rPAdoRLC86Ww+4PNqx3y
	XOx8cEBMMR8xQK6b21kq4PoSL3r2xArYmOAScCjMPCXn0MHUPHJMopd1nvbEcr2b
	ee6ctDzHwlx8JF+csWYyFXxw+l0k0nhaAIAB4/d1YtZ1F26qZC7OofZ31rjCKNo9
	Fa7xy2lvk+Qh6DS+0vjBtwvKog8QeWx+pCKaw7hkPIGUK8/6jTiJtig3pK23uPyP
	lbIxOyjS5LJjV+kGt4F8w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=willbush.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792399207; d=willbush.dev;
	mf=PHdpbGxAd2lsbGJ1c2guZGV2Pg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:HZc9ICsJxx2Uuygc/hSPi2KlYdfb5+cHN++tJTjfvYG6tFh
	mlB2u4byF1UuG5pK9bCYvpFfGpDf4cEiWcthsCCDMVFVEjeXNCZPxJFo4dmZ/V4i
	JbllYCE7dT5Re1uJi6fO5+DgEP2G94Do4PkBFQo0gMhtJVwY8vTi4/gT0vh4Njh+
	Ah0a1My+wMdpDUihJIL+bL4A7imuPAruBk5QANkArm1JIjpdYeyR4kDkg/wjj8JR
	0ygYjGQ2pwt0szriKW27864oxelZ+sGUWWPYz7NWI2fxKH0NYH+31p9kdGUlVaJj
	CC/4OkFW7wNUibLOAtQ5KSPQ8LL6TlLLU47D+vA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SDiBOR3f3THWX7zq7K44UIzYpm+TYb6O5W+zn+s1aKE=:cy3Ua8MM9A2x9HjTJezL/FV7SFefbt/v8MEXoHPBQwA=;
X-ME-Sender: <xms:ZtfVauM8ZcWUVhT0p_ba7R66po2TtLxh_7BCB3D55qGzkwWJs38s1w>
    <xme:ZtfVanyyodfXXePkLbxAU-DMhuMnKBfLZ-jlp61NR6g0I2xHuzzJE9z1IoJ2pLg9f
    e0ioDdu3lC0q3oOy9is9nJ8tIB1wtjgf-wER125VDbnlfiaNzRNwY0>
X-ME-Proxy-Cause: dmFkZTGAcjc+6WgGRvzGO12CmJYSXbnaD9JbOf0mpuC7TDfz6ktu/G51LeRFCO06NGnrqo
    NSvxNgeTB9XOpv8oeW/N1biwYRb3Mti3CXWY+8iUZq3XS2ln9Kk5QE4TyGaY8L7F2XtWdI
    rnleojg+zntuxOVUuFQkeRmqFrmG9mpuwm61oYYWyQJmWk8tLxgLtS4w0s1KiNQaDAgnkQ
    G8Rho1ueS43hPBvDMjvMveR8X1ptDWIpvvlS7v1mCKpP6na2opsJLr7cXcjiWiBaEsxReC
    uKuGiT7GRupQhJyiaJREi1E3nptlWVKrSliBIQ2cQcTtPK+vngE3BeBnHMxJjecFy5WBQZ
    45mz8vcMgo7NV4/mjt3q5K6Re2DKm3kimRlD+U7vNRj7r51eZPK9yXE4D2BOcRey2Yxa7F
    fhe/Fp6RvtnN0XSpycUQWQuAwAPkxdNvTjKXx4YZpzAa2BLj87BgM2u6eglE2bC4E8r3Xd
    JwCPXbLFjIF/qCgEcBH6ZCq6eBvh9CQukFYRmRxCaFaWtfsEU5wjbcHJsfo0i4TxVl4VD/
    xSirsgpDremoiLZScx496Q3bpqpJPlARMo9k9oJvb57o71FI/m+FN0mBjXEAM0x0oNJU6L
    KCuquWf/jJCMyEK/lGPo2qSKVDH6fk9m+Gmd77CF6sES0yaOrPnto8YUD1xA
X-ME-Proxy: <xmx:ZtfVai_DCLkEUBhywxeBZ_8CefQXlBot-tRahXkYoFKpNvxn5HpzGw>
    <xmx:ZtfValQ1H4zFnCnCSmziqYjmAp4tGBIBC1EN-Ctnp_KrTur_edQxOA>
    <xmx:ZtfVaroBwTtDg4jEsx7M_PU80kulOaqC75XaqpPqWtljJz4OIkBsLg>
    <xmx:ZtfVaqmNv8nir6i7m1TbAxzpgEhi2-kiMaKPDKIR-1xXIJRPRTk8Fw>
    <xmx:Z9fVanD_zL2w74H5qnovh3SuLOD7SBQggP7RkxteeDXv6iQoBtuqsyCE>
Feedback-ID: i0f194965:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C0A79700065; Mon, 19 Oct 2026 04:40:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxIikzjaTJho
Date: Mon, 19 Oct 2026 03:39:46 -0500
From: "Will Bush" <will@willbush.dev>
To: "Takashi Iwai" <tiwai@suse.de>
Cc: "Takashi Iwai" <tiwai@suse.com>, "Jaroslav Kysela" <perex@perex.cz>,
 linux-sound@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, "Jan Lentfer" <jan.lentfer@web.de>,
 =?UTF-8?Q?Sebastian_Dalfu=C3=9F?= <sd@sedf.de>
Message-Id: <bb9cad8e-48fc-4cc7-a893-1542270f2018@app.fastmail.com>
In-Reply-To: <87tsmjarjs.wl-tiwai@suse.de>
References: <45162613-2802-401c-84c9-742f9c8c68e6@app.fastmail.com>
 <87tsmjarjs.wl-tiwai@suse.de>
Subject: Re: [REGRESSION] usb-audio: Behringer UMC204HD broken in 7.2.10
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026, at 11:42 AM, Takashi Iwai wrote:
> Interesting, it's just a descriptor read and this fails on your device
> by some reason.  Could you try to ignore the error like below, and
> verify whether it continues to work?

Thanks for the quick reply. I reverted my patch and applied yours. Devic=
e keeps
disconnecting and reconnecting (just more slowly). It never ends up work=
ing.

  =E2=9D=AF journalctl -k -b -0 -o short-monotonic | grep -E 'usb 3-4|sn=
d-usb-audio 3-4'
  [    2.264012] blazar kernel: usb 3-4: new high-speed USB device numbe=
r 3 using xhci_hcd
  [    2.458009] blazar kernel: usb 3-4: New USB device found, idVendor=3D=
1397, idProduct=3D0508, bcdDevice=3D 1.35
  [    2.484013] blazar kernel: usb 3-4: New USB device strings: Mfr=3D1=
, Product=3D2, SerialNumber=3D0
  [    2.484035] blazar kernel: usb 3-4: Product: UMC204HD 192k
  [    2.484050] blazar kernel: usb 3-4: Manufacturer: BEHRINGER
  [   12.976010] blazar kernel: usb 3-4: USB disconnect, device number 3
  [   18.012013] blazar kernel: usb 3-4: failed to read device descripto=
r: -110
  [   18.012623] blazar kernel: usb 3-4: parse_audio_format_rates_v2v3()=
: unable to retrieve number of sample rates (clock 41)
  [   18.012768] blazar kernel: usb 3-4: parse_audio_format_rates_v2v3()=
: unable to retrieve number of sample rates (clock 41)
  [   18.012903] blazar kernel: usb 3-4: 10:0: failed to get current val=
ue for ch 1 (-19)
  [   18.013047] blazar kernel: usb 3-4: 10:0: failed to get current val=
ue for ch 2 (-19)
  [   18.013181] blazar kernel: usb 3-4: 10:0: failed to get current val=
ue for ch 3 (-19)
  [   18.013309] blazar kernel: usb 3-4: 10:0: failed to get current val=
ue for ch 4 (-19)
  [   18.013434] blazar kernel: usb 3-4: 10:0: failed to get current val=
ue for ch 0 (-19)
  [   18.013565] blazar kernel: usb 3-4: 10:0: cannot get min/max values=
 for control 2 (id 10)
  [   18.013690] blazar kernel: usb 3-4: Warning! Unlikely small volume =
range (=3D1), linear volume or custom curve?
  [   18.013822] blazar kernel: usb 3-4: [10] FU [PCM Playback Volume] c=
h =3D 4, val =3D 0/1/1
  [   18.013959] blazar kernel: usb 3-4: 10:0: cannot get min/max values=
 for control 2 (id 10)
  [   18.014102] blazar kernel: usb 3-4: Warning! Unlikely small volume =
range (=3D1), linear volume or custom curve?
  [   18.014239] blazar kernel: usb 3-4: [10] FU [PCM Playback Volume] c=
h =3D 1, val =3D 0/1/1
  [   18.014374] blazar kernel: usb 3-4: 11:0: failed to get current val=
ue for ch 1 (-19)
  [   18.014508] blazar kernel: usb 3-4: 11:0: failed to get current val=
ue for ch 2 (-19)
  [   18.014635] blazar kernel: usb 3-4: 11:0: failed to get current val=
ue for ch 0 (-19)
  [   18.014763] blazar kernel: usb 3-4: 11:0: cannot get min/max values=
 for control 2 (id 11)
  [   18.014890] blazar kernel: usb 3-4: Warning! Unlikely small volume =
range (=3D1), linear volume or custom curve?
  [   18.015021] blazar kernel: usb 3-4: [11] FU [Mic Capture Volume] ch=
 =3D 2, val =3D 0/1/1
  [   18.015151] blazar kernel: usb 3-4: 11:0: cannot get min/max values=
 for control 2 (id 11)
  [   18.015278] blazar kernel: usb 3-4: Warning! Unlikely small volume =
range (=3D1), linear volume or custom curve?
  [   18.015408] blazar kernel: usb 3-4: [11] FU [Mic Capture Volume] ch=
 =3D 1, val =3D 0/1/1
  [   18.300040] blazar kernel: usb 3-4: new high-speed USB device numbe=
r 6 using xhci_hcd
  [   18.491087] blazar kernel: usb 3-4: New USB device found, idVendor=3D=
1397, idProduct=3D0508, bcdDevice=3D 1.35
  [   18.517036] blazar kernel: usb 3-4: New USB device strings: Mfr=3D1=
, Product=3D2, SerialNumber=3D0
  [   18.517242] blazar kernel: usb 3-4: Product: UMC204HD 192k
  [   18.517398] blazar kernel: usb 3-4: Manufacturer: BEHRINGER
  [   23.644013] blazar kernel: usb 3-4: failed to read device descripto=
r: -110
  [   33.884021] blazar kernel: usb 3-4: parse_audio_format_rates_v2v3()=
: unable to retrieve number of sample rates (clock 41)
  [   49.244015] blazar kernel: usb 3-4: parse_audio_format_rates_v2v3()=
: unable to retrieve number of sample rates (clock 41)
  [   59.484034] blazar kernel: usb 3-4: 10:0: failed to get current val=
ue for ch 1 (-110)
  [   69.725032] blazar kernel: usb 3-4: 10:0: failed to get current val=
ue for ch 2 (-110)
  [   79.965020] blazar kernel: usb 3-4: 10:0: failed to get current val=
ue for ch 3 (-110)
  [   90.204027] blazar kernel: usb 3-4: 10:0: failed to get current val=
ue for ch 4 (-110)
  [  100.444027] blazar kernel: usb 3-4: 10:0: failed to get current val=
ue for ch 0 (-110)
  [  110.684056] blazar kernel: usb 3-4: 10:0: cannot get min/max values=
 for control 2 (id 10)
  [  110.684281] blazar kernel: usb 3-4: Warning! Unlikely small volume =
range (=3D1), linear volume or custom curve?
  [  110.684397] blazar kernel: usb 3-4: [10] FU [PCM Playback Volume] c=
h =3D 4, val =3D 0/1/1
  [  115.804025] blazar kernel: usb 3-4: 10:0: cannot get min/max values=
 for control 2 (id 10)
  [  115.812386] blazar kernel: usb 3-4: Warning! Unlikely small volume =
range (=3D1), linear volume or custom curve?
  [  115.812521] blazar kernel: usb 3-4: [10] FU [PCM Playback Volume] c=
h =3D 1, val =3D 0/1/1
  [  131.164026] blazar kernel: usb 3-4: 11:0: failed to get current val=
ue for ch 1 (-110)
  [  141.404011] blazar kernel: usb 3-4: 11:0: failed to get current val=
ue for ch 2 (-110)
  [  151.644020] blazar kernel: usb 3-4: 11:0: failed to get current val=
ue for ch 0 (-110)
  [  161.885033] blazar kernel: usb 3-4: 11:0: cannot get min/max values=
 for control 2 (id 11)
  [  161.885326] blazar kernel: usb 3-4: Warning! Unlikely small volume =
range (=3D1), linear volume or custom curve?
  [  161.885446] blazar kernel: usb 3-4: [11] FU [Mic Capture Volume] ch=
 =3D 2, val =3D 0/1/1
  [  167.004009] blazar kernel: usb 3-4: 11:0: cannot get min/max values=
 for control 2 (id 11)
  [  167.004224] blazar kernel: usb 3-4: Warning! Unlikely small volume =
range (=3D1), linear volume or custom curve?
  [  167.004341] blazar kernel: usb 3-4: [11] FU [Mic Capture Volume] ch=
 =3D 1, val =3D 0/1/1
  [  167.005012] blazar kernel: usb 3-4: Quirk or no altset; falling bac=
k to MIDI 1.0
  [  187.486013] blazar kernel: usb 3-4: USB disconnect, device number 6
  [  187.785034] blazar kernel: usb 3-4: new high-speed USB device numbe=
r 7 using xhci_hcd
  ...
  [ 1035.327013] blazar kernel: usb 3-4: New USB device found, idVendor=3D=
1397, idProduct=3D0508, bcdDevice=3D 1.35
  [ 1035.353013] blazar kernel: usb 3-4: New USB device strings: Mfr=3D1=
, Product=3D2, SerialNumber=3D0
  [ 1035.353185] blazar kernel: usb 3-4: Product: UMC204HD 192k
  [ 1035.353301] blazar kernel: usb 3-4: Manufacturer: BEHRINGER
  [ 1040.476017] blazar kernel: usb 3-4: failed to read device descripto=
r: -110
  [ 1050.717019] blazar kernel: usb 3-4: parse_audio_format_rates_v2v3()=
: unable to retrieve number of sample rates (clock 41)
  ...

Thanks,
Will
