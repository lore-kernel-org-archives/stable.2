Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D67263B
	for <stable@vger.kernel.org>; Sun, 31 May 2026 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780192037; cv=pass; b=OepvCjg5oEsmf04GZxZnYr1KVvbft1aA8A1XFK+hJjq1d13CRV9muY7ZhPWBGo7525yK9hOfFGdRp6lWJE7G0eHWcLrfyqq0Oo/oT1FFWxcx3kaP0ljZgbe0Uka3xAud/AYvGwaeAi4qQrL6Q5NTN9ykSv5tO/mzPts+uZLlt74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780192037; c=relaxed/simple;
	bh=vh5kRDjzzBEJ7r3I1+/zHm3OqBBaVfrc2+H7j4HGEXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxxbYXawXcDT2mpF9Ety8mL5Y0yY/W4i6qFrdQFyBPBbVGrYaLafCxRnUQHblGznQtRaYBqVrxUPFS1iSj3TU4/6vLf6KZp0b+lYU6u+OezSJyGklUwyql8PdYHNDfdqfWN11j7suwy3dOLrNCGKGjdTcc/pCoXLHuxltppe26Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjRcvfON; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjRcvfON"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7e2cb01a974so3768707b3.1
        for <stable@vger.kernel.org>; Sat, 30 May 2026 18:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780192035; cv=none;
        d=google.com; s=arc-20240605;
        b=LsA+YIF7uiXWW5DHTgWb+0tV6Uhy8OOsG6ewvHyRiACnUOV1Q3o2MpoJ5494WOGr1G
         YjLKqLMbmjrgRdgaSDe4KjVAPisbyIAwM0d8LGIzf2KVWfNdXUVOT3Leu4Ruhe7kwmLH
         JEaa0GC5c8Z8ZodXQgRYtFfs8PBmx0ZZec00DDUa5ODXXnC8oMvj8yFdLoHcT4b5p1Pr
         npqig6B+8Qr5gl7W/0Kw7tt99wrxfwos10kApJyd+PQGuYUvN7W96ynn0rnn/xKRmnQP
         hN8bx8J7FUzIrTbWiU2/H52+omWS2qApDQmkm9iQPFThDFbI6mDNzgfKqRnw8SgpgJt6
         EhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wo6qnMj7T215aHzWxww/SxbyHvlT9Ci/8Zz3mgbJ9ms=;
        fh=ONEsne37yTcX5Ugdxb0BZRYCrS03/NMSb6Khzha/Ms0=;
        b=YP/fnqJiwPHvdRsCEzE0WyDu6kHVIt97azjGltJJ94ZSIxSSIjjjkk+TCKtKu0g/x2
         WthnLz6auN0wJfpanNpqP86YGWGlK8PsAmqdwv3Hy7h+5ryc7r6dUofsxr23VTjmfHi2
         KnJSRXaakGYL4KQde7y3VGVc4zCHTqtPtftWGamAuUC/UTBJY8utONmZ53z83+5PY+Rh
         cLVX4FBeRbRru5smBV3sZ3ZQDKh+pce+lL/LoM5ziNOkQbVyProXAKDjrhJ3Qq8dZd32
         tduKKuAVl0VTQNVOALvFRopwDhQt6f/ZrLbC50PT2HG5J3BJxr3VqbxRoSSTR/GS7Dux
         GfMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780192035; x=1780796835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo6qnMj7T215aHzWxww/SxbyHvlT9Ci/8Zz3mgbJ9ms=;
        b=XjRcvfONSZ08P2/9nR0hz5GZHpa9GBdmwMDwDcplxkQ3rfhuXiwqZW4qizf2Uvi6QP
         PQubYFxMaYIVRoNhD2mR8y+agWKmrJ+vgk0PQ1yIgu0WGLtOvpWhCSFlQ2lCVQ+Xjt7x
         pVpDp4cd/aVk+H7pJpYIHoTDQfYdbUDPiceaL+JtYjKmm2WfCOBdB8GcxV3+rpBvB8If
         P/KrZpcYtO+U1OzWDHPw1t7jV9PZrptLSICR+5nOLhLYKNoqXR394SbCpPQtJLLS1ads
         wl3AtQgsPxVhQM4+AiNhmckPsFG6+hBWVsiZeQAHZc8WC6h5FEoeF7kdE+nr5ABSygnc
         F7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780192035; x=1780796835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wo6qnMj7T215aHzWxww/SxbyHvlT9Ci/8Zz3mgbJ9ms=;
        b=gV2Ky7ZsC9eZ6zA4CE5uQq1d3geKMO36lrF16OlsbGzuIY13AHYqb/3a87gF7xmx4t
         WKzgOX1uGcMd3Rpuyf/vg/ssFPtZRElj/H8tXsCTAA9lo0I1VuStJRQRobBHX2B8zdo/
         0d6QjmvZaYmhjg2YXn963rGHViRXLbTGvv/qJdTr3NCUl+SO0zdLFGmXoFlJcmRHZhVZ
         TD4h4lwFUNtpugj60MwVitAWa4UE+pFm39+SG1xVwunKc3mXX7iM5gnQ2qm9kK8tiGPq
         uBW/ty6JDue6N4nJziYujHSeq2RV5Ii8Xw9ClKT7ZhVIC/5qgEdKCy31ozwWv3EQ8BZv
         RK+w==
