Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000874BE1
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557938; cv=none; b=KueXrVhQ4QV8hWbn4ZSnJySIsc7Xi/5dhQXhVx1hrqp1LrKsfo9OpZpjnBpcYlZAQra+vvtFzZouQGKZkfRd2BVzTCoSOfe/WLBke3z6OH5QvlIdmKZHHBYry/DY54DeSzrS/CYrRj09wW7gVO6ye0A9juRo63zmxVbknPKTneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557938; c=relaxed/simple;
	bh=wx5FNEXB+I5iaw3g/TkoIVkXfM++XutjaWmlS5WG8lE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gVrDtZ8iLy+9x6zc2aUhcZA0dAxrKHXKgaTLCk1a8N5P6Ejq1F+VV+ZXFz4U52ezxKD62ASenruTurfUo+C3/R1yhOKoZnm03EdNhcL8W8elbt6tYrywkkhHvxoJCT2OqL2yVEhjUCDkySfrvITJL+QjQCZeWE6eXICwHaTIhrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r6e1MVnP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r6e1MVnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6590C1F000E9;
	Mon, 20 Jul 2026 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557936;
	bh=yM9NsuVA9KvCdm4ljQiGh7sEe9dokgvRVKBoyOOerPI=;
	h=Subject:To:Cc:From:Date;
	b=r6e1MVnPSucDn1+3DzoI2ADKANV+72+MatfbyoJBP3F30xpMzEcQ4ijiI8eIDtm3O
	 G/D+u377mc1Lx8aaHNstnvXa9mtXJiadCvNVkjMNaKGDkaDexpfGhKWaYs/DK8WAzQ
	 ZzMbbn/phPnZCCcDH6z5knw4KbLwX5wokrk4NfYA=
Subject: FAILED: patch "[PATCH] mtd: maps: vmu-flash: fix fault in unaligned fixup" failed to apply to 5.15-stable tree
To: fuchsfl@gmail.com,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:31:55 +0200
Message-ID: <2026072055-excusably-purge-be46@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 79d1661502c6e4b6f626185cef72cf2fa78116e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072055-excusably-purge-be46@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

