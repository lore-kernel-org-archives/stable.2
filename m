Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271343;
	b=r4iNhpp4M7k09gLSqb7BLcQTca+tlbn/APXrSXynjBSVS0fH7M9F8VQW8bN/qvEWWoQP
	 iUWYSXlLfi8nNlX+uYjtq6mdoEFIxj99i5FHwXMGX5sKM/ZR/PZSPj0y9RetSfQgtX84f
	 CAXyLHNZUavL+oaI9T2RQKZIMQstb05ahGsmIw+gE9CMZMbqckFb+5Vk1Oqkebo2+fOZq
	 yz7gvN6/+7gXG/Cys03wkR/wdWnmEAPjFHp7N/5kKOT3LYZSis9dvhAvNtmCEI7ucSj5c
	 5kXqiEE1eSNk/b8JlBGx+JEYrM+2NbGSrEiuI4woo2Ni0au1cqmlyCoBn+0LY1bqSPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271343;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=nb8/3651PQi+wnO5xWDWcO+y3y5ytYQlH20uezfH+ZU=;
	b=YtwJGBt+16uqRVP36wpc348ldCP5mACoXYNdr+XdZBwRHX58QyTH/TBRAiYO7LwzrDIo
	 18Ka5khg7IAwcwmexCsDbl78oDp/jP/ZcVEVWsT7kaEe6Wxpuz56cI7/QA8/x5tZAjNih
	 d8jXtYv6TBznSIiuLe1Bka2iHY9cl3EHbnQS/MnPOHs3Wdfjvw9rqBGm02aCrfFumFDFX
	 Lp6rk4HjfNk49kGhJS4AsGIjsfqJx0ryUvoneeXh+xzFdG8db0YL+rFxU7GpFn+FMvBeT
	 E4wNibs/WuGZIpxpnNj3AicWMJH2Rz+J+h8ELa2TCEmXVysYbqmETQaaBA9ABjDdWWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=g46Ipwb0;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8835606A31C;
	Tue, 10 Nov 2026 00:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8835606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=g46Ipwb0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794271341;
	bh=jelWMB/DBj38lxtsoeFn4zfXVqb37rYafHvCTADg8do=;
	h=From:Date:Subject:To:Cc:From;
	b=g46Ipwb0jR4wdsoxeI1/IuKY3ruRNQ6s2IslOn/OrWU8KUUBc9z3xcC/umjL4slnX
	 nbh4NDNiOTFTpcSVeChDAzlqmXMKyRaVyUyv05jhhjkACerJ9mr5GFv+agnob7n1WZ
	 uvIrb2oXUNtIe8odRRyap1Mdb9lQFd5HhhasoDv/CkbWubfYko5BxIr7H4WBh9Nq0T
	 WGhWaAX9dPWlKqEK0LZdEzDIcbhLkDW6uJvNwjl3S+ss2FHwcfvZx5zGF6dC1FGe12
	 d/iX24t3xZSaLA1gHv0zWYQa+heMuwOctMGJ1m9Cb3MElupRd7dF/gON9gIYSUwJNj
	 r3tp3BYq3Pq0A==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F01B117E04E5;
	Tue, 10 Nov 2026 01:42:20 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id B1B6148002C; Tue, 10 Nov 2026 01:42:20 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 10 Nov 2026 01:41:58 +0100
Subject: [PATCH] spi: Fix runtime PM imbalance on pump transfer message
 error
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
Message-Id: <20261110-spi-runtime-pm-fix-v1-1-8601ebb2f6a8@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrDtgRlLUq4iLGqc6gjFkYimId
 ze2y+/B+w9QjsIKbXFA5I+obD7DPApw88tPjDJmA5X0NMaUqEEw7j7JyhhWfMsXLTUVWUfW1gT
 5GCLn+Rft+r91HxZ26S7BeV7IM5zedgAAAA==
