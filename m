Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.240.27.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795761984;
	b=fo5S4hOJz4WseMoyROpQ6jKKE6yhWYwo30l/jmuBWeb7WnDK9lq0XBWG4SF1Vj+yzIYx
	 rJ+fwgj+uFlRJPupuuMnp2lV9/sS/S93p3+s8m5i3apPw4FXydlolvXfwnrDWHbdBy7Kk
	 jFChdN/J6m3JR5vS/yGbPiJa+Bpny4Gq28QxmoQ0CnZxWKYCSrpbPrCnNRFAltd1Qmejo
	 C5IN9YEr5c45wYhyxKQb0KsaLrpPxBxtfnNYR30d6FRHWatlJQhh6rFpomUBcrIOohtnY
	 uZr2vxINvhXWUDTgIF230Z4TIG+6ll1v0sBpixLKnp4Wxxk6at0aJKvFb28dnOtGgYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795761984;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Subject:From:To:Cc:Date:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 References:X-Mailer:Thread-Index:Thread-Topic:X-Original-Mailer:
	 X-Wm-Sent-Timestamp:Message-ID:Feedback-ID:X-SES-Outgoing;
	bh=UUrmEL4fj7DBJYDRPj0ZU1jj66ejxzXJDf0rYEb8jlw=;
	b=zIIkyvzx4RGRCRIb4g0JdUgAPH2HmFUCUnbTZBgAiYhGfuez+WfEFHIf0d39kMKoZhRi
	 osoPTD8O7Ri+IYaXM3/khLDb71PuLEo8Ygxqkoz+t1hQ64LSbm8P1ZJp/OHRBAsHR7Pol
	 iIgyV02GaHRles6vRYGo+EJIGlDuzXW2NZGTsqFvwo9y2Z0CoOMJDWcFFr53t16VbY3OW
	 wdZa0HvqVhqyuWAASdZoAz9gPDVLXg8VQtfnky01hw2LDixe5GyjZM+UGCpUQIhCaCpHt
	 tiQVBzy/I9q+MnUv2QElzMD2taXCD+IsuDzpzENVxT8S/EGW5j5IhMh/So+212esgTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=geek-masa.com;
	spf=pass smtp.mailfrom=mail.geek-masa.com;
	dkim=pass header.d=geek-masa.com header.i=@geek-masa.com header.a=rsa-sha256 header.s=mwholqyuytutcif2rgzxazuf7vd3euk6 header.b=lrbBfw5T;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=FC6RUv2q;
	arc=none smtp.remote-ip=54.240.27.128
