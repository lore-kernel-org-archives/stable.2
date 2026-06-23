Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170838D3EA;
	Tue, 23 Jun 2026 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782239237; cv=none; b=OiEf3BGMCGWFsMBoG1fpDYipLWKBDLTSTfLx1JZ4h1LPi1k50jchdhj3lIHgI5rQzQj/imWjLFQuRF4tYXhDE1TCnLWplPbxM/IhZayX4kKm0C8iSjJwjxJKNHjM9/L2oR7SYl60BaV9GeCG0ivO8rxx8KUMdeeN01T1DkHm2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782239237; c=relaxed/simple;
	bh=c266SklNeNU3U1hZxkhZXefmDfRswMXlkKWxX6IQPFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4hms5qrDHRy0rdLKTty4ORlum4aGQTIogKPvARNLjIahO8fCxXWfqbylkPpj+mFAIIc23hwkDn/PqEYVdLB8ehCkvcjz/es54F7aouC1YRZXZ4t1qwUFMXvjI0jXzgbs9gcvFp7Bxw54IwXWJFPwi5FtZIAnOjrtH5qoM2ErOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VistuIYF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VistuIYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28DF1F000E9;
	Tue, 23 Jun 2026 18:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782239235;
	bh=M1H6GgCBkd12Q2vTtVWlECeEISgxezKOQCjK4ILhU5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VistuIYFPmsC9YAjO6zS3akWtB7tmYrnuf958eTRfOHmEFfov6RoofYe0xZdZesIU
	 gAPBOENhcg6P+A0jRh8KTQqFuVrptXuntVmewM1Zi1fJ2NHMIGPfeQ8nAjeKL79GrJ
	 pM5UAVCvkUW/3Hp9YiIakqaaEPQRt3R50XKsjR5CZS8hQNT2wYztUtS0KcyryhCzW6
	 fMl1TumweDCyj4N7hRf13pQIIqroVuGlXcMYYWy/g5IsvF6Aw3MGm02s1h2m+ErNtF
	 oiRo0PVFQq6eAJZEUX43QsFWk/aU1TPMQeV/zz2rY8/qUvCr4/mXe9+9zATWz7wqjg
	 imjgaNWU0x7+Q==
From: Simon Horman <horms@kernel.org>
To: sam@bynar.io
Cc: Simon Horman <horms@kernel.org>,
	david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: nci: fix out-of-bounds write in nci_target_auto_activated()
Date: Tue, 23 Jun 2026 18:21:10 +0100
Message-ID: <20260623172109.1105965-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622145243.3167276-1-sam@bynar.io>
References: <20260622145243.3167276-1-sam@bynar.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
nfc: nci: fix out-of-bounds write in nci_target_auto_activated()

This commit adds a bounds check to nci_target_auto_activated() to prevent
an out-of-bounds array write. If ndev->n_targets equals
NCI_MAX_DISCOVERED_TARGETS, it prints a debug message and returns early.

> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index c96512bb86531..566ca839fa488 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -603,6 +603,12 @@ static void nci_target_auto_activated(struct nci_dev *ndev,
>  	struct nfc_target *target;
>  	int rc;
>  
> +	/* This is a new target, check if we've enough room */
> +	if (ndev->n_targets == NCI_MAX_DISCOVERED_TARGETS) {
> +		pr_debug("not enough room, ignoring new target...\n");
> +		return;

[Severity: High]
Does this early return cause the state machine to stall?

Looking at nci_rf_intf_activated_ntf_packet(), the state is transitioned
to NCI_POLL_ACTIVE right before this function is called:

net/nfc/nci/ntf.c:nci_rf_intf_activated_ntf_packet() {
    ...
    atomic_set(&ndev->state, NCI_POLL_ACTIVE);
    if (err == NCI_STATUS_OK)
        nci_target_auto_activated(ndev, &ntf);
    ...
}

Because of the early return here, nfc_targets_found() is skipped. Does this
leave the state wedged in NCI_POLL_ACTIVE, permanently blocking future 
attempts to stop polling since nci_stop_poll() requires the state to be 
NCI_DISCOVERY?

> +	}
> +
>  	target = &ndev->targets[ndev->n_targets];

[ ... ]

[Severity: Critical]
This isn't a bug introduced by this patch, but can the ntf union copy
uninitialized stack memory into persistent device structures?

In net/nfc/nci/ntf.c:nci_rf_discover_ntf_packet(), the local ntf struct
is declared on the stack:

    struct nci_rf_discover_ntf ntf;

If the incoming packet has ntf.rf_tech_specific_params_len == 0, the
extraction routines are bypassed, leaving the rf_tech_specific_params union
uninitialized. The struct is then passed to nci_add_new_target():

    if (add_target == true)
        nci_add_new_target(ndev, &ntf);

This eventually calls nci_add_new_protocol(), which blindly reads from this
union:

    nfca_poll = (struct rf_tech_specific_params_nfca_poll *)params;
    target->sens_res = nfca_poll->sens_res;
    target->sel_res = nfca_poll->sel_res;
    target->nfcid1_len = nfca_poll->nfcid1_len;

Could this uninitialized stack garbage be copied into ndev->targets, and
later broadcasted to userspace via Netlink in nfc_targets_found()?

[Severity: Critical]
This isn't a bug introduced by this patch, but does the general bytes length
calculation underflow?

In net/nfc/nci/ntf.c:nci_store_general_bytes_nfc_dep():

    ndev->remote_gb_len = min_t(__u8, 
        (ntf->activation_params.listen_nfc_dep.atr_req_len - 
         NFC_ATR_REQ_GT_OFFSET), NFC_ATR_REQ_GB_MAXSIZE);
         
    memcpy(ndev->remote_gb, 
        (ntf->activation_params.listen_nfc_dep.atr_req + 
         NFC_ATR_REQ_GT_OFFSET), ndev->remote_gb_len);

The length is computed by subtracting NFC_ATR_REQ_GT_OFFSET (14) from
atr_req_len. If atr_req_len is less than 14, this subtraction will
underflow.

Because of the min_t cast, this large underflowed value is bounded to
NFC_ATR_REQ_GB_MAXSIZE (48). The memcpy() then copies 48 bytes starting
from atr_req + 14 into ndev->remote_gb.

Since the source buffer is part of the ntf union allocated on the stack
in nci_rf_intf_activated_ntf_packet(), could this leak up to 48 bytes of
uninitialized kernel stack memory to userspace?

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of skb->len
validation in NCI response handlers allow out-of-bounds reads?

In nci_core_init_rsp_packet_v1() in net/nfc/nci/rsp.c, fields are read
and arrays are copied from the payload:

    ndev->num_supported_rf_interfaces = 
        rsp_1->num_supported_rf_interfaces;
        
    memcpy(ndev->supported_rf_interfaces, rsp_1->supported_rf_interfaces, 
           ndev->num_supported_rf_interfaces);

Similarly in nci_core_init_rsp_packet_v2():

    while (rf_interface_idx < ndev->num_supported_rf_interfaces) {
        ndev->supported_rf_interfaces[rf_interface_idx++] = 
            *supported_rf_interface++;
    }

Since the NCI control header is stripped via skb_pull(), leaving the
payload length in skb->len, what happens if an NFCC sends a short response
packet (e.g. plen = 1)? Could this cause the handlers to read adjacent
kernel slab memory?

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing boundary
validation when extracting activation parameters?

In net/nfc/nci/ntf.c:nci_extract_activation_params_iso_dep():

    nfca_poll->rats_res_len = min_t(__u8, *data++, NFC_ATS_MAXSIZE);
    if (nfca_poll->rats_res_len > 0) {
        memcpy(nfca_poll->rats_res, data, nfca_poll->rats_res_len);
    }

And in nci_extract_activation_params_nfc_dep():

    poll->atr_res_len = min_t(__u8, *data++, NFC_ATR_RES_MAXSIZE - 2);
    if (poll->atr_res_len > 0)
        memcpy(poll->atr_res, data, poll->atr_res_len);

These inner lengths are bounded by a maximum size like NFC_ATS_MAXSIZE, but
they are not validated against the remaining bytes in the SKB (skb->len).

If a malformed packet provides a large inner length but a short payload,
could this memcpy() read out of bounds into the device structure,
potentially leaking adjacent slab memory to userspace later?

[Severity: High]
This isn't a bug introduced by this patch, but is there a potential
priority inversion or timeout deadlock involving the device lock?

Functions like nfc_stop_poll() in net/nfc/core.c acquire the device lock:

    device_lock(&dev->dev);
    ...
    if (dev->ops->stop_poll)
        dev->ops->stop_poll(dev);

This eventually calls nci_request(), which synchronously waits for a
completion signaled by the nci_rx_work thread. However, if an NTF packet
is received first, nci_rx_work processes it and invokes
nfc_targets_found(), which also attempts to acquire the device lock:

    device_lock(&dev->dev);

Since the calling thread already holds the device lock, nci_rx_work blocks
indefinitely. Because the RX worker is blocked, it cannot process the
pending RSP, causing nci_request() to time out and fail. Could this
deadlock the RX thread?
