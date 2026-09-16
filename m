Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3984D9543;
	Wed, 16 Sep 2026 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578146; cv=none; b=u4mvmetRjTfXTsR9hs8EDchA3LdkXV6ALGDFG7oivKxt8gwh6FagefoRd9eQ7p58uvLceBEevUpywIpDwmPdmzRnRvSJ6E1gDh0I5Y+MqnyJ5t6BNLOTRqd7UQ3B7SCl/2B6Ym4UV6sV+7hdaYnVyJGh/Ii2Tx1mqrq1p5tdQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578146; c=relaxed/simple;
	bh=tVbmSbG2BpVyTa01308fCRWrpHLoeMs9KdUCGAYVxao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tOw/oGsM79qyQ6lBJ/gqmOR6T1YSM77ePJiYV88uytnAjQc91Vu/Xx73gGA0kUO+HgYh7Gs/G+zib0vJnQz8LvJo6uLaQXUNNLVoU/9e6DlkQtyMeAtx2uLLa22irQW/kRWqdDojL3ewv/2KLTWZ/hNS/+TldW5+3TT2RISDQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnUDuOy6pqzSluCA--.22313S2;
	Thu, 17 Sep 2026 01:02:07 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: heikki.krogerus@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: Fix PD object leak in select_usb_power_delivery_store()
Date: Wed, 16 Sep 2026 17:01:39 +0000
Message-Id: <20260916170139.2085947-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnUDuOy6pqzSluCA--.22313S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4xXF1xGw48AFWxJrWrZrb_yoWkWrg_u3
	W8W3Z7Xr4UCFW0kF1UJa9xAryxKanFvF40gFsFqws3GFWYv3WUXry293s8ZryUWF4xuFyD
	GF1UJryrZr18ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU08
	9NUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMMA2qqok9gFwABsR

select_usb_power_delivery_store() looks up the requested USB Power
Delivery object with usb_power_delivery_find(), which returns the
object with a reference taken by class_find_device_by_name(). The
reference is never dropped, neither when port->ops->pd_set() fails nor
when it succeeds, leaking a reference to the USB PD object on every
sysfs store.

Drop the reference with put_device() once the pd_set() callback has
returned and the object is no longer needed.

Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/typec/class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 0977581ad1b6..0595e8cb83aa 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1619,6 +1619,7 @@ static ssize_t select_usb_power_delivery_store(struct device *dev,
 		return -EINVAL;
 
 	ret = port->ops->pd_set(port, pd);
+	put_device(&pd->dev);
 	if (ret)
 		return ret;
 
-- 
2.34.1

