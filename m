Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39EA2AD3F
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643099; cv=none; b=E8cJO1LUqY3tm8T0SjNgnXemeVk8OinfQIgUOcTamZY/uoS2kVB3DEJw6idRPz3rhX6/GJ5DPhuPy+A4SErrMESCIY2dyAg1KLdO9G6kie8W2/gQSnuApy38A2KGQX6xIR3yS8XKZLPT6M676I8/pCefEO6iU8u+nCOCmZ+lXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643099; c=relaxed/simple;
	bh=aPeneUJ9pSTCNH1yd0Xp2mR4wGP6AFF7EJoEaS9UoiM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tpcIQaGgIRcajNtu1i2GQhsFUJlH43SHNri/bE2HfELLPgOS5m013vFAoUFff9fin5se1ErOO+f0C/YJlJJOyTVMWMVGkTjxT3+CcimSQk4Ld7HmDE22CmFfNWIwypbaYu7ax2BqTJhsw8Z2jnTbvrtmvWEFV2lGsjUfQ6Ppd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--eddiephillips.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tesAIww0; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--eddiephillips.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tesAIww0"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8478423e020so569047b3a.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 17:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783643097; x=1784247897; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x5jkh5eR7LJ5Z4DoKrzx2T4miH2hlilFiG/ybzcUBjc=;
        b=tesAIww0Xr1uFp3O34m5UisarsHxj8sKVeb2ZQIksETjU+RF8R59+SotjeC93W+xQ+
         GAZRyDFDgeFnb4nx0rT/utzMg61xpwMCkziTDjoqQUJVhl7Ygk0AcjOvYaCNHyWcX7ib
         dwrsjiRB727r+/Qo8BXTRS0EL9fIurq0OFFEoFXIgr9XLYESjOTxJ78usnDqQeYZdDOR
         uMBtJnPvA/uYXWI3J2TKHnDhK9tL+RK4csKmcDKox5HpVRGMHcW8ztO1ULG3kxp3LFsY
         Uj+wCZZ+TBf03DojMPeFjQR6Nn4isEg3Q1eJr8x+C7krQg9HQR/mDDW1w3JCe0MJCXge
         2W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783643097; x=1784247897;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x5jkh5eR7LJ5Z4DoKrzx2T4miH2hlilFiG/ybzcUBjc=;
        b=Xg4xf2bNUi8RtLKB3n5/Jdu7fb+4HDh+I2D8ICic1f13hKpivtleGGf8/6VAVMDBog
         G90losGpA57bm5oFUlYvXbWpjVODIJRrMOHg2yi7RxdSDMiNCt6T8yvAFSD5u7lxJ5VA
         nrGvYhMKJJTizk8sZGqpJfVZHFnV/CeBSL4TzwuYb5DLJJWZNKQcpkGtypvJ1z8Vd4Gf
         85/gHHVqi+Jka384hoG3lRIf/vDY0srKnTqH4steFWxGjykF+R/ScA+2v8bDx8r73XJ2
         f+xJl54g3kUJpzxmCkdYCWYF74EF5cIG06r+GejalLpyD9CTFocCm+MQBcWxKEOn4/GO
         Jkpg==
X-Forwarded-Encrypted: i=1; AHgh+RpSsDZGcLI77hL3C0ulAoOk5PxveOidlzbMZ3RPoQAqgRW02gJCtbmHPGJD43Nu/rlYIJbwQtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSf9UzndOabNmcpS6MwFYKC63eEYJ8vROjx+KCjrCDJDQCfOkY
	ZJFFv9eHRDve0l7ok/rI6kJve+o7lKL4x+L/Dex2KwtHGQtr2kRWxBRauLX8auljMt5uMYiY0fr
	kYBJ9QNaDlf0G8+noMQaPii9D4odH5WW+Ew==
