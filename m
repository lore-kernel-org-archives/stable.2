Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32E9366052;
	Wed, 30 Sep 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780885; cv=none; b=C+zlEKnO+7AEKQwZv/ImLrMo2ss2frcw9iaaAkk7Bz4ANXDeibSDJ646fT0ASS+yXjHItqJXtTChmVQaIrn8GYMqqs+KNEw7zLT6Qk3nPRGqLFZGKpfgEPNOe23fSBcKF/eef+2ce5YT0OKctApI+pdJ2U5Wo+0YmUpsA1STWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780885; c=relaxed/simple;
	bh=X5Ql4a/fq1dL+u/9J5iIsgt0eJC8ZfXYkoxyqfuHkRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPmXclB6yFasPAeWXysASV8LcS7kCmJlx+nNpIfL4TSOgQys/WFRemgowygLS2uy8viWWREufkx9dBAaFNRKeFnT9VEAHMAyoZaS9KbOX7sCS4OxSYMxC2Y79+R4HVRz2cAhyqJ2WbMu6/he08BdN7ht1zd4KFH3YbTrUl6PhmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGz41rV7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGz41rV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790780879; x=1822316879;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X5Ql4a/fq1dL+u/9J5iIsgt0eJC8ZfXYkoxyqfuHkRM=;
  b=JGz41rV76qIEmcS1WjEMEK59vLfErMiipB7BJ6O2PO41gvcRJHEPEDYB
   nofOz0b9V9FXGJtDtP/jGwPsCqLbgnDTxOoopWBVQQhRQQ/L0xaMGGJTy
   Zs5apRKmlCgPRlMN72uZSCSgcom7/O6p7b2RZOtgKA7NeZLasRVQR+PFF
   6m8iUgHl97q8j4Y27DS3FU3ZsbcZJN4IAwg+rE0ITPrAtE3eF1fwt80ks
   3TmvjbdgtzmLDPI3zqdsINmqHaKeokt1xwipF6acmmgkN6QoQWugNz+nM
   seWKadpEgi2tEr7fvC13S7iTvmLqCi5uK8+EVPdkNCpn1VU07X7le0afH
   Q==;
X-CSE-ConnectionGUID: MYBS5gCvT1iJgGvrSJVt6Q==
X-CSE-MsgGUID: V11qUP4OR4Cl+xkLXOEzXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="100849912"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="100849912"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 08:07:52 -0700
X-CSE-ConnectionGUID: KmMFwIWsSEq98WDzhnXgYQ==
X-CSE-MsgGUID: Cr65BJqRSZa5eKpBDiSHpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="313641619"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 08:07:52 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
	by linux.intel.com (Postfix) with ESMTP id E34AB20B5708;
	Wed, 30 Sep 2026 08:07:47 -0700 (PDT)
Message-ID: <f569d934-e468-4750-a75a-242f87ba6c97@linux.intel.com>
Date: Wed, 30 Sep 2026 17:07:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/6] iavf: fix VF stats not updating due to PTP
 command preemption
To: netdev-bot+sashiko@kernel.org, anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 david.butler@appgate.com, emil.s.tantilov@intel.com,
 luoxuanqiang@kylinos.cn, bryan.fraschetti@canonical.com,
 tristan@talencesecurity.com, horms@kernel.org, aleksander.lobakin@intel.com,
 stable@vger.kernel.org, jacob.e.keller@intel.com,
 aleksandr.loktionov@intel.com
References: <20260928230429.495442-6-anthony.l.nguyen@intel.com>
 <179072991532.434549.7383166792791708818@kernel.org>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <179072991532.434549.7383166792791708818@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30.09.2026 02:58, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] iavf_watchdog_step()
>   (drivers/net/ethernet/intel/iavf/iavf_main.c) now calls…
> 
> --
> 
> iavf: fix VF stats not updating due to PTP command preemption
> 
> With this commit, iavf_watchdog_step() requests VF stats on every pass
> while the adapter is in __IAVF_RUNNING. Before, it only did so when
> iavf_process_aq_command() found nothing to do. The periodic PHC caching
> task keeps a PTP command pending, so the old stats fallback never ran.
> 
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> index 29b8403a066bc..c0686ad5c4116 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> @@ -2932,18 +2932,12 @@ static int iavf_watchdog_step(struct iavf_adapter *adapter)
>>  				iavf_send_api_ver(adapter);
>>  			}
>>  		} else {
>> -			int ret = iavf_process_aq_command(adapter);
>> -
>> -			/* An error will be returned if no commands were
>> -			 * processed; use this opportunity to update stats
>> -			 * if the error isn't -ENOTSUPP
>> -			 */
>> -			if (ret && ret != -EOPNOTSUPP &&
>> -			    adapter->state == __IAVF_RUNNING)
>> -				iavf_request_stats(adapter);
>> +			iavf_process_aq_command(adapter);
>>  		}
>> -		if (adapter->state == __IAVF_RUNNING)
>> +		if (adapter->state == __IAVF_RUNNING) {
>> +			iavf_request_stats(adapter);
> 
> [Severity: Medium]
> Can this put two virtchnl messages in flight during one watchdog pass?
> 
> Suppose iavf_process_aq_command() has just taken the
> IAVF_FLAG_AQ_SEND_PTP_CMD branch. In that case
> iavf_virtchnl_send_ptp_cmd() has sent VIRTCHNL_OP_1588_PTP_GET_TIME
> without setting adapter->current_op:
> 
> iavf_virtchnl.c:iavf_virtchnl_send_ptp_cmd() {
>     ...
> 	err = iavf_send_pf_msg(adapter, cmd->v_opcode, cmd->msg, cmd->msglen);
> 	if (!err) {
> 		list_del(&cmd->list);
> 		kfree(cmd);
>     ...
> }
> 
> The only guard in iavf_request_stats() then still sees an idle channel,
> so VIRTCHNL_OP_GET_STATS goes out right behind GET_TIME:
> 
> 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
> 		/* no error message, this isn't crucial */
> 		return;
> 	}
> 	...
> 	adapter->current_op = VIRTCHNL_OP_GET_STATS;
> 
> When the GET_TIME reply arrives, iavf_virtchnl_completion() breaks out
> of the switch and reaches the unconditional reset at the end:
> 
> 	} /* switch v_opcode */
> 	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
> 
> That clears the GET_STATS tracking while the GET_STATS reply is still
> outstanding.
> 
> iavf_adminq_task() may drop the netdev lock before the GET_STATS reply
> arrives. A watchdog pass can then send another tracked command. The
> watchdog can be kicked by iavf_schedule_aq_request(), by the 20ms re-arm
> while aq_required is set, or by gettimex64() queuing another PTP read
> with mod_delayed_work(..., 0). The late GET_STATS reply would then clear
> that command's current_op as well.
> 
> Flow Director is one place where this could do real damage.
> iavf_add_fdir_filter() relies on current_op to keep only one
> ADD_PENDING filter in flight. If two adds overlap, the first successful
> VIRTCHNL_OP_ADD_FDIR_FILTER reply does this for every pending filter:
> 
> 			if (fdir->state == IAVF_FDIR_FLTR_ADD_PENDING) {
> 				if (add_fltr->status == VIRTCHNL_FDIR_SUCCESS) {
> 					...
> 					fdir->state = IAVF_FDIR_FLTR_ACTIVE;
> 					fdir->flow_id = add_fltr->flow_id;
> 
> Would the second filter then get the wrong PF flow_id? If so, a later
> delete of that filter could remove the wrong PF rule and leak the real
> one.
> 
> The missing current_op tracking in the PTP sender predates this patch.
> Before this change, though, GET_STATS was only sent in a pass where
> iavf_process_aq_command() returned an error, so it never followed a PTP
> message back to back. Now every PTP send is followed by a GET_STATS in
> the same pass. That covers the roughly once-per-second PHC cache update
> and every gettimex64() read.
> 
> This also adds one GET_STATS mailbox message per PHC read, which the
> commit message doesn't mention.
> 
>>  			iavf_detect_recover_hung(&adapter->vsi);
>> +		}
>>  		break;
> 
> [ ... ]
> 



Thank you, this is a valid finding. iavf_virtchnl_send_ptp_cmd() does not set adapter->current_op before sending VIRTCHNL_OP_1588_PTP_GET_TIME, unlike every other virtchnl sender, and iavf_virtchnl_completion() unconditionally clears current_op on any reply. This gap predates this patch, but making the stats request unconditional every watchdog pass makes it trivially reachable, since GET_STATS can now follow a PTP send back-to-back in the same pass - something the old fallback design structurally prevented.

This will be fixed.

Thanks,
Tomasz
