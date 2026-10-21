Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792609066;
	b=pPRfxlFIG3aBuk+4D6kyT94k9At9pYT00TyAOjxGqC9vhKcMgnAELOItHsJIUuBV2Dvm
	 KulvVVuuhdNMzzHYTJFaDWUorVBihOEzc0VkpdIxI7h+5qEM4m7OhKuwZLMZi6uYCmgGG
	 xC8tdc1h17mr8O+B8hLgKNUHTIl/H0wsrG4dVLC+BG2KDeAynimgtA8KgarldMWkDd1wl
	 aph/kx36H2nrmaZgPF3FU5XTXGSmvMrYl2Ddc08OSb/QjL5bqyJ1+iSMUMLMxjffyGwUv
	 NYF3Q/vWL3vQ6KLIPbTeoRGM2MsjNyJ+owzH+Yx+FRb72hQWvFnsVMUWqn7pL00ANmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TyL9llcsal4SOiVQ33XFom8NGFxfymW1uiK43kazgp4=;
	b=tVxvUth/dpjHo7xv9dzZE39I1IfILudfoObVwXsYLe1vRdtuILG1n7C9R97XJCXqbQAy
	 OCe/Zf8j3Xq006aUINO0y91EKtybrRratzZZjAUQfImtpRSi8WPha6LCwvig+wSSD1D7v
	 hssMta0thRAzLWzrt8dx3ekkxPhaOzVX91iaKNHukV/LTKcPyao9PV2tkIIk8bOI25sC4
	 iMWS0yhaZEiwIu8N0XYomBXXJUMgseVC0SoEoIV+/ZykFmW/uMirePOu/bNIKRX9dQq2a
	 HzWYx4BHf/UdgU8TOaFYpivVrxjvKKI+FXGM+bXd/Bc7xVzUK5e9K5OzoPOdnjJG0GQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kjGOALsu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE6606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59EE6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kjGOALsu
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b8b456dbeso11035866d6.2
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 11:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792609065; cv=none;
        d=google.com; s=arc-20260327;
        b=ByyqztjLEsr6cYzv1S8wFJKescaZUBxn5SHFJtirUUzScpuMf6QYs5MRtfGViVm8OE
         31eHyaVk8c+x76QJ+lkP62pGevr+4T8zKPtZWXAdDD18tsPnqHvqh/JuJ9ZzSQF3yF9E
         FZOy50yZSU1oTD6DaV4/5LZecTSp0GzU36jDP2fs5TDRmFcGUu16PnMvkECtlpT2PXDo
         JqzIbJ5WOFZR+Qd4Cuz7SJXFo93ZqGFTq28cG54bJBZ5qIS+zEK/WyE1ccBmE8PP7uIZ
         cFgMbtWVxTvjM9A3uCNnmHzPMwddL6GtyPp+hfc53GN9QS3f8wm4mSFvGHzvY78yxEJE
         mWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TyL9llcsal4SOiVQ33XFom8NGFxfymW1uiK43kazgp4=;
        fh=FyIGMhZnz2brh4duGKyuWryVKtiE4OkF5T1BaRR/d90=;
        b=Pk3vx2C5aIdYP7MPAPbv8ArhJVbDcBcPT0XLXqMdgEdiuYfTehDvgjieQtNVWGAULZ
         7FUTT4s4a0miK6CGOKV8DExlJxkKTOHIVJSL3W7HZzmDzOeJFDCs9uQcfqoWxHaO4rDR
         +qgiu35NBvtyO0439NxUhsW4GtlV+jAaIUikmrjfLibfifj9KrIsoCo1iMnjtMpey+7n
         KGXK50FYYn83ep9/mbJJ/cUi+9oDR+telsBFwPfaMByBmk3JmTXn7Ubr7gsERPF3SMKZ
         phoB5z1avDJjJJ7Lshea5BTrR4dYqe30UQQXYthTLkQEgOPe+pqsHdOsRkWsBZhWhhWp
         SrAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792609065; x=1793213865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TyL9llcsal4SOiVQ33XFom8NGFxfymW1uiK43kazgp4=;
        b=kjGOALsuRc96u0lbbBCHd+t/kSgHPs10UzG2JjaWN0A0JRVmmpjP+hr1FELaqqlIkc
         a2VxPzU2BjzlRqvebHagLCCoTnlxIn+hRgVkVnmFUg6+KB9wRNBijyH9EWOdT1eWUHFi
         d2sNdW29OMq6hggPg6S1bQUzcW+Vjgdb3ckPTvd70RuODMYSEtZl/s48Wcs2JBQh3yWB
         AgmJwDXmuUPTMUinlm4I1FkxrxxrFyCqgZkRfF6ArqcIIVz7T+pl7eNLSdvLk0RE6o6f
         k1KLciec+Qjw4Ope+zrjrSrXqtLdsmJX4PUgPOZAjf3vCcPQduHNzs7t31mMdnaf8Jwl
         e12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609065; x=1793213865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyL9llcsal4SOiVQ33XFom8NGFxfymW1uiK43kazgp4=;
        b=I5lkjTTr9lUIco5jw+dPl7dCiOw2dgNxmYLIi7d9/mGPUSz0uiRBpO4BNR1x5CWN8/
         IHkMUHgueGhW3HPYfWJstWLCzggao37rugOJeoVt6GViEanc+rBPFI0bw8FrILalDfum
         RHevwBcx7xEaK620QsGdnAKQ1W3O9BGUbEVSZJoHCCkPIwCDIlZlDu3Ges2X8pybsPUN
         8UBW5NdYzVjyDfhfXj4Dlf4LgT4NUxAWsX1CT48Z7dowLhUMQsLg3855tNWyebaj9tG0
         V7l3+DoEZaAttRhP60XX9Vc47vDFY8JFwnmL/sOQcOxdtpmDFLbW9S4I8xGP26iB6Kkf
         leeg==
