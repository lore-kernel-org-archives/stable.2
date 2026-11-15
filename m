Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794714275;
	b=rh3ONf/PITJfXC88DKseVQmIpzkUKkYm7XhC7KjDC8ND3N6+GlYJprNp1sPPXTzcRigD
	 cK6ksB5qzJ+tzD/NAdhU8kuxINydVE6+Y6EnEhlZuRVyxd8cBUOxcRSamPUxbEus9ce+C
	 GpfTXG26tDVRnwiAXOqVj+Itz30ymwsiLJ5APv7n5KDTV2wzk/iCCF8ta5sH5UoEf6rWW
	 rq2IpfCaBS9KjTQp+nAc9Y+LDhOAQWMuVnmZ0v5q2JJtuhIqp7Io75h86HvewK2bDg9E/
	 G2DqBwPrHxo+P+/9TCB+XDoaftE1VP8Tpk2ed9Wfia3TtK+HHa8yDlsVeRLa8AGBhKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794714275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kThqeDdUKeBAoBkOX7IeKXQ3xxyH8ieVIhJkg9hYd30=;
	b=01DPuU3ZQ8OLazbXcNPzYSrbb6OPV5Ad+ltyOjJZX/xxUN4GKTWryp2b2wkEzhEKgg/R
	 xrUX2jKFuDldxyfaeSe3x90QL1XeVolwQqDGBwxh8aDPIEW6uDMiq96DzVU3A9i/J4vv1
	 cfsyI1TFyJPzCYzY4UJjrMoECrSIdLEmRRC1HV7Vi4nfR7NKQhMmoinhuc4IBg/GKBLn1
	 otA5lVyW+/+aQJ0lXK6G/vCqHCDh287lUgAgC1CHq46mv557Vn7uAK7k3Ebs305jDQ4oN
	 KbVOGBqHgK6DXnp588avAhol7gi9cPwOsDXIUiRBee1Ntn0sIktLdoXgZtZ4TxY8D0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ldqCNZQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705E606A32D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 03:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9705E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ldqCNZQ
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ad0102edd4so26247481fa.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:44:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794714273; cv=none;
        d=google.com; s=arc-20260327;
        b=OsP+cCLgBWssicnvU9o/hDPGPHCp53sbMUPXxcBwM3ps5vuvo/IMYhz/DEPvo1ZeR4
         YrCKx19fN2eK0x1Fw35WoVh89TTvXrQXxzYkuid1UxW2ZwemEzfevGl1OCrgMN0YFE+b
         OvsdmH9qJJRGEfI/OKDso71AoYwPaI/spZ1OPy7OG7VyklZ+anW3e0xQKMNBn6GXV+Wk
         yAJ+erswVdeM2gImJcJNY1I7Darxc0V1g5rCEy5mlQgh3ZZsTE01Zv+WsVTnK+ETObs5
         x4dAZJFeHy9aGOrlttg8HAJUYfRg/X5/xt70pHzvXhv/EVyxBd+l8mmQPKNvO9LJirEG
         XHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kThqeDdUKeBAoBkOX7IeKXQ3xxyH8ieVIhJkg9hYd30=;
        fh=0HIv2lsVEb+SRwGngvWx/e/libL/iS2QqyZKA9DEyNo=;
        b=HSoXmDVzZXsVet0PMlWAzIJjeesePi0nBHbk6dxRHAZwkx0Q7YWaQTY24HSbdGq2Mz
         4qql5F1+OaxNUwrSrfELssi7MpxwKk/wLOjlsMJ+n40RqcEESPV4sW5cCxJsPRiTvvCE
         nYm27rYUNhjArR1eaKv+d0jXoyPdAFpRqWIAMYOpAD1b+yXmp2aYzIHG2sEDrmgrjH/K
         5fSF3bh1cHOKxhWQ5BY423f9XaIdIucFPROprJUn7ZhxkGuA9priBhnM9ITCa6+ZIM4j
         Qk0SMHyz6bBnhCo6Z3xRiCWAHdo/ti144isApWc6QSHS3mEqyTGkCzcXHiZsMOb0S60O
         ARVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794714273; x=1795319073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kThqeDdUKeBAoBkOX7IeKXQ3xxyH8ieVIhJkg9hYd30=;
        b=0ldqCNZQ9TlHUs3XebkPavhWT0bUBnSI7E1vuXY3K9z4q9joz2llVmil+tEUNyg4FC
         z3xzxAdJrVNw10ZiYr+nYP0GyBz/rh1K4RbqQT7K1eXVzrDQYpgFtkEmf2g0GkOTsR1o
         hm4BqocI14QUaCEYeTCu9mSiiTBQNz+XuRE+80L8fCinXl0In0AFeqsxGtO87inF6qNM
         uBGtOcuZEvl5Cz5uQMMlENj5etuxz7aAYFFwpZBDVTzzPTtKwpcW0+LRmUC5bd6Kq6WH
         +ajmrp2Q3FFnTrKjgADyA+2wiuwoQkzzrbO/2jxC4EunLkSWyfrvFB9XX6sSN7ShmhWw
         zbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794714273; x=1795319073;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kThqeDdUKeBAoBkOX7IeKXQ3xxyH8ieVIhJkg9hYd30=;
        b=0aPbqpnF+uQKQsVOgPMOIj4IdEI1HKfaAWDkg8VV75Nl06E2aMqG33WmWFi/AGPnbB
         eH4XXuz+G+aEYI+Qfttyit9ujqOCwyumlFiIUHJ9MKeSCqFMD3Dvs2T7RGdpECa9nD96
         Cm3wciwaD06iyC6tBRKornNSVBHCIVSLOtxdjavg5ASziOn0cuxJGMof/8X2cupfYIkL
         gdKA5brtt54WHXHclr1g9hy/uhz8dtUzWrln/oI15dzKVAFpB8VAAOAdLXs9AS6WxXlV
         QkstmXxD4UCo6EXwEnVNiuuenEEdEfarnPzBV3eprAHteuLAL3FKqBFYlED3EouGm6wl
         QQ7g==
