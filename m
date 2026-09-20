Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88833E40E4;
	Sun, 20 Sep 2026 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890308; cv=none; b=qxc6QdE0GjeYcIz6Oxykpuhu3chqWr++eFK5o2zfieP66mJSrMvVA1bumZkeDqmh59mWvZddATJ+hV1GqV2OHv9OJWix5CMREA72TbF9Rc26LN2De2Gyd1mpt1xkO3T941M36ON/P8OK45rKOs/OyoBXQ3JQOl/0fOeTVe0wChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890308; c=relaxed/simple;
	bh=10fE2iWtbvNRkibWkIM5wVpvO5z6pmhPHedJTmBlDIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K9d4VgpF3AJLHZxmE6kQim8wGkl2079y/Zg7ysMR5nV4GFzwexMBT0xnMQkU9zvaVLiG/CAwRTFl3w7MhD7czYdHC5t05w3M6HETZxBdZq1Lb/dNw6cFCWxCrraXWPtXYqMBTR/fQdse0YV9RSSNWowqSVzHr1v751yGxYYyYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.180.135.190])
	by gateway (Coremail) with SMTP id _____8BxbdL_jq9q6t4NAA--.41250S3;
	Sun, 20 Sep 2026 15:45:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.135.190])
	by front1 (Coremail) with SMTP id qMiowJCxPs_9jq9qUOwiAA--.8682S2;
	Sun, 20 Sep 2026 15:45:02 +0800 (CST)
From: Ming Wang <wangming01@loongson.cn>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	Ming Wang <wangming01@loongson.cn>,
	Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP whitelist
Date: Sun, 20 Sep 2026 15:44:59 +0800
Message-ID: <20260920074500.826121-1-wangming01@loongson.cn>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPs_9jq9qUOwiAA--.8682S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAQEQEmqvPvQFYgABsr
X-Coremail-Antispam: 1Uk129KBj93XoW7WF17ZFyrtw1kKw45XF17XFc_yoW8WFW3pF
	4rCFyYv39xJFW5Kw1rAw48WFyrZwn3Cay5KFWI93WY93Z0ya4aqFyxGFy5K34kGF45AF12
	yF93t34xWa1DAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8N_-P
	UUUUU==

The MeiG Smart SRM821 5G module (0x2dee:0x4d53) crashes and drops off
the USB bus when it receives a Zero Length Packet (ZLP) after sending
or receiving an NTB of exactly 16384 bytes (tx_max).

According to the MBIM specification, devices do not require a ZLP
if the NTB size is exactly dwNtbOutMaxSize. However, the cdc_mbim
driver defaults to sending ZLPs for devices not explicitly whitelisted
to accommodate non-conformant hardware. This default behavior breaks
the strictly conformant MeiG SRM821 module.

Add this device to the ZLP conformance whitelist (cdc_mbim_info) so
the driver will pad the NTB to avoid sending ZLPs, preventing the
device firmware from crashing.

Cc: stable@vger.kernel.org
Signed-off-by: Ming Wang <wangming01@loongson.cn>
---
v2: moved MeiG entry below Ericsson for better grouping; added Cc stable
 drivers/net/usb/cdc_mbim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index 877fb0ed7d3d..a7010a0664c7 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -635,6 +635,11 @@ static const struct usb_device_id mbim_devs[] = {
 	  .driver_info = (unsigned long)&cdc_mbim_info,
 	},
 
+	/* MeiG Smart SRM821 ZLP conformance */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d53, USB_CLASS_COMM, USB_CDC_SUBCLASS_MBIM, USB_CDC_PROTO_NONE),
+	  .driver_info = (unsigned long)&cdc_mbim_info,
+	},
+
 	/* Some Huawei devices, ME906s-158 (12d1:15c1) and E3372
 	 * (12d1:157d), are known to fail unless the NDP is placed
 	 * after the IP packets.  Applying the quirk to all Huawei
-- 
2.43.7

