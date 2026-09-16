Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647CA4B0E3D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577348; cv=none; b=q17gTJts5dJcUtm9E0GsjiWkmtFjd/oDuzb40RSlnyuYn3eIGG/tzd6jQSAZlnuIeZOa4BwK7A+VuNGMZcjWmRxkzJfFZVmXRQ1yzarRc4AeXQbc0JBAiKVlG7lSndKyJd6ru85EpMe+9KplMBCE3wBKGKo3sdJDoQ/6UGZTU2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577348; c=relaxed/simple;
	bh=+dzfy4pWvVVyqRj/pTPa44JUiBZfnm3rX39jed+mL2g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=peHIO6Vc1InhvmZsmAOKlSTosOq+wZSFzT+8QBHs0zvz0MZq+BNTqAzam4dwT+39G9ZWbmZx/3Y5aOG5Tw+figPlKqr38vzhEhpGHxEZ43HVNwkq05TYEZwChfytsA4NKnppGiPV6vGuWgK64Oz6W+815VVkeo/7jdErGioEvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c0pAF7wz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c0pAF7wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B771F00898;
	Wed, 16 Sep 2026 16:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577339;
	bh=3oEGpO77ai6q4bJZD6dqgBxIW+dn583JygJ8Ur9398E=;
	h=Subject:To:Cc:From:Date;
	b=c0pAF7wzY2j/0bvZa+hAg8ju1KRXGEdnh6F1+LVK1fTvM/ZHxl/bsY1/KItszFPX1
	 ktPcMhm4dzFOUA6yLZtc/6j+p1cY7CBCgH7NKlnqcQlWtOCe301kQQF6aQ2mQd0JgH
	 EPd9QlQNAXdqdZs7oigNPpSfexNePyDFe87iig2k=
Subject: FAILED: patch "[PATCH] smb: client: fix file type corruption in" failed to apply to 5.10-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:43:32 +0100
Message-ID: <2026091632-lizard-catalog-5af9@gregkh>
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
git cherry-pick -x 6bd360447941357e959414a525aa62576a448116
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091632-lizard-catalog-5af9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6bd360447941357e959414a525aa62576a448116 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sun, 6 Sep 2026 16:01:24 -0300
Subject: [PATCH] smb: client: fix file type corruption in
 cifs_reparse_point_to_fattr()

Setting the file type in cf_mode without clearing the existing S_IFMT
bits first is wrong as it corrupts the file type when cf_mode already
has type bits set (e.g. S_IFREG | S_IFLNK == S_IFDIR | S_IFREG).

Clear S_IFMT before setting S_IFLNK for native and SMB1 symlinks.

Closes: https://sashiko.dev/#/patchset/20260906181540.647469-1-pc%40manguebit.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 616ca2dbfac4..b6bded042e78 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -1280,6 +1280,7 @@ bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
 		break;
 	case 0: /* SMB1 symlink */
 	case IO_REPARSE_TAG_SYMLINK:
+		fattr->cf_mode &= ~S_IFMT;
 		fattr->cf_mode |= S_IFLNK;
 		break;
 	default:

