Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C6A54CF78
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090025; cv=none; b=YmNadBu7fn+NkdxeMSnmKcPL/IgVIT3w3YQZiuolS1fd+Cr4gWNXq7JPXBSh/hF35cIUn6sYqA6dG+BcWXgMwSB6UG7+xKA8q7Xwt0LWQs7gk+leomijZKy9kJFxvihksc35yQRkNqpAlXZpy76gJJdKAH5zfxGOG7ns0RKDADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090025; c=relaxed/simple;
	bh=GooR3qmKXlFMzjKe/93kaMf394ovQkW/pex4djm3khw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MvHrASjOjHZX7xrdy3IHjNbEzZsIf8mnKhgXxCBSvDG8rUimK9eh9Gj9amk+gAksmZ7FUPSJRTExXTSUywQAlyczEi1cstjrGk39+35Vb/Bt5DhpLhHQt6VdCzIaevuJTq/tewFQ0R5r6ctj5uWXb0sbbcyjfBaBCvEE178AplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1OVSQyG9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1OVSQyG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CF21F000FF;
	Tue, 22 Sep 2026 15:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790090024;
	bh=MQ0J9aNO4hzYI9ND4zqjAitnRFgDf97U80+1j09sNgo=;
	h=Subject:To:Cc:From:Date;
	b=1OVSQyG91aB2sNe88gvN+WaJAX/X7SkDM8yzI5XVsvZrIOHKsiYw7YHNmnW5lPVKd
	 dkeoVgyLkLL+rG+mL4CIdkY6/bYmzWr5qDAJHgoZHB1fIJDRF0gkfTfM65CpPaUPgD
	 Y5HmsVk/pYRoLI1qzIGV/ji6D1Y/ILYKyjL3C6Rg=
Subject: FAILED: patch "[PATCH] smb: client: fix next_buffer UAF and NextCommand bounds in" failed to apply to 5.10-stable tree
To: sorenson@redhat.com,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:07:10 +0200
Message-ID: <2026092210-mango-cacti-413b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 05762c5bc1cfdcac36747994fde2c04387a457f1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092210-mango-cacti-413b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 05762c5bc1cfdcac36747994fde2c04387a457f1 Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Wed, 16 Sep 2026 16:33:52 -0500
Subject: [PATCH] smb: client: fix next_buffer UAF and NextCommand bounds in
 compound PDUs

Fix several related bounds checking and pointer lifecycle issues in
receive_encrypted_standard()'s handling of compound encrypted frames:

- Clear next_buffer after assigning it to server->bigbuf. A stale
  next_buffer pointer can lead to a use-after-free on subsequent
  error paths.
- Update pdu_length to the decrypted plaintext size (buf_size). Using
  the pre-decryption length allows NextCommand to point into stale
  ciphertext residue.
- Reject next_cmd values smaller than MID_HEADER_SIZE(server).
- Fix an integer overflow in the upper bound check by verifying
  pdu_length - next_cmd < MID_HEADER_SIZE(server), ensuring the
  trailing slice is large enough for a header.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index cb4fd09f996e..fcf7033889c7 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5365,6 +5365,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	length = decrypt_raw_data(server, buf, buf_size, NULL, false);
 	if (length)
 		return length;
+	pdu_length = buf_size;
 
 	next_is_large = server->large_buf;
 one_more:
@@ -5377,8 +5378,15 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	}
 
 	if (next_cmd) {
-		if (WARN_ON_ONCE(next_cmd > pdu_length))
+		if (next_cmd < MID_HEADER_SIZE(server) ||
+		    next_cmd > pdu_length ||
+		    pdu_length - next_cmd < MID_HEADER_SIZE(server)) {
+			unsigned int max_next = pdu_length > (unsigned int)MID_HEADER_SIZE(server) ?
+					pdu_length - (unsigned int)MID_HEADER_SIZE(server) : 0;
+			cifs_server_dbg(VFS, "invalid NextCommand offset %u out of range [%zu, %u]\n",
+					next_cmd, MID_HEADER_SIZE(server), max_next);
 			return -1;
+		}
 		if (next_is_large)
 			next_buffer = (char *)cifs_buf_get();
 		else
@@ -5414,6 +5422,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 			server->bigbuf = buf = next_buffer;
 		else
 			server->smallbuf = buf = next_buffer;
+		next_buffer = NULL;
 		goto one_more;
 	} else if (ret != 0) {
 		/*

