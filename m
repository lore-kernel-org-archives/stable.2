Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.43.10.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002330;
	b=xK3s/dj0htVCyQArbQOt7FCli/DOEEzXjCb9dRZX5guCNax7zXSlWK9+X7svJISVGyZ9
	 8ym9S4VTixR1/6G2bwgjhq/61SxghTA75u3FcJhXwwWau2j+Q0f+SwP/rLKlv5aFXAU0t
	 PY7UMLVgJtqb5wkB2afoUxZL/T3nKWQitn/Bnun0FL+UZHXHvyuos3X7sila7b9Jq0UxS
	 NDhgFYh31g5p6qSJM5RpqmJmgWBTCgkZtnviHvqEri50r7jYx+cg/Jf/KiSBUl/Ym8Yhu
	 Upp8TFAUmBxlmf1KU+vWPSc9leg/DF5kuCBTG9c2cRz2+dTOyb1C22f25eoxYMtmEQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002330;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fRUT9Lg9z6AwPB9dQzGr9DHnfFa8cs5qYP2STJS6W40=;
	b=p9b53CEN3cnmBfTG+u1bcXF0Iw5kC8hg2xp4Wsbuq8s1Vli0jDFF1RYQJjVKRoNZczoK
	 XWhhwjGK3+DC7WFEx2rZn3GhXKnF0cpAI02vvg37p8Cr/JiHoVScEPfmtqXNI8icGJuRG
	 +G7gw0SwL/yN/c07Jd9ixnUYfob3vMiXQ8wAUcTw9sATXGXXobgyI/7luxG65k8ho9/bj
	 QPkxAdHW6Un5CSQMPJHzYLz7kSyNUiBnMzzAbgN14iVt3AKDjCQfiu2oThd268oL0o824
	 6Zd++l74wl5n7GX8sk0w1cAoPOiRfivfKK0Spqv5B2rJmPDXccfBQX9KQu+DNvS3/nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=altlinux.org;
	spf=fail smtp.mailfrom=altlinux.org;
	arc=none smtp.remote-ip=193.43.10.250
Received: from basalt.external.altlinux.org (unknown [193.43.10.250])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4E60A3812
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8D4E60A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=altlinux.org
Received: by basalt.external.altlinux.org (Postfix, from userid 1137)
	id 2008E2DF359; Wed, 18 Nov 2026 14:45:19 +0300 (MSK)
From: Alexey Shabalin <shaba@altlinux.org>
To: devel-kernel@altlinux.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12/sisyphus 21/29] crypto: krb5 - filter out async aead implementations at alloc
Date: Wed, 18 Nov 2026 14:45:10 +0300
Message-ID: <20261118114518.3605222-22-shaba@altlinux.org>
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
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

commit 6c9dddeb582fde005360f4fe02c760d45ca05fb5 upstream.

krb5_aead_encrypt(), krb5_aead_decrypt() in rfc3961_simplified.c and
rfc8009_encrypt(), rfc8009_decrypt() in rfc8009_aes2.c set a NULL
completion callback and treat any negative return from
crypto_aead_{encrypt,decrypt}() as terminal, falling through to
kfree_sensitive(buffer).  When the encrypt_name resolves to an
async AEAD instance the request returns -EINPROGRESS, the buffer
is freed while the backend's worker still holds a pointer, and the
worker dereferences the freed slab on completion.

KASAN report under UML+SLUB with a synthetic async aead backend
bound to krb5->encrypt_name:

  BUG: KASAN: slab-use-after-free in t5_stub_complete+0x7d/0xc7

The helpers were written synchronously, so filter the async
instances out at allocation time instead of plumbing
crypto_wait_req() through every call site.

Reachable via net/rxrpc/rxgk.c, fs/afs/cm_security.c and
net/ceph/crypto.c on systems with an async AEAD provider bound to
the krb5 enctype name.

Fixes: 00244da40f78 ("crypto/krb5: Implement the Kerberos5 rfc3961 encrypt and decrypt functions")
Fixes: 6c3c0e86c2ac ("crypto/krb5: Implement the AES enctypes from rfc8009")
Cc: stable@vger.kernel.org
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit ef6feb77e2d91761427c5b773edc9c97e1b706ad)
---
 crypto/krb5/krb5_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index c7ea40f900a7..03395b89cc61 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -207,7 +207,7 @@ struct crypto_aead *krb5_prepare_encryption(const struct krb5_enctype *krb5,
 	struct crypto_aead *ci = NULL;
 	int ret = -ENOMEM;
 
-	ci = crypto_alloc_aead(krb5->encrypt_name, 0, 0);
+	ci = crypto_alloc_aead(krb5->encrypt_name, 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(ci)) {
 		ret = PTR_ERR(ci);
 		if (ret == -ENOENT)
-- 
2.50.1

