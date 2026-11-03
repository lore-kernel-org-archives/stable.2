Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692483;
	b=vKyEQzD/cDHweThbwvvOks3/cAQl50d0lhWXaj5U/Ba4+oex6mcXeW3HW4j62Bduv1eJ
	 YIFHqOb+3vgT25h/mvCySGX5WabS1fuLtoKM/MY+Q18S0V915RAm8TA38p3pNdlOm92an
	 6v+LsqMYp/R0fMjGJu4/ET25XAUtMTAuoRol9tcNh+F1SQwOCt9ftbZKOk/Q6vtSJxWfh
	 3xV/O/X2npDWfuzYnT947QXGTydtvXF0UyOsBpKs7iU2f7CG6fllXoOOTc3kVA09sn7fQ
	 0vpJ3J8AFK6kxup8kDlA0RGG6eDfq3ri+CG4VzT7LyqgHPAbNzw9KYudObPMVROTsJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692483;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=bPBlrc4qEBfjzmIxVmq6fxazSIS+RETAtEIJfpuzKtI=;
	b=V3da/1JSF4avhNRmaT0Br2G84rcu9K/YIsOoSCYubk190GjdgeyYoLRbxEqikLO2ldGe
	 1BXFVLWmPKbdzQNCBawsOzL9bv5yCYTNAvYsVDjX06HGbc2EIONPUhnO15Qd4lkn/0lh4
	 ZKlecSuqqUjlbmV/GwPMJINIO4xhncww8WKYXezwj+TfoDd1mqJD7ut7rPjkdevFsVrop
	 ijOA7Z3rRY0dWTkzyeTgAJJcYbDGSFU5+0rI1T/5kWNj6nFAHq06FdNubjZ+M9KQ69w5f
	 ai2znj6AEIvOU0QjgfSfTGoL7ucMmuMrKTIJyUriIQPGA+Iy4odxNioRPfbO7BmpgJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DFC606A324;
	Tue,  3 Nov 2026 07:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97DFC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=bPBlrc4qEBfjzmIxVmq6fxazSIS+RETAtE
	IJfpuzKtI=; b=muoIAL+EHBIik1QVZ6fFdipSuwpKHoWWgAjjR6504GnkbsrOge
	B6RQNl0h0Hgkkapv7dbxHnJIy/4AFO+UDz15r0gM2O8tSNXDt1TJ9N8sb+yhVYnx
	93VO6fIWE92gbEEPQHgS98x5HL5rqfvLo0L9ZUNdbQ7hnrgCx+xyyauh8=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.101])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkB2fP8sk+lqE0IdAQ--.49868S4;
	Tue, 03 Nov 2026 15:54:27 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v5 2/3] media: dvb-core: keep dvb_device alive while checking users count in frontend release paths
Date: Tue,  3 Nov 2026 15:54:19 +0800
Message-Id: <20261103075420.7772-3-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103075420.7772-1-25031212351@stu.xidian.edu.cn>
References: <20261103075420.7772-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkB2fP8sk+lqE0IdAQ--.49868S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1kJry8CFyrCF4fury8Zrb_yoW5Krykpr
	Z3JFW5KrWUKw4kKrs7C3W7ZrnYvF4Syr98C34xt3Z7Cr1fX34SkryFq34q9r13Cr93A3yj
	qwnrGay8C3y7AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRMKZAUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUGD2rop1WenQABs-

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

