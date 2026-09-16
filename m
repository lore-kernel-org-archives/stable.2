Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03245503BD6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568308; cv=none; b=clMr+V0WwuV4LEt4yjE6/BMkC9NSsU5lH9yvGSnxPFliYwPw0Vye2TQYg/VIy76WN3bdRtJEkKmFiihl7TnZ0AiaO3bNmQc1jIiU1bxzZEgVCwjOdkn792KH/Hl7i+RTjdRZiQpYHyONrKrC8ETRclFejRAKQQNwlYJ/SEDAF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568308; c=relaxed/simple;
	bh=ZGEzPA+3vS81VHVtjItAaLk9dTLXxiDy5Kj2h5ovVEM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k+vUwQw/RWL17hWQFaipwr19yX5hqeufTHypOT/+lhGdu0lOT5Ca4FIiD+8ZMR8XrIR/jacFTE2h7R3Jr2ZV80Mhw/Ho5l58SPhMOWZGqHKjQMqKllcnjRP6W4uBrXiSP+fOOknQ/XXMRFs35aQ6nR7CPM7ySF2/6ABjL7AIapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XejFLf4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XejFLf4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4159A1F00893;
	Wed, 16 Sep 2026 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789568306;
	bh=ycg8V6F3Jx9UFg9F0pXioyWXKkiDlDx0WYBuwOUF87A=;
	h=Subject:To:Cc:From:Date;
	b=XejFLf4RYmMQyM4hqEcBcLsCVMIyD81VH8Z1kF7kXwm00hiVO24B+IjLHacceVxVR
	 k9Da7BayhXgFlaLVw90e9P6qo43J6ABuYmaOjR6l0jjx4aEFl31YizTYAIrosvjOA0
	 KIO8kEd8rffUH01mC+yK4RuiINjN0yMzmdnyEJu0=
Subject: FAILED: patch "[PATCH] tools/bootconfig: Fix integer overflow and truncation in size" failed to apply to 5.10-stable tree
To: mhiramat@kernel.org,ekffu200098@gmail.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 15:16:17 +0100
Message-ID: <2026091617-cackle-deeply-2ea2@gregkh>
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
git cherry-pick -x 462d0b066b613103f579793031429db2ca23abc0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091617-cackle-deeply-2ea2@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 462d0b066b613103f579793031429db2ca23abc0 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 11 Sep 2026 00:15:24 +0900
Subject: [PATCH] tools/bootconfig: Fix integer overflow and truncation in size
 checks

Sashiko reported that on 32-bit systems, if an attacker crafts size in
the bootconfig footer such that adding BOOTCONFIG_FOOTER_SIZE wraps around
(for instance, if size is 0xFFFFFFFF), the size check in
load_xbc_from_initrd() can be bypassed:

    if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
        pr_err("bootconfig size is too big\n");
        return -E2BIG;
    }

Furthermore, on 64-bit systems with an initrd > 4.29 GB, comparing a
corrupted 32-bit size (e.g. 0xFFFFFFFF) against
stat.st_size - BOOTCONFIG_FOOTER_SIZE can also bypass the check if
size is not bounded. Similarly, load_xbc_file() passes 64-bit stat.st_size
directly into the 32-bit int size parameter of load_xbc_fd(), truncating
large standalone files (>= 2GB).

In both cases, passing 0xFFFFFFFF to load_xbc_fd() truncates to -1,
resulting in malloc(0), an integer overflow in read(), and an
out-of-bounds null-byte write.

Fix this by:
1. Rejecting size > XBC_DATA_MAX or
   size > stat.st_size - BOOTCONFIG_FOOTER_SIZE in load_xbc_from_initrd().
2. Rejecting stat.st_size > XBC_DATA_MAX in load_xbc_file() before passing
   it to load_xbc_fd().
3. Checking size < 0 || size > XBC_DATA_MAX defensively in load_xbc_fd().

Link: https://lore.kernel.org/all/178905332413.213925.3179977110281463499.stgit@devnote2/

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260909161113.16C691F00A3A@smtp.kernel.org/
Closes: https://lore.kernel.org/all/20260910010137.EE0431F000FF@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Sang-Heon Jeon <ekffu200098@gmail.com>

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 7dc9fff9b637..17d971d47f87 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -140,6 +140,9 @@ static int load_xbc_fd(int fd, char **buf, int size)
 {
 	int ret;
 
+	if (size < 0 || size > XBC_DATA_MAX)
+		return -EINVAL;
+
 	*buf = malloc(size + 1);
 	if (!*buf)
 		return -ENOMEM;
@@ -168,6 +171,13 @@ static int load_xbc_file(const char *path, char **buf)
 		return ret;
 	}
 
+	if (stat.st_size > XBC_DATA_MAX) {
+		pr_err("%s size is too big\n", path);
+		ret = -E2BIG;
+		close(fd);
+		return ret;
+	}
+
 	ret = load_xbc_fd(fd, buf, stat.st_size);
 
 	close(fd);
@@ -218,7 +228,8 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	csum = le32toh(csum);
 
 	/* Wrong size error  */
-	if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
+	if (size > XBC_DATA_MAX ||
+	    size > stat.st_size - BOOTCONFIG_FOOTER_SIZE) {
 		pr_err("bootconfig size is too big\n");
 		return -E2BIG;
 	}