X-Forwarded-Encrypted: i=1; AFNElJ94cwAYQCvXwUV5vwlXpwW36C9jk96tv3I0FGCFwgv0xPaANVev7A7O4hNymdqYJ6BqXMpX7F4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbbmw5VPSfaX/7/5ci/vBVKSzKsoCALOpZYOWO/um6aamSbfRB
	3THytHUMiaZXzu8hzmaRBlOftOjifXn3VPe1p3K+ywx2BMVB/MZnd3Yz0zKN93Vg2Kd3zuR4IxE
	cagiUCi1ixoOlMka9hNXhgEQjaQqmCDo=
X-Gm-Gg: Acq92OEFO47ofJFw4p4A8T6XYerLKmtkEoD3YKj8zsCnjnYDuLk/yWp9QBcR4DUcuxc
	lVCgCu1PY2w9JmUX7QaiZ1HwMABStZlQk9/e6p47CAnKWgu9S57f8QRxF84V0efFqPwRtXIEg3J
	tMBmZnOPL33sXv9FVwm6CW8a91rFOcqQZWwLFX8vwgAJOw9lmEd/oG8UlKy2jXIaUISTYvYiuQD
	YKzRvN8d774XZPbOsoBDDr+hxipu2eOND8krsur+NVLPuTEgrYs8pdfC0CeAG5Onu69ZqZ7vd9f
	6cTk9iTW/5ercxLdEwJsS2040tVj7en3Vb5dMPu8X3/Fh1r32Z+ZU1ghIYaW6iEkAMOcxZEuFzh
	uLX+MYQ==
X-Received: by 2002:a05:690e:118d:b0:660:7700:e31f with SMTP id
 956f58d0204a3-6607700f684mr1270513d50.24.1780192034893; Sat, 30 May 2026
 18:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324015539.1451660-1-kartikey406@gmail.com>
In-Reply-To: <20260324015539.1451660-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 31 May 2026 07:17:03 +0530
X-Gm-Features: AVHnY4LVuloeVDsa0PR4xsQ4qvl_ltMiGJu6FklAXAj3AWoL-9T2VPD0GwmQrf8
Message-ID: <CADhLXY4SKRFnkDhR31U9pU_4CQ9WC+2AOfYL1KXnLoedTDoWbA@mail.gmail.com>
Subject: Re: [PATCH v2] media: ec168: fix slab-out-of-bounds in ec168_i2c_xfer
To: mchehab@kernel.org
Cc: harperchen1110@gmail.com, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+64485d3659c4c07111b4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 7:25=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> The WRITE_DEMOD path in ec168_i2c_xfer() checks msg[i].len < 1
> before accessing the buffer, but then reads both buf[0] (register)
> and buf[1] (value). If userspace supplies a 1-byte I2C message,
> the read of buf[1] goes out of bounds, triggering a KASAN
> slab-out-of-bounds error.
>
> Fix by checking msg[i].len < 2 and returning -EOPNOTSUPP if the
> buffer is too short to contain both register and value bytes.
>
> Fixes: a6dcefcc08ec ("media: dvb-usb-v2: ec168: fix null-ptr-deref in ec1=
68_i2c_xfer()")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+64485d3659c4c07111b4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D64485d3659c4c07111b4
> Tested-by: syzbot+64485d3659c4c07111b4@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> Changes in v2:
>   - Fix author email case (Kartikey406 -> kartikey406)
>   - Add Cc: stable@vger.kernel.org as the Fixes tag points
>     to a commit present in the stable tree
> ---
>  drivers/media/usb/dvb-usb-v2/ec168.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/dvb-usb-v2/ec168.c b/drivers/media/usb/dvb=
-usb-v2/ec168.c
> index 973b32356b17..ebfb02826b20 100644
> --- a/drivers/media/usb/dvb-usb-v2/ec168.c
> +++ b/drivers/media/usb/dvb-usb-v2/ec168.c
> @@ -135,7 +135,7 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, s=
truct i2c_msg msg[],
>                         }
>                 } else {
>                         if (msg[i].addr =3D=3D ec168_ec100_config.demod_a=
ddress) {
> -                               if (msg[i].len < 1) {
> +                               if (msg[i].len < 2) {
>                                         i =3D -EOPNOTSUPP;
>                                         break;
>                                 }
> --
> 2.43.0
>

Gentle ping on this patch. Please let me know the status of this patch.

Thanks

Deepanshu
