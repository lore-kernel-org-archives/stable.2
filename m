Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1A41F7F2;
	Wed,  9 Sep 2026 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994953; cv=none; b=QNBIIavPD2TIneYOtITvBmu7wTzU9izurcPtGrTeB1nH1l/V3t0P60KMTONkkAN5Dodbvi7J0KlmPLPE7UrNG28vCSs9dbWTUxOFnrvtwUor7W8gMi37m+AY1qTLoWkaZLt115cXaYleRbW+3feb7X34waTb6rYOb6Jv2hROLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994953; c=relaxed/simple;
	bh=VgahomZ0rZ2fr267ydGH5onvLUbsgRWZVvm4gMjOqqI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A4GlpaTpoaT4Nu8z2XbK9cqi3EXMnURUeORU/BkpttHhvc6TJcdFmTx7TbZZJhAd5+1NpJLhfxED5sElRnyF8yfM7xFz3kblZ/+MbUsu1waK8w25eDcxFBE9WD5hIPnQwsnF0iNKfDnkH+2Y0sx1k1Lcd/6YM3lUCggsIydqYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPZT/g5m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPZT/g5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D381F000FF;
	Wed,  9 Sep 2026 23:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788994948;
	bh=y71zi1x1NLPGISUH5NRTiK/jKpv4ngPapC+STcqAMOk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oPZT/g5mxFn4h9/NhGrJaPFz0KWHMUVZvWUsguM/j3BQwcqyfeuADEJm+PWzMon35
	 Lih6kMfbfI9Y3BNpE9azosplVxpx9nYG9iq5i8lbLnu+tTRQvXQPhPuXgprzmKh4AK
	 GkSSLwWCdd9ey6sxSGN29goOx5o5K+KMLy+Kq0Y5vuKVGbpUhOWT06ZjK5t07YbW0d
	 MMtP1j31D/2uL3RqoqE0B5e92YBO3+EZ0tETeRjeiU77gPceprHiPI5r8qcv5UKozv
	 039F+SVZuyXcyyX2lfBQd67FQP9kTWQnVHkBs6zWcD+2K8CA0b4/bKfFL3+zr+eYMg
	 HTaACdGlE/Yhg==
Subject: Re: [PATCH net v3 3/3] net: phy: qca808x: handle the active-high LED
 polarity mode
From: netdev-bot+sashiko@kernel.org
To: donggeunyoo.kernel@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, daniel@makrotopia.org, o.rempel@pengutronix.de,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 09 Sep 2026 23:02:26 +0000
Message-ID: <178899494670.219967.8563823740478760743@kernel.org>
In-Reply-To: <20260908105959.70453-4-donggeunyoo.kernel@gmail.com>
References: <20260908105959.70453-4-donggeunyoo.kernel@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Incomplete fix in drivers/net/phy/qcom/qca808x.c: the new `case
  PHY_LED_ACTIVE_HIGH: active_low = false;` in…

--

net: phy: qca808x: handle the active-high LED polarity mode

This adds a PHY_LED_ACTIVE_HIGH case to qca808x_led_polarity_set() so that
a device tree LED node carrying the 'active-high' property no longer makes
the switch fall into the default case and return -EINVAL, which previously
failed phy_probe().

> diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
> index 8eb51b1a006c..3ba58f14e248 100644
> --- a/drivers/net/phy/qcom/qca808x.c
> +++ b/drivers/net/phy/qcom/qca808x.c
> @@ -603,6 +603,9 @@ static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
>  		case PHY_LED_ACTIVE_LOW:
>  			active_low = true;
>  			break;
> +		case PHY_LED_ACTIVE_HIGH:
> +			active_low = false;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}

[Severity: High]
Does this new case leave the LED driven active-low, i.e. the inverse of
what the device tree asked for?

Before this change priv->led_polarity_mode could only hold -1 (never
requested) or 1 (active-low requested).  With the new case an explicit
'active-high' node now stores 0:

drivers/net/phy/qcom/qca808x.c:qca808x_led_polarity_set() {
	...
	/* Save the last PHY polarity mode */
	priv->led_polarity_mode = active_low;

	return phy_modify_mmd(phydev, MDIO_MMD_AN,
			      QCA808X_MMD7_LED_POLARITY_CTRL,
			      QCA808X_LED_ACTIVE_HIGH,
			      active_low ? 0 : QCA808X_LED_ACTIVE_HIGH);
}

The only other place QCA808X_LED_ACTIVE_HIGH gets programmed tests for -1
specifically:

drivers/net/phy/qcom/qca808x.c:qca808x_config_init() {
	/* Default to LED Active High if active-low not in DT */
	if (priv->led_polarity_mode == -1) {
		ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN,
				       QCA808X_MMD7_LED_POLARITY_CTRL,
				       QCA808X_LED_ACTIVE_HIGH);
	...
}

so the newly reachable value 0 skips that write.

phy_init_hw() runs drv->soft_reset (qca808x_soft_reset ->
genphy_soft_reset, BMCR_RESET) before drv->config_init, and it is called
from phy_attach_direct() and again from mdio_bus_phy_resume().  Since
BIT(6) has to be set explicitly for active high:

drivers/net/phy/qcom/qca808x.c:
/* QSDK sets by default 0x46 to this reg that sets BIT 6 for
 * LED to active high. It's not clear what BIT 3 and BIT 4 does.
 */
#define QCA808X_LED_ACTIVE_HIGH			BIT(6)

isn't the single probe-time phy_modify_mmd() write discarded by that reset
and then never restored, leaving the LED active-low?

That would make a device tree that explicitly states 'active-high' behave
worse than one that omits the property entirely, since the omitted case
keeps led_polarity_mode == -1 and does get the bit re-asserted from
config_init.

There is a second effect of the overloaded value: with
priv->led_polarity_mode == 0 the driver's global-polarity bookkeeping
records "active high" while the register says active low, so a second LED
also requesting active-high passes the mismatch check against state that
does not reflect the hardware.

Should qca808x_config_init() also cover the explicit active-high case, for
example by re-asserting the bit whenever led_polarity_mode != 1, or by
using a distinct sentinel for "not requested" rather than overloading -1
and 0?

Related to this, could the commit message paragraph:

  "active_low is already false when no polarity mode is requested, which
  programs QCA808X_LED_ACTIVE_HIGH, so the request is already satisfied and
  only the case label is missing."

be revisited?  In the no-property case led_polarity_set is not called at
all (of_phy_led() only calls it when modes is non-zero), so what programs
QCA808X_LED_ACTIVE_HIGH there is the led_polarity_mode == -1 branch of
qca808x_config_init(), which the new case label makes unreachable for an
explicit active-high request.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908105959.70453-1-donggeunyoo.kernel%40gmail.com
