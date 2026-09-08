Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6D4A92D7;
	Tue,  8 Sep 2026 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857489; cv=none; b=easw5ATCl3zT8qRxH2tWYE1mSiazvyfVk1xYC860W+mLnbKLjvSB7fG+rlJ/XbMr2GjYHLLQNrkOvaVvQAC1MBQDWn7+Vh41vELp0QRiB2ENOtFguWEV5yILHiDyX3kVmrqHgVrBE1t1JE9FgVTwMVqsIalZ3hg4wYPa/Hoy8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857489; c=relaxed/simple;
	bh=0sREjLT1KjXfL8M7weGuzjwt3vIcayaWQx1S9+MmZHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiFouIU6zhR/E9MXvsj9urzmd5SyWqGeOqXDAus1OGGDJhJbWK+t4z1+l/t45RNCNIdevm1gd4BNqkQsuSLB7Kxc+h2Bu/3v+06FG170SmucDbHpRbSSu4zVmJy4CUOD8jraO5K4rXV5ynS17VWq1v7MGuzZb1x5cWt0Yni37Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNURJBIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNURJBIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C861E1F00A3A;
	Tue,  8 Sep 2026 08:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857482;
	bh=M50dx1a27r3W3TPlHJ5gWaX3NM9i2Uykt5E8HjPLO/Q=;
	h=From:To:Cc:Subject:Date;
	b=gNURJBIuAJ7Lp3kSkULS9bbh5puHdiK0J8s9bYZlWmIYbMU/mtdmfc4K3TJOdcL79
	 sbHOQ2VNdlnRKK2OTn1t1w0eulfRGEkOARkZH/rhZOZdvS4dyCssFRfmK870aOUHFg
	 MoZEnc1eI79SphpNpI1A2P2ChpjRQ5t4CkU0XLpQxPeIfYdtlcw8efBzRh+s14pfFb
	 QHKT7B7zuQZvze3TECpVJNY4sIS6XzB+9P5xIYnet9/vlHxj9W/Vvg6tuq0Xm9u3V4
	 784gxqc+5AdLf9ZpKBjvfEyooNsOULdoLS+rFvjzKGpU6aGBWQsjBARnUPLLa2Krw3
	 f0PUTrpR0TeKw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [STABLE v5.15.y 1/8] file: add fput() cleanup helper
Date: Tue,  8 Sep 2026 09:50:57 +0100
Message-ID: <20260908085113.3960814-1-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 257b1c2c78c25643526609dee0c15f1544eb3252 ]

Add a simple helper to put a file reference.

Link: https://lore.kernel.org/r/20240719-work-mount-namespace-v1-4-834113cab0d2@kernel.org
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit ac275934626a85285cca43405e876566daa10533)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/linux/file.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/file.h b/include/linux/file.h
index 6726240b9279..fb8a5d22531e 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -11,6 +11,7 @@
 #include <linux/posix_types.h>
 #include <linux/errno.h>
 #include <linux/cleanup.h>
+#include <linux/err.h>
 
 struct file;
 
@@ -95,6 +96,7 @@ extern void put_unused_fd(unsigned int fd);
 
 DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
 	     get_unused_fd_flags(flags), unsigned flags)
+DEFINE_FREE(fput, struct file *, if (!IS_ERR_OR_NULL(_T)) fput(_T))
 
 extern void fd_install(unsigned int fd, struct file *file);
 
-- 
2.55.0.979.g7e5102b832-goog

