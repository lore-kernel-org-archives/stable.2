Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257711;
	b=4B030C2N036rjwcWmqUEEZ6RqnOkfMg26A/kcU47EGHQZlLp2iIuM8I1zf0xVmdc+U35
	 ShOsVSZrH5VythlDeObYagFKStyNUMkVcrDLanMbUbVh/oTQern9RiAJG322Skor3o2K6
	 vIkJ0skYaLI/Uciy5fxIMhzwgWbzu++kkz/qUzSDz56uoCTJDXWHy1Wrb9zkdxI++CcBG
	 pc5jf9so9PWu7XKmy+wGIws7r85lkkns93ONoglBObjJMBjHEEEpXML3qX/4AhxdAXU5q
	 kKmqDh7o/dYqmeIb3r5uJdJd10O0TQl+U1x7dQxm86ilUlnayv4zRDKNDv0b8fv89bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257711;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1mnk6HCaupblw/EK61S5BkiME4hmOYeInQztA0Fmq1Y=;
	b=dBVx7tZDNeb4M0d4BO2KSdrrl0ryA+ngUlaRciUH/tARnKJQ47k9vWdZALsjckcJpO8k
	 lnvMebH6da+Q8+55AijFsr6rKpsrus+m2X0IKy2t7Pfv2OhATIoIgh1+07e/KYNZEpCH6
	 uii2XotThFmYBRefAUOnCEaTUIG+hglJLk8f9vdjOtyrr0payJ8+ZovynQxHprHoWX74I
	 N4Rit2MMJFcjPryUbFMAjPZA6sOAbLUViADVNnOgRAXpp7bn1Ha9ZaADxEbgZd7zjQGR0
	 pPuf/OQz7FevoLjUbMHlJ6jlCDkfxpmCem6g7Af6WgiSlXIC9za72SkjRCss8d+F5Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=U3T+E0Pq;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3136606A31A;
	Thu, 29 Oct 2026 07:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3136606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=U3T+E0Pq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=U3T+E0PqH7zD19Dzpp+xnpf3auiKt73OZP6QiSFqhkkmEQ07BvoRk7J+7yTHNOPrwAxzj/2lMvqLx
	 uiK0OoiJurbgtpTIhgHM4sci4/TnQfxsPcC439CYDu+wdGXV5gaXQfrYK3vvAf7h1kqj3dLx66r5N0
	 lE2M0f1hBHTyfMoc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66ae2f0e73a8-3474f;
	Thu, 29 Oct 2026 15:08:25 +0800 (CST)
X-RM-TRANSID:2ee66ae2f0e73a8-3474f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181454368174 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96ae2f0e6fd1-25d98;
	Thu, 29 Oct 2026 15:08:25 +0800 (CST)
X-RM-TRANSID:2ee96ae2f0e6fd1-25d98
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: andi.shyti@kernel.org,
	dumitru.ceclan@analog.com,
	sakari.ailus@linux.intel.com,
	luca.ceresoli@bootlin.com,
	andriy.shevchenko@linux.intel.com,
	gonglinkai@kylinos.cn,
	rosenp@gmail.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org
Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] i2c: atr: fix race condition caused by static local variable in i2c_atr_map_msgs()
Date: Thu, 29 Oct 2026 15:08:17 +0800
Message-ID: <20261029070818.639-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

The variable `c2a` in i2c_atr_map_msgs() is declared `static`, which means
it is shared across all invocations of this function regardless of which
ATR channel is being serviced. Since each channel has its own
orig_addrs_lock and alias_pairs_lock mutexes, two threads can execute
i2c_atr_map_msgs() concurrently on different channels, racing on the
shared `c2a` pointer.

This can cause:
- The wrong alias to be used for address translation, sending I2C
  transactions to the wrong device.
- The `fixed` flag of an unrelated mapping to be corrupted, breaking the
  alias replacement logic.

Remove the `static` keyword so that `c2a` becomes a regular local
variable, eliminating the shared state between concurrent calls.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/i2c/i2c-atr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-atr.c b/drivers/i2c/i2c-atr.c
index e6d2af659d81..c9ad46db438d 100644
--- a/drivers/i2c/i2c-atr.c
+++ b/drivers/i2c/i2c-atr.c
@@ -360,7 +360,7 @@ static int i2c_atr_map_msgs(struct i2c_atr_chan *chan, struct i2c_msg *msgs,
 			    int num)
 {
 	struct i2c_atr *atr = chan->atr;
-	static struct i2c_atr_alias_pair *c2a;
+	struct i2c_atr_alias_pair *c2a;
 	int i, ret = 0;
 
 	/* Ensure we have enough room to save the original addresses */
-- 
2.43.0


