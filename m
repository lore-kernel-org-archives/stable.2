Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085739;
	b=tGXpOzWasXc8MkJq7bBQGCxoRY1ipwWiO9EDr6RwM5N1d2rCyOn6pk3jkI/RCtMRImE7
	 V///q5J8/wP80lKkTMS8hhSjxJEHlL0eDn0rsX15XEg7I6sMFBM3JmithQNSefvhnaBVj
	 gqg/QoU5+09E93EYcq8u2i8kxc2JEcN6AWOWz8rjBJEZsET75T0OK8ygrh0YO+NujFFzM
	 Ou/stkKBivUBHjb0p213BRFtPak1lUoOKf3qp44g/2Qd8SCZlU+62aotwhjPLPSOm5CJm
	 DjuQjF4oPrP9zPIFGwmnim2Xz9yHxGNVN5jSIt6zkGiykjfgh9Y89kp0cazOxV2A3Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085739;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JsUhQgYhLYbX4Kkfrba6OTA7TB95G8+K2DCg364sdME=;
	b=GMPlMuf1Stkcmpr56CuffGqk+4jG7QQCAgsAY/pMDbqn4O3F+nhRFIy5LtSrfAeOS0U9
	 IfLQnrp32lePmR8F02p9QrznodMVdhRUp/7yRqwlAqjqKHB4nLSX1eONPf2oxnhEZ6g3L
	 /G6SVaOFqyroi+y1ORnE6lL8Y4iPY0X1Mrhb0TiJ/pJTypjjVGXGWhT8XMCCLskJfw13u
	 /43vMC5d0QJ7DkWZL0Iy5JeW0sFQbSV7np1wftAVGUJrSj//gKxnWrNq3LFqbgCprWher
	 X+ZVpw+Tt/LGrbz9bugdo7AUnKePDgCxfnmEDExcLqTpLD2BnYQKj909L+rE8YQchWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xxk7Cki3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C45606A31F;
	Tue, 27 Oct 2026 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xxk7Cki3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5541F031E0;
	Tue, 27 Oct 2026 07:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793085739;
	bh=JsUhQgYhLYbX4Kkfrba6OTA7TB95G8+K2DCg364sdME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xxk7Cki3E+gWRVDPZ6nHxvfQA46+admaYon0whxApBCa96ueBxPexpYe+pdONks0k
	 ZmwvQ8N921y11ZWSkdbZi2kI/2Ic1coNgamsqP1giWSKOXsqjUUOeyQ3Q7PL6Y/tMG
	 7XcrVDEsrh6AiSDg462qp2WggcAfkf8hPSP5BoPBYxqmkAgYqm/WGXuMBLCjFEZUYE
	 aWj4m1FpvSVtF3TeQ9h5Xql7SK+s3czrirmi6OIGjbjihZUXCa92CZN/4+5FaiP0Vj
	 Jqzq1P1mzJ3NmqRt6r5mdiy6nBz7BNBO060vhs6cwpQxp9OP3CdKWDmPX5B9v1SkPH
	 tInYbvBtHaXAQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Max Chou <max.chou@realtek.com>,
	tfiga@chromium.org,
	tzungbi@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btrtl: Propagate errors if btrtl_vendor_read_reg16() fails
Date: Tue, 27 Oct 2026 07:21:47 +0000
Message-ID: <20261027072148.3963826-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027072148.3963826-1-tzungbi@kernel.org>
References: <20261027072148.3963826-1-tzungbi@kernel.org>
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
2.56.0.307.g5fe7bd680c-goog

