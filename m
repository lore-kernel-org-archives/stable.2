Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6A4B0E3D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577366; cv=none; b=NrXBTJg7E24XbMl/Viu/mpJaERVIk8S0/CdNJYQsz2PA7Y03+LrT3rCEYV4ZfnaTlnOaLAzL30Z4OYC+2fzsBj3bkG2YGpX/rTHam/s31tIriTk2lThyG0cdO+AvUnIJ9oy6Nw8LF3TjoFW9BizoVFnreaguJ4NZsMPtdTYvClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577366; c=relaxed/simple;
	bh=sqxiymqWpyznoclnfO9e+fS+HvmSKOAff7tee2lXIGY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f9IQ90lDPLtKxYyoy1qNGvi+d65o42IUWupLyeHZckHOSdu9KeQIYPTO//clsXS8DowO2vM6I98YHlGiECCY254U6biD2kHkvoyy8EB4PSZIkgL5weLnwT2tWvLBA1xcM9LI2R3oUvIWBrviTxWmSacrb87+XdHpj4wK2xG1xUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OhUBgy1b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OhUBgy1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B703E1F000FF;
	Wed, 16 Sep 2026 16:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577360;
	bh=0uuH1s3HpgE/N5JUaeEIGKhrdcR9B+zFH3/3wdu7dx8=;
	h=Subject:To:Cc:From:Date;
	b=OhUBgy1bHD4ivvvXFSDud89DGg/x3OYlyMktwxOksN7tTLjf6eUhM9HMxWg7b5EP6
	 XU1qnoWpTXUGCe4YjwUA2DFqx4PdL9WkBq7zO5YkAqU23NuvZkbVDeWO7ACSH+9Ecx
	 1vsiA3cj8Cl8h27BkY1V1JPl03DOkr/+5IpvRaRc=
Subject: FAILED: patch "[PATCH] smb: client: fix file type corruption in wsl_to_fattr()" failed to apply to 5.15-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:43:57 +0100
Message-ID: <2026091657-dismount-vixen-3669@gregkh>
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
git cherry-pick -x fa7a2cfcf1e6117fc478cae6809c66c518740969
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091657-dismount-vixen-3669@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

