Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793456922;
	b=bl8dABK5FhIUbJFxEf0V2MBLpGUKQyC/AzWh72x/kKQm3KK2jPCzr6QpIuDbSsA2gy2i
	 otx5SgqrM63c7ZSAwQRvbUqCa/+t5tMdYbIHctQHIdSYG6SSbuQCSv8XkiFd5TSLFkCnC
	 BgYTcMK8WC7iHVOj5rFfKOe3FVQUDwplIltvE5Xof/wzxAbP8MKgVyzUgZndYS1Iu2Ux7
	 I6o5mPwj3PTwkWQdmFbTKEEHj6YQDbX4QzGxyNydsR9+7rsch7JBl4WNitzkWzPmC4Q3p
	 25zRyUP1wjF0OhsU2pk6Tmq2wq08CHrU3XQbGjqTx3icA0lacscGrDkoTzeTqgjz+vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793456922;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=1KhEjBbS2PxEW961tuGY+mC3rr8BuX8rY+suSCsiUYo=;
	b=2kfW4GeH0HjfXBwxOlK6XLOwHx1ulnPIUxN7paHAQwQR9zo/T+2B1gR6FmoesGAwbyK1
	 KAhFf/zluX1PWLwbHRTSHR0ExjjS0nJks3hUO8FwjCbjXLE3t996YcQC/Qo835wvh8mhT
	 lJ+Bz86WRsMLix/iKlcg/ga9JYIu4ihXGgqZ5mK4HYZswY9XymPZuRVGYQ9DC4YgY+wVw
	 QLDAccv3eODKKUhNwG298fcRE7erzSaY34Tn/o81cTSwjyZUXAzCgmAnsLEkW9FTc9dMK
	 2wT1xdO/JtsIaIPQbrbCTTfnzgU25NI22ijs/7ZTqqGhwVrN1nhm0D22pZ80U1DEp+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jDVFHp9R;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1FD606A31D;
	Sat, 31 Oct 2026 14:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB1FD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jDVFHp9R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1K
	hEjBbS2PxEW961tuGY+mC3rr8BuX8rY+suSCsiUYo=; b=jDVFHp9RAeq6ZVsR8N
	3CV6cu9eLBtrxTaXeS5b4et1mdeZ5gB3YOQvw2d9S3rjf9gg8oRJ5SItdfBXLd9Y
	06pdAndN1tddOQPv7p0x1YlHD8nhzLfeeVZu6/sq/glhcsPYifnfJ63ang8SadZj
	vG02iybI6+a2FvdWLk/H6KhEM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgB30HEA++VqtTNjCw--.5261S2;
	Sat, 31 Oct 2026 22:28:17 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: biju.das.jz@bp.renesas.com,
	wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cosmin-gabriel.tanislav.xa@renesas.com,
	Li Youhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] counter: rz-mtu3-cnt: put runtime PM ref if counter init fails
Date: Sat, 31 Oct 2026 22:28:13 +0800
Message-Id: <20261031142813.2522444-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:PCgvCgB30HEA++VqtTNjCw--.5261S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1xXr45Jw17Zr13WF43Awb_yoW8GF1xpF
	4jqrZ5CrW0yrWkGF4xG34DZFyagw40yrWrWFy8K3WrZ3Z5ArnYv3WkWr4YqF1ktr95KFy2
	qrn7W3WUCFyUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5R6wUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3gITwWrl+wJWywAA3l

From: Li Youhong <liyouhong@kylinos.cn>

Counter enable takes a runtime PM reference before initialization but
only puts it on disable. Drop the reference if initialization fails.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Cc: stable@vger.kernel.org
Reviewed-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
v2:
- Add Cc: stable@vger.kernel.org.
- v1: https://lore.kernel.org/all/20261008020506.211566-1-dayou5941@163.com/

 drivers/counter/rz-mtu3-cnt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 7bfb6979193c..61fbeb122851 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -506,8 +506,11 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 	if (enable) {
 		pm_runtime_get_sync(counter->parent);
 		ret = rz_mtu3_initialize_counter(counter, count->id);
-		if (ret == 0)
-			priv->count_is_enabled[count->id] = true;
+		if (ret < 0) {
+			pm_runtime_put(counter->parent);
+			goto exit;
+		}
+		priv->count_is_enabled[count->id] = true;
 	} else {
 		rz_mtu3_terminate_counter(counter, count->id);
 		priv->count_is_enabled[count->id] = false;
-- 
2.25.1

