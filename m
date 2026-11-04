Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817967;
	b=lUgvIrP46XVB2sNbiXfLnlt3QXVKprAeh87j+/2efFRwzf6NSzmA277fifKp1Gb+5y1h
	 V2B+jLTRVTcDCdRNnobyNtdhI3wV2YXXx4NsZZszpeiZxGS5sIozVtj6kNq9WWd7XA3k+
	 +pG3Fgp3E3NsBwVjaVdcFMahtCpi8FZCSzUH57Q2Crnvy3UG6ENBFW9Od8bHugOYKZr/g
	 BFWVMFg6+mR3EvOsb6GYXtV5Y1d9uv7qlartQkpKNzoWnEQbVKS8oCxftHo13wZmIE6tl
	 h0R3cpfQkaTXGZztbZU+iIH0vJ8wfHGibwQTtVsZuaOKs6Ves/cDNT+keKdlRP0ISrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817967;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wUTm2T7u+Eq9Mh2AFa6EhefqBQ1LkkmWC1YNJHtbnNk=;
	b=GaLX4ySi1mdMcDF/UJztXm1don4nw2Gma8x+3OuXdhG5Kw6OXp5EkPfXy4fYvxVBtKFH
	 502fEaka8JdC2JHG+yyJI7jkoerJTnw0hI+j/TQWqUry4jeErdvIV369sJnJTo9BfW5VR
	 eZHydhc6GjJx6ajsKnpDV3xSNXksmepcvG3R0S1t95Uw3T4cwXideZl1wXMlX7KyTkxgK
	 Dd39WA112ZgIdS23a0Y+JUdVRB24hY3fIC1t2j/XlFOlY68uFwbBsSWylXcTbxffcO7J7
	 hxRE/8qnNb9RHJq5nqeMQ8s5axfzMka808ujTB1QjEea8HtSi/MkqcbRFO4sT08gQhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CrqjCKz7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4D606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CrqjCKz7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BF91F000C1;
	Wed,  4 Nov 2026 18:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817966;
	bh=wUTm2T7u+Eq9Mh2AFa6EhefqBQ1LkkmWC1YNJHtbnNk=;
	h=Subject:To:Cc:From:Date;
	b=CrqjCKz7PwDS3CKU0xYxooirsO0HHlI7HTIrRBwG5fdfnzeeEOgx3S08F7kwTR9Aw
	 /FDxr4+PuS7DW5TA/5hPreDmya8J22LaDg98XXsVBhEyxSldxFy6tJ/CrZ0Oa/cydk
	 Of4idd2AN0p/bK/Slda3Bd7SykbCOOBNjmkK/rWY=
Subject: FAILED: patch "[PATCH] NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before" failed to apply to 5.15-stable tree
To: ben.coddington@hammerspace.com,anna.schumaker@hammerspace.com,bcodding@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:46:00 -0500
Message-ID: <2026110400-plexiglas-ladder-a8f1@gregkh>
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
git cherry-pick -x 32f0967ea296d447925465c98e7eec71d4e2f755
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110400-plexiglas-ladder-a8f1@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

