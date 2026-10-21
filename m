Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595538;
	b=G3lXkCRrOThs8I9a1nqNJCd69tT5meMenWyWgUAn1LrBf662VxWO0nL0QhL/8uzni6Mz
	 /Xs1oViVuwtjI9NAssOcC9e9RSBmrvpxKhOE/v5uWVYA9r0mE8mPr1zhI7GIt3khTwj+z
	 /2srHY2aVJFpiLVLcaFnYiL+ByTANo436fap+ZueV5/k7u5UHWhbZMEcmII+4D/irwQw8
	 +mJBXGSRa13oB9nP6l8X1z4/CTQlcsGNRDGQA6Y4I/9yvJECmNLaYtZL15orig40+UH1a
	 3pmV0TbIJ6GTt8Ts2z17Og7DJg5sIcoFjiLyROn2899W5Xdxd0hY/b7wSrAVg56Zw0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595538;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nDyafuqAyS4w/TxvJKE43dap8AlkRGVyNwPuWJqK93M=;
	b=jR+x8OBXTBXZ8nj+kIHk/zAeoe5dET7QulOcEA1PV7fM0qf2y78iJjP5sNeMT9VkqLhb
	 uCh29KOPBOrFq4p142BrTgTnnTsfsrZw2FcIbAOvsvgkzYwZJXB++8OgxGtj8iB1ZzW64
	 01snV9Uf5IYVEdUEPAZw6D3aZW3SEv2p/xMsdPwGp/JbWxK93isg4cc2v1ZNeBZ/0ui3f
	 cTaYDBMeKLAW8xW/2iTN7pKL1ujs3ia6KA0MjS8th7rq3P5CfvM2mEOuwOf7ryqb8lZyl
	 lLKJ04npfRU6TKoMn1QIHq25kMTG9H3tH7wkCZ4/TS4dMKPbqmrQ5/QoYkI/mXtDrBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IT5jBD0L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AC5606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IT5jBD0L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242301F000C2;
	Wed, 21 Oct 2026 15:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792595537;
	bh=nDyafuqAyS4w/TxvJKE43dap8AlkRGVyNwPuWJqK93M=;
	h=Subject:To:Cc:From:Date;
	b=IT5jBD0L6sDV2fV4/f/W6xlFtpjLIPA1sxpBHHkIb7EoXEa72mAzItQ3KpqNmmbN4
	 K/J1J2eDNGyULHhbR0VVPYtVKZtkGVwwIj9hedwpeC5AMq0qGjfAZbXi/0a3QRACwk
	 RcBDTX/xQ+S6DCjuIFBZj2v8IoCBjwNnV8eok+PM=
Subject: FAILED: patch "[PATCH] dm-integrity: fix infinite loop on discard with large tag" failed to apply to 6.6-stable tree
To: ben@cressey.dev,jose.fernandez@linux.dev,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:07:06 +0200
Message-ID: <2026102106-hacker-likely-7fd3@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 18d80c77b4c7dd20699e81cedfbbff4e9d198f28
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102106-hacker-likely-7fd3@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 18d80c77b4c7dd20699e81cedfbbff4e9d198f28 Mon Sep 17 00:00:00 2001
From: Ben Cressey <ben@cressey.dev>
Date: Thu, 20 Aug 2026 21:44:58 +0000
Subject: [PATCH] dm-integrity: fix infinite loop on discard with large tag
 size

When integrity_metadata handles a discard, it fills a buffer with
DISCARD_FILLER and writes it over the tags, max_blocks blocks at a
time. If the kmalloc fails, the buffer is the on-stack array
checksums_onstack and max_size is set to HASH_MAX_DIGESTSIZE. So if the
tag size is larger than HASH_MAX_DIGESTSIZE, max_blocks is zero, bi_size
is never decremented and the loop never terminates.

Fix this by using sizeof(checksums_onstack) as max_size. The array has
MAX_TAG_SIZE bytes since commit b93b6643e9b5 ("dm integrity: fix a
crash with unusually large tag size"), so max_blocks is at least 1.

Fixes: 84597a44a9d8 ("dm integrity: add optional discard support")
Cc: stable@vger.kernel.org
Reviewed-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Signed-off-by: Ben Cressey <ben@cressey.dev>
Assisted-by: Claude:unspecified
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index d4fe85d61d33..5327d7c6a71c 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1979,7 +1979,7 @@ static void integrity_metadata(struct work_struct *w)
 
 		if (unlikely(dio->op == REQ_OP_DISCARD)) {
 			unsigned int bi_size = dio->bio_details.bi_iter.bi_size;
-			unsigned int max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : HASH_MAX_DIGESTSIZE;
+			unsigned int max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : sizeof(checksums_onstack);
 			unsigned int max_blocks = (max_size - extra_space) / ic->tag_size;
 			sector_t sector = dio->range.logical_sector;
 

