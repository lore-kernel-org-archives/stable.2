Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62324DAFB8;
	Thu, 17 Sep 2026 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645723; cv=none; b=iHGJITV9YPLADg/6eftsRWxZ3FsUQWUMjZZfBrt9ihh5WigyLKsv9EbLq27S6sdK0aLXRka6YKVaOhuXftGZ00ujYdHqc/FnU7ekosDxTv/tjSUo1I0v7T2W/Hvyhg/ZTFgnaJykq9OM/ovvye1w1xW30cKsWZxfmXUBSNR1q30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645723; c=relaxed/simple;
	bh=ITg4GgxqkN+/I92LhrsqbUthy8oVwbzjlBSGtmJtJ78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zwl5v3/zbVDQ7852ZpCtDMIL3qlFEsloebUL5HAwjypXybH1jP0mbbyiUl08VskyHSMpBiSLl17JzkNSXFN3wN/k8T57MhduhhbeKe4GPjaqqa9ikPXCWpvByljl/fO66hw0XMToSOUscjwFfypvo25VoIcU7bMD/Q638xbD8to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABn0TuF06tqIeF_CA--.2029S2;
	Thu, 17 Sep 2026 19:48:21 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alex.aring@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	marcel@holtmann.org,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stefan@datenfreihafen.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ieee802154: atusb: Fix URB reference leak in atusb_work_urbs()
Date: Thu, 17 Sep 2026 11:48:21 +0000
Message-Id: <20260917114821.2149704-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn0TuF06tqIeF_CA--.2029S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyfKFWDGrW5Zw13Xw17trb_yoW8Gw18pa
	y5u3Wagrs8Xa1Iyan7Jw1IvFyFyw4jk34xCFyru397Zrs5tw17Ka4xGanavF48JrW8ZFya
	vr12qr47Gwn8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU8czVUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQNA2qrrJp39gAAsw

usb_get_from_anchor() hands over a reference to the URB, which the caller
has to release. atusb_work_urbs() never does, so every URB collected from
the idle anchor keeps an extra reference: the reference count grows on
each retry cycle and the URBs are never freed on disconnect. Drop the
reference after a successful submission, and after the URB has been put
back on the idle anchor when submission failed, as the HCD holds its own
reference while the URB is in flight.

Fixes: 7490b008d123 ("ieee802154: add support for atusb transceiver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ieee802154/atusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 5f7fc4ee7a07..3dbb142eccb2 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -180,9 +180,15 @@ static void atusb_work_urbs(struct work_struct *work)
 		if (!urb)
 			return;
 		ret = atusb_submit_rx_urb(atusb, urb);
+		if (!ret)
+			usb_put_urb(urb);
 	} while (!ret);
 
+	/* The reference obtained above is dropped once the URB is back
+	 * on the idle anchor.
+	 */
 	usb_anchor_urb(urb, &atusb->idle_urbs);
+	usb_put_urb(urb);
 	dev_warn_ratelimited(&usb_dev->dev,
 			     "atusb_in: can't allocate/submit URB (%d)\n", ret);
 	schedule_delayed_work(&atusb->work,
-- 
2.34.1

