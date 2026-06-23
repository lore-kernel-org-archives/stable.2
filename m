Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7330C162
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254009; cv=none; b=j1wEUcgvN9IQ0+x/Kzi3ZInjp0i1dPbjKL6QyQosDQthNVvtY5IxV+xCjfSh2AEDx52tOyEFmiJVNXlJ49/bN4d6jXgkQegdUKSQBHSpnw3nAFGu+7qNTSlvOk2iy5hFqKS8kfR/ds3olcuMrP9f1rVhKl8lczarg/S/1zC/bkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254009; c=relaxed/simple;
	bh=28fitR7AD3p5MIhLTudcCTvDU4SWVERttyDPYSu3Y2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnobGEuD5gK4BrC2Cbr/UG+j2yxtzmtkLrhrETLrmDl0n1+8DGhe2p4mPZdT9dKad9hwB9aTnoY+vitOpNJw92ua5hOR8EVklWU4dPv3E341e39iVfip0lpMb3rEW+ehYhDDMRPGgMYHMGF627k66fu5Vw6UUEi3y4/6rAuyxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=Uadk5vg0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="Uadk5vg0"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-693c51a8a19so594176a12.3
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782254006; x=1782858806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQe2zkk4/rX7iIUXwjPWxzQOps0a3V9iYGHKEVDhy8o=;
        b=Uadk5vg0yJWg2f0ravOpdU6TFLnE+Zs1Qj//ttPrWAU5ID4ir4XOez7+9m/cVncHnD
         hMLvA6JzzmZRNemRVK95Xg9Lp2eslpmGJdgSsJiKd4NKMOfT3iitXR/xPXgPyy90j77s
         bg1QPPidpUWBBNBAtfSMcgJXPVDDVqZMt2fTJIwR8mNiesAmvKTHihsOfe8ygezqUZ9r
         0U+2XtdhFo84EfEIecd/lEkzWy7I9ao1y8TAmMk7uAijQLnXu/LX3xZf61hL3a88R5fY
         Yuy1ItkWGm84kIEo+IteHVdOy1eCxfcz2Y9I0doz3uBaADi6JNaF8KpcyG7A8stHiPSn
         1f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782254006; x=1782858806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQe2zkk4/rX7iIUXwjPWxzQOps0a3V9iYGHKEVDhy8o=;
        b=Oib6ISJ6/csfTFOaVetkQ5ZcfwEpssZHC/pP+ppUBQ5LVoGMZ822dZrD+T2uIaA0F1
         GcEKSW/ffTCVpA1wR8zbjCFQ2LrlYia6AjoL1DjpwlOpcnYeV4MbhrA9K1OCLngy/fK4
         0pL8o0pISPqE93GYXP6IXLK0US1+IzNocFrLcNy/horrAm1ZxqUV0s9FrA7IhJ6n2d0a
         SuAv5l19zHHyGkJLKgoPo7yvCA0+YIc+9IcnHdhUIvfrzD0Epj4T9XWiXbyKdk2oVcgx
         SUsqE3SqqrCA3+jDnTDMPI392ECEMZSUDBcH2erXwr5GBy2jBB9sRo2MGc8AHEBBoEjZ
         XE6w==
X-Forwarded-Encrypted: i=1; AFNElJ+8woyW3fiVMeiVzmfPpc2I6i/EbQVx50WbXWv1IdNENLYoEsKVWv8FStEzY1X+MNd4vq5avG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRG0dqiQY/k3aMchpCT1KjiUj+5J+vFSmunE6UuV4uPJY57DWY
	1CfvoGeYSglliOR8grUr9uWJVSrWyNwwMjdhBL6BExquO7QYpa92kXr2BeN8gHFBuUJK
X-Gm-Gg: AfdE7cna/qouKElNAu/BO+J0RICsZQls6/wbeV6frjEl227kMaq1ZStXctaAKLR9qvR
	o3Qe/OwFPMpXuZpY1aA6TZcokJ+X6ru6igU9dJT/Tf9QiAkNZyCrI+QvQ7CivWPyn4pqg9wrxrG
	g1Fts61U5F89pzQvKYPVyqubwobANL+smCs+m8dnLSs1hc6tPD0FtriuY7ubuMGspxphNQkdgZp
	10ku/jSHDEV+K8DbIKreAgHGlA4wbETmGsZIQo85/NFKDcnqzj8dX1PKiWOAwfWWDqNbIEGfgtJ
	+OPc6hm0hWzMWhHxbh075/h8dKaBPWn0KGGazlpywwAIsHtnU7YDvH6h1Qg7vg8aXCzsnkJN9FL
	LM9YJstlpWrWdaoqPX0Pd9d2NQ7v+3v9eyhGGBLxKW4ZggqlsbOiNxyqndGVN1v9UNwy1w34XvH
	3j1D3VeSPKS+pcVYlGfs4aCByXnhS+qLZbhxG/EzLWASjtAEQhYbaca4D2
