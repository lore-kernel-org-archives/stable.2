Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AFD4D0CE9
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577372; cv=none; b=o/HRhq26lDpZek/QqBHpEIai5oj/oExQKjmClWbT2p2ViwWyxWJm8nsKJMGfyGoG9l6Oovd/E+dh95dsCA9Bt5I26tvUMkrE+IMD8qT25un6K3ZlntbrfhadGPHm1tzkhy97eK1x3CC+bzEfmLw1oB5ZXvDhkxihk0Vy2iX/23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577372; c=relaxed/simple;
	bh=F1ng/Y/CXohF9Q12IGPwO9pNS/ASp7eePOiLtwdAE+I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZZd7CnEkJxiyg/AnHSipeKsD3YU/3n+nWFEpEOQWg0gZTdrxcKn17D/lGqS22UJqprCiHbCH0r8+BBI/gXStJmdipZFW3hUebbX9KQMPNeUG9ynRR7aQyBkTVKRsjpXENiR8AE0hegF620QPWZu982Kfw40nfLdVmdYN3Iav5uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hpb47qEB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hpb47qEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6851F00898;
	Wed, 16 Sep 2026 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577366;
	bh=hOJy+Ao73IktIf2rSgF1HDJlxRB17TpARMaZ0y74i4o=;
	h=Subject:To:Cc:From:Date;
	b=hpb47qEBrMyKh/ZofRPKRFfcFyeSLgb2CuE+4oSrzeZlPz4NEHBXQFwEbLRJINQmd
	 uvtomuyaYts6mj81O2HhzUKZ3pAnStOBLdmusNfQ1zzWdcyUNNtec7j+SJZU95yBMN
	 S9SQ8QALmEnrBbEo+4+xfUnN6GNgr72M86McCark=
Subject: FAILED: patch "[PATCH] smb: client: fix file type corruption in wsl_to_fattr()" failed to apply to 5.10-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:43:58 +0100
Message-ID: <2026091658-arena-emerald-fadb@gregkh>
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
git cherry-pick -x fa7a2cfcf1e6117fc478cae6809c66c518740969
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091658-arena-emerald-fadb@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa7a2cfcf1e6117fc478cae6809c66c518740969 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sun, 6 Sep 2026 16:01:04 -0300
Subject: [PATCH] smb: client: fix file type corruption in wsl_to_fattr()

Setting the file type in cf_mode without clearing the existing S_IFMT
bits first is wrong as it corrupts the file type when cf_mode already
has type bits set (e.g. S_IFREG | S_IFCHR == S_IFLNK).

Clear S_IFMT before the switch statement.

Closes: https://sashiko.dev/#/patchset/20260906172005.627163-1-pc%40manguebit.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 178da801e775..8a19dee564b8 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -1145,6 +1145,7 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
 	fattr->cf_uid = cifs_sb->ctx->linux_uid;
 	fattr->cf_gid = cifs_sb->ctx->linux_gid;
 
+	fattr->cf_mode &= ~S_IFMT;
 	switch (tag) {
 	case IO_REPARSE_TAG_LX_SYMLINK:
 		fattr->cf_mode |= S_IFLNK;

