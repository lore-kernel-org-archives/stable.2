Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5938737A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090052; cv=none; b=m6uOJteViSQh/af08RfcLXo9PHuCEJcB9MfPt68raBbhB4G6YNiIvuRUwKqnm3DTbC5/aTB0YM0K4MsmrGAkN/matzfD6PwJql0d1l5pwLn/PwkviFC6KdsMsZFA0iNhstO+0AnUkueZ4C2DWhlnUOkSXbhzkXbNYLzBDQh39dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090052; c=relaxed/simple;
	bh=PNhayetvnOpLCFHQ+w2Eh0LxeZ6PrF2/E5RiVesaUws=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IFK0ED7uWTBNm3xCHONEJhO28F2/mraOCl2rSo4E/MTdX0IPRBBITRN0ZUXzROoR1nYJUDXIqkw9+Tlmos3P+m+2pPE7SBODeg8N4MZztCRwC6kkMbD4RGNyIK+SMJMMO0F1Nkvg/t1LPuRvVjQGOTnv+aCUr6gKXJoVolTmNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xmEeZ2qB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xmEeZ2qB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F641F00893;
	Tue, 22 Sep 2026 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790090050;
	bh=1QS4SOzVzDage7JtuY+JFDDU++JJ2yyrM8kC5QPgIzU=;
	h=Subject:To:Cc:From:Date;
	b=xmEeZ2qBuABLuG6of7WUUky69TUEMlfQeFguArtHJnMz/Xgj4LaEyqyJca+ZNnv1m
	 FQ03g1njWAvBhLymS1s7teF+PtE+oXbNRhxjlM0jorYjf87V9s6mDHydn1HI8ZlHjP
	 eJfvncVNt3mjZIa8b6qr9Nu1EOnVRNuKRZMTVs+0=
Subject: FAILED: patch "[PATCH] smb: client: fix potential OOB read in smb3_enum_snapshots()" failed to apply to 5.10-stable tree
To: sorenson@redhat.com,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:07:46 +0200
Message-ID: <2026092246-amplifier-zookeeper-348a@gregkh>
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
git cherry-pick -x 4775c3b7a597907e0b97556c7986fda238a377ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092246-amplifier-zookeeper-348a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4775c3b7a597907e0b97556c7986fda238a377ae Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Wed, 16 Sep 2026 16:33:59 -0500
Subject: [PATCH] smb: client: fix potential OOB read in smb3_enum_snapshots()

If snapshot_array_size is smaller than GMT_TOKEN_SIZE,
smb3_enum_snapshots() sets ret_data_len to
sizeof(struct smb_snapshot_array) without verifying the actual length
of the server's reply.

Because SMB2_ioctl() places no lower bound on the server-supplied
OutputCount and allocates retbuf to exactly that length, a short reply
results in ret_data_len exceeding the size of retbuf. The subsequent
copy_to_user() then reads past the end of retbuf, leaking adjacent slab
memory to userspace.  The subsequent clamp check is ineffective as it
only reduces ret_data_len.

Fix this by rejecting replies shorter than
sizeof(struct smb_snapshot_array) with -EIO. Note that the bound is set
to the 12-byte struct size rather than the 16-byte
MIN_SNAPSHOT_ARRAY_SIZE defined in MS-SMB2 3.3.5.15.1, because 12 bytes
is exactly what copy_to_user() attempts to read.

Fixes: e02789a53d71 ("smb3: enumerating snapshots was leaving part of the data off end")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index ee3c98e3f316..3464470d3297 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2463,8 +2463,14 @@ smb3_enum_snapshots(const unsigned int xid, struct cifs_tcon *tcon,
 		 * and retry the ioctl again with larger array size sufficient
 		 * to hold all of the snapshot GMT tokens on the second try.
 		 */
-		if (snapshot_in.snapshot_array_size < GMT_TOKEN_SIZE)
+		if (snapshot_in.snapshot_array_size < GMT_TOKEN_SIZE) {
+			if (ret_data_len < sizeof(struct smb_snapshot_array)) {
+				rc = -EIO;
+				kfree(retbuf);
+				return rc;
+			}
 			ret_data_len = sizeof(struct smb_snapshot_array);
+		}
 
 		/*
 		 * We return struct SRV_SNAPSHOT_ARRAY, followed by