X-Received: by 2002:a05:6402:190b:b0:697:98dc:1196 with SMTP id 4fb4d7f45d1cf-697db815650mr2261536a12.0.1782254006268;
        Tue, 23 Jun 2026 15:33:26 -0700 (PDT)
Received: from ?IPV6:2a06:61c2:d427:0:b321:1c7a:b072:326e? ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bd44d0sm125957a12.29.2026.06.23.15.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 15:33:23 -0700 (PDT)
Message-ID: <443e2ee1-e9c1-45ca-be57-0c67966ec7d9@bynar.io>
Date: Wed, 24 Jun 2026 00:33:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfc: nci: fix out-of-bounds write in
 nci_target_auto_activated()
To: Simon Horman <horms@kernel.org>
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260622145243.3167276-1-sam@bynar.io>
 <20260623172109.1105965-2-horms@kernel.org>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <20260623172109.1105965-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/06/2026 19:21, Simon Horman wrote:
>> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
>> index c96512bb86531..566ca839fa488 100644
>> --- a/net/nfc/nci/ntf.c
>> +++ b/net/nfc/nci/ntf.c
>> @@ -603,6 +603,12 @@ static void nci_target_auto_activated(struct nci_dev *ndev,
>>       struct nfc_target *target;
>>       int rc;
>>
>> +    /* This is a new target, check if we've enough room */
>> +    if (ndev->n_targets == NCI_MAX_DISCOVERED_TARGETS) {
>> +        pr_debug("not enough room, ignoring new target...\n");
>> +        return;
>
> [Severity: High]
> Does this early return cause the state machine to stall?
>
> Looking at nci_rf_intf_activated_ntf_packet(), the state is transitioned
> to NCI_POLL_ACTIVE right before this function is called:
>
> net/nfc/nci/ntf.c:nci_rf_intf_activated_ntf_packet() {
>      ...
>      atomic_set(&ndev->state, NCI_POLL_ACTIVE);
>      if (err == NCI_STATUS_OK)
>          nci_target_auto_activated(ndev, &ntf);
>      ...
> }
>
> Because of the early return here, nfc_targets_found() is skipped. Does this
> leave the state wedged in NCI_POLL_ACTIVE, permanently blocking future
> attempts to stop polling since nci_stop_poll() requires the state to be
> NCI_DISCOVERY?
>
>> +    }
>> +
>>       target = &ndev->targets[ndev->n_targets];
>
> [ ... ]

Thanks for sharing the review.

I don't believe the early return can stall the state machine, as
nci_target_auto_activated() does not touch ndev->state.

nci_rf_intf_activated_ntf_packet() sets ndev->state = NCI_POLL_ACTIVE
before it calls nci_target_auto_activated(), so the transition has
already happened by the time the new check runs. Neither
nci_target_auto_activated() nor nfc_targets_found() modifies ndev->state;
nfc_targets_found() only clears the nfc_dev dev->polling flag under
device_lock, which is independent of the NCI state machine that
nci_stop_poll() tests. So ndev->state is NCI_POLL_ACTIVE after an
auto-activation whether the target is appended or the guard returns
early; the state behaviour is the same with or without this patch.

The check is the same n_targets == NCI_MAX_DISCOVERED_TARGETS guard the
sibling nci_add_new_target() (the RF_DISCOVER_NTF path) has used since
the Fixes: commit; it only drops the out-of-spec 11th+ target, which a
conformant controller shouldn't produce. The device still returns to
NCI_DISCOVERY/NCI_IDLE through the normal RF_DEACTIVATE path.

> [Severity: Critical]
> This isn't a bug introduced by this patch, but can the ntf union copy
> uninitialized stack memory into persistent device structures?
>
> In net/nfc/nci/ntf.c:nci_rf_discover_ntf_packet(), the local ntf struct
> is declared on the stack:
>
>      struct nci_rf_discover_ntf ntf;
>
> If the incoming packet has ntf.rf_tech_specific_params_len == 0, the
> extraction routines are bypassed, leaving the rf_tech_specific_params union
> uninitialized. The struct is then passed to nci_add_new_target():
>
>      if (add_target == true)
>          nci_add_new_target(ndev, &ntf);
>
> This eventually calls nci_add_new_protocol(), which blindly reads from this
> union:
>
>      nfca_poll = (struct rf_tech_specific_params_nfca_poll *)params;
>      target->sens_res = nfca_poll->sens_res;
>      target->sel_res = nfca_poll->sel_res;
>      target->nfcid1_len = nfca_poll->nfcid1_len;
>
> Could this uninitialized stack garbage be copied into ndev->targets, and
> later broadcasted to userspace via Netlink in nfc_targets_found()?

I managed to repro this issue locally via KMSAN, I can queue up a patch
for this that I can submit separately, ntf just needs to be zero-initd.

> [Severity: Critical]
> This isn't a bug introduced by this patch, but does the general bytes length
> calculation underflow?
>
> In net/nfc/nci/ntf.c:nci_store_general_bytes_nfc_dep():
>
>      ndev->remote_gb_len = min_t(__u8,
>          (ntf->activation_params.listen_nfc_dep.atr_req_len -
>           NFC_ATR_REQ_GT_OFFSET), NFC_ATR_REQ_GB_MAXSIZE);
>
>      memcpy(ndev->remote_gb,
>          (ntf->activation_params.listen_nfc_dep.atr_req +
>           NFC_ATR_REQ_GT_OFFSET), ndev->remote_gb_len);
>
> The length is computed by subtracting NFC_ATR_REQ_GT_OFFSET (14) from
> atr_req_len. If atr_req_len is less than 14, this subtraction will
> underflow.
>
> Because of the min_t cast, this large underflowed value is bounded to
> NFC_ATR_REQ_GB_MAXSIZE (48). The memcpy() then copies 48 bytes starting
> from atr_req + 14 into ndev->remote_gb.
>
> Since the source buffer is part of the ntf union allocated on the stack
> in nci_rf_intf_activated_ntf_packet(), could this leak up to 48 bytes of
> uninitialized kernel stack memory to userspace?

This one is already being fixed on the list:

[PATCH net v4 1/5] nfc: nci: fix u8 underflow in
nci_store_general_bytes_nfc_dep  (Lekë Hapçiu)
https://lore.kernel.org/all/20260424180151.3808557-2-snowwlake@icloud.com/

> [Severity: High]
> This isn't a bug introduced by this patch, but does the lack of skb->len
> validation in NCI response handlers allow out-of-bounds reads?
>
> In nci_core_init_rsp_packet_v1() in net/nfc/nci/rsp.c, fields are read
> and arrays are copied from the payload:
>
>      ndev->num_supported_rf_interfaces =
>          rsp_1->num_supported_rf_interfaces;
>
>      memcpy(ndev->supported_rf_interfaces, rsp_1->supported_rf_interfaces,
>             ndev->num_supported_rf_interfaces);
>
> Similarly in nci_core_init_rsp_packet_v2():
>
>      while (rf_interface_idx < ndev->num_supported_rf_interfaces) {
>          ndev->supported_rf_interfaces[rf_interface_idx++] =
>              *supported_rf_interface++;
>      }
>
> Since the NCI control header is stripped via skb_pull(), leaving the
> payload length in skb->len, what happens if an NFCC sends a short response
> packet (e.g. plen = 1)? Could this cause the handlers to read adjacent
> kernel slab memory?

I've since submitted a fix for this issue:

[PATCH net] nfc: nci: fix uninit-value in
nci_core_init_rsp_packet()
https://lore.kernel.org/netdev/20260623222402.175798-1-sam@bynar.io/

> [Severity: High]
> This isn't a bug introduced by this patch, but is there a missing boundary
> validation when extracting activation parameters?
>
> In net/nfc/nci/ntf.c:nci_extract_activation_params_iso_dep():
>
>      nfca_poll->rats_res_len = min_t(__u8, *data++, NFC_ATS_MAXSIZE);
>      if (nfca_poll->rats_res_len > 0) {
>          memcpy(nfca_poll->rats_res, data, nfca_poll->rats_res_len);
>      }
>
> And in nci_extract_activation_params_nfc_dep():
>
>      poll->atr_res_len = min_t(__u8, *data++, NFC_ATR_RES_MAXSIZE - 2);
>      if (poll->atr_res_len > 0)
>          memcpy(poll->atr_res, data, poll->atr_res_len);
>
> These inner lengths are bounded by a maximum size like NFC_ATS_MAXSIZE, but
> they are not validated against the remaining bytes in the SKB (skb->len).
>
> If a malformed packet provides a large inner length but a short payload,
> could this memcpy() read out of bounds into the device structure,
> potentially leaking adjacent slab memory to userspace later?

This one is already being fixed on the list too:

[PATCH v3] nfc: nci: add data_len bound checks to activation
parameter extractors  (Bryam Vargas)
https://lore.kernel.org/all/20260612-b4-disp-6d52d8b0-v3-1-e26221f8826d@proton.me/

> [Severity: High]
> This isn't a bug introduced by this patch, but is there a potential
> priority inversion or timeout deadlock involving the device lock?
>
> Functions like nfc_stop_poll() in net/nfc/core.c acquire the device lock:
>
>      device_lock(&dev->dev);
>      ...
>      if (dev->ops->stop_poll)
>          dev->ops->stop_poll(dev);
>
> This eventually calls nci_request(), which synchronously waits for a
> completion signaled by the nci_rx_work thread. However, if an NTF packet
> is received first, nci_rx_work processes it and invokes
> nfc_targets_found(), which also attempts to acquire the device lock:
>
>      device_lock(&dev->dev);
>
> Since the calling thread already holds the device lock, nci_rx_work blocks
> indefinitely. Because the RX worker is blocked, it cannot process the
> pending RSP, causing nci_request() to time out and fail. Could this
> deadlock the RX thread?

No patch for this one, although I'm not sure how accurate it is.

Thanks,
Sam
