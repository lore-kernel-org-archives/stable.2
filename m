Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795640624;
	b=CL5/0qNMoEUc+ncLM+XIS4d2hhBmv4LWai/qiR2ehtemYE/SVEPscxX2wUmgo8JGWm4z
	 JrPOzlQtqdqUl9cM4+bekF4TYGUi0gK8DZRUotrdW4tsfVyFvuxFRlm0Xe79eAwve56FI
	 muStwfho05sf8CBZs7Ow/xqSHWqB9m4a1grdu/ZwoT2Y2SBep4184i0VZz8K7uu1I+yPV
	 DoL2avDjoim6v4vMIKL2Rr68+2vaYsntwWAw+66ERgypYZIGnTI9AddpdqkwyOIGPM7+Z
	 NqWcIukhZs/28+qOZOeWO+c5RILMXMEKVTNGqaw4t13e7CaH+tgCNvHK/qAuOgn9GAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=g8oo3n3BAcC5n/86IJAMCc4c54L34G0M24e5RFRNyIo=;
	b=wSMdEpisOSdKVj5fhbOlOPdRAn4SlUHqO86k+HTad+ptVwIeFyPktpHVE9wNR/f+nkku
	 BFtUWiehlVO4VkVL63jkoPrSk5j4jn0YicmkrXZJJavjTJZwEEbrIEdHds13ZGUtGI3Vw
	 e6TMzEEJYg9k0zJnhDK0rzKFsoBaz1r6IQq06oNUgVigKb7BFMxx/ebJ4Mc5noXBb9RCD
	 D9Tnnxiqi0Vd8yexYHcMf75ZozjpRrRLxq8FN314RcrM2uCgM+dBQiKL3q0kdQiWjykzS
	 Qjn9pVunFq+S0gZj6NXQms4bNBZhhcjz6Ic1Yt5OditZfRfPFrFfj6/xckoeicnAP9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KJxP04gc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B8606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A4B8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KJxP04gc
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6bab377105dso4919475a12.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:03:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795640622; cv=none;
        d=google.com; s=arc-20260327;
        b=joUqcxPE18tmR90iFpS22tLc1Jz+cE00kxvbKS1R2opguvu1wcUuZLVk4weUF1B0a+
         TXYtDfkOmJlxmZf/T35VZjyXMXfG5NFb7HA/J23JH+gabmpBqPbLdnv+oW3MnGqrcwOr
         1v5e7VVgHTsI8nGMViKXIOK6uVgCLJPLzVrvQ+WreypQOMh5HVcBxKuRuHL0X4z71Zho
         feVFMth2MK/XJ7d53kscpxTguFohjPMxxes5hY/SbjoE7sbirXSYy6SjBQIdNolJfse5
         pviCoAAG0BKPnOPVOb5BbE609yx4U6AeHW+Nzj42b391w3X8N2bTRF2lUk7gO3MMvOE1
         F1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g8oo3n3BAcC5n/86IJAMCc4c54L34G0M24e5RFRNyIo=;
        fh=zhdGuBGFBMbpe+hC0VskSLIRsP5lA5oluKDft4EHURY=;
        b=T36XClMHSvlpHtXtSwBmb4ebr/B4WnBsgkUxBq8VlcipiFxmMItO1qUtES4dzzyYGX
         uwUQSv+PCNsVnbIR6eRJCdhOViBHt8ufvJi1u99/nD1fm+doR6vTa1YZISqqICFYnLqa
         VLX+mTbOVrDUgxfiI85YM5ojN+mGUxOVIblr8ji+i2xUL5jwRuyBbPwKOmKHI4xUPWBR
         JWLoCOttJj18Xg3pqKkRbGH6A/AgoO2IQKBwBISLhrnFN1N8hMqEGPTZhBuPl2NmEWKM
         5ldVtjcX3uL70L1Esx4iSY3wEv5xY5BZdEPg7LX6PClzO8jPG0mEgYg5uLMHHBrFIgr5
         sCmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795640622; x=1796245422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g8oo3n3BAcC5n/86IJAMCc4c54L34G0M24e5RFRNyIo=;
        b=KJxP04gcKtvhl2b2pLBHyg1LEE4rRCKNaHs8wlXVREzQ+Zgu+evjqb5AUqAab64UJh
         db0W1kX71KE9nNRRZX3Xb++Qtek17wOBcwiVnOg4NE6rd1DQWssOuyTErQyHq5fuCw8r
         LypcJ1lOj0zWJ5nW4f98vJyu1x2pycn6bV950NfnNDUUP+wnxSGy8kwkgf2DDpsT24iC
         FQ/oEv7Updo9niFGvDDtU5Pvh9LH8S4adbuY91mFnYcrYDmWajgDQYbmcF3jT6tn7MfA
         nUieK7bae64w4hGfVOAWaVmyMKDvQDNX9eRdqDyAcvpQvPwox2+9a90FZEy7Wff+rl9B
         6Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640622; x=1796245422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8oo3n3BAcC5n/86IJAMCc4c54L34G0M24e5RFRNyIo=;
        b=oQwMZbJSaXAX88Aryx+cROcGCLRI0g+tdwhUiTd7vkOEwfbemV6Gfky/2+nbxrZ0bn
         pI/tWFZdHPo8v/X2n4sXTjEvWn9fD/W0pWIOwta6EJZ+dJ8I18fRjdmB+qlPGXHZbJI5
         BStiQnK8mKmeTBwFwFiP24ataFWEbJ+RfGzXnFrbx+c/6VnHt1gTiI3hD/Aw8ZV5z0Kt
         gFG24WAaRmQosx30NhKmJLmDRiPLZ1vYmyVPyfL6xu5FfPlThxfFWEu8IGngvq32UkJK
         o65BIoi3881Dsa2q0oHZtCbG0OkVlr/QxGpZSpTgaQk+m77qmq794PiP/9DRvHYW08jN
         UYvA==
