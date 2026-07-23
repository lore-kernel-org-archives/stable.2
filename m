Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B8845D1B8;
	Thu, 23 Jul 2026 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822277; cv=none; b=daHVCt5+0tIoaINr7OmpdYyBqUKzA80TTOvKYY/U1NLvzLEVV70eyL8CxPkAQAIis1VXYNttoHBQS6+EOEbpIgq9BtwhvylNE2mluGdA1Dl7JcjUHIgssk+KafANU7BU16R7VVls9cUEc5JzfEo35w3LzEKcJq3515ZbtPHwNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822277; c=relaxed/simple;
	bh=YKqTmjywpdgcEnickDwsK+5E0IjbeS++/McSIUZkqp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=di8+kGTM0u+eDQjc8LL5uovozYv2BO7r+YonghuH2Gy/cfgCo9UGurE57+bakVPw7OOD0t2s/mMeb680bEHvMyeQFJJ8bzeNJoHK+dSf4hi3V2cNSu1fkcae5GRqymgQry3ay8MN301oky4FRBWIfw5rUQGj07yMjoUKTstdvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E59D1F000E9;
	Thu, 23 Jul 2026 15:57:55 +0000 (UTC)
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	moonafterrain@outlook.com,
	przemyslaw.kitszel@intel.com,
	danisjiang@gmail.com,
	stable@vger.kernel.org,
	aleksandr.loktionov@intel.com,
	horms@kernel.org,
	rafal.romanowski@intel.com
Subject: Re: [PATCH net 07/13] ice: support SBQ posted writes with non-posted support for CGU
Date: Thu, 23 Jul 2026 08:57:50 -0700
Message-ID: <20260723155750.717839-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717185340.3595286-8-anthony.l.nguyen@intel.com>
References: <20260717185340.3595286-8-anthony.l.nguyen@intel.com>
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
ice: support SBQ posted writes with non-posted support for CGU

This change introduces posted SBQ writes to remove the delay-based
"completion" the driver was relying on, adds a pre-SYNC SBQ flush in
ice_ptp_exec_tmr_cmd() to order posted PHY writes before GLTSYN_CMD_SYNC,
and keeps CGU accesses non-posted. E810 always waits for completion since
its firmware answers every write.

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index ef1ce106f81b..53974ebaaffa 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
> index dcb837cadd18..a6008dc77fa4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_controlq.c
> +++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
> @@ -1086,6 +1086,10 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
>  	wr32(hw, cq->sq.tail, cq->sq.next_to_use);
>  	ice_flush(hw);
>  
> +	/* If the message is posted, don't wait for completion. */
> +	if (cd && cd->posted)
> +		goto sq_send_command_error;
> +

[Low]
For the posted success path, could the goto target be renamed (or a
dedicated label added) so the normal success exit no longer jumps to a
label named for the error cleanup path?

The success path here relies on status still being 0 at the point of the
goto. Any future change that sets status earlier in ice_sq_send_cmd() (for
tracing, logging, or a refactor of the send path) would silently turn
successful posted writes into errors.

The posted path also skips the ice_debug() writeback traces, the
cd->wb_desc copy, and the timeout classification block, but neither the
goto site nor the new struct ice_sq_cd posted bit mentions this. Would a
short comment on struct ice_sq_cd's posted field, describing what the
posted path skips, help?

>  	/* Wait for the command to complete. If it finishes within the
>  	 * timeout, copy the descriptor back to temp.
>  	 */

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 8e5f97835954..c6049097f49d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -352,6 +352,20 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
>  static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
>  {
>  	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
> +	struct ice_sbq_msg_input msg = {
> +		.dest_dev = ice_sbq_dev_phy_0,
> +		.opcode = ice_sbq_msg_rd,
> +	};
> +	int err;
> +
> +	/* Flush SBQ to ensure posted writes complete before SYNC command.
> +	 * Skip for E810 - FW always sends completions, so writes are synchronous.
> +	 */
> +	if (hw->mac_type != ICE_MAC_E810) {
> +		err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
> +		if (err)
> +			dev_warn(ice_hw_to_dev(hw), "Failed to flush SBQ: %d\n", err);
> +	}

[Medium]
When ice_sbq_rw_reg() fails here (for example -EBUSY when
hw->reset_ongoing is set, or -ENOSPC / -EIO / -ETIMEDOUT from
ice_sq_send_cmd()), the code logs a warning and then unconditionally
proceeds to issue wr32(GLTSYN_CMD_SYNC, SYNC_EXEC_CMD).

The commit message states:

    Flush the SBQ by reading address 0 from the PHY 0 before issuing SYNC
    command to ensure that writes to all PHYs were completed

If the flush is what "ensures that writes to all PHYs were completed",
does silently continuing on flush failure reopen the race the patch is
trying to close?

ice_ptp_exec_tmr_cmd() returns void, and none of its callers
(ice_ptp_tmr_cmd, ice_start_phy_timer_e82x / eth56g,
ice_sync_phy_timer_e82x / eth56g,
ice_read_phy_and_phc_time_e82x / eth56g) can react to the failure. Should
this path propagate the error, or at least skip the SYNC issue when the
flush fails?

Also, is a non-rate-limited dev_warn appropriate in this hot PTP path?
Repeated failures (for example during a reset storm) could flood the
kernel log.

[Medium]
Does the phy_0-only flush actually order writes issued to other SBQ
destinations?

ice_write_phy_eth56g() now issues posted writes and picks the
destination via ice_ptp_get_dest_dev_e825():

    static enum ice_sbq_dev_id ice_ptp_get_dest_dev_e825(struct ice_hw *hw,
                                                         u8 port)
    {
        ...
        if ((!ice_is_dual(hw) && tgt_phy == 1) ||
            (ice_is_dual(hw) && tgt_phy != curr_phy))
            return ice_sbq_dev_phy_0_peer;
        else
            return ice_sbq_dev_phy_0;
    }

So on single-complex E825-C with ports >= ports_per_phy, and on
dual-complex E825-C for cross-complex writes, posted writes can go to
ice_sbq_dev_phy_0_peer. The flush here reads from a hardcoded
ice_sbq_dev_phy_0:

    struct ice_sbq_msg_input msg = {
        .dest_dev = ice_sbq_dev_phy_0,
        .opcode = ice_sbq_msg_rd,
    };

If the SBQ does not enforce global commit ordering across distinct
neighbor destinations, does a read completing on phy_0 guarantee that a
previously-issued posted write to phy_0_peer has landed on the destination
device before GLTSYN_CMD_SYNC executes?

The commit message says:

    Flush the SBQ by reading address 0 from the PHY 0 before issuing SYNC
    command to ensure that writes to all PHYs were completed

Is that guarantee documented for cross-destination SBQ traffic, or should
the flush also target ice_sbq_dev_phy_0_peer (and any other destination
that received a posted write) on multi-PHY / dual-complex E825-C?

>  
>  	if (!ice_is_primary(hw))
>  		hw = ice_get_primary_hw(pf);

[ ... ]
