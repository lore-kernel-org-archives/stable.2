Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817962;
	b=4qlpWm0/pPWskSnM+jNqDvp1j0mnSUz32MV68qZt7IzM48HPcGH3KPttxFp5h8U7NYgK
	 1/bofxIFjrNQmE+9A1JuHuV+eJXAVfiud0Ll4L7orKmWzeCdEhmmfK93RgeQah7O24Yna
	 9x7rIzJaYo0b+JjbNNJHSiWmuVdiJTbj1yA1lvN5CwoDXllYveDtSdw1T74YufWEGfe6c
	 IDJZS3hc5rGeKvGViHXzE0b8aFbZXZWefNi4C5xNYnH7VWEuhpkh1HjK7m693ET0Abq1/
	 YVuSYBnWmdFEOwcm7ySUdQ1hyHKFFDfkwN8goeD4uatXw+NuSHUb0GjYz54YJKxxKHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817962;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jp7U+9fRdvfmrDW01ZlDkiRzHhRmT840iq1/zjOOyKw=;
	b=HfiQ6SDtSIobr00Q5hTX4/6eU5peI5Vg9/dwc9tvZm1tr4eSyI9lLnFKSvxgv22CB9J7
	 1ws/39aPVIHDlYCtPQkVDfrf5za4gJCudcF9L0YEqUzPn1uNIJLi5wZJ8n7CcSsmm5nxZ
	 iY+TUqMbWXYxCZhDpNDPWSc1G8nx8UsjCM16fi17V9ubMu30iDKFiXJdjP3MUM9GN17eR
	 hu65mBFyyqiU1G8Q4K/oThv7/5xGbb/Ggb8BY6NmJNIEBy39eO5PT1VCb7vhlw/B6QvYs
	 4kRj2MNhsw2EmwPdm/d30KYevx755l6eYJNaUtMbTz6h/qT9OxLn/UEQxHtIiFeWOyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0EpXAp3b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05F7606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0EpXAp3b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580B41F000C1;
	Wed,  4 Nov 2026 18:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817961;
	bh=jp7U+9fRdvfmrDW01ZlDkiRzHhRmT840iq1/zjOOyKw=;
	h=Subject:To:Cc:From:Date;
	b=0EpXAp3b9yCn57DgFGSvxLt6MVnCyoBtS6WzgyW8P542Y53qgiAfeEq5xIuNfUY1T
	 pGPuXzDpiAjzqShYvSMgY2+5m7iMaCMiIC7xtGopsK24tCtV3YMmrE2y2dyg7W1NTt
	 1ppWs9yCEYnwbLyX8eV5kNA1Gq7VzctRIFy8ZPWI=
Subject: FAILED: patch "[PATCH] NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before" failed to apply to 6.12-stable tree
To: ben.coddington@hammerspace.com,anna.schumaker@hammerspace.com,bcodding@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:45:58 -0500
Message-ID: <2026110458-subsector-balcony-5182@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 32f0967ea296d447925465c98e7eec71d4e2f755
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110458-subsector-balcony-5182@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

