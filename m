Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816977;
	b=KiWfihY2vkRb0RacFYxFnaBsQAep9Lr6vA9w0oUeqSZQh0L4PckJQgQoQvX8GO9m5J5p
	 1vnyMHpxfFKwa6mNpfTrFqOxbRLbDH9Oep0MmIurtYHwwt3dLwUfHM7sb6VisyMOD2ZBb
	 nvAaLs3UyoAgQ/LfL1EpXuv5d2tT2Oe25Blaea/BrUvhKy5YtuUNIn75Y9zAD3b/3Z26W
	 JCrD4mQuwqFcMZixNDDxCmn7r/PI1RE/P+D7339ol2iIn1e0GK4nyNrveaIVUBhQo9xBe
	 9l/GJiJnIC+KykRbZsTicbhK1OWloKwfsjkBsdScd+WOIp+NI7ufxdXbumKLJOYGr0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816977;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IyOleqvmyKNyEOgscDyW73RjtzbRyE9+o5NBfCH8B8U=;
	b=rNPHQd/cJ4fkEURLOVzz2nSviS9OybQffsdNWLjg5BKKTOJ1Q+EreksMkDDsujxImbRT
	 d6s3Bgl28Sf2vJr/tOlpzHx9ARvaGm+6XrEuI9EhF1C0yCdsf60FFfySIpPxKonj28WCR
	 Dif1CdHirJs9Ilpl075h5YhEYKahEb8E311VOSRifkOklo4tvA7L1GsqiU5t/4JlpZzXe
	 TS8PNoiwGLLBuGwwwuzyeoXopi2WD47eXkTY+Sf/gBRoTeFgQpNTqjJHwvU3MORasQnps
	 MJF+VYI1lJCDbDV2V722ehPGSb+ccMQWHse2Utm8VHREIIvXraNNnr13UTj0knwTkmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HvsqwY7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B36606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HvsqwY7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833FE1F000C1;
	Wed,  4 Nov 2026 18:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793816976;
	bh=IyOleqvmyKNyEOgscDyW73RjtzbRyE9+o5NBfCH8B8U=;
	h=Subject:To:Cc:From:Date;
	b=HvsqwY7HeuKytg1cb2jKmcDrxWfE1eMOWdNH6TWjRk1i5wfh7bP6l250ZTy2GOJ4h
	 pzCjr1a9cUnPtuLKqZe4SF5W/R8YKvgEc+GEqPJgRY+kbFntsMDk7iUt/Z2yuZeSFU
	 RTzjDGk8EIiyDEpDCguK/Yc+mEB4wQ+Rp5XpqVdM=
Subject: FAILED: patch "[PATCH] smb: server: size directory name conversion buffer correctly" failed to apply to 5.15-stable tree
To: coderzeng@hotmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:29:25 -0500
Message-ID: <2026110425-refining-slum-bcbe@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f1f37834eaba5904103af1f18afe3510c7e9dc71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110425-refining-slum-bcbe@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

