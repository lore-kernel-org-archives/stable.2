Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.188.205.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884545;
	b=g58GSC2C9L8m3tfzbkeS37e9LekiI0ZhZw6jdE4iyuAtnOf80XIitpj5lFREzheUEeyC
	 hwpWcy2nmweWQOtdHa1NJnc6zw0OOoy8dFgoHDcQABOIbakXzNLRBRVCxMXb9k5fJ6xRf
	 1Gej6n7oFQV13jSU85u9nGxac9YlFQe6YahCffTzA1J5tNHmzNkGoM6VozpIa8NrLXdzA
	 p0d7YgHhIdKuRchobFp+L/eIsy5yllBAMj7R0Tz/4yqQ392dfcO+SXF4WLXiGWPHcUShn
	 jkwU5QpUgVe3irTvKuai3UU6mBBvBvpq2w4v468Qa0TZiFEhbK/1Vj4kTJtFj/q9c0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884545;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=ds4KqEzwz/HLlkZPq4+8HMZQs10s+qVLdbRmvQJPYqw=;
	b=o3QUiaiIO2jY0lv0dXBE6CsxuuCsyL3/fik/Z2ND7XfnQLqLyepDBwBCBGS9sY+BRU4C
	 osYVbjMFOmDK1peIckxRvCOgPtgcyjr8G+4lRnZDrfSQZ2GZecEkoTBVGiERXFPSvemDc
	 652p5XgA6zJoRa71dMrE40ZHqoKBhxYoSgnpG5xwreNdVYdsBNMt7NNogGG9EzGYJU+TV
	 PpMMq5zsUNCHnDUOG2GmkjCvn2zXjU5qXG34Cg5BRRtW/L+1+Rs2UzJ5gfHXWpuMoGbSc
	 8EPoCSdQGGaXDvXHieylPOzJ0GIvccMizMwwBpTW1bkHTs6wXECv7Egy5UrOdJAf5vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=CSw5vZHK;
	arc=none smtp.remote-ip=93.188.205.243
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02574606A32D;
	Thu,  5 Nov 2026 13:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02574606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=CSw5vZHK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793884540;
	bh=AY/uacwPRvt+BnCPmHcBKsQEeQyIXDjDNGjK9lDqr3I=;
	h=From:To:Cc:Subject:Date:From;
	b=CSw5vZHKMa+/hlSkocgvKgJjzhBsotusktPrYKYA0XYmVqDJHdNJc2DCYznh9g0CT
	 NmjH1sjHUOlp937Q7EiCTxqp6IXESTnAVQ7OWoxoBp3w+6PAS/2pDeyNMk51eqNLd0
	 4uRzCGt9IjHuOc6AMtSsVDd4kamo+MgXAfx8agDW+ay+Rmr423PNrrHyrGmQQY5xr9
	 5FjSK+H1XfEmanlzjSqbqXp5vd51zeEtkqdnLERFVI/lrjODTlrTFvtc/jqzOxOXLW
	 DDzk3NLicnxZcWhHlMi8ywhmKTSJtqVEVgll8Jy4zvwdEXefrWt7a/2s1jF5ZHFF9+
	 j2vbcamLzLUXg==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id C9EC81F9B6;
	Thu,  5 Nov 2026 16:15:40 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu,  5 Nov 2026 16:15:39 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.31.238])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jL2qZ50NTz4CMh;
	Thu, 05 Nov 2026 16:15:38 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	jerome.pouiller@silabs.com,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] wifi: wfx: validate MIB read length before copying to caller
Date: Thu,  5 Nov 2026 16:15:09 +0300
Message-ID: <20261105131510.650-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
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
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/05 12:15:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {diag_burst_silent}, {date_rfc_vio_soft_silent}, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;patch.msgid.link:7.1.1;127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207270 [Nov 05 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/05 10:48:00 #28800686
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/05 12:53:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Aamir Ahmed <elb12345@hotmail.co.uk>

commit ce67ebe9d8629776ce38e6995ae72fb903c828db upstream.

wfx_hif_read_mib() copies reply->length bytes from the firmware
response into the caller-provided buffer without checking that
reply->length does not exceed val_len. A firmware response with
a length field larger than expected overruns the caller buffer and
reads past the end of the reply allocation.

Replace the dead -ENOMEM check with an active validation that
reply->length fits within val_len before the memcpy.

Fixes: f95a29d40782 ("staging: wfx: add HIF commands helpers")
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
Link: https://patch.msgid.link/AS8P251MB000155034FC391A2A54B9803C8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[mdmitrichenko: Apply the fix in drivers/staging/wfx/hif_tx.c,
 where the functions are named hif_read_mib() and get_mib_name().]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-98830.

 drivers/staging/wfx/hif_tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/hif_tx.c b/drivers/staging/wfx/hif_tx.c
index 63b437261eb72..4ff109a582bf9 100644
--- a/drivers/staging/wfx/hif_tx.c
+++ b/drivers/staging/wfx/hif_tx.c
@@ -193,10 +193,12 @@ int hif_read_mib(struct wfx_dev *wdev, int vif_id, u16 mib_id,
 			 __func__);
 		ret = -EIO;
 	}
-	if (ret == -ENOMEM)
+	if (!ret && le16_to_cpu(reply->length) > val_len) {
 		dev_err(wdev->dev, "buffer is too small to receive %s (%zu < %d)\n",
 			get_mib_name(mib_id), val_len,
 			le16_to_cpu(reply->length));
+		ret = -EIO;
+	}
 	if (!ret)
 		memcpy(val, &reply->mib_data, le16_to_cpu(reply->length));
 	else
-- 
2.43.0

