Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069354;
	b=KU5oSWJHKVlpe+DjUm8Ny+nqvWVACxqGQoFFuA99DhCHzsGsSajZXS2WXRS1fcGDuy5i
	 QNH/wJZwy39B6h/EH/GZjScNYyejSYakPhzABl6c7JEGj0cjZ7IznmTVAoCUyzDbpyMvm
	 pYWKKtpjkC432QzMKupIjijoRJgkMTlq28VD5wKjlI2dl3rUG1OvfOE96Qv5sv18xd6mL
	 aFUAm+xf0R78C1xPBBziBgygFRrKAZA5mbKJLkiXXg/NI/6u4hFElD+y/xp1xBizOBmFq
	 l0VYEkb6LUD0WGtZEPIrThCjg77WIyKZ538eFsr6mv/aLGNZtgZRHR03Xpf1P9zF8/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069354;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=bPBlrc4qEBfjzmIxVmq6fxazSIS+RETAtEIJfpuzKtI=;
	b=nUqO2TTwFBxcUcDP6EsIhfl1w03ubaj0tsGklRP5sCEEc/iSwipVINnKLvK82MBo+boU
	 w/hfIARerCSk94FeR7U6UKKnHQI6v0FDeGItjAaYa2smWXPzLOtBVImXRx8b70GBcnbPa
	 zrhOvyMa7FUb7NbnWekeec/s4ZV6xAZicNa7+6HIyuz7hhER+FxDs0OsAN450yDQz/sZt
	 hioPK2letYFmeAO/s/IniBuqUZ5bdG1T2IvZVjlo21a/t+B9/fxLka11C2UIkdX7mW6I4
	 adBFP67qzkTEXzquCwlKas7oMJpFj92XyoLQFuSEN4UefT/GUG5cMrOFanHvV0DEOhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE94606A31D;
	Tue, 27 Oct 2026 02:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CE94606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=bPBlrc4qEBfjzmIxVmq6fxazSIS+RETAtE
	IJfpuzKtI=; b=byCJoAMnuO93BjTnRIKK+6Rlf15FGF+OYTBKYbTpkbetR1OGqh
	+cGz0n0KbXS1AYSgVJpKHm1D5S/8RdfPkyPqWyA8/BUR6NQnrwcQ8dzvumgr6cBv
	dyM7d5ytkcOGsK5RoC7jBWaJm5V1Xd0Ay0m1suBr6e/vT5StDlk78/1fY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.115])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBWnwQZEeBqBLjsAA--.49584S4;
	Tue, 27 Oct 2026 10:49:05 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v4 2/3] media: dvb-core: keep dvb_device alive while checking users count in frontend release paths
Date: Tue, 27 Oct 2026 10:48:55 +0800
Message-Id: <20261027024856.22764-3-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027024856.22764-1-25031212351@stu.xidian.edu.cn>
References: <20261027024856.22764-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkBWnwQZEeBqBLjsAA--.49584S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1kJry8CFyrCF4fury8Zrb_yoW5Krykpr
	Z3JFW5KrWUKw4kKrs7C3W7ZrnYvF4Syr98C34xt3Z7Cr1fX34SkryFq34q9r13Cr93A3yj
	qwnrGay8C3y7AaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
	nxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
	1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUiFxUUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUTD2rfbNNUuAABs-

Both dvb_frontend_release() and the __dvb_frontend_open() error path
inspect dvbdev->users after calling dvb_generic_release(), which ends
with dvb_device_put().  If that put() drops the last reference - e.g.
the device was unregistered during USB disconnect while this was the
last open() file - "dvbdev" is freed before ->users is read:

	BUG: KASAN: slab-use-after-free Read of size 8
	 dvb_frontend_release+0x28b/0x2b0 dvb_frontend.c:2903

The same pattern exists at err1: after dvb_generic_release() in
__dvb_frontend_open(), the ->users check runs on an object that may
already be gone.

Take the extra reference *before* dvb_generic_release(): the file
still holds its own reference at that point, so the get is guaranteed
to be valid, while a get after the put() could itself touch freed
memory.  Drop the reference again after the ->users check.

On the __dvb_frontend_open() error path the reference is deliberately
not put() back inside the function.  fops->release() does not run for
an erroring open(), so dvb_device_open() calls dvb_device_put()
itself; that put() drops the reference taken here.  This also keeps
the accounting balanced: dvb_generic_release() already dropped the
file's original reference, and the extra get hands dvb_device_open()
one to drop in its place.

In dvb_frontend_release() the reference is balanced explicitly, before
dvb_frontend_put(fe).

Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
Fixes: a2dd235df435 ("media: dvbdev: drop refcount on error path in dvb_device_open()")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-core/dvb_frontend.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 0286da57f382..00c29cf7ddf0 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -2834,6 +2834,14 @@ static int __dvb_frontend_open(struct inode *inode, struct file *file)
 	mutex_unlock(&fe->dvb->mdev_lock);
 err2:
 #endif
+	/*
+	 * dvb_generic_release() ends with dvb_device_put(), which may
+	 * drop the last reference if the device was unregistered while
+	 * this file was open.  Take an extra reference first so the
+	 * ->users check below cannot touch a freed object.
+	 * dvb_device_open() drops it again when ->open() fails.
+	 */
+	dvb_device_get(dvbdev);
 	dvb_generic_release(inode, file);
 err1:
 	if (dvbdev->users == -1 && fe->ops.ts_bus_ctrl)
@@ -2934,6 +2942,15 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 		mb();
 	}
 
+	/*
+	 * dvb_generic_release() ends with dvb_device_put(), which may
+	 * drop the last reference if the device was unregistered while
+	 * this file was open.  Take an extra reference first so the
+	 * ->users check below cannot touch a freed object, and drop it
+	 * again right after.
+	 */
+	dvb_device_get(dvbdev);
+
 	ret = dvb_generic_release(inode, file);
 
 	if (dvbdev->users == -1) {
@@ -2954,6 +2971,8 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 			fe->ops.ts_bus_ctrl(fe, 0);
 	}
 
+	dvb_device_put(dvbdev);
+
 	dvb_frontend_put(fe);
 
 	return ret;
-- 
2.34.1

