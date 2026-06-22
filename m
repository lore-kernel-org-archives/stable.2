Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA53546C0;
	Mon, 22 Jun 2026 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782109348; cv=none; b=oIcxQySiJzdklgKUWDBy6curryqJuP+AFEXf93amGTPRPKKvtJcS2D+BS21mAKP56jf4EIVUYhBoarGE7f5mkCbaWGXynIBpRVXHJYMIJ6nv4lgR+evwHNMvjrQWjgpDtChSOvGp/iy4I6CqttwKeNVo3INLXK9GQuiqMbM9j5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782109348; c=relaxed/simple;
	bh=zo1/q3TOHgSF/dD9tY1Lr9wZliLpz1/+pUdlCGJp1y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRZNhYDOJv8BQH0/MhkjrVxocqECpEynnzqqoF2BH0SxZROo6NETBPH4qxei0FqqjrrFulZqXACRJBNVWzArKkeHES0XzGQGIrAViqLG6HuuvHu2lSkD3wufWMOyL12uPFNTAS10vXR59OCvKPf6nrvvbLbvOyEzX0sXTwLpriU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=dRd/Kmbf; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="dRd/Kmbf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782109298;
	bh=KcyAE9Mrv2QeCOjGTTel9nwmN2YZobFO2XHb69/e0DI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=dRd/KmbfAgiDdy1ygEage2Da7KZhKn4fh1p8LQ55A535LFyHQxRMuy2TODzbve/sd
	 NwAOXgfON2sXJAmQ105M7UsGSWdkNFekoHCI/4E3FUkSawcLv/xuuV2d1vgu5X3isC
	 2zQF3aUZ3VgAG9JMwRkks1Wpx4tBifiymNSuSMas=
X-QQ-mid: zesmtpsz3t1782109280t30273a8d
X-QQ-Originating-IP: sor/btoz+tcHmtaIniwhSBXoUsSwJ4UUG2Oq8nsaqbE=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jun 2026 14:21:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3886938880095797919
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: michal.pecio@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mathias.nyman@intel.com,
	mathias.nyman@linux.intel.com,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] xhci: pci: Disable soft retry for Renesas uPD720201
Date: Mon, 22 Jun 2026 14:21:17 +0800
Message-ID: <237BFC17C62D63DF+20260622062117.56278-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260619124234.0a9e4670.michal.pecio@gmail.com>
References: <20260619124234.0a9e4670.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MxdW4jxL6NvX8FB/p8RhEVx7+aaunHMTd5a+JM0RF4JnC10t50vjZAUk
	2PBUQYM39r3ROJiJPZ8aisDxKJky0P02rT2w+jI4tfqiR1yohxJfo6oQ9CyQiIaKNb6T2Gn
	qKl2Ns79rJeTTm6PiYEqThTBafszl5B4ERTDCB+C1CEjHfzwHZkMgOcs0no2zYs3NmXFjQj
	CrCnY/l5I+Y1d4/QfD6ye/wpK+SrnyWRh41xx++LWZs4qv/u7H8MgZNTBxGvYxELDhYkZIo
	vNeXvynKVqocmtji2LtWm08XFpsoE6oiuHubkPnaB+IiUyU7YL8OqfBb+quiJ/CS8grD+P8
	8+vKGC6SVdfmoCPhK6Q7ZlFOvCemDpZEJ5OWCelItjtWcYaoyB3semqlbc6QY+cvPc7bxQb
	YpucESRIivFLMdodQvsmquZMCT6AusTN6UyXY89wW/yqCJVDNSVKxmgiAa/IF4LPNvwprPS
	5wBno2s+B/Gu4e4JLNSaQlsaHVoiEpRX8CQbZ4uzTMZCQ2bFTwVU0wPhu66i4pDIcf4Tcla
	NH4SUImjxymukYUNtX8bLDMZdD8AwkIBqVYYx2MRxvi7PFxEvTolqPIloeQxicK9O32uCO5
	3lNcx8NTRLNXjU1D8Q2W0bBZHL1j9ZlMC/tnQkDqrhUyc/skCsvHz4WhACaAKmu3Khxfagq
	1rAfP1MSw9tJ7u6Qz9WPIYsn2JyWZZhPszhlJFDgzfGVYJRFJxph92dyi+QJO/S5cb5WFaI
	bKCXJn2Z6DCy8o3BVFGzpZOrApwvIPmNFN5LgtgMSVMuWP6fb95Vv+h7dBWNveYCy4+hK+T
	dr6knzz+bAFzfVBNTYHWHFzjxwbrA5YdygiSaRcXkddgIk7rDJ4+6CaXN5VY/MOX4KIrSFm
	DRttHRm9pltlXqZjcfCZ8o8qxduBJA1HGgfLrtbN/Gj06RyHNPzeCrPzhTfOmjbU3AGh01y
	8x/fvShDQ2S3AqDHAugfmAZlk9btrpd70WxImfhscU3xJGoEvOk34iuTHyxT96/SW50o4nj
	QsJ+lXwoHB4iH5Sz5CCGdYNTQtEXw=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Hi Michal,

> > > The host reports a transaction error on the RTL8153 interrupt
> > > endpoint, queues a soft reset, and later times out the Stop
> > > Endpoint command while disconnecting the device:
> > >
> > >    Transfer error for slot 8 ep 6 on endpoint
> > >    Soft-reset ep 6, slot 8
> > >    Ignoring reset ep completion code of 1
> > >    xHCI host not responding to stop endpoint command
> > >    xHCI host controller not responding, assume dead
> > >    HC died; cleaning up
>
> There is other stuff too, like concurrent teardown of a separate bulk
> endpoint, not yet sure what exactly breaks these chips.
>
> Would you mind to apply the attached debug patch, reproduce and post
> dmesg from your system for comparison?

I applied the debug patch and reproduced the issue.
The XHCI_NO_SOFT_RETRY quirk was disabled during the test.

Short timeline from the log:
13:23:29 The USB hub with an integrated RTL8153 Ethernet adapter was
	 plugged in.
13:23:39 The USB hub was unplugged, and the endpoint error occurred.
13:23:44 The Stop Endpoint command timed out and the xHCI host was
         declared dead.

The complete dmesg output follows:

