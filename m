Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25203E5EF8;
	Wed, 23 Sep 2026 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155544; cv=none; b=c4eXODqtaIShfM+mkj68UBj5DOxyKrInbcJ9ImZjPInAuUPc0roQP1O4To+Xo7GK2Y8EcnZ3gjm3vuhy+kpv3kMlWC+8EEbp4Zk/XOTWNYV5hYEXgqjm/EC/F3SlLA/SBhpWM3gd3uKrAgMMUg0KwozHXfVbsO9nuqA1WaSKWM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155544; c=relaxed/simple;
	bh=jB8z6sEMowFvzLsPkiRETp3H3c5r4Nx1H2rLcot9d8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BixMJ0j4HtKmjiJo+zd1w59uV72STUE691huULAyfK1l3gjf49EOJ7Ynji1CAqwnw7NcOgRUjVBU6YoB6urYF6oX+kW5ZnmZ+KJu1K48srY2hxFp60MpQOs4O+hPc9gqqVAGfwHplzGeSV1buRjsPSSul2AtnEybt8YV8OHHwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=r/4/TNQO reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="r/4/TNQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding; bh=RybKETcbixVV3yVyAXW3M5o74IbsAhytgE
	aToaZycY8=; b=r/4/TNQOnacRKF6ivi9JVlEAoIx7f58CWq/oOx/3dMtWgmH03n
	bqHsrPRIBOPcfvfLs0Q+7mgE5wAUybWIdeTEOTRVVwcK6iSyoS8b/8uzckaP2seo
	F7tFSiiKEQoo46cvGhBErCI4HeyqGdKe4G09X9Lrfaj4MuTFngVlfdLaw=
Received: from localhost.localdomain (unknown [113.200.174.5])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkA2FjUAm7NqdssuAA--.1462S4;
	Wed, 23 Sep 2026 17:25:32 +0800 (CST)
From: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patrick.boettcher@posteo.de,
	Yuanzhe Liu <25031212351@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] media: dvb-core: keep dvb_device alive while checking users count in frontend release paths
Date: Wed, 23 Sep 2026 17:24:52 +0800
Message-ID: <20260923092454.969-3-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20260923092454.969-1-25031212351@stu.xidian.edu.cn>
References: <20260923092454.969-1-25031212351@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkA2FjUAm7NqdssuAA--.1462S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4fAr1DuFy3JFy8WF45KFg_yoW5GrW8pF
	Z3JFW5KF4UKwn7Wrs2y3WDur9YvF1Syry5Ga4xtanakr1fJ348KryYga4v9rsxGrs3JrWj
	qwsrGaykC3y7ZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmC14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRt73kUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2qyndaywgAAst

Both dvb_frontend_release() and the dvb_frontend_open() error path
inspect dvbdev->users *after* calling dvb_generic_release(), which ends
with dvb_device_put().  If that put() drops the last reference —
e.g. USB disconnect has already removed the minors entry and this was
the last open() fd — "dvbdev" is freed before ->users is read:

	dvb_frontend_release+0x28b/0x2b0 at dvb_frontend.c:2903/2916
	BUG: KASAN: slab-use-after-free Read of size 8
	(the same pattern exists at err1: after
	 dvb_generic_release() in dvb_frontend_open())

Take an extra kref around the post-release checks so the object stays
alive until we're done with it.  While there, also grab it in
dvb_frontend_open() before the same late ->users check on the error
path; the reference itself is dropped right after, which is safe
because fops->release() no longer runs on an erroring open().

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-core/dvb_frontend.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index d082b6c..9f92af3 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -2888,9 +2888,18 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 err2:
 #endif
 	dvb_generic_release(inode, file);
+
+	/*
+	 * dvb_generic_release() may have dropped the last kref, so the
+	 * object can already be gone.  Take an extra reference before
+	 * poking at ->users.
+	 */
 err1:
+	if (!dvb_device_get(dvbdev))
+		return ret;
 	if (dvbdev->users == -1 && fe->ops.ts_bus_ctrl)
 		fe->ops.ts_bus_ctrl(fe, 0);
+	dvb_device_put(dvbdev);
 err0:
 	if (adapter->mfe_shared)
 		mutex_unlock(&adapter->mfe_lock);
@@ -2913,6 +2922,13 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 
 	ret = dvb_generic_release(inode, file);
 
+	/*
+	 * dvb_generic_release() ends with dvb_device_put(); make sure the
+	 * object survives until after the ->users check below.
+	 */
+	if (!dvb_device_get(dvbdev))
+		return ret;
+
 	if (dvbdev->users == -1) {
 		wake_up(&fepriv->wait_queue);
 #ifdef CONFIG_MEDIA_CONTROLLER_DVB
@@ -2931,6 +2947,8 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 			fe->ops.ts_bus_ctrl(fe, 0);
 	}
 
+	dvb_device_put(dvbdev);
+
 	dvb_frontend_put(fe);
 
 	return ret;
-- 
2.45.1.windows.1

