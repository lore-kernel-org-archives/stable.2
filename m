Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4326296
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774263; cv=pass; b=s1j91viwd7X/XcRVE8kaapBG8trynljI8GdScQ33v8O8y1z2JQJCFWobNwXWyc0B44MWQmWGxWUyOxjPdDmfMiQ3plp3TD1HweR4gyECeNQSpdhIt69j26OjK0zTk/CcYY+1CtY3S/wOI35hPm6nSbU0UeEjrE/8UDfcklyd+K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774263; c=relaxed/simple;
	bh=MI41XlQsowXvuVw3HoU1qvNe19RJs6EkCkyiQjsEXzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9wuPBvl8/z7n9OgF7z4KVgFzC9EtCimrGZ9JbYGKGAlUwIh14qIC7GCMufsZCAP+DPvMUkvV4SY99xPSHSOhsMaEiOmECSMcQn0g3TKJuPso9tCAjxjJvs3MWUd8zCk+s60U++xbNMfn6Gm32nOtPiYC8wwW1IDoj0lF/gJl8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JSgew2yL; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JSgew2yL"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-39b24d114d4so3409750a91.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 02:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788774261; cv=none;
        d=google.com; s=arc-20260327;
        b=om3Cp/Pvoc95XZfVJkdwo1f7+WuxMZwuqRvu/TXbwTTuVyUKOpNqLUxSVSVsAh2CBv
         0QtfUD0PE3rsLYrMLpJjXVVNqw5bmPT+MgouBfPMsaBejjoEoNxn99T6hG31Y8PWBx9K
         l1ivHeODgNRgwm1fxENoKn8YIDaM5EH9kcz6LxKtAP5ioqlZ/YeJpkD45acdlC6F/r4F
         MLBRcc/l2JyLrO8llmvlkZLilkvjUqSVF72X3lvNaTMdCtceVfHVuCkQ9GzZcgatRuFr
         69SMAPB9yOZqFIMymIbEPjoqTRCC4gW75xW8jRbybeu8pSxSEYOYZGE0by7lszmOxivt
         879w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g/xnlyu8PQCnxo+4HJ8JoFUVnIyWkmOXZV+LXEWh1vw=;
        fh=kVt/f99Ihjy+ZhB/0psabB6+TSKXT0jJcTafw03fTbg=;
        b=m5W81buoq1/lgkuMGjEq4WVKMhmLsOC4EYb5Fun73t+JTZOmim0q4fdQG7xcmNM0Hz
         8kVhojJVP/N2Nvt4vM+ulMoxgPVcgINgQGuA+xO1z8mNcZ5Ba8RBOiiFwKTs97MrFD93
         GJc7gZurWZvLt5qY2tMSIhLR40jJk1Sc3P88/NRhxLl2qni7AwQ4jJGGwSNXTgGhfhMz
         aDVBgI0iYrWFn9Zy3S+ySJeENJ7v9K5RCVWY4xCEM5EoVnb38v0hsvKfk6goQXgRSzfk
         NmBYtsUp/UJfmXbplkFW+ZDA4U/lPFFrX4sIo8OOM057MQiLUJnddR7/nKB69k1jErv7
         Kpxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788774261; x=1789379061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g/xnlyu8PQCnxo+4HJ8JoFUVnIyWkmOXZV+LXEWh1vw=;
        b=JSgew2yLj7u0lUxFwIByIy/i5ID1FC62+yxMZCCC5f1MUYVbFWrp2HMyrsCmQD8TeG
         VNUECPVeNGPbmBqO+/zMM7N4KgSYBLlx+r72WTK42uttdOK57CSYGOwDOYFvapQt9x10
         JjdjZGW/cp5yAjovVfa66XdG/pf4+Y2F7Bp6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774261; x=1789379061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g/xnlyu8PQCnxo+4HJ8JoFUVnIyWkmOXZV+LXEWh1vw=;
        b=Y25w6WjL/CBwB40nbBnZiSbDSj6dKf1yejlgVZ2PmDqkU1ugRUUDj40Rv9xCeoa4ib
         IIvID0uzObVSs4wwmDITzV8XnmFwjlbt8eHeATJ4HVE3iws6vfhz7AVc7DGGD1QpSgCz
         OvBSIzjNdCpus6PmfD7932pn2pfRi024uB1gfyL9eiUhY0VqFPiHRVCkDOKKIY6s4/yd
         M2jwQCeYSvoBNhppxpLpto2IfsESZRL+njidWMzVkaC9qkXNMH8b8R0ZX+v05SMBg7NL
         Z3TMV/Upu3nLl0EHziEQXxDmFCrUeYozbOc1FkosVGNy2pTD607zmsoIZ2us17ctEExR
         YERg==
