Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535128;
	b=eY9LAojkYlx4Qmz8XVrFSu/9i4ieY5r7Bh9S9P9p3yY0NsGsxZ4Jumq1k5hUIWgNu/8+
	 qDJvtvqbxPLTC/977wYDodt4W6gmJEBjPFxtl1yLyEX9dY0vZDznML3G/ASopVI+9qUhh
	 ZgKy1YUbwAszdMFUriNS32e95fgZPJC7v4plFmtp+8hoMOeQwDxf1LJn7sQyI2pXwZKVs
	 7DU/GmOx9zLAJi6rOdRB+1hoxXDmMEmf0V0wL7yD1a03ajsLmMIty9lXExouFpRnxUAi5
	 +4OQUCkOOD+p4g9m/KaMlFbBFuc69Yk4mtYSLHOc+aIDvxvUXeOHPWXG0mXi22zVTjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3hkJat/Gg3boX44Q1mafJG1F0JYnnq/y7sAswGXXbDI=;
	b=RQ/rT6OJ4kXPLNUoYnoRWXPwT71RL8JV6qxq1DWYmo1CpLp1yc+g7udwwa9jY++rpspk
	 qv5dPD/CJ+5OxKnXVqklGOndAQ/fnHEm9VAL4C24FwCQoNVBt3mv6o7cM+pgQK7YasJg7
	 qm1En4DveuMu58mGjdFSMjLaAo0xD+dFXXTEY0U2O84uxmRmjYlCda7mj63iuzdVfdY2l
	 31RqrbgUWNtnM1Xo2MBPmQGQzeCp+5cOqmbjQkMuGbQ9oHwdabl9Xu5O7AqCJE4BHJ6i3
	 p+EYRHvs6a6ZT7R7A1yIJ8KeqJeGEtZmq8pHp+FVZXgHEzQIqXh7HTdLt5dntnr/JHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T08HQVU+;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FC606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 912FC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T08HQVU+
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8ca6a12efd9so1333778b3a.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 07:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795535128; x=1796139928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3hkJat/Gg3boX44Q1mafJG1F0JYnnq/y7sAswGXXbDI=;
        b=T08HQVU+RG0vW7CTZSiFCGrFWeD1QNQWCYFAfRXlUt8EbYsylC69ARNtHNoxccWMgD
         0XjlKPgKy6YFYTO2xeVhl23Czdkzs2g5Gs4osvH3SV5fLBB1heBG7EhNQZ0cFx7h8Bq1
         XgqV7tZGT1QDqN0WU4wXZEUjXOrJBiiaL9EyKV7FvrSHQrIcFNGVHOsMGDrh6Yg5EY1U
         ltbUUwQDEFYLjWxPd3dR8NUujAmPorV+/4c4O806ocsqOL/CUw6EoS1YP9j+wYiTPy1o
         kJLTi7Q/TzRRISTM2ICkPs77NSR1cQjIjGCAYd+YPEv4LbtnYhznhnBmlvXUbn6MZ81q
         GYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795535128; x=1796139928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hkJat/Gg3boX44Q1mafJG1F0JYnnq/y7sAswGXXbDI=;
        b=Sfdx0J4pFnuxYW8WGwSgYTyFcTxIdF9zddgLAmJWpoThZw7k3g0aYkCOTu4SZsJKqy
         hl+v63azVP5//+r2mGLi3F7afhSx8nPoNTOvEUNgxuuaaJx9fd1/oUG/nfgR7xkJSSKm
         AdxoT/UV7Y/ZcFF8xtKcOVtN7KVmzft1anWlqaUc+iqx+AsLOKZhlDZYKaSjqlQpLMBQ
         PUowKBYaAQVSXHKWVlobr5U6W91p54Yybna8cVUlaZps5kJa56YTqdf1lwIUb1j5H28m
         bBtVKC+/H7pBZCJGDSZlw0t1mnCTR6B9/KE7C8aRPhYvkG43jYT893NpQQt9fZ+5ld98
         BmxA==
