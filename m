Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=147.32.210.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673989;
	b=jB8CLhcIfq1n4elkPsjwQ8OJBy+mR0cDpogAkPaqCHNEE4umyJabyZCQcJphrwijSH7b
	 V4ZF3TiP1hMKV1ji/5495Dwzze/0V3f+EQwE8diCXGfrzpSqLQG/SJlWJmLMQDI/hbPhK
	 uUZlK/gOEcrHZqqSryPIzvm/s/N252bdjmMd6lnmko2uduvGXbA8iYi6N4gVff+pd6jpW
	 LzU8wh+A1srCGIomd5kcPoB8MygTEsCeMUtkBhLCW4tsTNB4KEEOsqNO4nloZ6u41lvRt
	 LqwgoG13cqNaEi/8Yg1u6upAJb8+Ji6RKuf+geJ+uqAKq5XA7tvivnQ6wYao2IO12Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673989;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:
	 X-KMail-QuotePrefix:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition:Message-Id;
	bh=zd7yJ/RnWTOCBnaUFHbPGYWo73OWzFvn3QDUHe+308g=;
	b=FT87H36wNrF2bVFWFFeOxYtXQYZYlBz4wA9gDTylKKW9zvHudrhAlJcHep9XvGWPDv90
	 gpzcI2Nty7l1RYgstotu5a0+y+s8+sX4ldStRU9kcC+/BKV/5SK5T6YO2rjGGxmQYzeTq
	 gLYugVhMKBM6HRWn7PGCrIi/IjmsMzvoIB4RZA+OSFTjePAND3ErgjMybBlk0RB3eqCKF
	 wwTD/qqOKJT1mKHn/xUrmE9eZHCdsqpJC7625yY1pUNF0YVn42CwGSqnXoLNV2Mlb+TG+
	 HBfPqQszuqanIvFpuYeXx2krVUYKttec6fYLqJ1ZGBxdjaCfNP9trnjdcIlIvMHCfVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fel.cvut.cz;
	spf=pass smtp.mailfrom=fel.cvut.cz;
	dkim=pass header.d=fel.cvut.cz header.i=@fel.cvut.cz header.a=rsa-sha256 header.s=felmail header.b=I8qhYii5;
	arc=none smtp.remote-ip=147.32.210.153
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004AE606A31B;
	Thu, 22 Oct 2026 12:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 004AE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.a=rsa-sha256 header.s=felmail header.b=I8qhYii5
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id 20FFBBDE9;
	Thu, 22 Oct 2026 14:59:38 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id JmNNU5Z5_G85; Thu, 22 Oct 2026 14:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1792673975;
	bh=zd7yJ/RnWTOCBnaUFHbPGYWo73OWzFvn3QDUHe+308g=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=I8qhYii58iF3YZdY4dAY9cqR+sAtngsqX9pRUO4BAu0ivzS3/slJhgVNd1GUFhQBL
	 NWf8tA58Oi4i8+5HIr+hUwQwzpZ63wHTgJSqsouy1K9DQjqZ1D1Q9n/tHjn5UBo7CR
	 16/3fDMKXh4LTZKJnJLlR+iVNMu17QxSqye1MDgj1yAbiR5R1dOI9LTYcbWxdTSOfx
	 86zqW3/K1POZGdnU3xcYKbvHBoxiMjiDixRLZHCLCtUgeDrx3EVZPWl88P+24rTRT/
	 Mk+Lp5pnQdpXtgoaiEAQWdaVbMlJibG391UWaUKel1to/GoZL5rtxdoG4PkebRnp4I
	 ni+V7YcRHddhg==
