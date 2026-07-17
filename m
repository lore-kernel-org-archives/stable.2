Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9853B14DE
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300106; cv=none; b=g1SUbWAZ8YncYwh7vG5T/yS4Aabcam+bPrlV4zhDM1Pq/4RXoCDJaaTbpaA0/6vxEW7bfuipbzSEnHqmXWKXwE7NoWUBWxCIYcHZmRk9QXtIEB0sQcdS7MXoBc8RmIuVXQANbB9m23/emcdlt1bkdWhrmqfqDCcBSzhI/0EWQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300106; c=relaxed/simple;
	bh=JwnZL+YCwllclzay+NAvX531J2L0uvIGoYbc+fni1AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbMWXKJLuBtlb02NSOYqCaFlXuxqOR8l4uwN1jEMdEDNmBJKO75xxt8523nbd7nKYux30Yu6m0duUseVNtYLP2tHQEFtvBpLi8R4Q8+xhin+EKxdXun+4ZY+jljUKrI+C1+YyIyFbT6DbM86A1EWekszP4uQXKUCPxt6D+t+6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2qBTpJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2qBTpJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8EE1F000E9;
	Fri, 17 Jul 2026 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784300104;
	bh=fmR4VEhcoV4cTfcr6MRsWAiofxCIXhD3woZ+A7YVLhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C2qBTpJcQN/9HtLceFDUCRoBUu4KqSgNs2NPURCnRomN+HvTgtQ5w0vr8BLjwOWuZ
	 uRD0myJ9ZAuKplRpv1K9p+Zn3Zknqs/p9nXofw7joCw+G9XOpFnFUQ2ySoELte8tzs
	 4IsBaln+xKHTJaBu5diofLDJQhIF7eJn/oiKF5Ev4dH8t4CSpmS/lMZtL9th6L+iZa
	 bb2iK86O/xZeKm9N5nZA2du/4zXoER5nQ8yuOqI132da6PcbpJ27+DuFCtn9WyB4Xj
	 2cQO+yS0efpyL7IFnJPynz1mbi//EmOc403XjfAn4X2ETrxKAyE01PMTGQnDQ65mBA
	 fUHTwZE9+OnNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] treewide: Switch/rename to timer_delete[_sync]()
Date: Fri, 17 Jul 2026 10:55:01 -0400
Message-ID: <20260717145502.1925738-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071428-footless-stunner-a722@gregkh>
References: <2026071428-footless-stunner-a722@gregkh>
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

