Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.130.202.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795737231;
	b=bakPRSZT1nvlvHfzbjXsyGa3BRYUm1Ql+kLnAWzIojVSEtY5yW20/ZS9cyt6lSEDBweE
	 gg5wRh0uVkz3YUov9+xuM/BnQujXBwsduJE6OjZ2dFoYc38Y8kCpwHVsBzM3SlcGBGcw5
	 IOqwpPQ0bzUZ0Pe3JUSwkXyYZ2HxD0pPsyf6ZkGSgOhx89gdU/CC6njrGVDNi0oZyCX9c
	 uZZhtN4AvWylVFoedzxC2OchvS5uRVX9AENz+651Q8ESaqgC4d4odH4XxbGwu2U8a/vhm
	 xMJg3za5c6d9ekBGKWNLVYELC5Yd8/+qH24xDajQemTDwGYoOFdrjxJ5Mkejg/SUrZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795737231;
	h=DMARC-Filter:DKIM-Signature:Received:X-Iguazu-Qid:X-Iguazu-QSIG:
	 Received:From:To:Cc:Subject:Date:X-TSB-HOP2:Message-Id:X-Mailer;
	bh=OcM2LULAOi6qxaM87NYAThKYLj+/GA1+gZYocPXXOdY=;
	b=C36R59ySEcDaxpS/o6/E0QWRF0laWSi9UnRn1ztro/6R2WCeW7oZ910SN5Z4dukQbXrE
	 /KBqlnI/WFakRkX0s+UkYWABifj1+R2g9XgdY5D+YzqfT+j0X6eIoRlnQDo/LogsGVYKu
	 tVt1g+1OkhDIGPa80yVmJvVv/ihO8W4NiuTrDh8H2OT+hlVaVaYsu6l4DSy6JK58vnjlK
	 X9wdpuCu683l3lZnoOnWC9rua9pYekrnwtKoNEtMNg3ETueLbb+f+ADdT6WYgyK8si9Dx
	 8l7A+2KcrKeP0L7FVxEGrlwjEn0whF6/Rhh6UXSGUByyLY5AmfjmAHnYplnnA23OvPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.toshiba;
	spf=pass smtp.mailfrom=mail.toshiba;
	dkim=pass header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=W7BUSGxe;
	arc=none smtp.remote-ip=210.130.202.131
Received: from mo-csw.securemx.jp (mo-csw1120.securemx.jp [210.130.202.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9318606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 23:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9318606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=W7BUSGxe
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1795737198;x=1796946798;bh=uzN4QuyX6KxfZniptxkRWNJLwVPH2EvasOuIIEvC1SU=;b=W7B
	USGxeVyN0epMsJz2hV8Q11ctq4QnXozhGhWD5jpOZzp09RiNrRKXzbkKjJG7aRB4b+QQsbenwY1Rg
	+ahO8VaUdYiRt6FaAlLi7eLedlKbV7Oq1dWqzeFOA50g0h6m2oriJpNxxF6wJGxSBVrRbsjh14qma
	aK48dLK8K1p9X2GK6I1xAbx0NTqBBG3paghWWI5kPmdWcdxqQ7XHIdCqZXAzatRoK8Eo3KGCKvU0n
	YbulIr4aLxoQnxZKs5OKh7i6v3Dc31d4Wz8xxZZYViCbUlG/bK8whiuy4pBoDfh+OQ37dq8F7Cept
	00mT3f/Ozxgh/67sMSyhvjHXxT63tsQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6AQNrHSR3007845; Fri, 27 Nov 2026 08:53:17 +0900
X-Iguazu-Qid: 2rWhnX7phepKAsthlK
X-Iguazu-QSIG: v=2; s=1; t=1795737197; q=2rWhnX7phepKAsthlK; m=ERKqjAa3UUtY9sPUH23TWuLBUiyLkpkv3P1G0f9uzag=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jbCzd1mVxz4vym; Fri, 27 Nov 2026 08:53:17 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 5.10.y, 5.15.y] power: supply: cw2015: Fix potential null-ptr-deref in cw_bat_probe()
Date: Fri, 27 Nov 2026 08:52:54 +0900
X-TSB-HOP2: ON
Message-Id: <1795737174-18670-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

From: Shang XiaoJing <shangxiaojing@huawei.com>

commit 97f2b4ddb0aa700d673691a7d5e44d226d22bab7 u pstream.

cw_bat_probe() calls create_singlethread_workqueue() and not checked the
ret value, which may return NULL. And a null-ptr-deref may happen:

cw_bat_probe()
    create_singlethread_workqueue() # failed, cw_bat->wq is NULL
    queue_delayed_work()
        queue_delayed_work_on()
            __queue_delayed_work()  # warning here, but continue
                __queue_work()      # access wq->flags, null-ptr-deref

Check the ret value and return -ENOMEM if it is NULL.

Fixes: b4c7715c10c1 ("power: supply: add CellWise cw2015 fuel gauge driver")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/power/supply/cw2015_battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index d1071dbb904e..616d481f834e 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -686,6 +686,9 @@ static int cw_bat_probe(struct i2c_client *client)
 	}
 
 	cw_bat->battery_workqueue = create_singlethread_workqueue("rk_battery");
+	if (!cw_bat->battery_workqueue)
+		return -ENOMEM;
+
 	INIT_DELAYED_WORK(&cw_bat->battery_delay_work, cw_bat_work);
 	queue_delayed_work(cw_bat->battery_workqueue,
 			   &cw_bat->battery_delay_work, msecs_to_jiffies(10));
-- 
2.55.0


