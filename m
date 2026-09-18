Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CFB4A3F21;
	Fri, 18 Sep 2026 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718934; cv=none; b=ByfqjShkN9f6dXlV4OBTq/vMDS+v/VoR2uI1y00/a0Egnld8dPrXOGv0qS7ppJ37VCjhHPbWc+mgLjM71+4SGq0QrJ6HdFFiqQihnOQbcNS92HFXCTuQkgPQ2kKH6yyJCP+IwJg7YoYWuMm5cgWNb5NpFJtcZBn4jC59/EfT4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718934; c=relaxed/simple;
	bh=Q+bXqF3C2apNDWquVn8KlyuqvfATYjULQQTWBiPXg40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tIDVxJhPQ3gLUV8w5ccnOR43t/NtFN8u2V3uW9rIC0JPaebEEFefeOFkjKhXx9sE61CpL9CQ42ax1ArKs062pG6fi6yEV0dVrj8GG4FIqEG5TTOH85ZDIiXuq50mowyUvv+pZPJMfV8j7Nrp6gnRjmV5H0nbJ+w8dJ2bHBM7U20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=HHzjQcRh; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="HHzjQcRh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1789718759;
	bh=WOQkXsLb8pBCAPb9jR6ub7qdKLg2BmurTWA4Q/P+M7M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=HHzjQcRhaUTey8BurGcGNwVVJYu264Ji7FspEi4H64L1G2tpzk6U2K3L1HcRZLEKL
	 M0z/+vjbcn7XyrV+WtwWchRzh1KaWpZzHVzDmv0KmT1ghX6vjyVyUXyFb6DuHx0v7x
	 m6dZDhyMI2+BErTWHEZqUZEhT8rjav9mrpzZMoC4=
X-QQ-mid: zesmtpgz1t1789718753t9f81553b
X-QQ-Originating-IP: s+R751XdQU89qxpy7egpD/GTIbYpR3/2Yu0mn+lQWYw=
Received: from hepeiyang-vm.wu.lxd ( [153.3.21.105])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Sep 2026 16:05:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14662369230533953901
EX-QQ-RecipientCnt: 9
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: josef@toxicpanda.com,
	axboe@kernel.dk
Cc: nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	prasanna.kalever@redhat.com,
	xiubli@redhat.com,
	ming.lei@redhat.com,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] nbd: fix backend identifier memory leak
Date: Fri, 18 Sep 2026 16:05:23 +0800
Message-ID: <D2B147C93306A66D+20260918080523.2841932-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OBWTMGjbXnSFfG9V2aEpjTl5kM5dShFg8FejOccEgDgtUNQccJusofc6
	Fogj5mwOL4rHdg3WGi8JwHg25wc6Tm/RxufSWgaxOnqzm56cfwHdtW9NQAn4qAQI8BHZqNN
	1uXqpousW829kS1fRQdjOmrFf8leemkk0qhcIfqjrdqUiRnxJNEl92Tp/oLrGh3ocKHwALz
	jPC2tZksyJw0+xZopUAW6FxZE2UqT8+SkFqbBww+8hjZO+01OEbJ+8PzJbfZbNergakTW+z
	Q5xBHm+xDKXmt888ce6GL1YfmmMIWcFSTDoNJIH18D9J+wwwnaCHdO3o4skA3TlHAUiqcdQ
	PMWk+sbNPnmQpkKxd58q488mUlNACrb0BENnZIlpaD7RlVJuO1OGpYCYWQhJKMzvrLWmfNa
	yaH/5OA4qRTgGD1mwRngqnKzqToORpII+EFxBjsPx49M47VuHQqW4zAZJQdq3lOtX6/qvBn
	U6fQFESTKV571YwrS936BJKy10uHM5W1tzSgJSWHPGixyw5QqVU7fW5JNXkyjqG7cWGbUPt
	1SJgPLwHayEauoJkwfZRJYe2n/gVNhUhOKiJhL2dW1g0Er87CdBf+OlGUEn83+lUIMauA8e
	lWTnP6XSxNoZ2H7xTh33Z3xWF7MLEdKCqzqTk52mO2o00Kfi5gzJkffKARIa7BsT4W9EYJ1
	uTCzJHXfCtwG4e8f2Zz+NQCKsiP6kqytUBAf9fUmrrRqnsWw/i7rQHnE5Dq5upd/hoCC1XW
	OzMF6n6Pt67bfYZnPjKEx7+ZCN+9s3OgeaL+b50pBtzTI+npXRjPTb1b6wTtYwBTmCBiLHq
	Z+79yfbZ4n+9HOq70NFj1qSf0E4VHrPb41xFQXXICbm1MHOe9oFZ5cAOkQkFVgloiad0VXV
	SehGGAwdgIhOEluTlG7JPJ1MyFPswK8SuhNdoOYxtPwfyyr4m3AINLjWHYHchtIFD74qvW2
	7OE0pIh4l8b2o0JFNkKaAY8xaHWiAIjKpqO75EPeUoCuMPEkdncCWfpVmNS6XVSbt7N/yoe
	SOzx8CV+muCEDo+wiBZbpXFt1f60hfLJaDJh9W6FP8JV0Kh7HYo40Jd2LagXG3CP8u7/4aT
	RWeVBasyu3e
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

nbd_genl_connect() allocates nbd->backend before creating the backend
sysfs file. If device_create_file() fails, NBD_RT_HAS_BACKEND_FILE
is not set, so nbd_config_put() skips kfree() and leaks the string.

Fix by freeing nbd->backend independently of NBD_RT_HAS_BACKEND_FILE.

Closes: https://lore.kernel.org/all/B518B1A813407AC5+004c9da2-4504-44ce-ac1b-7b46bf0c30db@smail.nju.edu.cn/
Fixes: 6497ef8df568 ("nbd: provide a way for userspace processes to identify device backends")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: LLM
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ffce519bf008..1e8bde3450c6 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1486,9 +1486,9 @@ static void nbd_config_put(struct nbd_device *nbd)
 		if (test_and_clear_bit(NBD_RT_HAS_BACKEND_FILE,
 				       &config->runtime_flags)) {
 			device_remove_file(disk_to_dev(nbd->disk), &backend_attr);
-			kfree(nbd->backend);
-			nbd->backend = NULL;
 		}
+		kfree(nbd->backend);
+		nbd->backend = NULL;
 		nbd_clear_sock(nbd);
 		if (config->num_connections) {
 			int i;
