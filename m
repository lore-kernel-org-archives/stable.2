Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820E63D300F
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857563; cv=pass; b=YSmOq1FPIoLhuCQZucHc+ZvyUlVpG3aBJd6OhjOCU4CYNtjONc5fdUfTJ3hduiuDopqIHcUzVr4I00J8r7lSE3LPiiyBJGSAoasmxhIzFMvpyYUnY1od4FOBIpUR4dA7UArud1go+nDv1pZTigNDmYZ/StGZgxhhjvmZU+roZjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857563; c=relaxed/simple;
	bh=x+RqhDEFCJlDmSwDf7GB3PDW2yVZPJ21uczV8t+z28A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrrWECFd4mMGvaoLGMU3mrYKbn8WTrfQMAUSvqu4I10jN1hcHbIIpTxDexzD4i3DNHPUoBeXGq//wAYQZFJDg5aHiYCXdsmPBYnYsjbpm5LwMxbE42AQkto//if6H1n9zXgwvDEgVBZAAcBRQlfMtAbn/pfFm2K+kz3OgiwLw6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nq+DxrKU; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nq+DxrKU"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a4c8262465so1866869a91.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 05:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790857561; cv=none;
        d=google.com; s=arc-20260327;
        b=Trfph/S83MdcH+wiCXdYsSz7YiUvNKsGJoVgWi9tTtksoOfdefGBB2FYIzLj3OQjB6
         KGTscB0PwdnTFdINKUx9Z5hqOtaTeGynHPuNLs3J87j5RMrbR7hkhVLjcoIWIBnpPrW8
         2jQaAEb0sfdeKSXp2UeotGCJJLyWulESLv/WP8CUn48c+XGnpaJi/LDhgLqqT90fF2Ak
         w05Pz78A1s6t7sKA5Ofjw4aPQIBceAlGAU0vyuCcCiv/jsaBQD75oJgRaPN20v8SAwjj
         r7MQ+RY7omaoDN/TPVzwS41laMObqsf43OSMButHqmZyllJ/WokgHHVMgsurwSLhfUVK
         RVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sHNsjDTZpfGR2H1l2JsSr6KfRDIP/MhvrrYNRy/u2yY=;
        fh=X+zQNxtRvT3X0pbufRuaXkC/QNTu8dd2iZgyjFBiH5Y=;
        b=AullT9yBXbqGU4JHWUbSd7ysKyYH+ZaAHp0sFKHxnIkR+YNLb41B1afQZrvKtEjzOt
         VEtzgyh46EDJbT7noqea5tZ8e00hwNxjaIGEejIrrEda5lVUg2oBkQLnM7o/+9HbcmgO
         Ag8mBQHDnEbl3wByAfuVOIncvHyvp0SgDsEsjmvCIp1CgRGuU1tKgwO5nD4osmJZaHk0
         tKxX45dWJp/QX0rPdrwz2g4kVZMpLltzSNgQmb5Jokx2bQ/E8/E3JcGeAYOJ7vbGJ+2R
         fn4rljWXuPlElScrYg2kb82eBH2O/qh22oTf5sp2FqJO18V4+SOYYu8xoFL4zqUNluk/
         ZZRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790857561; x=1791462361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sHNsjDTZpfGR2H1l2JsSr6KfRDIP/MhvrrYNRy/u2yY=;
        b=Nq+DxrKUGKvNs17iv6Sgu9y/wyowD8TUW2b8lFLAfbZ6EKrhC3y36R3f4S0FWC1l9h
         HgB4JDn6J7yeS5Zf+HcChijIPxP0YhzWy3L8u1DKpaXSEhCe88XuuTzo21cAgmCJ0E12
         5Zj2+N2vg5ysSbyGQKKfAO01O1hYSX7ogzA0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790857561; x=1791462361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sHNsjDTZpfGR2H1l2JsSr6KfRDIP/MhvrrYNRy/u2yY=;
        b=Nc/uky1JQaCFEV4MQcxJNmiy/J9QI0uqbJBxkxxUc6kGQNGHM2oTsTGBlZyTifrBOp
         /YCaXgfskxXDGUNW29RdbnvPAuMNnzkhPXf4CljkbsQB4NEIl6kV6QqTkg/FFxd6esSp
         FEWJyl2qs7X56h3Z28aPril1z0RlCmCvEg1pOkXNL5WxTzgXcA5F1fcKhdr3Mqq5oBoo
         RjFaqgxUzSCpOa8TH+uGOeVzMB5CV3Udk3b2pPOQTt51/t0HYdhR5wWL+rz8P4zzPhcv
         iNaQtnRNj4i5FigtS447SUcj/fueK+9QF7haq8T2XR5dS6C0A+Fw9M2Kuj1I++y0LmHY
         1o+w==
