Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8E2F549F
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638996; cv=pass; b=E5urFIwnbGgmISwn2nf4T2cdTFmq/Vd9yN2ruqa9l0joKm/+WdNWjVk0tzSDxY5TGK19TXzkoNLUkhCFd6ukl5WZESDvTIRbPJ8glxCho9uSkDIiSbIOd83ZjhaTN9CQSUecURgg7Cs8gZ3BcGFud5JE7CCzifkaYaY4cY4qXLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638996; c=relaxed/simple;
	bh=4bs2P+zoATtx76DLQEISYzQnJrNhzV0m3g4IlWokZ2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mi1Jcvr3YyycPfvHj4EYzyCyTuNr+ThmoH8pZim5tR193hfovhdPvnDabUnA8PTQL/uI1WQ/9YQBLe6OxEtZmCgKz/R2MlvDu7bD4MJHcFPtgTuM++VadyDrT4mnGQ/gUQXKjnOvnx7MFbxUfCzUtcUQgP/Y3lFY3xpdtZXwaYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENDesf4T; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENDesf4T"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15b33f7b23so52916866b.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 16:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783638993; cv=none;
        d=google.com; s=arc-20260327;
        b=iOFf2ZY3k36GcabONAt6fRJwi6bMEldpqaI+IieAEsWuCy/Xa7UvkKvLHsWRCoDOhO
         92VLRsYeJIjju6HpbfVa5ZL//4tfFoiqlEcc3yGC4/5tY+ky2RKOYogQBCmyKzX+Mq8u
         N47Yxk/QscAb7BmMuyKih1Fl2SU2mV1jDU7H0/QEiDixiJ7+srxhscltGPS4QQwwvEDC
         c91nt7FEaWmZKmpilNqREUYMEWRz6RXpMxAJWXUfw7AtXSdMgTL/a7TTWu7sobTpCnmZ
         BIx54A/UrFPAOLs0txZYXcyFBzmRwP9wYzP9rqexmVHdgzysVO/BmPf6vUNKmWAZohpF
         gBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4SiFdHkjry06BtTFqenSVBsf5DaH0RuxQ/XWFS2jU4c=;
        fh=P/O+JNE7Mwff4yw2FDrv7g8vF9nz03aD44il6IpjGR4=;
        b=pNTWL0Pxm1inwRrojhkd1huOY15kVs6rnYRDbgaq1cVL/Aud5U9W5VP3WWIas4z0St
         DDB+GSqWeXBn8MIU9hshUgVMiK1Z1hEGu9sLAGzg/ZgP1PFejPhhFqxxI7+R/1UNj3dw
         j+PNoiWuruN6CNXMnonAPfplBL5bNebErQevvKLRI/kfQoYoJ2iUM0W9eLnHRxdEC8C1
         ZB8mrzp4SpiCM67IbIsGSoFCXgxiis7vhaYfk4Kl2S/XhE1ayw9ER24Qfhi/eb6LSDA/
         +aV0ECCqr1AKNbHjMZdmDkbieRjWKMUBQynpT0Mv6RV5jzKMbftjD62k0uz53EPPa1mp
         wrpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783638993; x=1784243793; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SiFdHkjry06BtTFqenSVBsf5DaH0RuxQ/XWFS2jU4c=;
        b=ENDesf4TQ3UsKku/SX1/uI2SaG9ylW59TJFwZCs75rFij91nbPKL30JIbzmAgRluCt
         kvzBBhTd4WPRLIQbG8A1/PXybsrGkNATr7CA8YW4dqFwpdM3Oi3WIoZBQlhRWdenYk5f
         9JOAdLmZQPGLJWurXke0b4a1pXsXdB3ifTPRR8+rB/t8EjKu4+3wRxZDQwIwUo2LeFUm
         KDcZn2qU2wfiHVmWNQA/TAUMHCsktJEqeI0k4tmpFaxpfpgo2qYjaMD8GJ0jxR6iu+Fw
         2Gmlm7k2svVkUlrputsjez87bi/d9JGLJ9ANhONqeSNIM68OTpm2NPPWf9k2wm2RK5UZ
         3z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783638993; x=1784243793;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4SiFdHkjry06BtTFqenSVBsf5DaH0RuxQ/XWFS2jU4c=;
        b=AXlh3TzedvQ2HVCWR/c5G7fgBe6M7IX7Eh4lWckRYr3DQ0pyYFayTfxYmkMQelpN5X
         OJFxrGST2xbOYSfTYSigu2UbHHMdOUKS6udBC4++38vsJHixX+WFDy8hlTzFmykiRDWn
         TbWPWmyatE2jBDpLNP+wpIm+FtGH3bwTRPuceUmKne7K3JHh+CRa7egExF0gaIQka9hy
         XTXgS21mx2iEuvt+NOjnxifOgw6ttVofibyErq+LClBhg42WyLMYrcx7VYjQMIcdKzBK
         O3Izgk81mSkvy1fL574QFO4pL8zqx/xEgxJE+LCQ0xnjJl86D86zbkzC7Xr1Lx+zLaT0
         wquw==
