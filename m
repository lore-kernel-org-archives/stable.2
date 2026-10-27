Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084244;
	b=MPBYolVLty7gugcVnnoyE8HUQIZ74Tx+t3OZelgM+WXUWDBwS2eoVPZa3lPEPYLQGSSQ
	 O3xahWewzV7P12YtDYF4oy7YdtTZuTB9VOY1Cv4MUWGluMz6n/4Pmq8J6NUsEujssuSlM
	 sDIiMBa6Q23Nh2BXR6a9Aj8FVhTP2AN3DqiwELrRNguqXzoPTySTS4D7x843cyp/NAabL
	 lS1V93KUDIQTaMO7twJov9mYXDSlohd3JfPdmDwWMIL9X9I4i3XD6/znUPFxgDcEUt5vp
	 vHnLsVZEWKy/FMkZnty3hC4UNh41sHiiTGJ1bemwhhKri6bdTOmLY0PrpcOawOy+F9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084244;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=PwCP5UyYPH4odKmTXXB7Wfe40ztBWuQkqosyPb4KfP0=;
	b=B2t/Yqnvd6pMj6Nb2aYTa4vYZaod7PI9oOEgxVRJEw5LP9MFbDWInK5Z/lO8M6CZcoBT
	 Vy3nddocGcRn3syKy5jc+T4ikaRobuNAnoqrPJMSI889L8r9vHRZLeatfWdoYLiz6xAwo
	 8+fQ38tLDh5B+Zfe9P5dWGL3QA3fjv5/xN560P6XGdMaVVaTdNIGkUjmu63d56qUCcbWq
	 59BuDhdui50NVakr5XUECXQiofa2v0Jbz/fl129OginGMXqNrQhcG0/hPQ9VIDQIYe0ES
	 tJKmSTN4uclK8rJnaJWgw+YK8TbbhV0Rr6CfFom3NTSoN9hOdqIj/MwUFFrp6cs+pdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RFkjpEkO;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC980606A31A;
	Tue, 27 Oct 2026 06:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC980606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RFkjpEkO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Pw
	CP5UyYPH4odKmTXXB7Wfe40ztBWuQkqosyPb4KfP0=; b=RFkjpEkOyILTmEHZbG
	K8+z3vD2JY0EB3e2IO8hlbEhTFs0SuKieCjKCTyo5if0dpsLlN34rm4ICML5wy21
	wq09g1JCOf2a///hv+dO3q5TJq83GBZXKB5plL36b6h4T1m2powP6F164ekQ4+ad
	KGB4mvJi2xtP6mr+y7k7gkNOg=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3f3srS+BqJPR6DA--.54486S3;
	Tue, 27 Oct 2026 14:56:45 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Kameron Carr <kameroncarr@linux.microsoft.com>
Subject: [PATCH v3 1/2] Drivers: hv: vmbus: prevent duplicate dynamic IDs
Date: Tue, 27 Oct 2026 14:56:41 +0800
Message-Id: <20261027065642.2280297-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027065642.2280297-1-yaojiale02@163.com>
References: <20261027065642.2280297-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3f3srS+BqJPR6DA--.54486S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur45XF4fJF15Xw43ZFyrJFb_yoW8uF1xpa
	1UurWayr18JF13WwnYvrWUAFyFv3yvg343KryDC3Z2vF1qyryq93yUJa4jvF9xt3y8WFnI
	vF48tr1rua1DZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNAw3UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQ2w6mrgSy1OdgAA3O

new_id_store() checks for an existing dynamic ID before calling
vmbus_add_dynid(), but the check and insertion use separate critical
sections. Two concurrent writers can therefore both observe that a GUID is
absent and add duplicate entries. Removing the GUID once then leaves the
duplicate active.

Move the duplicate check into vmbus_add_dynid() so it is performed under
the same lock as the list insertion.

Fixes: fc76936d3ea5 ("vmbus: add support for dynamic device id's")
Cc: stable@vger.kernel.org
Tested-by: Kameron Carr <kameroncarr@linux.microsoft.com>
Reviewed-by: Kameron Carr <kameroncarr@linux.microsoft.com>
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

