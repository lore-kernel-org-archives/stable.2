Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844796;
	b=CwyjuZWl5mBCbTCZhG7VUXALT8kwB3mx/ukTN23ePx+DD9Pc1rFdfBFWvAufpmmfUTOF
	 k/gOJ79GjVdGVxRfSi4ylpfjGPYJ6BCrAuFicb9L94OrlWQb/r42+i5ecNXTONnEx1SVQ
	 BYIf26tojlrLOjy7Cel8iFE4InZgzbgcplEfG6/fovmtrZh3tXdGbbAyIQfHVy2saMAM5
	 MegFHBxqWgJwNA2koZBs6i0JLmrwzcBE+8i4Z6MyETR1ru2ixqUZ8i3wEUedeZkYSxnsO
	 dw6k1Iw/gndVJWkpf08ftsc4E4zoOKLBVBsWhkeYFnbnfGLB/3Huz9Ju/sDLU6jdTJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844796;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iTltyTy3XY6yo19A8F9g/qsXyruIBa411J5VIM+AbTg=;
	b=LQZ6orlwakCW7H8qDykrH6CYHFqGw2pjpNBxtb9/5ca+ShyseZigh5294cJWz0sHStJJ
	 bwovyIzi/1Jpz5Q03VTfCYwSqlj/IfmT+F1Hee/QLdpLRo3RzXoef8cTEwOdzNirA8YKY
	 WayRHwirTGWjf4JhTGSU+ptvqftADT71dsFMqmWW/iyk/xyoeIa7GfoYkq2UCnF1AWsZT
	 8WVapz0Y27KsXcVjcxVFvcYUzS+ndh5FNbZZ+aYt/UsQ3/t20lmh1gwWVHjcDuWR7Op13
	 vrd3TQ8LziLgFETBWKT3Ydip+jbLJnahkAXz4qkUqGdBN9hwSXrtl34WFA9Sx1byunQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=V+8QhNMj;
	arc=none smtp.remote-ip=115.124.28.218
Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052A6606A31B;
	Thu,  5 Nov 2026 02:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 052A6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=V+8QhNMj
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793844784; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iTltyTy3XY6yo19A8F9g/qsXyruIBa411J5VIM+AbTg=;
	b=V+8QhNMjfVbt6YKv2sdcr0bvaw+UcydgsTGQi5kh4iYrZeQR/p3kemlSaHPrh3CNGHMAkbkqVU8BcyFOFa4z4Dgz7x2k+NECnZC1jOZu7KI4XJsOvk+qwG4M0CtdH6bRkXN3sW5b6SM+BZZyqTUCe4yiQa1De/ml0h7NwnX4sbQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1164851|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00192615-6.33412e-05-0.998011;FP=10463892798782289586|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033071099199;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jx4H42-_1793844783;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jx4H42-_1793844783 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 10:13:04 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH v2] Input: tegra-kbc - check the pin numbers from the device tree
Date: Thu,  5 Nov 2026 10:13:03 +0800
Message-ID: <20261105021303.4206-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103084135.426629-7-zhugl3@xiaopeng.com>
References: <20261103084135.426629-7-zhugl3@xiaopeng.com>
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

The row and column pin lists are read straight from the device tree
and used to index the pin configuration array:

	for (i = 0; i < num_rows; i++) {
		kbc->pin_cfg[rows_cfg[i]].type = PIN_CFG_ROW;
		kbc->pin_cfg[rows_cfg[i]].num = i;
	}

The helper only limits how many entries it reads, not what they
contain. Not all Tegra variants have KBC_MAX_GPIO pins - Tegra114,
for example, has 11 rows + 8 columns = 19 - and the setup loop only
initializes pin_cfg[] up to kbc->num_rows_and_columns, so a device
tree that names a pin the variant does not have makes the row and
column stores write over pin_cfg entries that were never touched,
and the later check_pin_cfg() walk reads that stale data back as
valid configuration.

Reject pin numbers the variant does not have.

Fixes: 88390243a993 ("Input: tegra-kbc - add support for rows/columns configuration from dt")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v2: validate against kbc->num_rows_and_columns instead of
    KBC_MAX_GPIO, per review - Tegra114 only has 19 KBC pins and
    the setup loop above only initializes pin_cfg[] up to
    num_rows_and_columns, so pins in [19, 24) must be rejected too.

 drivers/input/keyboard/tegra-kbc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index bc1c80a..657260d 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -522,6 +522,10 @@ static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
 	}
 
 	for (i = 0; i < num_rows; i++) {
+		if (rows_cfg[i] >= kbc->num_rows_and_columns) {
+			dev_err(kbc->dev, "invalid row pin %u\n", rows_cfg[i]);
+			return -EINVAL;
+		}
 		kbc->pin_cfg[rows_cfg[i]].type = PIN_CFG_ROW;
 		kbc->pin_cfg[rows_cfg[i]].num = i;
 	}
@@ -538,6 +542,10 @@ static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
 	}
 
 	for (i = 0; i < num_cols; i++) {
+		if (cols_cfg[i] >= kbc->num_rows_and_columns) {
+			dev_err(kbc->dev, "invalid col pin %u\n", cols_cfg[i]);
+			return -EINVAL;
+		}
 		kbc->pin_cfg[cols_cfg[i]].type = PIN_CFG_COL;
 		kbc->pin_cfg[cols_cfg[i]].num = i;
 	}
-- 
2.43.0

