Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489334A33
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300407; cv=none; b=u8JGPOR6ENDkO31BrGNa+BRIooJn7QXZ7N9OKQPD9l8a3H2vdkf7mt0Y3HKu+6JviBQehrkmUiZOwHNADzIqtqPM1Jt1jNKMbtqHwopGvKJ1g7BHpXW1VM5DRA/PuLc3M/+UoFhoX3XUyo9G0tFsd2OD0iXSnOT+qKHAfKOzMXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300407; c=relaxed/simple;
	bh=JwnZL+YCwllclzay+NAvX531J2L0uvIGoYbc+fni1AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrTlXm0SiaEtp1DaPe/Sla1+kCEJtCcm53abiWdeHjqSwIbvVzSa/C90hrf7fHv+dtZ3Xy+A8Bxz+tEBrP8AoP7LPektKddF5B6eogprolCJPiDfqfW1EYn2niuv+NEfvCNgx4TS3wq6t9fy0rLV8wF9rpBj5zXae4ZFi6FRrMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAPpwIkJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAPpwIkJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BEB1F000E9;
	Fri, 17 Jul 2026 15:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784300401;
	bh=fmR4VEhcoV4cTfcr6MRsWAiofxCIXhD3woZ+A7YVLhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OAPpwIkJ9+1lNkMzL0szDXFraftZjTFt9wGXo+xFXgwthjRw2eTMzoXIqwSA1xd76
	 +jYoEuW4JO/MTrL2I3IT48+xrEW5hQSlAiSk6oR3YA3WX3phe/Xn7QOExCogkvIjRL
	 FjYyMKHSCdEEawZGiHz9OLXi436fPFQoTJfBjgFiIyWVata4bItJFJJf5gbjimvJwM
	 7dnfR+guabUGcDjYIbQ9otBJk0XrKmL2I/y9BmYo4ihU/5TY2z5fgCG2qSPZTCAqyl
	 HG5EbLATmAIlVMLypr+SY1xgGzC+73vPfXfcr+bxqsENSJWS44owY/346e2U5w1Z7j
	 Fp6mTZ0/oid5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] treewide: Switch/rename to timer_delete[_sync]()
Date: Fri, 17 Jul 2026 10:59:58 -0400
Message-ID: <20260717145959.1930377-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071429-oblong-grunt-47d0@gregkh>
References: <2026071429-oblong-grunt-47d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 8fa7292fee5c5240402371ea89ab285ec856c916 ]

timer_delete[_sync]() replaces del_timer[_sync](). Convert the whole tree
over and remove the historical wrapper inlines.

Conversion was done with coccinelle plus manual fixups where necessary.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Stable-dep-of: 75fe87e19d8a ("HID: appleir: fix UAF on pending key_up_timer in remove()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-appleir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
index c45e5aa569d25f..bb7db9ae41c249 100644
--- a/drivers/hid/hid-appleir.c
+++ b/drivers/hid/hid-appleir.c
@@ -319,7 +319,7 @@ static void appleir_remove(struct hid_device *hid)
 {
 	struct appleir *appleir = hid_get_drvdata(hid);
 	hid_hw_stop(hid);
-	del_timer_sync(&appleir->key_up_timer);
+	timer_delete_sync(&appleir->key_up_timer);
 }
 
 static const struct hid_device_id appleir_devices[] = {
-- 
2.53.0

