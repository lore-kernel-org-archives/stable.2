Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794314236;
	b=E/T3GztC5/dJ5/3U2wfX+F7Z5C4fuJCPzna5L2qOQ00rXfjCsEr43YdHF23gm04RJZQg
	 2LxWnFcAAUDWJ4SmO3/ed3x4amY/ToyVaN8RFpHrAeTQK/nGg5s1CjQ6nmeeUA5qcpgrl
	 QxW+H75ZhRlLlg4gvZ6Vs/isXOhF4Szrsq/W2P7TCXlFo6xNt7svp4zfYJRWWRryxZP1w
	 j2XU5SXtq0drsL9RutopkBz3z6E6dnPCBMoyRYkCsiYY6GlzNqRuVURThLU1x/V6txpYg
	 CEXAI2EYW+SYcotuTydh1OH5FR//ihpNu1fV+uAiq6pvov/S7mIeXeNwiDIOYPky7qQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=87rulhgJfiv21qEaTxseqV/cAge3CoEQMJ20JUEXXlI=;
	b=McgEBHqL1A9GB+mMMypASutN3TXwikRVkzmOeS9ifBKU9efxeBr+PDfLKkL4dOjMKnoZ
	 2DMahoDkdM/cV258n8j9jzNSDs3qf7CPZ2DSHSecc8U8EozloBvNZ6xzfyZjwV16tvpmf
	 rF900S414aBRxa9K0ElgRgN5Na5f5H8zj7fe65O3AgcBujKHb3zYNyFVBFJvBjfG3SsIy
	 KAtmpCCWYQe3/kRQ6UHDzua8oyhCXHNy+4vloj2rH1h063uBWbTIDz/PJ2ePh2jbkGMoq
	 lvwoPuycMyA/gZ9guStKseZm1anKcIYyzuzLymojgIYnd+HiL+2/Ml5+8+oKbRPVcEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QaxtLhML;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497A606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A497A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QaxtLhML
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c43373ae89aso113125266b.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:37:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794314234; cv=none;
        d=google.com; s=arc-20260327;
        b=AEmvQfjqVMSe5SCUEyJOo+bjWXEnDtLj/4a2OG6mRLE4s8Sn0eQEQIsVm6LjJ0BRcs
         /PbwfaeXOh9hvHiP/lZf435NpdiyP/NAj0z9QgrCU4gHEvkfKg3va2pgOIsCBuMTHDWT
         RMOG0cfd7cqz0Uz+8TobZXEv2ZYoSK14PQ2VZx+hTR504oHYMz70aHPOi+fcPZLAgJGA
         C6mHKyzGY4o1PeJatJRCA4RDjDARIPIlMO77Si1Vv9KtsIW3pGyMTpNdXtaWWjX3rJ+G
         gxE+qUUBVPEDGParhXYWAeWzqXL58cowAwUkjQks/hE1XB+8W0z8Olr8baX8mM5O/7Xg
         hocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=87rulhgJfiv21qEaTxseqV/cAge3CoEQMJ20JUEXXlI=;
        fh=hKMkDBAbn/is7YBHG8RaKHoqpHrZb1Ubqmu1+FOVfm8=;
        b=ljumWh8L7wUgH1Sn5Mty1H1S9ZtR2bD4d2sW1Vy+0cV6tDZNP/+6Hz9AROnbTSnLIl
         t21mXzRbSHRmaKv3MJYV81k5of1BUcmLUBZhwsjTrWK5WasGEs554hzWwekX7CpbKHmM
         ucSdb5V9V74TgTc731uNWb4/xN2L6D/L5quEFwu44UCuvU83wviQdxhc1OTFwoSHExlr
         z6VeMrLpfw2TP3ZenDMejNl8OJ6RRQTINm3unOFfb7nS35Ms0JxSHga2/EFKnRCU+jUU
         6duUWsS3nR54jj3KkAB/NLo8+KLP7MQh2fDr6T0O/twDuyAj8tojAIxLJyDePJ95A6+U
         lwlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794314234; x=1794919034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=87rulhgJfiv21qEaTxseqV/cAge3CoEQMJ20JUEXXlI=;
        b=QaxtLhMLzna2DqFnl8rF0kzUuQU4IXhwXr/jgqsxFsK029Wl0NXvyNa3kBQTnhNlew
         meP8pvjnlMfYi4qcE8fCHtuwCV33S83R56oo8Dz5kufwGjs/nfQkCkYD+W5vAjxXYWLH
         drlGFjUqr3CrE/ddqO3eZNxUKm9z+6r15U+DwhqkKgoJUucg5+hesGYXy3t373HHvxHI
         KWKqWfbo481m0UFJzbAeQqX806D/S/Sl9lLyqUMeXCsHONVEvI9ABrEU4p3Co0Jz7YbY
         ry/8kz88NHnyvl5G159qP4/d2DX0izhVLbcZckPIuTyC411wBprFPKPDpSTE99Tg7QaD
         w+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794314234; x=1794919034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87rulhgJfiv21qEaTxseqV/cAge3CoEQMJ20JUEXXlI=;
        b=kZDTJ1KsSTxKxtOb2+cLEYA/xK/VfBaP1oeATXEOzU0XvDvY7PeCOWdANFjOebJNTK
         xjqn5Ymxtesg40ATBM66sRVtBSZELmTRJiq1MZp5VVTIqkoAOBE0wFA1aYQdMbjA7EjM
         tw2psR6MwjPdfUS71pKFAsXNOPK4ctdTExey9yRvDYsTi0BHOoHDp3Szw0LZ0zME28US
         3Ibz4DqqJV0m6QhkWWRAa+f841Nyv64J2thc0gtFVJTXWdIfi/VGSylITZFykI2ZqLeP
         DZcq/0vIb+v2tW0VGlw+jQwDQdrWvnBJz/EHk/ApY0bqYaMim27ih3IOuP3l3T6FPGPE
         HwPw==