X-Forwarded-Encrypted: i=1; AKwUvBxwW3/5IVhyTGcc3ExsIjXz0T+gSwXlBpwOcOMa9N2v79TSjFmqe8Cc3y6UxnXPvTgnMVJhXnU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLX0nr03tsZS8eFxaCJneH1Kzpii3f1IETaQhRwAuyPQF21qKr6
	z64prPo+DwvJJBAtXaQkZUqMBitvmGaYYYq4s5pIz1dbzbOAnoOWeiPaGl3Rpnu5jQSgbQrZYYp
	b/tqVa9lfaG9ZsKuME2tHtLu2P8UJWiE=
X-Gm-Gg: AYBFou0u9EEr2GowPDo/ZnRjs3EE6+zszDw4L7hYGnBW21NlHPXPtEwX8eB20NMPf/M
	eXQ/FAKJvTa1uFT5jGW3wUlbSkos8EiYD2iwJHHpnSPrV+YYBGoV843N3Mc1C6twdZh4YsK8yEV
	yfL83TDcjVOUIplzdGwrnS42JvCueAeqq3CKIM7LyAHgiM3ulyewuVWTsX3bmwTKk3yg1j8l2XV
	PqkcEz/K/Wrps1o2V0f/M6w9ZIXiuV8nY4ZtxzpGPCyYiYdiZlYsqOiVUqWS+anVlN3Qqckuc5B
	qXpGsB53s2WgwrnLCQdzrhn87+eeXNSuQogAuR40UukcvJpt22nMywRYprggIdomfN9ddUVCbQj
	IlE44/jDILnMCsCzPKTc+DcNMGC8N4+ZrYGQI
