Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356095;
	b=E4iXvDT5h01HQ1iixQaJjnCunrOTXIQzvErlPhJ9DSoIpSQm7JyF5tVJx5US4F+2GTdu
	 1qADUtvl1Jq71rtEr+gledhtgAXn5VemGwpYnxD/0s0rBi73Yp88Xnu/9u0NJeRPYaTX7
	 ZdsuWrtaA8A9vMP9jKsiV/xumnmMndJLOg4xGKCiKEipcB2zbZwgDRTFQqdkt7W7BmWIn
	 pJee0BNkQl9VILXT57GEolp9pK3I3b1flnS//guW10jdYuMty7q9uveF+u9J1WAkMKwOU
	 bmfcrzUi5zXzV9564R5c6IaUD3YhWQHXaTqJoJJKjvd6kzcOEkrjn89Uke2I1yXtzbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356095;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qyJeCY+1SCigp3wsQXw3Clfptu3D9KJx2aBdbZMV1xE=;
	b=Ej0iPV1vy+W5345Gu1vlsCKpI/H+6pQo+LC6s1QT21vKuU2QP2zg9vuGHy+LHsnBszzC
	 vR3inBqfio86fEZ2pWxTHL7Gynsfp5d+VsEWYfM2e7Hlb4XiB/sK7Ff2PCP6M9JA49FrX
	 wXankEMTICia4a7UIlIFVMwhlqSNjZLHnlDKJnZWqpmoIGSAzusITF3/mLDn4wqqU9lQD
	 EtdVo3xgc2lRMGrvxytdlnCeGNCKBXo5qvy2rTeZyEdhCnnulRVILb4w9v9V/JiX6CrAT
	 xqjfuJYMM75GdTTokHvukRDiV34iKyd+/peKkECg0iqI/77dqoqpJLKDS4r0nNLvxbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=BD70mgLj;
	arc=none smtp.remote-ip=212.27.42.4
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6F60A3811;
	Fri, 30 Oct 2026 10:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5B6F60A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=BD70mgLj
Received: from stf-laptop.peak-system.com (unknown [IPv6:2a02:8424:8fef:6e01:2a4e:9a3e:485b:cbb0])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 0C19619F5A5;
	Fri, 30 Oct 2026 11:28:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1793356093;
	bh=6fAfA2nJ2WjTHNs3g8XX1i9e9d0cKdgzO0QCkae6n6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BD70mgLjj3ibezMaNF6AeqKjtW1YmhYD1a17JjEl/tysm4Q2t6pfvYpfHbWAVJvQ2
	 8c6R+aa4wESUDXNfNulcsqjMeCp3tq2X3f+pJ721/35hzGsAOayq/ov2+OWxCRwO4x
	 nsXP6C+z/9pi2e5zpNje8STuJP1wA3c5ZIkGGyg+8GlKS6MP/p4HB4cEpLGqpWenrG
	 inJq3uCl4m+LpANOP5E1BDJqlo2wAJJpcH5ynTDg234dRO2vA86ektk1gYJy8PgiQM
	 wUC0blfL54Ag2YNR9AEQUycM9Qr61mkOFRsS9xb1lih91+t0pmNX8US/yaw8x6W3Ng
	 bntTMaN42ftmw==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: Tristan Madani <tristmd@gmail.com>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net] can: peak_usb: fix use-after-free on PCAN-USB disconnect and init failure
Date: Fri, 30 Oct 2026 11:27:04 +0100
Message-ID: <20261030102705.30262-6-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025210256.629830-1-tristan@talencesecurity.com>
References: <20261023195400.3531721-1-tristan@talencesecurity.com> <20261025210256.629830-1-tristan@talencesecurity.com>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tristan,

On 25/10/2026 22:02, Tristan Madani wrote:
> The PCAN-USB adapter uses a restart_timer for bus error recovery
> but does not define a dev_free callback.  When the device is
> unplugged, peak_usb_disconnect() frees the candev without cancelling
> the timer.  If a bus error armed the timer and USB disconnect races
> with the timer callback, the timer fires on freed memory.

Thanks for the fix, the disconnect part looks right to me.

A small precision, since you'll respin (see below): the timer is not
armed by a bus error itself, but by the completion handler of the
asynchronous restart URB, pcan_usb_restart_pending(), i.e. after a
restart from bus-off (restart-ms, or "ip link set canX type can
restart"). This handler ignores urb->status, so it also arms the timer
when the URB is killed on unplug, and the timer may still be pending
(PCAN_USB_STARTUP_TIMEOUT, 10 ms) when free_candev() runs.

FYI, Sashiko reported the same issue independently on my peak_usb
series [1]. I won't fix it there, and will point to your patch instead.
Both apply in any order, without conflict.

> The same timer is initialized in pcan_usb_init() via timer_setup(),
> but on error (e.g. failed USB command to read the serial number) the
> function returns without cancelling it.  Because dev_init failure in
> peak_usb_create_dev() jumps to lbl_unregister_candev and skips the
> adap_dev_free label, the dev_free callback is never invoked either.

I agree with the Sashiko review of this patch [2]: the
timer_shutdown_sync() added in pcan_usb_init() doesn't close this
path. The netdev is registered before dev_init() runs, so it can be
opened and restarted while pcan_usb_init() waits for the serial
number. The restart URB submitted by pcan_usb_restart_async() is not
anchored, so it may still be in flight when the probe fails, and when
it completes, pcan_usb_restart_pending() re-arms the timer of the
freed struct pcan_usb. On the disconnect path, there is no such issue,
since usb_unbind_interface() flushes the endpoints before calling
->disconnect().

The init failure path is fixed by patch 9 of my series [3], which does
what Sashiko suggests: the netdevs are registered only once all the
channels of the interface are set up, so no channel can be opened, and
therefore restarted, while pcan_usb_init() is running. v7 of the
series is coming soon.

So I'd suggest a v3 restricted to the disconnect path: drop the
timer_shutdown_sync() below, and the init failure part of the subject
and commit message.

[...]
> +static void pcan_usb_free(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb *pdev =
> +		container_of(dev, struct pcan_usb, dev);

Nit: this fits on one line, as in pcan_usb_init().

[...]
> @@ -901,6 +909,7 @@ static int pcan_usb_init(struct peak_usb_device *dev)
>  		dev_err(dev->netdev->dev.parent,
>  			"unable to read %s serial number (err %d)\n",
>  			pcan_usb.name, err);
> +		timer_shutdown_sync(&pdev->restart_timer);
>  		return err;
>  	}

This is the line I'd drop: it's harmless, but it doesn't fix the init
failure path, and the timer can't be armed there once [3] is applied.

With the patch restricted to the disconnect path, feel free to add:

Reviewed-by: Stéphane Grosjean <s.grosjean@peak-system.fr>

[1] https://lore.kernel.org/r/179281433446.3130.6290059781976829176@kernel.org
[2] https://lore.kernel.org/r/179304858361.3134.1029344134259623994@kernel.org
[3] https://lore.kernel.org/r/20261022-canfd_check_channel_idx-v6-9-197704231551@peak-system.fr

Thanks,
Stéphane