Received: from [147.32.86.168] (unknown [147.32.86.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 22EF3C0E5;
	Thu, 22 Oct 2026 14:59:34 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Patrick Zhang <patrzhan@amazon.com>
Subject: Re: [PATCH 1/3] can: ctucanfd: enable NAPI before starting the controller
Date: Thu, 22 Oct 2026 14:59:33 +0200
User-Agent: KMail/1.9.10
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 linux-can@vger.kernel.org,
 Ondrej Ille <ondrej.ille@gmail.com>,
 Harini T <harini.t@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Jiri Novak <jnovak@fel.cvut.cz>
References: <20261021205924.2538511-1-patrzhan@amazon.com> <20261021205924.2538511-2-patrzhan@amazon.com>
In-Reply-To: <20261021205924.2538511-2-patrzhan@amazon.com>
X-KMail-QuotePrefix: > 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202610221459.33827.pisa@fel.cvut.cz>

Hello Patrick Zhang,

thanks for the problem finding and patch.

On Wednesday 21 of October 2026 22:59:22 Patrick Zhang wrote:
> ctucan_open() starts the controller and unmasks RBNEI in
> ctucan_chip_start(), prints "ctu_can_fd device registered", and only
> then calls napi_enable(). A frame that arrives in that window raises
> RBNEI. ctucan_interrupt() masks RBNEI and calls napi_schedule(). NAPI is
> still disabled, so napi_schedule_prep() finds NAPI_STATE_SCHED set and
> the schedule is dropped. napi_enable() then clears SCHED without
> scheduling anything. Only ctucan_rx_poll() unmasks RBNEI again, and it
> never runs. The interface receives nothing until the next close.
> Transmit still works. The RX FIFO fills up and the core sets DOR, but
> the overrun is only accounted in ctucan_rx_poll(), so rx_errors and
> rx_over_errors stay at zero and nothing is logged. Every re-open (ip
> link down/up, a driver rebind) runs the same race again.
>
> The netdev_info() in the window makes it much wider on a slow console.
> This can be reproduced by sending continuous traffic with cangen from
> another node and repeating "ip link set down/up" on the test device.
>
> Enable NAPI before the controller starts, so that an early RX interrupt
> can schedule the poll. NAPI can be enabled while the controller is in
> reset, because nothing schedules it until an interrupt arrives. If
> ctucan_chip_start() fails, disable NAPI again. Otherwise the next open
> would call napi_enable() on an already enabled instance and trip the
> BUG_ON() in napi_enable_locked().
>
> Tested on QEMU with the ctucan_pci device.
>
> Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source
> IP core - bus independent part.") Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Patrick Zhang <patrzhan@amazon.com>

Acked-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>

I have added patch into our CAN latency testing system

https://canbus.pages.fel.cvut.cz/#can-bus-channels-mutual-latency-testing
https://canbus.pages.fel.cvut.cz/can-latester/

See in the log for both master 7.3.0-gcac8667a979c
and RT tested branch 7.1.1-rt2-g1661cb7f80a0

-> Running pre-build script /var/lib/latester/patches-dut/apply-script.sh
Applying: can: ctucanfd: enable NAPI before starting the controller
-> Setting up build dir

I have spotted problem appearing in out-of-the-tree device tree overlay
driver build which is consequence of CAN unrelated this night change
in mainline which required next fix

--- a/dtbocfg.c
+++ b/dtbocfg.c
@@ -263,7 +263,11 @@ static struct configfs_attribute *dtbocfg_overlay_attrs[] = {
     NULL,
 };

-static struct configfs_bin_attribute *dtbocfg_overlay_bin_attrs[] = {
+static
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(7, 3, 0))
+const
+#endif
+struct configfs_bin_attribute *dtbocfg_overlay_bin_attrs[] = {
     &dtbocfg_overlay_item_attr_dtbo,
     NULL,
 };

As for fully-preemptive kernel testing, we have been on the git

https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/refs/heads

at the branch for-kbuild-bot/current-stable but that seems to be no longer
active to track latest RT development above stable branch so it is
time to switch to some else branch or master. Ideal would be something
above next with lattest RT fixes applied before they reach mainline.
But we probably switch to mainline with RT config if nothing better
to catch possible RT deviations (changes in latency or some bugs)
is suggested.

For the curiosity, we have run CTU CAN FD IP core on 64-core
RISC-V with 7.3 kernel and drivers to control motor servosystem
based on ESP32C5 over CAN FD on the SUSE booth at Open Source
Summit for most of the days and it performed well

  https://social.kernel.org/notice/BBBNKOIUZ3NnMKcsXQ

Best wishes,

                Pavel

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home
