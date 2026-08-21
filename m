Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6864470EA1;
	Fri, 21 Aug 2026 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303160; cv=none; b=IXVoaqBjZj6JMqCa6dFle69GZUtOuBdNyLnf8EewO1P4MpK4orQSXA8aALzk5oYahc1wcJTcUUJlmdB4ZKvjY0WZNOrHxp2U6wW+iZ3f3LG3wJTQDGW0ICdv80ilsI3b58+pFDgMGGZJ/od1RJftIIfQOiP7JuwULoMUZc5KCtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303160; c=relaxed/simple;
	bh=RND5CTJNq5RkPcfPxTB6fv83aG6h8XcGXUodchSKQHA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iSYYD0XX4lZvnkl+Cn+hR7HQ7LpwTKgOS4kTJlRXsL3bp+X7iCbsdrMBLFwikWN+/3yYK+yml/1yMxAeXFqCKlo4G5KBpMF58JCBNQApItJG76QbgcjcfrLcMR0bRwXUV4OUOTB9Cw75pAnTJTXBboAEVIP94jwyHZi0s5lvBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=longcheer.com; spf=pass smtp.mailfrom=longcheer.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=longcheer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=longcheer.com
Received: from mailsrv02.LongCheer.net
        by ssh248.corpemail.net ((D)) with ESMTP (SSL) id 202608211704210475;
        Fri, 21 Aug 2026 17:04:21 +0800
Received: from longcheer.com (172.16.9.238) by mailsrv02.LongCheer.net
 (172.16.8.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.33; Fri, 21 Aug
 2026 17:04:22 +0800
From: Liu Qi <liuqi@longcheer.com>
To: <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <stable@vger.kernel.org>,
	<syzbot+22ea20ef3afb6785b122@syzkaller.appspotmail.com>
Subject: [PATCH v2] usb-storage: ene_ub6250: fix race between scan work and probe
Date: Fri, 21 Aug 2026 17:04:16 +0800
Message-ID: <20260821090416.1247127-1-liuqi@longcheer.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailsrv02.LongCheer.net (172.16.8.232) To
 mailsrv02.LongCheer.net (172.16.8.232)
tUid: 2026821170421fb91a20b61515139b82025a13182233c
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

ene_ub6250_probe() calls usb_stor_probe2(), which starts the usb-storage
infrastructure and schedules the delayed scan work.  The driver then
calls ene_get_card_type(), which sends an ENE command through
ene_send_scsi_cmd() and the usb-storage bulk transfer helpers.

Both the delayed scan work, through usb_stor_Bulk_max_lun(), and
ene_get_card_type() use us->current_urb.  The scan work serializes this
access with us->dev_mutex, but the ENE card-type probe does not.  If the
scan work runs while ene_get_card_type() is still using us->current_urb,
usb_submit_urb() warns that the URB is already active.

Serialize ene_get_card_type() with us->dev_mutex, matching the locking
used by the scan path.

Reported-by: syzbot+22ea20ef3afb6785b122@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=22ea20ef3afb6785b122
Assisted-by: Qwen:Qwen3.6
Signed-off-by: Liu Qi <liuqi@longcheer.com>
---
 drivers/usb/storage/ene_ub6250.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
index 2cffc559a..13b332d1d 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -2358,7 +2358,9 @@ static int ene_ub6250_probe(struct usb_interface *intf,
 		return result;
 
 	/* probe card type */
+	mutex_lock(&us->dev_mutex);
 	result = ene_get_card_type(us, REG_CARD_STATUS, info->bbuf);
+	mutex_unlock(&us->dev_mutex);
 	if (result != USB_STOR_XFER_GOOD) {
 		usb_stor_disconnect(intf);
 		return USB_STOR_TRANSPORT_ERROR;
-- 
2.43.0

