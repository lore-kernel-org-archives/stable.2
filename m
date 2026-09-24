Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7BB38398E;
	Thu, 24 Sep 2026 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259236; cv=none; b=KrsRhPTDP1qarZK4tZjdZ4GMVJESKtIVixFh7VQwGOi920j9ZMH0pmm1bqDL3+X4H3Ywi0tuGCpf8HZVPigXTgixvGQDugPt9nS2fglp3drTYd23nJZuyz1dUq17leChIevdokiODqZpHpq8sC0WxsmIRixTriBhGV768cSgnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259236; c=relaxed/simple;
	bh=7jrN/kiBtovXwdcw5q3l5PM99etNWM5bre/IwH8kfy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WSEF5gdjuUQPe3VNEuWjmTTZjnmCWBXQ94kACJcuYgVVsmVAKAIUgs9cJFMO5u+sEersS987IBvEZaPK1rJ4NSPdmKK2DYcv72cA5Tmw6oAKEEufmZUU2GQILXXR68jgXChPtRv74v3NqmCjdfQQvSH8Z1MiuHuF0sh8ZBw46eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YuQDTQHm; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YuQDTQHm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=U2
	gefFVJgx/FzD23V4+y9PaoJuhGR4dGisyL4IkaCmI=; b=YuQDTQHmfMmSXSuSCa
	Dwtn/iY0IjSfP1vEw0UQxXhv9hnFKwDWIQg7b2UX8RZvyLg2yRRmv/RoNspAIbP/
	w5XAsKlYI1hWY4h/Sc7iE9lL27JccsKykAVhHlMyvc1I+TGPOR/9HrIcf67DlUdI
	5AfxiHM55nnFq+FYJIY26iJY8=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXN8sIMLVqBMA4Ag--.5098S7;
	Thu, 24 Sep 2026 22:13:36 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	"Daniel M. Lambea" <dmlambea@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 05/10] HID: logitech-dj: validate unnumbered keyboard reports
Date: Thu, 24 Sep 2026 22:13:20 +0800
Message-Id: <20260924141326.1154421-6-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924141326.1154421-1-yaojiale02@163.com>
References: <20260924141326.1154421-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXN8sIMLVqBMA4Ag--.5098S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1xur4fAFyxCrykJF45GFg_yoW8GrW3pF
	Z3trZ5t398tr18C3WUCw4rWFyfZF18ArWa9a45t34UZan0yFyDJrWav34Yqr13XrZ5tr92
	vF4FgasxCFyUZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pib4SwUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BAYUmq1MBBcggAA3L

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