X-Forwarded-Encrypted: i=1; AL+hErGeQHFJk4lIz71mR9oP9V992ReVqEjtox7tQiU3x14iIK/7a1o5Ls+H4WhFx1Zt559GzgEhtKQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FNrhVkdeKa7+tQc71wgGV9DYYKVuevqZoLDw5rUgOlGdJcG2t
	nwYjO56G7Vz782U8UWicEGN8bfx0Mk9wAFpI3kNMgFfVbD65TdwmvLK6vFwG31PvNEScd6Cqayw
	aEwMv/g1dTml2yL5vSVTymG397X4sBmc=
X-Gm-Gg: AYBFou2LUBE4aBjTdievoVQF3fMq8eaVfEnxFSXUXIVFtlMuwDQG0KFTLIgkLEQFMNt
	PJpyiQbrqfemiS6hKW2mWiV4gLLByYVNPYi+HwbEAWUqkWZ6TgWxkqeAdwuWzfDjad7jGHSRf6B
	WKOFUn5oGWZKWFqkei1kBPgiSVyYluAkeDuUJSa2KQyH8I3TTFpC47pndDEQlD4KOg+3EOY+BAv
	va3DErEFeoOLAfJZUJN4LnpsaJD3PkAcZntigzjDnqzBBgnyIuGOBOAeFl+WjdrHTEk9rVXJKs8
	4ycpNQLVM23vUXXZMFVX6sruSJo3w3+FYusLLoK/LOOWb0L1EuRLEV+6CpeGKIkyARCrcPt4fZX
	3ZwoQnCSMsq3q++iLO24PEgENjmQM493NFQsBTcUVRVj0c8N+VT+Xrzokd1dF1RGRb2OLqHc8KV
	C2WYqwAXVFScUgZsxKrSgpZK/ybEV4uXRsTTVcQqw=
X-Received: by 2002:a05:651c:1462:b0:3ab:540b:f4a7 with SMTP id
 38308e7fff4ca-3ae2b4b7f7amr19999811fa.8.1794714272554; Sat, 14 Nov 2026
 19:44:32 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108001057.29776-2-sanjay.govind9@gmail.com>
In-Reply-To: <20261108001057.29776-2-sanjay.govind9@gmail.com>
From: Sanjay Govind <sanjay.govind9@gmail.com>
Date: Sun, 15 Nov 2026 16:44:19 +1300
X-Gm-Features: AclHuK-q5gdxBrsCBs4zmYOWzMOC0EdVAeId6-QYsn6BvjHRo4yiUriEQ69Zn_E
Message-ID: <CALQgdA24BhzHQwNoswgpKj+FHG_tpA-cLMr6hA1Du7ukSJWs9w@mail.gmail.com>
Subject: Re: [PATCH] HID: sony: fix sleeping in atomic context in RB3 Pro raw
 event handler
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rosalie Wanders <rosalie@mailbox.org>, Brenton Simpson <appsforartists@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping on this one. Without it, connecting any Rock Band 3 Pro
instrument handled by hid-sony (Mustang or Squier guitar, keyboard, or
the MIDI Pro Adapter) can panic the machine: the full report request
sleeps in the URB completion softirq, and when that happens on top of
the idle task, the control transfer's completion later tries to wake
the idle task:
RIP: 0010:0x0
 enqueue_task+0x84/0x180
 ttwu_do_activate+0x6e/0x180
 try_to_wake_up+0x294/0x820
 complete+0x49/0x80
 __usb_hcd_giveback_urb+0xa0/0x120
 usb_giveback_urb_bh+0xc0/0x140
 ...
