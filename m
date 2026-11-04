Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816974;
	b=GJa1qXbII8Mq3JbLyofnDxu+cvezwwSqlc15p04CnpU5krqkTGlhfqGVkJNGlMt9kOLd
	 DdTVhDnJKP925A++m4HuZeYJ9zHgH39GQ5qTWCwe0y6o5f75gYChTUOWqOH680wN9rvWw
	 lxwyTsAsbYADcX/lQiD0TyZ4t+ejiR9fhNCPXC7xCuMkCXTQyChgj1WBc4bJiARjFvxQO
	 rn1ieOUCv2NtHhR0IH70Ff92Znkr9fL6JFNwrwnBRUsJYmQMqMpEPndbGwhTY6/lgR8LS
	 kscKd7CTAcU00GI0cl4U0hp6i7IJSwDp3a1HKWMo4iaGMihxTGAmU4ikrP0BwYiZM9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816974;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=e6Rm2UJ47md6836TjvxHTgjX3EPrAOcethFEnp8u6CM=;
	b=PkK3JlFIOY69nVGswus430JpEvykXNv3i2OI2Yw+P+coD99pN9Y66b/364vktj+iFcov
	 umjbLvOjgg8q+PXB0NgdACtK5koEXq9GBaySjVIwku9zIhJIuTMyv3Xfamwp9FnxowSkG
	 jrihTZwpiS+7A0Zwv8UBpjdyYT1zlKUsfvOWLdMNUQkjFYxXjSHMeqa4Z+TlmEcmMD6HA
	 NOM7yd8Ag7IH51swJZ2uQYJhNO8Dc71GOWNOF8l9ysNXiEPe9l5OcfuH7Kh2wOntsH9RA
	 C3VXO+8AjPFw8qa7n4aUqXF1B8gSs8s+io0gsVdIte0TNPWbOwj+8NKPfcjezHq+pjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0qddoAX2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF2606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0qddoAX2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32D01F000C1;
	Wed,  4 Nov 2026 18:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793816974;
	bh=e6Rm2UJ47md6836TjvxHTgjX3EPrAOcethFEnp8u6CM=;
	h=Subject:To:Cc:From:Date;
	b=0qddoAX2SWMHg4GbK+fII9dj8xqBIJQwGB9g1865scg+HwsLY6pbr3wkf655SXJ+D
	 6hYWQxBB8ln8MvjkLagjtHldncPuNm9JT+X3IPyB9BMekMoVfAuQUXveSE/mk5adV4
	 NfYTkF/SNtZP/Ch2/THuwHfF1vHDLFu5l8RWUAAE=
Subject: FAILED: patch "[PATCH] smb: server: size directory name conversion buffer correctly" failed to apply to 6.1-stable tree
To: coderzeng@hotmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:29:24 -0500
Message-ID: <2026110424-hypnoses-average-6482@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f1f37834eaba5904103af1f18afe3510c7e9dc71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110424-hypnoses-average-6482@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f1f37834eaba5904103af1f18afe3510c7e9dc71 Mon Sep 17 00:00:00 2001
From: VeroFess <coderzeng@hotmail.com>
Date: Mon, 26 Oct 2026 15:01:03 +0900
Subject: [PATCH] smb: server: size directory name conversion buffer correctly

A 2048-byte ASCII directory name needs 4098 bytes when converted to
UTF-16, including the terminator. ksmbd_convert_dir_info_name() caps
its allocation at PATH_MAX and writes past the end of that buffer.

Allocate space for one UTF-16 code unit per input byte plus the
terminator. Use kmalloc_array() to check the size calculation.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Assisted-by: gpt 6 sol with daybreak blue
Signed-off-by: VeroFess <coderzeng@hotmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/misc.c b/fs/smb/server/misc.c
index 2dd91c9e956a..5037f37c9226 100644
--- a/fs/smb/server/misc.c
+++ b/fs/smb/server/misc.c
@@ -296,12 +296,13 @@ char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
 				  int *conv_len)
 {
 	char *conv;
-	int  sz = min(4 * d_info->name_len, PATH_MAX);
 
-	if (!sz)
+	if (d_info->name_len <= 0)
 		return NULL;
 
-	conv = kmalloc(sz, KSMBD_DEFAULT_GFP);
+	/* One UTF-16 code unit per input byte, plus the terminating NUL. */
+	conv = kmalloc_array((size_t)d_info->name_len + 1,
+			     sizeof(__le16), KSMBD_DEFAULT_GFP);
 	if (!conv)
 		return NULL;
 
@@ -310,7 +311,6 @@ char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
 				      d_info->name_len, local_nls, 0);
 	*conv_len *= 2;
 
-	/* We allocate buffer twice bigger than needed. */
 	conv[*conv_len] = 0x00;
 	conv[*conv_len + 1] = 0x00;
 	return conv;

