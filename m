Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701730;
	b=EmtocvOujDtJI/5iVx8F5ZCLO9y4BgwsqbGDSLIAL2EK36xhIdWCpHjKUU9m1DvpOdgb
	 zN2lsRUhzRf06C3NBW8kalVz+S8w9WoIgN7xCHUeB9kmwWofGcRbqgmzDC0p+107wUOle
	 a+IgXUrrAQNupsCyKYoPkIYaB/dzaogAx8rkVBiDZC6kTdbfsLAiQSjLWLE6CqLCmnLUS
	 jvkGruUKpvYAQyLdOZvHkA1X3I6IRECDhC0tJXLl7nuFi5HJXnGRzeAtQhqFmZXPFPc+t
	 2BCbbwxu4fwlFasJk5LtVWSbD3s4KzJpNr2zeT5yDnLG2DAd0kgHA6S63cOSgwwsjRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701730;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=B/4a/m4lL4uRC4yyGPUUOdugFBsiVv9dUUI5/YZ8COU=;
	b=F6KRqqwBTo+wLT98PCgBL9zylZWfVxbA89pQhGQLxvOdqJjeJMy+WdlSutZ9BNriOkRK
	 zAPsJlsXtIx+P7wZLfqfceY0yc5tuaZim2JbxcHzf5zcOCEZ7x9/nHh66e1vC3xMfUYFe
	 LOaEYb7xsrWj/hwrnOREDDgsoWmGpFtEN09o6iE+7W1GvT1TgJS1MuvXhsVlClXYyo9FD
	 W3A+Y3xFTGDOZ0KUj8Z8E082EWq2DWSGGYAeyQGdy3g1G9OwoM70axF/7gbgIizGStmm1
	 hCg61DZ/e9KD6vw7uKFoKgZiCj+MiSYH+dkwDG3utbagzNWRAseMfKWevkSnHby8Rog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6D6082BCC;
	Tue,  3 Nov 2026 10:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CC6D6082BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAB3h5hYt+lqY6k7AA--.2791S2;
	Tue, 03 Nov 2026 18:28:40 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] igb: disable the PCI device when resume fails
Date: Tue,  3 Nov 2026 10:28:49 +0000
Message-Id: <20261103102849.1340413-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAB3h5hYt+lqY6k7AA--.2791S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4rAF1xJFWfXFyfJr4DXFb_yoW8Gr15pF
	4UJa40kry8Xr17W3W8Gw1UAas8tayjy3yrGFn5uws5W3s8Aa4kXrWkXryjvFWktrWru3Zr
	tF42yw18Ca1kAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCT
	nIWIevJa73UjIFyTuYvjfU7TmhDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAAA2rpnOFv8gADsv

If igb_init_interrupt_scheme() or __igb_open() fails after
pci_enable_device_mem() succeeded, __igb_resume() returns the error
without calling pci_disable_device(). The PCI enable count stays
elevated and the device remains enabled even though the driver failed
to resume it.

Disable the device on both failure paths.

Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d4a897a8c82c..853bc99a1011 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9621,6 +9621,7 @@ static int __igb_resume(struct device *dev, bool rpm)
 
 	if (igb_init_interrupt_scheme(adapter, true)) {
 		dev_err(&pdev->dev, "Unable to allocate memory for queues\n");
+		pci_disable_device(pdev);
 		return -ENOMEM;
 	}
 
@@ -9647,6 +9648,9 @@ static int __igb_resume(struct device *dev, bool rpm)
 	if (!rpm)
 		rtnl_unlock();
 
+	if (err)
+		pci_disable_device(pdev);
+
 	return err;
 }
 
-- 
2.34.1

