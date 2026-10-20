Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510891;
	b=yduCcuQDjzvPN8cmD/odu58q1l67gIQlLcUYSZNKvKd75hQg+ciZjihk7izd0keEOmQg
	 eOCkO6qI9akDbhIGXr2LloyTAfpOAi5PPSNEI/Uhlfw7SsBFuMnM2I93UB6FgqXHDEkoC
	 PBB5bDou6c9USF/82vUd7oBkyV43LM43wkB0TFqm2cAeOJSHjARuMJg5Y3ubTOIYYIUtj
	 DaO51KW4laBpEwxJ4iIrmYnGRYfzlEJQwPvkBVAMtO5n0Y3cGH7UKq2Uzz7lP7Ru3SSFH
	 3IBwgI2oKPCPXaxIfCy2ArFIFUl/sU94Ssq/AI1iIQInoTRruoqjrG2Jgqysouuau4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Hhz1fJyJlcO5CAzjOhZ0iixB1CbZDmg3HwLXlzLF10k=;
	b=kXdnshs//0wrS2VdvR6H/kxczzYX6qrOyc7VItdU+N5hb9S58cGuH4gvigfJ1xlD2odc
	 aGV9Z07uvwxC60ZeTMbSwL4u3u8Me1LeLfvL0jY/qKWVtFG/cVDg3xLSQlp6oFX3AlN1V
	 lLC+DASEUI8SgiJH6Wz1m4RpfgkSD8xvsUd/Ie28x52NZoM9R8AeGtLPAdCM+SPDWNZno
	 PjIT04NkHPlKG32VGk/AKNMWWkR7/zerCBLuvsu3MG1rPQtSmqvRYju6aazU6gaLEx8YE
	 M0mWMm6+ynmz7T4NSvBcu77nT9d8OO5Ep5/XlkmHpTc8a2Q3orUDeMBBDVfMPezwc8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MPmiLQ03;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6784760A2637
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6784760A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MPmiLQ03
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so32122995e9.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792510889; x=1793115689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hhz1fJyJlcO5CAzjOhZ0iixB1CbZDmg3HwLXlzLF10k=;
        b=MPmiLQ03jKBu9Up7Co1AR3HCCe5/NHH8J1NULRy09TjXAJpEbfZqkulIm5SZBBMKz5
         BohxsiApvkjeD+yBDUE7f8QOGnqdSG+aV386iBnVFI/PnEjv7qmEZ0rnz1lwWmvHMyv9
         z4FNJZZr11Fmhn3tWgjP4CvziEvtLC3zB9Be/JDLwUVWeEpwA2Sy4f/MlNtUnh+qXJde
         HNIEdrQ6Px/D35gLnykPoXWlgmtv+Y/Y9MKu9QIKwCmMI2UPtvXcnT+OmDyv4t5HBGJR
         E4BwULAWFCnQSzthPZWuE+JAOWVF//IcncuzSZuu522KJIE5nUwGHUFuH444RRTYVhLH
         lZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510889; x=1793115689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hhz1fJyJlcO5CAzjOhZ0iixB1CbZDmg3HwLXlzLF10k=;
        b=t616TsX+qMxlRk0FqNK6Uc2UZS86lI+dw/ResuyAmM03wpj/2rgl8DbBdAU9ztXr8L
         CJbRcJth10L2xYJiydHaKlXwDEjeme3KNEFn4qRqCtCVesXQmPGKgFuXKUj7dK3pzCyt
         U3bZMnaVitkfPoCbAVCnO3IH84LNNEpnwJxtuTtlyHEi9GbiUDsL2yDscc0E8HrIEEfm
         RllafQ56IeJEWLndyiXYvw7wwgkc5weTcpcqVaBOn5oFpTI4JomnVAnh/wIInEqRUaaH
         5uIdXSDwMEeRpVK/yMntoJLE+6oT89GFYGJh9515+bhrpsbvlImSzghdUJaweOaa0FHc
         2iCg==
