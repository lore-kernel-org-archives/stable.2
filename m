Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81984DD3C6;
	Wed, 16 Sep 2026 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577834; cv=none; b=GJ+SdsNWB3+mmH6sFKQDwgSLYAbw7CIfGSH3IAOdW1LP4kB+9oUMCjgoymjiBwX8tEXiFL4Cm7PZWat2gOEMb1qvLvCOVWMijpzDfUACNFalix6Bibvq1iuwumb0BCxcMmVCxbKGnAElcJWO4wSb/GVxk2djwKgSg8ruo9xOJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577834; c=relaxed/simple;
	bh=Q0vKnsBhU5N70+ASDlEYTgbNg+QlDDAhAMOMiJCKFR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EesBS2mJMbxxylLjqTX7ac2vFrJivlqYUqm34xCDG44GspTHLuJVkBOYnn4N+sMYaZGsR8u5x0PH5+SiGrLrIxAmB8+jX5rc+0KrJyCz5NwQiQYgD9RLr3W4R/MR7TnRMgKUDqgrlQ1eWDg0prgDySNDprF7zDIs3zOVxe9LusQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABnmEJDyqpqpxFuCA--.22468S2;
	Thu, 17 Sep 2026 00:56:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] USB: usb_wwan: Fix urb leak in usb_wwan_close()
Date: Wed, 16 Sep 2026 16:56:08 +0000
Message-Id: <20260916165608.2085613-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnmEJDyqpqpxFuCA--.22468S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JryDZFWkAry7ZryDXw4UCFg_yoWkKFb_Kr
	n5WFnrXw4UCFs5KF13KFy3uFy3Ka1kXan7JFsagr43JFyjyFWqq3s3K393Gwnrt3yUWFn8
	Jw1vk3yFvF1kGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj
	nmRUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMMA2qqozVdRwAAsZ

usb_wwan_close() drains the delayed write urbs with
usb_get_from_anchor(), which returns the urb with a new reference
taken. The loop only clears the busy flag of the urb and never drops
that reference, so each drained urb keeps one reference forever and
the urb object is not freed when usb_wwan_port_remove() later drops
the port's own reference.

Drop the reference with usb_put_urb() once the urb has been found in
the out_urb array by unbusy_queued_urb(), leaving the reference held
by the port's preallocated out_urbs array.

Fixes: 79eed03e77d4 ("USB: usb_wwan: fix urb leak at shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/serial/usb_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index e752ffa4dc62..2c46330f10da 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -403,6 +403,7 @@ void usb_wwan_close(struct usb_serial_port *port)
 		if (!urb)
 			break;
 		unbusy_queued_urb(urb, portdata);
+		usb_put_urb(urb);
 		usb_autopm_put_interface_async(serial->interface);
 	}
 
-- 
2.34.1