Received: from a27-128.smtp-out.us-west-2.amazonses.com (a27-128.smtp-out.us-west-2.amazonses.com [54.240.27.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C30606A31E;
	Fri, 27 Nov 2026 06:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66C30606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geek-masa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.geek-masa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=geek-masa.com header.i=@geek-masa.com header.a=rsa-sha256 header.s=mwholqyuytutcif2rgzxazuf7vd3euk6 header.b=lrbBfw5T;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=FC6RUv2q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=mwholqyuytutcif2rgzxazuf7vd3euk6; d=geek-masa.com; t=1795761983;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=j452pPgXWbNkeLAE9DAUy1JgfKaEzF8HrEHs86FoXRA=;
	b=lrbBfw5T5cGIpL1XtMEkwhrF8TjUh2NVb0m8HManf4EIwKcRIMXTqJfmYAgYCInu
	58QxHyQ4PKX2/5qi1eErtutsn3RSjaYTdKBAxr3SThVIHoniyP4/CCEO8IpE15yawu/
	CXASJcik9+n+SYLLI6gVaZeFZZKmMpwAF5H8FC0mhpHicrmUqDg0jxG5+VVgNYb+Ww4
	XKV7UmiDdcmQcEu5utZ7VL9+u4RRS2qi9Xoq2eOcPIuIY/ArQl3zBizZtC/z760gC2m
	fNmh0j7nTR82WVFb3UX0DlggqE82w7GWmqOdLdO0FNE82Ny8f618XvJ0rVaNwwn2Y1j
	NkfDYt+NOA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1795761983;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=j452pPgXWbNkeLAE9DAUy1JgfKaEzF8HrEHs86FoXRA=;
	b=FC6RUv2q1aOeQW5EGteGdN9tSMtEV3ZsX6EMxTycgf9K1CpXnKdqmkGKwo2SMaa5
	POWdKtgcvwRk5lN5H0wOFBHWNgDxhHieg+ja2vLsdPiJwvgxe8e1Ctj70mCC1+6ENir
	TDBP9LfIXA8N7F7VYcUUZig8mCJyxiJ0TWfsH/bQ=
Subject: [PATCH] ALSA: ua101: clamp playback packet sizes instead of
 rejecting UA-1000
From: =?UTF-8?Q?Masanori_Suto?= <suto@geek-masa.com>
To: =?UTF-8?Q?tiwai=40suse=2Ede?= <tiwai@suse.de>
Cc: =?UTF-8?Q?londongrad=40gmail=2Ecom?= <londongrad@gmail.com>, 
	=?UTF-8?Q?xmei5=40asu=2Eedu?= <xmei5@asu.edu>, 
	=?UTF-8?Q?clemens=40ladisc?= =?UTF-8?Q?h=2Ede?= <clemens@ladisch.de>, 
	=?UTF-8?Q?perex=40perex=2Ecz?= <perex@perex.cz>, 
	=?UTF-8?Q?linux-sound=40vger=2Ekernel=2Eorg?= <linux-sound@vger.kernel.org>, 
	=?UTF-8?Q?stable=40vger=2Ekernel=2Eorg?= <stable@vger.kernel.org>, 
	=?UTF-8?Q?regressions=40lists=2Elinux=2Edev?= <regressions@lists.linux.dev>, 
	=?UTF-8?Q?Masanori_Suto?= <suto@geek-masa.com>
Date: Fri, 27 Nov 2026 06:46:23 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <CANd6TdKdRftWyo5Cg_85-fBVGW3oHAntEY-DdCpQCDSyRpOprw@mail.gmail.com>
References: 
 <CANd6TdKdRftWyo5Cg_85-fBVGW3oHAntEY-DdCpQCDSyRpOprw@mail.gmail.com> 
 <20261127064615.40817-1-suto@geek-masa.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHdfjsDkETvySPpTqK7zfeNAGe9Jw==
Thread-Topic: [PATCH] ALSA: ua101: clamp playback packet sizes instead of
 rejecting UA-1000
X-Original-Mailer: git-send-email 2.56.1
X-Wm-Sent-Timestamp: 1795761982
Message-ID: <010101a21bc150d7-627da1ea-4ebf-499d-9ae0-edf88db3e063-000000@us-west-2.amazonses.com>
Feedback-ID: ::1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
X-SES-Outgoing: 2026.11.27-54.240.27.128

Commit 86f86e6fdedc ("ALSA: ua101: reject mismatched capture/playback=0D=0A=
packet sizes") rejects a device at probe time when a capture packet of=0D=
=0AwMaxPacketSize bytes would carry more frames than fit into a playback=0D=
=0Apacket.  It assumed that genuine hardware declares proportional packet=
=0D=0Asizes, but the UA-1000 does not:=0D=0A=0D=0A  capture  EP 0x81: 12 =
ch x 4 bytes, wMaxPacketSize 720 -> 15 frames=0D=0A  playback EP 0x02: 10=
 ch x 4 bytes, wMaxPacketSize 560 -> 14 frames=0D=0A=0D=0Aso the UA-1000 =
now fails to probe with=0D=0A=0D=0A  playback packet size 560 too small f=
or 15 capture frames=0D=0A=0D=0AIn practice the device sends about rate/8=
000 frames per packet at high=0D=0Aspeed (6 at 48 kHz, 12 at 96 kHz), whi=
ch always fits the playback=0D=0Apacket.=0D=0A=0D=0AThe out-of-bounds wri=
te has a single source: capture_urb_complete()=0D=0Astores the received f=
rame count in rate_feedback[], and both=0D=0Astart_usb_playback() and pla=
yback_work() take their packet sizes only=0D=0Afrom that FIFO.  Clamp the=
 value there to what fits into one playback=0D=0Apacket, so the playback =
URB buffer cannot be overrun whatever the=0D=0Adescriptors say, and relax=
 the probe check to require only that one=0D=0Apacket at the nominal rate=
 fits.=0D=0A=0D=0ATested on a UA-1000 (0582:0044): the device probes agai=
n, and playback=0D=0Aand capture both work.=0D=0A=0D=0AFixes: 86f86e6fded=
c ("ALSA: ua101: reject mismatched capture/playback packet sizes")=0D=0AC=
c: stable@vger.kernel.org=0D=0AReported-by: London grad <londongrad@gmail=
=2Ecom>=0D=0ACloses: https://lore.kernel.org/all/CANd6Td+b6ituLFzkhvX09vr=
icCY541fQapNOk3rTa=3D74zWA5LA@mail.gmail.com/=0D=0ACloses: https://bugzil=
la.kernel.org/show_bug.cgi=3Fid=3D222261=0D=0ASigned-off-by: Suto, Masano=
ri <suto@geek-masa.com>=0D=0A---=0D=0AHi Takashi,=0D=0A=0D=0ATo answer yo=
ur question earlier in this thread: on my UA-1000=0D=0A(0582:0044, bcdDev=
ice 1.07), reverting 86f86e6fdedc alone makes the=0D=0Adevice work again.=
 It is registered in /proc/asound/cards, and playback=0D=0Aand capture bo=
th work. Without the revert it fails to probe with=0D=0A"playback packet =
size 560 too small for 15 capture frames", as in the=0D=0Aearlier report.=
 So the commit is confirmed as the cause.=0D=0A=0D=0AA plain revert would=
 reopen CVE-2026-98741, so this patch keeps the=0D=0Aprotection by clampi=
ng the packet size where it is produced instead of=0D=0Arejecting the dev=
ice. With this patch applied, playback and capture also=0D=0Aboth work. T=
ested on linux-zen 7.3.6-zen1; sound/usb/misc/ua101.c there=0D=0Ais ident=
ical to mainline.=0D=0A=0D=0ATo check that the 15-frame worst case does n=
ot happen on real hardware,=0D=0AI captured the isochronous traffic with =
usbmon: 60 s of simultaneous=0D=0Aplayback and capture at each rate the U=
A-1000 supports, about 480000=0D=0Apackets each. Frames per packet, from =
the actual capture length=0D=0A(EP 0x81) and the submitted playback lengt=
h (EP 0x02):=0D=0A=0D=0A  rate       capture frames per packet           =
max=0D=0A  44.1 kHz    5: 48.76%   6: 51.24%                6=0D=0A  48 k=
Hz      5:  1.14%   6: 97.74%   7: 1.12%     7=0D=0A  88.2 kHz   10:  1.0=
4%  11: 95.45%  12: 3.52%    12=0D=0A  96 kHz     11:  0.08%  12: 99.86% =
 13: 0.06%    13=0D=0A=0D=0APlayback used exactly the same distribution a=
t every rate. The maximum=0D=0Ais 13 frames at 96 kHz, which fits the 14-=
frame playback packet. The=0D=0A15 frames assumed from wMaxPacketSize nev=
er occur: the device stays=0D=0Awithin one frame of rate/8000. The clamp =
warning added by this patch=0D=0Anever appeared in the kernel log during =
these runs.=0D=0A=0D=0AThe same breakage was also reported on LinuxMusici=
ans:=0D=0Ahttps://linuxmusicians.com/viewtopic.php=3Fp=3D189180=0D=0A=0D=0A=
#regzbot ^introduced: 86f86e6fdedc=0D=0A=0D=0A sound/usb/misc/ua101.c | 3=
0 +++++++++++++++++++++++++-----=0D=0A 1 file changed, 25 insertions(+), =
5 deletions(-)=0D=0A=0D=0Adiff --git a/sound/usb/misc/ua101.c b/sound/usb=
/misc/ua101.c=0D=0Aindex bd8e0ed..196a588 100644=0D=0A--- a/sound/usb/mis=
c/ua101.c=0D=0A+++ b/sound/usb/misc/ua101.c=0D=0A@@ -371,7 +371,7 @@ stat=
ic void capture_urb_complete(struct urb *urb)=0D=0A =09struct ua101_urb *=
ua_urb =3D urb->context;=0D=0A =09struct ua101 *ua =3D ua_urb->ua;=0D=0A =
=09struct ua101_stream *stream =3D &ua->capture;=0D=0A-=09unsigned int fr=
ames, write_ptr;=0D=0A+=09unsigned int frames, max_frames, write_ptr;=0D=0A=
 =09bool do_period_elapsed;=0D=0A =09int err;=0D=0A=20=0D=0A@@ -402,6 +40=
2,21 @@ static void capture_urb_complete(struct urb *urb)=0D=0A =09=09=09=
=09goto stream_stopped;=0D=0A =09=09=09}=0D=0A=20=0D=0A+=09=09=09/*=0D=0A=
+=09=09=09 * The playback stream reuses this packet size, but its=0D=0A+=09=
=09=09 * URB buffers hold only playback.max_packet_bytes.  The=0D=0A+=09=09=
=09 * capture packet size comes from the device, so clamp it=0D=0A+=09=09=
=09 * to what fits into one playback packet.=0D=0A+=09=09=09 */=0D=0A+=09=
=09=09max_frames =3D ua->playback.max_packet_bytes /=0D=0A+=09=09=09=09  =
   ua->playback.frame_bytes;=0D=0A+=09=09=09if (unlikely(frames > max_fra=
mes)) {=0D=0A+=09=09=09=09dev_warn_ratelimited(&ua->dev->dev,=0D=0A+=09=09=
=09=09=09=09     "capture packet of %u frames clamped\n",=0D=0A+=09=09=09=
=09=09=09     frames);=0D=0A+=09=09=09=09frames =3D max_frames;=0D=0A+=09=
=09=09}=0D=0A+=0D=0A =09=09=09/* append packet size to FIFO */=0D=0A =09=09=
=09write_ptr =3D ua->rate_feedback_start;=0D=0A =09=09=09add_with_wraparo=
und(ua, &write_ptr, ua->rate_feedback_count);=0D=0A@@ -1031,12 +1046,17 @=
@ static int detect_usb_format(struct ua101 *ua)=0D=0A =09ua->playback.us=
b_pipe =3D usb_sndisocpipe(ua->dev, usb_endpoint_num(epd));=0D=0A =09ua->=
playback.max_packet_bytes =3D usb_endpoint_maxp(epd);=0D=0A=20=0D=0A-=09i=
f (ua->capture.max_packet_bytes / ua->capture.frame_bytes *=0D=0A+=09/*=0D=
=0A+=09 * capture_urb_complete() clamps the packet sizes passed to the pl=
ayback=0D=0A+=09 * stream to playback.max_packet_bytes, so only the nomin=
al rate must=0D=0A+=09 * fit here.  wMaxPacketSize of the capture endpoin=
t may legitimately=0D=0A+=09 * be larger (e.g. UA-1000).=0D=0A+=09 */=0D=0A=
+=09if (DIV_ROUND_UP(ua->rate, ua->packets_per_second) *=0D=0A =09    ua-=
>playback.frame_bytes > ua->playback.max_packet_bytes) {=0D=0A =09=09dev_=
err(&ua->dev->dev,=0D=0A-=09=09=09"playback packet size %u too small for =
%u capture frames\n",=0D=0A-=09=09=09ua->playback.max_packet_bytes,=0D=0A=
-=09=09=09ua->capture.max_packet_bytes / ua->capture.frame_bytes);=0D=0A+=
=09=09=09"playback packet size %u too small for %u Hz\n",=0D=0A+=09=09=09=
ua->playback.max_packet_bytes, ua->rate);=0D=0A =09=09return -ENXIO;=0D=0A=
 =09}=0D=0A =09return 0;=0D=0A--=20=0D=0A2.43.0=0D=0A=0D=0A
