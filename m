Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87262198A17;
	Wed, 16 Sep 2026 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577359; cv=none; b=HmMsvS3/jrQ44NRLIpbi+cB0Hdpa1vi0X+yFGf9oT7Hnq/F16Six3UbQ20VOQo9+ye1gOXwTlPFSNaDbHzaYGNbdo7/o1t9X2sh8j5pqIhQL+nNFXzUi2HuXgqckMQSCk7QX6P3L8DUn6IibOIAk/eES1foCRwZAyaqixxk/Kew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577359; c=relaxed/simple;
	bh=0lHBnqzdcm0BomzMP7yXd8d+InPJAW6K6XFMa8TNtMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UghQ+Z+Jlv9+BGfe91UqouM0fJj28frXuFQyEN+eef4tJ5JI4aUe7Vb+SXpeffSJk+JT6BZLba0OSiIAnzf4ksuoR2OlKGo8euz9gIyKxlrGKcERVnZQxEYgTjkXeTMw1JMTHXwY9mx7mKQR/PyKTqwnWj9uB+412uaYSv90dC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3oDqDyKpqnfJtCA--.22040S2;
	Thu, 17 Sep 2026 00:49:07 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mathias.nyman@intel.com,
	sarah.a.sharp@linux.intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: host: Fix companion leak in usb_enable_intel_xhci_ports()
Date: Wed, 16 Sep 2026 16:48:40 +0000
Message-Id: <20260916164840.2085101-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3oDqDyKpqnfJtCA--.22040S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1fZryxJr4kKF4UJF17GFg_yoW8Gryrpr
	sruF1qyryrWr4Ikw4UGw4fZFyFyr4xG34Ykay2k34ku390vay3Xr9FqF1Yvry7JFZ7u3yY
	qa1DtF1xW34DGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj
	d-PUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQMA2qqpVhSRAAAsn

usb_enable_intel_xhci_ports() iterates over the PCI devices with
for_each_pci_dev() to check whether an Intel EHCI companion exists and
breaks out of the loop as soon as one is found. for_each_pci_dev()
takes a reference on the device returned by pci_get_device(), and
breaking out of the loop leaves that reference held. The companion
pointer is only used to set the ehci_found flag and the reference is
never dropped, leaking a reference to the EHCI companion device on
every port switch operation.

Drop the reference with pci_dev_put() once the lookup is done. When no
companion is found the loop leaves companion set to NULL, for which
pci_dev_put() is a no-op.

Fixes: 26b76798e050 ("Intel xhci: refactor EHCI/xHCI port switching")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/host/pci-quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 0404489c2f6a..bde5bc248d45 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1076,6 +1076,8 @@ void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev)
 			break;
 		}
 	}
+	/* for_each_pci_dev() takes a reference on the found companion */
+	pci_dev_put(companion);
 
 	if (!ehci_found)
 		return;
-- 
2.34.1