----- dmesg begin -----
2026-06-22T13:23:29.291089+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: Port change event, 2-3, id 3, portsc: 0xa021203
2026-06-22T13:23:29.291105+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: resume root hub
2026-06-22T13:23:29.291107+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: handle_port_status: starting usb2 port polling.
2026-06-22T13:23:29.291108+08:00 uos-PC kernel: usbcore:usb_remote_wakeup: usb usb2: usb wakeup-resume
2026-06-22T13:23:29.291114+08:00 uos-PC kernel: usbcore:hcd_bus_resume: usb usb2: usb auto-resume
2026-06-22T13:23:29.291115+08:00 uos-PC kernel: usbcore:hub_resume: hub 2-0:1.0: hub_resume
2026-06-22T13:23:29.321052+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 2-1 read: 0x2a0, return 0x2a0
2026-06-22T13:23:29.321058+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 2-2 read: 0x1263, return 0x263
2026-06-22T13:23:29.321060+08:00 uos-PC kernel: usbcore:hub_activate: usb usb2-port2: status 0263 change 0000
2026-06-22T13:23:29.321061+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 2-3 read: 0x21203, return 0x10203
2026-06-22T13:23:29.321062+08:00 uos-PC kernel: usbcore:hub_activate: usb usb2-port3: status 0203 change 0001
2026-06-22T13:23:29.321063+08:00 uos-PC kernel: xhci_hcd:xhci_clear_port_change_bit: xhci_hcd 0000:04:00.0: clear port3 connect change, portsc: 0x1203
2026-06-22T13:23:29.321064+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 2-4 read: 0x2a0, return 0x2a0
2026-06-22T13:23:29.362901+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: Port change event, 1-3, id 7, portsc: 0x202e1
2026-06-22T13:23:29.362905+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: handle_port_status: starting usb1 port polling.
2026-06-22T13:23:29.362908+08:00 uos-PC kernel: usbcore:hub_event: hub 1-0:1.0: state 7 ports 4 chg 0000 evt 0008
2026-06-22T13:23:29.365052+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x202e1, return 0x10101
2026-06-22T13:23:29.365056+08:00 uos-PC kernel: xhci_hcd:xhci_clear_port_change_bit: xhci_hcd 0000:04:00.0: clear port3 connect change, portsc: 0x2e1
2026-06-22T13:23:29.365057+08:00 uos-PC kernel: usbcore:hub_port_connect_change: usb usb1-port3: status 0101, change 0001, 12 Mb/s
2026-06-22T13:23:29.365057+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x2e1, return 0x101
2026-06-22T13:23:29.401047+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x2e1, return 0x101
2026-06-22T13:23:29.421050+08:00 uos-PC kernel: xhci_hcd:xhci_hub_status_data: xhci_hcd 0000:04:00.0: xhci_hub_status_data: stopping usb1 port polling
2026-06-22T13:23:29.421054+08:00 uos-PC kernel: xhci_hcd:xhci_hub_status_data: xhci_hcd 0000:04:00.0: xhci_hub_status_data: stopping usb2 port polling
2026-06-22T13:23:29.433054+08:00 uos-PC kernel: usbcore:hub_event: hub 2-0:1.0: state 7 ports 4 chg 0008 evt 0000
2026-06-22T13:23:29.433059+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 2-3 read: 0x1203, return 0x203
2026-06-22T13:23:29.433059+08:00 uos-PC kernel: usbcore:hub_port_connect_change: usb usb2-port3: status 0203, change 0000, 5.0 Gb/s
2026-06-22T13:23:29.433060+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_enable_slot
2026-06-22T13:23:29.433061+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.433061+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.433062+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 9 comp_code 1
2026-06-22T13:23:29.433064+08:00 uos-PC kernel: xhci_hcd:xhci_alloc_virt_device: xhci_hcd 0000:04:00.0: Slot 6 output ctx = 0x0x000000202074e000 (dma)
2026-06-22T13:23:29.433065+08:00 uos-PC kernel: xhci_hcd:xhci_alloc_virt_device: xhci_hcd 0000:04:00.0: Slot 6 input ctx = 0x0x000000200b52e000 (dma)
2026-06-22T13:23:29.433066+08:00 uos-PC kernel: xhci_hcd:xhci_alloc_virt_device: xhci_hcd 0000:04:00.0: Set slot id 6 dcbaa entry 000000009d531643 to 0x202074e000
2026-06-22T13:23:29.433068+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 2-3 read: 0x1203, return 0x203
2026-06-22T13:23:29.433068+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: set port reset, actual port 2-3 status  = 0x1311
2026-06-22T13:23:29.433069+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: Port change event, 2-3, id 3, portsc: 0x201203
2026-06-22T13:23:29.433070+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: handle_port_status: starting usb2 port polling.
2026-06-22T13:23:29.433071+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x2e1, return 0x101
2026-06-22T13:23:29.473049+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x2e1, return 0x101
2026-06-22T13:23:29.501051+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 2-3 read: 0x201203, return 0x100203
2026-06-22T13:23:29.501056+08:00 uos-PC kernel: xhci_hcd:xhci_clear_port_change_bit: xhci_hcd 0000:04:00.0: clear port3 reset change, portsc: 0x1203
2026-06-22T13:23:29.501058+08:00 uos-PC kernel: xhci_hcd:xhci_clear_port_change_bit: xhci_hcd 0000:04:00.0: clear port3 warm(BH) reset change, portsc: 0x1203
2026-06-22T13:23:29.501058+08:00 uos-PC kernel: xhci_hcd:xhci_clear_port_change_bit: xhci_hcd 0000:04:00.0: clear port3 link state change, portsc: 0x1203
2026-06-22T13:23:29.501059+08:00 uos-PC kernel: xhci_hcd:xhci_clear_port_change_bit: xhci_hcd 0000:04:00.0: clear port3 connect change, portsc: 0x1203
2026-06-22T13:23:29.501060+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 2-3 read: 0x1203, return 0x203
2026-06-22T13:23:29.513048+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x2e1, return 0x101
2026-06-22T13:23:29.513053+08:00 uos-PC kernel: usbcore:hub_port_debounce: usb usb1-port3: debounce total 100ms stable 100ms status 0x101
2026-06-22T13:23:29.565054+08:00 uos-PC kernel: xhci_hcd:xhci_setup_addressable_virt_dev: xhci_hcd 0000:04:00.0: Set root hub portnum to 3
2026-06-22T13:23:29.565059+08:00 uos-PC kernel: xhci_hcd:xhci_setup_addressable_virt_dev: xhci_hcd 0000:04:00.0: Set fake root hub portnum to 3
2026-06-22T13:23:29.565060+08:00 uos-PC kernel: xhci_hcd:xhci_setup_addressable_virt_dev: xhci_hcd 0000:04:00.0: udev->tt = 0000000000000000
2026-06-22T13:23:29.565061+08:00 uos-PC kernel: xhci_hcd:xhci_setup_addressable_virt_dev: xhci_hcd 0000:04:00.0: udev->ttport = 0x0
2026-06-22T13:23:29.565061+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_address_device bsr 0
2026-06-22T13:23:29.565062+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.565069+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.565070+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 11 comp_code 1
2026-06-22T13:23:29.565071+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful setup address command
2026-06-22T13:23:29.565072+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Op regs DCBAA ptr = 0x000020021cc000
2026-06-22T13:23:29.565073+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Slot ID 6 dcbaa entry @000000009d531643 = 0x0000202074e000
2026-06-22T13:23:29.565073+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Output Context DMA address = 0x202074e000
2026-06-22T13:23:29.565074+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Internal device address = 6
2026-06-22T13:23:29.565075+08:00 uos-PC kernel: usb 2-3: new SuperSpeed USB device number 3 using xhci_hcd
2026-06-22T13:23:29.589051+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_enable_slot
2026-06-22T13:23:29.589054+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.589054+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.589055+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 9 comp_code 1
2026-06-22T13:23:29.589056+08:00 uos-PC kernel: xhci_hcd:xhci_alloc_virt_device: xhci_hcd 0000:04:00.0: Slot 7 output ctx = 0x0x000000200c093000 (dma)
2026-06-22T13:23:29.589057+08:00 uos-PC kernel: xhci_hcd:xhci_alloc_virt_device: xhci_hcd 0000:04:00.0: Slot 7 input ctx = 0x0x0000002006f06000 (dma)
2026-06-22T13:23:29.589063+08:00 uos-PC kernel: xhci_hcd:xhci_alloc_virt_device: xhci_hcd 0000:04:00.0: Set slot id 7 dcbaa entry 00000000048e82a9 to 0x200c093000
2026-06-22T13:23:29.589064+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: set port reset, actual port 1-3 status  = 0x331
2026-06-22T13:23:29.593056+08:00 uos-PC kernel: usbcore:usb_parse_endpoint: usb 2-3: skipped 1 descriptor after endpoint
2026-06-22T13:23:29.593061+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.593062+08:00 uos-PC kernel: usbcore:usb_get_langid: usb 2-3: default language 0x0409
2026-06-22T13:23:29.593063+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.593064+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.593064+08:00 uos-PC kernel: usbcore:usb_new_device: usb 2-3: udev 3, busnum 2, minor = 130
2026-06-22T13:23:29.593065+08:00 uos-PC kernel: usb 2-3: New USB device found, idVendor=05e3, idProduct=0626, bcdDevice= 6.55
2026-06-22T13:23:29.593070+08:00 uos-PC kernel: usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2026-06-22T13:23:29.593072+08:00 uos-PC kernel: usb 2-3: Product: USB3.1 Hub
2026-06-22T13:23:29.593072+08:00 uos-PC kernel: usb 2-3: Manufacturer: GenesysLogic
2026-06-22T13:23:29.593073+08:00 uos-PC kernel: usbcore:usb_probe_device: usb 2-3: usb_probe_device
2026-06-22T13:23:29.593074+08:00 uos-PC kernel: usbcore:usb_choose_configuration: usb 2-3: configuration #1 chosen from 1 choice
2026-06-22T13:23:29.593075+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/2 (000/0) [ffffffff/00000000/ffffffff] xhci_add_endpoint
2026-06-22T13:23:29.593075+08:00 uos-PC kernel: xhci_hcd:xhci_add_endpoint: xhci_hcd 0000:04:00.0: add ep 0x81, slot id 6, new drop flags = 0x0, new add flags = 0x8
2026-06-22T13:23:29.593076+08:00 uos-PC kernel: xhci_hcd:xhci_check_bandwidth: xhci_hcd 0000:04:00.0: xhci_check_bandwidth called for udev 00000000e00147c8
2026-06-22T13:23:29.593078+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 200b52e000
2026-06-22T13:23:29.593078+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.593079+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.597058+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:29.597063+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Endpoint Configure command
2026-06-22T13:23:29.597063+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/2 (000/1) [2015a35000/2015a35001/2015a35000] xhci_endpoint_reset
2026-06-22T13:23:29.597064+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/2 (080/1) [2015a35000/2015a35001/2015a35000] queue_stop_endpoint suspend 0
2026-06-22T13:23:29.597065+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.597065+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.597072+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/2 (080/3) [2015a35000/2015a35001/2015a35000] handle_tx_event comp_code 27 trb_dma 2015a35000
2026-06-22T13:23:29.597073+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/2 (080/3) [2015a35000/2015a35001/2015a35000] handle_tx_event stream_id 0 trb_len 0 missing 0
2026-06-22T13:23:29.597074+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stopped on No-op or Link TRB for slot 6 ep 2
2026-06-22T13:23:29.597075+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/2 (080/3) [2015a35000/2015a35001/2015a35000] handle_cmd_completion cmd_type 15 comp_code 1
2026-06-22T13:23:29.597076+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 2014823000
2026-06-22T13:23:29.597077+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.597077+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.597078+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:29.597079+08:00 uos-PC kernel: usbcore:usb_set_configuration: usb 2-3: adding 2-3:1.0 (config #1, interface 0)
2026-06-22T13:23:29.597080+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.597081+08:00 uos-PC kernel: usbcore:usb_probe_interface: hub 2-3:1.0: usb_probe_interface
2026-06-22T13:23:29.597082+08:00 uos-PC kernel: usbcore:usb_probe_interface: hub 2-3:1.0: usb_probe_interface - got id
2026-06-22T13:23:29.597083+08:00 uos-PC kernel: hub 2-3:1.0: USB hub found
2026-06-22T13:23:29.601055+08:00 uos-PC kernel: hub 2-3:1.0: 4 ports detected
2026-06-22T13:23:29.601060+08:00 uos-PC kernel: usbcore:hub_configure: hub 2-3:1.0: standalone hub
2026-06-22T13:23:29.601061+08:00 uos-PC kernel: usbcore:hub_configure: hub 2-3:1.0: ganged power switching
2026-06-22T13:23:29.601062+08:00 uos-PC kernel: usbcore:hub_configure: hub 2-3:1.0: global over-current protection
2026-06-22T13:23:29.601062+08:00 uos-PC kernel: usbcore:hub_configure: hub 2-3:1.0: TT requires at most 8 FS bit times (666 ns)
2026-06-22T13:23:29.601063+08:00 uos-PC kernel: usbcore:hub_configure: hub 2-3:1.0: power on to power good time: 0ms
2026-06-22T13:23:29.601064+08:00 uos-PC kernel: usbcore:hub_configure: hub 2-3:1.0: local power source is good
2026-06-22T13:23:29.601065+08:00 uos-PC kernel: usbcore:hub_configure: hub 2-3:1.0: no over-current condition exists
2026-06-22T13:23:29.601071+08:00 uos-PC kernel: xhci_hcd:xhci_update_hub_device: xhci_hcd 0000:04:00.0: xHCI version 100 needs hub TT think time and number of ports
2026-06-22T13:23:29.601072+08:00 uos-PC kernel: xhci_hcd:xhci_update_hub_device: xhci_hcd 0000:04:00.0: Set up configure endpoint for hub device.
2026-06-22T13:23:29.601073+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 2014823000
2026-06-22T13:23:29.601073+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.601074+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.601075+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 6/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:29.601082+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Endpoint Configure command
2026-06-22T13:23:29.601083+08:00 uos-PC kernel: usbcore:hub_power_on: hub 2-3:1.0: enabling power on all ports
2026-06-22T13:23:29.641059+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: Port change event, 1-3, id 7, portsc: 0x200e03
2026-06-22T13:23:29.641070+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: handle_port_status: starting usb1 port polling.
2026-06-22T13:23:29.657049+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x200e03, return 0x100503
2026-06-22T13:23:29.657052+08:00 uos-PC kernel: xhci_hcd:xhci_clear_port_change_bit: xhci_hcd 0000:04:00.0: clear port3 reset change, portsc: 0xe03
2026-06-22T13:23:29.669054+08:00 uos-PC kernel: xhci_hcd:xhci_hub_status_data: xhci_hcd 0000:04:00.0: xhci_hub_status_data: stopping usb1 port polling
2026-06-22T13:23:29.669060+08:00 uos-PC kernel: xhci_hcd:xhci_hub_status_data: xhci_hcd 0000:04:00.0: xhci_hub_status_data: stopping usb2 port polling
2026-06-22T13:23:29.705051+08:00 uos-PC kernel: usbcore:hub_activate: usb 2-3-port1: status 0203 change 0011
2026-06-22T13:23:29.721057+08:00 uos-PC kernel: usb 1-3: new high-speed USB device number 6 using xhci_hcd
2026-06-22T13:23:29.721063+08:00 uos-PC kernel: xhci_hcd:xhci_setup_addressable_virt_dev: xhci_hcd 0000:04:00.0: Set root hub portnum to 7
2026-06-22T13:23:29.721064+08:00 uos-PC kernel: xhci_hcd:xhci_setup_addressable_virt_dev: xhci_hcd 0000:04:00.0: Set fake root hub portnum to 3
2026-06-22T13:23:29.721065+08:00 uos-PC kernel: xhci_hcd:xhci_setup_addressable_virt_dev: xhci_hcd 0000:04:00.0: udev->tt = 0000000000000000
2026-06-22T13:23:29.721066+08:00 uos-PC kernel: xhci_hcd:xhci_setup_addressable_virt_dev: xhci_hcd 0000:04:00.0: udev->ttport = 0x0
2026-06-22T13:23:29.721067+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_address_device bsr 1
2026-06-22T13:23:29.721068+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.721068+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.721069+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 11 comp_code 1
2026-06-22T13:23:29.721070+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful setup context command
2026-06-22T13:23:29.721071+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Op regs DCBAA ptr = 0x000020021cc000
2026-06-22T13:23:29.721072+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Slot ID 7 dcbaa entry @00000000048e82a9 = 0x0000200c093000
2026-06-22T13:23:29.721073+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Output Context DMA address = 0x200c093000
2026-06-22T13:23:29.721080+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Internal device address = 0
2026-06-22T13:23:29.721081+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.721082+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: set port reset, actual port 1-3 status  = 0x331
2026-06-22T13:23:29.768636+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: Port change event, 1-3, id 7, portsc: 0x200e03
2026-06-22T13:23:29.768641+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: handle_port_status: starting usb1 port polling.
2026-06-22T13:23:29.789054+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x200e03, return 0x100503
2026-06-22T13:23:29.789059+08:00 uos-PC kernel: xhci_hcd:xhci_clear_port_change_bit: xhci_hcd 0000:04:00.0: clear port3 reset change, portsc: 0xe03
2026-06-22T13:23:29.813057+08:00 uos-PC kernel: usbcore:hub_event: hub 2-3:1.0: state 7 ports 4 chg 0002 evt 0000
2026-06-22T13:23:29.813064+08:00 uos-PC kernel: usbcore:hub_port_connect_change: usb 2-3-port1: status 0203, change 0000, 5.0 Gb/s
2026-06-22T13:23:29.853057+08:00 uos-PC kernel: xhci_hcd:xhci_discover_or_reset_device: xhci_hcd 0000:04:00.0: Resetting device with slot ID 7
2026-06-22T13:23:29.853063+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_reset_device
2026-06-22T13:23:29.853065+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.853066+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.853072+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 17 comp_code 19
2026-06-22T13:23:29.853074+08:00 uos-PC kernel: xhci_hcd:xhci_handle_cmd_reset_dev: xhci_hcd 0000:04:00.0: Completed reset device command.
2026-06-22T13:23:29.853074+08:00 uos-PC kernel: xhci_hcd:xhci_discover_or_reset_device: xhci_hcd 0000:04:00.0: Can't reset device (slot ID 7) in default state
2026-06-22T13:23:29.853075+08:00 uos-PC kernel: xhci_hcd:xhci_discover_or_reset_device: xhci_hcd 0000:04:00.0: Not freeing device rings.
2026-06-22T13:23:29.853076+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_address_device bsr 0
2026-06-22T13:23:29.853077+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.853078+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.853078+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 11 comp_code 1
2026-06-22T13:23:29.853079+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful setup address command
2026-06-22T13:23:29.853080+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Op regs DCBAA ptr = 0x000020021cc000
2026-06-22T13:23:29.853081+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Slot ID 7 dcbaa entry @00000000048e82a9 = 0x0000200c093000
2026-06-22T13:23:29.853083+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Output Context DMA address = 0x200c093000
2026-06-22T13:23:29.853084+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Internal device address = 7
2026-06-22T13:23:29.877057+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_enable_slot
2026-06-22T13:23:29.877064+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.877065+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.877066+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 9 comp_code 1
2026-06-22T13:23:29.877066+08:00 uos-PC kernel: xhci_hcd:xhci_alloc_virt_device: xhci_hcd 0000:04:00.0: Slot 8 output ctx = 0x0x0000002014823000 (dma)
2026-06-22T13:23:29.877067+08:00 uos-PC kernel: xhci_hcd:xhci_alloc_virt_device: xhci_hcd 0000:04:00.0: Slot 8 input ctx = 0x0x000000201888f000 (dma)
2026-06-22T13:23:29.877070+08:00 uos-PC kernel: xhci_hcd:xhci_alloc_virt_device: xhci_hcd 0000:04:00.0: Set slot id 8 dcbaa entry 0000000047596e38 to 0x2014823000
2026-06-22T13:23:29.881062+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.881068+08:00 uos-PC kernel: usbcore:usb_get_langid: usb 1-3: default language 0x0409
2026-06-22T13:23:29.881069+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.881069+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.881075+08:00 uos-PC kernel: usbcore:usb_new_device: usb 1-3: udev 6, busnum 1, minor = 5
2026-06-22T13:23:29.881076+08:00 uos-PC kernel: usb 1-3: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice= 6.55
2026-06-22T13:23:29.881077+08:00 uos-PC kernel: usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2026-06-22T13:23:29.881078+08:00 uos-PC kernel: usb 1-3: Product: USB2.1 Hub
2026-06-22T13:23:29.881078+08:00 uos-PC kernel: usb 1-3: Manufacturer: GenesysLogic
2026-06-22T13:23:29.881079+08:00 uos-PC kernel: usbcore:usb_probe_device: usb 1-3: usb_probe_device
2026-06-22T13:23:29.881080+08:00 uos-PC kernel: usbcore:usb_choose_configuration: usb 1-3: configuration #1 chosen from 1 choice
2026-06-22T13:23:29.881081+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (000/0) [ffffffff/00000000/ffffffff] xhci_add_endpoint
2026-06-22T13:23:29.881081+08:00 uos-PC kernel: xhci_hcd:xhci_add_endpoint: xhci_hcd 0000:04:00.0: add ep 0x81, slot id 7, new drop flags = 0x0, new add flags = 0x8
2026-06-22T13:23:29.881082+08:00 uos-PC kernel: xhci_hcd:xhci_check_bandwidth: xhci_hcd 0000:04:00.0: xhci_check_bandwidth called for udev 00000000ec865509
2026-06-22T13:23:29.881083+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 2006f06000
2026-06-22T13:23:29.881084+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.881089+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.881090+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:29.881091+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Endpoint Configure command
2026-06-22T13:23:29.881092+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (000/1) [201fe3b000/201fe3b001/201fe3b000] xhci_endpoint_reset
2026-06-22T13:23:29.881093+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (080/1) [201fe3b000/201fe3b001/201fe3b000] queue_stop_endpoint suspend 0
2026-06-22T13:23:29.881093+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.881094+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.881095+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (080/3) [201fe3b000/201fe3b001/201fe3b000] handle_tx_event comp_code 27 trb_dma 201fe3b000
2026-06-22T13:23:29.881096+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (080/3) [201fe3b000/201fe3b001/201fe3b000] handle_tx_event stream_id 0 trb_len 0 missing 0
2026-06-22T13:23:29.881098+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stopped on No-op or Link TRB for slot 7 ep 2
2026-06-22T13:23:29.881099+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (080/3) [201fe3b000/201fe3b001/201fe3b000] handle_cmd_completion cmd_type 15 comp_code 1
2026-06-22T13:23:29.881100+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201fe43000
2026-06-22T13:23:29.881101+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.881101+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.885060+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:29.885065+08:00 uos-PC kernel: usbcore:usb_set_configuration: usb 1-3: adding 1-3:1.0 (config #1, interface 0)
2026-06-22T13:23:29.885066+08:00 uos-PC kernel: usbcore:usb_probe_interface: hub 1-3:1.0: usb_probe_interface
2026-06-22T13:23:29.885067+08:00 uos-PC kernel: usbcore:usb_probe_interface: hub 1-3:1.0: usb_probe_interface - got id
2026-06-22T13:23:29.885068+08:00 uos-PC kernel: hub 1-3:1.0: USB hub found
2026-06-22T13:23:29.885069+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.885070+08:00 uos-PC kernel: hub 1-3:1.0: 4 ports detected
2026-06-22T13:23:29.885071+08:00 uos-PC kernel: usbcore:hub_configure: hub 1-3:1.0: standalone hub
2026-06-22T13:23:29.885072+08:00 uos-PC kernel: usbcore:hub_configure: hub 1-3:1.0: ganged power switching
2026-06-22T13:23:29.885073+08:00 uos-PC kernel: usbcore:hub_configure: hub 1-3:1.0: global over-current protection
2026-06-22T13:23:29.885073+08:00 uos-PC kernel: usbcore:hub_configure: hub 1-3:1.0: Single TT
2026-06-22T13:23:29.885074+08:00 uos-PC kernel: usbcore:hub_configure: hub 1-3:1.0: TT requires at most 32 FS bit times (2664 ns)
2026-06-22T13:23:29.885075+08:00 uos-PC kernel: usbcore:hub_configure: hub 1-3:1.0: Port indicators are supported
2026-06-22T13:23:29.885075+08:00 uos-PC kernel: usbcore:hub_configure: hub 1-3:1.0: power on to power good time: 0ms
2026-06-22T13:23:29.885076+08:00 uos-PC kernel: usbcore:hub_configure: hub 1-3:1.0: local power source is good
2026-06-22T13:23:29.885077+08:00 uos-PC kernel: usbcore:hub_configure: hub 1-3:1.0: no over-current condition exists
2026-06-22T13:23:29.885078+08:00 uos-PC kernel: usbcore:link_peers_report: usb 1-3-port1: peered to 2-3-port1
2026-06-22T13:23:29.885079+08:00 uos-PC kernel: usbcore:link_peers_report: usb 1-3-port2: peered to 2-3-port2
2026-06-22T13:23:29.885079+08:00 uos-PC kernel: usbcore:link_peers_report: usb 1-3-port3: peered to 2-3-port3
2026-06-22T13:23:29.885080+08:00 uos-PC kernel: usbcore:link_peers_report: usb 1-3-port4: peered to 2-3-port4
2026-06-22T13:23:29.885088+08:00 uos-PC kernel: xhci_hcd:xhci_update_hub_device: xhci_hcd 0000:04:00.0: xHCI version 100 needs hub TT think time and number of ports
2026-06-22T13:23:29.885089+08:00 uos-PC kernel: xhci_hcd:xhci_update_hub_device: xhci_hcd 0000:04:00.0: Set up configure endpoint for hub device.
2026-06-22T13:23:29.885090+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201fe43000
2026-06-22T13:23:29.885090+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.885091+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.885092+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:29.885093+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Endpoint Configure command
2026-06-22T13:23:29.885094+08:00 uos-PC kernel: usbcore:hub_power_on: hub 1-3:1.0: enabling power on all ports
2026-06-22T13:23:29.889065+08:00 uos-PC kernel: xhci_hcd:process_bulk_intr_td: xhci_hcd 0000:04:00.0: ep 0x81 - asked for 2 bytes, 1 bytes untransferred
2026-06-22T13:23:29.917073+08:00 uos-PC kernel: xhci_hcd:xhci_hub_status_data: xhci_hcd 0000:04:00.0: xhci_hub_status_data: stopping usb1 port polling
2026-06-22T13:23:29.965062+08:00 uos-PC kernel: xhci_hcd:xhci_setup_addressable_virt_dev: xhci_hcd 0000:04:00.0: Set root hub portnum to 3
2026-06-22T13:23:29.965071+08:00 uos-PC kernel: xhci_hcd:xhci_setup_addressable_virt_dev: xhci_hcd 0000:04:00.0: Set fake root hub portnum to 3
2026-06-22T13:23:29.965073+08:00 uos-PC kernel: xhci_hcd:xhci_setup_addressable_virt_dev: xhci_hcd 0000:04:00.0: udev->tt = 0000000000000000
2026-06-22T13:23:29.965073+08:00 uos-PC kernel: xhci_hcd:xhci_setup_addressable_virt_dev: xhci_hcd 0000:04:00.0: udev->ttport = 0x0
2026-06-22T13:23:29.965074+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_address_device bsr 0
2026-06-22T13:23:29.965082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.965086+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.965087+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 11 comp_code 1
2026-06-22T13:23:29.965089+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful setup address command
2026-06-22T13:23:29.965090+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Op regs DCBAA ptr = 0x000020021cc000
2026-06-22T13:23:29.965090+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Slot ID 8 dcbaa entry @0000000047596e38 = 0x00002014823000
2026-06-22T13:23:29.965091+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Output Context DMA address = 0x2014823000
2026-06-22T13:23:29.965092+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Internal device address = 8
2026-06-22T13:23:29.965093+08:00 uos-PC kernel: usb 2-3.1: new SuperSpeed USB device number 4 using xhci_hcd
2026-06-22T13:23:29.985056+08:00 uos-PC kernel: usbcore:usb_detect_quirks: usb 2-3.1: USB quirks for this device: 0x400
2026-06-22T13:23:29.985064+08:00 uos-PC kernel: usbcore:usb_parse_endpoint: usb 2-3.1: skipped 1 descriptor after endpoint
2026-06-22T13:23:29.985065+08:00 uos-PC kernel: usbcore:usb_parse_endpoint: usb 2-3.1: skipped 1 descriptor after endpoint
2026-06-22T13:23:29.985065+08:00 uos-PC kernel: usbcore:usb_parse_endpoint: usb 2-3.1: skipped 1 descriptor after endpoint
2026-06-22T13:23:29.989079+08:00 uos-PC kernel: usbcore:usb_parse_interface: usb 2-3.1: skipped 3 descriptors after interface
2026-06-22T13:23:29.989086+08:00 uos-PC kernel: usbcore:usb_parse_endpoint: usb 2-3.1: skipped 1 descriptor after endpoint
2026-06-22T13:23:29.989087+08:00 uos-PC kernel: usbcore:usb_parse_endpoint: usb 2-3.1: skipped 1 descriptor after endpoint
2026-06-22T13:23:29.989088+08:00 uos-PC kernel: usbcore:usb_parse_endpoint: usb 2-3.1: skipped 1 descriptor after endpoint
2026-06-22T13:23:29.989089+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.989098+08:00 uos-PC kernel: usbcore:usb_get_langid: usb 2-3.1: default language 0x0409
2026-06-22T13:23:29.989099+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.989100+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.989101+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.989101+08:00 uos-PC kernel: usbcore:usb_new_device: usb 2-3.1: udev 4, busnum 2, minor = 131
2026-06-22T13:23:29.989102+08:00 uos-PC kernel: usb 2-3.1: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=31.00
2026-06-22T13:23:29.989103+08:00 uos-PC kernel: usb 2-3.1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
2026-06-22T13:23:29.989104+08:00 uos-PC kernel: usb 2-3.1: Product: USB 10/100/1000 LAN
2026-06-22T13:23:29.989105+08:00 uos-PC kernel: usb 2-3.1: Manufacturer: Realtek
2026-06-22T13:23:29.989106+08:00 uos-PC kernel: usb 2-3.1: SerialNumber: 001000001
2026-06-22T13:23:29.989107+08:00 uos-PC kernel: usbcore:usb_probe_device: usb 2-3.1: usb_probe_device
2026-06-22T13:23:29.989108+08:00 uos-PC kernel: usbcore:usb_choose_configuration: usb 2-3.1: configuration #2 chosen from 2 choices
2026-06-22T13:23:29.989109+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/0) [ffffffff/00000000/ffffffff] xhci_add_endpoint
2026-06-22T13:23:29.989110+08:00 uos-PC kernel: xhci_hcd:xhci_add_endpoint: xhci_hcd 0000:04:00.0: add ep 0x83, slot id 8, new drop flags = 0x0, new add flags = 0x80
2026-06-22T13:23:29.989111+08:00 uos-PC kernel: xhci_hcd:xhci_check_bandwidth: xhci_hcd 0000:04:00.0: xhci_check_bandwidth called for udev 00000000b85d7ba3
2026-06-22T13:23:29.989112+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201888f000
2026-06-22T13:23:29.989113+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.989114+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.989115+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:29.989121+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Endpoint Configure command
2026-06-22T13:23:29.989122+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/1) [200368a000/200368a001/200368a000] xhci_endpoint_reset
2026-06-22T13:23:29.989122+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/1) [200368a000/200368a001/200368a000] queue_stop_endpoint suspend 0
2026-06-22T13:23:29.989123+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.989124+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.989125+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/3) [200368a000/200368a001/200368a000] handle_tx_event comp_code 27 trb_dma 200368a000
2026-06-22T13:23:29.989126+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/3) [200368a000/200368a001/200368a000] handle_tx_event stream_id 0 trb_len 0 missing 0
2026-06-22T13:23:29.989127+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stopped on No-op or Link TRB for slot 8 ep 6
2026-06-22T13:23:29.993055+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/3) [200368a000/200368a001/200368a000] handle_cmd_completion cmd_type 15 comp_code 1
2026-06-22T13:23:29.993062+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201fe43000
2026-06-22T13:23:29.993063+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.993064+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.993064+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:29.993065+08:00 uos-PC kernel: usbcore:usb_set_configuration: usb 2-3.1: adding 2-3.1:2.0 (config #2, interface 0)
2026-06-22T13:23:29.993066+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:29.993072+08:00 uos-PC kernel: usbcore:usb_set_configuration: usb 2-3.1: adding 2-3.1:2.1 (config #2, interface 1)
2026-06-22T13:23:29.993074+08:00 uos-PC kernel: usbcore:hub_event: hub 2-3:1.0: state 7 ports 4 chg 0000 evt 0002
2026-06-22T13:23:29.993074+08:00 uos-PC kernel: usbcore:hub_event: hub 1-3:1.0: state 7 ports 4 chg 0000 evt 0000
2026-06-22T13:23:29.997105+08:00 uos-PC kernel: usbcore:hub_suspend: hub 1-3:1.0: hub_suspend
2026-06-22T13:23:29.997118+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Cancel URB 00000000cd08cff2, dev 3, ep 0x81, starting at offset 0x201fe3b000
2026-06-22T13:23:29.997120+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (000/1) [201fe3b000/201fe3b001/201fe3b010] xhci_urb_dequeue cancel TD at 201fe3b000 stream 0
2026-06-22T13:23:29.997122+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (004/1) [201fe3b000/201fe3b001/201fe3b010] queue_stop_endpoint suspend 0
2026-06-22T13:23:29.997123+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.997124+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.997125+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (004/1) [201fe3b000/201fe3b001/201fe3b010] handle_tx_event comp_code 26 trb_dma 201fe3b000
2026-06-22T13:23:29.997126+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (004/1) [201fe3b000/201fe3b001/201fe3b010] handle_tx_event stream_id 0 trb_len 1 missing 1
2026-06-22T13:23:29.997127+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stopped on Transfer TRB for slot 7 ep 2
2026-06-22T13:23:29.997127+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (004/3) [201fe3b000/201fe3b001/201fe3b010] handle_cmd_completion cmd_type 15 comp_code 1
2026-06-22T13:23:29.997128+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Removing canceled TD starting at 0x201fe3b000 (dma) in stream 0 URB 00000000cd08cff2
2026-06-22T13:23:29.997130+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (004/3) [201fe3b000/201fe3b001/201fe3b010] queue_set_tr_deq stream 0 addr 201fe3b010
2026-06-22T13:23:29.997131+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Set TR Deq ptr 0x201fe3b010, cycle 1
2026-06-22T13:23:29.997132+08:00 uos-PC kernel:
2026-06-22T13:23:29.997133+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:29.997134+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:29.997135+08:00 uos-PC kernel: xhci_hcd:xhci_giveback_invalidated_tds: xhci_hcd 0000:04:00.0: xhci_giveback_invalidated_tds: Keep cancelled URB 00000000cd08cff2 TD as cancel_status is 2
2026-06-22T13:23:29.997136+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (001/3) [201fe3b000/201fe3b011/201fe3b010] handle_cmd_completion cmd_type 16 comp_code 1
2026-06-22T13:23:29.997137+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Set TR Deq Ptr cmd, deq = @201fe3b010
2026-06-22T13:23:29.997138+08:00 uos-PC kernel: xhci_hcd:xhci_handle_cmd_set_deq: xhci_hcd 0000:04:00.0: xhci_handle_cmd_set_deq: Giveback cancelled URB 00000000cd08cff2 TD
2026-06-22T13:23:29.997139+08:00 uos-PC kernel: xhci_hcd:xhci_td_cleanup: xhci_hcd 0000:04:00.0: Giveback URB 00000000cd08cff2, len = 0, expected = 1, status = -115
2026-06-22T13:23:29.997140+08:00 uos-PC kernel: xhci_hcd:xhci_handle_cmd_set_deq: xhci_hcd 0000:04:00.0: xhci_handle_cmd_set_deq: All TDs cleared, ring doorbell
2026-06-22T13:23:30.009063+08:00 uos-PC kernel: usbcore: registered new device driver r8152-cfgselector
2026-06-22T13:23:30.009070+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 2-3.1: unregistering interface 2-3.1:2.0
2026-06-22T13:23:30.009071+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 2-3.1: unregistering interface 2-3.1:2.1
2026-06-22T13:23:30.009072+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 2-3.1: usb_disable_device nuking non-ep0 URBs
2026-06-22T13:23:30.009073+08:00 uos-PC kernel: xhci_hcd:xhci_drop_endpoint: xhci_hcd 0000:04:00.0: xhci_drop_endpoint called for udev 00000000b85d7ba3
2026-06-22T13:23:30.009073+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/1) [200368a000/200368a001/200368a000] xhci_drop_endpoint ctx_state 1 td_num 0
2026-06-22T13:23:30.009083+08:00 uos-PC kernel: xhci_hcd:xhci_drop_endpoint: xhci_hcd 0000:04:00.0: drop ep 0x83, slot id 8, new drop flags = 0x80, new add flags = 0x0
2026-06-22T13:23:30.009084+08:00 uos-PC kernel: xhci_hcd:xhci_check_bandwidth: xhci_hcd 0000:04:00.0: xhci_check_bandwidth called for udev 00000000b85d7ba3
2026-06-22T13:23:30.009085+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201888f000
2026-06-22T13:23:30.009086+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.009087+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.009088+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:30.009088+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Endpoint Configure command
2026-06-22T13:23:30.009089+08:00 uos-PC kernel: xhci_hcd:xhci_check_bandwidth: xhci_hcd 0000:04:00.0: xhci_check_bandwidth called for udev 00000000b85d7ba3
2026-06-22T13:23:30.009090+08:00 uos-PC kernel: usbcore:usb_probe_device: r8152-cfgselector 2-3.1: usb_probe_device
2026-06-22T13:23:30.009091+08:00 uos-PC kernel: usbcore:usb_choose_configuration: r8152-cfgselector 2-3.1: configuration #2 chosen from 2 choices
2026-06-22T13:23:30.009092+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/0) [ffffffff/200368a001/ffffffff] xhci_add_endpoint
2026-06-22T13:23:30.009093+08:00 uos-PC kernel: xhci_hcd:xhci_add_endpoint: xhci_hcd 0000:04:00.0: add ep 0x83, slot id 8, new drop flags = 0x0, new add flags = 0x81
2026-06-22T13:23:30.009095+08:00 uos-PC kernel: xhci_hcd:xhci_check_bandwidth: xhci_hcd 0000:04:00.0: xhci_check_bandwidth called for udev 00000000b85d7ba3
2026-06-22T13:23:30.009095+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201888f000
2026-06-22T13:23:30.009096+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.009097+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.013064+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/0 (000/1) [202182f480/202182f031/202182f480] queue_stop_endpoint suspend 1
2026-06-22T13:23:30.013070+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.013071+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.013071+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:30.013072+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Endpoint Configure command
2026-06-22T13:23:30.013073+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/1) [200368a000/200368a001/200368a000] xhci_endpoint_reset
2026-06-22T13:23:30.013074+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/1) [200368a000/200368a001/200368a000] queue_stop_endpoint suspend 0
2026-06-22T13:23:30.013074+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.013076+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.013076+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/0 (000/3) [202182f480/202182f481/202182f480] handle_tx_event comp_code 27 trb_dma 202182f480
2026-06-22T13:23:30.013077+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/0 (000/3) [202182f480/202182f481/202182f480] handle_tx_event stream_id 0 trb_len 0 missing 0
2026-06-22T13:23:30.013078+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stopped on No-op or Link TRB for slot 7 ep 0
2026-06-22T13:23:30.013079+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/0 (000/3) [202182f480/202182f481/202182f480] handle_cmd_completion cmd_type 15 comp_code 1
2026-06-22T13:23:30.013079+08:00 uos-PC kernel: xhci_hcd:xhci_set_link_state: xhci_hcd 0000:04:00.0: Set port 1-3 link state, portsc: 0xe03, write 0x10e61
2026-06-22T13:23:30.013080+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/3) [200368a000/200368a001/200368a000] handle_tx_event comp_code 27 trb_dma 200368a000
2026-06-22T13:23:30.013081+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/3) [200368a000/200368a001/200368a000] handle_tx_event stream_id 0 trb_len 0 missing 0
2026-06-22T13:23:30.013082+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stopped on No-op or Link TRB for slot 8 ep 6
2026-06-22T13:23:30.013084+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/3) [200368a000/200368a001/200368a000] handle_cmd_completion cmd_type 15 comp_code 1
2026-06-22T13:23:30.013091+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201fe43000
2026-06-22T13:23:30.013093+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.013093+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.013094+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:30.013095+08:00 uos-PC kernel: usbcore:usb_set_configuration: r8152-cfgselector 2-3.1: adding 2-3.1:2.0 (config #2, interface 0)
2026-06-22T13:23:30.013096+08:00 uos-PC kernel: usbcore:usb_set_configuration: r8152-cfgselector 2-3.1: adding 2-3.1:2.1 (config #2, interface 1)
2026-06-22T13:23:30.013096+08:00 uos-PC kernel: usbcore:usb_disable_device: r8152-cfgselector 2-3.1: unregistering interface 2-3.1:2.0
2026-06-22T13:23:30.013097+08:00 uos-PC kernel: usbcore:usb_disable_device: r8152-cfgselector 2-3.1: unregistering interface 2-3.1:2.1
2026-06-22T13:23:30.013098+08:00 uos-PC kernel: usbcore:usb_disable_device: r8152-cfgselector 2-3.1: usb_disable_device nuking non-ep0 URBs
2026-06-22T13:23:30.013099+08:00 uos-PC kernel: xhci_hcd:xhci_drop_endpoint: xhci_hcd 0000:04:00.0: xhci_drop_endpoint called for udev 00000000b85d7ba3
2026-06-22T13:23:30.013099+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/1) [200368a000/200368a001/200368a000] xhci_drop_endpoint ctx_state 1 td_num 0
2026-06-22T13:23:30.013100+08:00 uos-PC kernel: xhci_hcd:xhci_drop_endpoint: xhci_hcd 0000:04:00.0: drop ep 0x83, slot id 8, new drop flags = 0x80, new add flags = 0x0
2026-06-22T13:23:30.013101+08:00 uos-PC kernel: xhci_hcd:xhci_check_bandwidth: xhci_hcd 0000:04:00.0: xhci_check_bandwidth called for udev 00000000b85d7ba3
2026-06-22T13:23:30.013102+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201888f000
2026-06-22T13:23:30.013104+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.013105+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.017056+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:30.017059+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Endpoint Configure command
2026-06-22T13:23:30.017059+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/2 (000/0) [ffffffff/00000000/ffffffff] xhci_add_endpoint
2026-06-22T13:23:30.017060+08:00 uos-PC kernel: xhci_hcd:xhci_add_endpoint: xhci_hcd 0000:04:00.0: add ep 0x81, slot id 8, new drop flags = 0x0, new add flags = 0x8
2026-06-22T13:23:30.017061+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/3 (000/0) [ffffffff/00000000/ffffffff] xhci_add_endpoint
2026-06-22T13:23:30.017065+08:00 uos-PC kernel: xhci_hcd:xhci_add_endpoint: xhci_hcd 0000:04:00.0: add ep 0x2, slot id 8, new drop flags = 0x0, new add flags = 0x18
2026-06-22T13:23:30.017066+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/0) [ffffffff/200368a001/ffffffff] xhci_add_endpoint
2026-06-22T13:23:30.017067+08:00 uos-PC kernel: xhci_hcd:xhci_add_endpoint: xhci_hcd 0000:04:00.0: add ep 0x83, slot id 8, new drop flags = 0x0, new add flags = 0x98
2026-06-22T13:23:30.017069+08:00 uos-PC kernel: xhci_hcd:xhci_check_bandwidth: xhci_hcd 0000:04:00.0: xhci_check_bandwidth called for udev 00000000b85d7ba3
2026-06-22T13:23:30.017070+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201888f000
2026-06-22T13:23:30.017070+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.017071+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.017072+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:30.017072+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Endpoint Configure command
2026-06-22T13:23:30.017073+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/2 (000/1) [200368a000/200368a001/200368a000] xhci_endpoint_reset
2026-06-22T13:23:30.017074+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/2 (080/1) [200368a000/200368a001/200368a000] queue_stop_endpoint suspend 0
2026-06-22T13:23:30.017075+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.017076+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.017076+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/2 (080/3) [200368a000/200368a001/200368a000] handle_tx_event comp_code 27 trb_dma 200368a000
2026-06-22T13:23:30.017077+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/2 (080/3) [200368a000/200368a001/200368a000] handle_tx_event stream_id 0 trb_len 0 missing 0
2026-06-22T13:23:30.017083+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stopped on No-op or Link TRB for slot 8 ep 2
2026-06-22T13:23:30.017084+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/2 (080/3) [200368a000/200368a001/200368a000] handle_cmd_completion cmd_type 15 comp_code 1
2026-06-22T13:23:30.017085+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201fe43000
2026-06-22T13:23:30.017086+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.017086+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.021061+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:30.021066+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/3 (000/1) [20119e9000/20119e9001/20119e9000] xhci_endpoint_reset
2026-06-22T13:23:30.021066+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/3 (080/1) [20119e9000/20119e9001/20119e9000] queue_stop_endpoint suspend 0
2026-06-22T13:23:30.021067+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.021068+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.021069+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/3 (080/3) [20119e9000/20119e9001/20119e9000] handle_tx_event comp_code 27 trb_dma 20119e9000
2026-06-22T13:23:30.021069+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/3 (080/3) [20119e9000/20119e9001/20119e9000] handle_tx_event stream_id 0 trb_len 0 missing 0
2026-06-22T13:23:30.021070+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stopped on No-op or Link TRB for slot 8 ep 3
2026-06-22T13:23:30.021071+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/3 (080/3) [20119e9000/20119e9001/20119e9000] handle_cmd_completion cmd_type 15 comp_code 1
2026-06-22T13:23:30.021072+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201fe43000
2026-06-22T13:23:30.021073+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.021074+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.021074+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:30.021075+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/1) [2014f4d000/2014f4d001/2014f4d000] xhci_endpoint_reset
2026-06-22T13:23:30.021076+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/1) [2014f4d000/2014f4d001/2014f4d000] queue_stop_endpoint suspend 0
2026-06-22T13:23:30.021077+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.021078+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.021079+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/3) [2014f4d000/2014f4d001/2014f4d000] handle_tx_event comp_code 27 trb_dma 2014f4d000
2026-06-22T13:23:30.021079+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/3) [2014f4d000/2014f4d001/2014f4d000] handle_tx_event stream_id 0 trb_len 0 missing 0
2026-06-22T13:23:30.021080+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stopped on No-op or Link TRB for slot 8 ep 6
2026-06-22T13:23:30.021081+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/3) [2014f4d000/2014f4d001/2014f4d000] handle_cmd_completion cmd_type 15 comp_code 1
2026-06-22T13:23:30.021082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201fe43000
2026-06-22T13:23:30.021083+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.021083+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.025072+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:30.025078+08:00 uos-PC kernel: usbcore:usb_set_configuration: r8152-cfgselector 2-3.1: adding 2-3.1:1.0 (config #1, interface 0)
2026-06-22T13:23:30.025079+08:00 uos-PC kernel: usbcore:usb_probe_interface: r8152 2-3.1:1.0: usb_probe_interface
2026-06-22T13:23:30.025079+08:00 uos-PC kernel: usbcore:usb_probe_interface: r8152 2-3.1:1.0: usb_probe_interface - got id
2026-06-22T13:23:30.033050+08:00 uos-PC kernel: usbcore:usb_port_suspend: usb 1-3: usb auto-suspend, wakeup 1
2026-06-22T13:23:30.033054+08:00 uos-PC kernel: xhci_hcd:process_bulk_intr_td: xhci_hcd 0000:04:00.0: ep 0x81 - asked for 2 bytes, 1 bytes untransferred
2026-06-22T13:23:30.033055+08:00 uos-PC kernel: usbcore:hub_event: hub 2-3:1.0: state 7 ports 4 chg 0000 evt 0002
2026-06-22T13:23:30.113061+08:00 uos-PC kernel: xhci_hcd:xhci_discover_or_reset_device: xhci_hcd 0000:04:00.0: Resetting device with slot ID 8
2026-06-22T13:23:30.113070+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_reset_device
2026-06-22T13:23:30.113071+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.113071+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.113072+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 17 comp_code 1
2026-06-22T13:23:30.113073+08:00 uos-PC kernel: xhci_hcd:xhci_handle_cmd_reset_dev: xhci_hcd 0000:04:00.0: Completed reset device command.
2026-06-22T13:23:30.113081+08:00 uos-PC kernel: xhci_hcd:xhci_discover_or_reset_device: xhci_hcd 0000:04:00.0: Successful reset device command.
2026-06-22T13:23:30.113082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_address_device bsr 0
2026-06-22T13:23:30.113083+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.113084+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.113085+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 11 comp_code 1
2026-06-22T13:23:30.113085+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful setup address command
2026-06-22T13:23:30.113086+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Op regs DCBAA ptr = 0x000020021cc000
2026-06-22T13:23:30.113087+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Slot ID 8 dcbaa entry @0000000047596e38 = 0x00002014823000
2026-06-22T13:23:30.113088+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Output Context DMA address = 0x2014823000
2026-06-22T13:23:30.113088+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Internal device address = 8
2026-06-22T13:23:30.113089+08:00 uos-PC kernel: r8152-cfgselector 2-3.1: reset SuperSpeed USB device number 4 using xhci_hcd
2026-06-22T13:23:30.133059+08:00 uos-PC kernel: usbcore:usb_detect_quirks: r8152-cfgselector 2-3.1: USB quirks for this device: 0x400
2026-06-22T13:23:30.133065+08:00 uos-PC kernel: xhci_hcd:process_ctrl_td: xhci_hcd 0000:04:00.0: Waiting for status stage event
2026-06-22T13:23:30.133066+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/2 (000/0) [ffffffff/200368a001/ffffffff] xhci_add_endpoint
2026-06-22T13:23:30.133067+08:00 uos-PC kernel: xhci_hcd:xhci_add_endpoint: xhci_hcd 0000:04:00.0: add ep 0x81, slot id 8, new drop flags = 0x0, new add flags = 0x8
2026-06-22T13:23:30.133068+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/3 (000/0) [ffffffff/20119e9001/ffffffff] xhci_add_endpoint
2026-06-22T13:23:30.133068+08:00 uos-PC kernel: xhci_hcd:xhci_add_endpoint: xhci_hcd 0000:04:00.0: add ep 0x2, slot id 8, new drop flags = 0x0, new add flags = 0x18
2026-06-22T13:23:30.133069+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/0) [ffffffff/2014f4d001/ffffffff] xhci_add_endpoint
2026-06-22T13:23:30.133077+08:00 uos-PC kernel: xhci_hcd:xhci_add_endpoint: xhci_hcd 0000:04:00.0: add ep 0x83, slot id 8, new drop flags = 0x0, new add flags = 0x98
2026-06-22T13:23:30.133078+08:00 uos-PC kernel: xhci_hcd:xhci_check_bandwidth: xhci_hcd 0000:04:00.0: xhci_check_bandwidth called for udev 00000000b85d7ba3
2026-06-22T13:23:30.133079+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201888f000
2026-06-22T13:23:30.133080+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.133080+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.137061+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:30.137067+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Endpoint Configure command
2026-06-22T13:23:30.137068+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/2 (000/1) [2014f4d000/2014f4d001/2014f4d000] xhci_endpoint_reset
2026-06-22T13:23:30.137069+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/2 (080/1) [2014f4d000/2014f4d001/2014f4d000] queue_stop_endpoint suspend 0
2026-06-22T13:23:30.137070+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.137071+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.137078+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/2 (080/3) [2014f4d000/2014f4d001/2014f4d000] handle_tx_event comp_code 27 trb_dma 2014f4d000
2026-06-22T13:23:30.137079+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/2 (080/3) [2014f4d000/2014f4d001/2014f4d000] handle_tx_event stream_id 0 trb_len 0 missing 0
2026-06-22T13:23:30.137080+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stopped on No-op or Link TRB for slot 8 ep 2
2026-06-22T13:23:30.137081+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/2 (080/3) [2014f4d000/2014f4d001/2014f4d000] handle_cmd_completion cmd_type 15 comp_code 1
2026-06-22T13:23:30.137082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201fe43000
2026-06-22T13:23:30.137082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.137083+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.137084+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:30.137085+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/3 (000/1) [20119e9000/20119e9001/20119e9000] xhci_endpoint_reset
2026-06-22T13:23:30.137085+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/3 (080/1) [20119e9000/20119e9001/20119e9000] queue_stop_endpoint suspend 0
2026-06-22T13:23:30.137086+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.137087+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.137088+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/3 (080/3) [20119e9000/20119e9001/20119e9000] handle_tx_event comp_code 27 trb_dma 20119e9000
2026-06-22T13:23:30.137088+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/3 (080/3) [20119e9000/20119e9001/20119e9000] handle_tx_event stream_id 0 trb_len 0 missing 0
2026-06-22T13:23:30.137089+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stopped on No-op or Link TRB for slot 8 ep 3
2026-06-22T13:23:30.141060+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/3 (080/3) [20119e9000/20119e9001/20119e9000] handle_cmd_completion cmd_type 15 comp_code 1
2026-06-22T13:23:30.141066+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201fe43000
2026-06-22T13:23:30.141067+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.141068+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.141068+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:30.141069+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/1) [200368a000/200368a001/200368a000] xhci_endpoint_reset
2026-06-22T13:23:30.141076+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/1) [200368a000/200368a001/200368a000] queue_stop_endpoint suspend 0
2026-06-22T13:23:30.141078+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.141079+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.141079+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/3) [200368a000/200368a001/200368a000] handle_tx_event comp_code 27 trb_dma 200368a000
2026-06-22T13:23:30.141080+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/3) [200368a000/200368a001/200368a000] handle_tx_event stream_id 0 trb_len 0 missing 0
2026-06-22T13:23:30.141081+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stopped on No-op or Link TRB for slot 8 ep 6
2026-06-22T13:23:30.141081+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (080/3) [200368a000/200368a001/200368a000] handle_cmd_completion cmd_type 15 comp_code 1
2026-06-22T13:23:30.141082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 201fe43000
2026-06-22T13:23:30.141083+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.141084+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.141085+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:30.209052+08:00 uos-PC kernel: r8152 2-3.1:1.0: load rtl8153b-2 v2 04/27/23 successfully
2026-06-22T13:23:30.269062+08:00 uos-PC kernel: r8152 2-3.1:1.0 eth0: v1.12.13
2026-06-22T13:23:30.269079+08:00 uos-PC kernel: usbcore: registered new interface driver r8152
2026-06-22T13:23:30.273085+08:00 uos-PC kernel: usbcore: registered new interface driver cdc_ether
2026-06-22T13:23:30.277075+08:00 uos-PC kernel: usbcore: registered new interface driver r8153_ecm
2026-06-22T13:23:30.285111+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (000/2) [200ca193b0/200ca193c0/200ca193e0] handle_tx_event comp_code 6 trb_dma 200ca193c0
2026-06-22T13:23:30.285123+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (000/2) [200ca193b0/200ca193c0/200ca193e0] handle_tx_event stream_id 0 trb_len 1024 missing 1024
2026-06-22T13:23:30.285125+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stalled endpoint for slot 8 ep 0
2026-06-22T13:23:30.285128+08:00 uos-PC kernel: xhci_hcd:xhci_reset_halted_ep: xhci_hcd 0000:04:00.0: Hard-reset ep 0, slot 8
2026-06-22T13:23:30.285129+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (040/2) [200ca193b0/200ca193c0/200ca193e0] queue_reset_endpoint tsp 0
2026-06-22T13:23:30.285130+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.285131+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.285132+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (042/3) [200ca193b0/200ca193c0/200ca193e0] handle_cmd_completion cmd_type 14 comp_code 1
2026-06-22T13:23:30.285133+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Ignoring reset ep completion code of 1
2026-06-22T13:23:30.285134+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Removing canceled TD starting at 0x200ca193b0 (dma) in stream 0 URB 00000000f32725a0
2026-06-22T13:23:30.285135+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (042/3) [200ca193b0/200ca193c0/200ca193e0] queue_set_tr_deq stream 0 addr 200ca193e0
2026-06-22T13:23:30.285137+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Set TR Deq ptr 0x200ca193e0, cycle 0
2026-06-22T13:23:30.285138+08:00 uos-PC kernel:
2026-06-22T13:23:30.285149+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.285151+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.285152+08:00 uos-PC kernel: xhci_hcd:xhci_giveback_invalidated_tds: xhci_hcd 0000:04:00.0: xhci_giveback_invalidated_tds: Keep cancelled URB 00000000f32725a0 TD as cancel_status is 2
2026-06-22T13:23:30.285154+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (041/3) [200ca193b0/200ca193e0/200ca193e0] handle_cmd_completion cmd_type 16 comp_code 1
2026-06-22T13:23:30.285155+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Set TR Deq Ptr cmd, deq = @200ca193e0
2026-06-22T13:23:30.285156+08:00 uos-PC kernel: xhci_hcd:xhci_handle_cmd_set_deq: xhci_hcd 0000:04:00.0: xhci_handle_cmd_set_deq: Giveback cancelled URB 00000000f32725a0 TD
2026-06-22T13:23:30.285157+08:00 uos-PC kernel: xhci_hcd:xhci_td_cleanup: xhci_hcd 0000:04:00.0: Giveback URB 00000000f32725a0, len = 0, expected = 1024, status = -32
2026-06-22T13:23:30.285157+08:00 uos-PC kernel: xhci_hcd:xhci_handle_cmd_set_deq: xhci_hcd 0000:04:00.0: xhci_handle_cmd_set_deq: All TDs cleared, ring doorbell
2026-06-22T13:23:30.301070+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (040/3) [200ca193e0/200ca193e0/200ca19410] ring_ep_doorbell stream 0
2026-06-22T13:23:30.301079+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (040/2) [200ca193e0/200ca193f0/200ca19410] handle_tx_event comp_code 6 trb_dma 200ca193f0
2026-06-22T13:23:30.301080+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (040/2) [200ca193e0/200ca193f0/200ca19410] handle_tx_event stream_id 0 trb_len 1024 missing 1024
2026-06-22T13:23:30.301081+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Stalled endpoint for slot 8 ep 0
2026-06-22T13:23:30.301082+08:00 uos-PC kernel: xhci_hcd:xhci_reset_halted_ep: xhci_hcd 0000:04:00.0: Hard-reset ep 0, slot 8
2026-06-22T13:23:30.301083+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (040/2) [200ca193e0/200ca193f0/200ca19410] queue_reset_endpoint tsp 0
2026-06-22T13:23:30.301086+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.301087+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.301090+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (042/3) [200ca193e0/200ca193f0/200ca19410] handle_cmd_completion cmd_type 14 comp_code 1
2026-06-22T13:23:30.301091+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Ignoring reset ep completion code of 1
2026-06-22T13:23:30.301092+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Removing canceled TD starting at 0x200ca193e0 (dma) in stream 0 URB 00000000f32725a0
2026-06-22T13:23:30.301093+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (042/3) [200ca193e0/200ca193f0/200ca19410] queue_set_tr_deq stream 0 addr 200ca19410
2026-06-22T13:23:30.301094+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Set TR Deq ptr 0x200ca19410, cycle 0
2026-06-22T13:23:30.301096+08:00 uos-PC kernel:
2026-06-22T13:23:30.301097+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:30.301098+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:30.301099+08:00 uos-PC kernel: xhci_hcd:xhci_giveback_invalidated_tds: xhci_hcd 0000:04:00.0: xhci_giveback_invalidated_tds: Keep cancelled URB 00000000f32725a0 TD as cancel_status is 2
2026-06-22T13:23:30.301100+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (041/3) [200ca193e0/200ca19410/200ca19410] handle_cmd_completion cmd_type 16 comp_code 1
2026-06-22T13:23:30.301101+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Set TR Deq Ptr cmd, deq = @200ca19410
2026-06-22T13:23:30.301102+08:00 uos-PC kernel: xhci_hcd:xhci_handle_cmd_set_deq: xhci_hcd 0000:04:00.0: xhci_handle_cmd_set_deq: Giveback cancelled URB 00000000f32725a0 TD
2026-06-22T13:23:30.301103+08:00 uos-PC kernel: xhci_hcd:xhci_td_cleanup: xhci_hcd 0000:04:00.0: Giveback URB 00000000f32725a0, len = 0, expected = 1024, status = -32
2026-06-22T13:23:30.301104+08:00 uos-PC kernel: xhci_hcd:xhci_handle_cmd_set_deq: xhci_hcd 0000:04:00.0: xhci_handle_cmd_set_deq: All TDs cleared, ring doorbell
2026-06-22T13:23:30.309070+08:00 uos-PC kernel: r8152 2-3.1:1.0 enx2c16dba85d18: renamed from eth0
2026-06-22T13:23:30.345066+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/0 (040/3) [200ca19410/200ca19410/200ca19440] ring_ep_doorbell stream 0
2026-06-22T13:23:39.445959+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: Port change event, 1-3, id 7, portsc: 0x202a0
2026-06-22T13:23:39.445974+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: handle_port_status: starting usb1 port polling.
2026-06-22T13:23:39.445980+08:00 uos-PC kernel: usbcore:hub_event: hub 1-0:1.0: state 7 ports 4 chg 0000 evt 0008
2026-06-22T13:23:39.445989+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x202a0, return 0x10100
2026-06-22T13:23:39.449065+08:00 uos-PC kernel: xhci_hcd:xhci_clear_port_change_bit: xhci_hcd 0000:04:00.0: clear port3 connect change, portsc: 0x2a0
2026-06-22T13:23:39.449074+08:00 uos-PC kernel: usbcore:hub_port_connect_change: usb usb1-port3: status 0100, change 0001, 12 Mb/s
2026-06-22T13:23:39.449078+08:00 uos-PC kernel: usb 1-3: USB disconnect, device number 6
2026-06-22T13:23:39.449085+08:00 uos-PC kernel: usbcore:usb_disconnect: usb 1-3: unregistering device
2026-06-22T13:23:39.449087+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 1-3: unregistering interface 1-3:1.0
2026-06-22T13:23:39.449087+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 1-3: usb_disable_device nuking all URBs
2026-06-22T13:23:39.449088+08:00 uos-PC kernel: xhci_hcd:xhci_drop_endpoint: xhci_hcd 0000:04:00.0: xhci_drop_endpoint called for udev 00000000ec865509
2026-06-22T13:23:39.449089+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/2 (000/3) [201fe3b010/201fe3b011/201fe3b010] xhci_drop_endpoint ctx_state 3 td_num 0
2026-06-22T13:23:39.449090+08:00 uos-PC kernel: xhci_hcd:xhci_drop_endpoint: xhci_hcd 0000:04:00.0: drop ep 0x81, slot id 7, new drop flags = 0x8, new add flags = 0x0
2026-06-22T13:23:39.449092+08:00 uos-PC kernel: xhci_hcd:xhci_check_bandwidth: xhci_hcd 0000:04:00.0: xhci_check_bandwidth called for udev 00000000ec865509
2026-06-22T13:23:39.449093+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_configure_endpoint in_ctx 2006f06000
2026-06-22T13:23:39.449094+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:39.449095+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:39.449096+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: Port change event, 2-3, id 3, portsc: 0x202c0
2026-06-22T13:23:39.449097+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: handle_port_status: starting usb2 port polling.
2026-06-22T13:23:39.449098+08:00 uos-PC kernel: usbcore:hub_event: hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0008
2026-06-22T13:23:39.449104+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 2-3 read: 0x202c0, return 0x102c0
2026-06-22T13:23:39.449105+08:00 uos-PC kernel: xhci_hcd:xhci_clear_port_change_bit: xhci_hcd 0000:04:00.0: clear port3 connect change, portsc: 0x2c0
2026-06-22T13:23:39.449105+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 12 comp_code 1
2026-06-22T13:23:39.449107+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Successful Endpoint Configure command
2026-06-22T13:23:39.449108+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_disable_slot
2026-06-22T13:23:39.449108+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:39.449110+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:39.449111+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 10 comp_code 1
2026-06-22T13:23:39.449112+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x2a0, return 0x100
2026-06-22T13:23:39.457060+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/2) [200cb341b0/200cb341b1/200cb341c0] handle_tx_event comp_code 4 trb_dma 200cb341b0
2026-06-22T13:23:39.457070+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/2) [200cb341b0/200cb341b1/200cb341c0] handle_tx_event stream_id 0 trb_len 2 missing 2
2026-06-22T13:23:39.457071+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Transfer error for slot 8 ep 6 on endpoint
2026-06-22T13:23:39.457072+08:00 uos-PC kernel: xhci_hcd:xhci_reset_halted_ep: xhci_hcd 0000:04:00.0: Soft-reset ep 6, slot 8
2026-06-22T13:23:39.457072+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/2) [200cb341b0/200cb341b1/200cb341c0] queue_reset_endpoint tsp 1
2026-06-22T13:23:39.457073+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:39.457074+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:39.457082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (002/3) [200cb341b0/200cb341b1/200cb341c0] handle_cmd_completion cmd_type 14 comp_code 1
2026-06-22T13:23:39.457084+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Ignoring reset ep completion code of 1
2026-06-22T13:23:39.457084+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/3) [200cb341b0/200cb341b1/200cb341c0] ring_ep_doorbell stream 0
2026-06-22T13:23:39.477064+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 2-3 read: 0x2a0, return 0x2a0
2026-06-22T13:23:39.477069+08:00 uos-PC kernel: usbcore:port_event: usb usb2-port3: Wait for inactive link disconnect detect
2026-06-22T13:23:39.477070+08:00 uos-PC kernel: usbcore:hub_port_connect_change: usb usb2-port3: status 02a0, change 0001, 5.0 Gb/s
2026-06-22T13:23:39.477071+08:00 uos-PC kernel: usb 2-3: USB disconnect, device number 3
2026-06-22T13:23:39.477071+08:00 uos-PC kernel: r8152-cfgselector 2-3.1: USB disconnect, device number 4
2026-06-22T13:23:39.477072+08:00 uos-PC kernel: usbcore:usb_disconnect: r8152-cfgselector 2-3.1: unregistering device
2026-06-22T13:23:39.477079+08:00 uos-PC kernel: usbcore:usb_disable_device: r8152-cfgselector 2-3.1: unregistering interface 2-3.1:1.0
2026-06-22T13:23:39.477080+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Cancel URB 000000005c134e45, dev 3.1, ep 0x83, starting at offset 0x200cb341b0
2026-06-22T13:23:39.477082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/3) [200cb341b0/200cb341b1/200cb341c0] xhci_urb_dequeue cancel TD at 200cb341b0 stream 0
2026-06-22T13:23:39.477082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (004/3) [200cb341b0/200cb341b1/200cb341c0] queue_stop_endpoint suspend 0
2026-06-22T13:23:39.477083+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
2026-06-22T13:23:39.477084+08:00 uos-PC kernel: xhci_hcd:xhci_ring_cmd_db: xhci_hcd 0000:04:00.0: // Ding dong!
2026-06-22T13:23:39.477085+08:00 uos-PC kernel: usbcore:usb_hcd_flush_endpoint: xhci_hcd 0000:04:00.0: shutdown urb 000000005c134e45 ep3in-intr
2026-06-22T13:23:39.489048+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x2a0, return 0x100
2026-06-22T13:23:39.525050+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x2a0, return 0x100
2026-06-22T13:23:39.561050+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x2a0, return 0x100
2026-06-22T13:23:39.581068+08:00 uos-PC kernel: xhci_hcd:xhci_hub_status_data: xhci_hcd 0000:04:00.0: xhci_hub_status_data: stopping usb2 port polling
2026-06-22T13:23:39.581073+08:00 uos-PC kernel: xhci_hcd:xhci_hub_status_data: xhci_hcd 0000:04:00.0: xhci_hub_status_data: stopping usb1 port polling
2026-06-22T13:23:39.597050+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x2a0, return 0x100
2026-06-22T13:23:39.597055+08:00 uos-PC kernel: usbcore:hub_port_debounce: usb usb1-port3: debounce total 100ms stable 100ms status 0x100
2026-06-22T13:23:44.565110+08:00 uos-PC kernel: xhci_hcd:xhci_handle_command_timeout: xhci_hcd 0000:04:00.0: Command timeout, USBSTS: 0x00000000
2026-06-22T13:23:44.565132+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: xHCI host not responding to stop endpoint command
2026-06-22T13:23:44.565133+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: // Halt the HC
2026-06-22T13:23:44.565134+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: xHCI host controller not responding, assume dead
2026-06-22T13:23:44.565135+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 1, ep index 0
2026-06-22T13:23:44.565136+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 1, ep index 2
2026-06-22T13:23:44.565137+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 2, ep index 0
2026-06-22T13:23:44.565138+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 2, ep index 2
2026-06-22T13:23:44.565139+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 3, ep index 0
2026-06-22T13:23:44.565149+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 3, ep index 2
2026-06-22T13:23:44.565150+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 4, ep index 0
2026-06-22T13:23:44.565152+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 4, ep index 2
2026-06-22T13:23:44.565165+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 5, ep index 0
2026-06-22T13:23:44.565167+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 5, ep index 2
2026-06-22T13:23:44.565168+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 5, ep index 4
2026-06-22T13:23:44.565169+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 6, ep index 0
2026-06-22T13:23:44.565170+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 6, ep index 2
2026-06-22T13:23:44.565172+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 8, ep index 0
2026-06-22T13:23:44.565173+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 8, ep index 2
2026-06-22T13:23:44.565174+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 8, ep index 3
2026-06-22T13:23:44.565174+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Killing URBs for slot ID 8, ep index 6
2026-06-22T13:23:44.565176+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: HC died; cleaning up
2026-06-22T13:23:44.565177+08:00 uos-PC kernel: r8152 2-3.1:1.0 enx2c16dba85d18: Stop submitting intr, status -108
2026-06-22T13:23:44.565178+08:00 uos-PC kernel: usbcore:hub_event: hub 1-0:1.0: state 0 ports 4 chg 0000 evt 0000
2026-06-22T13:23:44.565178+08:00 uos-PC kernel: usb 1-1: USB disconnect, device number 2
2026-06-22T13:23:44.565180+08:00 uos-PC kernel: usb 1-1.3: USB disconnect, device number 4
2026-06-22T13:23:44.565180+08:00 uos-PC kernel: usbcore:usb_disconnect: usb 1-1.3: unregistering device
2026-06-22T13:23:44.565181+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 1-1.3: unregistering interface 1-1.3:1.0
2026-06-22T13:23:44.637078+08:00 uos-PC kernel: usbcore:usb_disable_device: r8152-cfgselector 2-3.1: usb_disable_device nuking all URBs
2026-06-22T13:23:44.637093+08:00 uos-PC kernel: usbcore:usb_disconnect: usb 2-3: unregistering device
2026-06-22T13:23:44.637095+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 2-3: unregistering interface 2-3:1.0
2026-06-22T13:23:44.637096+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 2-3: usb_disable_device nuking all URBs
2026-06-22T13:23:44.637097+08:00 uos-PC kernel: usbcore:hub_event: hub 2-0:1.0: state 0 ports 4 chg 0000 evt 0000
2026-06-22T13:23:44.637098+08:00 uos-PC kernel: usb 2-2: USB disconnect, device number 2
2026-06-22T13:23:44.637099+08:00 uos-PC kernel: usbcore:usb_disconnect: usb 2-2: unregistering device
2026-06-22T13:23:44.637108+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 2-2: unregistering interface 2-2:1.0
2026-06-22T13:23:44.637192+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 2-2: usb_disable_device nuking all URBs
2026-06-22T13:23:44.669064+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 1-1.3: usb_disable_device nuking all URBs
2026-06-22T13:23:44.669075+08:00 uos-PC kernel: usbcore:usb_disconnect: usb 1-1: unregistering device
2026-06-22T13:23:44.669076+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 1-1: unregistering interface 1-1:1.0
2026-06-22T13:23:44.669077+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 1-1: usb_disable_device nuking all URBs
2026-06-22T13:23:44.669079+08:00 uos-PC kernel: usb 1-2: USB disconnect, device number 3
2026-06-22T13:23:44.669081+08:00 uos-PC kernel: usbcore:usb_disconnect: usb 1-2: unregistering device
2026-06-22T13:23:44.669082+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 1-2: unregistering interface 1-2:1.0
2026-06-22T13:23:44.669083+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 1-2: usb_disable_device nuking all URBs
2026-06-22T13:23:44.669084+08:00 uos-PC kernel: usb 1-4: USB disconnect, device number 5
2026-06-22T13:23:44.669085+08:00 uos-PC kernel: usbcore:usb_disconnect: usb 1-4: unregistering device
2026-06-22T13:23:44.669085+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 1-4: unregistering interface 1-4:1.0
2026-06-22T13:23:44.797059+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 1-4: unregistering interface 1-4:1.1
2026-06-22T13:23:44.981134+08:00 uos-PC kernel: usbcore:usb_disable_device: usb 1-4: usb_disable_device nuking all URBs
----- dmesg end -----

Thanks,
Xu Rao
