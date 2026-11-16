Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794801303;
	b=n34bjaBZudKXBmV7LJmRksQx560QWUf5auedRGy253OLg/C9u3kh0d8GPVBszle8snPP
	 S/OBBtU3U+oLjTyyaURI45ZfoE4Hf8tiLv3jm47FLdaw3DD1//sDb+G6tZb8QSRKhCLoo
	 +L0YDjJvpeYadbFnbrdOPREh6VGBb301O2bdFJZV66f8JPCFMmlM0oHKJYERtkT95lnw1
	 Oc8ujLjoTfwcq3bjSt7NpjFp9sBafkxca++a8UdzpSvUceP2Th6cb3NnWut9ozOZznXY2
	 Iwp3/29fKB4kFuqUoVQRWqfiILgylRD9S3t1B0cKWlawuoRlCfPjFhDyxgVZ/rDfV7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794801303;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=XVo8cX/ZclE2JZLJ5Sy4t7M6wxCXh5CPKIlg5JJkfRI=;
	b=Pi4g10Fz+UFumV/4VEz2nuh/p5m08+204QAU4qmHEhMOVBEO3MiqQDLQeR9FE2Ce7g+0
	 eWoOVTwCYtCWOCe7n0TbK4XdMgBzssSmWv/UpsRMKTbvZ/oL4uDrRe2FZKlEsK8SlchGc
	 c32tZWTykdmGe/Gpi3vIW91cBdFIu69elD8I6jEgGPXVeCM7jiCKgVP3TicsS3VREMQhk
	 INwn0UYRxwGAsPijk0vPNgQ8syvWeRqfYkgRZofEmZYiZ9MVxvmT5q3feKHqc7vQptSdW
	 6PRVVJhpz/tR0RC8kQ/hhzzE7NvnjgDqg2kGGTu8FrrWWetxcmHHse3FC8cgWQy4bww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=R7sLG4T9;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6B606A31F;
	Mon, 16 Nov 2026 03:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3B6B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=R7sLG4T9
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XVo8cX/ZclE2JZLJ5Sy4t7M6wxCXh5CPKIlg5JJkfRI=;
	b=R7sLG4T9vY049yplmjnT6eRystNU87CIO2ZCQLt+aQXGzOQlCmADTVHSxbU6wvUSHp9FGtCUF
	ZdY0OpNctAk7BW91JZ/ymjVka4sZSTT7t8+ilaMcOvTGrKFfLDRdbudEUJn+S2sSzMK7JTVuSYT
	LTkTzqbkQdVVovu5MIdlxoY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jSYrs35q8z1T4Fp;
	Mon, 16 Nov 2026 11:54:21 +0800 (CST)
Received: from whupemk300003.china.huawei.com (unknown [7.152.185.49])
	by mail.maildlp.com (Postfix) with ESMTPS id EB55B40561;
	Mon, 16 Nov 2026 11:54:57 +0800 (CST)
Received: from huawei.com (10.50.87.204) by whupemk300003.china.huawei.com
 (7.152.185.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 16 Nov
 2026 11:54:57 +0800
From: Zhang Yuwei <zhangyuwei20@huawei.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>
CC: <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <chenjun102@huawei.com>
Subject: [PATCH] i3c: master: Skip IDR cleanup if bus ID allocation fails
Date: Mon, 16 Nov 2026 11:53:17 +0800
Message-ID: <20261116035317.132490-1-zhangyuwei20@huawei.com>
X-Mailer: git-send-email 2.22.0
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
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk300003.china.huawei.com (7.152.185.49)

Since commit 9d4f219807d5 ("i3c: fix refcount inconsistency in
i3c_master_register"), an i3c_bus_init() failure is handled by dropping
the initialized device reference. This invokes i3c_masterdev_release(),
which unconditionally calls i3c_bus_cleanup().

However, i3c_bus_init() only assigns the bus ID after idr_alloc()
succeeds. If the allocation fails, a zero-initialized controller retains
a bus ID of zero, and i3c_bus_cleanup() removes ID zero from the IDR.
If another bus owns that ID, its mapping is incorrectly removed, allowing
the ID to be reused while that bus is still registered.

Initialize the bus ID to -1 before attempting allocation and skip IDR
cleanup when the ID is negative. Keep the put_device() error path so that
the device reference and firmware node reference are released normally.

Fixes: 9d4f219807d5 ("i3c: fix refcount inconsistency in i3c_master_register")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yuwei <zhangyuwei20@huawei.com>
---
 drivers/i3c/master.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 9928c5dffb5b..39363c097682 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -523,6 +523,9 @@ static void i3c_bus_init_addrslots(struct i3c_bus *bus)
 
 static void i3c_bus_cleanup(struct i3c_bus *i3cbus)
 {
+	if (i3cbus->id < 0)
+		return;
+
 	mutex_lock(&i3c_core_lock);
 	idr_remove(&i3c_bus_idr, i3cbus->id);
 	mutex_unlock(&i3c_core_lock);
@@ -532,6 +535,7 @@ static int i3c_bus_init(struct i3c_bus *i3cbus, struct fwnode_handle *fwnode)
 {
 	int ret, start, end, id = -1;
 
+	i3cbus->id = -1;
 	init_rwsem(&i3cbus->lock);
 	INIT_LIST_HEAD(&i3cbus->devs.i2c);
 	INIT_LIST_HEAD(&i3cbus->devs.i3c);
-- 
2.22.0

