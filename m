Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.224.81.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154088;
	b=FNY+VKK1KWnXnDZ5DTKoqPmoH/DBJeV8lJWoRzF5f1N2bTCXC4KMnVVeBZLw1VlYQnuv
	 AihEI8b5veGuqgUCV2gtMQ9M+BsZIgGE3nRPxdxNaEZtVqgEDermMtHkSx45Nm5wfEkiH
	 uG4fPAI1XCxnZ2LUMxmLjeSE/zs4UP4QQCvyyXdf88bzV8IkD7Lxxp4T4ciLwDWXndK4s
	 +j/0y6dXSPUM1MXrc9VDWWcMkyReuxWixHZPLyh1ddjqbjB/k5yuma2zaATOsyYGkWJO6
	 vITsJ4T90iXa+jqtV6hMOhY+7NEyrzMshXC0NFQJVP70K0Fv+vaZbewgyJ/3jXnAyPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154088;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=yNHKjhci1gy/pCPG8FfXM4uD8fUDi3UIHMZ1Loq+UU8=;
	b=HMpdDezEjgc2D6p39KBlm1amBgE6YLSD6GuJ14kmHul5pinE4O9OhGmy92Ou7SHvwTK0
	 ejvG/GmVG0hJE4gBEvGClaPPODPtd3DhYPTY3yOMGOuZkuJI8QmnqtdlvD6n1RK/rw69N
	 ++KMbvJuO6qy3qixOQ1qSOqrEphMQ0Dnbv64aQjAomMEG13RWlKVVBbCEpHRrNbXs2B9c
	 1Eo/FcDUfqx9iL4s6errNAMQcMPVmS99KMLIwgsesFRKjzhr5NOQxnoZRDVV9x4R934xQ
	 yc/VbvNJ4WpjzvPBPY1ZaKI+5OGVQ6fl2setav6VTiyP9laZsLizgu4e6oSOJ3/Ip8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=ChbgGRda;
	arc=none smtp.remote-ip=156.224.81.22
Received: from mail-m8122.xmail.ntesmail.com (mail-m8122.xmail.ntesmail.com [156.224.81.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845C606A31A;
	Wed, 28 Oct 2026 02:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0845C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=ChbgGRda
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 529689659;
	Wed, 28 Oct 2026 10:21:14 +0800 (GMT+08:00)
Message-ID: <95aeecc0-2794-4cc6-a635-5c042afc1405@rock-chips.com>
Date: Wed, 28 Oct 2026 10:21:14 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, manivannan.sadhasivam@oss.qualcomm.com,
 bhelgaas@google.com, robh@kernel.org, heiko@sntech.de, dlemoal@kernel.org,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, iav@iav.lv
Subject: Re: [PATCH v3] PCI: rockchip: Don't lengthen PERST# when power is
 already valid
To: =?UTF-8?Q?Enrique_Hern=C3=A1ndez_Bello?= <ehbello@gmail.com>
References: <20261028005603.2399220-1-ehbello@gmail.com>
 <cf541723-eb4c-4ba6-92c5-33baafc20e7c@rock-chips.com>
 <20261028015923.2436122-1-ehbello@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261028015923.2436122-1-ehbello@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1804fc91103a4kunma6c4c0125b2f1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHx5DVh1IHh9CHUhJSB4aSFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ChbgGRdaxijZR8KSKUvfal1CoRHVY7Efis8YUv4CvZkGOOQ9ep4+V5XBRTk/O3wdft+rGE5oYntRLWujhiU2sBAr2Xq6/IqEK3kaRRClrPQc267MmCJQWAa90mhSb+ath4NiHQnQrpC8uKCcDQkzY2QZNBi3i1FuPkyPoNTC9O0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=yNHKjhci1gy/pCPG8FfXM4uD8fUDi3UIHMZ1Loq+UU8=;
	h=date:mime-version:subject:message-id:from;

在 2026/10/28 星期三 9:59, Enrique Hernández Bello 写道:
> On Wed, 28 Oct 2026 09:34:04 +0800, Shawn Lin wrote:
> 

...

> 
>> Furthermore, even with the same power supply design, different endpoints
>> may behave differently. What if a particular device requires a longer
>> reset pulse to work reliably? How would we handle that?
> 
> The only floor the spec gives is T_PERST, 100 us of active PERST#, and v4
> started guaranteeing that explicitly with an fsleep() rather than relying on
> the 100 ms. Beyond that there is no required minimum to preserve.
> 
> And the short pulse is not new behaviour: from the driver's introduction
> until c47f90be4c89 in v6.11-rc1 there was no wait before the de-assert at
> all, so the pulse was only as long as the register writes in between took.
> That is what every endpoint on this driver saw for years. The 100 ms pulse
> is the recent change, and it is what broke this one. If some device turns
> out to need longer, that seems like a quirk for that device rather than a
> reason to keep a default that regressed another.
> 

Was it possible to add a DT property for configurable delay? I came
across several EPs need quite a longer wait time, so add it in the
vendor tree for dwc-based IP[1]. That could be applied here to slove
your cases and others', and might avoid regression.

[1] 
https://github.com/rockchip-linux/kernel/blob/develop-6.12/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L865