X-Forwarded-Encrypted: i=1; AKwUvByUPFtuZLut9YKpxnazWPLrzaXnhrzclpmh9c/2zlo1jLxBXWpyTOjaeDw8TYlh/HnpIoKrFoc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsE71GTsKg+EWsVSRGA8phluszEh67kb4sK30/Wn5Pg5srOO/f
	WzBl9I3Q8pTlX3TZSfR1Hv4JWwBnyEGE6deGJ8xRPuJWE4WiubsVpzGCW5k8iTlzxnq7/7JOZ6b
	F4l3Zzh1litYrVHTkOfVbUsNcQOz8BnK5g0HzK8wY
X-Gm-Gg: AYBFou3DZmwYLp+AtFEb6bv+/iHC5YQ2bfKhmNdaRNFpig8Dbm7GrQLHKaIdyaDFBzX
	AdWUkPH78Oobaftkp9gWPjiz8g8x3UyycmuTe0oTQT4IquPDfrIx+EK5gsX3wJ4hSdA3lj1mEoB
	mUbrVYL/W6kzw36lgmpOdUy7ywPXUuqmWRk96QW0VnileCA7nVJerr2DRyiQ6Jwq6hn/4Mw/oSw
	VZE8QK3yAxUz9BMSjfqXxOmnbRREKwj3qU/A/lRX8eyjFo6HiLHK6AeH7HSSQBBF1zrFpM5MQd5
	+CQH7lDXvwP99VKG3xCZ19lvLM5xK9eHGJCUi4tbMHQULpGX/tNtDIQomhIzA2rPCrt242m+y1Q
	xpdA1oOU=
X-Received: by 2002:a17:90b:2787:b0:3a0:bbd8:5ba7 with SMTP id
 98e67ed59e1d1-3a4d19263b8mr3982449a91.62.1790857560613; Thu, 01 Oct 2026
 05:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930234611.468765-2-cnfourt@gmail.com>
In-Reply-To: <20260930234611.468765-2-cnfourt@gmail.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Thu, 1 Oct 2026 12:25:49 +0000
X-Gm-Features: AclHuK-BxU7MmUHAcZP4PHaPh5sL3Kfkf4dW_oEhBdzZNS6_OoOhRdYuvai3_LY
Message-ID: <CAMMMRMe1Nph0cOtVsJcKGJgsnNarj+9fEizMh50RqXZP+cHoPQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: ucsi: Skip CAM query when partner has no
 alt modes
To: Gris Ge <cnfourt@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>, Abel Vesa <abelvesa@kernel.org>, 
	Pooja Katiyar <pooja.katiyar@intel.com>, Jameson Thies <jthies@google.com>, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>, Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 11:46=E2=80=AFPM Gris Ge <cnfourt@gmail.com> wrote:
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

Reviewed-by: Andrei Kuchynski <akuchynski@chromium.org>

> ---
> v2:
>   - skip the invoke of `ucsi_altmode_update_active()` in
>     `ucsi_handle_connector_change()`
> v1: https://lore.kernel.org/linux-usb/20260927021649.8967-1-cnfourt@gmail=
.com/
>
>  drivers/usb/typec/ucsi/ucsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.=
c
> index bef3f9b71d71..c392afdc27ae 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1519,7 +1519,8 @@ static void ucsi_handle_connector_change(struct wor=
k_struct *work)
>
>         if (con->partner && (change & UCSI_CONSTAT_PARTNER_CHANGE)) {
>                 ucsi_partner_change(con);
> -               ucsi_altmode_update_active(con);
> +               if (con->partner_altmode[0])
> +                       ucsi_altmode_update_active(con);
>
>                 /* Complete pending data role swap */
>                 if (!completion_done(&con->complete))
> --
> 2.55.0
>
