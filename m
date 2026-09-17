Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B142489861;
	Thu, 17 Sep 2026 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641080; cv=none; b=lQp5J1Q7EHFUi/2JFWyaDoyA0smX602MAMvWkX5NZPNp8IcorKROrfvsihmBv4fm2f/SIJMegjT3ESJ7wBslBmPyxV2/BXuQzKBCinDpf6W5Ehj6zmf3Os8OAb1fn6ycHwE9JaSnvL4Obv5OGYq2NJPN3zPsmjqhybjTs8YGNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641080; c=relaxed/simple;
	bh=RhTa7k4Hj5AyVZA2eedkN0tuZEwWe9iRG3vzFtoFBEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ari9s+yoyGjlUpcxuAkCfajzJO3E9YFNi1cKmAa8NMlREdHUKjrc+3aIlPkJuJGptHgbbFm/BqaGmK7ydm4hzHhSyfPmx2HD9mA8XyqyZ+JUePBHsQdcXOLIjTaf45VXDjWRn6V2yLCKrqCYq3XOtxV2Jd2Tunn1nls2ZJetfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3pkBmwatqG6p+CA--.644S2;
	Thu, 17 Sep 2026 18:31:02 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: chengzhihao1@huawei.com
Cc: daniel@makrotopia.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: ubi: Fix UBI device reference leak in ubi_detach_mtd_dev()
Date: Thu, 17 Sep 2026 10:31:02 +0000
Message-Id: <20260917103102.2147038-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3pkBmwatqG6p+CA--.644S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jry5XFyfXw1xArWxCF4DArb_yoWkGwbEgr
	y7ur97XF1jgFyqka4ftr48Ar9ayFsIqrWI9F4Igwsa9a98WF9rXrZ8Crn8JFsruw40yF93
	AayDZrWrXw43WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07jbl19UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwANA2qrrRlG-wAAsF

ubi_detach_mtd_dev() takes a reference on the UBI device with
ubi_get_device() and drops the matching kobject reference only after
the shutdown notification has been sent.  When the device is still in
use and a forced detach was not requested, the function returns -EBUSY
before that put_device(), so the reference taken by ubi_get_device() is
never released and the device is never freed.

Drop the reference on the busy path as well.

Fixes: 7e84c961b2eb ("mtd: ubi: introduce pre-removal notification for UBI volumes")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/mtd/ubi/build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 674ad87809df..d81f5e0395ac 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1106,6 +1106,7 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
 	if (ubi->ref_count) {
 		if (!anyway) {
 			spin_unlock(&ubi_devices_lock);
+			put_device(&ubi->dev);
 			return -EBUSY;
 		}
 		/* This may only happen if there is a bug */
-- 
2.34.1

