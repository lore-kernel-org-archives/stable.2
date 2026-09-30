Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797AD35E55D;
	Wed, 30 Sep 2026 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729919; cv=none; b=jXg1HrGe8f77GDzRtN0/P8tkuU6Dkqy904AloefAiRGRP1bhiKe4QXLg8pXlMMA1jlJlEc9HVgbvFC1f62gwLCB32DjV+lfFUR++ZRI6ptSLLBKjlqhAaKnFBLH1cCqtlskHO2CHMC+MTZ2e77VOKq3roVyEdSnpykCXmkgGmZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729919; c=relaxed/simple;
	bh=Ur0Ddvl6ESmvpEVe3Qy5gR5GrC7locnWkov2f0hw4jk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S1uUZtyVJuoWJfAUsQtIQmSyV9ISbVIiQDKpngp4hP+ev8+zi2YjHEIFsEMZOF1yv49sco1+n+uwGRPpcwnVtGH3RMUAkDVMpuwB2UHyMxVDtdtAQoZdvK2WopTMJ1jFYDi87kQCbFnAvZKYO7T1vqiEfCALHn9xu1K8SfFqh3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=as8nCVTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as8nCVTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315FD1F00893;
	Wed, 30 Sep 2026 00:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729918;
	bh=6kP8kJQ6VA2Bt5fAEy7dftrFS4PHFNFwS4y8INrIUcM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=as8nCVTWFHmWQ0Wixey/K1CVNy4ORvwOJo12snhzGMRvht6HcMRyZjtOxLKl30DaP
	 pMvo25rhZraedYXfEx/0GwHnSiqgivUWeLvfyPimWS4ESJsg8NYnt2bHG7IaztX1Lk
	 NQHMwSuBo9BRvhf94gT14FmC9dCjGmyLyUjbnew9rOHlx6voWS7Qp2pdFAfEG5MliX
	 oBvdxqmwtPwN9ETr5fWVaoAI0KsKVj/HH/bgw43hwUKgeJqS11w/eKcsWvl5tKRG59
	 o5kLEsgfQ2T+IYpHam176nE8qf3AVHkw0XZTY26MKjXDPM707powRNMBjRqHeUBmAr
	 4JATqacFtXGcQ==
Subject: Re: [PATCH net 6/6] iavf: cap advertised max_pkt_size at the
 single-buffer HW limit
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 david.butler@appgate.com, emil.s.tantilov@intel.com, luoxuanqiang@kylinos.cn,
 bryan.fraschetti@canonical.com, tristan@talencesecurity.com,
 tomasz.lichwala@linux.intel.com, horms@kernel.org,
 aleksander.lobakin@intel.com, stable@vger.kernel.org,
 jacob.e.keller@intel.com, aleksandr.loktionov@intel.com
Date: Wed, 30 Sep 2026 00:58:36 +0000
Message-ID: <179072991678.434549.17815320009417499641@kernel.org>
In-Reply-To: <20260928230429.495442-7-anthony.l.nguyen@intel.com>
References: <20260928230429.495442-7-anthony.l.nguyen@intel.com>
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

- [Medium] The patch caps the Rx max_pkt_size sent to the PF (the per-
  queue Rx context 'rxmax') at LIBIE_MAX_RX_BUF_LEN (9728) in…

--

iavf: cap advertised max_pkt_size at the single-buffer HW limit

This commit caps the max_pkt_size that iavf_configure_queues() sends to
the PF in VIRTCHNL_OP_CONFIG_VSI_QUEUES at LIBIE_MAX_RX_BUF_LEN (9728).
Without the cap, a PF that advertises vf_res->max_mtu as 0 (the ESXi icen
PF on E810) receives 16382 and rejects the queue configuration.

Link: https://community.intel.com/t5/Ethernet-Products/E810-C-iavf-driver-issue-on-Linux-6-12/m-p/1737490
Link: https://access.redhat.com/solutions/6973766
Link: https://knowledge.broadcom.com/external/article/404315/sriov-enabled-vms-network-adaptor-goes-d.html

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index ec234cc8bd9db..680a28a739bf0 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -382,6 +382,14 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
>  
>  	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);
>  	max_frame = min_not_zero(adapter->vf_res->max_mtu, max_frame);
> +	/* The PF programs max_pkt_size into the per-queue Rx context "rxmax".
> +	 * LIBIE_MAX_RX_FRM_LEN is the multi-descriptor (S/G) frame ceiling
> +	 * (16382), but that exceeds the E810 max MAC frame size (9728); some
> +	 * PFs reject the out-of-range value with VIRTCHNL_STATUS_ERR_PARAM.
> +	 * Cap it at the single-buffer HW limit (== the MAC frame max),
> +	 * restoring the pre-Page-Pool behaviour.
> +	 */
> +	max_frame = min(max_frame, LIBIE_MAX_RX_BUF_LEN);

[Severity: Medium]

Should netdev->max_mtu be clamped to match? Rx max_pkt_size is now capped
at 9728. However, iavf_init_config_adapter() in iavf_main.c still derives
the MTU ceiling from the 16382 S/G limit when the PF sends max_mtu == 0:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_init_config_adapter() {
    ...
	if (!adapter->vf_res->max_mtu) {
		netdev->max_mtu = LIBIE_MAX_MTU;
	} else if (adapter->vf_res->max_mtu < LIBETH_RX_LL_LEN + ETH_MIN_MTU ||
		   adapter->vf_res->max_mtu >
			   LIBETH_RX_LL_LEN + LIBIE_MAX_MTU) {
		...
		netdev->max_mtu = LIBIE_MAX_MTU;
	} else {
		netdev->max_mtu = adapter->vf_res->max_mtu - LIBETH_RX_LL_LEN;
	}
    ...
}

LIBIE_MAX_MTU is 16382 - 26 = 16356. A PF-advertised frame size above
9728 that still passes the range check also gives a max_mtu above 9702.

In the icen case this patch targets, can a user still set an MTU the
queues can't carry? For example:

    ip link set dev ethX mtu 12000

dev_validate_mtu() only checks against dev->max_mtu. iavf_change_mtu()
stores the new MTU and triggers a reset without a check of its own. The
queues are then reprogrammed with max_pkt_size = 9728.

Received frames larger than 9728 bytes would then be silently dropped by
the Rx queue context, instead of the MTU change failing. Per the commit
message, E810 also discards Tx frames above MAX_TXFRAME (9728).

Before this patch, rxmax and max_mtu both came from the 16382 ceiling and
matched each other.

The commit message and the new comment both describe this as "restoring
the pre-Page-Pool behaviour". Commit 5fa4caff59f2 changed two things. It
changed max_frame from IAVF_MAX_RXBUFFER to LIBIE_MAX_RX_FRM_LEN(). It
also changed netdev->max_mtu from IAVF_MAX_RXBUFFER - IAVF_PACKET_HDR_PAD
(9710) to LIBIE_MAX_MTU. This patch only reverts the first change.

Could netdev->max_mtu also be clamped to LIBIE_MAX_RX_BUF_LEN -
LIBETH_RX_LL_LEN, in both the zero-value branch and the invalid-value
fallback?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928230429.495442-1-anthony.l.nguyen%40intel.com
