Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793906418;
	b=WNlZiLnpQqZEfMQJJTUsPeAL32R+24gezRvVnZmhP/+nVrb1UMq9/sKUf/xTqtVD+Iuw
	 ceL6/NNYE6oipE4ECSqzliJGu2s15UCLzv0HVdJ81ZyeeS1JWKFtAXi33AsWPjS1yeZ2r
	 pLG3fT0xbmjPIrxxd3ZCA68lk6kCoc746S9ZJ6aaD827TjNn2r9Eac2nQrJEHLyzsLcdM
	 KjXKWKKFVUZPxDWTrAJ+WRevPUX/pITI97USs1TMNnuGHr3hv4zM6um6mvV0nDuQNfaM6
	 yNHayK8AYm3hEk/o5F44qVFnjPIueTDaPaw3yoaQUcjYR29xwiKz/aHoINJhxBEITbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Pp/TG21mhE7k1t/eWybpON9LpBrMSOVs3egyXyjekZI=;
	b=XQXtQgklUZ7frvhPvt5Qx8hnTAHxsZcJwSDl/JhP7xnB71U9MELCwlDVhPB94H9Vly6B
	 ikMjYiZ6SKKbyDH82+3PU8DxyiIsxQRh/kySCBp9pnJVW5XF3LQJdeOVCiMOl2e7uwG1U
	 kNmQ3ecFkuqJLoxP/uOpZg68Jq/FB0D9ccc39Z3GEsBNbOR3kZ7cr77NHAyXgpgbwVYtC
	 dgKnrXhI36CU7ib0Lr0Aoo/P5FTC7cPj4kJRh3R5hnKOH30Nm+NiIT/Lo1qUIruE2LQgQ
	 E+ZzzFaS0esGBmeVjEmjhpwPNYD2210fIuKZZruOauClmNZ/B3v3mozCsIl933D87Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=goxBSdge;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06204606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06204606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=goxBSdge
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-945ae2daa66so218684785a.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 11:20:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793906417; cv=none;
        d=google.com; s=arc-20260327;
        b=LwRtIWmcDMFDit2IwlzQT+XVVfVZMJDqz5Sc+vdDAwHCyvJ6GHrWMNDdUmW7DzoYW8
         l4UddaVnxriNNmwDVQAEJMQFcPVl21u+CGNK1o674DtgZ+paIUWVIoV19uebxhANLYqB
         WXRiW31SlKdWnJuiy8TVhX7O5aozDOvl+/Qp31aXYljcjx72WU/m1fxN32r0XMrpx0zo
         y6EXb7oDIfwK8+iv7sE99XyLxuhICXUmL+TvzvAIB1Eb539P2ueTVScVh2FY8YWthfHz
         q3WBA/lSBqMT195tyBfhV0IrP6b4DC7E8amV6VrFfbJp9AJqpZY6lWKoiJkGgoP9ibYg
         eUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pp/TG21mhE7k1t/eWybpON9LpBrMSOVs3egyXyjekZI=;
        fh=APkz1iJZKxuuYKBCiGG9o5l0ZlHv5W3/97UPvb9YWFk=;
        b=FVoFoz4AOgB+tbH/Yqn0lY5As3b9p6MOnCOAZQD/3somgGsJnmbFbk9cJkbIzerRxJ
         ZXwJ8uebD6LZv693V92DB08s1GUvm8q6KcYWazqGGzZhV58jO1HauHLoEcW6dGVEJeOB
         qZ2ft31Q0WpPxYFwnwZIVVAXvbIFY0vLgED+n+JmXm2zhhfUDoaoc/yE8JcPpF3VJ5qA
         23jquSHU5SXX3bVOCOonwTTCWfJYDzTjrzWRQ6DzgxpqytmWQmTszHHkKdRohYCL0v3J
         qTmBw4jm6TFiaiZftMTPox1KW0MrvvaCOVXOnyFWqhjZPsD01PhNeefuqcp1h5h5ueNN
         ONgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793906417; x=1794511217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pp/TG21mhE7k1t/eWybpON9LpBrMSOVs3egyXyjekZI=;
        b=goxBSdgeBbdHj66o9Nu3RNovXtI7CJhsb0Rr7p21S9IEWF5RADy2eV4UGrMXXidFAl
         cTO0oAVzKBF5fO9sS/GOG37u8hhgHva6nZ/mle/Tp3bNfFyFKTXYJRAtKuu76p953xid
         afvRQG/ybr6Ut8n2erud5xXY/aDItoKUKt6VGisPWURfTnLLI1F9adpLJGkPPQQMKa2X
         3ygmX5UszfB7oFk/DshDKWoLiKPhzINYoTv7p/1tfte7N6+0mVfMFUUBEkGXI5WX1y1F
         TaRwiDOCSfgP1UpHoUWjnfCzogY3bzcRPH7XygMsHTMFXkryttjpg7un4zngWdx12xFL
         huPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906417; x=1794511217;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pp/TG21mhE7k1t/eWybpON9LpBrMSOVs3egyXyjekZI=;
        b=ZPvrlXh2ZQ1ActNSHSunG4naitoPGdo14rwJmtbGzKeYj4bqJpQRHA8QTwLwtswYlK
         kuptFRPEPTVHDFKKwdLQvERT0whGJ2bpdpiBj9axnCk1ZHjQO6tGHZ8BQCkOiWJp5+vF
         C53kSKQx8025BQdWcpEr3YzPkeR7A+XZKuY9lYJeMoVw50GLEsTC/hRROPpewSqQeQbT
         EXYkZoZRAhy8ER1zIAL8mRijKWyq8Ajhoh/6K1Z9ZBNzi6BMQr+nDoPCFfQIiBfgtOBs
         rOaXJaVXdyf7d0baJV8Z2JhPda6P35fkq2W+F8nCTLM4sTZfh9Y8c7nMaDN4QLpjcyod
         ZeDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWWngIKb0MKih3LqaTUhKnQyOt8iHsTQuy8HIRsIRbWcJGl5An1HPx3vSuBtY8UeYsrPxvCFc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/emfbOmzy+tKwoUARzVL5O8bpKnacGR7UVoC4W24wT48R2dhK3
	g2jov9hEvWcKGHc10RHFwiZ3iSSk6EOxvGrUpzMW0zMrRFOXFOjMaeEexQzuOQfU58uy/VcVO5S
	upcZ+sSmTphO1kzGxvIBv9PAuTc2TtNA=
