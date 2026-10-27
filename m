Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793066301;
	b=FrcIkszWGqOSfyp69cn1fPzL5G21PU5PL/sTlHICqrI5LvnapeZb/yzNpws+XI6V3xLQ
	 X0s9gXHkWUKSsmomnsySqkVaHI2CGFogT/xH9oeHhb2fHQ0ZFCrHC5BR2uBNYNrGQf+qv
	 wnU/C8IenJwixYdL+RdwGKYrq0Nk2JQC2kZlKIYqx/sGADNGIO+x6TtHDrDC/R/KIDmBF
	 igFLvgrY4ztG2VIlU+IhB416/d7Ry1Zr5RCm+Feb0xHkR/+reFfQQekc24jPLdWDA0bXd
	 UIOKLif1dGbq/pSPH6RhgDvkvjmFG6pIlDickCAiVC+tWuCmkpD+WI5toTlRs0vIujQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066301;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=V0hkJ099LgoWieByR8yk4rk9sO86OA12IjSyPFW9TO8=;
	b=zGOqr1RsphpzP3dcrjwj9OZYlwt2fdRYxLtNknPBDFhTJCXn80/diOiHpL9z8EIUvjDX
	 fDqosupCHXHPTEeGpNOmveEOoYnO3FPoNNl5F0S/du7EHJ42wH2FlmYVuEYzXVDwuTau/
	 AafCeXreRWguyxdMbVSmiswsUw5x/NetBJKwrPbca8eiaUKJeFQyHBDiDduY2Pi5y7PFO
	 buzYNg2NIi3tEiUKgqoBJLEmH01slaHFPZrvYKwUbK8YGvB11xlTdiGEH3gRurBCTR2wS
	 bT29fiuQu/6V5HSRpl4KywzL7dnS1feBL6rP5GscgTGyLtggn7NqqTgy4Kz18Q65QlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43C9606A31D;
	Tue, 27 Oct 2026 01:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A43C9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=V0hkJ099LgoWieByR8yk4rk9sO86OA12Ij
	SyPFW9TO8=; b=tD/h0kiNoCbBaxjabrx2sCoq5LaDyPqJ1EDk5Tf0UMH2VnVfPO
	odpjK8ISmlojl60V2sNw9ODuQPf04XV6M5gvolQBTDRy8FwFo1VHeHma4b4WAiPx
	m/SwQ9lBnqs2VNb7bUnqhurRuLd6w2qes01x614i7cqhuUAAO9r2ZC0yY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.115])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBWnAEsBeBqxnzsAA--.34537S3;
	Tue, 27 Oct 2026 09:58:10 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v3 1/3] media: dvb-core: fix use-after-free in dvb_remove_device()
Date: Tue, 27 Oct 2026 09:58:02 +0800
Message-Id: <20261027015804.13148-2-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkBWnAEsBeBqxnzsAA--.34537S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWxJF15Gr4fuFyfZF4kCrg_yoWrZF4UpF
	Z8ua45KrWjgrs2gr47AF109F98Gr1Sv34ruryakwn7Kr4fJrWIyryqyFyYq3W3ArZ7JFWU
	XFW7J3Wkuw4rGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	cSsGvfC2KfnxnUUI43ZEXa7VUjBbytUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUTD2rfbNNHyAAAsd

dvb_remove_device() clears dvb_minors[] and drops the minors-table
reference while holding minor_rwsem, but then keeps using "dvbdev":

	down_write(&minor_rwsem);
	dvb_minors[dvbdev->minor] = NULL;
	dvb_device_put(dvbdev);          /* may kfree(dvbdev) */
	up_write(&minor_rwsem);

	dvb_media_device_free(dvbdev);
	device_destroy(dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
	list_del(&dvbdev->list_head);

If the put() happens to drop the last reference, the remaining three
statements are use-after-free. KASAN reports the read of dvbdev->minor
inside device_destroy(), and the list_del() then writes list poison
into the freed object.

The reference accounting itself is fine: dvb_unregister_device()
pairs the put() with its own one for the caller, and direct callers
such as dvb_unregister_frontend() and dvb_ca_en50221_release() rely
on dvb_remove_device() consuming the minors-table reference only.
The problem is the ordering, so move the put() after the last use of
the object. The entry is already gone from dvb_minors[], hence no
concurrent open() can acquire a new reference in between.

While at it, fix the error paths of dvb_register_device(): once the
new device has been installed in dvb_minors[], a failure in
dvb_register_media_device() or device_create() frees it with kfree()
without clearing the array entry. dvb_minors[minor] is then left
pointing to freed memory and the next open() dereferences it. Clear
the entry under minor_rwsem and release both the minors-table and
the caller's reference with dvb_device_put() instead of freeing the
object directly.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-core/dvbdev.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d753d329502a..610f8634e8d4 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -537,10 +537,10 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 			kfree(new_node);
 		}
 		list_del(&dvbdev->list_head);
-		kfree(dvbdev);
 		*pdvbdev = NULL;
 		up_write(&minor_rwsem);
 		mutex_unlock(&dvbdev_register_lock);
+		dvb_device_put(dvbdev);
 		return -EINVAL;
 	}
 
@@ -556,11 +556,16 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 			kfree(dvbdevfops);
 			kfree(new_node);
 		}
+		down_write(&minor_rwsem);
+		dvb_minors[minor] = NULL;
+		up_write(&minor_rwsem);
 		dvb_media_device_free(dvbdev);
 		list_del(&dvbdev->list_head);
-		kfree(dvbdev);
 		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
+		/* drop the minors-table and the caller's references */
+		dvb_device_put(dvbdev);
+		dvb_device_put(dvbdev);
 		return ret;
 	}
 
@@ -575,11 +580,16 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 			kfree(dvbdevfops);
 			kfree(new_node);
 		}
+		down_write(&minor_rwsem);
+		dvb_minors[minor] = NULL;
+		up_write(&minor_rwsem);
 		dvb_media_device_free(dvbdev);
 		list_del(&dvbdev->list_head);
-		kfree(dvbdev);
 		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
+		/* drop the minors-table and the caller's references */
+		dvb_device_put(dvbdev);
+		dvb_device_put(dvbdev);
 		return PTR_ERR(clsdev);
 	}
 
@@ -598,7 +608,6 @@ void dvb_remove_device(struct dvb_device *dvbdev)
 
 	down_write(&minor_rwsem);
 	dvb_minors[dvbdev->minor] = NULL;
-	dvb_device_put(dvbdev);
 	up_write(&minor_rwsem);
 
 	dvb_media_device_free(dvbdev);
@@ -606,6 +615,13 @@ void dvb_remove_device(struct dvb_device *dvbdev)
 	device_destroy(dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
 
 	list_del(&dvbdev->list_head);
+
+	/*
+	 * Drop the minors-table reference only after the last use of the
+	 * object above: should this be the last reference, freeing it any
+	 * earlier would turn those statements into a use-after-free.
+	 */
+	dvb_device_put(dvbdev);
 }
 EXPORT_SYMBOL(dvb_remove_device);
 
-- 
2.34.1

