Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748391;
	b=xlgqgWRVGjqQL424aMshG8PWYZ/YIpPMfOJmj/2WimYhLdn+mX3Um/CUiW16qXxMoLOw
	 Qb2EJQeb0pu3SS2rKlzHTDXpG+PqXxY6WVRcVKs+5P0DXQe2zSSYQb/a/6PL9U1OerVt4
	 lENUD+49QfHx3VMkopWrTEyM97vWmpcJg75WHEevu//6D/d0gsIrMpAjh5Na8arix1DXW
	 4+9534x6GqQ9Mb182/y9WEBZbPkoqjsc7AUU64KPujadjDFhH0LJfRt1SBWU3ds2nPqum
	 cX7I+6+RzpU7O/lPqG7MaMkeMC/arBSfb2cbkkC0Jfaxu5KpeuabYL4rvicRE+rN3Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748391;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=NY0HV6PndfJnusJZI52dSV3HDQ5Ck0Pg/NUa29Q8I50=;
	b=tv/aaGgf5yEJo8CZzq2DB26cWH1JdIUPmUYAXe7Neu/J4CZggfv8nhn5bRWIOtMSqgvW
	 ifwvoIb8YIAguECkqUfcZCmED1epRKcUTQCS8eM+SuHTvrkCTTuw3uedDHYEVPpz+CP7Q
	 Y2+eCQ7PwKyNzllWdhN//aUCC0eFatR12ifHQgOZWURSJhQzAfKtuAwqGplDDTZvTqpZW
	 5EOFQvdE/BRolkHfsGasF+NBvO+PUjAqmRKCXfCQqyV7vT2DsLDxl9FK5/aC2qrLP9heh
	 4Y1PkH5chDCi6afYB9knNZro0Jk669OZRfpK/P07nyr9Rw8Q5i8ZkqDzPcIx+9fLR/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mrposg2U;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757C606A323
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4757C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mrposg2U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795748389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NY0HV6PndfJnusJZI52dSV3HDQ5Ck0Pg/NUa29Q8I50=;
	b=Mrposg2UnLBKy7VBM9scz9nLPmjaFGvgE61U+6GuDJY0bt392y3p8URxF5TSnJlyG9zMFC
	zghUZ8G8gMxPZEfj4AwTA06E8auO4WL2vvIMSYiGwzOO3s/lLirOxFLs9mW1HQwcUGLT+z
	4WoN28j65f+g0Y279HcXgBi2/DdEwlQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-jVMy_SlBO-29wTIFDjaXKQ-1; Fri,
 27 Nov 2026 02:59:44 +0000
X-MC-Unique: jVMy_SlBO-29wTIFDjaXKQ-1
X-Mimecast-MFC-AGG-ID: jVMy_SlBO-29wTIFDjaXKQ_1795748383
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E920519560AE;
	Fri, 27 Nov 2026 02:59:42 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3904D1956049;
	Fri, 27 Nov 2026 02:59:41 +0000 (UTC)
From: Bruno Meneguele <bmeneg@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dhowells@redhat.com,
	bauerman@linux.ibm.com,
	Bruno Meneguele <bmeneg@redhat.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH 1/8] pkcs7: don't cache a failed digest in pkcs7_digest()
Date: Thu, 26 Nov 2026 23:59:04 -0300
Message-ID: <20261127025912.1383750-2-bmeneg@redhat.com>
In-Reply-To: <20261127025912.1383750-1-bmeneg@redhat.com>
References: <20261127025912.1383750-1-bmeneg@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The pkcs7_digest() function error path leaves sig->m allocated when
messageDigest attribute doesn't match the content or the digest calculation
fails. Considering it can be called more than once for the same signer, a
second call after the first failed would have sig->m incorrectly set and
would skip any further check as a successful calculation.

One example of user is IMA, which hits it when measuring first and then
appraising a file module signature. With that, free and clear sig->m on
failure, so every call repeats the checks.

Fixes: e201af16d1ec ("PKCS#7: Introduce pkcs7_get_digest()")
Cc: stable@vger.kernel.org
Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 crypto/asymmetric_keys/pkcs7_verify.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 474e2c1ae21b..356570b6d6aa 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -131,6 +131,11 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 	kfree(desc);
 error_no_desc:
 	crypto_free_shash(tfm);
+	if (ret && sig->m_free) {
+		kfree(sig->m);
+		sig->m = NULL;
+		sig->m_free = false;
+	}
 	kleave(" = %d", ret);
 	return ret;
 }
-- 
2.55.0

