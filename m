Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059070;
	b=T8oNw5vliEEb3BawrvPlKagXr84BEQvo9rA3mtCY/36TGdUbb8vO0Yik2m1HCH1X+8Hb
	 J1kysJg4bYlahZE5r1drChGuveC9NcQu6BvPznGHMqAYWsDC3qaycHCK9K8uxvApxRc53
	 A+MIKGtO00CChedPiE43qk+dAlT7qKPBgyZuuQ9smSQWFHOTEJXLD3BGpgYTTEPP++HIw
	 kCLrPMaQL6/1lBhKUbB1fiTKKpIFOlLCuME01S+OvbTJAuRZcwyiRvo0Q+ByvMtKLtNPq
	 /Ne7vIMj2m+0xeOj9fTEMhI+nhoRdrANAgRXwnzujFXgak78KA9DBdvfmPUODkt+VPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059070;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ph+NGWmmYq1FDGFTa3cFuctLB01rHiDu5fL3wT4eWEw=;
	b=AvrqDJAF3Bi9mkm7pLBxnotUdX6DJsqsU+7o1trj2taeSgZ/oOBvfivxzbhmIPcJ/QKU
	 E/OEXJo37aL4u2zOgmeziyqpQMcmuQi3KGE92tocbYgdKrWDzdjKxHe+YXKWPStsWjOXx
	 mi0ExOuWd/4TeLEBz7X4E7cNs2aoAsdWge3u0Uf0W2ogHnlOwi1aat3IuZmllFfg69E1F
	 HZ51bT2TDUNht+J0Np4c1VNOd1G7WgdC5ztuknHxZrE0Qd/Nx3TGlcETV8jhggS5jao3Z
	 85gwx6RzD4sxX7odhKnRs2zj06nUgO2q/zQ7euEeGf2IGwbvx/4xO9v/Nta/NxsGz5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b="zY2hX4/K";
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA15606A31C;
	Thu, 19 Nov 2026 03:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA15606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=zY2hX4/K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1795059043;
	bh=ph+NGWmmYq1FDGFTa3cFuctLB01rHiDu5fL3wT4eWEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zY2hX4/KVpaiq9IAJa05Vc8tHdB2slFEQSiXQpb82DnwgkcUqI6hXHEW6ThvC5BHv
	 0daCpP2BA+ReM/oV1w1IVbwLJV1KkUH8hQ6TTW3cpVEd+FEWWUp03Kbxjz6t7xcF45
	 9bJvN94oZaBVKQvrc/teDPWpVKEASXnFSoVpQkI8=
