Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792840644;
	b=ylcuemVCDTmq2EuQrHa+3dDcLdTKtstDSDXMV66PEsCdFqBzjvIVRsvI6AS7+K7JeWsR
	 qSaQp1Z4qJj8Wz5ljkhwyxgROl+8lItWame6FJnZG8R1tpHNADsMfQ2jGlh41NPPGWoOg
	 T6ROAh5eZWLMn9a/hDQa863/bWIUgm1zsU8AKXraKjv0LOxFMq0A1JHmqCw/o+smwHg05
	 zvgo/S/0pjwNRyZEfZDQgBT0C9vUiyXPUHpgLzCME6F+85YnY4sCKBvHUK9PFhqDPETmg
	 nxGsuw2+QA1Q0UHAc8UKGv3uoTS4tFp7KOHW8PHH4fVIMW2+U0ZWNo+mH304gD8RBPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792840644;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=UWioxnS7+9M848vOzYEdNrzd7ZlxotcHELBkStbCFN8=;
	b=NtUj9b241SQYICkgSI+SUTxS7UCGUHtIsg21TZuQcwkkLvLfBNWYaA7bDevp6gvBQ5Fw
	 OKXvSGpfk0J5s8loGVotALiqbh6ILxcKmB53VmU9v/GBdHJYSKmO3jeQix6UrX9xTl/HX
	 2tpimL4VOzh+ZxSPzW7v3YahuCv8Xp83tq2VPqh/3LCszUrF9w7NUX2XWP469eJG8lbVY
	 1LAVIIeTYJqIBQUkedmjfA44BCJBzwy+QG0n9/OdmEM7iyUZAAEQQb/el6FFrSJAldp6s
	 M79W0jJ3jt9rUOdlvhKbueQJ41irH3EH5EULKO8wDyFM6Ljk9h0/hIKZQSAAvJU7jtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=N1C6S9gU;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A4606A31A;
	Sat, 24 Oct 2026 11:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 514A4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=N1C6S9gU
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 32423A15A3;
	Sat, 24 Oct 2026 13:17:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792840633; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UWioxnS7+9M848vOzYEdNrzd7ZlxotcHELBkStbCFN8=;
	b=N1C6S9gUE1z337eFBvCI7/A6w/c5tjnXAVHCR1Qib9hSuNOKyZHeZWPZBv8dQoS/6X7e8H
	1TdSRxQsNGvC6V1We4py/b2yy3R//BW8BDZoYFhuvhHAw1kLHIZpP3XM+z7wltUpd6B/UT
	zXbNQCl3Bs0cA3VxLK4ctILrXAx9SAUXBrTxWOBciNPjG/vRFh9eq5llyg+8viRFmvGWo0
	wWvy3F4PbAddV7YmrSx9JMQLkAV511ASG5N9nqKCP/fBsSILFcvKYpI33bdDGEu46OQ21g
	vsUpYF2ijJi0PFdzD7rsfJpwfR0Nw9u6bEMKfOi1sFPOj6A9bjgLAUgakh8U0A==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 13:17:11 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steve Bayless
 <steve_bayless@keysight.com>, Guido Kiener <guido@kiener-muenchen.de>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH 0/4] usb: usbtmc: fix undersized high-speed bulk packets
 on xHCI
In-Reply-To: <20261023202645.7bf4827a.michal.pecio@gmail.com>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
 <20261020184244.69b78d5e.michal.pecio@gmail.com>
 <a642dbc2e4ba0efc381c69e26821762a@tipi-net.de>
 <20261021005654.23517441.michal.pecio@gmail.com>
 <cae2e837872be0560f7f46e13651059b@tipi-net.de>
 <20261023202645.7bf4827a.michal.pecio@gmail.com>
Message-ID: <bc5865736052c55683b2d3f2eeca0e01@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 23.10.2026 20:26, Michal Pecio wrote:
> On Wed, 21 Oct 2026 11:34:19 +0200, Nicolai Buchwitz wrote:
>> I checked on Windows 11 (Intel xHCI, WinUSB + libusb): same
>> descriptors as on Linux (HS, bulk wMaxPacketSize 64), and a single
>> 4096 byte bulk IN read returns the complete 110 byte reply, so it
>> seems, that Windows programs the 64 bytes into the endpoint instead
>> of forcing 512.
> 
> Yes, that's what it seems to be doing. I passed a fake storage device
> with weird endpoints to Windows 10 in QEMU and with some debug tracing
> (slot/ep context hexdumps are my addition) I see this:
> 
> usb_xhci_fetch_trb addr 0x0000000139a3c450, CR_CONFIGURE_ENDPOINT, p 
> 0x000000013a18d000, s 0x00000000, c 0x01003001
> usb_xhci_slot_ctx addr 0x000000013a18d020, c 0x68000000 0x00000000 
> 0x00000000 0x00000000
> usb_xhci_ep_ctx addr 0x000000013a18d0a0, ep 4, c 0x00000000 0x00400016 
> 0x39a3cc01 0x00000001 0x00000000
> usb_xhci_ep_ctx addr 0x000000013a18d1c0, ep 13, c 0x00000000 0x00400036 
> 0x375ff001 0x00000001 0x00000000
> 
> The 0x0040 in the second field is packet size, and it becomes 0x0400
> when I change to 1024, or 0x0002 with 2050. Windows blindly copies
> those eleven bits here and only gets upset if they are all zero, then
> it resets and enumerates again a few times.
> 
> I don't have any out of spec device, so I tunned a Cypress FX2 into
> one - it exactly replays every received packet back to the host. I
> found that power of two sizes from 1 to 512 work, except on Etron HCs
> which only take 512. Guess we could have an exception for those.
> 
> So this seems very viable. I will turn it into a proper patch and see
> what the maintainers think. Seems better than patching class drivers.

Thanks! If you need something testing with the devices I have at hand, 
please let me know.

Regards,
Nicolai
