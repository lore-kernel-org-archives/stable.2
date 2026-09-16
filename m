Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D984FDE4C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580112; cv=none; b=OQC+vO2HdXYfzxPFOgnA+DtNk+8fFRhuzLWd8DfrzVUb61xKaptX1vzm/IjAbKS1q9XwP9vjWcJKkCZAXRhZ6OeFjLePU4e3yy+ZJWXMfQyEr+ujyueYbhb/qS6syQHhVRz6KgrErOy/KsYBkjwCtZ/IsP03su4ZbF8yi/ht/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580112; c=relaxed/simple;
	bh=k1W39TNW6Ea7Kb2QYweZflpsJyL12MDumtTKzHSKYPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALunj6Muq6rR+pjVSNrMuDkCDrx5KO6pn/TQhZl2MrwvwaTBeG6X9VRIZtmB2GNtMXMYj/+IFE1YnX8Y2csAGB6Bc8ivFxowMT++LRI/pn+r/Cd7h2zK6Ru4je347quL861pXvJapKM06wywMgNhH9G3lXnleTDb+XJUgTDLleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpGAjwFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpGAjwFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD401F0089A;
	Wed, 16 Sep 2026 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580104;
	bh=qWJzeJIQzAFb400p/ywudRQKNglbk+d7apw0c4SZyCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PpGAjwFukuszv+6zmdWqv0Y+9gLAUzlxNlYy8wXlaXQwpbXri0ioAe84c6DCl1xOo
	 5cfn2ZBMvGe4NXTVOpuMHm0QnWRj7khnxQuu9sxZWS1ckqvmTjfzBcgn8YB5mOVMWN
	 b3OHOvVJ3puu5rZqzCm54QYKm3hRIDohaIAEi/bRFj0z/Y+jlJF+hQ0/7V6nRWoy9T
	 zWOR2XHvuSBlgMJQwyRKAWZlU5N9vIf6voornNA/zKpHKqIwKNSOlXJhdV51FdAEUz
	 VfDHnguGZOGELjzbnyTBzttt9MadO+iyL/QYNwsfvKyaVLy2S7TBPsIB8UD25gc29n
	 5W9xQP81/6sCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tools/bootconfig: Fix integer overflow and truncation in size checks
Date: Wed, 16 Sep 2026 13:35:02 -0400
Message-ID: <20260916173502.1133275-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091615-county-flaccid-892f@gregkh>
References: <2026091615-county-flaccid-892f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 462d0b066b613103f579793031429db2ca23abc0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bootconfig/main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index f1a20f85a669d..5429a7674b35f 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -139,6 +139,9 @@ static int load_xbc_fd(int fd, char **buf, int size)
 {
 	int ret;
 
+	if (size < 0 || size > XBC_DATA_MAX)
+		return -EINVAL;
+
 	*buf = malloc(size + 1);
 	if (!*buf)
 		return -ENOMEM;
@@ -167,6 +170,13 @@ static int load_xbc_file(const char *path, char **buf)
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
@@ -217,7 +227,8 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	csum = le32toh(csum);
 
 	/* Wrong size error  */
-	if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
+	if (size > XBC_DATA_MAX ||
+	    size > stat.st_size - BOOTCONFIG_FOOTER_SIZE) {
 		pr_err("bootconfig size is too big\n");
 		return -E2BIG;
 	}
-- 
2.53.0