X-Gm-Gg: AYBFou0W005CTRQ9PYF9nhNZAx5Pv7U5jW6VUFpuL9kwXEYKQjcfDnF8hZG7KSrbdPl
	Lpeat89vpFh4kElzgDEmlQ+8ZrMUfQeNhcVf6WsOCkkgXN4eQlud7TnnMeGheT0fa6v3QrnGmmD
	jxCwOEvpfhHdTkt11zk/OMk41efHpUa4AM5yIdg6nxRPzdkhwtaFlfOPpItoTqJUoStJvGo9lzn
	IN8ryoVqduywSJULhYeMQAzqXnSnmLxfR4brlP2gBaUAcC2TMP1HHfPOKVY+2EtTJHMutAio39r
	Fv0W3q6/E3/o9C3PxMHKyLFFsBmZUu91E73S0+8v3iBm0JfuFJT4wwr9g1TxBXwnRNAr8U7E7sO
	fpcPWcHqTd7l024rq54GQEoLDACfEQBTVissR
X-Received: by 2002:a05:620a:4015:b0:93c:c2c2:40eb with SMTP id
 af79cd13be357-945f35e6c2bmr5090185a.66.1793906416804; Thu, 05 Nov 2026
 11:20:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260915111448.2726869-1-qwe.aldo@gmail.com> <20260915145229.3036596-1-qwe.aldo@gmail.com>
