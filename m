Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701735;
	b=tNJqvvWPX4d10fA3ExryDZamyh9cuNzi+04gE0CUwqXOsQAFFzUBGS0m7GwpUV5gia8G
	 0Hly1x6CFq6002PTe5KoAAI36liVH3L+LiQ7igC/vH8haFhZDzfmW9SwRd7antC2sGnI4
	 2ErdsJ8t3zWiyVId1+eY0vhGTCC4hGOXUYpZaQlZi5Tj3E4kPOpbYQl8g/aOSf6H9wki9
	 DqPub67ll/IsJAK3VHZUlc7F1/22gvLZu+lCmf46Gtu/Z3fsm6/kDJG9XlbEvsdPOi47M
	 6iDhC2bT+cQU87S5L97WQQazffDI8/LZMOdl99IYxviRp1LSOV1YPlJzoi2f4l/ocUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701735;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=vUYWuknMoTvBQ40MdG++4tyoJ/vmzglwDcYMirUPN0Y=;
	b=OrwJrUnx0LbjB7u7ba8ub1WP+nAtmxYUY0qCMARgFKfwgBr3q4O82MWwLN7cyGuaZYB3
	 JksyIUroHDYwWpHzOJyYYxQArnkcpzrQKhQMAv84GmJu3JPA98Rh7jNg9EATWVmokXNf0
	 FN+EPojGCpDSeIpiMn4j1LItyxfL4uGsd2BDcGP7DZ9sUf0OHYKsVsI1HKAa0xkDOyLpN
	 upq0pElCTVZ0jAsVkm8R9D0zVnOmtYU9gPUj1ylpVYZ5BsoFGKiMZJmHSG3+9EdjT48ty
	 KmA093bVWskcm68nz0GSFS0F/GrUJ6mlFH1t5+loaJpZm+JRg8vhZhaAYZb6TYxCs/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D260A6F43;
	Tue,  3 Nov 2026 10:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B0D260A6F43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADH15hkt+lq1qk7AA--.5564S2;
	Tue, 03 Nov 2026 18:28:52 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: 
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath6kl: free the ath6kl core on USB disconnect
Date: Tue,  3 Nov 2026 10:29:01 +0000
Message-Id: <20261103102901.1340914-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowADH15hkt+lq1qk7AA--.5564S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4fCw1kWF15JFy3tFykuFg_yoW8GFWxpr
	4fXryvgryftryqqw47X3WkCFy0yan3Aa4Skr48Zw1fXrn8Jw1Sk3WYvFyrtF4DJrWrGF12
	qa4ay348Jr9Y9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwC2zVAIFx02awCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAI
	cVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7sRiGQ6DUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIAA2rpnOFxFQAAsX

ath6kl_usb_probe() creates the core with ath6kl_core_create(), which
allocates the wiphy and the per-station aggregation state in
ath6kl_cfg80211_create(). These are released by ath6kl_core_destroy()
only. ath6kl_usb_device_detached() calls ath6kl_core_cleanup() and then
frees the HIF private data with ath6kl_usb_destroy(), so the allocation
made at probe time is never released when the USB device is detached.

The SDIO counterpart, ath6kl_sdio_remove(), already calls
ath6kl_core_destroy() right after ath6kl_core_cleanup(). Do the same in
the USB detach path.

Fixes: 241b128b6b69 ("ath6kl: add back beginnings of USB support")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/ath/ath6kl/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 945984c3dbe6..217397dd545f 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -690,6 +690,7 @@ static void ath6kl_usb_device_detached(struct usb_interface *interface)
 	/* Delay to wait for the target to reboot */
 	mdelay(20);
 	ath6kl_core_cleanup(ar_usb->ar);
+	ath6kl_core_destroy(ar_usb->ar);
 	ath6kl_usb_destroy(ar_usb);
 }
 
-- 
2.34.1

