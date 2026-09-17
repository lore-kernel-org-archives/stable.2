Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749E4B7A4D;
	Thu, 17 Sep 2026 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661545; cv=none; b=X2R1UYcXk/OCo+DFjzpgbSOWiUau95ECmVAWS4isQnkZxIyoJkJIrCVXaRdtp5AOVFKN/xemT6HrKuJdQ5TBGOSqNHsCRgcB3V9cYwpuxeYmrjpoWv0YPysoMAmS433L9pSaJlkhZQhX2mwrqL9jYRxd2/4/I62RkuwpGeprLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661545; c=relaxed/simple;
	bh=flo9osKtc/OpzjojZWTfF9H4r3vbpa+SFX7R4uSEisw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KgykSAuW4aA8Vsn1mUHpb4HnrCbaM0chnot1HKigvIUclu4x431jtjj4fI8JH8Z4sXRjcnGjWVHbALPt63ZPPSJ/hNLGui31tmrezagMNusDMJ+8Sr7BzK09/2yb/2HKSyrdT3sDq3oAyfY+NnXoPx7PCSKGCv3Duk2t3BN8xS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHdkBhEaxqZTmECA--.193S2;
	Fri, 18 Sep 2026 00:12:17 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	oneukum@suse.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: cdc-acm: Fix urb reference leak in acm_resume()
Date: Thu, 17 Sep 2026 16:12:17 +0000
Message-Id: <20260917161217.2161883-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHdkBhEaxqZTmECA--.193S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4DJw4xtFW7ZF1fAF17Awb_yoWfCFX_WF
	yUWrn7JrWj9FyqkF4kJwnxZr97K3WkZws7X3Z8t34S9FW2qF10vr4F9ayDGw1DGF47JF9r
	Kr4Utw1Fvr1kWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUY9a9DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRINA2qr9LZFPwAAss

acm_resume() takes the delayed write urbs from the acm->delayed anchor
with usb_get_from_anchor(), which hands the reference held by the
anchor over to the caller. That reference is never released, so an urb
that was queued while the device was suspended is never freed.

Drop the reference after the urb has been resubmitted.

Fixes: 140cb81ac8c6 ("USB: cdc-acm: fix broken runtime suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/class/cdc-acm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 54059e4fc6ed..399c42b58cfc 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1703,6 +1703,7 @@ static int acm_resume(struct usb_interface *intf)
 				break;
 
 			acm_start_wb(acm, urb->context);
+			usb_free_urb(urb);
 		}
 
 		/*
-- 
2.34.1

