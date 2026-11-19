Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058672;
	b=eOy1bMJvkqWqoycBLP5NaXaWTFS1CS1AcwggLHQitAQw/a6Aqmagpx9UAmz/9mKsIyWK
	 lVTX+ijPF/JCnZjhDhcTLCVb9NAqdsKT4gcb75sixLZ38dsvLQtyI9OPiZq4ITcAEx8Ge
	 SsvWBSF9+c8S8tUIPFzd6+1rk+jWyUM6rpqewh0FhsjDbWr5sqIk7pZADZSm2cA1uNpIZ
	 OxtV2g0oPa3IXxzVxl0w/20D4YfKdcau8rAmI+64fhrESqJSpwwz/QrTq/2a/Ay0BcN4/
	 0UYpmAcjh/LfjYI6ZK76FXKH9owYko4fPE2z88zLe8wy+GTBuZ/cTwi81DW9WHxhjkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058672;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ftjToYKMaBjQKeTlSCHaYubAnG9XSWnjOLKjEJHP5J0=;
	b=dtfxRpsJzNp6UhxFL5/Au2zK7zjFIUp6bfcutuZQbur5Tv3u1mtHX42MrKe8/qw/60Z5
	 hknxAHTrjoo86OYC/OcEZV7ndbqnXSs7klYQdXGwtzdGwkIK95Be4GHNIin/H+8saO9vM
	 YtSPBTMde1y5Z6COCGUp+unkCsnLY+LinSs7jidSMaXIMENkgAYOAh6VQdEdLiPQe2xuT
	 rai05JIhrqiqJn9wGbi7gy8oiIcVcNUNXq/gdG8u1E/zdbTyZIw5GOrxVywl96QjtKJus
	 OnzSmwsQNGAJSx8wzk8iKyBFrUwiJrZrUTUoeeQJo6albwshZu2mhG9Jk/glm8TKmuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhjIEB8k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C14F606A32A;
	Thu, 19 Nov 2026 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhjIEB8k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395AB1F000C6;
	Thu, 19 Nov 2026 03:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795058672;
	bh=ftjToYKMaBjQKeTlSCHaYubAnG9XSWnjOLKjEJHP5J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QhjIEB8kaagHpcdpbHIy/0UjvPHInMvkLzekrtBvzEV1hd4iP7dWUwLZ99Z5qXXOF
	 65J6W8IYeORgohMrclDEkK6KXzrjw32QRBFRoM5kzBIHGYDsJoAK5K4wvhKsF0kFOs
	 lY+/i8CvVq0IRE9iK6AuKDgICKFvxAgXSDd4uTemUtWyA9bQOfag/9d9i3D81ji+ei
	 QjmHeRIqX3xQ3JWg0FLWgl0XkvWxkOg9KSh8omXFi1GLr0czLXy7Ry/2GlYgGnoPSD
	 dWoorpx0VvNL+jq8VvlLXrbGvahzTk5bsUbmFKEiVkL7ry/ixSoQMROIur0k7iPUkn
	 3i8JM53cbYvbg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Max Chou <max.chou@realtek.com>,
	linux-bluetooth@vger.kernel.org,
	tfiga@chromium.org,
	tzungbi@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: btrtl: Propagate errors if btrtl_vendor_read_reg16() fails
Date: Thu, 19 Nov 2026 03:24:14 +0000
Message-ID: <20261119032415.4010732-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119032415.4010732-1-tzungbi@kernel.org>
References: <20261119032415.4010732-1-tzungbi@kernel.org>
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

A NULL pointer dereference is observed in btrtl_download_firmware():

  [ 2592.730992] Bluetooth: btrtl_vendor_read_reg16() hci0: RTL: RTL: Read reg16 failed (-110)
  [ 2592.731005] Bluetooth: btusb_rtl_alloc_devcoredump() hci0: RTL: Failed to generate devcoredump
  [ 2592.731060] BUG: kernel NULL pointer dereference, address: 0000000000000000
  ...
  [ 2592.731906] RIP: 0010:btrtl_download_firmware+0x19/0xb10 [btrtl]
  ...
  [ 2592.732791] Call Trace:
  [ 2592.732883]  <TASK>
  [ 2592.732935]  btrtl_setup_realtek+0x30/0x60 [btrtl]

When btrtl_vendor_read_reg16() for RTL_SEC_PROJ fails in
btrtl_initialize(), the error code is stored in `rc` instead of `ret`,
causing the err_free path to return ERR_PTR(0) (NULL).  As a result,
IS_ERR(btrtl_dev) in btrtl_setup_realtek() evaluates to false and NULL
is passed to btrtl_download_firmware(), leading to a NULL pointer
dereference.

Store the return value in `ret` so the error is properly propagated to
the caller.

Fixes: cd8dbd9ef600 ("Bluetooth: btrtl: Avoid loading the config file on security chips")
Cc: stable@vger.kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v2:
- No changes.

v1: https://lore.kernel.org/all/20261027072148.3963826-2-tzungbi@kernel.org
---
 drivers/bluetooth/btrtl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index d29813331603..d2c2e79800fc 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1073,7 +1073,6 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	u16 hci_rev, lmp_subver;
 	u8 hci_ver, lmp_ver, chip_type = 0;
 	int ret;
-	int rc;
 	u8 key_id;
 	u8 reg_val[2];
 
@@ -1185,8 +1184,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		goto err_free;
 	}
 
-	rc = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
-	if (rc < 0)
+	ret = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
+	if (ret < 0)
 		goto err_free;
 
 	key_id = reg_val[0];
-- 
2.56.1.708.g77570a6a1d-goog

