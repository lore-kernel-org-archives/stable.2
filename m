Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAB1DA57
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195559; cv=pass; b=kR/5SRFPCDfDduLaHWA1vJpNYoVGIt/s+tb1Sd/3AV7/YLkQqnddbKXjO2qk9DZcHCF8mgi4AuZwzZSAQ98D9Gns2D0GvqJrTjGsBZnoQBtSj4CrEXeaLohxAuUk0bYfugWFqarw72KWU2p3RPtrcXjGPeDLmMdELsUC1nI3Rj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195559; c=relaxed/simple;
	bh=A1yBBpLJ1bJ3Rv9E3+TAn047VSvJob1S4KjyARr4O0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhFZBQeaY53rZ6L4+n3byHUpQr6hJ2Tpkv6aHsZ2Kx/GvKH2k9kfgqg7y0EG5mF3uE+p9YeVjWMy+UOsKqEHWd+WKU9QncXfsX3ZLTfiqTpO5zw1I4G+Y4nPWzcLVMBC7l4eaQsvKmgp3mnk6ibbGdN+3kHW732jq+Jjph4ySUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdQoA7gQ; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdQoA7gQ"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5364d86f7f0so495781cf.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792195557; cv=none;
        d=google.com; s=arc-20260327;
        b=KhtHCCLsQuOj2RxRTqkqp3WM+cjm0AzzBiA4JMfIGs8Ece85cznbYHiv3xeAJJuWfz
         29qQY9MGzY6zdIHq4IpJnyzTHEywF+LpJpLwfvQgBuz7PPa4P6qq7cfy7REgI0JXo3UU
         WxSP4Q8y8TGlMvbSlsXaA/Ai/UJiQFDGWQFvjBWyQlKXnKJRLC31F4b9dZ95Zm9VNml3
         rEgjrob8g3+HlPtxRJM+xfG6bf4dBIyWZLPfpdj/JcKwhHDmXoc1w7gakgbwvOc5mW4B
         EW2yzuhiFCDNPypR2LMyrOPCEtXuPNh4FkNY5a1cda+a7xkato3yDFPjxReRjtX8c3Z9
         H3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9m04eWmztaCm3Wj7dJ9THoHZwUu785KZfKba5Fj3Wfg=;
        fh=tl56syxSW4VJRVn3nfOj6T/ZJOIFw9DD7EgVmvSZLnw=;
        b=q/wttFYwZR8JthB++LgCt5ngS/AdMj1CwAHYm4kxOUsVDZ1TM9d76Jslg5KBdLB0i5
         Qbzm8Y53wVqcj2X75fi7vPdovhrzvJtEYLg9qX9AJq44cNtnov+JTrD64k3CJNLvO5pj
         CxpWep6Ju+fQFhu3IthLuyj0rcNQssDFX1RevF0p2AlMPTRT1/4LXXLkFVpXVXs2bDKG
         rNhkOMAb/+W9EmDMn1hgVtdOgmqLnCh2eIMsrKLwjzDp5Y6UYS6WXAS/Ui3sNOVE8lNh
         X8usOrf4dxQmKDy+VDaaCXttl+evDQmGaosHSsEr8y39AknkZ3PAyJ6AjY4bVGZQOp9L
         naIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792195557; x=1792800357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9m04eWmztaCm3Wj7dJ9THoHZwUu785KZfKba5Fj3Wfg=;
        b=VdQoA7gQkThRoloVTJi3lLyl6W/YSOqabe47GQKVkVANrIrNj272DpJkOt8kK7BT2e
         O25+869fWCIkuGNIk5ep4NhBPcwEeMhPo6YN7oPXUJhAJMHasQHWm+lHHX4hvfrr8TCq
         yxaL0JyFRJ3itPc61U2svcirnk/ScSGacEtmot7XM/BqDciMQBNiWkIz3/5jwJzKT+fZ
         GYY3h/jDDsdIhuMsLRo8DqGZJWLLSIfRZVMrStrrODCj94/qVzQe0pGcRp932x9ISP5Z
         feYo6R3tpaxUje6WmGbIJs1FlLFD4V+MhciT/IqX2m/CKnJAiX5041XfbqJG8mqzVo4M
         h/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792195557; x=1792800357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9m04eWmztaCm3Wj7dJ9THoHZwUu785KZfKba5Fj3Wfg=;
        b=skgAcG2lBndRMDGQI9kUct3CULtTYZ0K/RDRRfj6ZXFmBrLjbxfAO3Tp1dVoMrRI2z
         3lBRdSB7l6T1FY2di5Zxx4S3caqwxDbesyUYGLF3zA/m2dL4Rw8hAyQEe34+PcarFNhI
         Ad0IoR5n1mTZgLUSZkC98Nj+1Mfak5pyjsb7O3A3vNWlVvZ8UCVDoAdU1YylKb7Dl7CU
         ETOKpHb8cdc6UI5519/dycYZN5lDlXYJFj3Tt+oZK83CFs0Ik6Fl7QxSHYFzy0qimpsf
         tdKmgqW9+KLeOrp0slDh3Iql4+cnn1s8KTbxwVR+E5LZHprVTR2Q+pC945nvoMpYWP/N
         sZ2A==
