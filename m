Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C422B594;
	Fri,  7 Aug 2026 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107007; cv=none; b=qQk2k5w+xaZKJ6RJ//omXd2dFFXOgoF6lJs3N0KG0djeP4VrR2QffMUIJ8KvNvQqgoNN6Ke8U6XNKVxn29qtHp70magScek3eaH27hgEJybOO9lsEFOc6cnDkqNAC5VIlKvRGZhZZ+96eYGR3u5JMd/aiBu6IQlTgUIPUFGXBCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107007; c=relaxed/simple;
	bh=Ygwoxj/qtp59qkhR0JC9cNOQGDSxqQ2MhDy99C2cWdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlmHZSQwJz6z8rWHmpVIdQORNw/xquo/XONOB50ED1xuJnpCxBX9Q+oobE0aeSMCvhae9DcPA25rGeKbUKhtEzfGrNL4CnXDqUvera3n8eKGzT/6+RhpcZqKzwigEEC9W0c577V3Q/FoS9b13U3IAnQnoECMzrOstZGt9XwofyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipBLdBfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipBLdBfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4BA1F000E9;
	Fri,  7 Aug 2026 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786106999;
	bh=722Cc1Rl8cvrCGD72DvJ3L0CwBbXdiDoCrPoTA21Xws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ipBLdBfGx6IZkiJDEZqLnWgNdmWisrNOaej1LpO0yS+bLonBHqXpNYi4l1W4nxtJ7
	 a1CRNf05shtsMT2gkkhF3huVkGeAg6lOHXYLXmuGd+yggQKODrPx7OAgZURJcDHDFv
	 9eYA+42hnN1iojNYNczE+cp6cFyG7skpqDraUT/F4o8K0tlVtmz2srZZQCgri5sL5Z
	 sq+Q1dTvISiUmPEF6JBVYUSRKh1zAJ/eqco41HsExaJb/ert6VuGINE57UnNpzcmwq
	 5Aw3QOK0jipV+TqA/u4VKRyA+Oha3MnJ4OL1I+4z4MhWCyj+DX2NhD+Vn+6hiausPN
	 p1ZulrTZxLnIQ==
From: Simon Horman <horms@kernel.org>
To: fanwu01@zju.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: mana: fix reset work race with device removal
Date: Fri,  7 Aug 2026 13:49:45 +0100
Message-ID: <20260807124945.713853-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805143812.220509-1-fanwu01@zju.edu.cn>
References: <20260805143812.220509-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805143812.220509-1-fanwu01@zju.edu.cn?part=1
---
--- Patch [1]: [PATCH net] net: mana: fix reset work race with device removal ---
commit 789cdee15635f51361a37bb4e10ca06127d69f71
Author: Fan Wu <fanwu01@zju.edu.cn>

net: mana: fix reset work race with device removal

The patch makes mana_serv_reset() take the driver-core device lock around
the pci_get_drvdata() read and the whole reset sequence, drops the lock
before calling mana_serv_rescan(), and has mana_gd_remove() clear the PCI
drvdata before vfree()ing the gdma_context.  It also clears GC_IN_SERVICE
on the resume-failure exit before rescanning.

