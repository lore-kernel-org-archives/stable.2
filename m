Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED67E523781
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572467; cv=none; b=Kjc2/C9RMEH2l9/4sRC6nQgPQ19ah2Rf/iRGrBrlxGxXi1pk14j5IFGuXiP/dFzrjZ0lFA4VmMpF5tRPX6FdtpmqHNN8JH4J4CGknm5jHwQh+Iq0wRYsGS9k4NWFhaxpfg934Iv4oBZWVI213voiK6GJ5JNJ8gd4LoB1no4LnnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572467; c=relaxed/simple;
	bh=2qLt14d7Gilvictr9+B6NVUpo5IzXWKBIJTVdw16E4Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gLVIg2uCskvegy5UBfMIXMNz8aT7w8ZgenpEh8Sm/ujO4Ko0P5FBC0gJPyoJjO0l1FvJEFHeHUtVZEGrMPWvRzXAKI5pXHpEIzyuxISIco0qIZJOmyU5VMFxBiEm4/sTFr3rSCsqO9mP59PFQe6byvozgqhad/KmpGhzdn1vL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TjTfG3LO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TjTfG3LO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA2D1F00893;
	Wed, 16 Sep 2026 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572465;
	bh=eALuC+L4jrUsTdf+kGYLqijn9nUQbdqqiyuB5BZ/2Uw=;
	h=Subject:To:Cc:From:Date;
	b=TjTfG3LOnYsC0tM/H6u5ISKP+gMLy1MIeM7l70EUEG6eW0Zasu7O3J+hMn9nMFROi
	 0oNWah1yE+eK5bS3HTwp2Lm0juy+sVWroxvp7yAJo+l0YEzta76R6Y7M7P8KIc93PG
	 u2DzPkws8BPaAiBKYuGd/8NI/oXj5olCj+q2vuY0=
Subject: FAILED: patch "[PATCH] bootconfig: Fix integer overflow in initrd size check" failed to apply to 6.18-stable tree
To: mhiramat@kernel.org,ekffu200098@gmail.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:15:15 +0100
Message-ID: <2026091615-curry-barracuda-b99e@gregkh>
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
git cherry-pick -x 7812d6dab0698001e50e8c2f901e17da3eb6f429
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091615-curry-barracuda-b99e@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

