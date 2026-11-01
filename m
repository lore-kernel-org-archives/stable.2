Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793538506;
	b=PcfZQCNRK+33o4AqfBKM1Cs0ZTz/VhPu0QVRuvzelt3ArGw/e9NIC+eSZC7hdgW3VnkE
	 2UCNLqODGytN4NCudf1vrov3Icm5UV9xBHg41Z9Pq8cvFbKjXsVhoU+9VsPwuHZlvQ0HN
	 RirPQFDwH9ab1znAK4nolKWRu4eewVR80L5Se7FpQAWaiDa8zTFrxnEgLsmgt4UQ+t+f+
	 7Fl31CPJRaaRE33yjA3hOXV4RWdRK78NYNaOKIe927f/n+RZR6XKmq96Ha6h/aWLRcMfL
	 lKi57XkW5dqslseeqsoM7IJQjwEIYRd0sszzVJMabPSdfub8B4oOJXYu81EVOwY5SsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793538506;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=psa55x/910KFK/n533kR2hCP+mlHqk7uCQV8do1En30=;
	b=yIjcPK2zpfcluHc6OggGBRel3UtDcl49M7Ep0hZ1XPpyETaCwKnRDk0pC02iYkUFINNV
	 X9L1mnIEL8mrgI+ssK8YnMx4WKdIOI/UA2r4jPc2Fi7/mcd+pxm6TvR/COamq7dVJO1ZJ
	 9SU2+FvTIkzxpXW6HeDjsFDe1fAafJ+UkcSzbmEf62o4h9ezH2scicv9KsHShkUC9DaVX
	 VoDiLNNu8iXZrte3msrMrrz4TxvfRSMRPnv2Bk9Y9CAXZOyF8XcUjv1bHzCHnzEviLhb3
	 x+lfS+UnKUu7SlefEQRtjHfHllntm8ngE7zEhZziG/CRiiWXYfjbd+3AbgZfVsfjftA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RGCn6t6g;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A9606A324;
	Sun,  1 Nov 2026 13:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E8A9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RGCn6t6g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ps
	a55x/910KFK/n533kR2hCP+mlHqk7uCQV8do1En30=; b=RGCn6t6gROJvfz/IyJ
	jRZHFoJmMhcmeVAmRbqtObatTOdmOREgk7VFPvzOqiJ9cXfTmQUXrM4DYRmw+C/w
	NGl68C2Jr9EFgOzDTL/Rp7UHKJ4TtZMNKgY2VDxJNWcncKfr73Ln3YklIBmJjya8
	tTYdF22bfVdjs19UrO9VbKkOs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3n3ejOedqcRQPEQ--.25545S2;
	Sun, 01 Nov 2026 21:07:49 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: biju.das.jz@bp.renesas.com,
	wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cosmin-gabriel.tanislav.xa@renesas.com,
	Li Youhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] counter: rz-mtu3-cnt: put runtime PM ref if counter init fails
Date: Sun,  1 Nov 2026 21:07:46 +0800
Message-Id: <20261101130746.1724364-1-dayou5941@163.com>
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
X-CM-TRANSID:_____wD3n3ejOedqcRQPEQ--.25545S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1xXr45Jw17Zr13WF43Awb_yoW8XFW3pF
	4IqrZYkrW0qrWkCF4xG34DXFyYgw40yrW5WFy8G3W8Za18AFn8Z3WkWr4YqF1vyr95KFya
	qwn7W3WUCFyUtr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5R6wUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3gUMumrnOaWrOwAA3s

From: Li Youhong <liyouhong@kylinos.cn>

Counter enable takes a runtime PM reference before initialization but
only puts it on disable. Drop the reference if initialization fails.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Cc: stable@vger.kernel.org
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
v3:
- Set count_is_enabled from enable after either branch succeeds.
- v2: https://lore.kernel.org/all/20261031142813.2522444-1-dayou5941@163.com/

v2:
- Add Cc: stable@vger.kernel.org.
- v1: https://lore.kernel.org/all/20261008020506.211566-1-dayou5941@163.com/

 drivers/counter/rz-mtu3-cnt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 7bfb6979193c..e7fe8bf45164 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -506,14 +506,17 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 	if (enable) {
 		pm_runtime_get_sync(counter->parent);
 		ret = rz_mtu3_initialize_counter(counter, count->id);
-		if (ret == 0)
-			priv->count_is_enabled[count->id] = true;
+		if (ret < 0) {
+			pm_runtime_put(counter->parent);
+			goto exit;
+		}
 	} else {
 		rz_mtu3_terminate_counter(counter, count->id);
-		priv->count_is_enabled[count->id] = false;
 		pm_runtime_put(counter->parent);
 	}
 
+	priv->count_is_enabled[count->id] = enable;
+
 exit:
 	mutex_unlock(&priv->lock);
 

