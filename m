Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078894;
	b=YK7Fb0+9skSO+XllyFLqeKcKrFvXydWyjFK5opeR3216Ks3YT83ZXeeJWol7uK/tQztM
	 azlvmUX/56XseIA4tEdQtD1TuwJDQmNOvUFeMn+CSESaS1/GZbltkIsEOpFBjtytG/rLT
	 w2W0m2P89k00W6LUxD2fPys3HGLR3Lwk4NuyEotF0qI+0oReW720DrF8gg7kFtQXnu0tI
	 2peyWjbFHym6hI997ZZ8FEkBkS9J2jxCYVjH7q6sCzUIPlyoXolBZl+xp0E7FojcjwhOs
	 D9AhaYip7FOiuG6qxYypPVXgIb023MGz7lB0zAw33MONnD1VgYUXXQmxmtcei6jJt1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078894;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DKJBh0a5KRxKDoybtZ7jY1emcZaxszzwhA065JGfkvs=;
	b=enlKCkMkceIwj3pD/h0jvJbFbkhtOlAXsXkOjMzTdDnr6zhLH/iFzE2RB9DsshVD1GQP
	 BrP9Dbn/aU7J0mRDsVA383DP4o8TjjG81BT0ibcC/YsNPshUlbCKJkkwE3437+8fNDEIa
	 oRkVb2+b0OyWHFgQIfb4W5WmfoXcJrEFYcerd9X5nhO1LysNS8hmebRWAazc+2qOnqN/3
	 qmbLaZsW61L9X7qkXm+7uWUKXl5Kx+wcGsuk/yfmf1tmVxcMZghLtwTUvP3PpdBh/KwO3
	 ShmvJUsLYcbUSiByDw34lpn5NaqHWVpsCYX1EUR/4Xn8VfOlBpTtoSudtp7ke0U6MyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E254D606A320;
	Thu, 19 Nov 2026 09:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E254D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id B9596C26;
	Thu, 19 Nov 2026 10:01:29 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 93725600E1C6; Thu, 19 Nov 2026 10:01:29 +0100 (CET)
Date: Thu, 19 Nov 2026 10:01:29 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Ziyou Wang (Lenovo)" <ziyou.dev@foxmail.com>
Cc: helgaas@kernel.org, bhelgaas@google.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI/DPC: Increase recovery timeout to 60 seconds
Message-ID: <av666Q38S0q5HqYS@wunner.de>
References: <20261106152143.GA1621130@bhelgaas>
 <tencent_F14FD4212049828EDB98B55B6E0FE116CF07@qq.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F14FD4212049828EDB98B55B6E0FE116CF07@qq.com>

On Thu, Nov 19, 2026 at 11:30:36AM +0800, Ziyou Wang (Lenovo) wrote:
>   [121.693046] pcieport 0000:00:03.1: EDR: EDR event received
>   [121.695743] pcieport 0000:00:03.1: DPC: containment event, status:0x1f01: unmasked uncorrectable error detected
>   [121.695825] pcieport 0000:00:03.1: PCIe Bus Error: severity=Uncorrectable (Fatal)
>   [121.695829] pcieport 0000:00:03.1:   device [1022:1108] error status/mask=00200000/00000000
>   [121.695831] pcieport 0000:00:03.1:   [21] ACSViol           | Receiver    | Transaction Layer (First)
>   [121.695834] pcieport 0000:00:03.1: AER:   TLP Header: 0x60002080 0x010042ff 0x00000017 0x7e325c00
[...]
>   [123.018691] nvme 0000:01:00.0: not ready 1023ms after DPC; waiting

I'm wondering why the ACS Violation Error is raised in the first place.
The TLP causing the DPC event is a Memory Write Request from the NVMe
drive to memory address 0x000000177e325c00.  The Requester ID 0x100
seems to match the bus address 0000:01:00.0.

What are the ACS settings at the Root Port and why is it signaling an
ACS violation?

TLP decoded with tlp-tool (https://github.com/mmpg-x86/tlp-tool):

+----------+-------------+----------------------+
| TLP Type | MemWriteReq | 4DW with Data Header |
+----------+-------------+----------------------+
+------------+--------+--------+-------+
| Field Name | Offset | Length | Value |
|            | (bits) | (bits) |       |
+------------+--------+--------+-------+
| Fmt        | 0      | 3      | 3     |
| Type       | 3      | 5      | 0     |
| T9         | 8      | 1      | 0     |
| TC         | 9      | 3      | 0     |
| T8         | 12     | 1      | 0     |
| Attr_b2    | 13     | 1      | 0     |
| LN         | 14     | 1      | 0     |
| TH         | 15     | 1      | 0     |
| Td         | 16     | 1      | 0     |
| Ep         | 17     | 1      | 0     |
| Attr       | 18     | 2      | 2     |
| AT         | 20     | 2      | 0     |
| Length     | 22     | 10     | 128   |
+------------+--------+--------+-------+
+-----------------+----------------------+
| TLP:            | 4DW with Data Header |
+-----------------+----------------------+
| Req ID          | 0x100                |
| Tag             | 0x42                 |
| Last DW BE      | 0xF                  |
| First DW BE     | 0xF                  |
| Addr High (DW2) | 0x00000017           |
| Addr Low  (DW3) | 0x7E325C00           |
+-----------------+----------------------+

Thanks,

Lukas
