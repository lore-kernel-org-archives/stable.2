Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.221.237.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357838;
	b=ocehifQjW7r5/iyUYbhyVGi7n1V8WMR+G298w7GQXxrsRhJn7HwiuyCdv+OZQh/OVZq/
	 6AU0BZpTNDmP8QyZlE/d2ZyDZHURpkk6xR1H/NJjWx+BG8ZIUETJgKTW73BkPLgcf23kc
	 DzxSKYf3nGuIFM0Nan9MZG+lYX1glV0DXsGJ+WuXf5Ov33CGrtLO1q9j4Hbl2JVkib28e
	 EcyYv0aBCJW+tiISx5BgcK2EU7LIlNNEpWUeWN7/RtWWC7BlK1WPXkie/dgIqSz31RWIW
	 tyjFI/yteXJjey5WjoMh8MG9ryI8FnbUCKh6mtkC6n9qQbGNl+Krf9PnjNp1zFKy74Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357838;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailru-Src:X-7564579A:X-77F55803:X-7FA49CB5:X-C1DE0DAB:X-C8649E89:
	 X-D57D3AED:X-Mailru-Sender:X-Mras;
	bh=s96wscDNW6KXZN5goNn2emWUK3WEavjmcezSRHjXda8=;
	b=bjw4MUx4oUs/d7wDeTOkZnevpJqxq/YYFZYcsvIOoY4SXBaxTsMzYq6cQooJh6xgtc9C
	 fsCW2I1J/c7WsDWyDMRWLJcB8PemTO66L/ByJe1M/yupgztUN6aKPbDQyazI3q+NUwCZR
	 jbZapRFKyNMGFREk5gVIj8mXl7jsKP/20HXdsLZNHhC0DwwImyW710jJ/PlTR2Yj8pro9
	 xMWsG/Sl1sXfHhjooEwrll9FuH0BilhD7pnEm/thTAbw/poXV56aRl8kiaD73zwjvvqv4
	 iL1WJlMqO/dv6Z6P4qoFSZNiCNh3NM30EWGg2J6LlQzTcTYfP1gjp/XsWnv6IhJ3+UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ru;
	spf=pass smtp.mailfrom=mail.ru;
	dkim=pass header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=f6HKy8hP;
	arc=none smtp.remote-ip=89.221.237.201
