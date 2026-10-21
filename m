Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593238;
	b=pCJOSgG53Ox3pUq2DmivSPvnyjPMbp/J6PVh0GVVySvr6j/DDAiJZwlkPtuKEC7N+8Vs
	 t/g+bdMYpV4mC9BrcBacjn85xjzw1lRTbEiAvASbVYwE/XQtdtwSyzlEeR7RJy8C4jjaH
	 gdq071Hc02kZzI+2MT3Jh+e94KRjdNasjqDd+Qbg/4TPGGmP+10Xlf2tHRO6qk8A8P6S9
	 /OUEBTwtcgt2zoyFcMpTba6SQE3/s2QQBxT8rhAkkjZ18uee5EDfubI9yD0qW8pBTpodu
	 bWW+6RtDGDtgbnol2KWXQEy/qU0ceJh8CdCFFSTmqYhvhsZzYTeS4NU1thw6HmOUrQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593238;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=0TbgbwPTcpHVBcw7avCcPBtAA6bSjHwtfQ+shaABXe8=;
	b=okpakYCsfXRoyHXwA1f9Y/Cod4wGg61O1jcQiLABJN0TlJCx48XEsP6p6FD3BWCxXaQv
	 xOvMDAmPbR3bPLVY8zBpkph6g2SWjr9Ug7GtWorPd23dYP3uc1s8xHhb37PitlB+PGPXO
	 9XfcGvYHGKSPR29u2Xy8J/npKCzkXmCc9P+S+1sTW6L7+X9s8GKfr9JyMa2k0f64r0BOq
	 vuQ9TsNuYZbr7OE7d2FxXYQab7s0cLzOa+MmMRSRm9TBRlIDHzgyL2OV6sEkHGZpMYjW2
	 Iw2raE4siwysGPDUVx2fwCMmzoXETPSVinotf8aBp0Cf17oIhYo0BwZtE2TKhPK3bpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KP5LhAgd;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F25606A31E;
	Wed, 21 Oct 2026 14:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0F25606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KP5LhAgd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0T
	bgbwPTcpHVBcw7avCcPBtAA6bSjHwtfQ+shaABXe8=; b=KP5LhAgdrcQ6uHJww3
	1Aftl6FDS3J8ti/1LdEQaBTISvofHWcik5e02UkqT8hHBUh4BU1BCwcW08D3im/Z
	6sHQVYON8q4EkR2eN+Cspar7OyZznTXZe+hSerQSe/J3r/PPhbEn1bdTp0Gzcv1u
	CDfjfJip1tIDuwJDw0EDbJKfA=
Received: from pc.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHt6Uzzdhqp3_gBA--.20120S3;
	Wed, 21 Oct 2026 22:33:27 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/2] Drivers: hv: vmbus: prevent duplicate dynamic IDs
Date: Wed, 21 Oct 2026 22:33:22 +0800
Message-Id: <20261021143323.338146-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021143323.338146-1-yaojiale02@163.com>
References: <20261021143323.338146-1-yaojiale02@163.com>
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
X-CM-TRANSID:PygvCgDHt6Uzzdhqp3_gBA--.20120S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur45XF4fJF15Xw43ZFyrJFb_yoW8ZrWxpa
	1UurWayr18JF13WwnY9rWUAFyFv3yvg343CryDCas2vF1qyryq93yrJa4qvr9xK3y8uFnI
	9F4Utr1rua1DZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UR7KsUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xdRi2rYzTfZgQAA3y

new_id_store() checks for an existing dynamic ID before calling
vmbus_add_dynid(), but the check and insertion use separate critical
sections. Two concurrent writers can therefore both observe that a GUID is
absent and add duplicate entries. Removing the GUID once then leaves the
duplicate active.

Move the duplicate check into vmbus_add_dynid() so it is performed under
the same lock as the list insertion.

Fixes: fc76936d3ea5 ("vmbus: add support for dynamic device id's")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hv/vmbus_drv.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4692687cdbf3..1037117e2d81 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -737,7 +737,7 @@ static const struct hv_vmbus_device_id *hv_vmbus_get_id(const struct hv_driver *
  */
 static int vmbus_add_dynid(struct hv_driver *drv, guid_t *guid)
 {
-	struct vmbus_dynid *dynid;
+	struct vmbus_dynid *dynid, *existing;
 
 	dynid = kzalloc_obj(*dynid);
 	if (!dynid)
@@ -745,9 +745,16 @@ static int vmbus_add_dynid(struct hv_driver *drv, guid_t *guid)
 
 	dynid->id.guid = *guid;
 
-	spin_lock(&drv->dynids.lock);
-	list_add_tail(&dynid->node, &drv->dynids.list);
-	spin_unlock(&drv->dynids.lock);
+	scoped_guard(spinlock, &drv->dynids.lock) {
+		list_for_each_entry(existing, &drv->dynids.list, node) {
+			if (guid_equal(&existing->id.guid, guid)) {
+				kfree(dynid);
+				return -EEXIST;
+			}
+		}
+
+		list_add_tail(&dynid->node, &drv->dynids.list);
+	}
 
 	return driver_attach(&drv->driver);
 }
@@ -780,9 +787,6 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 	if (retval)
 		return retval;
 
-	if (hv_vmbus_dynid_match(drv, &guid))
-		return -EEXIST;
-
 	retval = vmbus_add_dynid(drv, &guid);
 	if (retval)
 		return retval;
-- 
2.34.1

