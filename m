Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817965;
	b=Uo/01OSTlewKitdqSqKflrm11Z9OlC1i4E1Ipj1U+mCnIn8SZryAESOrYPtUr+XSRFgF
	 s75K0IlHZISKM3Lq3sLuTaZ0u4v2MyKnQVBIa3ql0rT8MpP7k69FDaS2E042Z44UrQGMF
	 jsIQKmo8QV/5MyArlN40yC0i7oVDGU+C+V22pWUIAjt6jjfZXIf55ig1mOrlj9gWwtsuV
	 GyGfjUhj5cdlMw4m7s+U9vzkSQGKHDKvLrCwcJ94ftEu4PWjjFoqi6qlXmHGqYvjibC5Q
	 KaTHsxZz4j74ooixB1xDa0P6M8Etv/vUSRSzaIjsMb326k20+RIplkYCSq1KgrlCQJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817965;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PQ9dsBxSTVYUNgREi1TEG9w6YubDNeSzGb3Z1VNImvo=;
	b=mBDTROZ0jqlhjbBQZCHU5j00B6a704FTqyRz9mCnN0hsfEj2P36reIMhA5GMjsXfz/GP
	 mTocuyZwb/nXhofMwmTXmdj8s1X5jTT5XiXopLFzjdSxzB43MvFTzRaO9hvQ5zzjLwagq
	 lpvybCfUdDXUx+Hq3xBO370f675ul1Avz7iIlS2ZCiJ2eK2NUnYR3FygHnDcUI5LOLx9v
	 t5tbQKt8PWtEKOQQW516AmduBNOJeAJkqqmYl/epOqhY92BHGUKUwsFMNFGZuZM5enm0V
	 NPA6wxWAioYHho52mveij02DLBFG4loBeCv2a4TFF+0TGs/IGP+CyFSyy00Xvi4nVrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kpYQ9vuc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D20606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kpYQ9vuc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E761F000C1;
	Wed,  4 Nov 2026 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817965;
	bh=PQ9dsBxSTVYUNgREi1TEG9w6YubDNeSzGb3Z1VNImvo=;
	h=Subject:To:Cc:From:Date;
	b=kpYQ9vucbvFvMvUTVwPb0ZJmzLxDhG4UH3rEqpvcDFoqUhIuPYPqaqkQBD6QA+VNZ
	 IVu0rsgJg/Kn1pX22r+jeet90c8k7mWvqJf1bto6obO44WU/2DUeX+0K6V7sHva7ac
	 fl4o3CV3ORZdljPKvCYJ8r6+ctPsKjBM0GV2noX8=
Subject: FAILED: patch "[PATCH] NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before" failed to apply to 6.6-stable tree
To: ben.coddington@hammerspace.com,anna.schumaker@hammerspace.com,bcodding@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:45:59 -0500
Message-ID: <2026110459-utility-dropkick-7942@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 32f0967ea296d447925465c98e7eec71d4e2f755
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110459-utility-dropkick-7942@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

