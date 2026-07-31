Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1043D75D1;
	Fri, 31 Jul 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487864; cv=none; b=YDt46IoEInjlK54Cnh7Vu0kcH/bI4snjrsjenE7VkeOvZ0UAKRHcJlgRVeZotWx7YeUYjd284zuWGuXzqDpQZxO332+4SaLE1mZ1Z7EWxVjV6T5Wwfp8A62RXxtnLYxR6f60f7cpirksOJ5dar56kxVtXto6FXLQHv/vpjNDDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487864; c=relaxed/simple;
	bh=M7AO/cYklFIWanNZ9acjjF56hbbu/V3yW+eRYtfVAvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R1rfndW24VOZR7iI6JcYMm2mewxgJzCYSblal71KrISSF+JQZ3bSXuT+HVBBQSyEsMJP4qmRrRRPrbhISuaQvzrJ9EudmwPBwTnQXMGEpRzCf9RZ3L3NcuDaVr9Bluf5HgB3dujKMmpkh/CDhsStpW3mx27D/5GskiN13S/sKE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KU3FUovM; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KU3FUovM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785487787;
	bh=j2d6Kj4efhOmsGE3VeSWl77MNEh59dtvqXGiBs7PKEk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=KU3FUovMSQ1MzCoB8nExPKS1raWgDwIlOa9IQ5Hxsfr7kMOxbrYy1GJ9Di7qgPEbV
	 be7z3zh4Y+XqNOrJbtPnB7PdLZM6fKK/RIFpJKzIwmI4Z0WQCLmdUzLRYFaMAt/3CB
	 5a/DU1XLDd1caE4IMA+nNPUAKyhus33+B1Jeln6A=
X-QQ-mid: esmtpgz16t1785487770tbc7ae547
X-QQ-Originating-IP: 3zxAjfepPUaL6xiXnujpSg+ZdcBgjACSBYEx8FXrl/s=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 16:49:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 93860266829892047
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: erazor_de@users.sourceforge.net
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] HID: roccat: free buffered reports when destroying device
Date: Fri, 31 Jul 2026 16:49:26 +0800
Message-ID: <B93A126D2A126AAD+20260731084926.1771993-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MQZ/dZQlO/THOE8XGfHK1S7hala1SbFa7nbwdwgGS36+p84gd2kYJ1IP
	od5gAfW77VZgdV+p8xPzqv+8gd5xrtUhM/PNsqlGJt260MQZCd1MBPQS2BS0RfXwsGnhFg/
	/uFUgnO5fw9cKizg03X/NEInYmkc4pYLzPQQ45n10BhUxU51qWx0aFGglhfogibgkHuDJ4h
	SgehR272hnA3jf3wh0K1a9vvbO88uVerYhcYVuf6rLnHUwwrPt+9uU82gbdXYquiau0p43i
	85paLlkk26APQ1GzebNB+jADgYjzLqu54HdKSICWv7wTcIK5x6eHHCesLSw6VJCSGKb4T9e
	myQ2PcjNXMc08DEGHtDt9ir4aEe8Bj2DYHda4h6SGuyxuu4TllxTwktjMmWU6UC+3xbSnTV
	p/T3z44xCEGJNzO/ApTf0jgNhDjJSHv3FmjsVXr5PS5e/wi69nlJdbZu/Ro2uTVLPtxJooH
	ytgszqLEPxGDm5/095LXMcBtRECP88xt15eToFRGAmuWBXwShi2G5LSE2cs1ym6udgHE90v
	9OjzApxRDw+pXBPCTwva550ImQUwWjEfC+Hc5FCJk69r65h/15at/neR2h9yGzCke/5TkzY
	cfh9+JxGLqW18HkwdkXG+nvYp87W4sAZGxbrpAuBysqTinSlaXOfvmnoqRL74CcyTpItVSQ
	KympsCiVYRh7k619MauwQir32N4PffSN1ceAVR3pqOfstvp6f+jjC80PJenAAymxLIxpfRF
	VXJQRDuCWL0alZUQ+mz/RACSNmmDvRqk7IswMlayejRwP1UXfk+oZdL6s1j3rbKmnn3OU7c
	jLHklvjJsjqumxHKJxIihTx8ULl1owRjLdv7IBylBqeFVwC1/o4VmIGcR5yWVaXRhvl6Wps
	H7oSpwOiiiYY7tLLe1fNbmMocZqytJtt12H4Room7FRIPcghvdmEa0viixJTFjGRHRwOqT/
	rsKCf3MEogk3AkX59bzKeONcEJTIHoc9CUxjeWyQW8h8bGk5gkontcqXVzX72HJW3niC7Tz
	ygqJyepxyAC6hLC0LQtHGc51TBoCfoPlqAkTSSaGKzk4on10q4ZlNYmu4e8t/p7ycaJalOg
	w==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

roccat_report_event() duplicates each report with kmemdup() and stores
the allocation in a circular-buffer slot. The allocation is released only
when that slot is reused.

The device destruction paths free struct roccat_device without releasing
reports still stored in cbuf[]. This makes those allocations unreachable
and leaks up to ROCCAT_CBUF_SIZE report buffers per device.

Add a small destructor that frees every buffered report before freeing the
device, and use it in both paths that can destroy a registered device.

Fixes: 206f5f2fcb5f ("HID: roccat: propagate special events of roccat hardware to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/hid/hid-roccat.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index d6fff53d4ee7..4f15eb951039 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -70,6 +70,15 @@ static struct roccat_device *devices[ROCCAT_MAX_DEVICES];
 /* protects modifications of devices array */
 static DEFINE_MUTEX(devices_lock);

+static void roccat_free_device(struct roccat_device *device)
+{
+	int i;
+
+	for (i = 0; i < ROCCAT_CBUF_SIZE; i++)
+		kfree(device->cbuf[i].value);
+	kfree(device);
+}
+
 static ssize_t roccat_read(struct file *file, char __user *buffer,
 		size_t count, loff_t *ppos)
 {
@@ -226,7 +235,7 @@ static int roccat_release(struct inode *inode, struct file *file)
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			hid_hw_close(device->hid);
 		} else {
-			kfree(device);
+			roccat_free_device(device);
 		}
 	}

@@ -374,7 +383,7 @@ void roccat_disconnect(int minor)
 		hid_hw_close(device->hid);
 		wake_up_interruptible(&device->wait);
 	} else {
-		kfree(device);
+		roccat_free_device(device);
 	}
 }
 EXPORT_SYMBOL_GPL(roccat_disconnect);
--
2.50.1

