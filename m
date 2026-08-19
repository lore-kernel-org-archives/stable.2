Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E52386C39;
	Wed, 19 Aug 2026 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141074; cv=none; b=g/Ms53V0fVLi/WROGwEfppG6URSWCFAEpKyUN7hM5NAdYBw6eZP8/z2Wvo/A2fFdfe/P6UFySDCfxoUN10o/49QpGitcuzFNsowFxE6c4t2XfLRxFJ4Z5oCnUAml6DA4meZLUUqzV2mzqs2J35KyBAR8CNtAdtm+PFnhb9zPq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141074; c=relaxed/simple;
	bh=4JaOfFlUP8bO46smg6ipx9sDPvlzvl8+K2iwdtAEKas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1690VEhXRpYyA9OhSHDaIixKL/7gdPJa/HoI6rEKJgHBE7u7OQrbxXnquadTtwbJkKIC0sjoLKYEpXSTHoURJEyZg/9ynLVTjOOPd8v1XYUUey6UXWcDC44b+H5ifuGDGxjj1ZnmqxyO9ZyEaOWWVgFvqCUyOJCl4IqzANxcCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9KzGzS3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9KzGzS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787141073; x=1818677073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4JaOfFlUP8bO46smg6ipx9sDPvlzvl8+K2iwdtAEKas=;
  b=J9KzGzS3ZRcxmRJdJrZngpENpQqYVLKu2b+dMjYeSXZZPx9KEospW0hj
   wpaCi2pcH2FxKZgToHiaaF0EKkCu0S/UpYETkJONDK8TraKRzmUhYei8y
   Pz+WdHwmNA7+XjEaz+UU8jZWSASXbNi/HkzGN46nPN0cSrlqR3Xt9R6DA
   onM6/84Xgp3tSJ6T6DuP3C9bAwy9gfz2rilDoU+c1kLjTDKJHBJqlHmo/
   /oD8D7iUkB3fBFb4V4jvDwUPSbwaonN5BBQeNcqb8MEsDyhKiNrA8KsOs
   u/obA5AOHEcolovjRD3R0cPae/dlku/HRk7paVWb5/WQtEzpgg+pcQPg9
   Q==;
X-CSE-ConnectionGUID: GeCdfM7QRCCpBr3U52Kyqw==
X-CSE-MsgGUID: Kg9I+XBWTfGK2qgzFyoqcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="105183878"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="105183878"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 05:04:31 -0700
X-CSE-ConnectionGUID: zB78kJC4QpyNPhWyA1r+JQ==
X-CSE-MsgGUID: 7KGAeJ+eRCqLMFSCSmJkbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="265073201"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by orviesa008.jf.intel.com with ESMTP; 19 Aug 2026 05:04:28 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: kuba@kernel.org
Cc: aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	danisjiang@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	moonafterrain@outlook.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	rafal.romanowski@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net 07/13] ice: support SBQ posted writes with non-posted support for CGU
Date: Wed, 19 Aug 2026 14:07:55 +0200
Message-ID: <20260819120755.187078-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723155750.717839-1-kuba@kernel.org>
References: <20260723155750.717839-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sure, can do that

> >  	/* Wait for the command to complete. If it finishes within the
> >  	 * timeout, copy the descriptor back to temp.
> >  	 */
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > index 8e5f97835954..c6049097f49d 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > @@ -352,6 +352,20 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
> >  static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
> >  {
> >  	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
> > +	struct ice_sbq_msg_input msg = {
> > +		.dest_dev = ice_sbq_dev_phy_0,
> > +		.opcode = ice_sbq_msg_rd,
> > +	};
> > +	int err;
> > +
> > +	/* Flush SBQ to ensure posted writes complete before SYNC command.
> > +	 * Skip for E810 - FW always sends completions, so writes are synchronous.
> > +	 */
> > +	if (hw->mac_type != ICE_MAC_E810) {
> > +		err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
> > +		if (err)
> > +			dev_warn(ice_hw_to_dev(hw), "Failed to flush SBQ: %d\n", err);
> > +	}
> 
> [Medium]
> When ice_sbq_rw_reg() fails here (for example -EBUSY when
> hw->reset_ongoing is set, or -ENOSPC / -EIO / -ETIMEDOUT from
> ice_sq_send_cmd()), the code logs a warning and then unconditionally
> proceeds to issue wr32(GLTSYN_CMD_SYNC, SYNC_EXEC_CMD).
> 
> The commit message states:
> 
>     Flush the SBQ by reading address 0 from the PHY 0 before issuing SYNC
>     command to ensure that writes to all PHYs were completed
> 
> If the flush is what "ensures that writes to all PHYs were completed",
> does silently continuing on flush failure reopen the race the patch is
> trying to close?
> 
> ice_ptp_exec_tmr_cmd() returns void, and none of its callers
> (ice_ptp_tmr_cmd, ice_start_phy_timer_e82x / eth56g,
> ice_sync_phy_timer_e82x / eth56g,
> ice_read_phy_and_phc_time_e82x / eth56g) can react to the failure. Should
> this path propagate the error, or at least skip the SYNC issue when the
> flush fails?
> 
> Also, is a non-rate-limited dev_warn appropriate in this hot PTP path?
> Repeated failures (for example during a reset storm) could flood the
> kernel log.
> 

yeah, making sure it returns earlier on failure is a good idea.

> [Medium]
> Does the phy_0-only flush actually order writes issued to other SBQ
> destinations?
> 
> ice_write_phy_eth56g() now issues posted writes and picks the
> destination via ice_ptp_get_dest_dev_e825():
> 
>     static enum ice_sbq_dev_id ice_ptp_get_dest_dev_e825(struct ice_hw *hw,
>                                                          u8 port)
>     {
>         ...
>         if ((!ice_is_dual(hw) && tgt_phy == 1) ||
>             (ice_is_dual(hw) && tgt_phy != curr_phy))
>             return ice_sbq_dev_phy_0_peer;
>         else
>             return ice_sbq_dev_phy_0;
>     }
> 
> So on single-complex E825-C with ports >= ports_per_phy, and on
> dual-complex E825-C for cross-complex writes, posted writes can go to
> ice_sbq_dev_phy_0_peer. The flush here reads from a hardcoded
> ice_sbq_dev_phy_0:
> 
>     struct ice_sbq_msg_input msg = {
>         .dest_dev = ice_sbq_dev_phy_0,
>         .opcode = ice_sbq_msg_rd,
>     };
> 
> If the SBQ does not enforce global commit ordering across distinct
> neighbor destinations, does a read completing on phy_0 guarantee that a
> previously-issued posted write to phy_0_peer has landed on the destination
> device before GLTSYN_CMD_SYNC executes?
> 
> The commit message says:
> 
>     Flush the SBQ by reading address 0 from the PHY 0 before issuing SYNC
>     command to ensure that writes to all PHYs were completed
> 
> Is that guarantee documented for cross-destination SBQ traffic, or should
> the flush also target ice_sbq_dev_phy_0_peer (and any other destination
> that received a posted write) on multi-PHY / dual-complex E825-C?
> 

I tested mainly on E830. If someone is using E-825 device it indeed
might be different. I've heard some information that it
causes failure on some setups, but I asked an waiting on some details
regarding what sort of failure it is and what's the failing device.
Will most likely need that information before sending new version.

> >  
> >  	if (!ice_is_primary(hw))
> >  		hw = ice_get_primary_hw(pf);
> 
> [ ... ]
