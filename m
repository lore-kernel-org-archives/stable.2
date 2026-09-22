Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E903B8BC5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101860; cv=none; b=NHP3OQfhJKZpKPa3eZ6qTVHOmx/BHIajgy8yWUYPX893C6p3/HvCn77xBF4Rlv52RRSEroAurio7Rl8cmZ8VN47Lcq9Sp7tOqOxe8viddvn5mZ5CodcLYxxKi14LVAQiPuZdBRF+tITfc1+4mhCkMqU13+ggGA8Me0Hm6H4XRU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101860; c=relaxed/simple;
	bh=DzrXO+ieTh2mycFph5KIteafnqRoXfjtxzpfEqImHjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnO/+dlm+9uUzGU9gDrP2TiKVz4T0CD7nzYVVP40aNinDY7AhWXI2k/Bhm7nhhwZ+K1B3GdY+eCRvjO9IE51b0NOwVRQlP225K02T4516pyxuJHZ6XaX3g1Nc0Ge/yiK30sUSZpiDRJvOiGAu4aB9tHpfPMlYZrL4pUFLmPJejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dECqEtNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dECqEtNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FE11F000FF;
	Tue, 22 Sep 2026 18:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101858;
	bh=mjuxcnhf4cvZQ9qX3eILYszPbfXFMCCfk0ZYnnH6jJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dECqEtNGzihhXUevImG4YRnRikmhzqiMkvK91GvhUGcgrKXfLZHBhk69R97T0r3rd
	 fK8a6LJPi9kHThNprgmZbWqDnYpJJcwOW4P4nA9BaM/nKsiMcQKcKYu1SEWiIJ5ZLJ
	 LjFSS7RC0ZdqYhuz3gYOT8UiqmzZzy9VkUiymRim0KK8UfhlLP+2dfdi83DxWYRms7
	 SJn4IirR+gOxt238YHkmykpAM3qF5yri9XRZKmWXJo4jS8Rtqxs2y3vPqd1O5SGe0r
	 O/9KWlmo8ebuWfCqutTLi20jGdLWECwGzbii/kSk2aFnO66L5z8eBYHza1LSfiVRyg
	 rPv2DfA6aytcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cen Zhang <cenzhang@linux.microsoft.com>,
	Francis Perron <francis@akrites.dev>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	R Nageswara Sastry <rnsastry@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KEYS: encrypted: fix integer overflow of datablob_len
Date: Tue, 22 Sep 2026 14:30:55 -0400
Message-ID: <20260922183055.3659298-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092201-deity-art-3047@gregkh>
References: <2026092201-deity-art-3047@gregkh>
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
index 1e313982af02a..b39bf082d5a29 100644
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
@@ -606,6 +607,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 {
 	struct encrypted_key_payload *epayload = NULL;
 	unsigned short datablob_len;
+	unsigned short payload_totallen;
 	unsigned short decrypted_datalen;
 	unsigned short payload_datalen;
 	unsigned int encrypted_datalen;
@@ -659,16 +661,22 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 
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

