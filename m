Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0A4CDDEB;
	Thu, 17 Sep 2026 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661674; cv=none; b=W9c3hmm8mDrs0kRquKtXnFIZ46eB2Sy0eZxpu1yhQ4hS5EHLnLLWzPjDA42HkrpOmRid/l+E+IJfMb3gwFhYBA96LTpXxxwDHlmDNy2AqSlTaCw10MptbO/mG61bt6py+b+YXai4p1yNJYhI/CCnjECtoaSdT/yfKayCLcusZJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661674; c=relaxed/simple;
	bh=e32bC870PeFPcpa8fqr9r1QD/PlRzxG+ael3+PgOwNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SYf2ARnapvinQri3Fy7DTugOLVufXaxGgAFKKepvHOCkVExjtPat07Kh0lCW0l3YQ3FFDuASU7onEI+fFN8GhsXK4Zm0D4scHjZGtGsCbam1UY2cpCNKDgEggcxh7YVOdBN/byGtjxwltRBpqJ7PRRnRlEqk6pxIdIYxsI4RDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABnl0HlEaxq70KECA--.6559S2;
	Fri, 18 Sep 2026 00:14:29 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mgr@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: uvc: Fix config_item reference leak in uvc_alloc()
Date: Thu, 17 Sep 2026 16:14:29 +0000
Message-Id: <20260917161429.2161970-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnl0HlEaxq70KECA--.6559S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW7Ww17Aw4rtFW5Wr1kuFg_yoWDCwcEkr
	1UWrZ3Gryjk34qyr40y39xuFW7KFs8Zr48WF1IgrZ8Ka4Fvw17urykurZ5AF17Zr1xCF98
	AFWrJrZ3Wan7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUnGQDUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQNA2qr9thAygAAso

uvc_alloc() gets a reference on the streaming header item with
config_group_find_item(). If the header is not linked to a streaming
interface the function returns -EBUSY after freeing uvc, so
uvc_free() never runs and the reference is leaked. Drop it before
returning.

Fixes: 3180d827c807 ("usb: gadget: uvc: don't put item still in use")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/gadget/function/f_uvc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 8d404d88391c..eb5837b17e6b 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -1126,6 +1126,7 @@ static struct usb_function *uvc_alloc(struct usb_function_instance *fi)
 
 		uvc->header = to_uvcg_streaming_header(h);
 		if (!uvc->header->linked) {
+			config_item_put(h);
 			mutex_unlock(&opts->lock);
 			kfree(uvc);
 			return ERR_PTR(-EBUSY);
-- 
2.34.1

