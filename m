Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794825230;
	b=44DomoE85sFjhQtH8NSD9w59DRbr7GwtEv4tLoTb7wbXY1bncSyMV7A1Z5tNRlmtbj1+
	 H4D2plHNQfWSgbQktCnehfQNNHtOCWgxn/3FftxvhssXEqlPdaEbN0CKWRLUnWQMlXBDj
	 /KRhYMI3sbaBZvv/Vb/1Vn0K3m9Rgg1BnSPS5M1j3DNGxu+hrbMd9tvPj6W2UxKSb9eoq
	 ogVrQNtXgK6NGfm/gNxaKGdxJJuwZauqDY/IfWenDo0d57W/6IW/fC/X2aM7HybYDVMSu
	 3sST3Nb9zMfk3MDRucJcw1o5mglcqbVZi2st+MRFzNvi1lOeHW5kl+v4GG02tr2irWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BcX26cyIolLDGV7RzmSSpE6fHAk7h/NEUs+iaS9LpDg=;
	b=TON9CFQjkmCcmVklyM6ftPvfZBRQk9y02mCZAxIrpdOknXwEhzrfHPkTyXCyYySZRzWx
	 jYDn39nDB6YUelFOuBOmNeSbwE+EPHj46B7MLkvfpiurnI4krkoWPmkWMad25vVqVakfE
	 DBBIbXux31Wl2TJlBmtgcd7boMcdZYBzbTLtPCRHHScYbtNMcf4YEajcF0iYi4t4FxyYl
	 VKNPZ6JnctHf4efcROOI3pgp80qXRJ4co88qgIZbO2oxHonLDUkSjX0eyX5joJj/ad2A7
	 33DueTrwAPXK035WM5A7Jg6XliJ5xVrWoPVEsto0ms2VI6yh6cHDHgyAdxf+p7i4DhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cMA7Ex2A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2759606A32C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2759606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cMA7Ex2A
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b5973a4b4cso4354522a12.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:33:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794825228; cv=none;
        d=google.com; s=arc-20260327;
        b=LxXS5ToRxLCDWPNwTMMeGGqeofbBaNJwx4kUfxvwu/pDjt46iyl3txLZKGzQaYhLXA
         pCGVnfx//utEL7dts4u+FkJIK4blpbCYX+C++9ZrAIQE09H8I/wm2tJfOlaAgKP5lJZR
         Tg4ecT9I8KNyIcX2cBAGYQTaxFqaDacv8zYK4bHmwndncQ1z/6xFWos9Iqsv6fk9zZ+7
         vFqbi3imtpdZGrEEwN7EgRVqTzJXoMLKnZ3YylZS3q//VdFRdhFvVfd418xXeuh0gt3i
         Xi8W8FA9x2c0RcrsRLFt048F7+Axas3wR+kdj8hwOft9gj7aKE/2k35/5kJF5rzcauCz
         eiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BcX26cyIolLDGV7RzmSSpE6fHAk7h/NEUs+iaS9LpDg=;
        fh=GpI0qjwONDeoLC1So9JTFtn01HCEngF2qPWQ7znfohU=;
        b=DyMWmrMEP+ezQGaDPFuyRmsH0BfKlQvkCFUiLv6eNcl9UJ/GJgPDZZjbbajYS75Wec
         n6wiWNOHyYt7mbOrVfHDOgkBWJTzj3h0+i9tcwHhQdh8nWn9qtEYHTSQyAF3qBarn2wX
         7G4RPgrjwUTprxzu51k2LmlbsevJAVxDc8M2XY+OtfSCAMg6MhF2JEeIbZB0GDU6hWzo
         vpYnwR+f4x/K+h+zJitlrLu9LaOMZqz+EZoQUQux1NQ2Sm9mtyAaM5FmdYr+Q+j5bwgf
         FgNDu5dmE4LbJktt9AO32hV7+7XqXpMZ7hB16INh44qKyb65J8hqMRRc5k/fsCpKHPLQ
         +9eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794825228; x=1795430028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BcX26cyIolLDGV7RzmSSpE6fHAk7h/NEUs+iaS9LpDg=;
        b=cMA7Ex2A6a8giwsic57JQmQVBX4z19O1dwTosopkucFyXilbY7y4KQvBgOiVlUfQHV
         HhAjKnQP4IMUT/2RcGEYQBbPdsrbJdKU7BxmvDzSFaQwhUskc5hS0PDmx1g/X6+As05o
         vBd0pxF0KsB6gB8C+ujKBTAPYJQPLmSf+FNlku+Fk+liGCRRjB6FtAr8GiqsV8qilknA
         4otgmDh0sj2x+FLoPTxCPf09e+9/mAFOVzJuMeIZKZyVKGLFzy7WnmxFpwsKwACWKYjq
         u/mzVKhZpQMIjHbuhHuLVWetNaA9FSK4x0zkK1a2lA64X50eyJSpw2S+gM4Z3AshUNqu
         TiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825228; x=1795430028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BcX26cyIolLDGV7RzmSSpE6fHAk7h/NEUs+iaS9LpDg=;
        b=DCBeT8h+Job45oEgZhRSITWdeZ3u1BVldtZDDwZuv46Tsq4hr6l+4URRxmXbd7p5sq
         qe2VoiquLyO6GFKxAikMKu6Stf5zZ5/3ZFeuFgl+npcIztuSNyTeXgvq/WNWg8b2wTKE
         d010L9WhE6LV37FMEzOjFDq/6cLgyTtbiI7NWDRGMLBtu7n0bqE7Jl4XgxGbmfXZfDv2
         fLylz0/OPnGInCooLe63tZkWdf6rROkhkUlC6tRce1s4u+PtxeXN5vwGRXfsk5lyFRSU
         BXC7BXNQ51np3PPVvVx/DwKrPqbL97wL5RsvBGhz+iM1PKIf0VtlHt7RcopwEGWjdsJk
         Ir+w==
