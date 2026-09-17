Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C881A1A6836;
	Thu, 17 Sep 2026 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669499; cv=none; b=BQziwqBM/w79T4CmNoTsXUlPGZdIu5fx7JxFYaQ3MKvJrk2v8/hA1xAde8XjL2hSF8SLGfEsvJ09n+2OLucAglE2pfANzYC2XRE4NAdp4a8SvG3zfULAJUnJfZGa1h1ew1nDkbRv67KRylmxFNN5XwXaroYenyZOWqcq3YrAWUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669499; c=relaxed/simple;
	bh=8e1dPrUTnLBwBwEMbNEttt1Sx4JtLkqfdrr17FZAlwI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fZQDTMJKhmzDLTZIIxcZB1QSyM8J46JnvRMk4E5iGiktIZfOZMxv0jELD8sjfwjAY1ZLyjreDr7S8MrC8lTwvK7sfyMTjjOUmBYIvqnrsGUHa26fsrP6rkYi7MOobgme7UY29MQ2s4sG8w6ELGX8tIc5FajXuq/7OkZ0wVdMxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtm1mn3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtm1mn3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0F81F000FF;
	Thu, 17 Sep 2026 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789669497;
	bh=/nY8RO6WqJu16RviD7GM6BbJ+XOyelc15xIa8cC6knU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vtm1mn3RUlAp2U07ZczmrXLCSDXQMZtSQ3K4WAObvkQ0baY8AkT4RAcgcmANVCPrT
	 2JTyUlvmgZPJPZC2tOkulAFfYX/KP+hJiY7uEM8YIQBWtyMJyNY17v7RBSiMckWCVA
	 qPBKisLLo1tAcC0dTHMEYziUf8jdXwXBushLbOEpKesD3ZNnZk4IpjmXmt99aqHIZZ
	 i9UbiyTZIMgUZjM3JtaIUwNJV7Md1q71K+5eB0YkRyZhvG7hwfAImgtcEXFIpTuxlT
	 lVcuAW7VnyKXqU8Tf7O0OWUOm05q2G8uFO/slhFWLlxHDjbyVGd6doXUQbEANZwVAe
	 yKo5cNzAV8RDg==
Subject: Re: [PATCH] net: hinic3: unregister event callback on remove
From: netdev-bot+sashiko@kernel.org
To: lgs201920130244@gmail.com
Cc: gongfan1@huawei.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, gur.stavi@huawei.com,
 guoxin09@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 17 Sep 2026 18:24:56 +0000
Message-ID: <178966949630.22033.16226469760988787498@kernel.org>
In-Reply-To: <20260916032427.2899987-1-lgs201920130244@gmail.com>
References: <20260916032427.2899987-1-lgs201920130244@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

- [Medium] The commit message asserts a live use-after-free ("If an event
  is delivered after the NIC private data has been released, the…

Pre-existing issues:
- [Medium] hinic3_del_one_adev()
  (drivers/net/ethernet/huawei/hinic3/hinic3_lld.c:94-113) implements…

--

net: hinic3: unregister event callback on remove

This adds a hinic3_adev_event_unregister() call at the start of
hinic3_nic_remove() so the auxiliary device event callback is cleared before
the NIC device is torn down, matching what the probe failure paths already
do.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> index 0a888fe4c975b..42e2ad179a9f5 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> @@ -499,6 +499,8 @@ static void hinic3_nic_remove(struct auxiliary_device *adev)
>  	if (!hinic3_support_nic(nic_dev->hwdev))
>  		return;
>  
> +	hinic3_adev_event_unregister(adev);
> +

[Severity: Medium]
Is there an event delivery path in this tree that can actually reach
hinic3_nic_event()?

The commit message says:

    If an event is delivered after the NIC private data has been released,
    the callback may dereference the freed nic_dev and netdev objects.

Grepping drivers/net/ethernet/huawei/hinic3/ shows the only accesses to
struct hinic3_adev::event are the two assignments:

  hinic3_lld.c:hinic3_adev_event_register() {
	hadev = container_of(adev, struct hinic3_adev, adev);
	hadev->event = event_handler;
  }

  hinic3_lld.c:hinic3_adev_event_unregister() {
	hadev = container_of(adev, struct hinic3_adev, adev);
	hadev->event = NULL;
  }

Nothing loads and calls hadev->event.  The hardware event paths that do
exist dispatch through aeqs->aeq_cb[] / ceqs->ceq_cb[] in hinic3_eqs.c, and
hinic3_nic_event() is referenced only as the argument to the
hinic3_adev_event_register() call in hinic3_nic_probe().

If that is correct, then this change restores register/unregister symmetry
but does not close a reachable failure.  Should the Fixes: tag for
17fcb3dc12bb and the Cc: stable@vger.kernel.org be dropped, and the message
reworded as a symmetry or cleanup change?  Alternatively, could the concrete
dispatch path that makes the dereference reachable be named in the message?

One further note for whenever a dispatcher is added: clearing a plain
function pointer gives no barrier against a call that is already in flight,
so the symmetry alone would not be sufficient there either.

[Severity: Medium]
This isn't a bug introduced by this patch, but the event-versus-teardown
exclusion that this ordering change leans on is a hand-rolled bit lock in
hinic3_del_one_adev():

  hinic3_lld.c:hinic3_del_one_adev() {
	timeout = read_poll_timeout(test_and_set_bit, state, !state,
				    HINIC3_EVENT_POLL_SLEEP_US,
				    HINIC3_EVENT_POLL_TIMEOUT_US,
				    false, svc_type, &pci_adapter->state);

	hadev = pci_adapter->hadev[svc_type];
	auxiliary_device_delete(&hadev->adev);
	auxiliary_device_uninit(&hadev->adev);
	pci_adapter->hadev[svc_type] = NULL;
	if (!timeout)
		clear_bit(svc_type, &pci_adapter->state);
  }

The bit svc_type of pci_adapter->state is set on entry and cleared on exit
to guard a code region, which is invisible to lockdep and provides no
ordering or fairness guarantees.

Does this loop also fail open?  On -ETIMEDOUT the bit was never acquired,
yet auxiliary_device_delete() / auxiliary_device_uninit() run anyway, which
drives hinic3_nic_remove() and free_netdev() while, by the code's own
assumption, another context still owns the bit.

On that same timeout path clear_bit() is skipped, so the bit stays set for
that service type.  Would every later add or delete of that service then
burn the full HINIC3_EVENT_POLL_TIMEOUT_US poll and fail open again?

Since the callers already hold pci_adapter->pdev_mutex, could that mutex
plus a synchronous flush or cancel of the event source replace the bit
entirely?

Today the only accesses to pci_adapter->state are the test_and_set_bit and
clear_bit above, so the first test_and_set_bit always observes the bit clear
and the timeout branch is not reachable, but that changes as soon as event
dispatch is added.

>  	netdev = nic_dev->netdev;
>  	unregister_netdev(netdev);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916032427.2899987-1-lgs201920130244%40gmail.com
