Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069353;
	b=oADoM2nJ3dukDGPUwmJllp+nmahL8uqGogkk7jJPtHOqbMbfkEwk6diSMz+2uUtoLbpC
	 R8Iltitwgel23kV/V3yWALIkbKNdy2l8U4pxLR+wJohic1BqS5jlobC75on5+fTivfZdK
	 gYgJg2ntoDNwdIMVTr+edBfuiwmdfLNqkGdS7lE10LXepGDNFcgC02t49jHfCfQzwdeLN
	 I666fh7Qhp54Wo/JHxCLxVoRGXhbdvyJcPLTp76+VXMCgedzcs3JGF3bJ/vJZJI6RbpqS
	 RsTVOd8ch/anjrGz+iyE+/SGje4tHsQEDfVQI6JIE+a4odfrUFggvUDPEJxYbhx8xCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069353;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=/X5YrTLx42L4/eawScJmauQ1NvnpJr9kEe3x+juTih0=;
	b=TIz7irty/3YorRny/wADor6IksOoT8e2x/0SHGvAYyeebQElTfTd33nfF3vmM+YD0lVV
	 bIiw0c1QEWg3KkgDvplP+d+mx8eaQ6QceQtQRNbctjHA5bWiMDYKJAsh/EIj4EFyH7fPr
	 K1L0c514T0UEXVan32Qiczlop7XB91Wg8quFjMES3dF8vQ0+S8emOzIKGl+dGz5kXX/Pa
	 MGNEj6jtNQ4e4pI3hiNBukFS9Vs448m5JyTpDkENStjQfcWqlgRiBgDubZyUddl45qrqP
	 O4kZleIsR7wRP/dqEWlEl52DWpq2z+i9I/HNj6oUT4BLKQuRRAdrPk6pPTRXdTwLbUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8CC606A31A;
	Tue, 27 Oct 2026 02:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E8CC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=/X5YrTLx42L4/eawScJmauQ1NvnpJr9kEe
	3x+juTih0=; b=gHMEZOs7BHWx18tGN0jlgNgNpNwRU1y8w2CphD3t+d954MdVB0
	9L1sNYfdyelKWC2DBHx2RBiZ+fUThTREk3G2vwNR87E8dArLyHHcZidaZUt6qz8X
	0FBXptG2FVWx4P9FW7rEPhVNN5OT3tl17rDv5L3MuHEjmGeMWvlXz5yuM=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.115])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBWnwQZEeBqBLjsAA--.49584S3;
	Tue, 27 Oct 2026 10:49:03 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v4 1/3] media: dvb-core: fix use-after-free in dvb_remove_device()
Date: Tue, 27 Oct 2026 10:48:54 +0800
Message-Id: <20261027024856.22764-2-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkBWnwQZEeBqBLjsAA--.49584S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF18tr1DGry3tr47AFy7Jrb_yoW7tF43pF
	Z8Wa45KrWjgrs7Wr4UAF18ZF98Cr1Sv34ruFySkrn7Kr4fJrWIyryqyFyYq3W3A397JrWU
	XFW7JF1kuw4rGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
	nxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
	1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjBc_DUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUTD2rfbNNUuAAAs+

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

dvb_register_device() has a related problem in the other direction.
It installs the new device in dvb_minors[] before calling
dvb_register_media_device() and device_create(), and when one of them
fails it frees the file operations with kfree() while
dvb_device_open() may just have looked the entry up.  Clearing the
array entry from the error path narrows the window but does not close
it: dvb_device_open() releases minor_rwsem only after it has fetched
dvbdev->fops, installed it in file->f_op and called into it.

Publish the file operations only after every step that can fail has
completed.  dvb_minors[minor] is still filled in before
dvb_register_media_device() so that the minor stays reserved and
concurrent open() calls reach a stable decision, but dvbdev->fops
remains NULL until device_create() has worked, and dvb_device_open()
turns such an entry into -ENODEV without taking a reference.  The
error paths can then release the object and its file operations with
no concurrent user in sight.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-core/dvbdev.c | 37 ++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d753d329502a..7988d01ebe99 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -518,7 +518,6 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	dvbdev->id = id;
 	dvbdev->adapter = adap;
 	dvbdev->priv = priv;
-	dvbdev->fops = dvbdevfops;
 	init_waitqueue_head(&dvbdev->wait_queue);
 	dvbdevfops->owner = adap->module;
 	list_add_tail(&dvbdev->list_head, &adap->device_list);
@@ -537,10 +536,10 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
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
 
@@ -556,11 +555,16 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
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
 
@@ -575,14 +579,31 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
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
 
+	/*
+	 * Publish the file operations only once every step that can fail
+	 * has completed.  Until then dvb_minors[minor] is just a
+	 * reservation: dvb_device_open() turns an entry whose fops is
+	 * still NULL into -ENODEV without taking a reference on it, so
+	 * the error paths above never free file operations that a
+	 * concurrent open() is about to use.
+	 */
+	down_write(&minor_rwsem);
+	dvbdev->fops = dvbdevfops;
+	up_write(&minor_rwsem);
+
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
 		adap->num, dnames[type], id, minor, minor);
 
@@ -598,7 +619,6 @@ void dvb_remove_device(struct dvb_device *dvbdev)
 
 	down_write(&minor_rwsem);
 	dvb_minors[dvbdev->minor] = NULL;
-	dvb_device_put(dvbdev);
 	up_write(&minor_rwsem);
 
 	dvb_media_device_free(dvbdev);
@@ -606,6 +626,13 @@ void dvb_remove_device(struct dvb_device *dvbdev)
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

