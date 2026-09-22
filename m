Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22F54147B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079523; cv=none; b=jeapFpYR5T63PbycxTXwBTl+W/Ois8j0W0KK/khOFw0Vlx1eGFJPRA5IPefIJAW3jCsEIDpXjSU/PL5nr/EFMopNnhX3busuniqMoL/DzSlNqObdBCF0CHyxKHluSLw792Cp1dBLTGR91q9jFssR76jO+DFrfLIRR0PRSbWOEH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079523; c=relaxed/simple;
	bh=LoOZuski8uiJB2mMgnZ6om3i1HqfYTbFniLyPp2qsVY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kaFx2Za0C9z7M2l61zVnv68vbN9CH+2jOFGdHZ2aZWZIAs9Xqgk36OzzuKlu72S/3XlpWn5izpYdCEcXkVsKCrGbvUNr4hoWrOtNwIgON189FiIfTWzDM23p7HZz9I7zd5P2tEw/OuMTdsk5QmbEWUFs38gWkl+7DFbdEgF9l2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EbOJl+5D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EbOJl+5D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6011F00893;
	Tue, 22 Sep 2026 12:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790079522;
	bh=tPQOUYzKyg9PteLpGWe7l3TqgeT2cRsWDn/1c7ojo9g=;
	h=Subject:To:Cc:From:Date;
	b=EbOJl+5DIxZ7q3vFaz/5lLqovSojCeqSgE7FIuXIJf5LjO8zmGfpbww+F1jpAWBcW
	 +ajeEtbMldR4jGa16rvylnZ72zd9RTJhezPvt7YCJT0fDlb7YlNRzjDuVbNJEYDnER
	 ZPslrAhAFiCayRAmtRqMvM4tpPhS7UCrU2CybM1w=
Subject: FAILED: patch "[PATCH] KEYS: encrypted: fix integer overflow of datablob_len" failed to apply to 6.1-stable tree
To: cenzhang@linux.microsoft.com,francis@akrites.dev,jarkko@kernel.org,rnsastry@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 14:10:01 +0200
Message-ID: <2026092201-deity-art-3047@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8697c431e297eb0d0ab13dda6bc172b48a34f05c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092201-deity-art-3047@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8697c431e297eb0d0ab13dda6bc172b48a34f05c Mon Sep 17 00:00:00 2001
From: Cen Zhang <cenzhang@linux.microsoft.com>
Date: Sat, 12 Sep 2026 00:31:16 +0300
Subject: [PATCH] KEYS: encrypted: fix integer overflow of datablob_len

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
 
-	ret = key_payload_reserve(key, payload_datalen + datablob_len
-				  + HASH_SIZE + 1);
+	if (check_add_overflow(datablob_len,
+			       payload_datalen + HASH_SIZE + 1,
+			       &payload_totallen))
+		return ERR_PTR(-EINVAL);
+
+	ret = key_payload_reserve(key, payload_totallen);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	epayload = kzalloc(sizeof(*epayload) + payload_datalen +
-			   datablob_len + HASH_SIZE + 1, GFP_KERNEL);
+	epayload = kzalloc_flex(*epayload, payload_data, payload_totallen,
+				GFP_KERNEL);
 	if (!epayload)
 		return ERR_PTR(-ENOMEM);
 

