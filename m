Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797982931D5;
	Tue, 18 Aug 2026 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046585; cv=none; b=fFzoRvNdSYnXdg3xcxBJYi70apUBAasKO6NNAQhZF6EcDm7f9I2mENRNYu+QpEnXUGW5tVLy+dgJZkpR3V6nTkRu2DNOUzru/4not0b3hkfJmORZYiyAkhjhmCv82X/9aub5id+nfv13Vv1x6eHwvVm1ghVw+sVCxe8sAnz12rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046585; c=relaxed/simple;
	bh=y5GD6lS0t2jnsBMwQDdXpyEkybJrOftyeRvVeWJIWFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XvBD+hkVzJxmHF69tZFTfFh96Bs5kKKjDuv0FNRtPxq+tszY9R/hl0nigkOdFANCj0leMAlJzuPtjq/qzHxjr3+QjzSGG58W5b0Q8OQQ1aSO3mG6ziMAL3hlqye68Po2/UAHjC+Pk7cEGI4C6x9vGO9k5jQ8T5B9nueou8u5kQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mp127J7X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp127J7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB6A1F000E9;
	Tue, 18 Aug 2026 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787046584;
	bh=+3gQstz+ynLenZZkOIHRG2TEYZzSHYIitb2qWK/ts+w=;
	h=From:Date:Subject:To:Cc;
	b=Mp127J7X2WYfzJHcXaLguKI0yBVpMLYIP9vedFanrNG6QmKilyIXCzDYvExuVcTUg
	 1wbfOeMevZRupYhrZDUa92eRQUV9jcdoHPM+G+H8SC/MeDwY4koLjNLwCTNTZOuoQa
	 wVKFnsomqqj+g9uip8WtnQjnJ+ypHQnXlw1Z4vc0FdFlYN6EYqwtW09gS/CEc7ZiFD
	 uYVA3NXKn3L+SlFdErNN+/Jdg3qt388skhOSaSvNAisCoFqLPNqAyztpKgBDOlYABq
	 CPqPTXXK/GHXybs9Y4w2pb91WPubUTsr5rp/v1HV3okJLRyQOG7yjMAkCwGafesmWX
	 mdE2QEScmZJyg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 18 Aug 2026 10:49:34 +0100
Subject: [PATCH] Bluetooth: hci_bcm4377: Ignore reserved PHY in ext adv
 reports on BCM4378
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-fix-bcm4378-ext-adv-v1-1-81a143eac194@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkEzVPpKdChdaw9ZaIQQ/T3pO
 DAzD2RKTBmG5oFEN2c+YgXZNuC2Oa6E7CtDJzotrLQYuODi9l4Zi1QunP2NwijjlAte6wVqeSa
 q2n8dp/f9AOPzgC5lAAAA
X-Change-ID: 20260818-fix-bcm4378-ext-adv-0737c3cfd66b
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2533; i=ljs@kernel.org;
 h=from:subject:message-id; bh=y5GD6lS0t2jnsBMwQDdXpyEkybJrOftyeRvVeWJIWFc=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJatDZdiBD26Z6Xf+nL2WZpx1a+tqLKTMmZzpGielYcB
 SaPZG06SlkYxLgYZMUUWZ5/Ed8fJBI2r/OCvxvMHFYmkCEMXJwCMJGinwz/lBVsyhezFPzeFSVb
 bhmXP+1RBfs0Wb4gbcHlsnuPygYIMDJ0nph/O/0ue4bR/nOmXcGmIhsS/96p0rX5fE30tPWmz7v
 4AA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Commit ed2a2ef16a6b ("Bluetooth: Add quirk to ignore reserved PHY bits in
LE Extended Adv Report") added a quirk to handle creative use of the
reserved bits in the PHY fields for 4388 controllers in Apple silicon.

I observed the same issue with the BCM4378 Bluetooth controller (14e4:5f69,
rev 05) on an Apple MacBook Pro (13-inch, M2, 2022):

> HCI Event: LE Meta Event (0x3e) plen 51
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x2513
            Props: 0x0013
              Connectable
              Scannable
              Use legacy advertising PDUs
            Data status: Complete
            Reserved (0x2500)
          Legacy PDU Type: Reserved (0x2513)
          Address type: Random (0x01)
          Address: EA:C1:82:F0:24:C6 (Static)
          Primary PHY: Reserved
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -57 dBm (0xc7)
          Periodic advertising interval: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 25

This results in the firmware rejecting connection attempts with
"Unsupported Feature or Parameter Value" (0x11).

Fix the issue by using the same quirk for BCM4378 devices too.

I tested this locally and confirmed that the issue is resolved.

This was observed when attempting to connect a Kinesis Advantage 360
keyboard to the MacBook.

Assisted-by: Claude:claude-fable-5
Fixes: 2e7ed5f5e69b ("Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/bluetooth/hci_bcm4377.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 925d0a635945..66d49b471544 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -2490,6 +2490,7 @@ static const struct bcm4377_hw bcm4377_hw_variants[] = {
 		.has_bar0_core2_window2 = true,
 		.broken_mws_transport_config = true,
 		.broken_le_coded = true,
+		.broken_le_ext_adv_report_phy = true,
 		.send_calibration = bcm4378_send_calibration,
 		.send_ptb = bcm4378_send_ptb,
 	},

---
base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
change-id: 20260818-fix-bcm4378-ext-adv-0737c3cfd66b

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

