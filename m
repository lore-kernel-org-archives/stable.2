Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A653EFD10
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306307; cv=none; b=WYoCAiPWm6eKORWxot+9L+iCLzD+rH6v7Z+jVuQrzlXCi7AjQb1wokTBMuKziji11UlU7M04LfWkWiuAG1KNsPU81QqDWok1ZcLvIAdMEStC2unZC8cbnchzUBqudQmsw+TNIFBDJo4kKKyqltn3lMDbtaybjyUv7OG5YebKZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306307; c=relaxed/simple;
	bh=JwnZL+YCwllclzay+NAvX531J2L0uvIGoYbc+fni1AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMKYKiMw/MBcFKIW/LifJOXsZsuNN42ADSq7KeaApB8Wq/opVjqFEEe0jwQfiHEig8ebFHQQG2hTkOEp3fNHhjKYXrZii8ImWq2L5ZKBMNlkFnp2In6+uqENQ50zTI42ElunnkBD8Z2ObT92rbXQMSCEDm15tXUyc89k2Oxld2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQPu9WRX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQPu9WRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546501F000E9;
	Fri, 17 Jul 2026 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306306;
	bh=fmR4VEhcoV4cTfcr6MRsWAiofxCIXhD3woZ+A7YVLhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQPu9WRXpmBhqe1E+yh5cQd3LvfgJpdeQkOz/5WKAAIsSPOG457Xai6aJCJPgOFXE
	 k5ocXoUd+tn0P4kB0Z16zZiQdq//guCeAxjA/ZZ/7V+d3L4tdB9xPTdDhCpVVzW+Hj
	 2KUtU3Xo3wpxMdBdfO1Cnkd9XA+QPXvtC8nGXcYweFvmiXV2Uc5W4EucGn9OWIDM2K
	 JrxBu2E6/RzFce9w7X6DE381BckmQaiNXRZ09/t73UrPjuxqxOwJoXN0vYfo7kDqCj
	 zBmoftptIbMNymFJn4qBOQdo6tmnv1qsxtM5mbDft+L8/W1mhn5pP0qmsnsTvguiPH
	 kik/TQA66I0Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] treewide: Switch/rename to timer_delete[_sync]()
Date: Fri, 17 Jul 2026 12:38:23 -0400
Message-ID: <20260717163824.2035351-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071429-omega-envious-4fef@gregkh>
References: <2026071429-omega-envious-4fef@gregkh>
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