Received: from localhost.localdomain ([107.173.101.132])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 7A6052CB; Thu, 19 Nov 2026 11:30:38 +0800
X-QQ-mid: xmsmtpt1795059038tre2pkvgj
Message-ID: <tencent_F14FD4212049828EDB98B55B6E0FE116CF07@qq.com>
X-QQ-XMAILINFO: OW+Aa38L0qVBPF71u6y/GgmQhnrfohGjPxkly7mnvBDRtLQetEZfgyBr0O5OGm
	 Uaz3oG+WNgMulm5nsKNn7TD17QZuUTUCYUkGjiTwwn1oqVvxWn4+z0N4bhKdzTg8BkQg0Ct77GC0
	 B47ZajaA3ivV6HZsf1VbyNbux0ZfIubiXIyWx0GkUXppsqg94DzAGff1FyJDAKXkylToeqrmedq4
	 SLLFDroi/Y0HdRghZ9Sxiy1K01GMr0dBd+IMaur2n0+Ruy2zwdB24L1auEMqq7nvV9u43wE4DI+r
	 gwPNLbZvZAmvQqeGe38Vp/KKj7gN7FsiK1bF5ds8iCWbwMkCn82HZ5RtSk0YjTY/ryz/3q5QA2A8
	 z+Nt+8M4UbsaKdG55ZyLShweVPFo/iLCOclTxFqA/M04pXV1HjZnY5CgTkahgGVlNYqcyrPs3Fuy
	 uoIWEh4uu49OKZcaY1QHJ9fQGXnPtFTaV+O4W/WgEfFUAHveqs4txarSPBoFbLJu0S57HTFMRTOH
	 +GdMGw7XmppPNjKI6AotYgBezUZm9OBWdwRTlprp2zruqspjYH/q1U+WMgc55Lgrovkld4a4PG7j
	 gU/O3E6r0iRqIEwIOypQppcxj+M/hkx2FVFx89Zd/JavyNHICYqDX4YMgjDpHWfJr0exkEDVDb3b
	 g2WVQNdX1PFwlcL39qsWjQUtK52VQrKQVSZnwlRxahBJSTNlekUnudbyji6KNiqxMQyCkC2OpH09
	 ZGdj4UBtzWu6c7zeirWizoUC77kNqVD0LQKRyJWd5qnvWTvTpMTuXmWT5J5G7LOWEXDuMfkf28VO
	 OAnUwfPitwXII6jynDlpHD2Lqp5I0cYrp8A5lHQXgOMVQIDEox5zpq6AxNYV7yYC3k1DelZ3+OEA
	 MYntawzM+MdXoYHSI8jSkfFoXD9SuufWma8Ypho64NnbI7oNaL7FYl6Z1HSBJgrxfE7WGS/o0MD7
	 xYSDKwxjK6MLvodVXyWccVaaYLT5N+0QF8s5T8RC3zTSFpNxkw6I7Vfg4OFAX9zB2go1qIb89d1u
	 k50uQIaCej1pws93Pl
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: "Ziyou Wang (Lenovo)" <ziyou.dev@foxmail.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	lukas@wunner.de,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ziyou.dev@foxmail.com
Subject: Re: [PATCH v2] PCI/DPC: Increase recovery timeout to 60 seconds
Date: Thu, 19 Nov 2026 11:30:36 +0800
X-OQ-MSGID: <20261119033036.2039885-1-ziyou.dev@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106152143.GA1621130@bhelgaas>
References: <20261106152143.GA1621130@bhelgaas>
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

Hi Bjorn,

Thanks for your review!

On Fri, Nov 06, 2026 at 09:21:43AM -0600, Bjorn Helgaas wrote:
> Was there a "not ready ... after DPC; giving up" message here?
> pci_dev_wait() should log *something* about how it resolved this
> situation.