X-Forwarded-Encrypted: i=1; AL+hErH3AtpCAWHZ0AiP8b6unwLbajUhjTnbshKlYc6xaN0T/nKavSDCXsnT4w16HiDHjmfbxxyscyo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oUBqEVBSCJyM+Jpr1rG0gUk5zIX441zXrx3YZBW0BNc0u0fOr
	tllP3BT1vZELkyIQBFiZXcc1J3Z2mVq8gJoa7LUwFz8TNUr+4JZB1KDwpX2yRIH+7t6Z1wPqhW/
	iQatqAeW9B3cMCEPvxT6K9zOgez4LvSREKNxUJ7pWoA==
X-Gm-Gg: AZFdTZeGwayeg54u+0nIJSG5KcYWYm4UUn9ek5r54iyMNfYhEAIUErm/ZO5QEO6ZjYe
	DHy6ousRVBcH3YAxmJcLl814boZRfnlJC7ES7GPpFt9rKI2AeVCwxNGH8iSuey8FnA0sQOxhCVs
	Sa6EECQdSva+wVr6Ut7GJ/NIkltU7ykHTLlDx75hvHqsvd5gwsjwDMZ6yC3NN/BoreNWgSUe/im
	aZ+9sWcV7dOGHQxo3IwxDRcHiQo4ghzkydsKCBJpzGKB0XIeiqUrVvdZmWFKFlEi3aJJXa+EqNY
	DJmBWF+AFOKkq+Iemgo8jpkpCL/an12vuUtbwjAsw0r8AiTBZ/UE4KB7inNXN9XvKg+FCakitf1
	r2HTVvFZD6efHWQbWVj4QVkHgbsqwUxEoFGw9ZG6yDzPt3nCI7bo497NOTdUqkvOLXvbVGqo=
X-Received: by 2002:aa7:df18:0:b0:6b9:c43d:88f with SMTP id
 4fb4d7f45d1cf-6ba37d5c69dmr10748147a12.9.1795640622317; Wed, 25 Nov 2026
 13:03:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-gs101-usb-phy-orientation-v2-0-3361fa5f7543@linaro.org> <20261123-gs101-usb-phy-orientation-v2-1-3361fa5f7543@linaro.org>
