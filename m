Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793066304;
	b=DrA9Khdl7Z1URxwhZ1bdgXuKANH1O1CvwEjDSRbmzoglnaf+B5AAKQOUBeI2YabyvD2f
	 MnpcwBDPzpwJratDx1LdjX/oUljXLRQgvow1DWzU5ij/JSIjD1vxzuMCh+L5SumgP1/LG
	 y4XP7e4M3+W+H/EVZeUx6WjtsaOA5A44EQ1udOd/fz/us7AvNrcmwHMKokAI6pwkEScaC
	 TOOKrlcy54vQPy9GRvqNtTKdbNS8FZfR7sTx8kr5+6fR2xQF9llZsCdOqNUbO9vp4uK+e
	 X+WyKXCW8AcbEpIM/1Xg8XQiO5hXrTLntpnHWjXfDOtyOOt0ctLmkcyxgSaXG6sM+cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066304;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=bPBlrc4qEBfjzmIxVmq6fxazSIS+RETAtEIJfpuzKtI=;
	b=uHKy+QCZ9GUsIm9vl7enR+XaTGZqEpuEm/AOGLH506DrTSNPU8GkjpH2+98tos7CLVuL
	 c8OrWIHLAhpg0/sd9whLi6Ws+0yy8AFN0thbVaQThy7dDe5zpNTkcvTOPJ41JUTi5Kxmk
	 HxozUcscxNpH1nHkAV7B/LGlGUxwVQktN19R16lNX9FZI4pxJyweA3yaM4yKIqVnTkAxt
	 JpiCFKKrAAYppof3h40Zp8z60OZ/RT7KimaabDQgw7aOldGZ3LoZZRZt/99pYT7WenTli
	 vCwLYPCU43AgvTxXYP7Psmqy4sjtsXbxKVa37HebTcH3xwUZi3x4RoOUn8E6BOF3lBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE811606A32E;
	Tue, 27 Oct 2026 01:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE811606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=bPBlrc4qEBfjzmIxVmq6fxazSIS+RETAtE
	IJfpuzKtI=; b=stD+GEJ7WsT1Qc4IdLdHDb7vBmRPiA3CWiLyaf4lr51NcHanGD
	sZKVdFYSuAPpbtrtw/Y2ghvLUVqzPrcwt41G0NXlNIyrA9S0NbjFzzweR9xaUpTU
	9Oq2Y5NM9sssI0G7RgCSpameXMX3SKX/ZQDDwLdckqdWe5vCbNgT5AxaY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.115])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBWnAEsBeBqxnzsAA--.34537S4;
	Tue, 27 Oct 2026 09:58:15 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v3 2/3] media: dvb-core: keep dvb_device alive while checking users count in frontend release paths
Date: Tue, 27 Oct 2026 09:58:03 +0800
Message-Id: <20261027015804.13148-3-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027015804.13148-1-25031212351@stu.xidian.edu.cn>
References: <20261027015804.13148-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkBWnAEsBeBqxnzsAA--.34537S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1kJry8CFyrCF4fury8Zrb_yoW5Krykpr
	Z3JFW5KrWUKw4kKrs7C3W7ZrnYvF4Syr98C34xt3Z7Cr1fX34SkryFq34q9r13Cr93A3yj
	qwnrGay8C3y7AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mx
	kF7I0En4kS14v26r126r1DMxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
	cSsGvfC2KfnxnUUI43ZEXa7VUUmLvtUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUTD2rfbNNHygABse

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

