Received: from cvsmtppost15.nm.naver.com (cvsmtppost15.nm.naver.com [114.111.35.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E8416115
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791125301; cv=none; b=QZGwIwhVOWQK2C//MRWBGvy26JWK1UBzgWCaO7PXGqaxs6AfOrtNtExlS/1rt5Z9gONuornXGwq7ONET7k9mP509gTPeVDFGsfblVRa30wAkhrfXmwkQLoCWKkxUsYrUMcRSWkYQhwG3LQAWWlb7avyZydpJLW/jGNT3XpxHwAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791125301; c=relaxed/simple;
	bh=XcNN7eJ8pqt5t9I3uN7RYCmycRwA+uReKRMPHRBCfAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYcIl2MDsadYdN/PVatYGsWnCtJBneDxywrHeC8rKpklDTzvu+MJ279x6iJ1tUvCxndtSgZfY1WDH0d+NiGe1N9K/zoswJijXoW2FNVOOkhvczVegf3AXRWuTiptRlZFOiWqGkygXb6rPpJPsHCWJhqT5JTQY2m6j2VzyBoKyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=u0R9aV+V; arc=none smtp.client-ip=114.111.35.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="u0R9aV+V"
Received: from cvsendbo010.nm ([10.112.20.44])
  by cvsmtppost15.nm.naver.com with ESMTP id KnKOFhBkRsCKo2icfPuEeA
  for <stable@vger.kernel.org>;
  Sun, 04 Oct 2026 14:48:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791125292; bh=XcNN7eJ8pqt5t9I3uN7RYCmycRwA+uReKRMPHRBCfAU=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=u0R9aV+VwksgHAfzZ8mWR1H1Rr2l2UzuYcqBSfZHCgVYbkGOyADg9tSFrQytXTtMm
	 AQY/1BxkyriNvX9x57SI5psmDiJy65l3ozdPVl34emVC3XtSvgJEUtAQkH9pMgvZW+
	 3xNu8aJqkIc/vh4GIltZz6PWWsfrb3ApeMVWSmSpRlsxDNtSv3mdfL3+bDWwoyUNdC
	 sEpEcu4sKtn1QTDGzAHVowuyhuFdYiu2dboPRHlcNHGf06FR1yvmhFoNS6iluYBVjl
	 bhP2G05nK+qETn5rpqGS7mDR9HIkembYSWKEYWm0p/0zCvx9B2ky1UsNjvG7CLl73Z
	 vGy/cl7VVTa3A==
X-Session-ID: LmKJ5MAwSoyrVmVIaLe33g
X-Works-Send-Opt: O9ewpzGdjHmdKHFOMr39Ko3YKHmwKNmwFAbrFxKrKqEmjJkaBd9YKBmm
X-Works-Smtp-Source: sdKlKAulFqJZ+Hmwax2Z+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp006.nm.naver.com with ESMTP id LmKJ5MAwSoyrVmVIaLe33g
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sun, 04 Oct 2026 14:48:11 -0000
From: Byeongchan Sung <tjdqudcks0424@naver.com>
To: German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] virtiofs: validate fixed-output response length
Date: Sun,  4 Oct 2026 23:48:00 +0900
Message-ID: <20261004144801.663923-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004123405.586168-1-tjdqudcks0424@naver.com>
References: <20261004123405.586168-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A short successful virtiofs response can leave the fixed-output
portion of the request argument buffer unwritten. The completion path
nevertheless copies the full declared output to the request destination,
allowing stale allocator contents to reach callers such as
fuse_statfs().

Require successful fixed-output responses to contain their complete
declared output. Continue to permit a shorter final argument only for
out_argvar requests. Reject positive and internal restart error values,
require valid error replies to be header-only, and do not copy output
arguments from error replies.

A header-only FUSE_STATFS success returned stale fields in nine of
nine calls across three boots. The fixed kernel rejected the short
response and preserved complete replies, valid error replies, and
variable-output controls.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Byeongchan Sung <tjdqudcks0424@naver.com>
---
Changes in v2:
- Reject positive and internal restart error values.
- Require error replies to be header-only.
- Rate-limit malformed-response warnings.
- Rely on the existing FUSE pr_fmt prefix.
- Add Cc: stable@vger.kernel.org.
- Use the author's real name consistently.

 fs/fuse/virtio_fs.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f15e516ebcb5c..fffbe08d9114a 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2018 Red Hat, Inc.
  */
 
+#include "fuse_i.h"
+
 #include <linux/fs.h>
 #include <linux/dax.h>
 #include <linux/pci.h>
@@ -20,7 +22,6 @@
 #include <linux/cleanup.h>
 #include <linux/uio.h>
 #include "dev.h"
-#include "fuse_i.h"
 #include "fuse_dev_i.h"
 
 /* Used to help calculate the FUSE connection's max_pages limit for a request's
@@ -730,6 +731,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	unsigned int num_out;
 	unsigned int i;
 
+	/* Error replies contain only the output header. */
+	if (req->out.h.error)
+		goto out;
+
 	remaining = req->out.h.len - sizeof(req->out.h);
 	num_in = args->in_numargs - args->in_pages;
 	num_out = args->out_numargs - args->out_pages;
@@ -755,6 +760,7 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	if (args->out_argvar)
 		args->out_args[args->out_numargs - 1].size = remaining;
 
+out:
 	kfree(req->argbuf);
 	req->argbuf = NULL;
 }
@@ -762,19 +768,46 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 /* Verify that the server properly follows the FUSE protocol */
 static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
 {
+	struct fuse_args *args = req->args;
 	struct fuse_out_header *oh = &req->out.h;
+	unsigned int expected;
 
 	if (len < sizeof(*oh)) {
-		pr_warn("virtio-fs: response too short (%u)\n", len);
+		pr_warn_ratelimited("response too short (%u)\n", len);
 		return false;
 	}
 	if (oh->len != len) {
-		pr_warn("virtio-fs: oh.len mismatch (%u != %u)\n", oh->len, len);
+		pr_warn_ratelimited("oh.len mismatch (%u != %u)\n",
+				    oh->len, len);
 		return false;
 	}
 	if (oh->unique != req->in.h.unique) {
-		pr_warn("virtio-fs: oh.unique mismatch (%llu != %llu)\n",
-			oh->unique, req->in.h.unique);
+		pr_warn_ratelimited("oh.unique mismatch (%llu != %llu)\n",
+				    oh->unique, req->in.h.unique);
+		return false;
+	}
+	if (oh->error <= -ERESTARTSYS || oh->error > 0) {
+		pr_warn_ratelimited("invalid error value (%d)\n", oh->error);
+		return false;
+	}
+
+	if (oh->error) {
+		if (len != sizeof(*oh)) {
+			pr_warn_ratelimited("error response too long (%u)\n",
+					    len);
+			return false;
+		}
+		return true;
+	}
+
+	expected = sizeof(*oh) +
+		   fuse_len_args(args->out_numargs, args->out_args);
+	if (len > expected ||
+	    (len < expected &&
+	     (!args->out_argvar ||
+	      expected - len > args->out_args[args->out_numargs - 1].size))) {
+		pr_warn_ratelimited("invalid response length (%u, expected %u)\n",
+				    len, expected);
 		return false;
 	}
 	return true;
-- 
2.43.0
