Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68563476CCB;
	Wed, 23 Sep 2026 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204146; cv=none; b=SFAgtWgUQPA2w0g4Wn1FVZtm2uMgst8F/+qFFXlaRZMquiEtv+SfUIUw16FLetsQgJiqThF/9lKxn72E1yBbUD7tVslLeJxYDvWrwNHbbqXgPrLmNK93zop7k8uZbEIdoD/EK2UeCmziPrFO6qIy5O/Hv7ndvDim93+NHV3zV0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204146; c=relaxed/simple;
	bh=aydlV5ktcDl0PDNi3ENBMrs9Jtn5QE5eQuglT7Mje+o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TrDT1m8KbqGTui7Q9HiPnEPqai7+Gw5jPMJc7zMN3YRGus1rmcet5F8FQ5fC2ZpEcE8nPtpxa8eVc1X86eUNIv+0rhNdJwNM7C+gPkAukLoenUX2HGCwpRWG3/xYHMumMFzpyLvBCepcU7cwY82eg4KoDHTeeemIWUUxkzcp5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ7ud/iA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ7ud/iA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACB71F000FF;
	Wed, 23 Sep 2026 22:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790204141;
	bh=bMEz+8z5/iFSbryMaD4429+XzgUW35I0roiUh76X7Pc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QQ7ud/iAz5QTGl8j3woniFEhYBL5+J0OZC4zosRtGnJjqPtTsrsMME4uBwY3nmr4k
	 TvHJJAwu8+zCkzPHXgLrW9LlQxy/xlvQNKRRghW8Z5PDWrvo4nopuFPt66zb9zVXTy
	 H4u1RJ7Fwst9+hUnx8QT6DRe/yxBi4pBCIraOV88P+Qgj5BcxRoz5lUwUc+yrvBxs5
	 o3FNlYVZx8G5pR/8mg01uLy2gk1JdqY3MAsj32Aj7uuP7YLdsWq5DKoulE5hqbHwA6
	 HwfF92BCterAUdfWtFVIfCfUl/SmZrK12OLlQj0yBm3qZc3PSjwkceXRYFXN/g0Zrm
	 40oRifDUt69hg==
Subject:
 Re: [PATCH net v2] net: phy: intel-xway: workaround 100BASE-TX Link-Up issue
From: netdev-bot+sashiko@kernel.org
To: alexander.sverdlin@siemens.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, olek2@wp.pl,
 daniel@makrotopia.org, john@phrozen.org, hauke@hauke-m.de,
 stable@vger.kernel.org
Date: Wed, 23 Sep 2026 22:55:40 +0000
Message-ID: <179020414050.2160803.9286678901573366174@kernel.org>
In-Reply-To: <20260922075251.23386-1-alexander.sverdlin@siemens.com>
References: <20260922075251.23386-1-alexander.sverdlin@siemens.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] phy: intel-xway: workaround only applied to one PHY instead of
  unconditionally
- [Low] Unhandled error path leaves the PHY latched in cable-diagnostic
  test mode and skips the remaining init.

--

net: phy: intel-xway: workaround 100BASE-TX Link-Up issue

This adds the MaxLinear GSW12x/GSW14x errata workaround to the Intel XWAY
driver by toggling Cable Diagnostic Mode on and off in a new config_init
wrapper.  The wrapper is wired up for the PHY11G (xRX v1.2 integrated)
entry and then calls the existing xway_gphy_config_init().

> diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
> index afbcec7117443..3cee31bb931f2 100644
> --- a/drivers/net/phy/intel-xway.c
> +++ b/drivers/net/phy/intel-xway.c

[ ... ]

