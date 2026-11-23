Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429428;
	b=UqBC/xy90o7DsDEjfIO7vjTDp+5e2lnPOH2WKXDkqgFH4MgD5rX1xYnIjufN5vJJNrCq
	 Nie5Q03zIuGDKGVwi75slRHzSIqvDSFR5LLIBs8dJi/+2XPTeWEBPhhBNYmuN28i39f1V
	 momw4zKN3WGePEAs5VLAAO+kTGcbbAtRIIuIdICPOP53PUQRS2Y19gXwr3f+B4Gi9KNnY
	 my2DxxbNveN/zlTmAWln4YA1oJbLg+iKzSW7tJq/NYoe0CrGnW12Y108aCO3tK7kON99v
	 K7uY2MTXvXVHHo6YDRB/MHhpB/C8EzesrLlp3UYdwoIB+QbBzbdAE0KPrvZ3MPe80lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429428;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=mfpoO1fOKw002k5IcVOKkLSprH7dDwx/j69Zlno5YF8=;
	b=mN5lbuRtRQTZXFh+eBfV8L7ghYiq+av8OK7/yCW0jvYqt5MMcMngBPe/w3jtZnBhazQM
	 h8L1iwIsCj1GOjBfzbQjVeERa2vDp19Bnc4xWLtCHTSIEzh54rAtj+Jjbvak8sxhMY3Xe
	 9/nlwdzp9Ufb0QBcvzKl0TmvdwzEpMe8yT/7h6rftfujrISNoXDHfzCDcc6ykNJGeZa1f
	 QGr1c+bwaba5Cpfil68wHZIpySYIjf80vh4tv+OUpj+thLuefsf/5J5SRqoK+kYbY6TW6
	 mCU1mR2XkDfoZFvGDoLyNgTQ96z17yawkwNIjV3aT3qLdaLFmVYgIZ+blqZTaNyGHcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dYNPuCq1;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF3606A31A;
	Mon, 23 Nov 2026 10:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61CF3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dYNPuCq1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mf
	poO1fOKw002k5IcVOKkLSprH7dDwx/j69Zlno5YF8=; b=dYNPuCq1WwgvLoLOkA
	sz0vINwfVruTJrMAL3Ku9wjhAMqb861dHH78pNKHYRlIDbWH/VXQJCdk1/tiSqkx
	J57T6imXTcBCunncrxDshSgWmuGG/593qnAEc0d2sVhEXQom8rUBYHBTNo/yfORO
	xS7mFi96RX/9DHerUip8dT400=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD316MbFARr7drKIw--.29626S2;
	Mon, 23 Nov 2026 18:23:24 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] soc: qcom: aoss: fix cooling device registration cleanup and lifetime
Date: Mon, 23 Nov 2026 18:23:23 +0800
Message-ID: <20261123102323.8635-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wD316MbFARr7drKIw--.29626S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF15uryUZr4DZr1fuF43trb_yoW5AF1kp3
	W5Ja45GrWjqr47AF90qr48Wa4FvF1Iy3y8Z34UK34UKF1rJa43trykGFy7JF15WFyIka1r
	Xr4aqr1I9Fy7XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jW2NtUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7hznOGsEFBz+LAAA3Y

qmp_cooling_devices_register() frees qmp->cooling_devs when no cooling
devices are registered or registration fails, but leaves the pointer
non-NULL. qmp_probe() still returns success in both cases, so qmp_remove()
later walks the freed array.

The error path also unregisters the failed slot because count is
incremented before registration is checked. Moreover, cooling devices
are registered with devres even though qmp_remove() unregisters them
manually before closing the QMP channel.

Clear qmp->cooling_devs after freeing it, increment count only after
successful registration, and use unmanaged registration so manual
unregistration remains the only release path. Skip removal when the
array is NULL.

Found by LLM-assisted static analysis. Build tested only; no runtime test.

Fixes: a89f355e469d ("soc: qcom: aoss: Fix the out of bound usage of cooling_devs")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---
 drivers/soc/qcom/qcom_aoss.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 2d248c7be..b9ae12685 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -381,10 +381,9 @@ static int qmp_cooling_device_add(struct qmp *qmp,
 	qmp_cdev->qmp = qmp;
 	qmp_cdev->state = !qmp_cdev_max_state;
 	qmp_cdev->name = cdev_name;
-	qmp_cdev->cdev = devm_thermal_of_child_cooling_device_register
-				(qmp->dev, node,
-				cdev_name,
-				qmp_cdev, &qmp_cooling_device_ops);
+	qmp_cdev->cdev = thermal_of_cooling_device_register(node, 0, cdev_name,
+							    qmp_cdev,
+							    &qmp_cooling_device_ops);
 
 	if (IS_ERR(qmp_cdev->cdev))
 		dev_err(qmp->dev, "unable to register %s cooling device\n",
@@ -410,22 +409,25 @@ static int qmp_cooling_devices_register(struct qmp *qmp)
 	for_each_available_child_of_node_scoped(np, child) {
 		if (!of_property_present(child, "#cooling-cells"))
 			continue;
-		ret = qmp_cooling_device_add(qmp, &qmp->cooling_devs[count++],
+		ret = qmp_cooling_device_add(qmp, &qmp->cooling_devs[count],
 					     child);
 		if (ret)
 			goto unroll;
+		count++;
 	}
 
-	if (!count)
+	if (!count) {
 		devm_kfree(qmp->dev, qmp->cooling_devs);
+		qmp->cooling_devs = NULL;
+	}
 
 	return 0;
 
 unroll:
 	while (--count >= 0)
-		thermal_cooling_device_unregister
-			(qmp->cooling_devs[count].cdev);
+		thermal_cooling_device_unregister(qmp->cooling_devs[count].cdev);
 	devm_kfree(qmp->dev, qmp->cooling_devs);
+	qmp->cooling_devs = NULL;
 
 	return ret;
 }
@@ -434,6 +436,9 @@ static void qmp_cooling_devices_remove(struct qmp *qmp)
 {
 	int i;
 
+	if (!qmp->cooling_devs)
+		return;
+
 	for (i = 0; i < QMP_NUM_COOLING_RESOURCES; i++)
 		thermal_cooling_device_unregister(qmp->cooling_devs[i].cdev);
 }

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

