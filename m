Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D1935C6B5;
	Wed, 30 Sep 2026 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729918; cv=none; b=sj/w+NL5bu1tUWYS9qKkZgHxKnWYy07/x8WNX+cAFYyFCh4IIj/50fQ7TagtzyGanWKmk3kCFDS2HGvW9qolGX4pN534053kTIpuMma0m+2wgtgLtU/w93N+H/vW2/5yb251NaEWeaHJjVBRGylVrIM6E4cwRW2QPxrci+McvVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729918; c=relaxed/simple;
	bh=KWdKMX+Zx+Tno0xPCjHS/mLvF/QIyx6FobCFqtaOg5U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MPexhdIhpzlvcfRvqSnVuxvwp3OrCiPbvORyFdRbHscZvGDjmRDrX17rtx4m9WsdYcRgW/VX4oct3+DZSy69HU1LhdsQtPwi31VbzOg5bs91u77tEc8P/d8srWDSAc2+6OI5cLSPSLQZUlCuyJMh31mzC6b2Caa7lV/tbEzACmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXePyrtC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXePyrtC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82F31F000FF;
	Wed, 30 Sep 2026 00:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729916;
	bh=N0kZtHtUFfZ4QaxSpdp8all56IQbAYtvEK93JlDznAc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bXePyrtCVXmWKPOR+XuyPkmKK5NihrTmTyZbZPm474Ej//CcSBn3vqui2CggVQTn4
	 IOsXq4u3fCZtWsFNiC+SB32x8PWsGLc97/wBVPs7kU3eqFR8YA4E8EJ5/jkc1zSpU0
	 GfJDrp5XUmd5tegTvpWwutiR93b0xMsiQG4AHXFuwYONoaqrijhjKhMfu0mJW9Qk70
	 heHL72vuYy0bRCM+Zhsqw/swiHt3Wk03TcXpm8oDqhzgwhSfkzK3jiTbzzyxrngjXW
	 PRhK89Bra0NqtYfKYttPvQzWCvn/ek0Pe52Z8SeKxWl7qylKylLGML9J/JsWtI2Inc
	 uLHH19T0u4wcA==
Subject: Re: [PATCH net 5/6] iavf: fix VF stats not updating due to PTP
 command preemption
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 david.butler@appgate.com, emil.s.tantilov@intel.com, luoxuanqiang@kylinos.cn,
 bryan.fraschetti@canonical.com, tristan@talencesecurity.com,
 tomasz.lichwala@linux.intel.com, horms@kernel.org,
 aleksander.lobakin@intel.com, stable@vger.kernel.org,
 jacob.e.keller@intel.com, aleksandr.loktionov@intel.com
Date: Wed, 30 Sep 2026 00:58:35 +0000
Message-ID: <179072991532.434549.7383166792791708818@kernel.org>
In-Reply-To: <20260928230429.495442-6-anthony.l.nguyen@intel.com>
References: <20260928230429.495442-6-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] iavf_watchdog_step()
  (drivers/net/ethernet/intel/iavf/iavf_main.c) now calls…

--

iavf: fix VF stats not updating due to PTP command preemption

With this commit, iavf_watchdog_step() requests VF stats on every pass
while the adapter is in __IAVF_RUNNING. Before, it only did so when
iavf_process_aq_command() found nothing to do. The periodic PHC caching
task keeps a PTP command pending, so the old stats fallback never ran.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 29b8403a066bc..c0686ad5c4116 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2932,18 +2932,12 @@ static int iavf_watchdog_step(struct iavf_adapter *adapter)
>  				iavf_send_api_ver(adapter);
>  			}
>  		} else {
> -			int ret = iavf_process_aq_command(adapter);
> -
> -			/* An error will be returned if no commands were
> -			 * processed; use this opportunity to update stats
> -			 * if the error isn't -ENOTSUPP
> -			 */
> -			if (ret && ret != -EOPNOTSUPP &&
> -			    adapter->state == __IAVF_RUNNING)
> -				iavf_request_stats(adapter);
> +			iavf_process_aq_command(adapter);
>  		}
> -		if (adapter->state == __IAVF_RUNNING)
> +		if (adapter->state == __IAVF_RUNNING) {
> +			iavf_request_stats(adapter);

[Severity: Medium]
Can this put two virtchnl messages in flight during one watchdog pass?

Suppose iavf_process_aq_command() has just taken the
IAVF_FLAG_AQ_SEND_PTP_CMD branch. In that case
iavf_virtchnl_send_ptp_cmd() has sent VIRTCHNL_OP_1588_PTP_GET_TIME
without setting adapter->current_op:

iavf_virtchnl.c:iavf_virtchnl_send_ptp_cmd() {
    ...
	err = iavf_send_pf_msg(adapter, cmd->v_opcode, cmd->msg, cmd->msglen);
	if (!err) {
		list_del(&cmd->list);
		kfree(cmd);
    ...
}

The only guard in iavf_request_stats() then still sees an idle channel,
so VIRTCHNL_OP_GET_STATS goes out right behind GET_TIME:

	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
		/* no error message, this isn't crucial */
		return;
	}
	...
	adapter->current_op = VIRTCHNL_OP_GET_STATS;

When the GET_TIME reply arrives, iavf_virtchnl_completion() breaks out
of the switch and reaches the unconditional reset at the end:

	} /* switch v_opcode */
	adapter->current_op = VIRTCHNL_OP_UNKNOWN;

That clears the GET_STATS tracking while the GET_STATS reply is still
outstanding.

iavf_adminq_task() may drop the netdev lock before the GET_STATS reply
arrives. A watchdog pass can then send another tracked command. The
watchdog can be kicked by iavf_schedule_aq_request(), by the 20ms re-arm
while aq_required is set, or by gettimex64() queuing another PTP read
with mod_delayed_work(..., 0). The late GET_STATS reply would then clear
that command's current_op as well.

Flow Director is one place where this could do real damage.
iavf_add_fdir_filter() relies on current_op to keep only one
ADD_PENDING filter in flight. If two adds overlap, the first successful
VIRTCHNL_OP_ADD_FDIR_FILTER reply does this for every pending filter:

			if (fdir->state == IAVF_FDIR_FLTR_ADD_PENDING) {
				if (add_fltr->status == VIRTCHNL_FDIR_SUCCESS) {
					...
					fdir->state = IAVF_FDIR_FLTR_ACTIVE;
					fdir->flow_id = add_fltr->flow_id;

Would the second filter then get the wrong PF flow_id? If so, a later
delete of that filter could remove the wrong PF rule and leak the real
one.

The missing current_op tracking in the PTP sender predates this patch.
Before this change, though, GET_STATS was only sent in a pass where
iavf_process_aq_command() returned an error, so it never followed a PTP
message back to back. Now every PTP send is followed by a GET_STATS in
the same pass. That covers the roughly once-per-second PHC cache update
and every gettimex64() read.

This also adds one GET_STATS mailbox message per PHC read, which the
commit message doesn't mention.

>  			iavf_detect_recover_hung(&adapter->vsi);
> +		}
>  		break;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928230429.495442-1-anthony.l.nguyen%40intel.com