X-Forwarded-Encrypted: i=1; AKwUvByGGVYpJHf8jxYj9+0UZ6Ybeb4i4CQUs7J2AuAM5wsi0HKqIo3WDavJ85F6V9k1hSTAha3FwV8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYSHUroIPGA6yg+jFuvmqcEKwEALRG4hboTM4xDXO7swKVEc4H
	T8uQsLWfjNXGHMiP4HeolRoKzusPCgOteupqSai1qR2ujOwtqSje5RE=
X-Gm-Gg: AYBFou12mNTHb9VeGRxx61h6pBFG7jcb2/Nhp4dYLQT7vton/0ROVTA3xa63J5rrRJK
	HbSigPul1KHI2eXmPWrYM2KFf78HZJy03VgG6UH62L6+o5dXvHfyGkClrIjpjZKzvID5vb/KG2f
	K5pGKRnmscLKnRzUBPKZorXLEPpkceQoGxfe+gFQvoUs3zZJ1aTcCu8mKHBXNkjogBePIr/4aRC
	pnDmV1Rht/FeqNvmju9xAC4Ms6taQLToOIVq/p716DDLjrL5TlFYre2VH1lqv61271CZx3KrDi4
	emb1JcjUnheuHsItEiHbXYzOO9zj49E7XnX+kLTxNOxkrziVfY69U9oDZPUpDMjlzbFBRevDvpv
	f9YcMLKVurKdMIrpO00xUmusDEfKq+qDHBbTY+VDtghKlDHr0Upi0yw7s/9xHbC5NAeEmuopfz/
	G4Yhzw1ZfoJA0etq5L4cveJ5pu5qoenmxwwdoeZaQ=
X-Received: by 2002:a05:600d:82f1:b0:4a1:fa21:fd90 with SMTP id 5b1f17b1804b1-4a1fa22013amr25711045e9.9.1792510888489;
        Tue, 20 Oct 2026 08:41:28 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca31234sm256606155e9.4.2026.10.20.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:41:27 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 4/5] extcon: rt8973a: cancel wq_detcable on driver unbind
Date: Tue, 20 Oct 2026 15:41:18 +0000
Message-ID: <20261020154119.2568395-5-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020154119.2568395-1-tristmd@gmail.com>
References: <20261020154119.2568395-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

The driver schedules wq_detcable as a delayed work during probe but
the remove callback only tears down the regmap IRQ chip and never
cancels it.  If the device is unbound before the work fires, the
callback dereferences freed memory because the driver data is managed
by devm.

Use devm_delayed_work_autocancel() so the work is automatically
cancelled when the device is removed.

Fixes: c03e017c4d3d ("extcon: rt8973a: Add Richtek RT8973A extcon driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/extcon/extcon-rt8973a.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-rt8973a.c b/drivers/extcon/extcon-rt8973a.c
index 19bb49f13fb08..184e9f4c16ce3 100644
--- a/drivers/extcon/extcon-rt8973a.c
+++ b/drivers/extcon/extcon-rt8973a.c
@@ -6,6 +6,7 @@
  * Author: Chanwoo Choi <cw00.choi@samsung.com>
  */
 
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
@@ -635,7 +636,10 @@ static int rt8973a_muic_i2c_probe(struct i2c_client *i2c)
 	 * After completing the booting of platform, the extcon provider
 	 * driver should notify cable state to upper layer.
 	 */
-	INIT_DELAYED_WORK(&info->wq_detcable, rt8973a_muic_detect_cable_wq);
+	ret = devm_delayed_work_autocancel(&i2c->dev, &info->wq_detcable,
+					   rt8973a_muic_detect_cable_wq);
+	if (ret)
+		return ret;
 	queue_delayed_work(system_power_efficient_wq, &info->wq_detcable,
 			msecs_to_jiffies(DELAY_MS_DEFAULT));
 
-- 
2.47.3

