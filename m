Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633573;
	b=Mw849OfqzmL0W7osE9nqC+mc/cm81gVlacxSO+use4ADsxncBUZ7Zz4mMDUDYdU3T5PY
	 Og1FTWqc7zd4GyNcpqFVMjI+ileNTCOP7X0A5/1Yj4fbxtvi8Qq/D6I5qcR9/R2YS8qLk
	 aVIK+sfdmxP+nBeWSzo1pixwyUcA2qy+ggk02VRhNd2bSC1j/ExQB1QKL8ZXSnq4Nc9oo
	 bq4IjKTyCDOFkaUKOuKA5ZghaTlv82I9miWaC+ntjlnCD+gNdo9WYOwULd83dVfwrn3GB
	 N1MvE8fZgYFfAjU9YDO3qeKeUldm8FIsXOlrtmJLPS3yizlXM1JCNhzHPxDWka+RCvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633573;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=CTt/YYvUfzJO1/7/KTOddM8YWPoh09+PQrKLe+3zoTY=;
	b=q3+eMvf9aG7JfR/OyzOdi22mggUxlbP4sQiX4iZRiMFD+U/sx6V9Mw0ROowloLT8Mi0w
	 5JP+jPKbC5esVwlVvFxM57Oyc7wudbUL8IAfOp6BNCpPuoR28u2U+/dJwNvP8eweETI+L
	 Zh3uMg2F9kK3edpgiWXviULFl9DsiHfkkHmT85E578vRFBuZNg752FM5HwpIBt4ExH7ZF
	 u3LrmywbQt7gGH/tFRAiKTSFhUIxa0G6KDMxqhuxVJbLg5ax5frQziSSoAfCwHNF7G4V3
	 +LIRFY41tGZn50LASKceW2au52v3PCd9jgOEtQheDSjDFH4v/XxJlvNq9g5sf6dmZjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=online.de;
	spf=pass smtp.mailfrom=online.de;
	dkim=pass header.d=online.de header.i=cito@online.de header.a=rsa-sha256 header.s=s42582890 header.b=eG3sZZcn;
	arc=none smtp.remote-ip=212.227.126.187
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CF7606ABBB;
	Mon,  2 Nov 2026 15:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99CF7606ABBB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=online.de header.i=cito@online.de header.a=rsa-sha256 header.s=s42582890 header.b=eG3sZZcn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1793633564; x=1794238364; i=cito@online.de;
	bh=CTt/YYvUfzJO1/7/KTOddM8YWPoh09+PQrKLe+3zoTY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eG3sZZcnEcwnovsqrKfrcSQo6xopFXceOoJM8NInhD3hvaGcvk2i6seOGqK+VKQJ
	 1VpZlCF10Wxq4Sl72FZT34rdAsz19GXI62ub6cnthPVr15H9Qk3lNPg+zpMU5qtzD
	 bJtzzU7QHkO69G34/5e8+FBKh7WPgAZLazxeCNzsV1jhrcqkRPeZZIT4qUUkxixVt
	 rxdbI3Fnul9x5433a7h1u65AlwJ0GCQ635egO4OQ1WcvPr0ic2tgiKlzTxKWlhbug
	 8Ss3Bu2pgV3+AN4+B8S0EV0XnmqMYlsuKkdLz2PNpHO07PR+NNQ/ffSUF8ZD3XkWX
	 sdN4jSqxPAWOJVwTGg==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MpTpc-1wj2Qq2eTc-00mWSv; Mon, 02
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
Subject: [PATCH 6.12 2/2] Revert "Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU"
Date: Mon,  2 Nov 2026 16:32:43 +0100
Message-ID: <20261102153243.373899-2-cito@online.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102153243.373899-1-cito@online.de>
References: <0cf3aaf2-9911-4918-8f6f-c11d6077d39b@leemhuis.info>
 <20261102153243.373899-1-cito@online.de>
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
X-Provags-ID: V03:K1:86HzDPGKrm0805yWCO5gVTYg3CaHKvLmGUE64u/rG676x6KlA/e
 MVNEsPYB7xkP56zCUAsy4+lQpgsyOrfZHzblIyuDGKMSNA8Mw5px1lBvckqnzTP/2VaMnh8
 4N/YcC87uN4z/rdxT5sTa57mwRBfmTIO+tN3KBS7+9+j6pNHtMCx1NlMd99sChDw9vd00Ki
 GNIzGnL+nlNpZRoT4kbMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SaYXDBaF4bU=;hA4/xwLKQMVyBOeqqJjDZikQUYg
 PAQfCIalUUrOeERvMQfjkRn3U6vsqcBZRzMwAv7gd8POkBE6j9Lu3ksI+8sgRezc0JFFmG1q6
 hSadGiecA7HTTxwHtU6p9f+2Zpdqj1bPRbcESGXLdC2eWj0s4r68yXvuS4K9ML4pvznrSJARy
 z+YbfdC83D3YTzlXqTfzZlxSQuU9Zz6YRQPkggQNsWo4n3BehDL5VeL/Gfb5eF6RmGOxN2em/
 BaPcpUFuKQXcCgHFtJjLB48kbxKnAX5D4e/KHPcyNRkIhVSi8s5Mbebqtx4tZmD0gfU4IFCvR
 ds5feQjskaGcyr5BS5BMrn4R08SwGiCOSNN9MTNCG1b8JtGrEnLJuEVLIigmUxF2CwFD8e56c
 Ib+ATM5XMJ/GDf58GDpoWOgFSB4K431qeJZwvlbjBpD/I0FgTIUlgUI5V1pVeL0zywJIDvv1i
 sf+n7yvqJLHEEaVCyLohQcry9VUGdSGNIVHljx3Su/fzQdLaaZvJk8Oaehacx4IYOZFNVV4pJ
 xVEnM6DSVntTZHZQwc0qhLMyy2Eo+4t1dpSkgzsP+xBU1VZkuy4v7NMVtLxPj5PSeOmEfp2NV
 GjKfXNIpKFfe3g8PqfHmppiLPt5uuRgmRi9qjvmmnKQxGQHDn0ksYKCi/RLlETK7L5l0fH8FH
 +J7G4nG+/iEelXaPtgNrMrU98TY5rPvXPmlcKzbMFnzdfpylRGzw0TP56dnCmyNf4ErLoh4+r
 G+LBLxo2Dkq3bFdhHmiQRb0CP8QP0jQb7Bi+lhHbYX4+b4jwa9SOn1bI4iRnQv01thslS0PnL
 JZBDrThrlNpW2Qj6ci5Dpc8OC00nlT8Cdt+JuAvDJnNs5cJnqNOt/eFtGczepMaWsF52sahgE
 Vls0EVjeLs/tiUJBt3Ap58z7hW5N5NzuI0g/dYCA2n+//UQziLhewtvxLNWvbu8LZspoHRCwW
 WWGQdlEfZ0WUTFyHFWpWoKhY+OvkLArE7ntpAIcbMIY7yWTPkpxV7DRDhHnan+km1oh34Ffff
 JJuomXXyzoahNQq/zUQnxw342zob/6KbihIr6rYDN5m4c2XeVw96RTK+2AhXRAH2XEJ0PqEiH
 JmM2mHpDYKxrNUkhwmcON4WaWeco6Ymyw2fetoYL6TQrtWfY0w7XwQvfXoKegtGkoAC1megvn
 znDfWb4Rcamt9NcKawxoTsoQr3hEzRri3yXyqN0mXAbkTIST5N4K5gQi5bLabHzhhLNTA08m8
 tEv7xUh7aBSorsogFmWfCP3Kymu4yHSJjZPpEqVtlx3sL8veIQoo6X6EDvN04oDE14JjS90H5
 n//MJJrhpdgxWFA3uRR/JjD7WDYbj3TRu/MlUjQvfWwK+ulht+5xZZBQjpqvO1TocPSqYCjMg
 grmCLcolHjdaFV59dudfTK4eYZ+23uAybUih8nKl5CBi8gIBXmkb6f3bPU8TRFZ178i3fN00X
 9wcfq0wLsoGwfIYpRTbkjDsMew+BrLPAmlpRpiPKxDb5RmTOja0z6Qmo/j/iKieRBERwaFOGs
 Uym+sE1U1/E6rANrT0lTNZSCVUVdRdf33Bj6LQYNJQPW/a8OiSUaixlt4rbKkEAwEj8vi1FFk
 N0eRdjta1ZFbArv5lCwoqIASDppbf6TeoVNsd0FUTkLlJ49RnBFy6/qufUbCIg+xpXhsD9jye
 uHEDie2mHZ/K6CDK9ryGijVaTolS8XXsGBjtb9SYjcPgSWZPTO0Oc5cSHY2AxaFHoStd5DJqs
 +74WHFKb9uPF2cgjOgFtBP7BETtDdXY4lWMkw4VzInaC/bb5umPACuEvRTXjAP5QYX7/+FMPX
 ewZlkgSkQmtGOdtl6ElA2MeFp2C9iMCuW0r7v4Pwg/BoW4m4pxEk3BhcjDzHffXLdlOyNwU8+
 cejKJMAX32cRKDbdlHwQc3vVO0penqT0R4XWjA7kYt31MMZ3Q3dnlEGIm/nS4AxdNYPfjxMPJ
 VQaotQ8LTce55Jd3m3a3VxpbPvpfTacYJs3S6BY7L5/OyvvF+PwmR2ALnHicFAzgz9wyiOZ0u
 Swbsl7QugQriO4A2XSh3/oi6EW0cEaK/Tt5/7d7w5e1f+OBzUJW6sCTRdZI301abMq47wPFyx
 C8KxqvgTFtVuWf2jNthwcVc8ke77rq6JHFr01WUm5Q2wnZ1wMjc7ko4qYDhHytuOQ+C8uEVZt
 LkZPkRlBbCbTLhUU4zk/3Q5Ovcd96/Ve4Eqg17yDNKIpeQhY25RQceSzbwRk0Zig9bFNE3Vvc
 f6NJc/FfGrlLADwPb3dVE9QcVuPIGVgxHxFJPTfMNS+M4WASts6B/HgWmrIFzc+oHW54E1Yav
 UQbvbWVWfvgnqJ/X0OlxfmApYrXJ6hywXBUqnannw0yyUH9frbI0vhXHB6v50GwXJu1+rL9xm
 jQqQvYWvmW7rCm6UjyLalr6V1OiLBY+a5YmZ0wjNAob70uSdNQjXDVoQPcre+wIIsllwoOYjy
 ulCRy1pLBEX+/OE8md/fkVc2ViJcE85W+AMb/pSBNQ1noN1H32JB0x2CAx6t3AVeBEa8qnotc
 HqCJ2n3bn2GVd1cvzOZqkATCAolhGnsNgMGdUKw73//TXsES1L59P6qbhJIYoWqiSvq4hPopw
 /IcR15LLzMRmtVJGFli9N7c1p6rK4b1Qb9R8bugtcC49llyaGAOOlQfMLRxAlyCQ3jJWE9d92
 fWvWySuIo3m0uPvOQ7F6SMIPfcf58fc00+mvXDo3sUaLVIPJxjGgsciudc+KFgW990FshkNVv
 OD5VFB6OXxL/njUrngQ3V1NWSrIsnEklkmpQ9L2S6Gf7XxrW9iFqVLu25k6lGFWPqFSXP34Fg
 iZPfljmN7r+E8De63U6a5W+ZyANARLMZ5D5u+X0yf+AS4IYYGjIms9h2hNwjAVGMn4fPjiVnA
 S/RMMzedj7eOfetA5pQr1Sg1VyG0I++c1wl1qZ2V8cLI1HBHZYVOfxd0d2Wo60EI+c7GOhcJO
 /zdLqEbgkzeKSZGZKgm4jzqJftxojzMjkW3cZJlOBMJVnWjf8k4GcDFab8gxQpVo2MxnLGae9
 9eHlr5GFXDL9WY0irtfNaj76iAKgz8wrKq73CUEcOqbv/RNh2eP19h0daPQYfurTjgH6+pQ5S
 +NJSNEHzgZ2HCZorm6rX92ibx7k69c0gie3DIU5xszoKDm/IlE3fedGqcnX7UGJllJbpL5bl8
 6w9MQdGrV16QjyQouDB01RCG0FbMxJMF1h2nJ3vAbprcU1Pp+y56/oipCpUi1ggbKu7x3PK6z
 3lsivoYpOXx/iBNyTYqROFa7taNhviHlqtoOBuIsBA3nFEMApXMZkG8tkcZBUVha28HF8Ko/f
 uss3x5fvBJz1NjdhtiePesBlxiWURxlBfBVQnokMtZNH/rbsBelcUDRd67OOr4ga2uMP7Tb/c
 mjQyptMopw0LT8IN6FT7NxyvU2dCiSwnlS/4q0Il5Ln46hd++3A1fNuegdhexIJA0vtBAKKRm
 koYqWySQ0pFhLu08cqgmHoZy3wvagw2uttZMd9REeD5NU4fepy15X7eHrDPLd2h7j8MmU5pdB
 hut2nJR9KQ0W5UYrq1qjwGNGNM0wLh0uBBiFjAEC8rLrsZadOHxsDsb88PIJ6qSpnLYUxs/BS
 c/qyweEMRemqmxzjJSp4XZCGpCWLYxVERv0KM/lZHeQO3hpgPR7+JNg5L+53AarIaLZBWWSD9
 sLBkkxVfM73qYYB6caxeBSE2R/NT2E2rze6jrnFaoukher6823jAzkYXP/h+ZR6sBz6vDOpma
 F3dTWEdyNDOqAGdTbyOTl59a5boqh0Eu4BNv747N8T3oz63eO9mD22nxumBg=

This reverts commit f05baf6e0680d8c10d2fbbc5953848fc3e3db957 which is
commit 980084de4d9b25193398d89a1c0430ba3501b683 upstream.

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
 drivers/bluetooth/btusb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index bb83dc0b031e..f8b5492c8021 100644
=2D-- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -817,10 +817,6 @@ static const struct usb_device_id quirks_table[] =3D =
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

