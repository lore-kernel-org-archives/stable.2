Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695309;
	b=4ZI9OnzZ5p5qmTbN+toyQ9mGvdoEYakXbkTPdrxQzpxBaJT1MRl3DQuRlWhg2Xf0dzdX
	 wJ3uHrwXUPuqQxmHMncK+oGKThXqtmURwkB/mozd/cS27ZRVKZv5fqttUE5Y9Ql0Gkzpc
	 +1uzYcb/rvqxNr9zQT2K46WH8qm8usa7ICBb3Rhce6oiAVEtXVXsm1HeXP7gKXpEUqKN+
	 MemOv/lJIb3sZeAx+93rsOsTRu1qyX9+AynAwnpuK+CkXZ53GNf12NZfWHl7vn5f7jb2B
	 YmXLZurpHielpkwCcD56kJTPduAJj84QohshMewmu14ob7jGs7bVJ+82SP78tOJVjGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695309;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wnOygQfSWno4QPM14hpop/ZAWYYTiXmnGCUHEc3ZDDc=;
	b=D8BspUEGczHcViTTJyYGttkMlZsbWNJw/eJ2PKMt4XFmEdynvob0FtI2RELu5sdmokba
	 CTHVSgf84LO+DBkQlgYiAFFTsz5LQNcFBMnOp6g6l43RImJI3q1+Fn7VkpMZIoOgRGSMQ
	 Lil3kcoZ5TY1CNnc+XUIIYqyOhsyp7pKIa00Rwe88A70q1yJvbXmToyCsr1u0M+qUiedY
	 /hgPHX4Z1Sl2K1PcOgrCpzXHb6UMmKklRJZzF4roIwRSD9zRMY0OKXYgGUVn+0fHGqSL4
	 3MKYwwWx2U/Wy4UZaDJJsl1hcUVWlTQj9VWqkshQrVBTLF1LN/XJrOsGtuZeB1plABw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="cvP/kpPv";
	arc=none smtp.remote-ip=115.124.28.77
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8D606A947;
	Tue,  3 Nov 2026 08:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E8D606A947
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=cvP/kpPv
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793695299; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wnOygQfSWno4QPM14hpop/ZAWYYTiXmnGCUHEc3ZDDc=;
	b=cvP/kpPvUOmT2i9udi0kPf/0liRk2cH5HQ4BMPvcQ+ZX8y6Cf8f6aoCpI00D9TfTuN4OJ+ujzoykGP4in42WSkW+lfcRCNDV5tIUSNosf5LanjoANz7ZhI5G/SxXIXnA+iOT0ozmOlioyQTbxZYfnmfslnaKCMK4e1ACXaqi0mo=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2593157|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00933782-0.00124026-0.989422;FP=18250523093982794882|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034138;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jvUy9Fw_1793695298;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jvUy9Fw_1793695298 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:41:38 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH] Input: cyapa_gen3 - clamp the reported finger count to the array
Date: Tue,  3 Nov 2026 16:41:35 +0800
Message-ID: <20261103084135.426629-8-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103084135.426629-1-zhugl3@xiaopeng.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
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

The finger count is taken from the top nibble of a status byte the
trackpad firmware fills in, and used to walk the touch array:

	num_fingers = (data->finger_btn >> 4) & 0x0f;
	for (i = 0; i < num_fingers; i++) {
		const struct cyapa_touch *touch = &data->touches[i];

The nibble allows up to fifteen fingers, but the array holds the
five touches the chip is documented to report, so a firmware that
counts beyond that makes the driver report coordinates read from
the stack past the register block.

Clamp the finger count to the size of the array.

Fixes: 9f1cd857518f ("Input: cyapa - re-design driver to support multi-trackpad in one driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 drivers/input/mouse/cyapa_gen3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index fc3fb954523b..fda807a4c141 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -1149,7 +1149,8 @@ static int cyapa_gen3_event_process(struct cyapa *cyapa,
 	int num_fingers;
 	int i;
 
-	num_fingers = (data->finger_btn >> 4) & 0x0f;
+	num_fingers = min((data->finger_btn >> 4) & 0x0f,
+			  ARRAY_SIZE(data->touches));
 	for (i = 0; i < num_fingers; i++) {
 		const struct cyapa_touch *touch = &data->touches[i];
 		/* Note: touch->id range is 1 to 15; slots are 0 to 14. */
-- 
2.50.1