X-Received: from pgee15.prod.google.com ([2002:a63:1e0f:0:b0:c88:e5cb:265])
 (user=eddiephillips job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d0c:b0:3bf:77d7:667d with SMTP id adf61e73a8af0-3c0bccbaf9cmr11307634637.28.1783643096736;
 Thu, 09 Jul 2026 17:24:56 -0700 (PDT)
Date: Thu,  9 Jul 2026 17:23:37 -0700
In-Reply-To: <20260709101635.103005-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709101635.103005-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260710002451.500112-1-eddiephillips@google.com>
Subject: Re: [PATCH] wifi: brcmfmac: drain bus_reset work on device removal
From: Eddie Phillips <eddiephillips@google.com>
To: eddiephillips@google.com, Fan Wu <fanwu01@zju.edu.cn>
Cc: Arend van Spriel <aspriel@gmail.com>, Kalle Valo <kvalo@kernel.org>, 
	Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, 
	Chi-Hsien Lin <chi-hsien.lin@infineon.com>, Wright Feng <wright.feng@infineon.com>, 
	Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu,  9 Jul 2026 10:16:35 +0000 Fan Wu <fanwu01@zju.edu.cn> wrote:

> brcmf_fw_crashed() and the debugfs "reset" entry both schedule
> drvr->bus_reset, whose callback recovers drvr through container_of()
> and dereferences it.  The teardown paths free drvr (brcmf_free ->
> wiphy_free) without draining the work, so a bus_reset callback pending
> or running during removal can outlive drvr.
> 
> Cancellation cannot live in brcmf_detach() or brcmf_free(): the work
> callback reaches teardown through the bus .reset op (PCIe
> brcmf_pcie_reset -> brcmf_detach; SDIO brcmf_sdio_bus_reset ->
> brcmf_sdiod_remove -> brcmf_free), so cancelling there would wait for
> the running work and deadlock.  Arming and the drain must also be
> mutually exclusive: a debugfs writer can otherwise schedule bus_reset
> after the drain and before the debugfs file is removed in
> brcmf_cfg80211_detach(), re-opening the window.
> 
> Add a per-bus mutex and route all arming through
> brcmf_bus_schedule_reset(), which under the lock skips when the bus is
> marked removing.  Each bus remove entry calls
> brcmf_bus_cancel_reset_work(), which under the same lock sets removing
> and cancels the work.  Where applicable the remove entry first stops
> the firmware-crash producer: on PCIe mask the mailbox and
> synchronize_irq; on SDIO unregister the bus interrupt and cancel the
> data worker, which also reports firmware halts through
> brcmf_fw_crashed().  The mutex is initialized at bus allocation so it
> is ready before any firmware-probe or removal path can reach it.  The
> SDIO suspend power-off path frees drvr through the same
> brcmf_sdiod_remove() and takes the same lock; resume re-allows the work
> only on a successful re-probe.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 4684997d9eea ("brcmfmac: reset PCIe bus on a firmware crash")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> Assisted-by: Codex:gpt-5.5
> ---
>  .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 13 ++++++++
>  .../broadcom/brcm80211/brcmfmac/bus.h         |  6 ++++
>  .../broadcom/brcm80211/brcmfmac/core.c        | 33 +++++++++++++++++--
>  .../broadcom/brcm80211/brcmfmac/pcie.c        |  6 ++++
>  .../broadcom/brcm80211/brcmfmac/sdio.c        |  6 ++++
>  .../broadcom/brcm80211/brcmfmac/sdio.h        |  1 +
>  .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
>  7 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index ac02244a6..c4bb32aec 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -1043,6 +1043,7 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
>  	bus_if = kzalloc(sizeof(struct brcmf_bus), GFP_KERNEL);
>  	if (!bus_if)
>  		return -ENOMEM;
> +	mutex_init(&bus_if->bus_reset_lock);
>  	sdiodev = kzalloc(sizeof(struct brcmf_sdio_dev), GFP_KERNEL);
>  	if (!sdiodev) {
>  		kfree(bus_if);
> @@ -1102,6 +1103,14 @@ static void brcmf_ops_sdio_remove(struct sdio_func *func)
>  		if (func->num != 1)
>  			return;
>  
> +		/* Drain bus_reset before the shared brcmf_sdiod_remove()
> +		 * teardown, which the SDIO reset callback also reaches.  The
> +		 * data worker can arm bus_reset via brcmf_fw_crashed(); cancel
> +		 * it first.
> +		 */
> +		brcmf_sdio_cancel_datawork(sdiodev->bus);
> +		brcmf_bus_cancel_reset_work(bus_if);
> +
>  		/* only proceed with rest of cleanup if func 1 */
>  		brcmf_sdiod_remove(sdiodev);
>  
> @@ -1163,6 +1172,8 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
>  	} else {
>  		/* power will be cut so remove device, probe again in resume */
>  		brcmf_sdiod_intr_unregister(sdiodev);
> +		brcmf_sdio_cancel_datawork(sdiodev->bus);
> +		brcmf_bus_cancel_reset_work(bus_if);
>  		ret = brcmf_sdiod_remove(sdiodev);
>  		if (ret)
>  			brcmf_err("Failed to remove device on suspend\n");
> @@ -1188,6 +1199,8 @@ static int brcmf_ops_sdio_resume(struct device *dev)
>  		ret = brcmf_sdiod_probe(sdiodev);
>  		if (ret)
>  			brcmf_err("Failed to probe device on resume\n");
> +		else
> +			brcmf_bus_allow_reset_work(bus_if);
>  	} else {
>  		if (sdiodev->wowl_enabled &&
>  		    sdiodev->settings->bus.sdio.oob_irq_supported)
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
> index 3f5da3bb6..b606094af 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
> @@ -6,6 +6,7 @@
>  #ifndef BRCMFMAC_BUS_H
>  #define BRCMFMAC_BUS_H
>  
> +#include <linux/mutex.h>
>  #include "debug.h"
>  
>  /* IDs of the 6 default common rings of msgbuf protocol */
> @@ -149,11 +150,16 @@ struct brcmf_bus {
>  	u32 chiprev;
>  	bool always_use_fws_queue;
>  	bool wowl_supported;
> +	bool removing;		/* device removal in progress; quiesce async work */
> +	struct mutex bus_reset_lock;
>  
>  	const struct brcmf_bus_ops *ops;
>  	struct brcmf_bus_msgbuf *msgbuf;
>  };
>  
> +void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if);
> +void brcmf_bus_allow_reset_work(struct brcmf_bus *bus_if);
> +
>  /*
>   * callback wrappers
>   */
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> index fed9cd5f2..b934feb9b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> @@ -1164,6 +1164,35 @@ static int brcmf_revinfo_read(struct seq_file *s, void *data)
>  	return 0;
>  }
>  
> +/* Serialize bus_reset arming (debugfs reset write, brcmf_fw_crashed) against the
> + * teardown drain: the remove path takes bus_reset_lock, sets ->removing and cancels
> + * the work under it, so a racing armer either schedules before the cancel (and is
> + * drained) or observes ->removing and desists.
> + */
> +static void brcmf_bus_schedule_reset(struct brcmf_bus *bus_if)
> +{
> +	mutex_lock(&bus_if->bus_reset_lock);
> +	if (bus_if->drvr && bus_if->drvr->bus_reset.func && !bus_if->removing)
> +		schedule_work(&bus_if->drvr->bus_reset);
> +	mutex_unlock(&bus_if->bus_reset_lock);
> +}

