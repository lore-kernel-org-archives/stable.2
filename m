Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467B3DFC92
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557940; cv=none; b=u5KMkUdFBFiUxtWDtyPrmYiBf9PH/Y9nCh5qM2PwOd0CGGoF6+1gZooP0jjPKyUOhdQiB7tivZ+Ri/WWtWP9M6Zpmuv+PP5/ek05diOTtZV4AUOooCLfzaY9c7kTKd8z0Uf2JB5b1R57yHrumiPoBneAArx24zdvVVv4BjjcxrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557940; c=relaxed/simple;
	bh=SgoUwZXFQQNxl+F/8inlp7txV3C1r5ysBlbIJnEq4I8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IGIEWhpc+wXfuj2FFlsL6q6BjMvES7BUmTeNoO5ijPKeAo9Pu07ztLQFZfCb+KAqu8gBK6L1JWwD2oLZibFnwquAdY2VAW3WGyrt9+29RMeW3LENrV2JfqZ7aT+UEXvo4VGCjJYqMYVNGIcQh3yD2rqeRC/5orFBdQ3W/2E2ZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fSiUGhRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fSiUGhRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092751F00A3A;
	Mon, 20 Jul 2026 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557939;
	bh=HFsexr8/b6MymBSxoKTu3LM3UGbhoy2NgxHmxanX7As=;
	h=Subject:To:Cc:From:Date;
	b=fSiUGhReme47yJrTPuA9Ku5j3C8VX/HvGls00p/eJr+R7jm1NjNqxHkwxVB3jw2PK
	 mtaCITyrsMoQ47IxKgGoUa9Wc2e7TkSni/zKiwLB/lXgY+wUPmys5Q+/FTfBU9XN83
	 GnyYUxhYcSiCeeHeXNT7toydNERTP+SdT6tKEgWc=
Subject: FAILED: patch "[PATCH] mtd: maps: vmu-flash: fix fault in unaligned fixup" failed to apply to 5.10-stable tree
To: fuchsfl@gmail.com,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:31:55 +0200
Message-ID: <2026072055-underwear-richness-fd5f@gregkh>
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
git cherry-pick -x 79d1661502c6e4b6f626185cef72cf2fa78116e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072055-underwear-richness-fd5f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 79d1661502c6e4b6f626185cef72cf2fa78116e1 Mon Sep 17 00:00:00 2001
From: Florian Fuchs <fuchsfl@gmail.com>
Date: Mon, 18 May 2026 13:45:20 +0200
Subject: [PATCH] mtd: maps: vmu-flash: fix fault in unaligned fixup

Use kzalloc_obj() / kzalloc_objs() to allocate the memcard structs,
instead of kmalloc_obj() / kmalloc_objs() to prevent access to
uninitialized data.

Fixes runtime error: Fault in unaligned fixup: 0000 [#1] at
mtd_get_fact_prot_info.

Fixes: 47a72688fae7 ("mtd: flash mapping support for Dreamcast VMU.")
Cc: stable@vger.kernel.org
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 75e06d249ce9..b76d0609d1b7 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -609,7 +609,7 @@ static int vmu_connect(struct maple_device *mdev)
 
 	basic_flash_data = be32_to_cpu(mdev->devinfo.function_data[c - 1]);
 
-	card = kmalloc_obj(struct memcard);
+	card = kzalloc_obj(struct memcard);
 	if (!card) {
 		error = -ENOMEM;
 		goto fail_nomem;
@@ -627,13 +627,13 @@ static int vmu_connect(struct maple_device *mdev)
 	* Not sure there are actually any multi-partition devices in the
 	* real world, but the hardware supports them, so, so will we
 	*/
-	card->parts = kmalloc_objs(struct vmupart, card->partitions);
+	card->parts = kzalloc_objs(struct vmupart, card->partitions);
 	if (!card->parts) {
 		error = -ENOMEM;
 		goto fail_partitions;
 	}
 
-	card->mtd = kmalloc_objs(struct mtd_info, card->partitions);
+	card->mtd = kzalloc_objs(struct mtd_info, card->partitions);
 	if (!card->mtd) {
 		error = -ENOMEM;
 		goto fail_mtd_info;