In-Reply-To: <20261123-gs101-usb-phy-orientation-v2-1-3361fa5f7543@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 25 Nov 2026 21:03:29 +0000
X-Gm-Features: Aa3M54pP550miJl9HbCRj99JxEMj3d0cMVlh26LqNCl_O0LJ7lYFwSv6xfFKFjY
Message-ID: <CADrjBPpm8OzJTG4J8TqWZF-f_qdOKXJ4Tk-LYhNH1D=mWPNNUQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] phy: exynos5-usbdrd: gs101: re-init PIPE3 on
 orientation change
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, RD Babiera <rdbabiera@google.com>, 
	Juan Yescas <jyescas@google.com>, kernel-team@android.com, phone-devel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Nov 2026 at 14:25, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> The SS lane mux on gs101 is programmed only when the PIPE3 phy is
> initialized, based on the Type-C orientation known at that time.
> The orientation switch callback just stores the new orientation and
> relies on the USB controller to exit and re-initialize the phy, which
> only happens if DWC3 enters runtime suspend.
>
> If a cable is connected during boot, the phy is initialized before the
> TCPC reports the orientation (e.g. ~4.0s vs. ~5.3s on Pixel 6), so the
> lanes are programmed for TYPEC_ORIENTATION_NONE, i.e. as if reversed.
> DWC3 doesn't runtime suspend while the cable stays connected (and
> runtime PM is forbidden by default anyway), so the phy is never
> re-initialized and the link comes up in high-speed only.
>
> Re-run the PIPE3 init from the orientation switch callback if the
> PIPE3 phy is initialized and its lanes are programmed for the other
> orientation. Rewriting the lane mux registers alone isn't sufficient,
> the link still comes up in high-speed only with that. Re-initialize
> before signalling VBUS valid, so that DWC3 only sees VBUS once the
> lanes are right. A failure is only logged, so that the TCPM still
> configures the USB role.
>
> Mark the PIPE3 phy as initialized in the same critical section that
> programs the lanes, so that an orientation change can't get lost in
> between.
>
> Also stop storing TYPEC_ORIENTATION_NONE on unplug, so that the stored
> orientation always describes the lanes: while the PIPE3 phy is
> initialized, they stay programmed for it, and when the phy is
> initialized again after phy_exit(), which gates its power, they are
> programmed from it. This avoids re-initializing the PIPE3 phy when a
> cable is plugged in again in the same orientation and the phy stayed
> initialized.
>
> Cc: <stable@vger.kernel.org> # 6.15.x: 2ef1e78ef722: phy: samsung: usbdrd=
: propagate GS101 PIPE3 lock failures
> Cc: <stable@vger.kernel.org> # 6.15.x
> Fixes: 09dc674295a3 ("phy: exynos5-usbdrd: subscribe to orientation notif=
ier if required")
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 61 ++++++++++++++++++++++++++=
++++--
>  1 file changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsu=
ng/phy-exynos5-usbdrd.c
> index 2186b745d58f..ccaf0f27c4c8 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -509,6 +509,7 @@ struct exynos5_usbdrd_phy_drvdata {
>   * @regulators: regulators for phy
>   * @sw: TypeC orientation switch handle
>   * @orientation: TypeC connector orientation - normal or flipped
> + * @pipe3_initialized: gs101 PIPE3 phy is initialized (and not isolated)
>   */
>  struct exynos5_usbdrd_phy {
>         struct device *dev;
> @@ -532,6 +533,7 @@ struct exynos5_usbdrd_phy {
>
>         struct typec_switch_dev *sw;
>         enum typec_orientation orientation;
> +       bool pipe3_initialized;
>  };
>
>  static inline
> @@ -1713,6 +1715,8 @@ static int exynos5_usbdrd_gs101_pipe3_init(struct e=
xynos5_usbdrd_phy *phy_drd)
>         u32 reg;
>         int ret;
>
> +       lockdep_assert_held(&phy_drd->phy_mutex);
> +
>         exynos5_usbdrd_usbdp_g2_v4_ctrl_pma_ready(phy_drd);
>
>         /* force aux off */
> @@ -1737,7 +1741,17 @@ static int exynos5_usbdrd_gs101_pipe3_init(struct =
exynos5_usbdrd_phy *phy_drd)
>         if (ret)
>                 return ret;
>
> -       return exynos5_usbdrd_usbdp_g2_v4_pma_check_cdr_lock(phy_drd);
> +       ret =3D exynos5_usbdrd_usbdp_g2_v4_pma_check_cdr_lock(phy_drd);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Set this while still holding phy_mutex, so that the orientatio=
n
> +        * switch callback can't miss an orientation change.
> +        */
> +       phy_drd->pipe3_initialized =3D true;
> +
> +       return 0;
>  }
>
>  static int exynos5_usbdrd_gs101_phy_init(struct phy *phy)
> @@ -1783,6 +1797,9 @@ static int exynos5_usbdrd_gs101_phy_exit(struct phy=
 *phy)
>                 ret =3D exynos850_usbdrd_phy_exit(phy);
>                 if (ret)
>                         return ret;
> +       } else {
> +               scoped_guard(mutex, &phy_drd->phy_mutex)
> +                       phy_drd->pipe3_initialized =3D false;
>         }
>
>         exynos5_usbdrd_phy_isol(inst, true);
> @@ -1880,8 +1897,48 @@ static int exynos5_usbdrd_orien_sw_set(struct type=
c_switch_dev *sw,
>
>         scoped_guard(mutex, &phy_drd->phy_mutex) {
>                 void __iomem * const regs_base =3D phy_drd->reg_phy;
> +               bool reinit_pipe3 =3D false;
>                 unsigned int reg;
>
> +               /*
> +                * The SS lanes are configured during PIPE3 init, for
> +                * TYPEC_ORIENTATION_NORMAL or else as reversed. If the P=
IPE3
> +                * phy is initialized already (e.g. the orientation is on=
ly
> +                * known after the USB controller probed) and the lanes h=
ave
> +                * to change, initialize it again, before signalling VBUS=
 valid
> +                * to the controller. Rewriting the lane mux alone isn't =
enough
> +                * for the SS link to come up.
> +                *
> +                * TYPEC_ORIENTATION_NONE (unplug) isn't stored: while th=
e PIPE3
> +                * phy is initialized, phy_drd->orientation is what the l=
anes are
> +                * programmed for, otherwise it is what the next PIPE3 in=
it will
> +                * program.
> +                *
> +                * Don't return an error, so that the Type-C port manager=
 still
> +                * configures the USB role.
> +                */
> +               if (orientation !=3D TYPEC_ORIENTATION_NONE) {
> +                       bool was_normal =3D (phy_drd->orientation =3D=3D
> +                                          TYPEC_ORIENTATION_NORMAL);
> +                       bool is_normal =3D (orientation =3D=3D
> +                                         TYPEC_ORIENTATION_NORMAL);
> +
> +                       reinit_pipe3 =3D (phy_drd->pipe3_initialized &&
> +                                       is_normal !=3D was_normal);
> +                       phy_drd->orientation =3D orientation;
> +               }
> +
> +               if (reinit_pipe3) {
> +                       const struct exynos5_usbdrd_phy_config *cfg =3D
> +                               phy_drd->phys[EXYNOS5_DRDPHY_PIPE3].phy_c=
fg;
> +
> +                       ret =3D cfg->phy_init(phy_drd);
> +                       if (ret)
> +                               dev_warn(phy_drd->dev,
> +                                        "Failed to reconfigure SS lanes:=
 %d\n",
> +                                        ret);
> +               }
> +
>                 if (orientation =3D=3D TYPEC_ORIENTATION_NONE) {
>                         reg =3D readl(regs_base + EXYNOS850_DRD_UTMI);
>                         reg &=3D ~(UTMI_FORCE_VBUSVALID | UTMI_FORCE_BVAL=
ID);
> @@ -1900,8 +1957,6 @@ static int exynos5_usbdrd_orien_sw_set(struct typec=
_switch_dev *sw,
>                         reg |=3D HSP_VBUSVLDEXTSEL | HSP_VBUSVLDEXT;
>                         writel(reg, regs_base + EXYNOS850_DRD_HSP);
>                 }
> -
> -               phy_drd->orientation =3D orientation;
>         }
>
>         clk_bulk_disable_unprepare(phy_drd->drv_data->n_clks, phy_drd->cl=
ks);
>
> --
> 2.56.1.750.gf70dc682cf-goog
>
