Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D33DFC92
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557933; cv=none; b=C1WK86KAL2Y4LAJGZLS3TBYH7CMVvKKl8ObX9CTFrifWyKP4YkOhYQScs0b152ygRoInkGP/+1Y6PXe2COpueXvmoPfzSSbkCT1XDZFH0HcPor4Rqr13MMdMt9QXaHWxDc+miYUO9YCYmNFwm+ltUQ4o9WZUx2JJ3TCjDiyjkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557933; c=relaxed/simple;
	bh=vH65z0wcmYrKuSrk0tIg9RNlohc3gHUjZVnwCwtrorU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VYP25YcsbqkV2T5/4u94Gm1OvWpRWZTVP8NpWRb1We9SUK2ndebJfsmC/IvB2durABNmQ3dZWBFhZsHyyNuK3k2NM2kHlGcNK1dxiM8oqSHj+r2UN/QiiCl6I4gpHk9qkFHkRiN1tfvT1FFrPtsAh7n9N4X9dxavihqL7gvDpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=woQ7pClm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="woQ7pClm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D791F000E9;
	Mon, 20 Jul 2026 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557931;
	bh=jyJDs43z6eAnXtYasC/UA9Kjl+HCwjAiMse7dMInDbg=;
	h=Subject:To:Cc:From:Date;
	b=woQ7pClmNunMCuIPHCKDjnytRtdkX6zO0n+ZOboAFB9RStHwGbvftzRLXzSY1/87t
	 KCPA3Vemxq+Ba1bx+5DnbzpCV1/42ZhMGNjG5bH+JUYnct0GLs6fZ+8GdHZhcc99T3
	 PsI8owgAY0VdOnN2VY3NrliIKYXnnFap5XDCNGac=
Subject: FAILED: patch "[PATCH] mtd: maps: vmu-flash: fix fault in unaligned fixup" failed to apply to 6.12-stable tree
To: fuchsfl@gmail.com,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:31:54 +0200
Message-ID: <2026072054-croak-unfixed-9a14@gregkh>
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
git cherry-pick -x 79d1661502c6e4b6f626185cef72cf2fa78116e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072054-croak-unfixed-9a14@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

