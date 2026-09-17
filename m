Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90A4B7A30;
	Thu, 17 Sep 2026 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661285; cv=none; b=hs0Oh7NcCUNoWX5gO6CxaFhTaNdpoBrSvkk8E1dFBN6jC2+16x4gjvLeKq7LWAFhBuWNAqdY/9xZMOKMXxnWJVlUDYw6/Fe72nZqRxe7Fh5eVYaDSemUfXM3JurKK5+KgvUAo3/YAXJWb9M9xdaR46wcigAlA/R0j3bbc4/OB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661285; c=relaxed/simple;
	bh=kyLNYI+hqqLQRI9p6z2axNlHWPE91dvDEuCJRQLgbPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JcWIPWmX+zdwTzQPN1OQYNjGEBYc02AEB2JwewKkjXWrblzI8hKicoetKYVKZ46LeuLjlrQ1XwyCAGxnoMbpBnB8LnD3/4Dfh2Nzl86AAoDOKr2pQegEVDSHDCo3OFhZcbEv9WEM2QdvIqG3WKR+TVDnyxfZDHXUT8SsOWBuUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB34jxeEKxqdCiECA--.6483S2;
	Fri, 18 Sep 2026 00:07:58 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pawell@cadence.com,
	peter.chen@nxp.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: cdnsp: Fix runtime PM reference leak in __cdnsp_gadget_init()
Date: Thu, 17 Sep 2026 16:07:58 +0000
Message-Id: <20260917160758.2161710-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB34jxeEKxqdCiECA--.6483S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry3Gr1kKr1DKw18Cw1xKrg_yoWDArc_Wr
	45uF17AFyjga4DCw1kGw43urWj9FyDXw4kWan7t3y3CayUKr18Zry3Xrs5Cr1xZ3y7GryD
	t3W8KFsIkFnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUY9a9DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgNA2qr9tg9FQAAsG

__cdnsp_gadget_init() takes a runtime PM reference with
pm_runtime_get_sync(), which is only released by cdnsp_gadget_exit().
If the initialization fails after the get, the role is never marked
active, so cdns_role_stop() does not call the ->stop callback and the
reference is leaked.

Drop the reference on the error path as well.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 6b3815f8a6e5..53c395631955 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1990,6 +1990,7 @@ static int __cdnsp_gadget_init(struct cdns *cdns)
 	kfree(pdev->setup_buf);
 free_pdev:
 	kfree(pdev);
+	pm_runtime_put_autosuspend(cdns->dev);
 
 	return ret;
 }
-- 
2.34.1