X-Forwarded-Encrypted: i=1; AHgh+Rqmi3oNWMNu/fFXWqvgRTsve2jrGTbnm/6kYdn9AlmqVkpzRZvPtNf5lo/dL8EOQsAQ2NYjrQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvGAFmWkk4n+qXtygxLPTf4FpRoZ/xtdeyqQbFr9iFqIugO7bp
	GKzdRqcK0jQXKpRPT3pAcCl8MvQNEt5536kmfNlESxrl19aazccNnNBWlZInL0y3rcUSObjUyVu
	l7tfKgUzQg69cDrHF2aLr16iIWlHfBKA=
X-Gm-Gg: AfdE7cn5m496TFoCMy0RYz0I453ZTscbT5rCltmzup5RotLDEHxvjqk7HOV/YDH26Gz
	NTza06QRxe4FrkaIbq6i8Amy1Xu3Wd+Iuc+sLS5KGw6f3SN6T7sAdTj2rUIMivO21uDWZkzVnTc
	wBAxCAE5Thx27ELUFoqY6WPGP3tY48wbYjeafKcEUN6zV0EuiSBmkDCDerNUfBxstim0sC+EoNn
	ot6EKPPFaBdK6Dhs3Qs/Rx+y+6aEPKCe3iSFdDH2NwzrlR6Z8MT+F/S0yTVQmX9XLBB7d8lh879
	JM4LCYBF4seAk4cvrAk49vPJYOuRBvIiML0QFVaBiSMs5cA=
X-Received: by 2002:a17:907:3c84:b0:c12:5c08:279 with SMTP id
 a640c23a62f3a-c15cdec79bfmr369289166b.1.1783638993079; Thu, 09 Jul 2026
 16:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709095006.3683940-1-prashanthkumar.k.r@amd.com>
In-Reply-To: <20260709095006.3683940-1-prashanthkumar.k.r@amd.com>
From: Patrick Oppenlander <patrick.oppenlander@gmail.com>
Date: Fri, 10 Jul 2026 09:16:22 +1000
X-Gm-Features: AUfX_mxUiVRzHTwRrTyEh3pN0V9WkIRo5NwoajH-PlNaUNIlsMVuVzVYktZyTzI
Message-ID: <CAEg67Gk9zaFd1KZaffy04VgrRb86TnpDfBtH4Z_jkqQG9bOPcQ@mail.gmail.com>
Subject: Re: [PATCH net] amd-xgbe: fix MAC_AUTO_SW handling in CL37 AN
To: Prashanth Kumar KR <prashanthkumar.k.r@amd.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"

Hi Prashanth,

thank you for addressing the bug. I will test your patch on our
hardware next week.

On Thu, 9 Jul 2026 at 19:50, Prashanth Kumar KR
<prashanthkumar.k.r@amd.com> wrote:
>
> From: Prashanth Kumar KR <PrashanthKumar.K.R@amd.com>
>
> MAC_AUTO_SW (VR_MII_DIG_CTRL1 bit 9) enables automatic XPCS speed
> mode switching after CL37 auto-negotiation and is only meaningful in
> SGMII MAC mode. The original code unconditionally set this bit on
> every call to xgbe_an37_set(), including when called from
> xgbe_an37_disable() with enable=false. This left MAC_AUTO_SW=1 after
> AN was disabled, causing the XPCS to autonomously switch speed from
> stale AN state during subsequent mode changes, breaking SGMII speed
> negotiation on 1G copper SFP modules.

In my testing this was breaking negotiation for all 1G SFP modules,
not just copper modules.

Patrick

> Fixes: 42fd432fe6d3 ("amd-xgbe: align CL37 AN sequence as per databook")
> Reported-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
> Link: https://lore.kernel.org/netdev/CAEg67GmFS0Q4oSZkz8zWdOzckSth9_vBPiOy6a7-d697C2w2Xg@mail.gmail.com
> Signed-off-by: Prashanth Kumar KR <PrashanthKumar.K.R@amd.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> index fa0df6181207..12770af031eb 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> @@ -267,9 +267,14 @@ static void xgbe_an37_set(struct xgbe_prv_data *pdata, bool enable,
>
>         XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_CTRL1, reg);
>
> -       reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
> -       reg |= XGBE_VEND2_MAC_AUTO_SW;
> -       XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
> +       if (pdata->an_mode == XGBE_AN_MODE_CL37_SGMII) {
> +               reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
> +               if (enable)
> +                       reg |= XGBE_VEND2_MAC_AUTO_SW;
> +               else
> +                       reg &= ~XGBE_VEND2_MAC_AUTO_SW;
> +               XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
> +       }
>  }
>
>  static void xgbe_an37_restart(struct xgbe_prv_data *pdata)
> --
> 2.34.1
>