Kernel panic - not syncing: Fatal exception in interrupt
I reproduced the panic on 7.2.11, and with this patch applied I can no
longer reproduce it. A user on Fedora's 7.2.13 has also hit "BUG:
scheduling while atomic" followed by "bad: scheduling from the idle
thread!" and lost all USB and Bluetooth until a hard reboot. As it's a
fix tagged for stable, could it go in as a 7.4 fix?

As for the issue Sashiko raised, I submitted the fix for that as its
own patch because it was unrelated to this change.

On Sun, Nov 8, 2026 at 1:12=E2=80=AFPM Sanjay Govind <sanjay.govind9@gmail.=
com> wrote:
>
> Rock Band 3 Pro instruments only send navigation reports until they
> receive a magic SET_REPORT feature request. When such a report is seen,
> rb3_pro_instrument_raw_event() sends that request directly through
> rb3_pro_instrument_enable_full_report(), which does a GFP_KERNEL
> allocation and a synchronous hid_hw_raw_request().
>
> The raw event handler is called from the URB completion handler in
> softirq context, and on USB hid_hw_raw_request() ends up in
> usb_control_msg(), which sleeps. Plugging in an RB3 Pro instrument
> therefore triggers:
>
>   BUG: scheduling while atomic
>   ...
>   softirq: huh, entered softirq 0 HI ... preempt_count 101, exited with 0
>
> This was reported on a Mustang guitar (12ba:2430).
>
> Move the request to process context by registering
> rb3_pro_instrument_enable_full_report() as the send_output_report
> callback of the existing state worker. The raw event handler now only
> schedules the work, keeping the 8 second rate limit. The state worker
> is already cancelled by sony_cleanup() on remove and on probe failure,
> and sony_schedule_work() is a no-op once cancellation has started, so
> no new teardown is needed.
>
> Fixes: 7245b0017d12 ("HID: sony: add support for more instruments")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
> ---
>
> Notes:
>     Reproduced and tested with a Santroller device emulating a 12ba:2430
>     guitar: without the fix, 'BUG: scheduling while atomic' is logged eve=
ry
>     8 seconds; with the fix no more warnings are logged.
>
>     The fix and changelog were written with the help of an AI coding
>     assistant (Claude Opus 5.5).
>
>  drivers/hid/hid-sony.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 50f5ad6bbeb4..9ee175f9e58d 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -630,7 +630,7 @@ static int ghl_init_urb(struct sony_sc *sc, struct us=
b_device *usbdev,
>   * Sending HID_REQ_SET_REPORT enables the full report. Without this
>   * Rock Band 3 Pro instruments only report navigation events
>   */
> -static int rb3_pro_instrument_enable_full_report(struct sony_sc *sc)
> +static void rb3_pro_instrument_enable_full_report(struct sony_sc *sc)
>  {
>         struct hid_device *hdev =3D sc->hdev;
>         static const u8 report[] =3D { 0x00, 0xE9, 0x00, 0x89, 0x1B,
> @@ -647,14 +647,14 @@ static int rb3_pro_instrument_enable_full_report(st=
ruct sony_sc *sc)
>
>         buf =3D kmemdup(report, sizeof(report), GFP_KERNEL);
>         if (!buf)
> -               return -ENOMEM;
> +               return;
>
>         ret =3D hid_hw_raw_request(hdev, buf[0], buf, sizeof(report),
>                                   HID_FEATURE_REPORT, HID_REQ_SET_REPORT)=
;
> +       if (ret < 0)
> +               hid_dbg(hdev, "failed to enable full report: %d\n", ret);
>
>         kfree(buf);
> -
> -       return ret;
>  }
>
>  static int djh_turntable_mapping(struct hid_device *hdev, struct hid_inp=
ut *hi,
> @@ -1098,10 +1098,10 @@ static int rb3_pro_instrument_raw_event(struct so=
ny_sc *sc, u8 *rd, int size)
>         if (size < 25 || rd[24] !=3D 0x02)
>                 return 0;
>
> -       /* Only attempt to enable full report every 8 seconds */
> +       /* Only attempt to enable full report every 8 seconds, from the w=
orker */
>         if (time_after(jiffies, sc->rb3_pro_poke_jiffies)) {
>                 sc->rb3_pro_poke_jiffies =3D jiffies + secs_to_jiffies(8)=
;
> -               rb3_pro_instrument_enable_full_report(sc);
> +               sony_schedule_work(sc);
>         }
>
>         return 0;
> @@ -2217,6 +2217,7 @@ static int sony_input_configured(struct hid_device =
*hdev,
>                 hdev->quirks |=3D HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
>
>                 sony_init_raw_event_handler(sc, rb3_pro_instrument_raw_ev=
ent);
> +               sony_init_output_report(sc, rb3_pro_instrument_enable_ful=
l_report);
>         } else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
>                 /*
>                  * The Sony Sixaxis does not handle HID Output Reports on=
 the
> --
> 2.56.0
>
