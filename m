Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057588;
	b=OiwEbDEQks3KfwYgNW9KMDBFT30LIfvfDGfkUDc64nB8otya6MSmU5MPJMxXJloyi/ya
	 ke51eokrJLyFUNER4TcwX1lVGWu20lZe55TtC2c1xeNRttrH1IkNOXlbNuqVacHiFmNcq
	 ibjN3+gGDpxWipDbxY9Ljfrynm7sA8ZujOHIeIbYBa0KtPSlj9yg8eyNaAuyJqoDdmbB8
	 xf89b8hWWPEkNR1H1LUDOsdYx+JAAVGpTw0VbzmehczIOi+8//T00hBonM0rn/HboPimz
	 jtku39XMD5M7GPfhpdBc9Ssw5+HPzDbtOvqaB/dWfgwWs1zWspyZMMQJcYEYzWbymcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057588;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=phegVDEv9oPEmeqfsTcmMo9KAwe4QIWlNgLxl6JXfLo=;
	b=Bt3a531/W75oQHXFuwbADvZckXT2QRFebOiO+LCovYGm6ISFrJEupMBXTzKKJv+gyDf7
	 Hdk3pk+wsArY0gfWAD0p1e9cq5pRWDmOM8bbCQBAcMmSlpQZXWfkIuyrWwkiisLR+Lnsq
	 QD3FMPhvR6ey9Lae4ogSVqvSCNWawQr5UB6UDn31bzDohAAnI3ZPO7ynt82HlD0txuQfi
	 FEHmNRETFtfX96qDUmydGCkl69ySqsOOj7xMlLKcRtcpLC7HnI3wNyC1VIIIb2ADxjABx
	 qE4aVD48xTY1wiLdYzBFG5eg51y187kVxibouwizrlFdpF9ewMMajhOoV4gNUU+WvAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HaIsQbE4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAEB606A326;
	Sat,  7 Nov 2026 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HaIsQbE4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965791F0089F;
	Sat,  7 Nov 2026 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794057587;
	bh=phegVDEv9oPEmeqfsTcmMo9KAwe4QIWlNgLxl6JXfLo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HaIsQbE4YU2N7/OxXefG62Bkvtk0NOmMOaFv3MmhxjDWDjgywzy1Of3PSZeaBwkIF
	 q2DA7Su3iOBqQa+hbHvElyQEBp5FVhx6gQ7uQVRSdkPNgNwqPEyDaavfazxDG97gj3
	 ljj3dJsFSXJZJK5FGH5sLTEKeGdmcS7RZjPV3X0C2OwL81FSfQ+Lyws855xIDXEiuK
	 UJcDIZG/jsaTRK0Cc2PzRCUrNAUfQ0jZ6CJjvYP8h9e7wjE7EEDjvJv2N6k/ixNDxJ
	 wFV618d5cugpubdxzvYQG7gfOwpQ9uFgzD47c34xF7rPS9npYe1wGQzj+yHpHRB0rR
	 Gickzu9rVG5PA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Marco Ziliani <rylos78@gmail.com>
Cc: Kyrylo Biryuk <illofspeed@gmail.com>, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261107-pmp-88sm9705-v2-1-18eed983d3db@gmail.com>
References: <20261107-pmp-88sm9705-v2-1-18eed983d3db@gmail.com>
Subject: Re: [PATCH v2] ata: libata-pmp: disable the SEMB port on Marvell
 88SM9705
Message-Id: <179405758634.946822.2611921287082577908.b4-ty@kernel.org>
Date: Sat, 07 Nov 2026 14:19:46 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Sat, 07 Nov 2026 14:13:30 +0100, Marco Ziliani wrote:
> The Marvell 88SM9705 is a 1-to-5 SATA port multiplier with one
> additional SEMB (SATA Enclosure Management Bridge) port [1].  Ports
> 0-4 are device ports and port 5 is the SEMB.  The number of fan-out
> ports in GSCR[2] is 6 when the SEMB is enabled and 5 when it is not,
> so on boards without the SEMB there is no link 5 and this quirk does
> nothing.  That includes the common 8-port PCIe cards that pair an
> 88SE9215 with an 88SM9705, which report 5 ports.
> 
> [...]

Applied to libata/linux.git (for-7.4-fixes), thanks!

[1/1] ata: libata-pmp: disable the SEMB port on Marvell 88SM9705
      https://git.kernel.org/libata/linux/c/6b67cdb4

Kind regards,
Niklas

