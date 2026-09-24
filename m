Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE5384CC3;
	Thu, 24 Sep 2026 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259233; cv=none; b=CBklRIWrOTLheRL7FEXTznAb2RtnyWkxXpKa1GHJHJsRUECrUozfHqnWVd2hZhmk1FhjULwKci1JqE1ocmEA97Ku6WuRn4bpyEJY4JF8yGZJPGtYt90i70UNd1FP6Co57ncxoZWx8YYuDCMux3wbEHnTJUpD0fK0fg4IiEHr9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259233; c=relaxed/simple;
	bh=8GJVh8zyxnT5u0h4IreF5rD+qZqANbXKz98OmJ810PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzkB8C9+f9f9L+YwtFzED7Fds9IYGYn2YWAYSHF18dscD5MJA8PKCh1kNKJPFKUriqaVsOjlczX7kdt0PMXRrJ12uWF3NLZB8r2pKuwHCPwqPFESBclcurrJIo/wMuEBQPTdCkKT81cgA7P0dDUQg0W2adkWLeh96pzE6fQoVWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eNIQyNPD; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eNIQyNPD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=X3
	B0WsYGwWxeNRan1ARn3/d6wJOVWNtlnr5O1j4FW5A=; b=eNIQyNPD0HMNVzG/tN
	ep7iBe8kPsil12NByxOEAIfidff8xSbulnv1tdyAL9Bm+4haik8zoR1JuCCch4Rk
	vIOD3mCVP6dEgfoLGDMlB0sWTe3BeHzdvfkq07ajBR90P4ytsiHuBnKT/jViWd2p
	xkUy/3qGdrHWpPqyQAXJ6/8GU=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXN8sIMLVqBMA4Ag--.5098S4;
	Thu, 24 Sep 2026 22:13:32 +0800 (CST)
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
Subject: [PATCH 02/10] HID: cougar: reject short special-key reports
Date: Thu, 24 Sep 2026 22:13:17 +0800
Message-Id: <20260924141326.1154421-3-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDXN8sIMLVqBMA4Ag--.5098S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy3GFWxXFWxCrWxWrW7Arb_yoW8GF4UpF
	s8tr90krZrtrWfuw1rGw1UCFyFvwn5JrW29FyrGw1Fvwn09FnIgay093sFqFW5Zw40qr9F
	kwsrtrs5uFyDuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR1q2tUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wwXUWq1MAxX5wAA32

The HID core invokes raw_event callbacks before validating the report
length.  cougar_raw_event() reads the key code and action from offsets one
and two without checking that those bytes are present.  A short report on
the special interface can therefore cause an out-of-bounds read.

Consume reports that do not contain the action field before accessing the
fixed offsets, consistent with the callback's handling of other reports on
the special interface.

Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw_event length validation to hid-asus.

Fixes: b8e759b8f6da ("HID: cougar: Add support for the Cougar 500k Gaming Keyboard")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-cougar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index ad027c45f162..7156658166f5 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -270,6 +270,9 @@ static int cougar_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (!shared->enabled || !shared->input)
 		return -EPERM;
 
+	if (size <= COUGAR_FIELD_ACTION)
+		return -EPERM;
+
 	code = data[COUGAR_FIELD_CODE];
 	action = data[COUGAR_FIELD_ACTION];
 	for (i = 0; cougar_mapping[i][0]; i++) {
-- 
2.34.1

