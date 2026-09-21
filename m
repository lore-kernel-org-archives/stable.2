Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834D25208BF;
	Mon, 21 Sep 2026 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029582; cv=none; b=kxtwcTanvPNatY8q9lyXG32DMFrZ77U8E32ojWVtPSzAxuh4x9ijbKfItEMHVCLVCuwul2vC2QdDuG/4dwVL+ZrbzdM9P5FK4NSJoRpMmFo1DRJB82wImq3jDLYS5va24KJgdHyv5VpTo1xc4DO0BUkg7jk5XoB4dyw8xy6Jd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029582; c=relaxed/simple;
	bh=GcMnaXTTftwt41AhpHqvdPr9YoCU8O93u2dGIJB9RiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8asYYU9CBFhW+S3nGFc0bvc094oincv1aMHtMMyVrIy9K48lZJ99euRlKusMnHlt24quir7ZdAWXxTsu58RI4CBMsFl/07vJW0PdYqfx/ns9Pzeg2kuqOLN+A/kBOq3z/pV5oCjg8wzttfPmApGkROagcGtpmLkiozl6hgTYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyiO0Y1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyiO0Y1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CF41F000FF;
	Mon, 21 Sep 2026 22:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790029580;
	bh=zph6y9NJaryVoOTe29OOcRQJCkR//nh1huNAKE/qpIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TyiO0Y1vax0l9de7yRPOteF5/NXDyQdNq96LIBmd47S+3RyQL7Pi5vnCDWRLSnzAi
	 6WEZBjivu61z/CqReB3gSS312o7nsUMFOnyPO3q3mAerGflaLS81JKU9chV7ZgSd8r
	 C+6EwpLjGwXEGS0Bg/yWBsGRIlX3sCIpJTctYdFEwET3qagZo5H6mMrQQbKgsQbE5c
	 5kh0VNMbA+h0qjrOIIrlepqKM/zGHBso4qv6OkURON69drUPkj1jlT+3Y9+qhLIDJw
	 L+/RumqLa2mdQB9eYbzGl64mHcUEJOZq7jUrS0egCYsMCbwePMZKG93KFnnhbLi8AP
	 5AIdKeQ3eMriQ==
From: Michael Grzeschik <mgr@kernel.org>
Date: Tue, 22 Sep 2026 00:25:55 +0200
Subject: [PATCH 2/7] net/9p/usbg: set client to Disconnected on
 usb9pfs_disable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-usb9pfsfixes-v1-2-9d8dcc52904c@kernel.org>
References: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
In-Reply-To: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <mgr@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=976; i=mgr@kernel.org;
 h=from:subject:message-id; bh=GcMnaXTTftwt41AhpHqvdPr9YoCU8O93u2dGIJB9RiU=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBqsa8E6bj/poLkRwIWHFxsjxAMfXWsvKvN9iPxZ
 yqXSNr0Z8aJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCarGvBAAKCRC/aVhE+XH0
 q+p3D/9W5fDy0OUhj+QzJL/xq8Fz1ehzvCHrSc55sxunj6yI1ING65LLmFQCuDmbK88LAbEzy7x
 h+UyQyulJw3S3BOqz1G5oIHw3sxHEg5mivYTtv7zGs0lzfLQb7tHyXW0U23ie05EL8D2qZbOrGj
 0w22AN3qUEmsfhPJIJUoUWhlJDpeYCEDYKVmTO0dvRAym5lD56bEn7Bz9RRAJ2z+jmS5SS7BXXY
 6JFPiF+s7v/F3nCHFeLP48Ud5dML7STLUqWE5b+b+JuCCwFyGEKvFmrfVAm5qAZ+QIV7//VRcMS
 2vTS5XbIoASBULI0SKZicUJn0mVy8W5Nv9vUy2fVJyamC8PkMokEPHOVKbnpHZ9jrjKE6Kdsrge
 somNmvlFe8KyIL2uXVru2DVBbh/sbUd2lBdOMkZDpY4d1rXDviasHHHsqtgRiBHGE22BUGUFQ8U
 YTCzaHvXDL/viHfBfCIxnTcz3uQYlJiYYdQEZALELs5VcN2QbS4OXqppVvXXERLMTkepYoOWfXY
 eyXVgXaFCkGKViHrJ9faUkX39pmnhdsmOX6h/Pss5lxLRmbeY+OKsYRtnNMIf56Iy1yI7GRUhec
 C7JBfEKTfy3B686QYBZM3cQmF98kraxMsrmheP8flZxmXrtP78MCZ5SdbbZAy9v8eWejwOhobvw
 1hk9LSdCZRHy2MQ==
X-Developer-Key: i=mgr@kernel.org; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64

This patch is setting the client status to Disconnected, when the
client is still in use. Otherwiese a disconnected usb cable would run
any use of the mount to faults.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Grzeschik <mgr@kernel.org>
---
 net/9p/trans_usbg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 32e18077309a..a3182d3db175 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -757,7 +757,12 @@ static int usb9pfs_set_alt(struct usb_function *f,
 static void usb9pfs_disable(struct usb_function *f)
 {
 	struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
+	unsigned long flags;
 
+	spin_lock_irqsave(&usb9pfs->lock, flags);
+	if (usb9pfs->client)
+		usb9pfs->client->status = Disconnected;
+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 	usb9pfs_clear_tx(usb9pfs);
 }
 

-- 
2.53.0