Is this safe in a softIRQ context?                                                                                                        
mutex_lock() sleeps until it can get the lock.

> +
> +void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if)
> +{
> +	mutex_lock(&bus_if->bus_reset_lock);
> +	bus_if->removing = true;
> +	if (bus_if->drvr)
> +		cancel_work_sync(&bus_if->drvr->bus_reset);
> +	mutex_unlock(&bus_if->bus_reset_lock);
> +}

How about if brcmf_pcie_remove() calls brcmf_bus_cancel_reset_work(),
takes the lock and calls cancel_work_sync(), sleeps. If debugfs
path is already running, it can invoke the worker thread. Is there
potential that both try to reset?

> +
> +void brcmf_bus_allow_reset_work(struct brcmf_bus *bus_if)
> +{
> +	mutex_lock(&bus_if->bus_reset_lock);
> +	bus_if->removing = false;
> +	mutex_unlock(&bus_if->bus_reset_lock);
> +}
> +
>  static void brcmf_core_bus_reset(struct work_struct *work)
>  {
>  	struct brcmf_pub *drvr = container_of(work, struct brcmf_pub,
> @@ -1184,7 +1213,7 @@ static ssize_t bus_reset_write(struct file *file, const char __user *user_buf,
>  	if (value != 1)
>  		return -EINVAL;
>  
> -	schedule_work(&drvr->bus_reset);
> +	brcmf_bus_schedule_reset(drvr->bus_if);
>  
>  	return count;
>  }
> @@ -1408,7 +1437,7 @@ void brcmf_fw_crashed(struct device *dev)
>  
>  	brcmf_dev_coredump(dev);
>  
> -	schedule_work(&drvr->bus_reset);
> +	brcmf_bus_schedule_reset(bus_if);
>  }
>  
>  void brcmf_detach(struct device *dev)
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index 8b149996f..3c6775166 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -1914,6 +1914,7 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		ret = -ENOMEM;
>  		goto fail;
>  	}
> +	mutex_init(&bus->bus_reset_lock);
>  	bus->msgbuf = kzalloc(sizeof(*bus->msgbuf), GFP_KERNEL);
>  	if (!bus->msgbuf) {
>  		ret = -ENOMEM;
> @@ -1985,6 +1986,11 @@ brcmf_pcie_remove(struct pci_dev *pdev)
>  	if (devinfo->ci)
>  		brcmf_pcie_intr_disable(devinfo);
>  
> +	if (devinfo->irq_allocated)
> +		synchronize_irq(pdev->irq);
> +
> +	brcmf_bus_cancel_reset_work(bus);
> +
>  	brcmf_detach(&pdev->dev);
>  	brcmf_free(&pdev->dev);
>  
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 8effeb7a7..31e37b0d4 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -4541,6 +4541,12 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
>  	return NULL;
>  }
>  
> +void brcmf_sdio_cancel_datawork(struct brcmf_sdio *bus)
> +{
> +	if (bus)
> +		cancel_work_sync(&bus->datawork);
> +}
> +
>  /* Detach and free everything */
>  void brcmf_sdio_remove(struct brcmf_sdio *bus)
>  {
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
> index 15d2c02fa..3c68ebf8e 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
> @@ -373,6 +373,7 @@ int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiodev);
>  struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev);
>  void brcmf_sdio_remove(struct brcmf_sdio *bus);
>  void brcmf_sdio_isr(struct brcmf_sdio *bus, bool in_isr);
> +void brcmf_sdio_cancel_datawork(struct brcmf_sdio *bus);
>  
>  void brcmf_sdio_wd_timer(struct brcmf_sdio *bus, bool active);
>  void brcmf_sdio_wowl_config(struct device *dev, bool enabled);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> index 9fb68c2dc..97d65ba36 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> @@ -1271,6 +1271,7 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo)
>  		ret = -ENOMEM;
>  		goto fail;
>  	}
> +	mutex_init(&bus->bus_reset_lock);
>  
>  	bus->dev = dev;
>  	bus_pub->bus = bus;
> @@ -1336,6 +1337,8 @@ brcmf_usb_disconnect_cb(struct brcmf_usbdev_info *devinfo)
>  		return;
>  	brcmf_dbg(USB, "Enter, bus_pub %p\n", devinfo);
>  
> +	brcmf_bus_cancel_reset_work(devinfo->bus_pub.bus);
> +
>  	brcmf_detach(devinfo->dev);
>  	brcmf_free(devinfo->dev);
>  	kfree(devinfo->bus_pub.bus);
> -- 
> 2.34.1

Sent using hkml (https://github.com/sjp38/hackermail)
