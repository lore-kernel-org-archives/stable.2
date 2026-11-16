Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794841616;
	b=11DkMdHWWF5+TGoGvfqPKHhpWxv8UqovPR1iC6OyE6eh5XbiO+LPMy8mimkwLRyLmoYE
	 nrtVnjupun3WYI+yotYJy1odY4Jje9p8Lpwgjh3AISkmOLzeK78eA6D3Xryd5DIARgRLu
	 MLo3dCBeZe2FdUsPhY7CUdYnQ+IVAFg268wm7pyTamb0kcX6U99b2mKLG+UbRbYmCCDF6
	 90C0IZ44ChMUCbEE1bwzfy+gumkNwyyZFe/G5xfL0tSgNYqX4v5/SSHdTj+bs+h68zqiE
	 MXrlumAMcdalnYeIV6OapZ69O0Zv3UptN69D/dHOkBt8xiguRPwxmLUF7mYDY2C3+AQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841616;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=T1UsFtKq8NK+F2gPpj4Li9wd2ti1JativxkcIukMKKc=;
	b=T/MmokKxhzZblZcaa+XchzpUJdqeXFinc7TRnePXWxqXI+0JojSzeepcQPAkiv6Oq/Xu
	 bt342FSxxx/wSV59r0lzmRr9NFikwNLId4Hr5SnuEC4pMV5h7+fMQgJTVFfOJ46oKP7a3
	 Ul5DhEy70n6Kln+1eD3nsBQKl+17FFSdw0GNOakD5b+ODZx9jX1/SgTsVZM47dnpwoJdm
	 Ffj5kFV5wVwwJuh/S10fll4+LF3ZCjEcU2viezcP86V1BWoN5B6XFa6Foyhcf0Wjkht/v
	 U8lhGee7CQWXMloZtgSjgEg5S/fj5jWfKwP9JFjtDTuQmSaXs4ONciydaS1QxF4FUJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=QmlsSaG5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197DD606A32F;
	Mon, 16 Nov 2026 15:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 197DD606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=QmlsSaG5
