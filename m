Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817287;
	b=sstSgqcgSbP/1KwggkRivE87IA+jj2lxTO28SlW6weeGezEh8KZVcczWiwoLhnnObs6l
	 ugdhr+uIP3H49HFZRegmwnwmfXuynBVv34BMFQ2lRCTU6msnUusWkLziXf3yGzY9jIB59
	 d4VQ1Ef7nSpj8oVrwlChSbLV69dEX1IKIfjQrKvZZtJxIxcFD+rUw3JrLjI1M0ZrEuxuB
	 +8cliFIdaLEKvZLyazhLQvHd6FJFVJzblb9RH8Rkadvf615pxTU8nTMofEHjos8iFUCL0
	 0dxWN+de1zTTQMYo9yBWmXnz4FzpvPnTsRt9dMZf7QeZqzUDOavf2eJEXlTrJKPT4kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817287;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0h/gAJNDvzkk5NSFXmyhTJES9vgDz3Ri9s1YuoJI7KM=;
	b=MUTp4KZ78Nwbqcrr3ZGjq9MkZyRC3S7Hycf1ZyHTLQNVW34DBWsd63T0m43ZDuwy/uNC
	 eYLl/AI5k9YcDb4ApIiSq5S0lTWRpvx9V8VZeBYXeRF/blCNJC9v+TTW2Kl+TzM8bjkez
	 Gm3E6cSYrQ/IXyM0t4J+wiTP6YLCWD/tO+Cfyzc97mLvS2BFK3nsM/d3CtVotn0OSbmtV
	 t4rJe3hazhp3nPDmrmPBHQ/Rop0bFK/xcMp31mP/KUNyyfwSbjoyyXM84R/4VNdH0piVN
	 yxH8TSd4S3HiHWWvbUXwzBWNl0hrASv1nBfXPa1N+fPlK9jSYYzjNoYAaIvS/YDHdCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uelxDLw9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D7606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uelxDLw9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4576B1F00A02;
	Wed,  4 Nov 2026 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817287;
	bh=0h/gAJNDvzkk5NSFXmyhTJES9vgDz3Ri9s1YuoJI7KM=;
	h=Subject:To:Cc:From:Date;
	b=uelxDLw9zm9QD9roFeNWG9u1mJpy+0OcLwRg6MRUbUMuBsZNE6cMEfB+dmIxAZtfy
	 AH7Br5JCiwO5J4liMH0KQRvqJ+636rWvPi/pbEqDgTHNoMJe9k1ine5gcc5KMYT2Wc
	 WcyRd8klGdkG9gD7UGpakiEKA/+2NOFPg3G6mYEw=
Subject: FAILED: patch "[PATCH] smb: client: require stable pages for SMB compression" failed to apply to 6.12-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:34:42 -0500
Message-ID: <2026110441-macaw-surround-30fa@gregkh>
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
git cherry-pick -x 8667061cf99394526dd9c0ea2662e6bbc7ae7848
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110441-macaw-surround-30fa@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

