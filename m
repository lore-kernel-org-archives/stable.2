Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.43.10.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002331;
	b=HYs5z6Zo+xVTpnirNYeLRMH9hRR802+9XvxJj6vVG4z35nImKsbpbJlQRGC/MUYfMnS/
	 zsXy9HN/vADKXCHbqB0jzjXazjvsWGB549xWyrTYRxpE6ftyC/y9hnLvhK8t6QDH4IPA+
	 FRrZjuBi9u69yk4Bsb24i4ldQNtKy97g6891Gn9NI6GLZQ6zBpqFdh8QCv/rWBecNuvyC
	 45sXpAm8TBTq+9xaE5eArX00nbMOFVYdt1S33UJVvhypnIeclAjaGhm2XX5fXOaxlLVnT
	 tYC37kSm9pm27311P/oB/o3igxjLU6MH3urGp/h9Tpgo4iO/5MlTdc2RZwtHf842W3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002331;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tR1sg5IBn8Z95zP4i5R1hydMesQ9Jd4TyFB0yaUnNC0=;
	b=U+x7ImidgoO6kfag99kZz3fZuB6TqteC9neGG5WHOAVtrjmuPJUNvE00zJKKd3bEQhhh
	 H4tJu+CCn7IeMu68WG/qOfHjj/A2BEGVenB/wQlSCkyRuWYRE2XIOxkBI21nxNzN5Juh3
	 CFomQBcFTcvflELEE3LxEZYRHCr162lKrYdscVlCUbSYUVtwe8yXgtWbG9cJ84s+SNNMP
	 Lfuet/203gRRdxrVxD0taTBHE0bTamEdvXrH7UGtBNfojg/sC6RLvajVjL5ouAaWYHz7H
	 bOD4iwVfiQvEaddUM/Rm5Y0w5/3UF4IeBZsa5s7WOVZ0x1gFurtd+ha5t19BPVXQlLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=altlinux.org;
	spf=fail smtp.mailfrom=altlinux.org;
	arc=none smtp.remote-ip=193.43.10.250
Received: from basalt.external.altlinux.org (unknown [193.43.10.250])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAA960A5BC5
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AAA960A5BC5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=altlinux.org
Received: by basalt.external.altlinux.org (Postfix, from userid 1137)
	id 238222DF35B; Wed, 18 Nov 2026 14:45:19 +0300 (MSK)
From: Alexey Shabalin <shaba@altlinux.org>
To: devel-kernel@altlinux.org
Cc: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>,
	stable@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12/sisyphus 22/29] crypto: krb5 - use kfree_sensitive() for derived key buffers
Date: Wed, 18 Nov 2026 14:45:11 +0300
Message-ID: <20261118114518.3605222-23-shaba@altlinux.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261118114518.3605222-1-shaba@altlinux.org>
References: <20261118114518.3605222-1-shaba@altlinux.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jan Sebastian Götte <linux@jaseg.de>

commit f7d53dd3f267e46a784f219a75072f2f400d42b9 upstream.

crypto_krb5_prepare_encryption() and crypto_krb5_prepare_checksum()
free the buffer holding the freshly derived keys with plain kfree(),
leaving the key material behind in the freed slab object.

Fixes: 3936f02bf2d3 ("crypto/krb5: Implement Kerberos crypto core")
Cc: stable@vger.kernel.org
Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 731a5b6fb4c1705f9405d9029dd64ea81e336207)
---
 crypto/krb5/krb5_api.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index 03395b89cc61..b377f4f7558d 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -263,10 +263,10 @@ struct crypto_aead *crypto_krb5_prepare_encryption(const struct krb5_enctype *kr
 		goto err;
 	}
 
-	kfree(keys.data);
+	kfree_sensitive(keys.data);
 	return ci;
 err:
-	kfree(keys.data);
+	kfree_sensitive(keys.data);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(crypto_krb5_prepare_encryption);
@@ -333,10 +333,10 @@ struct crypto_shash *crypto_krb5_prepare_checksum(const struct krb5_enctype *krb
 		goto err;
 	}
 
-	kfree(keys.data);
+	kfree_sensitive(keys.data);
 	return ci;
 err:
-	kfree(keys.data);
+	kfree_sensitive(keys.data);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(crypto_krb5_prepare_checksum);
-- 
2.50.1