X-Forwarded-Encrypted: i=1; AL+hErFwatjdbYvTEPJeS/SNmzqFUgw/CqQTT5HAQoDfK+abUnSMSmcoUlVO3OKoOZ6/bEJlvJFHcVI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FmlP4MZ8QB1VR/pfn+HYEHAkJMepgGWouKFZdGE5xWSLcHOnI
	hqdvk7fVM0l6gWEGbERIdVKPArCfNnXwDy/6Y9nO+VRBCNO5GAR6G1A8cqlgUOoRIn4rpx2lGBi
	onWKzWIpckRiXfRrPpm6VUP5V0PyDaZI=
X-Gm-Gg: AYBFou0hGrOSBdZ+rW1viaPF3hzzyRoTCq2oJhRh09CBdN2WsD1zZveHV7e0kJRxE7P
	qY61KL8XGGkOVF2z0aFR3s1Rgt80QjW9M23OX+qKt++AGRgMNerEhwpoy1PfqeZykJ4pVaZhlQF
	wRTIXsXA4f6VC2WnEWFT+l5KutCtMmFTHZM7HtShh+VdS7P7Hk+ynzLEXIKV9Gd0dcNTSSdGthf
	ISWLNZCrHxmJYo4RlgXd26eMPOS+lrvpn2oII/NPb41YNNCcQsyrFI68H5xSNPio1N9MyFL4if8
	Qq0vWJOtqQ5MK8tFYHt+mxNvZhowdtY4W8khRnQcu/pwPxxksmblAm3pVyDAZgmZ3nAOZzfGWN6
	VbXuuS6rmdGhG7UiKDvfVrJLp0ZfH7zuTfSsPcnFIX2BdAu9BQY0n7Xu6/LYyGHnxkk2rHw==
X-Received: by 2002:a05:6402:44d2:b0:6b4:59d0:7294 with SMTP id
 4fb4d7f45d1cf-6b7c0c7fc57mr6737947a12.31.1794825227756; Mon, 16 Nov 2026
 02:33:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com> <20261115210952.2140036-4-graypanda.inzag@gmail.com>
In-Reply-To: <20261115210952.2140036-4-graypanda.inzag@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 11:33:36 +0100
X-Gm-Features: AclHuK-NMHGmo8BvWWPeGRhVs7Os08I_QBobJYDFHOlrsGgrh13rxr7aQnEhSTs
Message-ID: <CAOQ4uxibz=iM4Xg6qmRmqKB25w=Z9AaaqnMqc-L2d27G632hyw@mail.gmail.com>
Subject: Re: [PATCH 3/3] fanotify: zero-pad copied event names after an
 embedded NUL
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:10=E2=80=AFPM Junyoung Jang
<graypanda.inzag@gmail.com> wrote:
>
> fanotify_alloc_name_event() sizes the variable-length event buffer from
> the qstr lengths and allocates it via kvmalloc() without zeroing.
> fanotify_info_copy_name() and fanotify_info_copy_name2() record
> name->len in info->name_len and info->name2_len, but copy the strings
> with strscpy().
>
> If a qstr contains an embedded NUL byte, strscpy() stops at the first
> NUL and leaves the trailing bytes of the allocated name buffer
> uninitialized. copy_fid_info_to_user() then copies name_len + 1 bytes
> to userspace, leaking uninitialized kernel heap memory.
>
> This mismatch dates back to
> commit 929943b38daf ("fanotify: add support for FAN_REPORT_NAME") and
> remained after commit 0fdbe845534f
> ("fanotify: replace deprecated strcpy in fanotify_info_copy_{name,name2}"=
).
>
> Switch both helpers to strscpy_pad() so any trailing bytes up to the
> recorded length are zeroed.
>
> Fixes: 929943b38daf ("fanotify: add support for FAN_REPORT_NAME")
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
> ---
> Note: default FUSE mounts report a zero fsid (-ENODEV on fanotify_mark()
> with FAN_REPORT_DFID_NAME), so this patch was runtime-tested on tmpfs
> with FAN_REPORT_DFID_NAME create and FAN_RENAME events.
>
>  fs/notify/fanotify/fanotify.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index c25cf5c1fc70..4a1f14aa4974 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -225,14 +225,14 @@ static inline void fanotify_info_copy_name(struct f=
anotify_info *info,
>                 return;
>
>         info->name_len =3D name->len;
> -       strscpy(fanotify_info_name(info), name->name, name->len + 1);
> +       strscpy_pad(fanotify_info_name(info), name->name, name->len + 1);
>  }
>
>  static inline void fanotify_info_copy_name2(struct fanotify_info *info,
>                                             const struct qstr *name)
>  {
>         info->name2_len =3D name->len;
> -       strscpy(fanotify_info_name2(info), name->name, name->len + 1);
> +       strscpy_pad(fanotify_info_name2(info), name->name, name->len + 1)=
;
>  }

Same as for inotify patch I prefer that we are consistent with d_path(), fo=
r
example by using memcpy().

Thanks,
Amir.
