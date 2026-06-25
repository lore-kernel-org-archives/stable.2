Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BBC3E4C61;
	Thu, 25 Jun 2026 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392250; cv=none; b=AvTPZpHXOS2E1tmgPmxrc9+Ad9wkX/q/z2f82UctAasLnfC18NEgFGqpE5niYtL59HOXUZQLxNuXtkupMYhJTBtWIIssqiqmyCn4PqMKz5ujY3Y2fhQG5uEVLTENn3jCTYszaghWVOx/IxQSQrB8dPy20H/qmb9AIUeZLfIUTQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392250; c=relaxed/simple;
	bh=6amijwCuDW1hDzQ5UWJN/W7f4d8ORSH6s4r5B6T/dLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du3yNUA0B3n7/VzZQgY09590UAS5Z32f6UF5Mef8+fvEhkwzWhqYR/qQQkZVLwP2HkVb2+eO3fVgubsn3hLU8o6lo8zqwcPua8wPOiOFydRQdXdJXYMsUb6DxX4DlrEf3mtCSZynpLVlJNMHFd0dFkBiymZ5GEDvTp7MW7NTBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd+B/VPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd+B/VPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3660D1F000E9;
	Thu, 25 Jun 2026 12:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782392248;
	bh=2AUXtweujPMCo16oaEA/mFfW29cS251qdPvyJQVWc7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rd+B/VPQ06Cun5eevbQkRPwhK1ALrFleOBZw8CAmDKBzUitIwIjhUYtffBXZcMVrn
	 xM1+l8fvR1JlYNQGL/6Kq9C6R5B9yJE5xPuiPyLIoDZsBPM2sT/3FaeQ7xJgKUE7OH
	 6G9qlc5OrIEc6rG7lbXDa2Uixccsyrc16N0qLjOX+fsn93mv8FwiYCr6TCledm++zk
	 7M+16vwnYY8vGQEkeSZOUTCNd1psKJngX6tXCM4b5e4TrDXNf8oD4zddbtaAvl6H0d
	 d+mtGsClZHQJ/C75yXu3BCZN1ZTOodYl1NAfsDQIBxSLRdnk6GEDzr3TnkOqyGpNfX
	 ImPq/llhe8jpQ==
Date: Thu, 25 Jun 2026 13:57:23 +0100
From: Simon Horman <horms@kernel.org>
To: Sam P <sam@bynar.io>
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: nci: fix out-of-bounds write in
 nci_target_auto_activated()
Message-ID: <20260625125723.GF1131256@horms.kernel.org>
References: <20260622145243.3167276-1-sam@bynar.io>
 <20260623172109.1105965-2-horms@kernel.org>
 <443e2ee1-e9c1-45ca-be57-0c67966ec7d9@bynar.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <443e2ee1-e9c1-45ca-be57-0c67966ec7d9@bynar.io>

