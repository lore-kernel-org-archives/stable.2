Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916E2EAB6F
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311923; cv=none; b=S7Ki/8Je05pCZU2jXYxy04dB7iPWH/PSbKWciRW/oP6yqsU/gpTe5V8uuE77qwf0RbR5gjw/npQVlg0/AbRAxiglnGCZo85IQKacE7naQFGn7AyabplRnMr9gQciTTFri5OKciEeaUz3Y/QHtEdcZwEU1m81uYPEb8ukBTrV37E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311923; c=relaxed/simple;
	bh=JwnZL+YCwllclzay+NAvX531J2L0uvIGoYbc+fni1AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaTm7qvm3SVfRb9aHbuRazwsN3rxfpi8LWvKqoD1PPGkNf6/67VnwCv0Dy/PtTqaZr23TWTJswgWnlkohAWrQ7V/UrP61VeTpplT87TSZdbW8a2icRBp/AK1xDax1/+zfBzsMiApldtA8kiOhzDr4IZ2RW1+36j5/s1/BzieEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/ap5/Xl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/ap5/Xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736751F000E9;
	Fri, 17 Jul 2026 18:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311921;
	bh=fmR4VEhcoV4cTfcr6MRsWAiofxCIXhD3woZ+A7YVLhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F/ap5/XlBIOKv7ojNOSs1mKBpVLpr08K8G84hIqHvA3fizl87H541pe+gJbpZ31EE
	 SQpT0UTbjy0yYclL7Rxpf6XeBvUOIynma6G4N/+oTtH+Ei9HDsHzr0fBIX/MTUQmeM
	 0b1b8gtSK4UwpVt7bQc6m3OXv+pVpPBnPWhPpD4T05/Zx5RU6VtkiY3UVHbeo0Obt6
	 EfFqd8PiTjX8edXC0X6hVuXI9UXFTn3VSew90GmPNzs/9G9eCDZTvHE+9834+JgYPj
	 PI9RVHY5b5emG5+W0aU12oVSV0O/Fh8pv/i8gEmkQy8Hwpoiy6AZYjGH2Q+KTHA1+b
	 k3T8E3QBJ7yVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] treewide: Switch/rename to timer_delete[_sync]()
Date: Fri, 17 Jul 2026 14:11:58 -0400
Message-ID: <20260717181159.2086971-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071430-excavate-prayer-7d7c@gregkh>
References: <2026071430-excavate-prayer-7d7c@gregkh>
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

