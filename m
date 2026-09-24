Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41A48D899;
	Thu, 24 Sep 2026 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261135; cv=none; b=t4ia5uSX/UlLI2VWOVwxuxVMiB6wjpm/pCdhx4sdrGhW0/GpuRem6dwZFh+4kumXdbhT0miMRo4d/OTeGMgFxFdESEaUl9NqL74N3TaNQXokZtMcvWFvaFLSFJ1w7VMVafpiorQJhAv4COQZJC8hdGYikaXkTa853eEEdmlr1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261135; c=relaxed/simple;
	bh=7jrN/kiBtovXwdcw5q3l5PM99etNWM5bre/IwH8kfy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHnPIrBj3reZO30jFkkW4XzuzHlWrRrKV3XBfS/ju7FgE4bgCALtgPkrR21zKk+z7wQpMLBNt4Z/lklPlh8W4vjGTrmZ4m23kOV8Ygd0zDaaAbb0k/eqOG9XQsaVzjss5P/Sf936Ha5OJdlp0f8CGceLCPG+zwulx+rBdFjJRKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PZocf0HQ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PZocf0HQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=U2
	gefFVJgx/FzD23V4+y9PaoJuhGR4dGisyL4IkaCmI=; b=PZocf0HQBUZ+t9bN1d
	1a2kZW9GymJx90YblSU67bs3kLD+KNCnV9wkcUcHJ/aHvbzF1+M6EvAsr9awAaWK
	KbzrIz4ofEps7Ph3jcsOgSteeQEW8t1h8SaintF9GLkrzFmoSMPrNUJ/d34A+aIL
	UWFtAFI0kRNkmoh7XknJ83bPw=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD330ZHN7VqyTtKAg--.25624S7;
	Thu, 24 Sep 2026 22:44:31 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 05/10] HID: logitech-dj: validate unnumbered keyboard reports
Date: Thu, 24 Sep 2026 22:44:08 +0800
Message-Id: <20260924144414.1192037-6-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924144414.1192037-1-yaojiale02@163.com>
References: <20260924144414.1192037-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD330ZHN7VqyTtKAg--.25624S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1xur4fAFyxCrykJF45GFg_yoW8GrW3pF
	Z3trZ5t398tr18C3WUCw4rWFyfZF18ArWa9a45t34UZan0yFyDJrWav34Yqr13XrZ5tr92
	vF4FgasxCFyUZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMoGQXUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzg-oI2q1N09M7AAA3N

The HID core invokes raw_event callbacks before validating the report
length.  For an unnumbered keyboard report, logi_dj_raw_event() uses the
second byte as temporary storage while prepending a report ID.  A one-byte
report therefore makes both the initial write and the later restoration
access data beyond the received report.

Reject unnumbered keyboard reports that do not provide the temporary byte.

Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw_event length validation to hid-asus.

Fixes: 74808f9115ce ("HID: logitech-dj: add support for non unifying receivers")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-logitech-dj.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 1d619d2345e1..ce5e0f7218b8 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1813,6 +1813,9 @@ static int logi_dj_raw_event(struct hid_device *hdev,
 	if (!hdev->report_enum[HID_INPUT_REPORT].numbered) {
 
 		if (djrcv_dev->unnumbered_application == HID_GD_KEYBOARD) {
+			if (size < 2)
+				return false;
+
 			/*
 			 * For the keyboard, we can reuse the same report by
 			 * using the second byte which is constant in the USB
-- 
2.34.1