Received: from [127.0.1.1] (unknown [IPv6:2a02:560:5d79:c700:9ebf:dff:fe00:fdb5])
	(Authenticated sender: sha@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D9ACA205A20;
	Mon, 16 Nov 2026 16:06:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794841608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T1UsFtKq8NK+F2gPpj4Li9wd2ti1JativxkcIukMKKc=;
	b=QmlsSaG5ynYAJx0UP+YLAFN0EUIcDEZDTZzBksyOqw47j1n+NvJPLYoaiBlny8lQH20c6h
	3CEJD8emvI8coq77VnBPqKlqV+OIbIFdz4yoyMCNeqBUyPZxJYVTxogo7NFNWGVH1xloEe
	8c/saAFrRg9+aqY1DEsEghb9YbGzFmuN2TIKJIFfGV3RJarCwIADI+ux66rekl0KjbeTsp
	x7lT9ubcuzfES83kVANoD8dbMg3ZK8OGjho4BnmXKIxsCMqcPq5aH2aNTqVFeWbtQXevZZ
	DVfIWaWnaiQell9sQi6CDts6MQTiDpAkE8f+cv8av48nucqnN6i+rmv5vbrErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794841608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T1UsFtKq8NK+F2gPpj4Li9wd2ti1JativxkcIukMKKc=;
	b=doqzRaBfDk1i57VmCmT9ogef8+tUqvmoUauuEQI6cpYxjQMm3tgOjAx+XfOuWXND24yLci
	sEW+lH8aT5kH0jxT1AAikYv+znIo7970a81UbPenDdFurI3gVAgvzQ5euDWRABKxMSAB5B
	ms/edFTnX/WvCACz4S5egoDIAHfBT1ntiRbLRCex/d5rzwiEqpjd3eExWr7zM0QoZv/T10
	cBeVkehzPSY84DxMi/ejyKVOc+lJPIB8L68DnjW0WhAyHLEGkKdzkQB6jX0gkodDpFdBW5
	sjZEkfUXnUKUpib1nb4mMN4BPZU+6YhBNr1d/iJsevrEbN7mqA3Tnw+lhEXJEQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794841608; a=rsa-sha256;
	cv=none;
	b=YDKwT2KcAbwwJem4JMz0FLBPm1rB3yH8eIr1OmE51O0lTBYof/FR6WPVBoejf3Qx3Oor6J
	BPlKIFqQtnzrT5HtA4SwjFw9pHUcgc4PtQimq9dAXWsEgZo6QHOJb/ZSuqErZ3sbbaJC/D
	8mXprYuGBTScxCi9ql1+4c9Et/txRSDLjYMJjlh1PcYZOZPPdC5MjYBkWaEZUFAsz0qgy6
	t/XoBfAsU8wahpYN1Fvdx5dFSy9SP9AkWoIXOQIAaks+fd4pbu2esYA4hZJ08uoX0BBZ5z
	ukze8UAqSvR5zIoMetvQr/KkvLORzfwzhS1wBTCAu5UM/6YGl+O+mSWwAhTUVw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sha@pengutronix.de smtp.mailfrom=s.hauer@pengutronix.de
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 16 Nov 2026 16:06:42 +0100
Subject: [PATCH] media: synopsys: hdmirx: move the reset bulk data out of
 the driver data
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
Message-Id: <20261116-hdmirx-resets-uaf-v1-1-1903146a3118@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAEc+2oC/x3MTQ5AQAxA4atI15rohBGuIhaYogs/aRGJuLuJ5
 bd47wFjFTaokweULzHZ1ghKExjmbp0YJUSDy5wnIo9zWERvVDY+DM9uxODLylFGVZH3ELtdeZT
 7fzbt+34L/OahYwAAAA==
X-Change-ID: 20261116-hdmirx-resets-uaf-d6792101954b
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794841608; l=2962;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=8OvIriJY+xaEJsg+OIxVr3VqHqkZqrLen/qgRskmuS0=;
 b=DarysF3AcdzMfMP72QUydhstkpIEWzGnV42s5EoX4zEO1RAfufLarACCepZiW8v+ZuPe9Pj/k
 GBLnQWAmy6sAb6Yy3Kru3dVKYsmOVgAI1QiBpi1wx3S2E9fkvknnK7Z
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=

devm_reset_control_bulk_get_exclusive() keeps a pointer to the bulk data
it is handed and releases the controls through it when devres is torn
down. Since the driver data is freed from the v4l2_device release
callback, remove() and the probe error paths may free it before that
happens: on every unbind without an open file descriptor, and on every
probe that fails after hdmirx_parse_dt(), in practice a deferral.
devm_reset_control_bulk_release() then reads the controls from freed
memory. KASAN reports the use-after-free, the controls stay claimed, and
the deferred probe fails for good with -EBUSY on the exclusive get.

Give the array an allocation of its own with devm_kcalloc(), so it lives
exactly as long as devres needs it.

Fixes: 03ec4aa9817b ("media: synopsys: hdmirx: free the driver data when the last user is gone")
Cc: stable@vger.kernel.org
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Hans, this fixes the patch you applied from v3 of the hdmirx bridge
series. Sashiko pointed out the use-after-free on v3, and the fix was
meant to go into v4 of that patch. If you can still replace 03ec4aa9817b
in your tree, please squash this into it; otherwise it applies on top.

The remaining patches of the series will follow as v4, rebased onto this
and with the v4l2-compliance output you asked for.

The fix was developed with the help of an AI coding assistant (Claude),
which also drafted this message.
---
 drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
index a241761b1bcd9..8a5304603c00d 100644
--- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
+++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
@@ -144,7 +144,8 @@ struct snps_hdmirx_dev {
 	struct mutex phy_rw_lock; /* to protect phy r/w configuration */
 	struct mutex stream_lock; /* to lock video stream capture */
 	struct mutex work_lock; /* to lock the critical section of hotplug event */
-	struct reset_control_bulk_data resets[HDMIRX_NUM_RST];
+	/* devres may release these after the driver data is freed */
+	struct reset_control_bulk_data *resets;
 	struct clk_bulk_data *clks;
 	struct regmap *grf;
 	struct regmap *vo1_grf;
@@ -2296,6 +2297,12 @@ static int hdmirx_parse_dt(struct snps_hdmirx_dev *hdmirx_dev)
 		}
 	}
 
+	hdmirx_dev->resets = devm_kcalloc(dev, HDMIRX_NUM_RST,
+					  sizeof(*hdmirx_dev->resets),
+					  GFP_KERNEL);
+	if (!hdmirx_dev->resets)
+		return -ENOMEM;
+
 	hdmirx_dev->resets[HDMIRX_RST_A].id = "axi";
 	hdmirx_dev->resets[HDMIRX_RST_P].id = "apb";
 	hdmirx_dev->resets[HDMIRX_RST_REF].id = "ref";

---
base-commit: 48fe5a7834cc10081887d7bcd9ff0a4cadc3fa8c
change-id: 20261116-hdmirx-resets-uaf-d6792101954b

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>

