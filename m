Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82103C10AD;
	Thu, 24 Sep 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260207; cv=none; b=VMji3yje7bXnE5g0y+lNYzaSLy+/zFqpxDEx854thUNS/Fw2E7AJ8+/mYlXNfcHJMaPMYNVKVPRA3H3TISVbTfNM5IN7uXmrZS16zRX0HKY96LkS3h95I73Onb1hbb2d0CUgvxmqKSnv4xM62R7LoFyrP3/8334jWrPwJbBfzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260207; c=relaxed/simple;
	bh=awIeCVqTxD+VXZkiWR4ELN8NW1J9Z8AMPlTGdgIresU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DjJ9HObC6s3458JFO/3JGaV1LSWB8R3+7j+X9AAgYMKizMHcQ8LlVigKuwUg65BGcnfkTy+mla4MvqLfv+BlZ3hmV1wV6FntFj0vsPDSNglU8DoUzbzxJskgikDMBXjmGEkiu/lkWERTHYbjIE1i8+yeZPkNuyn7520EYCJwZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jLHBWRKB; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jLHBWRKB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bJ
	4wD1M3yh8esHOH7BpCtPCCSuetB8Vl3QW6xcMcCFI=; b=jLHBWRKBWLq+ynRzHH
	cIcaghwpAFVw/U1EpDFJVaI3qdn/uFnPfPkSnK5FVI0p2gqsHjjNDxjdIAdZ6wVQ
	K2V8YyfAkMtpel1r03hFAX0Y8Fn4UgqI8ppJ9zhCRWfs7TgqP9rMvvC8Qz0MdTMm
	7K2oDIsN+4DTSFfi/IbmEMAno=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v7zAM7VqMhFPAg--.56297S9;
	Thu, 24 Sep 2026 22:29:50 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 7/7] HID: roccat: savu: reject short special reports
Date: Thu, 24 Sep 2026 22:29:17 +0800
Message-Id: <20260924142918.1177952-8-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924142918.1177952-1-yaojiale02@163.com>
References: <20260924142918.1177952-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v7zAM7VqMhFPAg--.56297S9
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryDurykJF4rKw1DCFy8Krg_yoWkKrbE9a
	45uws7Wry8CF4vyr1rtr4Svr9xKw45uFn3ZwsFqr1fJryDA3Zrurn3t3s8C3yUWrWv9a1D
	Crn0y3WI9rnavjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRLa93tUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8B4MRmq1M96tngAA3l

The raw event callback runs before HID core validates and zero-pads the
report.  It passes the buffer to a helper which inspects data[0] and, for a
special report, reads the complete struct savu_mouse_report_special.  A
truncated report can therefore cause an out-of-bounds read.

Require enough data for the special report before calling the helper.
Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw-event length validation to hid-asus.

Fixes: 6a2a6390cf09 ("HID: roccat: add support for Roccat Savu")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-roccat-savu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-roccat-savu.c b/drivers/hid/hid-roccat-savu.c
index 679136933560..cfd86267e35b 100644
--- a/drivers/hid/hid-roccat-savu.c
+++ b/drivers/hid/hid-roccat-savu.c
@@ -182,6 +182,9 @@ static int savu_raw_event(struct hid_device *hdev,
 	if (savu == NULL)
 		return 0;
 
+	if (size < sizeof(struct savu_mouse_report_special))
+		return 0;
+
 	if (savu->roccat_claimed)
 		savu_report_to_chrdev(savu, data);
 
-- 
2.34.1

