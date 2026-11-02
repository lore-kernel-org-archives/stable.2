Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633596;
	b=wbPbHW+t1VN/kpGl0tz8VQUFSD8iCAzS/aTFGV3ROVO5qSwmwqBv0kPUWbn56EVrpLV9
	 bwfGZqUe7pMLJhG+63JYudvraNE72XN1Pq/OCodIHrOmardGENr+eB5WTC44B3oSploqd
	 JtTOeeJ58KWj99YJRWSagqAQVj73z8u1OSQzgJtYE9wWu3EdSgkEcmV/R4yxoGMRsl304
	 dChYh4Uh2rWUN8jV0WmokpzdZEWZ4n/5mv4P8+iEtYtiMsOlgF2MV00euMDZds4n/1Gow
	 JsL/MOY/uQyy2OcJu0LgQVXE+6RWCjhYHPAdU+kp3ylxk1DzZkgBHAOyQ+IxbBEEDYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633596;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=v+D0D7gwO9eEkB3WVqiwBrJfrYEsyonPDFETvujz8EE=;
	b=dE9nBwgU0th+KxM+6MNiEcHTgM38aFZYBRLsOZHeNHv777SiG7DiYWO3vhN/TaL+3CcW
	 yH+d8QMYnxIOKyB/9Y1AKsjFBbsdoWmfFyfJROPxvVEA6AxCslJUzvEaItRhfPWXi5Oz3
	 /j52K9b4f72nndDsWrRsyP+RM5zj8h4BY61zr/T5XPvsRYa/UkL1u7frOWmSsrm6N73ln
	 t5HRbrLJtqRa+EU9Tgj8pte99sfJpV/VYFrUC1LCaJq51eH9W++bUsyhEp51A+ddVwcD2
	 LuEEzNBI+Huw7p9DoHpnBtMaWBBx+vrmmLPL7P4iXQ6cXsbkoyagcU3KBde0hP1HUvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=online.de;
	spf=pass smtp.mailfrom=online.de;
	dkim=pass header.d=online.de header.i=cito@online.de header.a=rsa-sha256 header.s=s42582890 header.b=UJHmVRZv;
	arc=none smtp.remote-ip=212.227.126.133
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1323260D95E3;
	Mon,  2 Nov 2026 15:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1323260D95E3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=online.de header.i=cito@online.de header.a=rsa-sha256 header.s=s42582890 header.b=UJHmVRZv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1793633563; x=1794238363; i=cito@online.de;
	bh=v+D0D7gwO9eEkB3WVqiwBrJfrYEsyonPDFETvujz8EE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UJHmVRZvbP4hIGvBPbb+mPEEapuAZ+zeWEztJDPdV5/vx7AmWAPCyLI13p3JPKqd
	 ObrTH97VLZArn1MLKuan0S795e5E/iS+iDxCM0vEdkByqdke1+NwFzeTZEji0PwQw
	 P7IbQ2ybIGoTW8MJSFSCRWxFQNwzxz7tldY5TKlXNfRF9nEbmzBXVBdRb0WUFibVM
	 i1KPch42sXxIQLy/wRsMjstmwUiUUJQ5ToMdUaIjxj8fc+vt4churqNguc2IGhdfh
	 Ew+QhW/HOkj0kXbum5If/3oB+MpwmNwZ7bByh/b8ig5TjqrzMPGYB/TQRNNTyzaxE
	 ElKM5hS85Vx5BhOLZg==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mi2BV-1wtG6E0d3x-00diWI; Mon, 02
 Nov 2026 16:32:43 +0100
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
Subject: [PATCH 6.18 2/2] Revert "Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU"
Date: Mon,  2 Nov 2026 16:32:41 +0100
Message-ID: <20261102153241.373878-2-cito@online.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102153241.373878-1-cito@online.de>
References: <0cf3aaf2-9911-4918-8f6f-c11d6077d39b@leemhuis.info>
 <20261102153241.373878-1-cito@online.de>
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
X-Provags-ID: V03:K1:CNfaH5AzoLko6AUgTrUQvFKiE/1miiRurP+XSNDgMErRemo0S7P
 kAN3uKfYy6VsymcN7VizVp6TaifFgJg7gtjJDt81CNxRSw+apUo2D+9i375LBp+I7dpVQsQ
 UkjnzfuttLoXgEGTC+o+AzlnOdwBAOXPPzRnGfBunmdAQzHHQhxuMkvqVoaCXMicv3FiICH
 STkgl3UjFm2Jrnb6ugu2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0XhjqiBUSZ0=;lZ5nkc5ESEeHedpojZJwi8enJ2h
 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
 7QYs+7N7

This reverts commit aa7b93fe98ba726971b7d0c68320ce513e68aac2 which is
commit 980084de4d9b25193398d89a1c0430ba3501b683 upstream.

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
 drivers/bluetooth/btusb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9d6610b8ecfc..0229d0637013 100644
=2D-- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -842,10 +842,6 @@ static const struct usb_device_id quirks_table[] =3D =
{
 	{ USB_DEVICE(0x37ad, 0x0600), .driver_info =3D BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
=20
-	/* Additional Realtek 8761CU Bluetooth devices */
-	{ USB_DEVICE(0x0b05, 0x1bef), .driver_info =3D BTUSB_REALTEK |
-						     BTUSB_WIDEBAND_SPEECH },
-
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info =3D BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info =3D BTUSB_REALTEK },
=2D-=20
2.56.0

