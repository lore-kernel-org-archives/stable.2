Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69B914A619
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560723; cv=none; b=sy4WfyDHB9Xa81F6cJdsw2do9NN9LaGEnOIBtxuPS25GUhofVsJDPrTSMns2Hg3l9OrcVj6vmec5DFRqAXSJfEv5tP3e9k4gKzqqn0yJ6hkWyjy20xNmWcKWmTelLx2trJ3lq+vZ8LlOERAFMcHOYOo2frJMHX5ev8tRVnYkXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560723; c=relaxed/simple;
	bh=1qmMuV4lQd2O9D0H/7EAVLLg5vSaAIZp6qhynJt+dbM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dpQTP0ST6eeYgz2qMU2fnuwWQ3+m6RxRGIkPNH3VmVZpPNIHxLUggs92hELIcfEnMTbA3THBFiFZIcHGDmB7dRuclhX/4f6nJ4DUwurMSQySvkc0JsdxIROmIFJ6b34QoYt9xzt+ffzAm1Xkpa19dB+5jeuVU80KJXV/6+5868s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pp/bOki1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pp/bOki1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C166B1F000E9;
	Mon, 20 Jul 2026 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560722;
	bh=qTZ6j+SGRw+HkfDiO6HcjDP24cjTDQv0w64T5kKvhCE=;
	h=Subject:To:Cc:From:Date;
	b=pp/bOki19tI6t1KwXgVYw5fHc2a3d5x8rdptI4FE3785pVBTBqCo1Pk+eh/xaE7ql
	 T8TkQtemVAsAhApsgSUlvGscBDmJyx/Yk703c67Oq+w5CFPLVnsxWK2poQ6TK7Z0Sj
	 PWpmvY5RXy9FTJ5nJnHnmXeYj14rL5L9f0KUA/2c=
Subject: FAILED: patch "[PATCH] dm-integrity: fix leaking uninitialized kernel memory" failed to apply to 6.12-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:18:33 +0200
Message-ID: <2026072033-produce-defense-a018@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7bb03b2b01b814a9fc14afbfc2cbb2cca5b34750
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072033-produce-defense-a018@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7bb03b2b01b814a9fc14afbfc2cbb2cca5b34750 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 9 Jul 2026 21:22:47 +0200
Subject: [PATCH] dm-integrity: fix leaking uninitialized kernel memory

If hash size is less than device's tuple size, dm-integrity is supposed
to zero the remaining space. There was a bug in the code that zeroing
didn't work. This commit fixes it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-4.6
Fixes: fb0987682c62 ("dm-integrity: introduce the Inline mode")
Cc: stable@vger.kernel.org

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index dbabb8e46fb7..02b2805ed33a 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2606,7 +2606,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 			struct bio_vec bv = bio_iter_iovec(bio, dio->bio_details.bi_iter);
 			const char *mem = integrity_kmap(ic, bv.bv_page);
 			if (ic->tag_size < ic->tuple_size)
-				memset(dio->integrity_payload + pos + ic->tag_size, 0, ic->tuple_size - ic->tuple_size);
+				memset(dio->integrity_payload + pos + ic->tag_size, 0, ic->tuple_size - ic->tag_size);
 			integrity_sector_checksum(ic, &dio->ahash_req, dio->bio_details.bi_iter.bi_sector, mem, bv.bv_offset, dio->integrity_payload + pos);
 			integrity_kunmap(ic, mem);
 			pos += ic->tuple_size;

