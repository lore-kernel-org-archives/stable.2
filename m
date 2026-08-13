Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268F347F2DD
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629676; cv=none; b=TTBgCab6MJGZfz5GwTm5TSZX/ueudX6642BUjM07VYJwH7d95qUvDj1eLU1Nt3GHLVjNQ8DxaHlIM0WrLXx0QDeQ9XkEmlcd+8QSb/NrP08Svb/DzoA329gUxENGhGbsPQMhXD9vKjfcEeBmpdP6jpj8OhtQCzkMiWvSBIJlJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629676; c=relaxed/simple;
	bh=wxjZCs9hYEpM9tlo8/Kh+pKrRnnfQtrFSBbQygpeHYQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jxsYzrBRqpDOri7xPBO9v/rrtetzux3fd+XrUn7APj0fBO3R6p4NVj8jIBKFhxaiaaSrbc73VSPxOgxVBJ8WBOKI/Db6gJnc3tlFBWOhUzfrDNljSZZpMFAWg6TcJCnFOnxqtGvUkxqKxAGhlVhxA2tS0iBADH93d9WwVcJaHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qasnq0ge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qasnq0ge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4082B1F000E9;
	Thu, 13 Aug 2026 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786629674;
	bh=bFE/Hct37g3gp/p/VbjKIam8PkWR1MB0sjJZC6/Dp+k=;
	h=Subject:To:Cc:From:Date;
	b=qasnq0geijWf/+vM87rCBfvII2jWDjDtKrqLAA8kUrJ41vekNIny50G9u7ferQzOs
	 oNIf0siy3U7v/cVhVtjdbBVyrLETAxDgnczHf0MWqNkvZpmJKeRWCnZ9rYP+fwxSHc
	 XCDU9SXmvg9wnMa6eCZJ+suz1ax5HhInsW6gvm+I=
Subject: FAILED: patch "[PATCH] ima: fix out-of-bounds read in xattr_verify()" failed to apply to 5.10-stable tree
To: locnnil0@gmail.com,zohar@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Aug 2026 22:55:11 +0900
Message-ID: <2026081311-refutable-kiln-56fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5ff232d31106f45ac87c3b64e1d35a0667777797
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081311-refutable-kiln-56fe@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ff232d31106f45ac87c3b64e1d35a0667777797 Mon Sep 17 00:00:00 2001
From: Lincoln Wallace <locnnil0@gmail.com>
Date: Mon, 3 Aug 2026 10:50:21 -0300
Subject: [PATCH] ima: fix out-of-bounds read in xattr_verify()

The digest-length check in xattr_verify() mixes int and size_t:

	if (xattr_len - sizeof(xattr_value->type) - hash_start >=
			iint->ima_hash->length)

sizeof() yields size_t, so the usual arithmetic conversions promote
the whole left-hand side to unsigned 64-bit before the subtraction
runs. For a truncated xattr this underflows instead of going negative:
a 1-byte IMA_XATTR_DIGEST_NG xattr (xattr_len == 1, hash_start == 1)
turns "1 - 1 - 1" into SIZE_MAX, which is trivially >= ima_hash->length.
The check then passes and the following memcmp() reads
iint->ima_hash->length bytes starting past the end of the buffer
vfs_getxattr_alloc() allocated for it.

Nothing upstream clamps xattr_len back into a safe range first:
ima_get_hash_algo() only special-cases xattr_len < 2 to pick a default
algorithm, and evm_verifyxattr() returns INTEGRITY_UNKNOWN rather than
failing when no HMAC key is loaded, so a truncated security.ima value
reaches the length check as-is.

Rewrite the comparison so every operand stays a signed int and no
implicit conversion to size_t can occur.

Fixes: 3ea7a56067e6 ("ima: provide hash algo info in the xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Lincoln Wallace <locnnil0@gmail.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 18d0d9154317..ced2e131b061 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -274,8 +274,13 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 		} else {
 			set_bit(IMA_DIGSIG, &iint->atomic_flags);
 		}
-		if (xattr_len - sizeof(xattr_value->type) - hash_start >=
-				iint->ima_hash->length)
+		/*
+		 * Use addition, not subtraction: sizeof() forces unsigned
+		 * math and a short xattr_len would wrap around, bypassing
+		 * this bounds check.
+		 */
+		if (xattr_len >= (int)sizeof(xattr_value->type) + hash_start +
+				(int)iint->ima_hash->length)
 			/*
 			 * xattr length may be longer. md5 hash in previous
 			 * version occupied 20 bytes in xattr, instead of 16