X-Forwarded-Encrypted: i=1; AKwUvBzP3TWJviDAEIZ9B2XrCxu4BI6TWQ+V/wKGRJx0992/LBeERymrVq1njWNYiSHMItsQ793nB8E=@vger.kernel.org
X-Gm-Message-State: AFuF++m9ZZZue42W4RI/Vh56ilmdDQSp0M7bzaRRFjypBizP00on/oBv
	1PIe5Ei+EwPK5LHtPCyMGq+end0KUavsju7Iw08kG2r+WDHi1fSlsYczCCML6+DpeFa+//raQvh
	sMrkPRV5Tgjh4HzKjwpXE5cHuEdzP/tHh4DQl9/iW
X-Gm-Gg: AYBFou09Qs9Ai6/QhYXM/5kvwiCCNKaMTXNeLB+KvcRQiJWvdt4ZXfyAxbVpiJpbvar
	n7U4N+AUPxEc+kxD25N0ofIXJE34qltjVU8qoStOMSYOv6e3i3k3j0NL0kFbV9t5yVTYWWFARuo
	1uSLW+OjyGvrGTNukJPL2eD/z+nV5njBSXBSXE38yDe/NUifnrIKYR0D3Mf9Uf6zgDPLg2VyJr+
	30pM5JRuMzZvVuubzrIWNv3GYS+OtMdBI9+p95s9pIThcOPhWWd3ETA2w60KAXlnYesBE6y+Haa
	t56a9bulSZQxwcbeoERrAaW5aakMIZv0hpzTO2WvhEG1JitEtfGyUecC2kLGkA5QwojLJewKCg=
	=
X-Received: by 2002:a17:90b:5106:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-39b260feb03mr32280186a91.4.1788774261208; Mon, 07 Sep 2026
 02:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904234401.2339633-1-jthies@google.com>
In-Reply-To: <20260904234401.2339633-1-jthies@google.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Mon, 7 Sep 2026 11:44:10 +0200
X-Gm-Features: AcwNN1WMY3fqhnicN71CEKCWOY9vaZG4m4eQH1V9NiV1awWwS6rAM01YuF7ygVM
Message-ID: <CAMMMRMd-7=hzAiMASAkgUxxG50+sNQQUQN2=dNOS_THVjDmxxw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: ucsi: displayport: Fix OOB altmode array index
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bleung@chromium.org, gregkh@linuxfoundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 1:44=E2=80=AFAM Jameson Thies <jthies@google.com> wr=
ote:
>
> The UCSI displayport driver indexes the connector's port altmode array
> with the GET_CURRENT_CAM response after checking it is not 0xff. The
> port altmode array is UCSI_MAX_ALTMODES elements long. If the PPM
> returns an invalid GET_CURRENT_CAM response above UCSI_MAX_ALTMODES and
> not equal to 0xff, the kernel may crash with an array index OOB error.
>
> Update the UCSI displayport driver to verify the current cam is less
> than UCSI_MAX_ALTMODES before accessing the port altmode array.
>
> Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Andrei Kuchynski <akuchynski@chromium.org>

> ---
> Changes in v2:
>  - removed 0xff alt mode assignement when GET_CURRENT_CAM returns an erro=
r.
>  - return -EINVAL when alt mode index above UCSI_MAX_ALTMODES is returned=
.
>
>  drivers/usb/typec/ucsi/displayport.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucs=
i/displayport.c
> index 7067f2561b84..572da7bbd29c 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -71,11 +71,14 @@ static int ucsi_displayport_enter(struct typec_altmod=
e *alt, u32 *vdo)
>         if (ret < 0) {
>                 if (ucsi->version > 0x0100)
>                         goto err_unlock;
> -               cur =3D 0xff;
>         }
>
>         if (cur !=3D 0xff) {
> -               ret =3D dp->con->port_altmode[cur] =3D=3D alt ? 0 : -EBUS=
Y;
> +               if (cur < UCSI_MAX_ALTMODES)
> +                       ret =3D dp->con->port_altmode[cur] =3D=3D alt ? 0=
 : -EBUSY;
> +               else
> +                       ret =3D -EINVAL;
> +
>                 goto err_unlock;
>         }
>
>
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> --
> 2.55.0.979.g7e5102b832-goog
>