No.  Here is the complete log from the DPC event to the re-enumeration:

  [121.693046] pcieport 0000:00:03.1: EDR: EDR event received
  [121.695743] pcieport 0000:00:03.1: DPC: containment event, status:0x1f01: unmasked uncorrectable error detected
  [121.695825] pcieport 0000:00:03.1: PCIe Bus Error: severity=Uncorrectable (Fatal)
  [121.695829] pcieport 0000:00:03.1:   device [1022:1108] error status/mask=00200000/00000000
  [121.695831] pcieport 0000:00:03.1:   [21] ACSViol           | Receiver    | Transaction Layer (First)
  [121.695834] pcieport 0000:00:03.1: AER:   TLP Header: 0x60002080 0x010042ff 0x00000017 0x7e325c00
  [121.695841] nvme nvme0: frozen state error detected, reset controller
  [121.721168] nvme0n1: I/O Cmd(0x2) @ LBA 67600640, 256 blocks, I/O Error (sct 0x3 / sc 0x71)
  [121.721182] I/O error, dev nvme0n1, sector 67600640 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
  [121.721193] nvme0n1: I/O Cmd(0x2) @ LBA 67600384, 256 blocks, I/O Error (sct 0x3 / sc 0x71)
  [121.721196] I/O error, dev nvme0n1, sector 67600384 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
  [123.018691] nvme 0000:01:00.0: not ready 1023ms after DPC; waiting
  [124.106690] nvme 0000:01:00.0: not ready 2047ms after DPC; waiting
  [125.642703] pcieport 0000:00:03.1: pciehp: Slot(64): Link Down
  [125.647840] Buffer I/O error on dev nvme0n1, logical block 8450048, async page read
  [125.647846] Buffer I/O error on dev nvme0n1, logical block 8450049, async page read
  [125.647847] Buffer I/O error on dev nvme0n1, logical block 8450050, async page read
  [125.647848] Buffer I/O error on dev nvme0n1, logical block 8450051, async page read
  [125.647850] Buffer I/O error on dev nvme0n1, logical block 8450052, async page read
  [125.647850] Buffer I/O error on dev nvme0n1, logical block 8450053, async page read
  [125.647851] Buffer I/O error on dev nvme0n1, logical block 8450054, async page read
  [125.647852] Buffer I/O error on dev nvme0n1, logical block 8450055, async page read
  [125.647853] Buffer I/O error on dev nvme0n1, logical block 8450056, async page read
  [125.647854] Buffer I/O error on dev nvme0n1, logical block 8450057, async page read
  [125.849608] pcieport 0000:00:03.1: pciehp: Slot(64): Card present
  [125.849614] pcieport 0000:00:03.1: pciehp: Slot(64): Link Up
  [126.218696] pcieport 0000:00:03.1: AER: subordinate device reset failed
  [126.218700] pcieport 0000:00:03.1: AER: device recovery failed
  [126.705745] pci 0000:01:00.0: [1dbe:5668] type 00 class 0x010802 PCIe Endpoint
  [126.705786] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
  [126.705793] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
  [126.705801] pci 0000:01:00.0: Max Payload Size set to 512 (was 128, max 512)
  [126.705987] pci 0000:01:00.0: _HPX attempts Link Control setting (AND 0xffff OR 0x0040)
  [126.706073] pci 0000:01:00.0: supports D1 D2
  [126.706074] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
  [126.706432] pci 0000:01:00.0: Adding to iommu group 16
  [126.706481] pci 0000:01:00.0: ROM [mem 0xde300000-0xde30ffff pref]: assigned
  [126.706483] pci 0000:01:00.0: BAR 0 [mem 0xde310000-0xde313fff 64bit]: assigned
  [126.706491] pcieport 0000:00:03.1: PCI bridge to [bus 01]
  [126.706494] pcieport 0000:00:03.1:   bridge window [io  0x1000-0x1fff]
  [126.706498] pcieport 0000:00:03.1:   bridge window [mem 0xde300000-0xde3fffff]
  [126.706500] pcieport 0000:00:03.1:   bridge window [mem 0x10021600000-0x100217fffff 64bit pref]
  [126.709685] nvme nvme1: pci function 0000:01:00.0
  [126.709692] nvme 0000:01:00.0: enabling device (0140 -> 0142)
  [126.712068] nvme nvme1: D3 entry latency set to 10 seconds
  [126.720936] nvme nvme1: 129/0/0 default/read/poll queues
  [126.727879]  nvme0n2: p1 p2 p3

pci_dev_wait() never reached its timeout.  The 4s pci_dpc_recovered()
timeout expired first, so pciehp removed the device and marked it
disconnected.  When pci_dev_wait() woke up, it took the
pci_dev_is_disconnected() path, which only logs at debug level and
returns -ENOTTY.  That is why the -ENOTTY surfaced as "AER:
subordinate device reset failed" instead.

The device needs a little over 4s to become ready ("ready 4095ms
after DPC" with this patch), so the 4s timeout is losing that race.

One thing worth noting: before e8df1d194c39b ("PCI: Don't treat ~0 as
ready in pci_dev_wait() with RRS SV"), this failure was masked on this
system.  The RRS SV path only checked for the 0x0001 RRS Vendor ID, so
a ~0 read from the not-yet-ready device was treated as "ready",
pci_bridge_wait_for_secondary_bus() returned early, and the DPC
"recovery" appeared to succeed within the 4s window, even though the
device was not actually usable (nvme then failed with -19 after the
"successful" recovery).  With e8df1d194c39b, pci_dev_wait() correctly
waits, which re-exposed this 4s race.

Best regards,
Ziyou Wang