X-Forwarded-Encrypted: i=1; AKwUvByly5txQmRw4dkGvVeWMar679uZks0XVhUUFvXMLRFI3zASm9OqeqgHaFOwjbVDxYG3imLMHGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoJoMyOA4pbN2S8DydGy+ri32FiUkf+W1DglUh3sj5hJH4QD4+
	T1Sh2tdjQ5zMJOuW1GWNJX4d1A92ACJ+h0VZoEoe6NZMjt2+2co7napE3I3Apmu9SD3ggRIOE9l
	R0vKdwyefVmyZJYTvl8fbNNF8Bmm8MKk=
X-Gm-Gg: AYBFou10JGXr11NPytKFGcjOxappVyPJTmI3+6tiqSAnX72CKJZavUNNhVx3N+seZEH
	sstgXok29XbGNQtoCNeNU3xjzLocihGEMD+Lh/71RbmzcrqEAb1i8hYZA2npTzRcNtR6YKWtkJO
	mbuDKgnE2s/r9zMWtvSfeO5PDd/gFExF2O93ecMnCcj28Rm6MIa1sk6lEG3OEdoCymyGmg09GTV
	clPXg7/A1t2Xa005Zt7o9wOEG2gJ6O1gqWjda0QGZUJ2wRPrYoK4jHucPizVuk5TUT3l5vkUUSd
	hhI6YrZivo2CtyCwP/PIa+swGfCWUpsxXtsQO/7b8QQzmGwKUYkiRh8=
X-Received: by 2002:a05:620a:6cc9:b0:93f:baf:279e with SMTP id
 af79cd13be357-93f29b72b3dmr256358185a.8.1792195557231; Fri, 16 Oct 2026
 17:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
 <20260927041138.4112920-1-jinmo44.yang@gmail.com> <20260927041138.4112920-4-jinmo44.yang@gmail.com>
In-Reply-To: <20260927041138.4112920-4-jinmo44.yang@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 16 Oct 2026 17:05:45 -0700
X-Gm-Features: AclHuK8DOt62Xds_xVpqa-lc0Zk5FJujgPMgnOItP_EsoMr5iLn6xlgBeOOCC30
Message-ID: <CANRwn3S26juDz-Ad74Ehh2q7SFvbjzBNDMjS65WMdJvK=zaU2A@mail.gmail.com>
Subject: Re: [PATCH 3/5] HID: wacom: check the input device in wacom_intuos_pad()
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 9:12=E2=80=AFPM Jinmo Yang <jinmo44.yang@gmail.com>=
 wrote:
>
> wacom_intuos_pad() takes wacom->pad_input without checking it. An
> interface that declares no pad leaves the pointer NULL on a fully
> successful probe, and wacom_intuos_irq() still calls this function for
> pad report ids.
>
> Reproduced on linux-next 20260925 (x86_64, KASAN) with vendor 0x056a
> product 0x032A and report id 12:
>
>   BUG: KASAN: null-ptr-deref in input_event+0x44/0xb0
>   Read of size 8 at addr 0000000000000028
>    wacom_intuos_irq+0x1b46/0x3300
>    wacom_wac_irq+0x1b59/0xb3f0
>    wacom_raw_event+0x68f/0xb60
>    __hid_input_report+0x398/0x4d0
>    uhid_char_write+0xa99/0xfc0
>
> The function only ever serves pad reports, so the check goes at entry.
>
> Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/=
Cintiq")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
>  drivers/hid/wacom_wac.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 794c2865064a..48a58a6672c2 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -553,6 +553,9 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>         bool wrench =3D false, keyboard =3D false, mute_touch =3D false, =
menu =3D false,
>              info =3D false;
>
> +       if (!input)
> +               return 0;
> +

As with patch 1, each of these checks is for an unusual error
condition so a dev_warn_once or hid_warn_once before returning is
suggested.

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


>         /* pad packets. Works as a second tool and is always in prox */
>         if (!(data[0] =3D=3D WACOM_REPORT_INTUOSPAD || data[0] =3D=3D WAC=
OM_REPORT_INTUOS5PAD ||
>               data[0] =3D=3D WACOM_REPORT_CINTIQPAD))
> --
> 2.53.0
>
>
