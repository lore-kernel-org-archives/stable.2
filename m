Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7B521229
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685490; cv=pass; b=Ahmu3PvVFoOI5UQIUcXBfbr5vLWN6bcv4QJzTXqsqpfAjlrSwBGcT0mDR+8J2Q+eaNTgloSqVhfuou8fW8XuGzccJ1DVvd548AiRhyMKfTVSpKXFNLYx0c7tuw2aipO92TvwCu6Zt707V/eACZQ6R+rpOUHJs6Gg3Kwjcb2gSiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685490; c=relaxed/simple;
	bh=gdwEoK7FYkbsV8ilbpkgZH4Vf2p7L5T3GmRfoLao/do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUq6/APiZxqyhJfmc5Po7ytlErPgupcV2HLfLQNrSOmcpj1gzvUkRhnehIEE413bBZC+RRaTNflaLtKpWw/5neyfHD54a5mozhCOat5vAvrI5Bmcs4720lrqDzHT9Kx0fkDyvoyNQ5D09LUeA6vM/gqldiu2VqYxC3A+qfKzXC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Olx30u+2; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Olx30u+2"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fbef5018so27706735ad.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 05:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790685488; cv=none;
        d=google.com; s=arc-20260327;
        b=kR9uaTfHVAtw7pvf25lrgFcdM1/uR6z0MMpIJBzD61AM4xAiqT9YL7T4w7puuNg0ws
         QQZ0e53BBNrzbvHVtHpwQ6HSvC3G51v/U1rIkx8rpXRQYuYaU0EBp5vqaTFytPz3HOlV
         WjdjBERTaMnTct+wXQ/63yOATMiXf9C+x4BwwLDJvA44QuH975FnalotYimaNMuPpLfB
         KyBN/QqDgvs2q990n3YssXpIwgZqIouItQP2/6Q2NS/Hu+XJQ5pEKJ2p7y4J/Cb5hH4d
         3UmWVVGLMiH8oyNTRx+rtLWR5dfJCR9P+HGQBHGOJnC+tBrj7AeY+gb6bTomAol1nQX7
         EFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qoWvSXu4SSqUtmIwYczgMuYDrPposdeRENj3E/8sf70=;
        fh=a1Nft4ZQuHKSuQXCVvdSNC3Lg5x3bNCurtueVqMZ0xY=;
        b=iBv7EBx1qou3a2SikpKzvBMVSojbz1La+i4T/djSAWwiq5ChwnSLDTcG+zz91Z7gBF
         Fzv5gNW4XzbpbsK/cYPnHMayo+m4Fd3htSwsQJP4gZjW4cfvTHP7LYMhB51MkWUCnhlP
         7cBuUFNJBVBLg5TWmvHwo0vp39K9MxOdzCXVnN5Gr9RwG1vpU/ZI+xEoaR/Rfe+B3DiK
         VOWb17lfOxZl4vClw5i/ZFTu4fMNmeRGzdosX1jlSlYvAN8ljW+bYu8V2R9wKEpxe89g
         hKIGqHNBRykKi60gTNVziWScm2TkHydG+b1F99f41E+OV3yw/m7SrZAyBiTacJUyQ1rU
         7IHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790685488; x=1791290288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qoWvSXu4SSqUtmIwYczgMuYDrPposdeRENj3E/8sf70=;
        b=Olx30u+2vkzdBRWUin7CaqOCLIIXK1eMdtQVJTsR8tjAyFCYBTleImUPcbU8xHqYft
         IJvxM88y17wrSm5bgv9dY2qky2XIhsB+sUjp/Lt58sKAenzsCixSWDjbkbm10HXONv9o
         j77FQ9/ieXl6w9wbcMRONwV/FqlDC3OtTW7sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790685488; x=1791290288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qoWvSXu4SSqUtmIwYczgMuYDrPposdeRENj3E/8sf70=;
        b=VbooT8SRkIp2SK0j9SozPjdmNAFakjhY7X1CwsJZigUDyzZkURqLATiik9nl8TmxkR
         1/fzzJAqAJIJJ6m9r7qiUC3S12j+X4/Gr5pNu01L3Y8xnKFvdlHFV7qXUXf+qeGKlIRB
         lMiBetFW8hxZ/gXNdnnobpstCG36ogaoCs+fTDSqDqkAAS1q4Q+zP8CQgBgbfNhKtF0F
         BeYrCJ2mTpZt+4BGZcTVY3uhZLIKUjDGF1cSH7O+LCVCmsQ3hZWkX4Ow7L/FSN3zhGZe
         Ezvc7T8ebz2YYfzps6p97YuQ//r82RhXTmp74Yq1fAC+gGkN6mTBBigBC97P417O/vDS
         xVOw==
X-Forwarded-Encrypted: i=1; AKwUvBy2JlAG6V1XzTYBg10TYftZ5J1f8Bbzr0hcU7AI+npdPPWj2NDIsR8fuV+MUzS5V1vxp5pQSwM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8xfUTnXSsfarLYlah/t/64O5vPbt+qo6bnq+bo46ZOyvbHVYA
	Opi7OimfaelHAY10R1qLciHBLQAY6cDU8QY00osT/c3QgtKvpWazUyGCBNhstZt5wDG77faLVMM
	oLzyvfJQ096RDhLiX9N5C+qbgAVdUuQuO61tRhDEk
X-Gm-Gg: AYBFou2vQGldWrtTs4NkxsfGilFYTYqsfdjTUkAf97axSPzek+kzFmMD+BJ60DkCPtu
	o4iNmtLNPZngd1Lk8vjNCse94xf2O1IhXjQfQORadfTUeeexplx2l4Fkwvt5A89qi8vt47FnlLT
	dPUcGMOQn41PnVYiYEyi/lkZ6W+X+0MbzaFo76phDyRA7A99diLDuPaCYBiLc5NKkNgXTJwoCk/
	ir/5QLy4lYw/on2TWDBdhFIHt83m5dWokQkJnjXnG6S/m830Al+psZqVk4QvwkI5gfIoKUtWe3J
	7/zLlP/LStqwRIC0oNtKer71b+J0wtiSutjXq/RNw46q7AYHVA7cTyE1foQMfTNXUlbTzmQFNlu
	cA9DlIKw=
X-Received: by 2002:a17:902:d2cd:b0:2df:9eb0:761a with SMTP id
 d9443c01a7336-2df9eb07bdfmr90906095ad.25.1790685488373; Tue, 29 Sep 2026
 05:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927021649.8967-1-cnfourt@gmail.com> <20260929010937.21559-1-cnfourt@gmail.com>
In-Reply-To: <20260929010937.21559-1-cnfourt@gmail.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Tue, 29 Sep 2026 12:37:55 +0000
X-Gm-Features: AclHuK8Kr2_e3IG10_JsHj3zc5b55EX5CFHCX9UVqeJ6c3jOq4FtBB5ZoR7AfGU
Message-ID: <CAMMMRMf_5Vgrir_PtNPhvd5HDUP=_YsLzPssR+ciKtuHzqfLFA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: ucsi: Skip CAM query when partner has no
 alt modes
To: Gris Ge <cnfourt@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>, Jameson Thies <jthies@google.com>, 
	Pooja Katiyar <pooja.katiyar@intel.com>, Hsin-Te Yuan <yuanhsinte@chromium.org>, 
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 1:09=E2=80=AFAM Gris Ge <cnfourt@gmail.com> wrote:
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

Thanks for the patch.
Could you please send v2 as a new email thread?

Thanks,
Andrei
