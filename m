Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323015;
	b=qxE9SrOZxIJ/YUI2N6HVMhpScsNM7m5MFkMW+sfoeHRQuZ/NhWLwufnGUoFYJYmcm7EF
	 6x0hKtFlm9f+icuVROnkItqdmxIexkqNhiH6c9cQn+DVFd2kDRBPaXnJBlLrwPzI1qrH2
	 KZWf+2o1GOWTT9kzfSvgB7dGi8Z28QOBKTB2XDNvRlU4LsrqYkRwh0/hcO1qlvP5jeF/b
	 Gd/I7NKRDR/VKEERpV2oHQdwRu/MwAdzM1E1zqhxagLdzf7EtZVOvjOSYb2KudrUNg+Ga
	 GBOS2flQzHEvHTpZKyjJz4huehdkUSsn0V0h+C0d+DDAqtQuFrVMuME7YBJ1bfrnAtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323015;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=IslVlOmwBGg3p+v3gGF46rUJoUJouv81e/78UA4si+4=;
	b=XFkGS5f90xFGXIzLCcQorcgnjpyyZQyPfZznbOCAQEskmbztujowIqaqHScAX8vnMf2x
	 8x2fdX2CBHL6HrRkioHKPLIjgSxoXRio+8WBvOi5PlEUV3dlhREZtFk+CMPzbzDUsGpGx
	 HxUfcMUJGGt3cXcUN6EjLMZACozJEKk1EPQOKuOn0vAmVkoWN9COG6mtYLpjrWxcnBIo1
	 NpeSLXf6Nd7Cdt4tvsgHps/rsc3baUTPfSvgB+uXs/2a24CtW1tbN4Z4fqkV2YBMtKZZt
	 kflhyTT+C8/tIE7xJd6sODV1IT+ToZ0HEP2rCMBe8NM5NFCjdMhunyim+Acq9oj/RcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=YQmw6diV;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3160A5BD5;
	Tue, 10 Nov 2026 15:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5D3160A5BD5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=YQmw6diV
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP8zn3zJzz5BNRx;
	Tue, 10 Nov 2026 23:03:33 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794323013;
	bh=jjq1ZQM75nb1ZoCa5+xB+DaGEArgjFHQrWX3hL0CSsQ=;
	h=Date:From:To:Cc:Subject;
	b=YQmw6diVzMSZn5KgHVq+CxCqmDgGPwZR8r8fPB3Lk0nVx+QiMJy+TIlsfSTaLlB9x
	 eRNOhyHPZmL7aWU8kefoOwZAU9moiWhOSscVlDDZCg5VGaEJGcT3CvaZnCZ7V11SP3
	 yI1jiwgyXMUNAw/HdCd18BaY93eSbsyWPfPyH3eMLCflMuIz0yxpnUM4Z/rv0KKaa/
	 MvFjRlEFYZbIlBnZ6NFoNAGDHh+Vf4Ru5QibcsK1OAoSE0NLaf8lQbTVpCuDs+vZIW
	 tAM6X2A1sl5BT1KrglxSvWt4n/RWB4Iidi7uLy/c0ws6PB/7T7WhxRDoratyTNfEqS
	 ng7yOFBZ9mRTA==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AAF3NAb030791;
	Tue, 10 Nov 2026 23:03:23 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:27 +0800 (CST)
X-Zmail-TransId: 2afa6af3323f1cd-1d7f5
X-Mailer: Zmail v1.0
Message-ID: <20261110230327212pqd9rWq5IWa4wD-Ckj5C3@zte.com.cn>
Date: Tue, 10 Nov 2026 23:03:27 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <hansg@kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvMl0gYXRhOiByZWplY3QgaW52YWxpZCBEVCBwb3J0IG51bWJlcnMgaW4gQUhDSSBkcml2ZXJz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AAF3NAb030791
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 23:03:33 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF33245.000/4jP8zn3zJzz5BNRx

Both the shared AHCI platform support and the DWC glue use the "reg"
property of their port child nodes as a port number without checking
that it addresses one of the controller's ports.

Patch 1 is in the shared platform code.  ahci_platform_get_firmware()
uses "reg" as an index into hpriv->saved_port_cap[] while filling the
firmware-specific port capabilities, so a "reg" value at or above
hpriv->nports writes past that array.  Patch 2 is in the DWC glue.
ahci_dwc_init_dmacr() walks the same child nodes a second time and uses
"reg" both as an index into dpriv->dmacr[] and to compute the port MMIO
base, with the same out-of-range consequence.

Both loops now skip child nodes whose "reg" value is at or above
hpriv->nports, matching the check in ahci_platform_get_resources(),
which has already reported the invalid port number.  The two patches
are independent and can be applied in any order; each carries Fixes:
and Cc: stable.

Changes in v2:
 - Do not print a warning for an invalid port number: the resource loop
   has already reported it (Niklas Cassel).  The check is unchanged.
 - Send the two fixes, previously posted separately, as one series at
   Niklas's request.
 - 2/2 keeps Damien Le Moal's Reviewed-by from v1, since the only change
   is the dropped warning (confirmed by Niklas Cassel).

Link to v1 1/2: https://lore.kernel.org/all/20261029190111138tS0yRo0lL1zJZ_IutobE1@zte.com.cn/
Link to v1 2/2: https://lore.kernel.org/all/20261104221318841yKO89PGcSNeaV4KutBOUJ@zte.com.cn/
Review 1/2: https://lore.kernel.org/all/avHkMosHVOXCpVPD@ryzen/
Review 2/2: https://lore.kernel.org/all/avHknBRJnZPpAIke@ryzen/

Shao Mingyin (2):
  ata: libahci_platform: reject invalid port numbers
  ata: ahci_dwc: reject invalid DT port numbers

 drivers/ata/ahci_dwc.c         | 4 ++++
 drivers/ata/libahci_platform.c | 4 ++++
 2 files changed, 8 insertions(+)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
