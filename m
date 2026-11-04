Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817969;
	b=xplPw/CxlRJUYCmP2q5rg0UyctclJT0Xztiy8wqK6knko7YUcXWzqCTvpZpnktNavnBV
	 t5/+47UmftWJygK6aTuxLcUcLlYuF/D3cEcBxPcH++xqZ610wxZmDhBq2k+SGo0Xv/rDg
	 HCloACwMJSSnuVYfw8l/pq0p42VjjqWeK67RF6ZoZLmLHVHKrq0LyNIRv/o3rnAMsYz59
	 ifcyIc19g6EdFVeZtoF9fLpBKWuNWqSs1j92q1jbkdz0A32q29kcyLUx9iaFPVCIt1Keo
	 LY7Uv2RGyWQdaZms344yxM5XQKtxKtWQUKCz+8f0A2ah1odkVjbTLpYIKxLHmdjdj9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817969;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7KLXcGUkGwXOqLbbuWyBvOa0T7K9za+kQ+0ti+yN5tM=;
	b=r2wAdHCS8c7P0ZTR57h1mTpYdh9wI6lJagmiwxHzFCn6Pm1bysvMfP7qJb3lGtxET4d/
	 1K6zanXQPOo47/1fXNmMIAdRH8vWaArmCKACd+gFgmqKf2RaabeNHqaK0+UN4un7fjAOp
	 8smQCyvwugEu035P5Ntu5YTZrAIjpfKZSY7/KrAJjtbHpEIj0YLAxd7MzCqzLrRrD2qnd
	 0NK4oqWV7QaAUK/+pDoh0+TOEiEYUea85RSYbBXozs4B8TTzbaZXPJmUHHdJAAhKocqGm
	 GHeviA3yvJSYmvWwfm6zSe7p5QarLzitR4J3r32TTCmKL6S/B5V1w6aYxZtpnUr62XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jV8q3vRd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C2606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jV8q3vRd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F811F000C1;
	Wed,  4 Nov 2026 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817968;
	bh=7KLXcGUkGwXOqLbbuWyBvOa0T7K9za+kQ+0ti+yN5tM=;
	h=Subject:To:Cc:From:Date;
	b=jV8q3vRdF2nR6sM7yKVlMe2uOmB5rVK4Lor9iMPzeXBP7iS+izGfo5CzL3Ih2Xy1R
	 4W2Js8gFlMYbTz6NinrM8dYJASAvGmHa71RPd4IXCzzgpiXDSx9qZ3pJiluYLSou/Z
	 dhADIToyM3xAQlZ7GG2bEd5LTTc3QVBNLWo7oL0s=
Subject: FAILED: patch "[PATCH] NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before" failed to apply to 5.10-stable tree
To: ben.coddington@hammerspace.com,anna.schumaker@hammerspace.com,bcodding@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:46:00 -0500
Message-ID: <2026110400-luminance-syndrome-19a6@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 32f0967ea296d447925465c98e7eec71d4e2f755
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110400-luminance-syndrome-19a6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

