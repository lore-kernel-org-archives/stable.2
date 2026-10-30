Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356078;
	b=XJxxDoOgfJgD1yV5EroVvXY3OtQ/PBKLEYWeqgkwNS/p+zdclABBXnTOSWGgTyp9yxpA
	 TmVXzisE8Z1rvzMlUOyOGHa2aHvU926RhRCrr+GaBS9L7YIupJjoTb5EPWLHW15iRdz58
	 ksA9Y2+b8VzJHoEJStxGQYJv8DpYF9sdBsSqBLQ1VXSDcR3Bntj3hypkITbwDIFubMsAR
	 5rEiqaToUmkO6AcnID15eue4i8z3+le3m3riqs0EgyAOJaQjNLIHVx8Cb1BrFA4BwnJgA
	 GCxZbHsx6kOPXfL/jEZhbqmX2x+YQhrm/9cfY8pYDZuey7aoLSayA1vKrxH3+MoDBSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356078;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GUpb6zALxOrE0SMxkk9VxYOTfoPMEK2Cy5Obr/HVslc=;
	b=Uc4CE3vB7cQbWhNfSMhGIS7vbsBfNswgwN3+K0i7TFnkOrtYBGoYVdjDSBbNjbVWgXR4
	 h5yfnNK03xu9dE6ajFeWfUFGNyy9Ie8Bp2TCuSbFBrD/pmK8co/Kn9EYexxXM4jXHt+Zs
	 WoPzrdS0H52LyaJcD++C4pols18YknLUFs79K/N/ICPM6putqI4SkYqusKEhli0+exViP
	 YODvoNKZuigjrxD8KUvqVoibiQykv7ozk23YRAwussH+uzD01YuGb1AsFsswVxEbHOaJa
	 9DoTgG219XhnKYHJ2Lxh04+g9ify37FYms7CQJU/wUN2/ZHQdsUwxrXSIZsp6OzphQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Rhsxrw7A;
	arc=none smtp.remote-ip=212.27.42.4
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A173E606A332;
	Fri, 30 Oct 2026 10:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A173E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Rhsxrw7A
Received: from stf-laptop.peak-system.com (unknown [IPv6:2a02:8424:8fef:6e01:2a4e:9a3e:485b:cbb0])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 85AC119F58A;
	Fri, 30 Oct 2026 11:27:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1793356076;
	bh=LOQ9Ep05ySdArizRJJp7qd48ta63Np0n1XVIrCQp7qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rhsxrw7AYzs7fBiDbxP4KtyPg/YXr2vTVzvMjzYyhjc18xAgxiD2Dl+4KeyzxaRDw
	 AxYmQi9lnlgt4VlEN4W0CirCeP2l7BhuyMXF3xM68EyUVnKvWEBIFOdlmXjBo/QUEQ
	 O7XbfILJ9d8BnvzxY2EXWy9pbOPopzXtq1VvDzeV8sjd9hAaafCka+gkGGP5LrF/vT
	 1lbFxuNX3YzgYwIL9Y6a2vXfX4VFmk6Fwp4IcBRsrFAbrLJINx/1it2aC0b2BZ3vV+
	 axFiTFtPEqxZvj+8lzZkezmpuFv6W2iznjHCvxFr1NskmAMngD1c41yC0q9iECkA+g
	 3rgNZFJ7DORxA==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	wg@grandegger.com,
	error27@gmail.com,
	lukas.magel@posteo.net,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v6 09/13] can: peak_usb: register the netdevs only once all channels are set up
Date: Fri, 30 Oct 2026 11:27:02 +0100
Message-ID: <20261030102705.30262-4-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179281433446.3130.6290059781976829176@kernel.org>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr> <20261022-canfd_check_channel_idx-v6-9-197704231551@peak-system.fr> <179281433446.3130.6290059781976829176@kernel.org>
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

On 24/10/2026 05:58, netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Low]
> Should the helpers on this same path be converted as well?
> pcan_usb_wait_rsp() and pcan_usb_send_cmd() still log with
> netdev_err(dev->netdev, ...):
[...]
> These messages
> therefore print with an "(unnamed net_device) (uninitialized)" prefix.
[...]
> The new lbl_disconnect path in peak_usb_probe() has a similar issue.
> peak_usb_disconnect() copies netdev->name and logs "%s removed" for
> channels that were created but never registered, so it prints a literal
> "can%d removed".

Right. The "can%d removed" message is a regression of this patch: v7
only reports the registered netdevs as removed.

The netdev_err() of the command helpers only print on error, and only
the prefix is wrong. Converting all of them in this patch would make a
Fixes: patch grow for a cosmetic issue, so I'll do it in a separate
patch for linux-can-next.

[...]
> [Severity: High]
> This isn't a bug introduced by this patch, but can the PCAN-USB restart
> timer fire after free_candev() in this loop?
[...]
> When the timer expires, pcan_usb_restart()->peak_usb_restart_complete()
> writes dev->can.state and calls netif_wake_queue() on the freed netdev.

Right, thanks. This is a real bug, present since the PCAN-USB support was
added. Tristan Madani has posted a fix for it, independently [1], so I
won't fix it in this series, and both apply in any order.

The Sashiko review of his patch [2] found that its other part, the init
failure path, isn't closed by shutting the timer down in
pcan_usb_init(): the unanchored restart URB may still be in flight. That
path is closed by this patch, since no netdev can be opened, nor
restarted, before all the channels are set up.

[...]
> [Severity: Medium]
> This is a pre-existing issue, but take a multi-channel adapter (PCAN-USB
> Pro, or a two-channel PCAN-USB FD). Channel 0 is registered and opened by
> userspace, and then register_candev() fails for channel 1. What state is
> the hardware left in?
>
> The commit message says:
>
>   Since no netdev can be opened during probe anymore, there is no RX to
>   stop when probing a channel fails.
>
> That doesn't quite hold inside this loop.
[...]
> Does this leave the still-attached adapter bus-on on the opened channel?
> Calibration messages would stay enabled, and the firmware would still
> believe a driver is loaded.
>
> The same ordering existed before this patch.

Right, the sentence was too broad. v7 says instead:

  Since no netdev is registered while the channels are being created,
  there is no RX to stop anymore when creating a channel fails. If
  registering a netdev fails, peak_usb_disconnect() still stops RX on
  the channels already registered, which may have been opened in the
  meantime.

For the bus-on state, this is the same pre-existing issue as the one
reported on patch 6: I'll deal with it in a separate series.

[1] https://lore.kernel.org/r/20261025210256.629830-1-tristan@talencesecurity.com
[2] https://lore.kernel.org/r/179304858361.3134.1029344134259623994@kernel.org

Thanks!

Stéphane
