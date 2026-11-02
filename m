Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633590;
	b=v78YuivYsIngwUKBJl4PSxFNCmqKAFiItComeLpuouh5hZCLMhex+FGlshgcnn+tAdRI
	 efPbZV5GHmtymYofU3BGP1GRy4yP+slYPMN7juNovYwSYyZVQZVC97G6120EEOUYNP+06
	 0jcRo0uJ2G757PZcSilcblAoEPNbWj5m2RCKYsuq5T6OPn8KQn437Tb1t9Fc37p+CYc1e
	 u6N8/j/AyNze3li8+RsL8vOjK2Bx7wqmIfI6VPO0Fu3L3dTFB4gtSbEj6OU+r/NOQXYst
	 ClTEYtPINbvvCKfYvnH7J0sFjdZHZFdhkmEN409G2VOmWBUoCACVIWTRlWEdnlzAoaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633590;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=P3gziTHx8CMmwlI1c6o4J2lA5lTkZqRgb1nFTn/4q7c=;
	b=JS49/8jvjS8vUYwZch4LpUTMkyMMHjZS0xrZ68HsastZzCtntCNyb4+t/9Ak2QHk3619
	 xPPF2pIwfyPkCnlrW+cj91xZtPxhTjDAbK/I+XE4FPn1Wfigfb8FVJEOwKRi4l00emWOB
	 hclGNTUIwvys8Wp2+Sm5276F88vKNn6Ds/VxY5zGOwMn40mmNv3ae9Ewq579jaXaxivdR
	 hw1HaEk86efE4COSIxjkdoeHZvLZXqV0hnIgkzunaQ0CkF4/51HPOt7kMXMC9832K3QW9
	 W41kvvVNIzOBa98xxqsowwEPQJT1Cao08oCAaZu2EYmwFeud0whXkC6Cs3XZ+MNSDgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=online.de;
	spf=pass smtp.mailfrom=online.de;
	dkim=pass header.d=online.de header.i=cito@online.de header.a=rsa-sha256 header.s=s42582890 header.b=LqEanx5m;
	arc=none smtp.remote-ip=212.227.126.134
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5618608A351;
	Mon,  2 Nov 2026 15:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5618608A351
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=online.de header.i=cito@online.de header.a=rsa-sha256 header.s=s42582890 header.b=LqEanx5m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1793633564; x=1794238364; i=cito@online.de;
	bh=P3gziTHx8CMmwlI1c6o4J2lA5lTkZqRgb1nFTn/4q7c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LqEanx5mqDs4UHDsrifBWjTcv5U+VpLsvDdhDYlLkYwnYIQ/GJJab2tBUtnv1BSv
	 LrvW6c64MeAQ7qy4Vxp9pq+if02KT3VIZsbfHqRwvkp2H/NP/Eqrmyvn4atBM3Anv
	 qcK055fqs1ONH5AikfRaNyO1w+srsmxJz8J1tAmzsZxjwkCMP7gGpCVsad4QyGtLE
	 HQkwmClWVST3Rbhuzgv4IAIetVDFNO8m7QCsBpPhZjMyX3E5+mPVs78078IWkcE9j
	 3tKc3Sh270N6Hfj3rf5ovpqXHtU/FRqAUWBd9PhRWPPfhsyk9UQXVheYR4okWVJ0C
	 V1fMQyHGZC06QHf/og==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mxpqo-1watV402ec-00vlcx; Mon, 02
 Nov 2026 16:32:44 +0100
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
Subject: [PATCH 6.12 1/2] Revert "Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU"
Date: Mon,  2 Nov 2026 16:32:42 +0100
Message-ID: <20261102153243.373899-1-cito@online.de>
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
X-Provags-ID: V03:K1:SwOeEke6jMmGJ3rFIcPIGcokqfXxSxdPALB3a+wgHSZUHS/FqrB
 TcdanMyQFgKPEdKW2dp0UXFiwm5B3U77cHrjyHHLc64y2yEXPAEcBj2DmKzieQlaOC2Jc99
 CZaS5iRxomJS/PPEBb1KGi+9uAe7zbcLqb+2FXFDVv1DYN3tLMVNuauDJZ9KSzTgw1oi9AE
 bQOIVl6tB7fbfnPXy+1qw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5Pjwte9dNI0=;ndSHZ6UfCHGaI1uQ1Qfn5ll4sy7
 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

This reverts commit 32412aff8d11d00672053cb10750869f2de94a1f which is
commit 6f0624b4427e38c3bb63a951c536cf8adaee1238 upstream.

With the device ID in the table, the adapter is handed over to btrtl,
which in this tree, together with the backport of commit 4a23ce935f74
("Bluetooth: btrtl: Add the support for RTL8761CUV"), now requires
rtl_bt/rtl8761cu_fw.bin. That file is only shipped by linux-firmware
since 20251111. On systems with older firmware packages, such as
Debian trixie, the adapter no longer initializes. Without the ID entry
it binds via the generic Bluetooth class and works on its ROM firmware,
as it did before the backport.

Mainline keeps the ID entry, so this revert is for 6.12.y only, as agreed
in the regression thread.

Reported-by: Erik Brangs <erik.brangs@gmx.de>
Closes: https://bugs.debian.org/1149377
Link: https://lore.kernel.org/all/179104011040.2214689.5921682013387867802=
@eldamar.lan/
Signed-off-by: Christoph Zwerschke <cito@online.de>
=2D--
Not tested on 6.12.y. The same change was tested on 6.18.55 with both
adapters and without rtl8761cu_fw.bin: with the ID entries they fail to
initialize, with both reverts they come up on ROM firmware and A2DP works.

 drivers/bluetooth/btusb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 00aa0fffd0c9..bb83dc0b031e 100644
=2D-- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -820,8 +820,6 @@ static const struct usb_device_id quirks_table[] =3D {
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

