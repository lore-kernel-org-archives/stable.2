Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588872627;
	Fri, 26 Jun 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477335; cv=none; b=msICt8WzDEM6zCc3ZOWp1ym5MiR9GWzarfxuEtjsuXEC54iL5tKdX9K90/d7EwIPdVXQWDYpdw9nAbQ7VCeepaTNq9wr/WDpJikHMxEIfoJy4wUuUossCHU+2T6sDnBnCsrXvC3znX7PSNGopAnV4icoYeB0pWUuouG4wQJbC/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477335; c=relaxed/simple;
	bh=XGEdQXpaoKlN689Xk7cJfiTOTuOwaThxfE1eDe/ontg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HOkQPmzcXEO4VM5DkXa7il2w3LpvXivUIC/YbZX7EgqqIuO4e/0iVMcprRcf/8Tv8GAYHkzHE0jx2cjQ3Qq5sSVORvo9KU6SepxYjZpT5U58NO/FdQeE9fRP0nCVarX88r0XMp79uoeS3Gq7txTfoJdMh8b8F2zbwFm4Ua7s92U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowACnMwcMcj5qwG5oFQ--.22930S2;
	Fri, 26 Jun 2026 20:35:25 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: edac: edac_device_create_instance: main_kobj reference leaked on   success and block-creation error paths
Date: Fri, 26 Jun 2026 20:35:23 +0800
Message-Id: <20260626123523.36166-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnMwcMcj5qwG5oFQ--.22930S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWrtw4xJFy8ZFy8Zw43Jrb_yoWkJwc_KF
	y0gF17urn5Krs3Kw17Aw4xZryvg3Z2gr1xAFZFgFs5Jr1UZF15Xw4DWF1rArW7Wa1I9FyY
	k3W5trWUuryxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjIJmUUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoKA2o+Sxl+3wAAsi

kobject_get(&edac_dev->kobj) acquires a reference on main_kobj, but it is
  only released when kobject_init_and_add fails. The success path and the
  block-creation error path both return without calling
  kobject_put(main_kobj), leaking the edac_dev kobject reference. The
  main_kobj pointer is local and lost after function return.

Cc: stable@vger.kernel.org
Fixes: c10997f6575f ("Kobject: convert drivers/* from kobject_unregister() to kobject_put()")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/edac/edac_device_sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index b1c2717cd023..72b06d608b98 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -647,6 +647,7 @@ static int edac_device_create_instance(struct edac_device_ctl_info *edac_dev,
 
 	/* error unwind stack */
 err_release_instance_kobj:
+	kobject_put(main_kobj);
 	kobject_put(&instance->kobj);
 
 err_out:
-- 
2.39.5 (Apple Git-154)

