Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801523;
	b=cqDizWoVt1sFkuszSNW3IA7FC1eWmvUQTr5xtGm8x2CsqnUV4Wpz7rRURHdQxMA2aMnl
	 A43lTpEj7GpIlnD3LVi0W0jUQDPxGs0k3eedb6pLGHXmW3LWH1N5qyyFy0Qkf0k94vJJ0
	 XMq7mvMCAQod5RK3Bf7/CJBb8/7QIafqJNTEI2UmvgZzGbF4kJSWt3sxrWxLj/scCwORO
	 ZHfUHuvyy2o91UWLBG7pWXgZT9fv4oHyI7lVuxDviTPwgooi654fBR6x/cnVj1WrHGH6B
	 C9IuaPNkuRvrlFwls0NT4yfjEZ0L2Mei38CnirgWG2W5VVu8NTNmMNctxAsUlch7PCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801523;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Y39eLwKBh7+YdyJTBtoEtPlQiCtjp6Ze/lxCmmYNeDM=;
	b=RYDU2QTfQ57J4hqplkE50UP8x4YEv+0mrKM7V+fS/CeA4FHYXqqKYBcnDIcBvQgkNKX4
	 y2+ey7apyYHwvZLAAdTngeVQQvefH8g8ffzBtP0hEnx24qomY2NYELDjVFyqWth8yYh+S
	 Kyp8EV+wg5PT43NpWDI9Y5FmT5QM7zo3yEVCFo64M+wlabLZpw67M8PDTsQ4v2qZ2O4Rf
	 LDX2SxvU0Mdx68tEj5DNpO4A0+topL7Hh9MSuqR4ldfSIY6Vo4dK5L6coLuuSe6zU7ueJ
	 XyRO5pYb1TFvmpQps/KspMdblBRu0PeGhEw25V1oFyihKNUMXiTqOF1xE92w7h9H1+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WRpvTe61;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A6606D809
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WRpvTe61
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702751F000C1;
	Wed,  4 Nov 2026 14:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801522;
	bh=Y39eLwKBh7+YdyJTBtoEtPlQiCtjp6Ze/lxCmmYNeDM=;
	h=Subject:To:Cc:From:Date;
	b=WRpvTe61f+E0Ka2Uv4XVOAPzWhqT7jPVlGckh4AlifbnJKtXNoG+GLebRWdIdN6nO
	 5hLtgS1++uI2WN366imrt1FqKRqoszMAre1NWSP/5lBBXNrSUU0qbkDZDktVXIi4k2
	 eZjdHrrGYzPljOhXsaZiltVx4GhuJkxZi8bitjyY=
Subject: FAILED: patch "[PATCH] rust_binderfs: add transaction_report feature entry" failed to apply to 7.3-stable tree
To: cmllamas@google.com,aliceryhl@google.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:12:01 +0100
Message-ID: <2026110401-lure-unmoving-2038@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 2fcc8b9687af998b74ce6b0d349167eae7931558
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110401-lure-unmoving-2038@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2fcc8b9687af998b74ce6b0d349167eae7931558 Mon Sep 17 00:00:00 2001
From: Carlos Llamas <cmllamas@google.com>
Date: Wed, 16 Sep 2026 12:08:32 +0000
Subject: [PATCH] rust_binderfs: add transaction_report feature entry

rust_binderfs is missing the equivalent of commit f37b55ded8ed ("binder:
add transaction_report feature entry"), which adds "transaction_report"
to the binderfs feature list. This helps userspace determine if the
BINDER_CMD_REPORT from the generic netlink API is supported.

Cc: stable@vger.kernel.org
Fixes: f14e0c8183bc ("rust_binder: report netlink transactions")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260916120833.593407-1-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/android/binder/rust_binderfs.c b/drivers/android/binder/rust_binderfs.c
index 7ad3ea6d8087..acc83a179f38 100644
--- a/drivers/android/binder/rust_binderfs.c
+++ b/drivers/android/binder/rust_binderfs.c
@@ -72,6 +72,7 @@ struct binder_features {
 	bool oneway_spam_detection;
 	bool extended_error;
 	bool freeze_notification;
+	bool transaction_report;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -89,6 +90,7 @@ static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
 	.extended_error = true,
 	.freeze_notification = true,
+	.transaction_report = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -566,6 +568,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = rust_binderfs_create_file(dir, "transaction_report",
+				      &binder_features_fops,
+				      &binder_features.transaction_report);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 

