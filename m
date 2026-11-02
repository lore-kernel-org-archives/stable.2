Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633593;
	b=v+oUNmJiuH8RfTsigZLKc4B8fQzQzfppb41jnkJDJjM4JM0Iv6i/9b0/jHBcjdqud7DY
	 1gC/KfcFxuDQtjgw1HlHYivV2AhnN5bPaHH7mybpUj93kZgOUBf3018F++569x7ls5SIn
	 Pen2nXpCPgti/vaazmRdv3ggnBJC7ylKaikuPHCa3t6gQBgYKKLd+rcoh57QEPcUUAddJ
	 rL2vu2t2Lr0G0JGikXXu+l+MJUVe3m09F8+A4eva+QakLyJ/rmBN6wDBZ+m2lvWJfC0bh
	 dZuHZWKPkZGkpx3Eso5U/YvPhXvsdQGIaeOwF3iTbqM4g4XzeooV1KbY7YQ1pSAIfhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633593;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=4+LAcFGtzGdSQ8GQ/D3ZV7dt7pVsSriYUcY25iYuHXU=;
	b=5oUE30DKxVQxsugR/o3Gn+4JN9qKKFVS3oX2Ls2xANnhD0y/2n2+tFR6Ykhj3NTyHAuq
	 EYQB+KY5E5C9tynFA4Xj4NV4lnXNCD4bZwSFxN9tbyNo7xedQOcTG+p7pBmTd6jvcALJL
	 2eTA88GLwhSu8kacP8R5MibQAH5p+9YExaNgN71UR52ppNXEv5UkICRW11RJ7ib/VqTwl
	 JJ8Yzgz9x+s0Nw9wkuZgsKJRLiClZvHDMhFUWOAtHRtJU544yBV98qC9QYzvs60sRk2K6
	 Y5EH1DLky3p8htlfGNC0iVqQKwJwcykywWOE/u+dArsSJxg6MlkJXlOjfNczEPckJ4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=online.de;
	spf=pass smtp.mailfrom=online.de;
	dkim=pass header.d=online.de header.i=cito@online.de header.a=rsa-sha256 header.s=s42582890 header.b=E1s7g4KV;
	arc=none smtp.remote-ip=212.227.126.130
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D6C608A354;
	Mon,  2 Nov 2026 15:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D6C608A354
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=online.de header.i=cito@online.de header.a=rsa-sha256 header.s=s42582890 header.b=E1s7g4KV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1793633562; x=1794238362; i=cito@online.de;
	bh=4+LAcFGtzGdSQ8GQ/D3ZV7dt7pVsSriYUcY25iYuHXU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E1s7g4KVMfkueLOUa61HKQ1EYYRNcB8PrSvDeGonUfjANs2CmA7hJJAESOafM48K
	 9tzuX56vrpAXTEezhnCmp9IEq8zfQlO0RD4Ts1I0akMSKtpVs9BrLfwUOEqFBfS1P
	 63sq9+9IXSF913dbQ5HeEMNpgJXQ/VpDTofGp9UNaTdymvFV03RTwYHwYNuQvb/8P
	 qiim9z7w0NGfe/2NOXGr0+X0GPCF2kaWBTYOibLGl2FyLU+/VflquiRiZ8GHiFVY5
	 qBAMX30jD37akr8EMDe7DZQsfzrzl0L8acTt4gjSpu+ms694/RFZRoCMwLQNZDIHA
	 j4O4CqSFt+tl8PxxsQ==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1My3Ad-1wbAU126O7-00z6zE; Mon, 02
 Nov 2026 16:32:42 +0100
From: Christoph Zwerschke <cito@online.de>
To: stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Erik Brangs <erik.brangs@gmx.de>,
	benh@debian.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	regressions@lists.linux.dev,
	1149377@bugs.debian.org
Subject: [PATCH 6.18 1/2] Revert "Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU"
Date: Mon,  2 Nov 2026 16:32:40 +0100
Message-ID: <20261102153241.373878-1-cito@online.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <0cf3aaf2-9911-4918-8f6f-c11d6077d39b@leemhuis.info>
References: <0cf3aaf2-9911-4918-8f6f-c11d6077d39b@leemhuis.info>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:loHoDm1fmTYoByffe4I5umF4gAEjNvFrd07U+ei8Is3/fGSYvza
 TQzsHSWtCoUo42ZWdHGNet+ayNCeWyTPB8jjnciC46zYW5tPDCghyrJtFi3QHQ0H/Eg4h3y
 MEoiFQFOGbnwCnAbTZXEDB98qZcsBD+ObTd76PtclBtTEZlcVT3ZUisR7kQpMrq2u7SDAhN
 /YLEUh62cIN+hxWRBbWIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x0eKzA0PKI8=;JeNwR1hDN0rresbYSnTxa3a0fk4
 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
 0luUfqrDiyfIeaJ1Hp0APT6sIIYA==

This reverts commit bce588b4ca081833ed8fc62062291f71d4218278 which is
commit 6f0624b4427e38c3bb63a951c536cf8adaee1238 upstream.

With the device ID in the table, the adapter is handed over to btrtl,
which in this tree, together with the backport of commit 4a23ce935f74
("Bluetooth: btrtl: Add the support for RTL8761CUV"), now requires
rtl_bt/rtl8761cu_fw.bin. That file is only shipped by linux-firmware
since 20251111. On systems with older firmware packages, such as
Debian trixie, the adapter no longer initializes. Without the ID entry
it binds via the generic Bluetooth class and works on its ROM firmware,
as it did before the backport.

Mainline keeps the ID entry, so this revert is for 6.18.y only, as agreed
in the regression thread.

Reported-by: Erik Brangs <erik.brangs@gmx.de>
Closes: https://bugs.debian.org/1149377
Link: https://lore.kernel.org/all/179104011040.2214689.5921682013387867802=
@eldamar.lan/
Signed-off-by: Christoph Zwerschke <cito@online.de>
=2D--
Tested on 6.18.55 with both adapters and without rtl8761cu_fw.bin: with
the ID entries they fail to initialize, with both reverts they come up
on ROM firmware and A2DP works.

 drivers/bluetooth/btusb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 59fff918fd2d..9d6610b8ecfc 100644
=2D-- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -845,8 +845,6 @@ static const struct usb_device_id quirks_table[] =3D {
 	/* Additional Realtek 8761CU Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x1bef), .driver_info =3D BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0b05, 0x1d70), .driver_info =3D BTUSB_REALTEK |
-						     BTUSB_WIDEBAND_SPEECH },
=20
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info =3D BTUSB_REALTEK },
=2D-=20
2.56.0

