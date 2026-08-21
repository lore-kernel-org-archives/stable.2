Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9B1374E60;
	Fri, 21 Aug 2026 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291647; cv=none; b=a/GkY/gxnGRE17mGqmHrApxlMIRhLTO+rsUl9ojc/Atdi0uwgeGxTju1C6AD27+0NNPyEPgLnZ8SBxXyCTgdVunEHkAqANIcDSF+KjWTbwiiyp6DcNUtBdxDdmYzlJoQv3sr+HeV4OSpv7zp/S8km04qfXesS9ra1yB7lz/m4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291647; c=relaxed/simple;
	bh=EQYy2ReQS8Q4cqPhMkoXfvKOv1etXmUZoox7amO9ng4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rLctAs0UFgezCsAkwlssOBO44Yi2pXNpRqBWG3oCFi8wupl9KEVteibBMCe6Vnpj2dARwcCjkJ2Q6xkLvOJ6biLVNd8uZSdpkslHcPOWhho04XxV7acD2Jyzs4obzMNtEgvqGZPmTT7rB8fr1xYAS5LkxDejHcH7ikF2pvcxVi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=longcheer.com; spf=pass smtp.mailfrom=longcheer.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=longcheer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=longcheer.com
Received: from mailsrv03.LongCheer.net
        by unicom146.biz-email.net ((D)) with ESMTP (SSL) id 202608211353543256;
        Fri, 21 Aug 2026 13:53:54 +0800
Received: from longcheer.com (172.16.9.238) by mailsrv03.LongCheer.net
 (172.16.8.233) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.33; Fri, 21 Aug
 2026 13:53:58 +0800
From: liuqi <liuqi@longcheer.com>
To: <gregkh@linuxfoundation.org>
CC: liuqi <liuqi@longcheer.com>, <linux-usb@vger.kernel.org>,
	<stable@vger.kernel.org>,
	<syzbot+22ea20ef3afb6785b122@syzkaller.appspotmail.com>
Subject: [PATCH] usb-storage: ene_ub6250: serialize card type probe with scan work
Date: Fri, 21 Aug 2026 13:53:58 +0800
Message-ID: <20260821055358.1058653-1-liuqi@longcheer.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailsrv01.LongCheer.net (172.16.8.231) To
 mailsrv03.LongCheer.net (172.16.8.233)
tUid: 20268211353549b8d585b014ed617134708a235b549f3
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

usb_stor_probe2() starts the usb-storage infrastructure and schedules
the delayed scan work. The probe then calls ene_get_card_type(), which
sends a command through ene_send_scsi_cmd() and the usb-storage bulk
transfer helpers. These helpers use us->current_urb.

The delayed scan work also uses us->current_urb when issuing GET_MAX_LUN
through usb_stor_Bulk_max_lun(). The scan path is serialized with
us->dev_mutex, but the post-usb_stor_probe2() ENE card-type probe is not.

If the ENE card-type command is still in flight when the delayed scan
work runs, the scan work can try to submit the same URB again, and
usb_submit_urb() warns that the URB is already active.

Serialize ene_get_card_type() with us->dev_mutex, matching the locking
used by the scan path.

Reported-by: syzbot+22ea20ef3afb6785b122@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=22ea20ef3afb6785b122
Signed-off-by: liuqi <liuqi@longcheer.com>
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

