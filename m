Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89544AA59B;
	Wed, 16 Sep 2026 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552003; cv=none; b=mAhb3ueqdqnPqo7solT1rEOCUtHtxZxDKw+KmlMdyUodegy8gkQ5KQaS1LXtzcy0lClUT7/uSvFwWEuatSrc2THMD8k4IXf7rmizW3Mu210Imz6BoNwBdem372uzYFtb2aC86vkrEk63mIa2SpiapXbRqX0nwrbFHY2jujDRoX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552003; c=relaxed/simple;
	bh=/SI7GVxt4mC87rMVsfTK7mjas/Rgm1glug6oiBjzips=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HxDn3JCM6fE013a+ljCN6YnxOpJQ7P6QDLRXIdYSv+/NIyCWqPnfYgbz0EWxF2bG4yHWLYhp+D/RhmoC+ggm4UTovCI2C5g6MagoVF8vQFGHpCvuotcqHU58a1RqxdTb7SSzBJ0Ee+3UT0WPYEVOhimFligxFDC5N1wULsSV4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABHUT9yZapq8Z7gBw--.14690S2;
	Wed, 16 Sep 2026 17:46:26 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] gpib: tnt4882: Fix device reference leak in mite_init()
Date: Wed, 16 Sep 2026 09:45:58 +0000
Message-Id: <20260916094558.2007240-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHUT9yZapq8Z7gBw--.14690S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKryrWw1DGrW3Kw43Cw4UJwb_yoWDtFX_K3
	40vryxXw1UuF4kKr1ayw47Zry29F4xZr95XFs7t3Z3Ga4Yvw1rXF9I9rn8twsF9347Xr1U
	J3srArW3Xr1IyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUeN
	txDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMMA2qqP4edSQAAs5

In mite_init(), each pci_get_device() iteration returns a new
reference to a National Instruments PCI device, which is consumed by
the next iteration.  If kzalloc_obj() fails, the function returns
without consuming or putting that reference, leaking it.

Put the device reference before returning when the allocation fails.

Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpib/tnt4882/mite.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpib/tnt4882/mite.c b/drivers/gpib/tnt4882/mite.c
index c75c45cdf03f..3e411653ffc7 100644
--- a/drivers/gpib/tnt4882/mite.c
+++ b/drivers/gpib/tnt4882/mite.c
@@ -58,8 +58,10 @@ void mite_init(void)
 		pcidev;
 		pcidev = pci_get_device(PCI_VENDOR_ID_NATINST, PCI_ANY_ID, pcidev)) {
 		mite = kzalloc_obj(*mite);
-		if (!mite)
+		if (!mite) {
+			pci_dev_put(pcidev);
 			return;
+		}
 
 		mite->pcidev = pcidev;
 		pci_dev_get(mite->pcidev);
-- 
2.34.1

