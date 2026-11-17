Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794887543;
	b=H3Yo2HjxDWuybA/XsPS4THO0Ai1hXwb8J7ZmaoGCtuOQzq6X529wExGxaSZNnH4bmHB0
	 b1BRpdBhpe4Djo8XSV0WFdoqbO8UuGgaey0wO9HtZtJqPAzqXwpDKF9ygpSzvS8YMVUGd
	 fbl2j//sQSoeWqCST/Sv60aB+YdC8sP9bd8dmKtqIkk2YUPYZ8qD3rWukhPw8ksubXxK3
	 2PR78z3ynof0sTmGAVlDw7H6ncTFW0MBp4vR1ul3uBiJBI6hJcvMuLIsGwihtAUU1Hh7B
	 KLSxjPWVEyb0cLE+iTAQOP2z1ZIPi8phEVVVtzP8bU5ZpxnGn6XcgaWGxfTTM4dw8ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794887543;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kPbUU2pSkdSIyR6nxJNJ4pLUOdW5sNHpnFPYPN95g1Y=;
	b=hsy6vbFxCvSddVTFCu8ogCczqhphcSmiZ7Ccek7gYyJEsMjCvk+r0QZVzI7GwagJ9COC
	 +U3EQEumgCE6cINf8Xn9mtwwH3BBjLQzTGIlf1fb7IuopTNLJjer4eusB54/NxlSMRKRK
	 bx1BLr+mDBwyirum8iWDXo4KN4PAND1cA8657lUbdXq5kd27f/BFYJ84MFZMDEYi/UWlj
	 QCn/qMex534xOhHqXVaXvSiPsFYqe19PphY5pmn7d54Fk9lduOYpWQCBh9V+W70w8hOCC
	 uG0nTk232KrtrPx40QXuVwi11cNzpmyhM3kMFoUj+5IhoXkexaTSAuhvMFJHOcifjIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12731606A31C;
	Tue, 17 Nov 2026 03:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12731606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 429694a0e23a11f19a56ed5b684f684d-20261117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:e56faa59-909d-4110-9eb5-9206bf254019,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:54d9638c31d6d837d37134dceeea875f,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 429694a0e23a11f19a56ed5b684f684d-20261117
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 671802626; Tue, 17 Nov 2026 11:52:07 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: brendan.higgins@linux.dev,
	david@davidgow.net
Cc: raemoar63@gmail.com,
	skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] kunit: fix NULL dereference when glob filter matches no tests
Date: Tue, 17 Nov 2026 11:52:02 +0800
Message-Id: <20261117035202.251238-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

When a suite glob matches a suite but its test glob matches none of the
suite's tests, kunit_filter_glob_tests() returns NULL.
kunit_filter_suites() only checks IS_ERR(), so the NULL passes into
kunit_filter_attr_tests() and is dereferenced by kmemdup() in memcpy().

Skip the suite when the glob filter returns NULL. Keep the existing NULL
check after the attribute filter, which covers suites whose tests are all
removed by attributes.

Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 lib/kunit/executor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index c798a02470d8..3a281af3cda8 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -226,6 +226,9 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 				*err = PTR_ERR(filtered_suite);
 				goto free_filtered_suite;
 			}
+			/* Skip this suite if the glob filter matched no tests. */
+			if (!filtered_suite)
+				continue;
 		}
 		if (filter_count > 0 && parsed_filters != NULL) {
 			for (k = 0; k < filter_count; k++) {
-- 
2.25.1

