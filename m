Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA754779BE
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102757; cv=none; b=C5Ex7yBF7vy2zzbHhyYDZbONKfIecyOy4fUxLujURu1PTelQOBuwa/cYpAVVisBIsXnW+17f4MTGu93cVSQBFJJ5I6ZXlDJkuNIkV563fMUtJsY6/HxZv+1nQaP82lv2DYo3IgyMfbsgzBIQlBNXJgG5ItmDyBaSEeqt39NFh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102757; c=relaxed/simple;
	bh=I6fK01foZ/fDARB0DMDHN0arhOzUrC5j/V/NCoh7MX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQM/D0WCqrp8JH19vonfLh6tiL4/6EzA9dLhcb9TD59NS7V9AJE++hEYX30Du2VA+s9q6yaEST4QOaC9+e8UcSn7cdmc3vReTte1Nhnf76q3NFkbGKgD7fr/cmMTLANinblVRO1siVkUwsq/ntCciJs6MhSD2xUmuMzS52DUE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvG8EgVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvG8EgVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F07B1F00893;
	Tue, 22 Sep 2026 18:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102750;
	bh=LnpIrI5j9O+mv14fC4H8dbCUYPaWvWzBPJZOyPnRhU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CvG8EgVYz7nGcOIbns53g2jb2AZASvinDjebSqjkHig5gyMe8kZEo6EZs2Hitzfon
	 iyxsBpLL6u2tDX9a+Hi4mIA63zThmzCxJqxRkFfWAtBdxaGn8dlFxIeGJQr2iZjVbc
	 p7BV7rlCnf6HrTrBDhuAWKI9wtm+wYRk0H3S3ee+zqztPFhsl0Q5h3eDFVPZ3+yPM+
	 Ynvki9g1kU4JRXxD0wDVwF0oowQRz4ZdVQzMkB3eQbZxYDrQx9CxAMKqSU0LH9EAXV
	 cFH4gW3JM2Shh/gALZNexZxm40xI8E5nL31GGYbyu2LlnJ4FjO9rQqqcsIKm9zBGr5
	 kMq0kV8gTsKVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cen Zhang <cenzhang@linux.microsoft.com>,
	Francis Perron <francis@akrites.dev>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	R Nageswara Sastry <rnsastry@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KEYS: encrypted: fix integer overflow of datablob_len
Date: Tue, 22 Sep 2026 14:45:48 -0400
Message-ID: <20260922184548.3790526-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092202-sapling-foster-2f79@gregkh>
References: <2026092202-sapling-foster-2f79@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cen Zhang <cenzhang@linux.microsoft.com>

[ Upstream commit 8697c431e297eb0d0ab13dda6bc172b48a34f05c ]

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
Assisted-by: GitHub-Copilot:claude-opus-4.6
Signed-off-by: Cen Zhang <cenzhang@linux.microsoft.com>
Signed-off-by: Francis Perron <francis@akrites.dev>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Link: https://lore.kernel.org/r/20260909153433.83117-1-cenzhang@linux.microsoft.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
[ replaced unavailable kzalloc_flex() with kzalloc(struct_size(...)) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/encrypted-keys/encrypted.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 192e531c146f5..358bcb41ab23e 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -18,6 +18,7 @@
 #include <linux/parser.h>
 #include <linux/string.h>
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <keys/user-type.h>
 #include <keys/trusted-type.h>
 #include <keys/encrypted-type.h>
@@ -599,6 +600,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 {
 	struct encrypted_key_payload *epayload = NULL;
 	unsigned short datablob_len;
+	unsigned short payload_totallen;
 	unsigned short decrypted_datalen;
 	unsigned short payload_datalen;
 	unsigned int encrypted_datalen;
@@ -633,16 +635,22 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 
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
+	epayload = kzalloc(struct_size(epayload, payload_data, payload_totallen),
+			   GFP_KERNEL);
 	if (!epayload)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.53.0