X-Change-ID: 20261110-spi-runtime-pm-fix-529325c25582
To: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Mark Hasemeyer <markhas@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 kernel@collabora.com, Alexander Shiyan <eagle.alexander923@gmail.com>, 
 stable@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=jelWMB/DBj38lxtsoeFn4zfXVqb37rYafHvCTADg8do=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGryaGhpQIC8Xs2xQCf2WNxWILLEANG2wd/+H
 r6D1fb9Mj2nmokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq8mhoAAoJENju1/PI
 O/qaX14P/3c6UYpoe1cZY32PTKyEzxN4atoVcyQYaq99xgbTUKYYpP6JTNLg54d4ld2haBuxRfj
 o+qDsMYJ4gUWyQ4V2H0pIFq0GX3TEjZS+VRKGSJUGbwoazuuBJylvkTVmTlo3wH1zO7hdBaNF3A
 yW6lHSpKLN9YXXSwao9+pPoy3DjScR7AwviIdzeuv6If/Bts61DbiRe3/YiMgoGvsacqpcWzSKg
 bfhjyaTG7+k722HYMemRegBTfEGK6oWuh+zuG5T2/fkjle51SkVrtuNh2LNWPe/QUwSCOYYQ+IS
 ui05x0irNBtOKAeQ/UD2UWooaaRGGK3PHx5xATJLJkziEerOUk+FUfkcl3F7tKgdvfP2bFOmK5Q
 fY91hRBL+Fb0LGTPl0an8D6UZdUoXoPQk2Gi9Rl3AqoFWo3bLn6xipYTxcD9JlE0lGLcJ+Ugzoi
 2mPEONJaj0pj7hYabsTHnSmkpx0jatPj5xeucNaz0XTHwAwyP8+6ksNQLGzA8YviYa3YmZ6l3i5
 cwRuPvsOSng6VlFwIz1qvuzzYoJa5n9NTiwHkbeXPXCGV5byHZ4h87IB50VwFvYRFhZP7TzBAZ6
 KHauBdXSwOLBV6AhY/0uruImRt59Wt5nPvD34CnH+w/Y6314OpxcCu+iIRyCdYXdI0LVO3saqXc
 28Lkv86asTjXrLg60mQguCA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The current SPI message pumping code may drop the runtime PM twice when
an SPI message cannot be sent:

spi_master spi2: noqueue transfer failed
rockchip-spi feb20000.spi: Runtime PM usage count underflow!

Fix the problem by always keeping the runtime PM count increased when
exiting __spi_pump_transfer_message(), as the caller handles decreasing
it.

Note, that the function already keeps the RPM usage counter increased
for the error paths following after the prepare_transfer_hardware step.

Cc: stable@vger.kernel.org
Fixes: bef4a48f4ef7 ("spi: Fix null dereference on suspend")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
I noticed this with RK3588 system suspend/resume, which uses SPI based
PMIC and runs into SPI transmission problems when the PM domain driver
tries to disable regulators required by e.g. NPU or GPU domain. I've not
yet checked too closely, but suspect Heiko's atomic SPI transmission
support series might also help with fixing the actual failure.

My patch is not really a v2, but Alexander Shiyan probably ran into the
same issue before and came up with a way different patch and rationale:

https://lore.kernel.org/linux-rockchip/20260806191854.922530-1-eagle.alexander923@gmail.com/
---
 drivers/spi/spi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ce257b3ec530..4d9c5d026ff6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1967,7 +1967,6 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 	if (!was_busy && ctlr->auto_runtime_pm) {
 		ret = pm_runtime_get_sync(ctlr->dev.parent);
 		if (ret < 0) {
-			pm_runtime_put_noidle(ctlr->dev.parent);
 			dev_err(&ctlr->dev, "Failed to power device: %d\n",
 				ret);
 
@@ -1988,9 +1987,6 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 				"failed to prepare transfer hardware: %d\n",
 				ret);
 
-			if (ctlr->auto_runtime_pm)
-				pm_runtime_put(ctlr->dev.parent);
-
 			msg->status = ret;
 			spi_finalize_current_message(ctlr);
 

---
base-commit: 059518f775baecc9803fc97787bd0b17558f8047
change-id: 20261110-spi-runtime-pm-fix-529325c25582

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

