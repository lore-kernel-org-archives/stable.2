Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28DA3932F7
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572481; cv=none; b=Y2QHi0x9ka97LRIGmfNgjc2/31Rynb/Zr1Q8HBpstGRWka5OOBt2QmXdaERVyF0cd+ORemJWfPj2t2sq79wXym1fv8v6iL2qG9RfKvi6Q7rN6PXort53JU+BjXfLmtnxEtXt83cLZoboTcBjV5o0repI4n7zAt3c39FIYCNdJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572481; c=relaxed/simple;
	bh=Dlo/j7aJP3tGJOSnYXi7QrTcYCWI6XtEgM+LMR/hjTI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J4srmOhW36N+y22cFqA466By8ljzmZUce1/tQCfa45ozTP4uLvc+Ro0T4rc6JidhtILMZpeV1VFbkigKsmUImX7MrJh5nBvNq+l5v71hm9E208MOnNSvXz0fS+qqas2shh6MJXVIoFRmnJTerHdhQPrZ3A7e1dIpAluC5k8Do2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mh9Zu/cb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mh9Zu/cb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ECB1F00899;
	Wed, 16 Sep 2026 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572477;
	bh=7l4qup+RGVK2Ee0W1digmfWk1IZbbZIMEHgWwjiIY5c=;
	h=Subject:To:Cc:From:Date;
	b=Mh9Zu/cbdoamoc83pFRTMbsNNLcmFbkgo2QaKk8vUs1J9JAUEEhPLiF47BqCn9nJ9
	 JhrhSZY2xmzlXne4giqAYXCATsC2DacddUd72kIBPK3T4oo4H6z/Gs3DCPa9qaXoBH
	 nJftITo7PE20fjavKx7ADN66bd+kzUDcux95wgf8=
Subject: FAILED: patch "[PATCH] bootconfig: Fix integer overflow in initrd size check" failed to apply to 6.1-stable tree
To: mhiramat@kernel.org,ekffu200098@gmail.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:15:17 +0100
Message-ID: <2026091617-grudging-framing-3324@gregkh>
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
git cherry-pick -x 7812d6dab0698001e50e8c2f901e17da3eb6f429
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091617-grudging-framing-3324@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7812d6dab0698001e50e8c2f901e17da3eb6f429 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 11 Sep 2026 00:15:34 +0900
Subject: [PATCH] bootconfig: Fix integer overflow in initrd size check

Sashiko reported that in get_boot_config_from_initrd(), a crafted initrd
with a huge bootconfig size (such as 0xFFFFFFFF) can cause the pointer
arithmetic:

    data = ((void *)hdr) - size;

to wrap around on 32-bit systems (or when pointer subtraction overflows).
Because data wraps around, the subsequent bounds check:

    if ((unsigned long)data < initrd_start)

evaluates to false, bypassing the check. The kernel then calls
xbc_calc_checksum(data, size), which attempts to read 4GB of memory,
hitting unmapped pages and triggering a fatal kernel page fault during
early boot. Furthermore, on 64-bit systems with an initrd > 4.29 GB, an
unbounded 32-bit size can similarly bypass the initrd_start check.

Fix this by:
1. Ensuring the initrd is at least large enough to contain the bootconfig
   footer and verifying hdr is within the initrd bounds.
2. Checking that size does not exceed XBC_DATA_MAX and does not exceed
   the available space between initrd_start and hdr before performing
   pointer subtraction.

Link: https://lore.kernel.org/all/178905333479.213925.1358412668943562406.stgit@devnote2/

Fixes: de462e5f1071 ("bootconfig: Fix to remove bootconfig data from initrd while boot")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260910010137.EE0431F000FF@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Sang-Heon Jeon <ekffu200098@gmail.com>

diff --git a/init/main.c b/init/main.c
index 2613d3f9b3ce..16749bb7a219 100644
--- a/init/main.c
+++ b/init/main.c
@@ -277,7 +277,8 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 	u8 *hdr;
 	int i;
 
-	if (!initrd_end)
+	if (!initrd_end || initrd_end < initrd_start ||
+	    initrd_end - initrd_start < BOOTCONFIG_MAGIC_LEN + 8)
 		return NULL;
 
 	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
@@ -294,16 +295,26 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 
 found:
 	hdr = (u8 *)(data - 8);
+	if ((unsigned long)hdr < initrd_start)
+		return NULL;
+
 	size = get_unaligned_le32(hdr);
 	csum = get_unaligned_le32(hdr + 4);
 
-	data = ((void *)hdr) - size;
-	if ((unsigned long)data < initrd_start) {
-		pr_err("bootconfig size %d is greater than initrd size %ld\n",
+	if (size > XBC_DATA_MAX) {
+		pr_err("bootconfig size %u is greater than max size %d\n",
+			size, XBC_DATA_MAX);
+		return NULL;
+	}
+
+	if (size > ((unsigned long)hdr - initrd_start)) {
+		pr_err("bootconfig size %u is greater than initrd size %lu\n",
 			size, initrd_end - initrd_start);
 		return NULL;
 	}
 
+	data = ((void *)hdr) - size;
+
 	if (xbc_calc_checksum(data, size) != csum) {
 		pr_err("bootconfig checksum failed\n");
 		return NULL;
@@ -394,12 +405,6 @@ static void __init setup_boot_config(void)
 		return;
 	}
 
-	if (size >= XBC_DATA_MAX) {
-		pr_err("bootconfig size %ld greater than max size %d\n",
-			(long)size, XBC_DATA_MAX);
-		return;
-	}
-
 	ret = xbc_init(data, size, &msg, &pos);
 	if (ret < 0) {
 		if (pos < 0)