On Wed, Jun 24, 2026 at 12:33:21AM +0200, Sam P wrote:
> On 23/06/2026 19:21, Simon Horman wrote:
> > > diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> > > index c96512bb86531..566ca839fa488 100644
> > > --- a/net/nfc/nci/ntf.c
> > > +++ b/net/nfc/nci/ntf.c
> > > @@ -603,6 +603,12 @@ static void nci_target_auto_activated(struct nci_dev *ndev,
> > >       struct nfc_target *target;
> > >       int rc;
> > > 
> > > +    /* This is a new target, check if we've enough room */
> > > +    if (ndev->n_targets == NCI_MAX_DISCOVERED_TARGETS) {
> > > +        pr_debug("not enough room, ignoring new target...\n");
> > > +        return;
> > 
> > [Severity: High]
> > Does this early return cause the state machine to stall?
> > 
> > Looking at nci_rf_intf_activated_ntf_packet(), the state is transitioned
> > to NCI_POLL_ACTIVE right before this function is called:
> > 
> > net/nfc/nci/ntf.c:nci_rf_intf_activated_ntf_packet() {
> >      ...
> >      atomic_set(&ndev->state, NCI_POLL_ACTIVE);
> >      if (err == NCI_STATUS_OK)
> >          nci_target_auto_activated(ndev, &ntf);
> >      ...
> > }
> > 
> > Because of the early return here, nfc_targets_found() is skipped. Does this
> > leave the state wedged in NCI_POLL_ACTIVE, permanently blocking future
> > attempts to stop polling since nci_stop_poll() requires the state to be
> > NCI_DISCOVERY?
> > 
> > > +    }
> > > +
> > >       target = &ndev->targets[ndev->n_targets];
> > 
> > [ ... ]
> 
> Thanks for sharing the review.
> 
> I don't believe the early return can stall the state machine, as
> nci_target_auto_activated() does not touch ndev->state.
> 
> nci_rf_intf_activated_ntf_packet() sets ndev->state = NCI_POLL_ACTIVE
> before it calls nci_target_auto_activated(), so the transition has
> already happened by the time the new check runs. Neither
> nci_target_auto_activated() nor nfc_targets_found() modifies ndev->state;
> nfc_targets_found() only clears the nfc_dev dev->polling flag under
> device_lock, which is independent of the NCI state machine that
> nci_stop_poll() tests. So ndev->state is NCI_POLL_ACTIVE after an
> auto-activation whether the target is appended or the guard returns
> early; the state behaviour is the same with or without this patch.
> 
> The check is the same n_targets == NCI_MAX_DISCOVERED_TARGETS guard the
> sibling nci_add_new_target() (the RF_DISCOVER_NTF path) has used since
> the Fixes: commit; it only drops the out-of-spec 11th+ target, which a
> conformant controller shouldn't produce. The device still returns to
> NCI_DISCOVERY/NCI_IDLE through the normal RF_DEACTIVATE path.

Thanks, I agree with your analysis.

> > [Severity: Critical]
> > This isn't a bug introduced by this patch, but can the ntf union copy
> > uninitialized stack memory into persistent device structures?
> > 
> > In net/nfc/nci/ntf.c:nci_rf_discover_ntf_packet(), the local ntf struct
> > is declared on the stack:
> > 
> >      struct nci_rf_discover_ntf ntf;
> > 
> > If the incoming packet has ntf.rf_tech_specific_params_len == 0, the
> > extraction routines are bypassed, leaving the rf_tech_specific_params union
> > uninitialized. The struct is then passed to nci_add_new_target():
> > 
> >      if (add_target == true)
> >          nci_add_new_target(ndev, &ntf);
> > 
> > This eventually calls nci_add_new_protocol(), which blindly reads from this
> > union:
> > 
> >      nfca_poll = (struct rf_tech_specific_params_nfca_poll *)params;
> >      target->sens_res = nfca_poll->sens_res;
> >      target->sel_res = nfca_poll->sel_res;
> >      target->nfcid1_len = nfca_poll->nfcid1_len;
> > 
> > Could this uninitialized stack garbage be copied into ndev->targets, and
> > later broadcasted to userspace via Netlink in nfc_targets_found()?
> 
> I managed to repro this issue locally via KMSAN, I can queue up a patch
> for this that I can submit separately, ntf just needs to be zero-initd.

Thanks, I agree this can be handled separately.

> > [Severity: Critical]
> > This isn't a bug introduced by this patch, but does the general bytes length
> > calculation underflow?
> > 
> > In net/nfc/nci/ntf.c:nci_store_general_bytes_nfc_dep():
> > 
> >      ndev->remote_gb_len = min_t(__u8,
> >          (ntf->activation_params.listen_nfc_dep.atr_req_len -
> >           NFC_ATR_REQ_GT_OFFSET), NFC_ATR_REQ_GB_MAXSIZE);
> > 
> >      memcpy(ndev->remote_gb,
> >          (ntf->activation_params.listen_nfc_dep.atr_req +
> >           NFC_ATR_REQ_GT_OFFSET), ndev->remote_gb_len);
> > 
> > The length is computed by subtracting NFC_ATR_REQ_GT_OFFSET (14) from
> > atr_req_len. If atr_req_len is less than 14, this subtraction will
> > underflow.
> > 
> > Because of the min_t cast, this large underflowed value is bounded to
> > NFC_ATR_REQ_GB_MAXSIZE (48). The memcpy() then copies 48 bytes starting
> > from atr_req + 14 into ndev->remote_gb.
> > 
> > Since the source buffer is part of the ntf union allocated on the stack
> > in nci_rf_intf_activated_ntf_packet(), could this leak up to 48 bytes of
> > uninitialized kernel stack memory to userspace?
> 
> This one is already being fixed on the list:
> 
> [PATCH net v4 1/5] nfc: nci: fix u8 underflow in
> nci_store_general_bytes_nfc_dep  (Lekë Hapçiu)
> https://lore.kernel.org/all/20260424180151.3808557-2-snowwlake@icloud.com/

Ack.

> > [Severity: High]
> > This isn't a bug introduced by this patch, but does the lack of skb->len
> > validation in NCI response handlers allow out-of-bounds reads?
> > 
> > In nci_core_init_rsp_packet_v1() in net/nfc/nci/rsp.c, fields are read
> > and arrays are copied from the payload:
> > 
> >      ndev->num_supported_rf_interfaces =
> >          rsp_1->num_supported_rf_interfaces;
> > 
> >      memcpy(ndev->supported_rf_interfaces, rsp_1->supported_rf_interfaces,
> >             ndev->num_supported_rf_interfaces);
> > 
> > Similarly in nci_core_init_rsp_packet_v2():
> > 
> >      while (rf_interface_idx < ndev->num_supported_rf_interfaces) {
> >          ndev->supported_rf_interfaces[rf_interface_idx++] =
> >              *supported_rf_interface++;
> >      }
> > 
> > Since the NCI control header is stripped via skb_pull(), leaving the
> > payload length in skb->len, what happens if an NFCC sends a short response
> > packet (e.g. plen = 1)? Could this cause the handlers to read adjacent
> > kernel slab memory?
> 
> I've since submitted a fix for this issue:
> 
> [PATCH net] nfc: nci: fix uninit-value in
> nci_core_init_rsp_packet()
> https://lore.kernel.org/netdev/20260623222402.175798-1-sam@bynar.io/

Ack.

> > [Severity: High]
> > This isn't a bug introduced by this patch, but is there a missing boundary
> > validation when extracting activation parameters?
> > 
> > In net/nfc/nci/ntf.c:nci_extract_activation_params_iso_dep():
> > 
> >      nfca_poll->rats_res_len = min_t(__u8, *data++, NFC_ATS_MAXSIZE);
> >      if (nfca_poll->rats_res_len > 0) {
> >          memcpy(nfca_poll->rats_res, data, nfca_poll->rats_res_len);
> >      }
> > 
> > And in nci_extract_activation_params_nfc_dep():
> > 
> >      poll->atr_res_len = min_t(__u8, *data++, NFC_ATR_RES_MAXSIZE - 2);
> >      if (poll->atr_res_len > 0)
> >          memcpy(poll->atr_res, data, poll->atr_res_len);
> > 
> > These inner lengths are bounded by a maximum size like NFC_ATS_MAXSIZE, but
> > they are not validated against the remaining bytes in the SKB (skb->len).
> > 
> > If a malformed packet provides a large inner length but a short payload,
> > could this memcpy() read out of bounds into the device structure,
> > potentially leaking adjacent slab memory to userspace later?
> 
> This one is already being fixed on the list too:
> 
> [PATCH v3] nfc: nci: add data_len bound checks to activation
> parameter extractors  (Bryam Vargas)
> https://lore.kernel.org/all/20260612-b4-disp-6d52d8b0-v3-1-e26221f8826d@proton.me/

Ack.

> > [Severity: High]
> > This isn't a bug introduced by this patch, but is there a potential
> > priority inversion or timeout deadlock involving the device lock?
> > 
> > Functions like nfc_stop_poll() in net/nfc/core.c acquire the device lock:
> > 
> >      device_lock(&dev->dev);
> >      ...
> >      if (dev->ops->stop_poll)
> >          dev->ops->stop_poll(dev);
> > 
> > This eventually calls nci_request(), which synchronously waits for a
> > completion signaled by the nci_rx_work thread. However, if an NTF packet
> > is received first, nci_rx_work processes it and invokes
> > nfc_targets_found(), which also attempts to acquire the device lock:
> > 
> >      device_lock(&dev->dev);
> > 
> > Since the calling thread already holds the device lock, nci_rx_work blocks
> > indefinitely. Because the RX worker is blocked, it cannot process the
> > pending RSP, causing nci_request() to time out and fail. Could this
> > deadlock the RX thread?
> 
> No patch for this one, although I'm not sure how accurate it is.

With the above in mind, this now looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

