Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4811E481FDF
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585274; cv=pass; b=Kiwh3nBIGljI/cvSFa24ydBkNk3lXIA/wNXhEjRKmELmex5GF4Fa4RIyxde/x7JE9n0JlPijbwYF+S90W8fTMp+opiAj+gVagGUlKIrWIvuCyQQjvUVboTG7bXYdoLqAFd0CqdNu7/MQBlyg7Lc1OsxMYyG2a4THmulJ1fylnL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585274; c=relaxed/simple;
	bh=dJKpOVv6fqiFc8ddNiCOZUDl7GePNfYcxXC4eyDXn28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMHu4nl+fyz9KLL7eqcwl3Mo5kcqlwsXtcux3uk1YsK1KJfu3gFLhlALFEz0z5PCcGV4zC8elffv9KYQ4MeTbtr+rWLroTpAqmPg0PCbHfMQ+VW9kFJbpMkGQLapc/3qN7rBCILUtGlC3+9toqJPMsrF3mHadEYw2o6X1UHJWkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kYHDT28z; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kYHDT28z"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fb334e72so10623655ad.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 01:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790585271; cv=none;
        d=google.com; s=arc-20260327;
        b=fj0TlGzZ/ZXrCmU3ByFlI6qHiBAuoDAR+o7f1xtlNg+krRgnAJSgojs7ibParheRjE
         j94EvwjZrpR2mmW6FUr05BmGaW+3H3Hpl49bNXqdQIrclHJTtMk/taxu0U01iXo1ZuU8
         crH8qLe/T1cfRiJL70pZLTBj7rrUX0a9T3P6k3dJPiZNQrCuXHshSqzGuUqJKS7JHp1J
         rcvVL1QWZ9d92zrVF7hTk/1yTj4XtIEalClo0h9jl0vviarkSzukFaf/TzwqA8H5PA0Z
         8VATmtiyLSCz4aGRilOPgssrcJwo2RyqahT2AqaumAeB0hLiagx8+Be/DHgDHXmnf6H9
         pkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mYUWucSS/+zmzWz3eV15/EjWdNuEkuuWYSgDXuT5k/Q=;
        fh=kMdLpUlB3P/xClczMh9hWfDTaU71LrdlTlSp7/bBAIk=;
        b=DYG6W1MTAmqO2P/kWHm+zUh5GTr50Y9r9MV41SfLwX3PjhbVEe8O4opmcyPOcJVuN1
         9fcm2IAxpsua9FNkZ0cjGxpol1aAHuidt/eANDhSwm5GTw55TFYuvCHv2SrIMYMl8klZ
         BC14q/0fbqGnLZ4DTaQhVPu/NKpBgaDvAbVxjkm0GddpLaY4pf707TwJQURgDu35G+CF
         uy0B0LUp6HNLFEn9+FzntF/XeauOcvutV4EhKU1xNK7iMn3T7rVyMGUI7tCdvDCTay/j
         Y7QCUYKny58j9alsiCaH5i2raiVb6wOl4A8a25W+JBqq/bxisAIySjiRqeWw8sTFN6Gs
         xKmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790585271; x=1791190071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mYUWucSS/+zmzWz3eV15/EjWdNuEkuuWYSgDXuT5k/Q=;
        b=kYHDT28z+Lf1Zv2PVtZwV+bex6aVsL6C46lBcLxOJEAUAzRQjRdHqte6WC0N3k4mDU
         DA/XrwMMq8a1udP0hcoFnlrQaa1GQ5jomydyXeaNhgHJs4MuWa2OH2h0Rzit9QyjTdc6
         X+KCWkOeCEXJ00EgyTL7rWhlmt2TuP2OzIaVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790585271; x=1791190071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYUWucSS/+zmzWz3eV15/EjWdNuEkuuWYSgDXuT5k/Q=;
        b=AR2FBpDpuugKCqdgyPvzMiw4OKc0QBqHJqBn457KcAYqAEGUGpEEXRD3ovTv2K/9YJ
         TxPzFZ/I8xfSw+nqUK/oPLDTpGLvFNZdo6PEqitjfYI837UV+z8rPDRIH0QnxJcSwSn0
         wTU5NQhQdk7tCuEkokpcxAFNg+/QSemML0+98PdElx7i0jECC0qQBgb+tlSjqXhVsIVr
         VRdIdSJanE7NJ0plliGh4zSePVM2lpkos7Rx0VgHNdGBeKxPiXnE7CtLdrPtK0Xxg92W
         ZfJFl9ii+BeuiWmntSxW7SIrrJ+nc6qCCPH3D5Mtdf2eqtcx26pCuf5GEvwAmfpEfYSI
         g9UQ==