X-Forwarded-Encrypted: i=1; AL+hErFS1EFo6VEr0Rvecy8LOxbZ9My5KpWsir/qKg1Qp4207BxxMLG0P4o/mG/7T5/fm745r7ObiJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PIjGen/v77+4YuxldVpxxFZ2jAu2RjoGygyoI5XiNwW95uHiQ
	Mkn93y3H+4Y9zIkhQca8XEAWDUIcFXSactwa1evhq/On200B5sgoucOCbDBOOZYAV+fudPgwulq
	jetbMuIqz0FxehDG492ZZToX5NcpAuXg=
X-Gm-Gg: AYBFou1V4prRdp6OmzMDZ5nxS75BWrZt7K4koV8sn9IvYUoAWWWz85LEzm43G0Rqmmi
	ZXR4CLnvSN9VKw/XxdSGHb9H+4DcqpzLisnrNWxIkAnjeL5/2B1fuBpmfAQ+UxHcfmWVBAQl1YZ
	27bTooNv22P0M+XketClDIzn7Oi2Ux59sL0C4jMulcUphFiAGymPcaCgutfvsOHHB7gESyWwWzs
	H1U9u0ZwRNavhe7vOIptPkwNWx44hseSlUwPfcCHR3DQ4WaQLvLES8Wiu/0YfPB+SdRfhAxp9Kf
	yMn3vmK7rftHqTQVq8uoxXOKuqh9XbS0orxymRL1+WEbH5eE4fvGuPXBJOTCjSCVLTIfFOVCm/3
	qtl998uauJ73H3TbC1AHOcpboqKww6ZjcVuuE2KGl0m0t+g3plTzQIAaQeTsqIlRsp2ton86O48
	mByXip4gmVZmNakW/QXXo=
X-Received: by 2002:a17:907:843:b0:c46:645f:cedc with SMTP id
 a640c23a62f3a-c50496efa2fmr206469866b.46.1794314233766; Tue, 10 Nov 2026
 04:37:13 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031210922.323-1-drifabdelmalekmohamedsaid@gmail.com>
