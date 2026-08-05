Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC3331EB3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922077; cv=none; b=LSFf6UQpgKHzQ/utQ/zQm3n45glRz4tyJNcHM9oapjBll98ebixkduj5H/Dn5heMDwJionZt0Y5luytjsGu75n6xSZWaruNk8VouFK3KAhX3egpC+kIntL6YU6LLwOzhGSsmFWKNscOEX4BBrwUffUz1ypwD1uumxHhBWJoNIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922077; c=relaxed/simple;
	bh=W9SEoaIMIwKFFKQwjkW3EnG9QouK/g3i+Yo2RVbCVyY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LYMogNVaOJel7+zMDNioEj6ND6UaX2/L0MNeKKtX9Kj5ZDGSWadgkNAIvWtVL3rtC564xJYtOI5El9P+2yvzGDXbVmmkipMlPJ56Qvamcccs1CdwxXj6D9DvKN3SWjasPL2AomgAhNBh+kTTPY7ih2CZfctoeBkV8LmzOVYlrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KnBDVtId; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KnBDVtId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FC31F000E9;
	Wed,  5 Aug 2026 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922075;
	bh=qkzTKQXPZApHaU3XyH82/kUtvYF2QqsBS07+9lAPOTQ=;
	h=Subject:To:Cc:From:Date;
	b=KnBDVtIdDf5HOBUKRnd3nrtn1jRKMbRHDmEFTgz7YbWQlJuWeIf7RZ0yXa1Mq1XXE
	 6BY1wpvR3K7gicnO9d8DCGvkgK4X1moUGjNfDmLWPkO3OvsCIlPf0Yf+EsIhJx9z84
	 Xx5Ls52OEp6/edrzJAtouWnnsiui2jIoD+1moT+w=
Subject: FAILED: patch "[PATCH] erofs: cap LZMA stream pool size" failed to apply to 6.1-stable tree
To: michael.bommarito@gmail.com,hsiangkao@linux.alibaba.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:27:38 +0200
Message-ID: <2026080538-tartly-varying-5d75@gregkh>
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
git cherry-pick -x c9b47e6b23114e939b17f818471c7a46e59006e7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080538-tartly-varying-5d75@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c9b47e6b23114e939b17f818471c7a46e59006e7 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 14 Jul 2026 07:47:29 -0400
Subject: [PATCH] erofs: cap LZMA stream pool size

fs/erofs/decompressor_lzma.c sizes the module-global MicroLZMA stream
pool from num_possible_cpus() when the lzma_streams module parameter is
unset, then z_erofs_load_lzma_config() preallocates one image-supplied
dictionary per stream, accepting dictionaries up to 8 MiB.  On high-CPU
systems, a small EROFS image can pin hundreds of MiB of vmalloc-backed
decoder state until the erofs module is unloaded.

Impact: An EROFS image mounted by the system can pin up to 8 MiB of
vmalloc memory per LZMA stream, either as intended or unexpectedly.

Bound the default stream count by a new
CONFIG_EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS option, default 16, so the
worst-case default preallocation is 128 MiB if the number of CPUs is no
less than 16 while preserving the existing per-image dictionary limit.
An explicit lzma_streams module parameter is still honoured as-is, so
administrators who deliberately size the pool are not affected.

Fixes: 622ceaddb764 ("erofs: lzma compression support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 1feb28cfe557..8ca1767dafb6 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -131,6 +131,20 @@ config EROFS_FS_ZIP_LZMA
 
 	  Say N if you want to disable LZMA compression support.
 
+config EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS
+	int "EROFS LZMA default maximum decompression streams"
+	depends on EROFS_FS_ZIP_LZMA
+	range 1 NR_CPUS
+	default 16
+	help
+	  By default EROFS allocates one LZMA decompression stream per CPU.
+	  Each stream can hold a dictionary of up to 8 MiB taken from the
+	  mounted image, so on systems with many CPUs this can reserve a lot
+	  of memory.  This caps the default; the lzma_streams module parameter
+	  still overrides it.
+
+	  If unsure, keep the default of 16.
+
 config EROFS_FS_ZIP_DEFLATE
 	bool "EROFS DEFLATE compressed data support"
 	depends on EROFS_FS_ZIP
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index f6692d0f2f04..6b0cdb446c6a 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -51,7 +51,8 @@ static int __init z_erofs_lzma_init(void)
 
 	/* by default, use # of possible CPUs instead */
 	if (!z_erofs_lzma_nstrms)
-		z_erofs_lzma_nstrms = num_possible_cpus();
+		z_erofs_lzma_nstrms = min_t(unsigned int, num_possible_cpus(),
+				CONFIG_EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS);
 
 	for (i = 0; i < z_erofs_lzma_nstrms; ++i) {
 		struct z_erofs_lzma *strm = kzalloc_obj(*strm);