Received: from send106.i.mail.ru (send106.i.mail.ru [89.221.237.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9CB606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A9CB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=f6HKy8hP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=s96wscDNW6KXZN5goNn2emWUK3WEavjmcezSRHjXda8=; t=1794357836; x=1794447836; 
	b=f6HKy8hPUhaCFSYfA6rQzhqDE400DEGmg2jHf0A9V0W/KjXcXIki8mYt3EWlIgQRS5ZAEbm3HwG
	nNeeiKjm+cVTiiVoBEBsK+ld6+5IvMq9HrXpeNkTMVNTV3EG9msAyzabD/u285iX27b+UZZNZ7n/O
	G+j9N638ix/wJd07Y+1i8bRHBYqhFIAqFBBwd6GKwh9Qk/a6xEbYd+i94X5nY9P3JAnPoTTb0jRxx
	vEehgmLszmPeY3u8vT0ajdcN3p4wY3eqJN097a5V9TkTEtE8+uXj1+r7punYPogM+eSiqOiohvF0s
	wNyKA46oYEs3UYwCxSFnm4ndBnJGiKUS6V+g==;
Received: by exim-smtp-5cc8b577fd-ffc6m with esmtpa (envelope-from <gvozd188@mail.ru>)
	id 1xQwRI-00000000Geg-2Fzh; Wed, 11 Nov 2026 03:43:48 +0300
From: Vladimir Nedoshivin <gvozd188@mail.ru>
To: sashal@kernel.org
Cc: stable@vger.kernel.org
Subject: Intel VMD 8086:ad0b: ARL004 stable fix also requires Second Root Bus support
Date: Wed, 11 Nov 2026 04:43:28 +0400
Message-ID: <20261111004328.11209-1-gvozd188@mail.ru>
X-Mailer: git-send-email 2.53.0
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
Authentication-Results: exim-smtp-5cc8b577fd-ffc6m; auth=pass smtp.auth=gvozd188@mail.ru smtp.mailfrom=gvozd188@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD960A32E02787845125A7EADB9572D408D599195B75B12B1FA182A05F538085040DFE7B934027BFA3E3DE06ABAFEAF67057C6387332C7D8423861817D778526D99ABAB3F2802300857
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C6068CE86C2B75F5EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375669BFFA6ABF9D5DBB93514EB304EAB389F31D548B0F38DDA5EE327E5CDAE82D3BE8EEF46B7454FC60B9742502CCDD46D0D062BEEFFB5F8EA3EF6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0CB629EEF1311BF91D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A127C277FBC8AE2E8B1ECCCC3F2AC951FC3AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E735157381330E1A1978C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5D52E56629C99BDBD5002B1117B3ED696FB7EB47A84A28CAE8B25839F35DFE037823CB91A9FED034534781492E4B8EEAD191B9814762F309EC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659001DE998A889BEF7BC32BF4F8B290C585E12AFFAE5AED0F077572E4015E488A6CE9957864F11E511B8341EE9D5BE9A0AC69EB922256B0B2C3571FB89362F1CE1D8F9DA9105FFB6A98CD93680B12512CF4C41F94D744909CE0346A531A93BA247997F67558ABE823CF0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWA9nyXmeaHaGAP+qXqN/L60=
X-Mailru-Sender: A47ED0EA96B79D3129134CB94CD97376D3DBE171EA7DE143B951B70A5BD4BD8E221831D635679E4D32E5092D52DEA5C453148BAE84F7D0213DDE9B364B0DF2894C9083906008D79F5EA11F3C5F3A97E80D4ABDE8C577C2ED
X-Mras: Ok

Hello Sasha,

I would like to provide an update regarding the Intel Arrow Lake
VMD ARL004 fix and its implications for stable kernel backports.

On my hardware, the ARL004 interrupt-ordering fix and the VMD
Second Root Bus support are both required for a working system.

Neither change alone resolves the complete problem.

The original investigation is documented here:

https://bugs.launchpad.net/bugs/2166325

Hardware:
- MSI Vector 17 HX AI A2XWIG
- Intel Core Ultra 9 275HX
- Intel VMD controller 8086:ad0b
- Phison 1 TB NVMe SSD
- Ubuntu 26.04
- Secure Boot enabled

1. Original problem: NVMe enumeration failure

With the original Ubuntu VMD driver, the kernel reported:

  vmd 0000:00:0e.0: Unknown Bus Offset Setting (3)

The internal NVMe controller was not enumerated, preventing
Ubuntu from booting from the SSD.

The ARL004 interrupt-ordering fix alone cannot resolve this
enumeration failure because it does not implement support for
the second VMD root bus.

2. Second problem: ARL004 interrupt ordering

An earlier revision of Szymon Durawa's Second Root Bus series
restored NVMe enumeration.

However, without the ARL004 workaround, storage operations
experienced repeated completion timeouts and long stalls.

The kernel reported:

  nvme nvme0: I/O tag ... timeout, completion polled

A diagnostic 1 GiB sequential read required approximately
121.339 seconds, corresponding to only 8.8 MB/s.

The underlying issue was identified as Intel ARL004:

  MSI from VMD-Owned Device May Pass Memory Write

An experimental PCI configuration-space read before interrupt
dispatch resolved the observed completion timeouts.

The same diagnostic read then completed in approximately
0.882 seconds.

The upstream solution enables the existing VMD interrupt-ordering
quirk for Intel Arrow Lake VMD device 0xad0b.

Upstream commit:

  2c88c2dc1852

Subject:

  PCI: vmd: Flush DMA writes before handling MSI on Arrow Lake

3. Both fixes together: successful v10 testing

I have now tested the complete seven-patch Second Root Bus v10
series from Szymon Durawa, based on Linux 7.4-rc1.

The test used:
- Ubuntu kernel 7.0.0-43-generic
- VMD source from Linux 7.4-rc1
- All seven Second Root Bus v10 patches
- The upstream ARL004 interrupt-ordering quirk
- A separately compiled and signed VMD module
- A dedicated test initramfs

No additional local ARL004 workaround was applied.

The system booted successfully.

Both VMD PCI domains were created:

  10000:e0
  10001:e1

The NVMe controller was detected behind BUS1:

  nvme nvme0: pci function 10001:f1:00.0

A 4 GiB direct sequential read completed in 4.16695 seconds,
approximately 983 MiB/s.

This is comparable to the performance of my previously working
ARL004-specific driver.

The physical VMD MSI-X interrupt counters were active.

No VMD/NVMe errors or timeouts were found in the checked logs.

The complete test report was sent to the Linux PCI mailing list:

https://lore.kernel.org/r/20261111003249.10880-1-gvozd188@mail.ru

Please note that this was an external-module test against
Ubuntu 7.0.0-43, not a boot test of the complete Linux 7.4-rc1
kernel.

Dedicated write stress tests, suspend/resume, and long-term
stability testing remain outstanding.

4. Stable backport implications

For this specific Intel VMD 8086:ad0b platform:

- ARL004 fix without Second Root Bus support:
  The NVMe controller cannot be enumerated.

- Second Root Bus support without the ARL004 fix:
  The NVMe controller is detected, but severe I/O timeouts occur.

- Both fixes together:
  The system boots successfully and NVMe sequential read
  performance is normal.

Therefore, backporting only the ARL004 fix is insufficient
to restore functionality on this hardware.

I am not suggesting that the ARL004 fix should be withheld
from other systems that benefit from it independently.

However, I believe the dependency on Second Root Bus support
should be considered when evaluating stable backports for
affected Arrow Lake VMD platforms.

Could you advise whether the Second Root Bus series could
also be considered for the relevant stable branches, or
whether the two changes should be tracked together for
affected systems?

I understand that backporting the Second Root Bus series
may require additional work.

I would be happy to test a stable backport on this hardware
and provide diagnostic logs.

Thank you for your work on the stable kernel series.

Best regards,
Vladimir Nedoshivin
