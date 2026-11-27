Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745212;
	b=rOnSTFJn9mIBFe2zoG1tfTDZHJSP5nh3QYfld/XmU6jg+MrCitwgLZe7gdcKiXablAvP
	 MIBNskM/oVO/ygiLdrvbGFP1hoQKfKbkTbPJN8ewJgsGpAEqAoEBxEQZOiiiSEM/xbziJ
	 tVI7UwQG48xUJ2+JhU5KiifX+WgxuqSSNdY2uTiixqGg9IoVFEJ0yCRoLQRyVX+hgmT/5
	 U2yZoYVNfGyWbCcQd/HGnGjpYUytiOl+oDtkFbQ3u/+JsMYZNYo064/l+Nlw5OWJnxYS/
	 XRGGn4t5L7VmYk4EzY8PXlqNZAI8IMNPav+7flTiTVV58SmT3uw+klV81Oe5JVqKB0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745212;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=NY0HV6PndfJnusJZI52dSV3HDQ5Ck0Pg/NUa29Q8I50=;
	b=w5OfyYqUu2EJw+urSl+0dLnE8rnk7PWVd9PhiVVAKQZRrut47ft/jGkNDoDgH60Hcgq4
	 0X2z2oVCzBkHdUFm46a2m8yyBso+crEoUvd0YMQV5/64QOTfOHr6mYWvWcYEnkn0dImX2
	 K1X0IwEG0SSe1w4JhBM0aArC60FQ7j5QqytnmoCjjMx0Nv5WNKdvqSivoNn5TIQgzqjW6
	 3NITx35KoNR6iOuGP4gq9VBR7o8gUHQSglgITx+Lr2ONOy3QoBVZ3zfOjxkzFQtuMVOZG
	 IId5088rB9w6y6XEYvpWju2YrFNSAMSYDjiD3aMe1d9rjtM4ilHpKuAyCp8iyLz98qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CJU3kdvL;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70959606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70959606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CJU3kdvL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795745210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NY0HV6PndfJnusJZI52dSV3HDQ5Ck0Pg/NUa29Q8I50=;
	b=CJU3kdvL812c3gSZoHIKZkNftKOxku3CnwoojJUZz/4Hmoe6JPamO31+TXoDvBB0P/II8E
	2yuwLTbZpJmMhxXC33cxwE/HWx6esxTwRp1xUa5vk5/ibnxlXHLQe1VqONGIOgx4HoOXFb
	szDrnLjnaEPEEgFLsiLZsIZJAKuM/jM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-CPYhI7hpP1OtWVFJQgnpsg-1; Fri,
 27 Nov 2026 02:06:48 +0000
X-MC-Unique: CPYhI7hpP1OtWVFJQgnpsg-1
X-Mimecast-MFC-AGG-ID: CPYhI7hpP1OtWVFJQgnpsg_1795745207
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD218180063D;
	Fri, 27 Nov 2026 02:06:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 285D71955F76;
	Fri, 27 Nov 2026 02:06:46 +0000 (UTC)
From: Bruno Meneguele <bmeneg@redhat.com>
To: bmeneguele@gmail.com
Cc: Bruno Meneguele <bmeneg@redhat.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH 1/8] pkcs7: don't cache a failed digest in pkcs7_digest()
Date: Thu, 26 Nov 2026 23:06:29 -0300
Message-ID: <20261127020636.1296460-2-bmeneg@redhat.com>
In-Reply-To: <20261127020636.1296460-1-bmeneg@redhat.com>
References: <20261127020636.1296460-1-bmeneg@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

