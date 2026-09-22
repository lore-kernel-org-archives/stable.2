Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC04542EEA
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090086; cv=none; b=irW6C50C1amE/3v74dlROdyxhRsNKha23pTEFWzElEK0vC0j3ZcqkxikpbKy10lpQBwXRyAKRjMLI+Nmv8j1oygeAbMRubDNtKJw2NQ+PVrtKZNiwGAyDSCLIiXK8vhBAWaIc6oetuFV8emAsdYhPLTsDVR8dxHYBQas7+TF0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090086; c=relaxed/simple;
	bh=+5terzSraDSiYM7esBrt2PszSEPl94j/H7WiDkiD2WI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C1j0UDM2K0tiuSe2vlXv47hnKhAzx2uhpYxBNgjlmiW0oI1ZvmfvRAZy0CvtnZwJ0kU0Tg6mt0Hohc7Vneayfkkvf7wsAs9hpXW2+dq5zb09f3bCAxTnmGu4DkkCXmPYtfQa9NPGQBj9CNsCHgPCqTAVYcxPHeQPgET3U9hly3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cd+iWoA/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cd+iWoA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4091F00893;
	Tue, 22 Sep 2026 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790090084;
	bh=TcjKzJNSYjFD/yNvIyClerb6i1svr17XgwqIFvX4dyA=;
	h=Subject:To:Cc:From:Date;
	b=cd+iWoA/mO3T5s/mAGOSAFZ4qI9YaPeO6eNyqkowt5IgXOigFyiFX508F/GFiWWwu
	 /i+MQGoaDutPF1eDxBoGsnch0sJPOiHJ7k2Dfw1RvYXxgMYDO66SVCSjaNgbWHXZZU
	 P9cgEHpfr++qRml1FD7A2mAltj6DpY3/9nVxfm0A=
Subject: FAILED: patch "[PATCH] smb: client: fix missing iov bounds check in" failed to apply to 5.15-stable tree
To: sorenson@redhat.com,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:08:45 +0200
Message-ID: <2026092245-barstool-maximize-23e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x b09d092eb24ad0110f16a9b7c1ed5d2a0c1733dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092245-barstool-maximize-23e3@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b09d092eb24ad0110f16a9b7c1ed5d2a0c1733dc Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Wed, 16 Sep 2026 16:33:58 -0500
Subject: [PATCH] smb: client: fix missing iov bounds check in
 parse_posix_sids()

In parse_posix_sids(), sidsbuf_end is calculated using the server-supplied
out_len without being validated against the actual length of the received
iov (iov_len).

If a server provides an inflated out_len, sidsbuf_end will point past the
end of the iov. This defeats the bounds guards in posix_info_sid_size(),
allowing out-of-bounds reads into adjacent kernel memory.

Fix this by rejecting responses where the calculated sidsbuf_end would
exceed the received iov boundaries or cause pointer wraparound.

Fixes: a90f37e3d7ac ("smb: client: parse owner/group when creating reparse points")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 96063e355186..13fe8e3b48f3 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -77,6 +77,17 @@ static int parse_posix_sids(struct cifs_open_info_data *data,
 
 	sidsbuf = (u8 *)qi + le16_to_cpu(qi->OutputBufferOffset) + qi_len;
 	sidsbuf_end = sidsbuf + out_len - qi_len;
+	if (sidsbuf_end < sidsbuf) {
+		cifs_dbg(VFS, "%s: server-supplied out_len %u caused pointer wraparound\n",
+			 __func__, out_len);
+		return -EINVAL;
+	}
+	if (sidsbuf_end > (u8 *)rsp_iov->iov_base + rsp_iov->iov_len) {
+		cifs_dbg(VFS, "%s: server-supplied out_len %u overruns iov by %td bytes\n",
+			 __func__, out_len,
+			 sidsbuf_end - ((u8 *)rsp_iov->iov_base + rsp_iov->iov_len));
+		return -EINVAL;
+	}
 
 	owner_len = posix_info_sid_size(sidsbuf, sidsbuf_end);
 	if (owner_len == -1)

