Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68280480975;
	Thu,  6 Aug 2026 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036852; cv=none; b=dsvnOfQOE+EWsjRM83zuXYGKTFaWMWbr7qARg/BPV+M+92EPsq8qcchzuj9mBq3P92hu0I0eWmXxFvDeYywciNZTpkm+iSdmJfasCHCvl34coas5KVNudC+LMkD14Jr6b/a1CNJB9awzbBBpCkZcYNC6XHhg/h4CM94aDm5q8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036852; c=relaxed/simple;
	bh=7StifURND+oD07WD3k/Qx/nNZEDqvgwKvWYyp6JhpVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1SsW3fH8xfELBa1Jigpy6IpZzD9BIck6l0GH4DpBDj2qSDEYNo6/0y9kx4jhbqzHBr6FVWav1oLxP8ZavrT+lRaKo2a8+O2Fi+8fjuxLvB96/Qkf7DIRnHiNoz06SlQ8acbnHL8k76AVoEM1Fnzh+z93orO5YvCCt1EcZB1a3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZWzEFh9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZWzEFh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4231F000E9;
	Thu,  6 Aug 2026 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036851;
	bh=t/PTNCWC/5CSohY8+HOUvOf+ql5Jy3uxtVrk/EDTTaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZZWzEFh9dCju8FiSU6+rAIiQ1ipzyOryN/88AIfmWAlQ2AkPMyh5AF7IP42i0K1Qa
	 KA5hNS6p+bWOUbdDuAoKrv/QR95vcFYvrH4BrdRy2ZZxzZ0a+8GuC6vU8dVIRm9lkO
	 JUVp5M3C7Z0MIV2Iiubn3+RRX0zYYMjosw/0HSfOsn+MFPODUFYw7Q8Is54FMFAqsL
	 7o8iIpv4R9qOgiwU9iV/b6tkIse4xdi3vEWr0tpsGOakc6xm/4IMsNfXIixspCVkZO
	 tRbCYPTjJ9E9/Q9mg0MkpDs/eZCqssF0ro0n/02e7oZ/5h0iZHJTu1bHD0HZbwrmhA
	 Osv6xZHbB+hdw==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	doruk@0sec.ai,
	michal.swiatkowski@linux.intel.com,
	grzegorz.nitka@intel.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	aleksandr.loktionov@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH net 08/10] i40e: fix memcmp of pointer in i40e_hw_set_dcb_config()
Date: Thu,  6 Aug 2026 10:20:41 -0700
Message-ID: <20260806172041.2935963-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804222205.1580328-9-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-9-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
i40e: fix memcmp of pointer in i40e_hw_set_dcb_config()

The patch changes the "need reconfiguration" check in
i40e_hw_set_dcb_config() so that memcmp() compares the two
struct i40e_dcbx_config objects instead of the two pointer variables on
the stack. With the old code the compare could never succeed, so the
early return was never taken.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index a04683004a567..0ac1be6289f6b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -6907,7 +6907,7 @@ static int i40e_hw_set_dcb_config(struct i40e_pf *pf,
>  	int ret;
>  
>  	/* Check if need reconfiguration */
> -	if (!memcmp(&new_cfg, &old_cfg, sizeof(new_cfg))) {
> +	if (!memcmp(new_cfg, old_cfg, sizeof(*new_cfg))) {
>  		dev_dbg(&pf->pdev->dev, "No Change in DCB Config required.\n");
>  		return 0;
>  	}

[Severity: High]
Does this compare now always report "no change" when the function is
reached from the tail of i40e_hw_dcb_config()?

i40e_hw_set_dcb_config() takes its old side straight from the PF:

	struct i40e_dcbx_config *old_cfg = &pf->hw.local_dcbx_config;

but i40e_hw_dcb_config() has already published the new configuration into
that same object before making the call:

i40e_main.c:i40e_hw_dcb_config() {
	...
	old_cfg = &hw->local_dcbx_config;
	...
	/* Update the port DCBx configuration */
	*old_cfg = *new_cfg;

	/* Changes in configuration update VEB/VSI */
	i40e_dcb_reconfigure(pf);
out:
	...
		/* registers are set, lets apply */
		if (test_bit(I40E_HW_CAP_USE_SET_LLDP_MIB, pf->hw.caps))
			ret = i40e_hw_set_dcb_config(pf, new_cfg);
}

So new_cfg and pf->hw.local_dcbx_config are byte-identical at that point,
memcmp() returns 0, and the callee logs "No Change in DCB Config required."
and returns 0.

Does that make the "registers are set, lets apply" step dead code for this
caller? Everything after the early return is skipped, including the etsrec
normalization and the only code that pushes the configuration to firmware:

	*old_cfg = *new_cfg;
	old_cfg->etsrec = old_cfg->etscfg;
	ret = i40e_set_dcb_config(&pf->hw);

i40e_dcb.c:i40e_set_dcb_config() is the sole path that builds an LLDPDU via
i40e_dcb_config_to_lldp() from hw->local_dcbx_config and issues
i40e_aq_set_lldp_mib() for the local MIB. With the early return taken, the
DCB registers, packet buffer and PFC state plus the cached
local_dcbx_config carry the new values while the firmware's local DCBX MIB
still holds the previous one.

Which callers does this affect? The DCBNL entry points in i40e_dcb_nl.c
(i40e_dcbnl_ieee_setets(), i40e_dcbnl_ieee_setpfc(), i40e_dcbnl_ieee_setapp(),
i40e_dcbnl_ieee_delapp() and the CEE i40e_dcbnl_cee_set_all()) all copy
*old_cfg into pf->tmp_cfg and then call i40e_hw_dcb_config(pf, &pf->tmp_cfg),
so on parts with I40E_HW_CAP_USE_SET_LLDP_MIB the AQC is no longer sent for
those changes.

Is the resulting behaviour also inverted? On the error paths of
i40e_hw_dcb_config() (the goto out after i40e_aq_config_switch_comp_ets() or
i40e_aq_dcb_updated() fails) the "*old_cfg = *new_cfg" assignment is skipped,
the two structs still differ, and the full quiesce / Set LLDP MIB /
reconfigure sequence does run. That would mean the AQC is now issued only
when the earlier register programming failed.

The i40e_dcb_sw_default_config() call site looks unaffected, since its
freshly memset pf->tmp_cfg differs from a previously cached
local_dcbx_config (etsrec in particular), so the compare still fails there.

Would moving the comparison ahead of the caller's "*old_cfg = *new_cfg", or
not pre-publishing the config in the caller, be a safer shape for a fix that
is tagged for stable?

The commit message says:

    As a result, the memcmp never compares the actual configuration data,
    meaning the "no change needed" early return never fires. Every call to
    this function performs a full DCB reconfiguration (quiescing all VSIs,
    reprogramming via "Set LLDP MIB" AQC, and reconfiguring VEB/VSIs) even
    when the configuration has not changed.

Given the i40e_hw_dcb_config() call site above, is it accurate to describe
the only effect as a redundant reconfiguration? For that caller the old
comparison was load-bearing: comparing &pf->tmp_cfg against
&pf->hw.local_dcbx_config could never match, which is what kept the
Set Local LLDP MIB programming running. Could the changelog cover what
happens at that call site after the fix?