X-Forwarded-Encrypted: i=1; AKwUvByhBrFe/vTXSES0msUpjpifoFAFynVSzXHvKt1KFzrRefw/PCkfKtX5mNtJ7zhfodTfZm69pdk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4xHCLb/YoKo6yIjsGYb8ZRGtTR938mf88eQahK3obg1tzaV9P
	AVymj8N1WDdjeLOGy5pcvb6cCmSaZv0tEPQjZn+WKA5BCVncsTX2f/09QS+UKvIm5+E/oH/wTdG
	LrTmw61GYcxLwRA70fqj0BBMG8MD5KDaxT0eARBm9
X-Gm-Gg: AYBFou0KLf0aJjJX9vXa1lCHbt4secHe7rtJe0Q68Ii7R4et4RRKaHeXccNSUkQG+bQ
	mS0up+h/J7tsbqVVCj2ydfqolSzTagZupssEUdSO2gMgRDGOy4vsLyEBbBHL8//fRMvmFTyDh9G
	V0BeamTjaRBX2jpzGyPFEYnkBzDrS2qlk6Cg7En+AEDYiHwW05e8MtwKgm0GWpKZ7IKA69XR0k+
	/qBBBcOAjZWx+Vp/egNj273wpxFTwROxby/2/Tgns01CAREWv92y9qfqs3S16nRxOpR8QdvdVO5
	Bwxm9XARdLLfUWSjZ5cpHb0pclb2+59A2sL2plZkptzBGBxA1Q5N1sSHX5LgcClOfQiDGvqXVJZ
	TSag/ZPU=
X-Received: by 2002:a17:902:f549:b0:2dd:c053:e662 with SMTP id
 d9443c01a7336-2df7dc37080mr103063685ad.40.1790585271422; Mon, 28 Sep 2026
 01:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927021649.8967-1-cnfourt@gmail.com>
In-Reply-To: <20260927021649.8967-1-cnfourt@gmail.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Mon, 28 Sep 2026 08:47:40 +0000
X-Gm-Features: AclHuK_CwEL7lxywAL9tW9lf7X78Ed9Y6yHTJv7brK-cGmDSjgzxO9Ta_DmbBfI
Message-ID: <CAMMMRMeX9-r_coX1zbUNoMGU+GUW56o4iY_jfyE5_ovFYs6UCA@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: ucsi: Skip CAM query when partner has no alt modes
To: Gris Ge <cnfourt@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>, Jameson Thies <jthies@google.com>, 
	Pooja Katiyar <pooja.katiyar@intel.com>, Hsin-Te Yuan <yuanhsinte@chromium.org>, 
	Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 2:17=E2=80=AFAM Gris Ge <cnfourt@gmail.com> wrote:
>
> Since Thunderbolt alternate mode support was added,
> `ucsi_altmode_update_active()` is called on every Connector Partner
> Changed event.  This made the driver send `UCSI_GET_CURRENT_CAM` to
> PPMs even when the partner had no alternate modes registered. Firmware
> that does not support the optional alternate mode details answered Not
> Supported, which produced a spurious error on every partner change:
>
> ```
> ucsi_acpi USBC000:00: GET_CURRENT_CAM command failed
> ```
>
> Fixed by skipping the command when there is nothing to update.
>
> Fixes: da87d45b1951 ("usb: typec: ucsi: Add Thunderbolt alternate mode su=
pport")
> Cc: stable@vger.kernel.org # v7.0+
> Assisted-by: Codex:deepseek-v4.1-flash
> Signed-off-by: Gris Ge <cnfourt@gmail.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.=
c
> index bef3f9b71d71..71b28e4df470 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -360,6 +360,15 @@ void ucsi_altmode_update_active(struct ucsi_connecto=
r *con)
>         u8 cur;
>         int i;
>
> +       /*
> +        * Alternate mode support is optional, and the PPM is not require=
d to
> +        * support GET_CURRENT_CAM when it does not support alternate mod=
es.
> +        * There is also nothing to update when the partner has not regis=
tered
> +        * any alternate modes, so don't send the command in that case.
> +        */
> +       if (!con->partner_altmode[0])

Should we move this validation into ucsi_handle_connector_change?

        if (con->partner_altmode[0])
                ucsi_altmode_update_active(con);

All other call sites are already guarded by this condition.
Besides, I don't think we need that comment above.

Thanks,
Andrei