X-Received: by 2002:a05:6214:2026:b0:91b:5d3a:4fcc with SMTP id
 6a1803df08f44-91c12f57cd8mr50541036d6.57.1792609065159; Wed, 21 Oct 2026
 11:57:45 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018124755.850888-1-jinmo44.yang@gmail.com> <20261018124755.850888-6-jinmo44.yang@gmail.com>
In-Reply-To: <20261018124755.850888-6-jinmo44.yang@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Wed, 21 Oct 2026 11:57:34 -0700
X-Gm-Features: AclHuK_ejuCq64puYEyVI0F5dBdnGQ6uXcliBiinZhl_jRQ73tHCVePIfkfF6W8
Message-ID: <CANRwn3Sw1r6PWqZVynBdtqDC=T6SjF86y9VcNM7WYBhhX0LyJA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] HID: wacom: add NULL input guards to Bamboo
 touch/button handlers
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 5:51=E2=80=AFAM Jinmo Yang <jinmo44.yang@gmail.com>=
 wrote:
>
> wacom_bpt_touch() dereferences both touch_input and pad_input.
> wacom_bpt3_touch_msg() dereferences touch_input.
> wacom_bpt3_button_msg() dereferences pad_input.
>
> All three can be NULL when the corresponding
> wacom_setup_{touch,pad}_input_capabilities() returns -ENODEV during a
> successful probe. Add per-function guards.
>

Seems reasonable to also add a check in wacom_bpt_pen(), even if (in
its current state) a null pen_input is not possible for these devices.

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....



> Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
> Fixes: 862cf5535c0c ("HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD de=
vice_type")
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
> ---
>  drivers/hid/wacom_wac.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index e0bf03123cf9..a34db1505625 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3151,6 +3151,12 @@ static int wacom_bpt_touch(struct wacom_wac *wacom=
)
>         if (data[0] !=3D 0x02)
>             return 0;
>
> +       if (!input || !pad_input) {
> +               dev_warn_once(&container_of(wacom, struct wacom, wacom_wa=
c)->hdev->dev,
> +                             "%s: input is NULL\n", __func__);
> +               return 0;
> +       }
> +
>         for (i =3D 0; i < 2; i++) {
>                 int offset =3D (data[1] & 0x80) ? (8 * i) : (9 * i);
>                 bool touch =3D report_touch_events(wacom)
> @@ -3185,8 +3191,17 @@ static void wacom_bpt3_touch_msg(struct wacom_wac =
*wacom, unsigned char *data)
>  {
>         struct wacom_features *features =3D &wacom->features;
>         struct input_dev *input =3D wacom->touch_input;
> -       bool touch =3D data[1] & 0x80;
> -       int slot =3D input_mt_get_slot_by_key(input, data[0]);
> +       bool touch;
> +       int slot;
> +
> +       if (!input) {
> +               dev_warn_once(&container_of(wacom, struct wacom, wacom_wa=
c)->hdev->dev,
> +                             "%s: touch_input is NULL\n", __func__);
> +               return;
> +       }
> +
> +       touch =3D data[1] & 0x80;
> +       slot =3D input_mt_get_slot_by_key(input, data[0]);
>
>         if (slot < 0)
>                 return;
> @@ -3229,6 +3244,12 @@ static void wacom_bpt3_button_msg(struct wacom_wac=
 *wacom, unsigned char *data)
>         struct input_dev *input =3D wacom->pad_input;
>         struct wacom_features *features =3D &wacom->features;
>
> +       if (!input) {
> +               dev_warn_once(&container_of(wacom, struct wacom, wacom_wa=
c)->hdev->dev,
> +                             "%s: pad_input is NULL\n", __func__);
> +               return;
> +       }
> +
>         if (features->type =3D=3D INTUOSHT || features->type =3D=3D INTUO=
SHT2) {
>                 input_report_key(input, BTN_LEFT, (data[1] & 0x02) !=3D 0=
);
>                 input_report_key(input, BTN_BACK, (data[1] & 0x08) !=3D 0=
);
> --
> 2.53.0
>
>