In-Reply-To: <20261031210922.323-1-drifabdelmalekmohamedsaid@gmail.com>
From: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Date: Tue, 10 Nov 2026 13:37:02 +0100
X-Gm-Features: AclHuK-L9Xy9_jIPCQDlfmK_CNn6002vmZtvxWl3lyu2iMFsjY1T0_prMJR207g
Message-ID: <CA+xk8n_CwetRPVJtQRQLehqXFJstwb-hYPDyP2ZGyPiYOXFacA@mail.gmail.com>
Subject: Re: [PATCH v2] media: em28xx: fix v4l2 use-after-free after failed init
To: mchehab@kernel.org, hverkuil+cisco@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org, 
	syzbot+1e71765881a6fc43185f@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
Just following up on this patch to see if anyone has had a chance to
review it or if any changes are needed.
Thanks,
Drif Abdelmalek Mohamed Said

On Sat, Oct 31, 2026 at 10:09=E2=80=AFPM Drif Abdelmalek Mohamed Said
<drifabdelmalekmohamedsaid@gmail.com> wrote:
>
> em28xx_v4l2_init() publishes the new object in dev->v4l2 before the
> video device is registered. If a later initialization step fails -past
> v4l2_device_register-,  the error path unregisters the device nodes and
> drops the initial v4l2_device reference, but previously left dev->v4l2
> pointing at the freed object.
>
> syzbot reported:
>
> BUG: KASAN: slab-use-after-free in v4l2_device_disconnect+0xa4/0xc0
>                 drivers/media/v4l2-core/v4l2-device.c:78
>
> em28xx_v4l2_fini() is called later from USB disconnect. It reads
> dev->v4l2 before taking dev->lock, and on the failed-init path it owns
> no reference. The last close of the video node can therefore drop the
> final v4l2_device reference and free the object between that read and
> its use in v4l2_device_disconnect(), causing a use-after-free.
>
> Fixing this by clearing dev->v4l2 under dev->lock in the init error path
> before dropping the initial reference, and read it under dev->lock in fin=
i.
> This makes fini see NULL after a failed init, while the successful path
> continues to hold the initial reference until fini is done.
>
> Fixes: 288254383674 ("media: em28xx: use v4l2_device release callback")
> Reported-by: syzbot+1e71765881a6fc43185f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D1e71765881a6fc43185f
> Cc: stable@vger.kernel.org
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gm=
ail.com>
> ---
> v2: added unlock in early return in em28xx_v4l2_fini
> v1:https://lore.kernel.org/all/20261031204723.1415-1-drifabdelmalekmohame=
dsaid@gmail.com/T/
>  drivers/media/usb/em28xx/em28xx-video.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/=
em28xx/em28xx-video.c
> index 84424284d486..924a3f7977c9 100644
> --- a/drivers/media/usb/em28xx/em28xx-video.c
> +++ b/drivers/media/usb/em28xx/em28xx-video.c
> @@ -2414,7 +2414,7 @@ static int em28xx_v4l2_open(struct file *filp)
>   */
>  static int em28xx_v4l2_fini(struct em28xx *dev)
>  {
> -       struct em28xx_v4l2 *v4l2 =3D dev->v4l2;
> +       struct em28xx_v4l2 *v4l2;
>
>         if (dev->is_audio_only) {
>                 /* Shouldn't initialize IR for this interface */
> @@ -2426,13 +2426,17 @@ static int em28xx_v4l2_fini(struct em28xx *dev)
>                 return 0;
>         }
>
> -       if (!v4l2)
> -               return 0;
> -
>         dev_info(&dev->intf->dev, "Closing video extension\n");
>
>         mutex_lock(&dev->lock);
>
> +       /* matches em28xx_v4l2_init error paths */
> +       v4l2 =3D dev->v4l2;
> +       if (!v4l2){
> +               mutex_unlock(&dev->lock);
> +               return 0;
> +       }
> +
>         v4l2_device_disconnect(&v4l2->v4l2_dev);
>
>         em28xx_uninit_usb_xfer(dev, EM28XX_ANALOG_MODE);
> @@ -3129,6 +3133,9 @@ static int em28xx_v4l2_init(struct em28xx *dev)
>                 vb2_video_unregister_device(&v4l2->vdev);
>         }
>
> +       /* matches check in em28xx_v4l2_fini (under the same lock) */
> +       dev->v4l2 =3D NULL;
> +
>         mutex_unlock(&dev->lock);
>
>         /*
> --
> 2.43.0
>
