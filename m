Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E66A5650ED;
	Wed,  9 Sep 2026 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968096; cv=none; b=kn27wm4VHLhv0M9UJzy4JXoDjNwBnrrMw0poGDvrVwh8d3yo+A0pkTOojb6jPYN27y2DQwPP6J3LTUKOZAFVAKQbKfPp0SQ581zbJ7miPHYdjvgRDOguwSR1zGYPovIEVorILbYyJQcYXFpVpjJRE6fdbMhfUgMPBzDPChhXxRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968096; c=relaxed/simple;
	bh=jT/6qnvM4oWKTmyPgJEH4m3bosIGhZyi2XddKFBfyHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gXHA4pVSsmMVrfIfTaB8ybnvC96sp3P1HDP/oH1o7aLLPxr+hynAo8y1LyojaOkp1FdkdBN3AyujifezoNK3SNbmoCavguJklyRE2/uBiPkwZKyVAymXxyQgYRRTt/EtJ61C0RuOpWy1FvD7MoNQL6clOIFe0WUDRkTrVzZrkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hfbBBrrP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hfbBBrrP"
Received: from localhost.localdomain (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8ECCD20B712B;
	Wed,  9 Sep 2026 08:34:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8ECCD20B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788968053;
	bh=jkyd3viOhcP/SUiBsKXxAPjfzXvVxxIT/POrqkoVbf0=;
	h=From:To:Cc:Subject:Date:From;
	b=hfbBBrrPi77CTw1i4sjs5KAuGhQqQAaEPyK+N+Xd3mMjZxM+TbtOuyJ/ga+gXKPGJ
	 OIS5f+ycs4X+bHlDfjatM6cwDFuBrkrm3Evn+DMINubroOTAVnUwh+lxPD4CIvr9hw
	 fk/IUsnO/SRHYZRyPjcNAP0sxuZ/Az5u2luI2MaE=
From: Cen Zhang <cenzhang@linux.microsoft.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Roberto Sassu <roberto.sassu@polito.it>,
	David Safford <safford@watson.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Francis Perron <francis@akrites.dev>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Akrites SIRT <sirt@akrites.dev>,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: [PATCH v3] KEYS: encrypted: fix integer overflow of datablob_len
Date: Wed,  9 Sep 2026 11:34:33 -0400
Message-ID: <20260909153433.83117-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

encrypted_key_alloc() stores datablob_len in a u16. It is computed from
multiple string and payload lengths. If the result exceeds U16_MAX, the
assignment truncates the allocation size. KASAN reports a 32760-byte
slab-out-of-bounds write when __ekey_init() copies the master key
description into the undersized buffer.

The total payload length stored in key->datalen is also a u16. Use
check_add_overflow() to reject values that do not fit either destination,
and use kzalloc_flex() for the flexible-array allocation.

Fixes: 7e70cb497850 ("keys: add new key-type encrypted")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/keyrings/20260826154456.85974-1-blbllhy@gmail.com/
Assisted-by: GitHub-Copilot:claude-opus-4.6
Signed-off-by: Cen Zhang <cenzhang@linux.microsoft.com>
Signed-off-by: Francis Perron <francis@akrites.dev>
---
Changes in v3:
- Describe the bounds using u16 and U16_MAX and simplify the commit
  message.
- Include the KASAN-reported write size.
- Remove organization names from the author and sign-off identities.
- Remove the unnecessary off-list discussion note.
- Use cenzhang@linux.microsoft.com.
- No code changes.

 security/keys/encrypted-keys/encrypted.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 59cb77b237b3..e07092ea301a 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -19,6 +19,7 @@
 #include <linux/parser.h>
 #include <linux/string.h>
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <keys/user-type.h>
 #include <keys/trusted-type.h>
 #include <keys/encrypted-type.h>
@@ -579,6 +580,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 {
 	struct encrypted_key_payload *epayload = NULL;
 	unsigned short datablob_len;
+	unsigned short payload_totallen;
 	unsigned short decrypted_datalen;
 	unsigned short payload_datalen;
 	unsigned int encrypted_datalen;
@@ -632,16 +634,22 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 
 	encrypted_datalen = roundup(decrypted_datalen, blksize);
 
-	datablob_len = format_len + 1 + strlen(master_desc) + 1
-	    + strlen(datalen) + 1 + ivsize + 1 + encrypted_datalen;
+	if (check_add_overflow(format_len + 1 + strlen(master_desc) + 1
+			       + strlen(datalen) + 1 + ivsize + 1,
+			       encrypted_datalen, &datablob_len))
+		return ERR_PTR(-EINVAL);
+
+	if (check_add_overflow(datablob_len,
+			       payload_datalen + HASH_SIZE + 1,
+			       &payload_totallen))
+		return ERR_PTR(-EINVAL);
 
-	ret = key_payload_reserve(key, payload_datalen + datablob_len
-				  + HASH_SIZE + 1);
+	ret = key_payload_reserve(key, payload_totallen);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	epayload = kzalloc(sizeof(*epayload) + payload_datalen +
-			   datablob_len + HASH_SIZE + 1, GFP_KERNEL);
+	epayload = kzalloc_flex(*epayload, payload_data, payload_totallen,
+				GFP_KERNEL);
 	if (!epayload)
 		return ERR_PTR(-ENOMEM);
 

base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
-- 
2.55.0
