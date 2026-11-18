Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994751;
	b=FkZGagyG6/pY/mTJHVczd1LvizUTIrvyrRboixp8QXHKd4/70IoulLlkqUE6aZOUEzHG
	 3HS0giDDaPar3vCq8nuhGEaczqe9yvyVAyIm4QVg+1+hgd7cse5XpnCAdXpyFZYI522zf
	 GNVcYtZv0oMqiDM1noH+Nti4JcHJVfPxr4K5H4YH+RbTC47+4+QQLsTGV71mQNCCi3wx9
	 qcyJaXJqFtX1VCsZAEJjqGxFJgHD+iAS0dLcpjN/VJf3f6w5sEdZHXNBBUfToltxaNcei
	 04AZJm46fRxLnFq7WMck2rdiZ8ceIp4oG9jrJo3+P3QEyvKeZNzsGwReuSPNnR1PVnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994751;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AsjaTEvjj3gZ93q0amD72vG8GO/OKqJcee747/qPRiI=;
	b=RQuuo4Dlq/ytPkinhSn+TTsKSWCPMsA+/oGbbwgeES3xmW2wmlXAvqA34ceoMeY8Lqzy
	 agieMiBQsUKuTXrre1W8m3jIdJPbYm1vPCUp54wA7x1in5TL1GrTBLE6uSqJEyYLZJBLL
	 SUw+yP7z8QhV8lcKwxw8wNfvkdNO2OVr+yw9G+Igco8e8gy0jWMN9ajXNVBojZm+Yg+ZP
	 5v54iG1vDlqsjBsy8ArSFdXqf3CJsR5Ac71bzL4ENs1ZuZlDKvxftO74BJC8odYducrCU
	 oSt7thN+b7T8hFsHx4rWld1MLXv/C8Nw4DXl53B8NBvl1h29FGGZrYjDzvgc3BrL7fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C62606A31C;
	Wed, 18 Nov 2026 09:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69C62606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e3a9c08ee33311f19a56ed5b684f684d-20261118
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0846131d-252d-4e03-a1fd-780c2246c151,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:c674026f7db0ce8aac13ae7d87e7d93e,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e3a9c08ee33311f19a56ed5b684f684d-20261118
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1229989291; Wed, 18 Nov 2026 17:39:02 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: brendan.higgins@linux.dev,
	david@davidgow.net
Cc: raemoar63@gmail.com,
	brgl@kernel.org,
	sboyd@kernel.org,
	skhan@linuxfoundation.org,
	logang@deltatee.com,
	gregkh@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] kunit: fix resource leak when init fails
Date: Wed, 18 Nov 2026 17:38:57 +0800
Message-Id: <20261118093857.578044-1-yijiangshan@kylinos.cn>
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

If the init function passed to kunit_alloc_resource() or
kunit_alloc_and_get_resource() fails, __kunit_add_resource() returns
before the resource is added to the test's resource list, so the
allocated resource is never freed. Call kfree() on the error path.

The free function is not called on this path: init() is responsible for
cleaning up after a failure, and free() expects an initialized resource.

Fixes: 0a756853586c ("kunit: test: add test resource management API")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 include/kunit/resource.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index c330ed3e751c..5c12b3cc2947 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -258,6 +258,8 @@ kunit_alloc_and_get_resource(struct kunit *test,
 		kunit_get_resource(res);
 		return res;
 	}
+
+	kfree(res);
 	return NULL;
 }
 
@@ -293,6 +295,7 @@ static inline void *kunit_alloc_resource(struct kunit *test,
 	if (!__kunit_add_resource(test, init, free, res, context))
 		return res->data;
 
+	kfree(res);
 	return NULL;
 }
 
-- 
2.25.1

