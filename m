Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD814D7973
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577348; cv=none; b=dA5QuasAcyg2MfvwCjY8aZaMd40GqBmfYHT/SksNSHxa7URelaHwtL6eIyvus5TWWkSU2VMrxsBHApxZOaKCdiASnjWWQRERhJXgbmrFpzilO3mVd0UB6MkgIkKvNDT7muiCb8m1h9K2Me4qFP0g1lvNWYKB4lchCKaSeAufYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577348; c=relaxed/simple;
	bh=UuiFX3V+MDpGcvar+LJ8Va1TeVW/6Ain5kBQ+Paqb48=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jU+VoJ7Fzl4ggFKeJ/k6QPxQrzu9IkdSsbn9yaydjkup0H3jQIUq09FUZYfVLaON7qopm8A1t0fJFrUaS4QGVIrybMFUCpj4TiO46p0uheqKhM0F0GJBjkyLv6PA8kf74hGaXJE2usb2Vns4KZTcKU+TMN7U+cszg5fqTCk7mrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Br4eSND/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Br4eSND/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57841F000FF;
	Wed, 16 Sep 2026 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577342;
	bh=eAqm4CMZJ+xPbpkvYBlPmwI3RNNDzxSOupGGbK2VLRA=;
	h=Subject:To:Cc:From:Date;
	b=Br4eSND/+txb6+0heq6WWMo+b/A1FI7Ev/pp3xHBXRovR5buj3YPazMAOonwlztJu
	 iLD9RXmFWEDihg7qlOHVG1hB7G693woeGuOwPixnHyW6Ux5dykNiLvwpTENHw+OhOR
	 4/uCLGZFE9CeJAVUG4RpXbAT1LYcTVReGS0Dn/do=
Subject: FAILED: patch "[PATCH] smb: client: fix file type corruption in" failed to apply to 5.15-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:43:32 +0100
Message-ID: <2026091632-favorable-freefall-74c4@gregkh>
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
git cherry-pick -x 6bd360447941357e959414a525aa62576a448116
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091632-favorable-freefall-74c4@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

