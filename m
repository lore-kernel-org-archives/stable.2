Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817960;
	b=yp65elnbxtECxtlTTGg6yffPNpIB+RGpBdaOljQeNgphuaBoPRpz5aBligxHHxV9vfYu
	 EiTDQqeIbkL0NZn1FCcAY9lNetGMd+tXfHFXfq7rgufV71ZEvW4xjztd4nQY34KpHD48l
	 eS6onTfWQyRFQBKIwFCr/b8fPnJ9OMj75xS/e/wiFBRirVmd1DP1lgfpAjdrMYPHz9dQv
	 pxw5Mx7tx12OJgI1ixiDkoc/xCGplLCI5lqGzZJcDlLpGH7szWYJbPeQdutpBur/IicjS
	 TvwQl0tcu7FBpYhGCPf6slsusTW3aw9/y/OoXTcrwY3uDpgq2FOQXgZE6m1Y+4alE1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817960;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LFlkTwnfWqjVnH/LqEmjIjrs1OgfBEuK+0FRELMu59Q=;
	b=MGrvXjo7LG2Tjl6a5bDZDaDp4WLrE153qXtILapcHcWhely+w5fbkhMf3GnYJJ6KXxOB
	 8BSsriec1hPTbFPINw1VjROUQ3tIjR2QIWXP29H+r8fIHZJWWPb6GfXRKtDOJ59EExf0i
	 kJ4L2vkVxk36vi5Q5SRqamKbDEH2sBf15yhgUYMqcuhIhLvvf/j4Yab1kRxdpAqPEFk2D
	 v0Hglnhnj9WoT6mh6fa+xCwGPuNrrns84I9qZONPXCSpB5Ur7sjfvWVF3AoDrng1WiFRU
	 tb1ulebmzbTa3HYBb0o5e+u8arf04ApQD5DdZahKurGZAaM31zG87tfiaNv8GO275RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cqdkqTy2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B51606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cqdkqTy2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8AD1F000C1;
	Wed,  4 Nov 2026 18:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817959;
	bh=LFlkTwnfWqjVnH/LqEmjIjrs1OgfBEuK+0FRELMu59Q=;
	h=Subject:To:Cc:From:Date;
	b=cqdkqTy2hZjjGzIdRNPzUkyXEUQ1XOUWnv+8GbZWPKs7L4Uty9g+jSONtK4RSqNhi
	 dU/IQcl9HHVKRBvXiYEf5y7cO2ewZtbLXUfweo+lsI7nKsfRQvGKjfnCkSEI3M1d8e
	 9qHchdY8gJYeoN97AZtlwWMbNpXrTpT04src+I/s=
Subject: FAILED: patch "[PATCH] NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before" failed to apply to 6.18-stable tree
To: ben.coddington@hammerspace.com,anna.schumaker@hammerspace.com,bcodding@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:45:58 -0500
Message-ID: <2026110458-pelt-tragedy-4542@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 32f0967ea296d447925465c98e7eec71d4e2f755
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110458-pelt-tragedy-4542@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32f0967ea296d447925465c98e7eec71d4e2f755 Mon Sep 17 00:00:00 2001
From: Benjamin Coddington <ben.coddington@hammerspace.com>
Date: Tue, 15 Sep 2026 08:22:05 -0400
Subject: [PATCH] NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before
 allocating

decode_devicenotify_args() hands the server's notification count
straight to kmalloc_objs() as the array length, without checking it
against the message that carried it.  Bound it the way nfs4xdr.c bounds
an attribute length, against xdr_stream_remaining().

Fixes: 1be5683b03a7 ("pnfs: CB_NOTIFY_DEVICEID")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 88e1af0fda01..b1bc2c02b5a6 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -271,6 +271,13 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 	if (n == 0)
 		goto out;
 
+	/* sanity check the count against the remaining stream */
+	if (n > xdr_stream_remaining(xdr) /
+		((4 * sizeof(uint32_t)) + NFS4_DEVICEID4_SIZE)) {
+		status = htonl(NFS4ERR_BADXDR);
+		goto out;
+	}
+
 	args->devs = kmalloc_objs(*args->devs, n);
 	if (!args->devs) {
 		status = htonl(NFS4ERR_DELAY);

