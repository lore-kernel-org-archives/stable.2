Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817283;
	b=b1KVyCDQuxY3txptNanUwJyU44aAJKYgysT9PxdHiFXNktz5SWia3a1CKJS3i7t4LMzI
	 3/+yvxaM4VVzJ2C1p6NIXAKHvUvTx+IL7jbLKJ1KgxyhvCWFnGWlI1jp2NxsNhVfMmOMn
	 0NrYFKJ9cRwKUpB7YhM0hXIlMs1pvpNa2srdLengQjttje7al0iEUdLrdzfMEq2KdJhPJ
	 dJmzv2y6Becc5FT9Q6DN3GC2QodmjQeEjq3Cxi0OzEQryl5I8ae9Fef46fqra+c+hg6TC
	 0JbCxM1a1bU+lmVzQ4gnYKmIBGx4ayEIHN6GIO/rQjr0l/rEXtNFpYJ1VIdRv4Deebw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817283;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lHdZ1u7tO6g0FdLvGarVQ5q1/SAGeq7Fs8cFtp3xxeU=;
	b=oOIjwmBquB5L0meftWNPM/uckp2a1xNIk1NykMhWk8ybaQXhXh8ngGIm/EqKcMKo4jbU
	 ZLiHHTiTTeiK0zcZE7cXhefc0WhlFHMRVOUEu0haQxviJaOqqn1o4WUhNxP0H9qE/cQ9c
	 KWIqtt49v26C8LAQH2YdujHpnF1ZjIySYCgrrHEwURurJaIsiSYJ/sncGhB3MOf+OuCC4
	 p8+WuhrLUhBw4zfcloT6Acjn4m4bv4uIO9+9A6ntQipXDhmJyRMaPb4h1tNZx6DjVSyLp
	 9WQjHFB83Qp4oX+YqSvnn2rnIyp1TyPXsjI8M+sLEmdjIFFLjVQ3giI/4nIar3SEWIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bj0le5NM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58FF606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bj0le5NM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D0B1F000C1;
	Wed,  4 Nov 2026 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817282;
	bh=lHdZ1u7tO6g0FdLvGarVQ5q1/SAGeq7Fs8cFtp3xxeU=;
	h=Subject:To:Cc:From:Date;
	b=bj0le5NMNvJ+gel24qn4BAsjCx42nTvMd0yr1ajg4kCoqFgNx9iVxsuS6ZgFfKqk7
	 V4lTIo6MIc1rNQPd44FY+f9NnwpJ2GMJU32mfhmxgQSysppw0MeT8nfPsO08gt4E2e
	 xWUpTQ2EfiTyao6r1DQwXmgOrjXWjr5u2xFlgRCY=
Subject: FAILED: patch "[PATCH] smb: client: require stable pages for SMB compression" failed to apply to 6.18-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:34:41 -0500
Message-ID: <2026110441-ethically-speech-8e44@gregkh>
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
git cherry-pick -x 8667061cf99394526dd9c0ea2662e6bbc7ae7848
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110441-ethically-speech-8e44@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8667061cf99394526dd9c0ea2662e6bbc7ae7848 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Tue, 13 Oct 2026 10:33:41 -0300
Subject: [PATCH] smb: client: require stable pages for SMB compression

Like signing, SMB compression builds the write payload from the pagecache
folios: should_compress() lets a write request through and smb_compress()
compresses those folios on the way to the socket.  If a buffered write
mutates a folio while a write subrequest is still in flight, the compressed
bytes no longer correspond to a consistent view of the data, and the server
silently stores corrupted contents - worse than the signed case, which at
least fails loudly with STATUS_ACCESS_DENIED.

Mark the mapping for stable writes when a write may be compressed, i.e. the
same condition should_compress() tests (compression negotiated and the share
allows compressed data), so netfs_perform_write() waits for writeback to
complete before modifying an in-flight folio.

Fixes: f046d71e84e1 ("smb: client: insert compression check/call on write requests")
Suggested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 43a2d7982488..d94007deb548 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -88,7 +88,9 @@ static void cifs_set_ops(struct inode *inode)
 		else
 			inode->i_data.a_ops = &cifs_addr_ops;
 		mapping_set_large_folios(inode->i_mapping);
-		if (tcon->ses->server->sign)
+		if (tcon->ses->server->sign ||
+		    (tcon->ses->server->compression.enabled &&
+		     (tcon->share_flags & SMB2_SHAREFLAG_COMPRESS_DATA)))
 			mapping_set_stable_writes(inode->i_mapping);
 		break;
 	case S_IFDIR:

