Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B97399356;
	Thu, 23 Jul 2026 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822285; cv=none; b=Sz/VqiwUpUAoCvGgPqHv+HBOWzpxqCliDIi1FGlgWixzX6hdZprz+f48+6e8O+o8bdoD8adqx0q1kOspyZXhzZzWUHMdBQRXiGcHElpSucrXwltF8t58BvAjh8oLujKBeC0ARGt8fcSDh2A6NA+EUwbYX5Yp20U5Q5NtMydmL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822285; c=relaxed/simple;
	bh=eKZl1BymiMrEuud9Nz3x/gcKPKZpSaZ1yTULfelVEq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t750XOFS2LtgrMSvgMk+qomMRoschk6ojxql/6horiSbjvetDcNATbK1hBhLYCwRyQjXZ80ZbdJ/MxBUp/dU0X3vqcOkxAws4ch5rgFNuOB5RF/FtvO22/3xWNzoA89fPtoZokAVMPhyuAop4ZP4IsRes7NebyG4suzj1jrA77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKAr2JsS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKAr2JsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604E61F000E9;
	Thu, 23 Jul 2026 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784822280;
	bh=fuxnJRqsWS6EgLQHxg5U8zfvVmbk3kTWrkWnV7H2sfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IKAr2JsS5UsO9TaWJeyFf6h/2LyuH1swWhsl0OoD/mRzl+EBXQXtOUXFTleLZtYK2
	 Pj+lAEwoQnUqjlBe8833JZ+qsosZPni6y2Qm5LHAICx3OSaXsU4UH8xKE6WemIEOPf
	 3sZuoLv82ZS90wz5+eD/ds92WsHl96SgrEmN1JwwhYdu+qXzlEBES1jQk4CQjBxq7u
	 8lAsjxgySLacgGym42wQl+J8DOJSoAfXKsf0KSkFsY4pxWXdDsS5e5wZnxm7ManG9G
	 48Z1F9uZBX1qouXdj90GI9PyLy8Mh37nW2AGHnYutjy7w2HFXwbV+sBuOo/iyHk092
	 QaFQiQt+i3TDQ==
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
Subject: Re: [PATCH net 13/13] iavf: validate num_vsis in VIRTCHNL_OP_GET_VF_RESOURCES response
Date: Thu, 23 Jul 2026 08:57:55 -0700
Message-ID: <20260723155755.717968-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717185340.3595286-14-anthony.l.nguyen@intel.com>
References: <20260717185340.3595286-14-anthony.l.nguyen@intel.com>
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
iavf: validate num_vsis in VIRTCHNL_OP_GET_VF_RESOURCES response

This patch clamps the num_vsis field from the PF's
VIRTCHNL_OP_GET_VF_RESOURCES response so that the loop bound used when
iterating over the fixed-size vsi_res[] buffer cannot exceed what the
received message length can cover.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index ec234cc8bd9d..c4039d2b24a4 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c

[ ... ]

> @@ -300,7 +316,7 @@ int iavf_get_vf_config(struct iavf_adapter *adapter)
>  	 * we aren't getting too many queues
>  	 */
>  	if (!err)
> -		iavf_validate_num_queues(adapter);
> +		iavf_validate_num_queues(adapter, min(event.msg_len, len));
>  	iavf_vf_parse_hw_config(hw, adapter->vf_res);
>  
>  	kfree(event.msg_buf);

[High]

Does the error path in iavf_get_vf_config() still allow the
out-of-bounds access on vsi_res[] that the commit message describes?

Looking at the surrounding code:

    err = iavf_poll_virtchnl_msg(hw, &event, VIRTCHNL_OP_GET_VF_RESOURCES);
    memcpy(adapter->vf_res, event.msg_buf, min(event.msg_len, len));

    /* some PFs send more queues than we should have so validate that
     * we aren't getting too many queues
     */
    if (!err)
        iavf_validate_num_queues(adapter, min(event.msg_len, len));
    iavf_vf_parse_hw_config(hw, adapter->vf_res);

The memcpy of the PF-supplied payload into adapter->vf_res runs
unconditionally, but the new num_vsis clamp is only invoked when err is
zero.

iavf_poll_virtchnl_msg() returns virtchnl_status_to_errno(v_retval), so a
PF response carrying a non-success v_retval together with an
attacker-controlled msg_buf would still populate adapter->vf_res with the
raw num_vsis value and then skip the clamp.

iavf_vf_parse_hw_config() runs unconditionally after that and iterates
based on the unclamped u16 num_vsis:

    for (i = 0; i < msg->num_vsis; i++) {
        if (vsi_res->vsi_type == VIRTCHNL_VSI_SRIOV) {
            ether_addr_copy(hw->mac.perm_addr,
                    vsi_res->default_mac_addr);
            ether_addr_copy(hw->mac.addr,
                    vsi_res->default_mac_addr);
        }
        vsi_res++;
    }

vsi_res[] is a fixed-size array of IAVF_MAX_VF_VSI (3) entries in the
adapter->vf_res allocation, so num_vsis up to 65535 would walk far past
that buffer, and any OOB slot whose vsi_type happens to equal
VIRTCHNL_VSI_SRIOV would additionally copy six bytes of adjacent heap
memory into hw->mac.perm_addr and hw->mac.addr.

Would it make sense to either apply the num_vsis clamp unconditionally,
or gate the memcpy and iavf_vf_parse_hw_config() behind the same
if (!err) as the validation, so that the error path cannot reintroduce
the out-of-bounds access this patch is meant to close?
