Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF25218BA;
	Tue, 29 Sep 2026 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692047; cv=none; b=h2eK24HYw0ioTVuiaiDHrED+7DGDonCT3nri4G9LZ3oWw1QWPb1ME4DupyhgNnvR5iisnYKtveWXq4EObS7490tBKRuR2Ta2VYBH2om5UknD7UbWG8EMpajapa6vUNfDKHTatID+FDnJ5FGJEYJ/bhWKPB/1fL7l7pGmIbeTITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692047; c=relaxed/simple;
	bh=Bwk2Sbj+akQ3diAVdTcu04i0hLai1HH/u9GO5nLS0DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elsB5WDeDzawGvF5lLrOh3GIP4XZ52w433g5elVMZg+1ddbBEg1gHqknHsmdb/00/z2RCUyJp1UObwfl8hsJnSdfyvY0a83CVDPA1l6AVHUUrxqqsbA+S2K4/pgOAp00UE6n4hDMYLPghlXY1B6hB0cEq2FQu2eWiG3Z7LC9Lk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwQJzShy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwQJzShy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE151F00893;
	Tue, 29 Sep 2026 14:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790692042;
	bh=DnI00DpYKUiWrAQ2VQ34nPrOmLv5QkaMmD+3SRHPxEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WwQJzShyxEh5mqIFTtW6rwAdxkfKY0g16gmXemDmquxWmpkcrOrpXGj2QWtcJJQCe
	 6YzFYe7CaJyl9nl+R7f2G10FSdSRGBNtMvug8Dtd7TrIfXrf/kDWY7yK+2OOYUMI1y
	 EI05UNljuH5uC+piW1ZX66Qc9LrAx+9WqQXUoJF+HwaofIlD1ayuyl92cuTx6EgNeh
	 0cjLccpMZuL1tbPWYh/rfzGZpLVdpDcghi9z6S9CU+4UGKFJZftmC2NccKbL0d0eYy
	 lKPJOFLdad8MFhGFv7VL6983OmWkaBU6+FSDrUb40kfnvjKSVL1qafajRa4VMC6izt
	 2dntYiTe8ZwFw==
Date: Tue, 29 Sep 2026 15:27:17 +0100
From: Simon Horman <horms@kernel.org>
To: Matvey Valigura <valigurasm@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chas Williams <3chas3@gmail.com>,
	Duncan Sands <duncan.sands@free.fr>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzbot+9ca2c9f85bd8b5e46516@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: atm: use request_firmware_direct() for firmware
 probing
Message-ID: <20260929142717.GV13925@horms.kernel.org>
References: <20260924050654.15347-1-valigurasm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924050654.15347-1-valigurasm@gmail.com>

On Thu, Sep 24, 2026 at 08:06:54AM +0300, Matvey Valigura wrote:
> When disconnecting a device while firmware is not present on the system,
> usbatm_usb_disconnect() waits for the heavy_init thread to finish:
>     wait_for_completion(&instance->thread_exited);
> 
> If CONFIG_FW_LOADER_USER_HELPER_FALLBACK is enabled, missing firmware
> causes request_firmware() to fall back to sysfs/udevd. This creates a
> circular dependency during disconnect:
> 1. usb_disconnect() holds device_lock(&udev->dev).
> 2. usbatm_usb_disconnect() waits for instance->thread to exit.
> 3. instance->thread waits for request_firmware() sysfs fallback.
> 4. udevd receives the firmware uevent and attempts to read sysfs
>    attributes (e.g. serial), blocking on device_lock(&udev->dev).
> 
> Furthermore, the fallback wait uses wait_for_completion_killable_timeout(),
> which ignores the non-fatal SIGTERM signal sent by usbatm_usb_disconnect().
> Because speedtch and cxacru probe multiple candidate firmware files
> sequentially, each file stalls for the 60-second fallback timeout,
> triggering hung task timeouts (>120s) reported by syzbot.
> 
> Switch to request_firmware_direct() to probe firmware files directly from
> the filesystem without falling back to user-mode helper.
> 
> Reported-by: syzbot+9ca2c9f85bd8b5e46516@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9ca2c9f85bd8b5e46516
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matvey Valigura <valigurasm@gmail.com>
> ---
>  drivers/usb/atm/cxacru.c   | 2 +-
>  drivers/usb/atm/speedtch.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

I am assuming that in practice users do not load firmware for these devices
from user-space.

Reviewed-by: Simon Horman <horms@kernel.org>