In-Reply-To: <20260915145229.3036596-1-qwe.aldo@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Thu, 5 Nov 2026 11:20:05 -0800
X-Gm-Features: AclHuK-4ryZB_pVHQTvIJoueiQY69x_P5hoZ4Ix7YJII7Qwx1mdwYxlfMzqsWMk
Message-ID: <CANRwn3RYhEu0g9Lx+Vg=Uy8V7BWWz-jWV9d7UVuyRK-MGdbHOA@mail.gmail.com>
Subject: Re: [PATCH v3] HID: wacom: avoid overflows in sequence number tracking
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:17=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gmail=
.com> wrote:
>
> The dropped-packet calculation derives the sequence range in signed int
> arithmetic. A sequence field whose logical range spans all 32-bit values
> makes the range calculation wrap to zero, so the following modulo trigger=
s
> a divide exception.
>
> Normalize the maximum and current value according to the HID parser's
> signedness rule, and keep the sequence state and arithmetic in s64. Use
> div64_s64() for the remainder to avoid __moddi3 link failures on 32-bit
> architectures. This also avoids overflowing value + 1 at the logical
> maximum.
>
> Fixes: 359673ea3a20 ("HID: wacom: Support sequence numbers smaller than 1=
6-bit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---

Generally speaking, I feel like NAK-ing this patch as it currently is.
I'm happy to take a patch that specifically addresses the divide
exception, without expanding the size of sequence_number (mostly
because that particular part is a bit unnecessary with our hardware
unlikely to ever spend more than 32 bits on a sequence number). It
should be possible to introduce a helper function that calculates the
value with a branch rather than explicit division, e.g. something
like:

int wrapped_dist(int after, int before, int min, int max) {
        if (after >=3D before) {
               return after - before;
        }
       else {
              return (max - before) + (after - min) + 1;
       }
}

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

>
> Changes in v3:
>   - Replace raw s64 modulo with div64_s64()-based remainder to avoid
>     __moddi3 link failure on 32-bit architectures (i386, arm32).
>     Reported by Sashiko AI review.
>
> Changes in v2:
>   - Normalize logical_maximum/value as unsigned when logical_minimum >=3D=
 0,
>     matching HID parser signedness. Store sequence state as s64.
>     Fixes unsigned 0..UINT32_MAX range that broke v1.
>
>  drivers/hid/wacom_wac.c | 33 ++++++++++++++++++++++++---------
>  drivers/hid/wacom_wac.h |  2 +-
>  2 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea856..af94f59a5d 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -7,6 +7,7 @@
>  #include "wacom.h"
>  #include <linux/input/mt.h>
>  #include <linux/jiffies.h>
> +#include <linux/math64.h>
>
>  /* resolution for penabled devices */
>  #define WACOM_PL_RES           20
> @@ -2527,18 +2528,33 @@ static void wacom_wac_pen_event(struct hid_device=
 *hdev, struct hid_field *field
>         case WACOM_HID_WD_BARRELSWITCH3:
>                 wacom_wac->hid_data.barrelswitch3 =3D value;
>                 return;
> -       case WACOM_HID_WD_SEQUENCENUMBER:
> -               if (wacom_wac->hid_data.sequence_number !=3D value &&
> +       case WACOM_HID_WD_SEQUENCENUMBER: {
> +               s64 sequence_minimum =3D field->logical_minimum;
> +               s64 sequence_maximum =3D sequence_minimum < 0 ?
> +                       (s64)field->logical_maximum :
> +                       (s64)(u32)field->logical_maximum;
> +               s64 sequence_value =3D sequence_minimum < 0 ?
> +                       (s64)value : (s64)(u32)value;
> +
> +               if (wacom_wac->hid_data.sequence_number !=3D sequence_val=
ue &&
>                     wacom_wac->hid_data.sequence_number >=3D 0) {
> -                       int sequence_size =3D field->logical_maximum - fi=
eld->logical_minimum + 1;
> -                       int drop_count =3D (value - wacom_wac->hid_data.s=
equence_number) % sequence_size;
> -                       hid_warn(hdev, "Dropped %d packets", drop_count);
> +                       s64 sequence_size =3D sequence_maximum -
> +                                           sequence_minimum + 1;
> +                       s64 drop_count =3D sequence_value -
> +                                        wacom_wac->hid_data.sequence_num=
ber;
> +
> +                       drop_count -=3D div64_s64(drop_count, sequence_si=
ze) *
> +                                     sequence_size;
> +                       if (drop_count < 0)
> +                               drop_count +=3D sequence_size;
> +                       hid_warn(hdev, "Dropped %lld packets",
> +                                (long long)drop_count);
>                 }
> -               wacom_wac->hid_data.sequence_number =3D value + 1;
> -               if (wacom_wac->hid_data.sequence_number > field->logical_=
maximum)
> -                       wacom_wac->hid_data.sequence_number =3D field->lo=
gical_minimum;
> +               if (sequence_value >=3D sequence_maximum)
> +                       wacom_wac->hid_data.sequence_number =3D sequence_=
minimum;
> +               else
> +                       wacom_wac->hid_data.sequence_number =3D sequence_=
value + 1;
>                 return;
>         }
> +       }
>
>         /* send pen events only when touch is up or forced out
>          * or touch arbitration is off
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 126bec6e5c..74e7c5a04a 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -324,7 +324,7 @@ struct hid_data {
>         int bat_connected;
>         int ps_connected;
>         bool pad_input_event_flag;
> -       int sequence_number;
> +       s64 sequence_number;
>         ktime_t time_delayed;
>  };
>
> --
> 2.43.0
>
