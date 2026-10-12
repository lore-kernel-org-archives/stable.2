Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AAE478E27
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816023; cv=pass; b=aYkM/RazTT+eFjB+TM+4Em7q7+hOZDz6vByktikHsnMAn/lRBkacuItyF0lEyYsSzBMiSR1NSWfWJ0zTqZO1Br8oaWRIJU2G09qGhHwTdWe/KYDSsa7zfNHZBxtsVyYuWN0Bhh8TOVebu6qgWZabDQKo/4WJBc4G0B6NoHLoIbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816023; c=relaxed/simple;
	bh=vyjFk+OVzX73rkv+Vf4KwdMVbobAdz3wh39L0hTuAmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3fw8CEB8xhgHBkmu4SNgI4ZrXTh5atOgk20kKOWLlsUvKxioqsAuHS8114zod9OmrDl3SFSaNwMewmdNdEhuOZdSjJc/xKlI0WYA6oAYIvJRkEfHCoyJEZ0wSqgmg4dQbMkjBNkuuUBdxXmlQUPJjdio1fxZMxDd4qgWCp4EoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYWzYxqI; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYWzYxqI"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8ab8d96d02aso14058677b3.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 07:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791816021; cv=none;
        d=google.com; s=arc-20260327;
        b=CPadyPxTkjG8fyhiVtLVSHRV1amzEr774oCRVwQ9Dl7wMyO1aFizQ+dZ9TNd/G63GK
         yB05NQrgTvD3TKhmWQcPJyCZjhhulbEMefY0Twy8cPKcAfnSWa2HZmVUrEfURsZIEJtn
         WPo+woQdzHnf9WpxTbU/vNHYWFMhdzUSePLGnL+0v4ifcaR83V8dN/+LJOJOuelqEvJs
         dN740BmxHS46cUhKYp+PVRntN+cB64Yuykb2lnmE3O/vNLG0NZDj3KHBrKlT0VyAfzV2
         yXZ+RJK5xbI34HmB65jv8LSYNeEpZ3huYCf8KXa9F7nK7j8UU+qV9ZiCUdywQ8aoDQmn
         yNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JCv8gBANZutmGTGlF/Uql5wg79snoB/nJkY2lKkKjE0=;
        fh=XN1vgKEL7eieaf+izow05I5eULOoKT1fVQwW2lsLaDc=;
        b=I94IXsPCMLbechHA5WxNc5U0szAyE/0eDarlXsWo4TcYcrn6Y1wG8FXxOLSo3B+jQT
         Xcm31R1rRDJp3DLZQ2H4dYnsL2Ey+SlzVyeL0331qIGKnZ4berPYstmIDeQjgaEi+eDN
         BZG1thfKuWlHJWmzDiA7W3Eh3oh1SNZMrx+32BWuDyNFyZaD1SzPplcurEt+kKdJyoG7
         U0iElDcxcgSHuQ+Pu9S4P4orAFf+FFoJfnWqfDzMhVtyHdRnpREa0JD3I0j/yN8rxX8l
         t//u0J9j1V14MWjTFVNqOaAm07hxTKTG2ZT9p7NxkN3EYY0Ro0dIKP6XbYaHnkVRJx5Q
         aBrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816021; x=1792420821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JCv8gBANZutmGTGlF/Uql5wg79snoB/nJkY2lKkKjE0=;
        b=qYWzYxqIFGs3ZcdrTMmsoWwJ7uja2OrKnsz9Hwne++42sA9Kkc3LTKJb26bHqSrzRf
         526eQ7aRiBtH0yqR8VoaaOsoVX602ReVnQVj15aOH7L7XzGo5Yu6Z8gclMxgn399S+0R
         vqJnKYI+L5S7ihpEDfDYum+ttp5dmKeGJLlabUjSnjI0AP1dLpNO3EbZ3NPXkwNLooSW
         yIzzPDbqDT9NCwww1bmsGLcoGXLMA91Bjk0AHkT7Wop7998l00FF/DYTjFROx1BYaKsy
         gYftlevQY36i54UMOZQhMyzTuSLgG6pyjQDrAst7L8IQK2H65u02XArTiig8DHZeb3pA
         AEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816021; x=1792420821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JCv8gBANZutmGTGlF/Uql5wg79snoB/nJkY2lKkKjE0=;
        b=uZJYPAYc3KODZh+9X/pFXfYj22Ad0WFuAQZXFMR4nmktOu81V01LBI7GKBXLFxFJsW
         WDDRZf6E4KO2B6bmRgYnXquRlwgiKeBoTqjKSEGcUSApkivSIN3t6hbbSJeWMifnKAki
         07BUczfj1UlYT+x8zudkDLyQ9K40YcvqACUy+D8ZvaTKviPCflJA+dCDKByDbEuJU0m7
         3zC9r9nNOX5XB95hANx8ZLXZV+SGCGPRdRzTal1yfohc3dbtPyoe44hkVvyOJdzcyJ6G
         O7rae87j7QI3768kXDmwjuwl3aBDDwyJd52sOWiqXYm/lbIFafYgM9sjH0B2Q6S9rwgL
         bgeA==
X-Forwarded-Encrypted: i=1; AKwUvBxyTXyrjlv4w8kLV0oNkT1qXp+TUFBdJ6J06JslplyWa0pdAdraLMXYY9MKxHf9eKYaVBqO1yE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKz34M7TAT/RAIWIiKQqf9GBXkSF0Qr9glq91vOs9Kfde8MNOWm
	DE/FeKRRmrDP/qG3oB2XD6ufD9oQRkdP/jfg2tiFl2EiswDUooW3RnyKpSHWvkpvw0M44z4wm42
	ZKRpwzQFh//IbSP+EJQERhbLsNP2lw+s=