X-Forwarded-Encrypted: i=1; AL+hErHwcp0SNC9PteEq3Al3auGVAXzjgv9spKHHC8+qRq2tUyobxLruGzAhUP/f+9m4Dv8w8mjOlcQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9J35vWaYposEOHKMZhXfyXPZX0IGo+6rLcD/6+D5xvanBeZ/BW
	BC2CXqajKMNf3+5SOFATSqdkBavibD9D82ag1YpRGRotbB/kq13B5jQ=
X-Gm-Gg: AZFdTZcMqxBSjeE1ouPKz2xsNFNktw44iZTXeSELnZIboNA88ksafk3NLnPMy5OnEmc
	7ldfVc5fSPudp2M8brF9gcsquO2YC0NFhbv4zvbCW86S8AFYsemns6ltdFgILpavirvi1ukRh+V
	U3FMImGLx/XTkkhunYr/rrnAJSjfW9Mq4LLkifV1ja9+c2PktXdN7gUHIVE6N+6b+4GhtlzxJx+
	TZ/UwyM0e1CDVzHSmXqYNnPI4/jyGE5X7I0kRuU+KjFbJ5KjsrhJC0XncMAijzYfi/g6xQmdZHe
	WD8iU7vCin3N7+h1nGp1KDOGTH1+q+RUqQs2ieWU41/egO3vgjMm5pZAfRDQnQXMeEI0q+KLCiM
	eSUSSTVQ0Sys1pXI+152BkcyyMs988CC8CkLUQ6fMI+G4qIDkMzk6lDIJSJR0lEFBMWfQJu7mbW
	lJMmE/FXh34vRRTJri2tUaGeUhUGblUHdNkKj7CW3Kog03HP4M/09ILsmmIYHiCGD6QTH+w3AsQ
	Lx0fOKQadRtokFOdAtBbHwUaYnl3gzSX7J4ewHMKndGjtJEN2L1KCWy+oAP3Y42CdTN34jddjLc
	8xC6IJxnAFLAVpYNewaeGpk7Res2dDp7eq8MfhjSsVbGBLZAiIThdA0jJESGytTw/Vwy
X-Received: by 2002:a05:6a00:1f17:b0:8a0:f375:d1c0 with SMTP id d2e1a72fcca58-8c87c57b5fcmr12396223b3a.33.1795535127699;
        Tue, 24 Nov 2026 07:45:27 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:5da8:85f0:b5f6:2eae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873f11da2sm7136132b3a.55.2026.11.24.07.45.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 07:45:27 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] remoteproc: qcom: Clear the GLINK node after name allocation failure
Date: Tue, 24 Nov 2026 23:45:21 +0800
Message-ID: <confirmed-20261105-37-9a8d5cd59eb0@gmail.com>
X-Mailer: git-send-email 2.50.1
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

If kstrdup_const() fails, qcom_add_glink_subdev() puts the acquired node
reference and returns without adding the subdevice. However, glink->node
remains set, so qcom_remove_glink_subdev() later treats the subdevice as
registered. It attempts to remove an uninitialized list entry and can
also drop the node reference a second time.

Clear glink->node after the error-path put so that the existing guard in
qcom_remove_glink_subdev() skips a subdevice that was never added.

Fixes: 44f4911ab8e6 ("remoteproc: qcom: Fix glink->node reference leak in qcom_add_glink_subdev")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
AI assistance was used for analysis and patch preparation.

Based on next-20261104 (8b7179210b22).
Compile-tested: arm64, GCC 14.2.0, W=1, drivers/remoteproc/qcom_common.o;
baseline and patched objects built with no warnings.
Static source review; no hardware, boot, or KASAN test was performed.

 drivers/remoteproc/qcom_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 5294e327f1587efc917eb01dde59bd1e723c225e..cb3f6f93c6da85010f89244a6991f4d74ae57dc1 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -255,6 +255,7 @@ void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink,
 	glink->ssr_name = kstrdup_const(ssr_name, GFP_KERNEL);
 	if (!glink->ssr_name) {
 		of_node_put(glink->node);
+		glink->node = NULL;
 		return;
 	}

base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
