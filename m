Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B334D7D2C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583844; cv=none; b=C2gYTUcYZOQLgmon9e/pd6O7wKxCPtBHL904CxTHylV99ef3W2OrIdu7OgtsussUenXN46jCGI/CR8yLZjd10qPYudkp3gtPG4PAW+bVmP/BnjXIactayU98HPx9pTHylHM8Jtf/Y1SYtzXH375J2BgPtHbuIKYqGTX3K1gUiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583844; c=relaxed/simple;
	bh=S4/JtlHcOWPfwbqm0F8DY6JB2+vRlaOBIjxLK6vmalk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bqcxum5QH2nYJAhQ6JaL9fZT6PqsvkrxOoSEblPBHp5BBnuHEg1DDLVBMXkdBLu62JfVt5dLU7RWfrLaHG4qNblFzq448uXPJQujWexLKJQD60a2YWl1dKGtlexDLvxEEGeoaG0RyJ3DrQ2Bw3m/6ZfLkIpm2rpOARmmxKQvw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii1zRDd3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii1zRDd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F9F1F00893;
	Wed, 16 Sep 2026 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583816;
	bh=fzi34rbSxh+nIhdH4ve9t8Pl7yzWqTh2HOWZR6el8WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ii1zRDd3LkwsTjubNT6/EaXAhEooMtOorwh6apwBy5Y2/ARmLGgId592/x7ecG51B
	 Fa5SeNoQWw/4l9+jAg6W7SqdcMS46tYMm5XQ+q8jFvg0X6uEnU4AOlNlhqmSLEQRED
	 w6q0QEZOk6ZI0Crl2FXZi7fAQ+MveEUdzn515Bk1QnEpqd8Q3iyVV5Rd3e4NClaPWM
	 Es5ivrLMoWXPLKgutccTAoMlFTI7zmpGWNyljhtBUCYv7Aqz3Vr4xzyqJrXHRBT3so
	 cx6UKq+DkEBJTU8WDFvpzcfyrBsVXIdtVrUBc7KBF1kO7cVUnayJKLQRTTN4f8WhbC
	 KKOwIwRNe+ztw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] tools/bootconfig: Fix integer overflow and truncation in size checks
Date: Wed, 16 Sep 2026 14:36:52 -0400
Message-ID: <20260916183652.1772436-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916183652.1772436-1-sashal@kernel.org>
References: <2026091616-brisket-appease-387d@gregkh>
 <20260916183652.1772436-1-sashal@kernel.org>
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
index 31536110699ec..eed01f97130ef 100644
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
-- 
2.53.0