X-Gm-Gg: AYBFou10R56fmw6alQv6/4h3ZlJBUqlj2HePnRCJGNBaqnOn/DkZEAFOASIYzZoNDky
	t4DzMSs9gHDsDg6MODCQJBfHI9xmYA3PVRHg5fTmguq229EykeEs8jALWi+NB61ofs78xWVKE9Z
	mgWaYaWrwefUhIiCmkaFMixh8RQvnyo0iCCo73XIvp5ZpfP0uCLp+Ma1f3v5jZtvAsAWDKWJ6N2
	dGT/PxVhiAmCI9Xq8EhMK08rC3u4aq6qvILvpHMEOdiehV1Gg/4epcj5f+pWLgvCzt3a5tV5myu
	OllqePEDaq0TaW5uav37TQWeoNE36SxQ+FQL6ctajXIswZuQ3iCAQgHNLWPnRV7227YFUV/Gmv6
	eHhia7GX2tosgiUY6GkYarKHLRJfWTSWI3hUW+Rj9zQ==
X-Received: by 2002:a05:690c:ec5:b0:8b0:a5d3:7198 with SMTP id
 00721157ae682-8b0a5d37935mr8627877b3.47.1791816020580; Mon, 12 Oct 2026
 07:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012092017.3275428-1-ravindra@intel.com>
In-Reply-To: <20261012092017.3275428-1-ravindra@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Oct 2026 10:40:09 -0400
X-Gm-Features: AclHuK_W5r3-kSFq8ZOrp8v14qXeljv26kcEUvDpgPt4bofmiSEXo2HZBIzWGUA
Message-ID: <CABBYNZKHL4t+jfuLJ=6N4xge-XNYnqrsdJtjMRDo2fcubbuLJA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Retry FLR on device lock contention
To: Ravindra <ravindra@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, stable@vger.kernel.org, 
	chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ravindra,

On Mon, Oct 12, 2026 at 5:17=E2=80=AFAM Ravindra <ravindra@intel.com> wrote=
:
>
> Several paths request an FLR asynchronously, including S3/S4 resume,
> resume recovery, HCI reset, and hardware-error recovery. When a request
> comes from a PM callback, reset work may run before the PM core releases
> the PCI device lock. pci_try_reset_function() then returns -EAGAIN
> without attempting the FLR. Other FLR requests can encounter the same
> error if another operation holds the device lock.
>
> Retry the FLR on -EAGAIN. If all attempts fail, clear the recovery
> in-progress flag so a later reset request can try again.
>
> Fixes: 9c36951474d8 ("Bluetooth: btintel_pcie: Refactor FLR to use device=
_reprobe()")
> Signed-off-by: Ravindra <ravindra@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 3a555aa50c87..251dd4e2ceb4 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -3743,7 +3743,7 @@ static void btintel_pcie_perform_pldr(struct btinte=
l_pcie_data *data)
>  static int btintel_pcie_perform_flr(struct btintel_pcie_data *data)
>  {
>         struct pci_dev *pdev =3D data->pdev;
> -       int err;
> +       int err, retry;
>
>         /* pci_try_reset_function() avoids the device_lock ABBA against
>          * btintel_pcie_remove(): .remove() runs with device_lock held an=
d
> @@ -3751,7 +3751,16 @@ static int btintel_pcie_perform_flr(struct btintel=
_pcie_data *data)
>          * pci_reset_function() would deadlock by trying to re-acquire
>          * device_lock here.
>          */
> -       err =3D pci_try_reset_function(pdev);
> +       /* PM callbacks hold the device lock, so the queued resume reset =
may
> +        * run before the callback releases it. Retry after that lock is =
dropped.
> +        */
> +       for (retry =3D 0; retry < 3; retry++) {
> +               err =3D pci_try_reset_function(pdev);
> +               if (err !=3D -EAGAIN)
> +                       break;
> +
> +               usleep_range(1000, 2000);
> +       }

We have to make our mind here, either we use pci_try_reset_function
and gracefully handle -EAGAIN, or we don't then we must use
pci_reset_function which awaits for the lock, retying a couple of
times with sleep won't solve for it for good since we don't know how
long it will take for pci_dev_trylock to be available.

>         if (err) {
>                 BT_ERR("Failed resetting the pcie device (%d)", err);
>                 return err;
> @@ -3817,6 +3826,7 @@ static void btintel_pcie_reset_work(struct work_str=
uct *wk)
>                 enable_work(&data->hwexp_work);
>                 enable_work(&data->fwtrigger_work);
>                 enable_work(&data->mbox_work);
> +               clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags=
);
>         }
>
>  out:
> @@ -3841,10 +3851,9 @@ static void btintel_pcie_reset_work(struct work_st=
ruct *wk)
>   *     in-flight one (whose recovery will reinitialize the device
>   *     regardless of the dropped trigger's variant).
>   *
> - * The bit is cleared only by .remove() / re-probe via fresh devm
> - * allocation, which is the intended one-shot semantics: a reset
> - * tears down and re-probes 'data', so there is no "in-flight"
> - * reset to follow up after device_reprobe() succeeds.
> + * A successful reset clears the bit through .remove() / re-probe via
> + * fresh devm allocation. A failed FLR clears it in reset_work so a
> + * later request can retry; there is no in-flight reset after failure.
>   */
>  static void btintel_pcie_request_reset(struct btintel_pcie_data *data,
>                                        enum btintel_pcie_reset_type type)
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
