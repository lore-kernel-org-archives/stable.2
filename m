Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960BB3F0A9B
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557924; cv=none; b=SMKddi4Ym6ie7wDVI77DFImjex3/Bdz4i4tTjGnU3kVDncy31vnH+x9fb5QDQkm7DnVWOrTyUJcOGj5aG/kZMVLdt/irPl7kRcEIgsirR5x4Dd7tGOaLN0j+5xCgI78pv3hrCX0woJPN9Vm482kwD1aWmzX3w1yRFWkIzT3/Luk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557924; c=relaxed/simple;
	bh=6XyFVnvZa/0lvriPuSVR1EYTlvIyHKfhnRcdbdSvJyc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VG3vbnDxF/VBuF7wUC9JA+6dwHOckWFRSx9DdvE4s9rRn0b2RaC9rJKmcmcZ08Rl6QEuZCaGDXYzuj+L0zk82NSv/qeDsBrH1SwQtKJASzMelnHwV8HwFfYVn1oUgdyU7CkgAqKXLsWxvn35trWoZAoQWQWF8aJzRGNgaoV5DZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n4Knf5zl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n4Knf5zl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FD51F000E9;
	Mon, 20 Jul 2026 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557923;
	bh=dXS6V9MaCQkDxQPHs++slquGJW+jHW08sgKOD1aDsyg=;
	h=Subject:To:Cc:From:Date;
	b=n4Knf5zlb089IaJoLGBebQS8jdNVQc2kI28rOzQyIOwo4SNq3tzoP3dJQ5QnpId/+
	 kiGecKmwsl8+y5IylbpPrceF2dhVmkDQ0rRU8E8egcffeM9279s1Jvke1OzRbeWlFm
	 M1ONGUIIRuw4sLj6EdCYEjPKI6j8Hp6M6lgZ3Bdk=
Subject: FAILED: patch "[PATCH] mtd: maps: vmu-flash: fix fault in unaligned fixup" failed to apply to 6.18-stable tree
To: fuchsfl@gmail.com,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:31:54 +0200
Message-ID: <2026072054-king-ranking-9254@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 79d1661502c6e4b6f626185cef72cf2fa78116e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072054-king-ranking-9254@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

