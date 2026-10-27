Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085741;
	b=Gs1ZWXsEedYRov+wexbJAhTSd6xbOJK0ZBn7/0bmE01IMuRjMHAhH76RGXGlRp6r8wg2
	 bSDhrAo5KkTfyacHlhfUh4vsAgNwHGi8w6j+enslBp6BVjbEjRBpChxPhKh8XlGQrgknS
	 ux698hguUSLel6725WrHKovm20kBfz0X800qryEAkHzXiUjk4MGQs0Ksmowlg8fz8osek
	 drSGD51f6ECwTOJdN6FCQhdwzaeuEH5ek8gxJtgdm9DiC0BcqDR+ABrgmCpMrgRmwyh/U
	 16hQce34cGvyj7uTJcvz0mGk/kQJBMrixEEPrL05SFyXv/oOhF0QKTEb+3SN+OPY7Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085741;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Q6jWh89o5UKoMZ/0RlsiAH/kxqcIItW3K/PVTfjynJc=;
	b=26TXuHy3+nqKzOjdT3QWAEcTL3pMTLBX/k+8hFyoMFwsAMNf0pM4bA9sTZ0zLqvcsJkb
	 Kd0BdOXiMoewXZCxr4wcKz0UrNTBhJPyselHNSdYtTKovWFGtlYBVsDLKcfkttXpfEEuw
	 KXO+IMGg+UTJTXYVym9nAazPbyKy6L5TP/jbqa9b7OQvGFNFLqZbTDY9Xyrg3cWkymlAM
	 HZOkaocYUTk7lSihXkyvzfX/1lHinxsIocfr2aLU6gHpPlB8b8YCx6e4zgwy6IRPrDEit
	 5lMeDZCUpN0Y8yo+xfKUrqL8L0quaBLeweiySc6+xflcEP2L7MzRLwvH2CyST7wQu9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UsZnPkS/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CCE606A32C;
	Tue, 27 Oct 2026 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsZnPkS/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642D51F031E2;
	Tue, 27 Oct 2026 07:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793085740;
	bh=Q6jWh89o5UKoMZ/0RlsiAH/kxqcIItW3K/PVTfjynJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UsZnPkS/XYYW8OoPMA0AD6SQUHZ/FQJDEVU5lWbMzd4xy0huJvXFmP25PzNci8KxG
	 6FGv6DHfo1T6dDtgFf+hjlomDKsteopWtFT5JSIen8Bs4EMOmDvtBDiNPxoGv3LxWR
	 65oKpAb87KdlBrON6li0dD2pSmu6MU6ecnQ7U6RJOJvnSZv+YN/RMLyFrPBNEaUDE3
	 wNETtvkPyaDt7ci2roFGgf9zE2FtSsCf88n32OXj8c1bRLh0UUw0cLFNQwCEWggoli
	 PDaCAA9XCWo6HAYTVVRjeYnUKF9JMKs/D/PcS9+l84gX1VzTC1BLqnrOScmlBwmZk/
	 hgKz63f7Rtptw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Max Chou <max.chou@realtek.com>,
	tfiga@chromium.org,
	tzungbi@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: btrtl: Return -ENOMEM if bt_skb_alloc() fails
Date: Tue, 27 Oct 2026 07:21:48 +0000
Message-ID: <20261027072148.3963826-3-tzungbi@kernel.org>
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

If bt_skb_alloc() fails in btrtl_initialize(), it jumps to `err_free`
without updating `ret` (which is 0 from earlier calls).  As a result, it
returns ERR_PTR(0) (NULL) to its caller, leading to a NULL pointer
dereference in btrtl_download_firmware().

Set `ret` to `-ENOMEM` before jumping to `err_free`.

Fixes: 9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")
Cc: stable@vger.kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/bluetooth/btrtl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index d2c2e79800fc..35a2c9d3380c 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1143,8 +1143,10 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 
 	if (btrtl_dev->drop_fw) {
 		skb = bt_skb_alloc(sizeof(*cmd), GFP_KERNEL);
-		if (!skb)
+		if (!skb) {
+			ret = -ENOMEM;
 			goto err_free;
+		}
 
 		cmd = skb_put(skb, HCI_COMMAND_HDR_SIZE);
 		cmd->opcode = cpu_to_le16(0xfc66);
-- 
2.56.0.307.g5fe7bd680c-goog

