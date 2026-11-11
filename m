Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412741;
	b=ibtL9xyZJtr1y8uhwJ0oampwf/CoETQlaDbpVsEedpQQQlCQ7W/5pFrxZ4kNU6tR3aiW
	 VwML3rOUad6VyS4s8AOQDtK1jPGMSdNLJBy7hiqpaXbO9xPnBYVO+hAZPh4c+uIsrAaWp
	 CnHkHCWYaKOTJYLo/nwZOfDL5mqVt9JASg7ZnUxhzYL48AaRBy5z0JqdggPZ/b+RvhFd8
	 AeAbUmtB/hukokythhWf6g3HbmIi560BYRgi5hvrRgOEV1xk0VprX/MIqVOiwUe3GD+Fc
	 ChmG8KLs6okRvRI+0Rmr486FYC7+chJbO4gChi5GB7CbZN+g1yvVREJcIGLbPVY2rQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412741;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oImOupv6sF18dten5DgH8uCzzPA7MNXQ5UprHlFCaQ4=;
	b=nkqNfDZ7pfU7qaas/Ff6UTCDR8Kyz6mrOlv6m3TzLaAbGNzxpRNhcq2dGwVQVjtr7nKV
	 9rLdAaq9dj+spea3yrDA6GRS2qddqWuTRcwY+5Uy42+RBlORQyil+NKQPCgRxHgs3voIX
	 4K08kCD8DNKvRckE4VZLclPYFrXTrXjz3l9sS3qJOQx2RAX/6BC/lyPACp3L4+D+Uiig6
	 fBAG8N7dBalq3ZosPKRdU5p7kFpmFBS+/I3mbV6f0YSXCLhqbGr5s6MmnGKMPqxhYTFp0
	 Ci0k6hj9NP8nehP0u7Jpn0ktDEVgv5qdIZePDiAtuKHsLVQtqKJxVrhAec0zod1JqPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaND8zGe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6F606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaND8zGe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C284C1F00A07;
	Wed, 11 Nov 2026 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794412741;
	bh=oImOupv6sF18dten5DgH8uCzzPA7MNXQ5UprHlFCaQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WaND8zGeFoxOmWGem4VWOTJ4RA8SKCYRuSsBL1z8ezNIgmPHai7yj0cCKHv+wo575
	 XpSu/p7Ah5aHfcPC+20T/wVIe/CPlQIt/3BeubPUiFXPpnGAL/aYdzTZPBxnGbwYKp
	 XRSjV/RVb4gibwNDZpryt39T8LQ09XO7pWZI1V1wqPyxzdiRwOzZhDdKFezf2SPMdD
	 RjOS/TotS9IxIe5uOx6Kk2Aa1uiWUxlB1Fiji+hV/jPRTtLnG5oAEzaMRSQtmTxUTR
	 T03E4xx2+6abW6K2rfdOOBH/Ll+L/XoIv9sr805PQRdcwb/vI9dwW3trldBBdqhC0j
	 7RhGG1k8iFn/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] splice: avoid stale f_pos writeback on error
Date: Wed, 11 Nov 2026 10:58:57 -0500
Message-ID: <20261111155849.2761399-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111155849.2761399-1-sashal@kernel.org>
References: <20261107061356-failed-5.15-79b496ebe382@kernel.org>
 <20261111155849.2761399-1-sashal@kernel.org>
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

From: Daehyeon Ko <4ncienth@gmail.com>

[ Upstream commit 79b496ebe382866e3a05090b7dc9ae95e85e65b2 ]

do_splice() snapshots an implicit file position before calling the splice
helper. Since splice does not take f_pos_lock, another operation on the
same open file description can update f_pos while the helper is blocked.
If the helper then fails, the unconditional writeback restores the stale
snapshot.

For a directory without ->splice_read, a file-to-pipe splice fails with
-EINVAL. A concurrent directory mutation and getdents() call can advance
f_pos and refresh the filesystem's revalidation cookie before that failure
restores only the old position. The next ext2 readdir can then trust an
offset inside a directory entry and copy data from the adjacent page to
userspace.

Only update an implicit file position when splice returns a non-negative
result, matching read and write. Keep explicit offset updates unchanged.

Fixes: 7995bd287134 ("splice: don't pass the address of ->f_pos to methods")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Link: https://patch.msgid.link/20261018051708.2422394-1-4ncienth@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 70008e08998f5..3630fd18a12e8 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1107,10 +1107,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 		ret = do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
 
-		if (!off_out)
-			out->f_pos = offset;
-		else
+		if (off_out)
 			*off_out = offset;
+		else if (ret >= 0)
+			out->f_pos = offset;
 	} else if (opipe) {
 		if (off_out)
 			return -ESPIPE;
@@ -1127,10 +1127,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 
 		ret = splice_file_to_pipe(in, opipe, &offset, len, flags);
 
-		if (!off_in)
-			in->f_pos = offset;
-		else
+		if (off_in)
 			*off_in = offset;
+		else if (ret >= 0)
+			in->f_pos = offset;
 	} else {
 		ret = -EINVAL;
 	}
-- 
2.53.0

