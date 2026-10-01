Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9333264C8;
	Thu,  1 Oct 2026 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851438; cv=none; b=XUhEqqWV+mkcX6P7v9pOsLvDX/TZtTjvfGnFGZTg0R2YfLBVtQCsgczayM8ck1AdlD/VIbSs9ITUx6GdNZ3iTUd2IGcOj8UfHJMHBieaz/KSAnUe5tsB04rUAyEgCVP4khxGaZiwhJGAbOXGWPL94/BYDpbe1CjvVtpkVoj9Vjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851438; c=relaxed/simple;
	bh=F5T25okxxj3wkm8vBHu1BJoGK39vzb+Nbf/OZkVMo9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8ESOh0lQda4jNczx9pYDspLWmySLEQHP8yjfkBo0fBTQAg+S/4/iZxkYPKTj+xLtOz2JeAh8dPnJm9958UHmUePwHJKh75n081SFZWpinSi2g0aurhlUoTNSU82MXn0xeXecBS7CYZrQngVrMCGI/WuuAl8oFlEyJbmlvYki6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvijDuM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvijDuM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F7F1F000FF;
	Thu,  1 Oct 2026 10:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851436;
	bh=ag07URdANwZ2qlpZa9rQoXExFjLkpiIUYJe8sMUl1e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DvijDuM8v5XPVG1j0cOZUQ6H+4qknXwmGflt5eIOyqTpsgckF5NYy/gcWAR/JOzh1
	 8VGUn4zp2Up/miINCoJcsEGqx7VkLXY4vXris3UAOW0bH+N4Uzr7Pv6WmTtWo63aP9
	 lDOQzXYg5NRLOW4Re49lYhIc7Lc8hqZRbzFSfSCF6TlySCmv3DRBFvY6QfI8Muv9+/
	 FK3ns881Vo128u5ZTXcWBi9g5Z+h1rCQQVXbgpxNq181DoAiu6ndcjXtuS/nyfJkFw
	 4r8RDpITroLExrph21YMlaqXqjTI9lS885udyzw7YITJIIL0q+2Iw79oUDcpusd1Od
	 rhl9J/hV98ikQ==
Date: Thu, 1 Oct 2026 11:43:52 +0100
From: Simon Horman <horms@kernel.org>
To: Yuchao Zhang <ndaugoing@gmail.com>
Cc: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] nfc: nci: ignore unexpected CORE_RESET_NTF and
 CORE_RESET_RSP
Message-ID: <20261001104352.GZ13925@horms.kernel.org>
References: <20260927132914.24648-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927132914.24648-1-ndaugoing@gmail.com>

On Sun, Sep 27, 2026 at 09:29:14PM +0800, Yuchao Zhang wrote:
> Commit bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
> added handling of CORE_RESET_NTF in nci_core_reset_ntf_packet(). When
> received, it updates ndev->nci_ver, ndev->manufact_id, and
> ndev->manufact_specific_info, and calls nci_req_complete(ndev,
> NCI_STATUS_OK) to finish the pending reset request.
> 
> However, unlike other notification handlers in ntf.c (which validate
> ndev->state before completing requests), nci_core_reset_ntf_packet()
> does not check whether a core reset request is actually pending.
> If an unsolicited or delayed CORE_RESET_NTF arrives (e.g. after a reset
> command times out or from a misbehaving NFCC), it unconditionally:
> 1. Completes whatever request is currently in-flight (such as CORE_INIT,
>    RF_DISCOVER, or CONN_CREATE) with NCI_STATUS_OK, leading to kernel
>    state desynchronization.
> 2. Overwrites ndev->nci_ver and manufacturer info. Because
>    ndev->nci_ver is used as a selector for subsequent packet formats
>    and parsers (e.g., in nci_open_device() and nci_core_init_rsp_packet()),
>    unexpectedly modifying it can cause protocol format confusion.
> 
> A similar issue exists in nci_core_reset_rsp_packet(): an unexpected or
> delayed response packet can prematurely complete an unrelated in-flight
> request.
> 
> Fix this by ensuring CORE_RESET_NTF and CORE_RESET_RSP are only processed
> by the core layer when a reset command is actively awaiting them:
> - Set NCI_RESET_PENDING in nci_reset_req() when sending CORE_RESET_CMD.
> - In nci_core_reset_rsp_packet(), ignore the response if NCI_RESET_PENDING
>   is not set. If set, atomically clear the flag and complete the request
>   on failure or for NCI 1.x (checking skb->len >= sizeof(*rsp)).
> - In __nci_request(), ensure NCI_RESET_PENDING is cleared upon request
>   completion, cancellation, or timeout.
> - In nci_core_reset_ntf_packet(), fail any in-flight reset request if the
>   controller reports an unrecoverable error (0x00), and only process
>   command-triggered notifications (0x02). Non-command triggers (e.g.
>   power-on 0x01 or proprietary triggers) and unexpected notifications
>   return 0 without modifying core state, ensuring driver-specific
>   notification handlers (such as fdp firmware patch handling) still
>   receive them.
> - In nci_core_reset_ntf_packet(), support notifications shorter than 9
>   bytes (e.g. NCI 2.0 frames with manufacturer_specific_len == 0),
>   validating the fixed header length and safely bounding
>   manufact_specific_info reads.
> 
> Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
> ---
> v3:
>  - In nci_core_reset_ntf_packet(), do not reject notifications shorter than
>    9 bytes with -EINVAL; instead allow valid short frames (e.g. 2-byte NCI 1.x
>    or 5-byte NCI 2.0 with manufacturer_specific_len == 0), safely cap field
>    reads, and return 0 so driver-registered hooks (such as fdp firmware
>    patching) are not skipped (per Sashiko AI).
>  - Fix trigger semantics: in NCI, CORE_RESET_CMD trigger is 0x02
>    (NCI_RESET_TRIGGER_RESET_CMD). If controller reports an unrecoverable error
>    (0x00, NCI_RESET_TRIGGER_ERROR) while reset is pending, fail the request
>    instead of completing with OK; ignore power-on (0x01) and proprietary
>    triggers at core layer (per Sashiko AI).
>  - In nci_core_reset_rsp_packet(), use test_and_clear_bit(NCI_RESET_PENDING)
>    upon completing the request to consume the flag atomically (per Sashiko AI).
>  - Link to v2: https://lore.kernel.org/netdev/20260922102144.39689-1-ndaugoing@gmail.com/
> 
> v2:
>  - Do not abort the notification pipeline on unexpected CORE_RESET_NTF (return 0
>    instead of -EINVAL), preserving driver-level hooks (e.g. fdp firmware
>    patching) per Simon Horman.
>  - Skip power-on notifications (trigger 0x01, identical in NCI 1.0 and 2.0)
>    while gating both NCI 1.0 (0x00) and NCI 2.0 (0x02) command-triggered resets
>    on NCI_RESET_PENDING alone.
>  - Check NCI_RESET_PENDING in nci_core_reset_rsp_packet() to avoid completing
>    unrelated requests on unexpected responses.
>  - Explicitly check skb->len >= sizeof(*rsp) in nci_core_reset_rsp_packet()
>    for NCI 1.x handling.
>  - Link to v1: https://lore.kernel.org/netdev/20260918013337.82214-1-ndaugoing@gmail.com/

Reviewed-by: Simon Horman <horms@kernel.org>