> @@ -326,6 +331,28 @@ static int xway_gphy_probe(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int xway_11g_int_config_init(struct phy_device *phydev)
> +{
> +	int err;
> +
> +	/* An issue has been sporadically observed after device power-on on the
> +	 * first link-up attempt in 100BASE-TX mode resulting in either the
> +	 * link-up taking a long time, or failing to link-up altogether.
> +	 *
> +	 * Workaround:
> +	 * After power-on, enable Cable Diagnostic Mode for all ports and
> +	 * disable it.
> +	 */
> +	err = phy_modify(phydev, MII_CTRL1000, XWAY_MDIO_GCTRL_TM_MASK, XWAY_MDIO_GCTRL_TM_CDIAG);
> +	if (err)
> +		return err;
> +	err = phy_modify(phydev, MII_CTRL1000, XWAY_MDIO_GCTRL_TM_MASK, XWAY_MDIO_GCTRL_TM_NOP);
> +	if (err)
> +		return err;
> +
> +	return xway_gphy_config_init(phydev);
> +}

[Severity: Medium]
The commit message says the workaround is implemented "unconditionally
in the Intel XWAY driver", and argues that the diagnostic bits have the
same meaning in older PHYs such as GPY111/PEF7071/PHY11G so it should
not hurt them.  But the only entry in xway_gphy[] that is switched over
to xway_11g_int_config_init() is PHY_ID_PHY11G_VR9_1_2 ("Intel XWAY
PHY11G (xRX v1.2 integrated)").

Every other entry still points .config_init at xway_gphy_config_init():
the PEF 7071/7072 PHY11G v1.3, v1.4 and v1.5/v1.6 entries, the PEF 7061
PHY22F entries, the xRX v1.1 integrated PHY11G/PHY22F entries, and even
PHY_ID_PHY22F_VR9_1_2, the xRX v1.2 integrated sibling of the entry that
was changed.  On all of those PHYs the cable diagnostic toggle never
runs.  If any of them is affected by the same errata, the sporadic
100BASE-TX link-up failure described in the commit message remains.

Which behaviour is intended?  The name xway_11g_int_config_init()
suggests the restriction to one PHY ID is deliberate, which contradicts
the changelog.  If the workaround is only meant for the PHY ID that the
GSW12x/GSW14x integrated ports report, could the commit message say so
instead of "unconditionally", and name that PHY ID?  If it is meant to
cover the whole driver, the remaining entries need to be wired up as
well.  For the PHY22F variants it would also be worth confirming that
bits 15:13 of MII_CTRL1000 carry the same test mode meaning on a Fast
Ethernet only PHY before writing them.

[Severity: Low]

What happens to the PHY state if the second phy_modify() in
xway_11g_int_config_init() fails?  The first write has already latched
MII_CTRL1000[15:13] to XWAY_MDIO_GCTRL_TM_CDIAG, and the only write that
leaves cable-diagnostic mode is this separate read-modify-write.

phy_modify() only reports negative errno for real MDIO read/write
failures, so the "if (err)" here fires exactly on bus errors:

drivers/net/phy/phy-core.c:__phy_modify() {
	ret = __phy_modify_changed(phydev, regnum, mask, set);

	return ret < 0 ? ret : 0;
}

On that path the function returns with the PHY still in diagnostic mode
and with no attempt to restore XWAY_MDIO_GCTRL_TM_NOP.  It also skips
xway_gphy_config_init() entirely, so XWAY_MDIO_IMASK is never masked,
the pending interrupt read of XWAY_MDIO_ISTAT never happens, and the
RGMII skew, LED and error-counter setup are all left unprogrammed.

Do the callers recover from this?  phy_init_hw() just propagates the
error to phy_attach_direct(), and on resume:

drivers/net/phy/phy_device.c:mdio_bus_phy_resume() {
	ret = phy_init_hw(phydev);
	if (ret < 0)
		return ret;

	ret = phy_resume(phydev);
	...
}

returns before phy_resume(), so config_init is not re-run in that cycle
and the diagnostic mode persists until the next attach or init.

Granted, this only triggers after the MDIO bus has already failed, where
a rollback write would likely fail too, and the next successful
phy_init_hw() re-runs the toggle.  Still, would it be worth noting that
before this change a config_init failure never left the PHY in a mode
that by itself prevents link-up?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922075251.23386-1-alexander.sverdlin%40siemens.com
