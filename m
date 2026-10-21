Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595541;
	b=LOuQLg+68mtTQvva2sakjzQU9kqXLGXcEdTsSAivc/7kjx8JgHrkSF/eAmk1sGdHFyq4
	 +J2nDyOxeW6LKxxfZxBIhHwiPqZflWKnWI9ZUMOejyqIknxPYsK4GMp2yQ+B/nmGov84Y
	 new7RBKYpF7XfHlnvVZ+C8e7LDhavoqPjyInc0N486IPuAcigzvk1PIeuy7g7Elw/N3+6
	 wiar9ySoXlR+lo7jEEl/tHyDdFl7kS2juLHruWZlw2fQ5vwYo/HnshmBf90mRNnIML0H+
	 cNqiU6Zl1KyDFHQP5dbSQDM+lwLDIqFvMcFT729CvHW64E/+LZyNj8PBMM0vADF2cOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595541;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MY+Cje2Mr0xqGWQX2oZ5IqmavZDfOPm0dXS9J0UNG4c=;
	b=q54q+1qH4dTxgAUbbcIvb8B4MhLdBtFIN8WKCLj3xV+p0ouN1C1GZ1KuBUmjcqyNd680
	 JB3aeMY7G5SWV0TdARngLHt26glamFl2wYbMNakdN/qZd1VBpYV7691mQP7sms7DadL4f
	 MYIGpQcYp5JJbQMmyb22EIPkZ/EWjEUWGCB2dwnWlDTU6DC5th8vPGBR2UeBkRqwCUA+B
	 kK+Fl0yY7NRB4Y48MtWX65Itav8Bj1c9NoDpJQdmqvDImvY1XPJB5Rd86RkdAaeDzAzGq
	 1vCoOs9Pjzl/0hiZvceLrJc8miGWqT1J1ic8XXRBWGyyXSkLHnu191gwsTuvGTD+/kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IDDSzUU5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B1606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IDDSzUU5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ECA1F000C1;
	Wed, 21 Oct 2026 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792595541;
	bh=MY+Cje2Mr0xqGWQX2oZ5IqmavZDfOPm0dXS9J0UNG4c=;
	h=Subject:To:Cc:From:Date;
	b=IDDSzUU5VkwPW907y/DxfDZFsWYp3M5Nhe9BcdzwvF9/5YGi41IpYcmbqlDjvDd9Q
	 IqlPbih4OFTjIGZ9jrN7Fa6GrDK5CLEzlAiJtdTdWJb7riq45MOujCx+u9+/NnJOZP
	 UwTPNxw4srjjiXVUNkSVR64OQbOOW/HD6q11REDY=
Subject: FAILED: patch "[PATCH] dm-integrity: fix infinite loop on discard with large tag" failed to apply to 5.15-stable tree
To: ben@cressey.dev,jose.fernandez@linux.dev,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:07:07 +0200
Message-ID: <2026102107-handled-starlight-f1cb@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 18d80c77b4c7dd20699e81cedfbbff4e9d198f28
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102107-handled-starlight-f1cb@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