A couple of questions about the new locking and the new clear_bit().

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index e8b7ffb47eb98..ae03d7a53348e 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -591,15 +591,16 @@ static void mana_serv_fpga(struct pci_dev *pdev)
>  
>  static void mana_serv_reset(struct pci_dev *pdev)
>  {
> -	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	struct gdma_context *gc;
>  	struct hw_channel_context *hwc;
>  	int ret;
>  
> +	device_lock(&pdev->dev);
> +	gc = pci_get_drvdata(pdev);

[Severity: High]
[Finding: fable-5-5-8]
[Sources: fable-5, opus-5]
Is it intended that &pdev->dev's mutex is now held across the entire reset
cycle rather than just the drvdata read?  With the new labels the lock is
only dropped at out: and rescan:, so it covers this part of
mana_serv_reset():

	mana_gd_suspend(pdev, PMSG_SUSPEND);

	msleep(MANA_SERVICE_PERIOD * 1000);

	ret = mana_gd_resume(pdev);

That is an unconditional 10 second msleep(), plus mana_gd_resume(), which
re-runs mana_gd_setup()/mana_probe()/mana_rdma_probe(); the first HWC
command there can wait up to HW_CHANNEL_WAIT_RESOURCE_TIMEOUT_MS (30000
ms) when the adapter is unresponsive.

This runs from a system_wq work item (mana_serv_func() -> mana_do_service()
-> mana_serv_reset()), so everything that serializes on the same device
mutex blocks for that whole time:

  device_release_driver_internal() -> __device_driver_lock()  (sysfs
    unbind, driver removal)
  device_shutdown()  (reboot/shutdown, takes device_lock(parent) plus
    device_lock(dev))
  drivers/base/power/main.c device_suspend()/device_resume(), which arm
    the DPM watchdog before taking device_lock(dev)
  pci_stop_and_remove_bus_device() -> pci_stop_dev() ->
    device_release_driver(), which blocks on this mutex while holding the
    global pci_rescan_remove_lock

Can this stall system suspend/resume, reboot and all PCI hotplug/rescan on
the machine for tens of seconds?  And with CONFIG_DPM_WATCHDOG set below
the hold time, would the PM core's watchdog fire because it is armed before
device_lock()?

The trigger is not driver-internal: mana_schedule_serv_work() is called
from mana_gd_process_eqe() for a device-supplied
GDMA_EQE_HWC_RESET_REQUEST, and GC_IN_SERVICE only prevents overlap, not
back-to-back requests.

Would narrowing the lock to the pci_get_drvdata() read, and getting the
lifetime guarantee from a driver-private mutex, a refcounted
gdma_context, or cancelling the service work in mana_gd_remove(), be
enough for the stated goal?

There is also a structural concern with the wide hold: under this lock the
code reaches mana_rdma_remove() (flush_workqueue(gc->service_wq)),
mana_gd_cleanup_device() (destroy_workqueue(gc->service_wq)) and
mana_remove() (disable_work_sync(&apc->queue_reset_work),
cancel_delayed_work_sync(&ac->gf_stats_work), rtnl_lock()).  Would a later
flush or cancel of the service work from the remove path then deadlock
against this lock?

>  	if (!gc) {
>  		/* Perform PCI rescan on device if GC is not set up */
>  		dev_err(&pdev->dev, "MANA service: GC not setup, rescanning\n");
> -		mana_serv_rescan(pdev);
> -		return;
> +		goto rescan;
>  	}
>  
>  	hwc = gc->hwc.driver_data;
> @@ -621,8 +622,8 @@ static void mana_serv_reset(struct pci_dev *pdev)
>  	if (ret == -ETIMEDOUT || ret == -EPROTO) {
>  		/* Perform PCI rescan on device if we failed on HWC */
>  		dev_err(&pdev->dev, "MANA service: resume failed, rescanning\n");
> -		mana_serv_rescan(pdev);
> -		return;
> +		clear_bit(GC_IN_SERVICE, &gc->flags);
> +		goto rescan;
>  	}

[Severity: Medium]
[Finding: fable-5-2-2]
[Sources: fable-5, opus-5]
Does clearing GC_IN_SERVICE before the rescan change the service gating
semantics on this exit?  Previously this path returned with the bit still
set, and it only stopped mattering because mana_serv_rescan() removed the
device and vfree()d gc (a freshly probed device starts with flags == 0).

GC_IN_SERVICE looks like the only "a service cycle is in flight" gate:

  mana_schedule_serv_work():
	if (test_and_set_bit(GC_IN_SERVICE, &gc->flags)) {
		dev_info(gc->dev, "Already in service\n");
		return -EBUSY;
	}

  mana_tx_timeout() in mana_en.c:
	/* Already in service, hence tx queue reset is not required.*/
	if (test_bit(GC_IN_SERVICE, &gc->flags))
		return;

With the bit cleared first, the flag reads "not in service" for the whole
teardown window: device_unlock() happens, then mana_serv_rescan() can block
for a long time on pci_lock_rescan_remove() and again on device_lock inside
pci_stop_and_remove_bus_device() -> pci_stop_dev() ->
device_release_driver().

Is that window reachable with the HWC still alive?  mana_gd_resume()
returns -ETIMEDOUT when mana_rdma_probe() -> mana_gd_register_device()
times out on HWC, and in that case only mana_rdma_remove() has been undone
- the HWC channel, its EQ and the MSI-X IRQs are still up and the netdevs
are still registered.  In that state two triggers can queue a second
service work:

  mana_gd_process_eqe()          (incoming GDMA_EQE_HWC_RESET_REQUEST)
      -> mana_schedule_serv_work()

  mana_gf_stats_work_handler()   (re-arms every 2 s, on -ETIMEDOUT)
      -> mana_schedule_serv_work(gc, GDMA_EQE_HWC_RESET_REQUEST)

Can that second work then win the unfair device_lock ahead of the in-flight
removal, observe a still non-NULL gc, and run another full
mana_gd_suspend() + msleep(10 s) + mana_gd_resume() cycle while the first
work is stuck inside pci_stop_and_remove_bus_device() holding
pci_rescan_remove_lock?

Separately, with the bit cleared, is mana_tx_timeout() still suppressed
during teardown, or can it now queue apc->queue_reset_work and drive HWC
and queue programming against an adapter that just requested a reset and is
being removed?

The commit message describes this hunk only as:

    Also clear GC_IN_SERVICE before rescanning after a failed resume, so
    this exit follows the same service-state cleanup as the other reset
    exits.

Could the changelog also mention the change in service-gating behaviour,
given this is tagged for stable?

>  
>  	if (ret)
> @@ -632,6 +633,12 @@ static void mana_serv_reset(struct pci_dev *pdev)
>  
>  out:
>  	clear_bit(GC_IN_SERVICE, &gc->flags);
> +	device_unlock(&pdev->dev);
> +	return;
> +
> +rescan:
> +	device_unlock(&pdev->dev);
> +	mana_serv_rescan(pdev);
>  }

[ ... ]
