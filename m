Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D5B3C9898;
	Fri,  2 Oct 2026 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949224; cv=none; b=h1bmh+f0Isgjapn9NVbZmj16bgIijh/GAEBIMcA/OiB7B9kp9HemUy2LMA4/urYakANUccn9qzhMVsJUreg+YxfhEszjm0mEaoBsTOxjTsMDXDu4Y7J0TXs7S3mW1eE5+/3HQrfkMmURaLdUfB5JRvzvdLyD0RDt4Lx999rgw4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949224; c=relaxed/simple;
	bh=3GX40kkgFX04f1M1VBLAGNqLkmuGlBA208POCG1wU+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4bE03a3h3LUJ+6mkUXszavhWsf/D5jmTwGSdpkaV4L2q01gORGet42zjp6QupTBBfJvtL0SIFWYpDDWlMmixBpQmqGAqwWXkS018e0t5wbaY+Mv4twEAqAdXswtmx9ZWzXDFI9YQ+HHatYgJsmcvn9Oq2CwWVnkk2xaIE60/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD2iwPdq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD2iwPdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAF71F00898;
	Fri,  2 Oct 2026 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949223;
	bh=+VRNB9zEeB4QJcujwwjWiPxR8ID0I2zr7XM9sLDP7sg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JD2iwPdqt6imyFCplV2UHpmhUxWRBAzF7YDuekjOHJnE17TEeYqspKnAbuOkFdT5n
	 MQmiL9PSxNprjZqhBua6IL3rB2FUrybaD0lZAkOC00e+59UIQqJ70+81SiJaYrRj91
	 juhiRpuhcFNDf9mTkz7khC/kYni5m0IfHz2GmrLHnMMAnv9lHng3usDmQQZVfAqtGB
	 XldggJJx/QS7ytvHWvOs4R7xmzxpUQlXjKnF/Cy1b9s/C1UIP6xQp+/+9CDh3bJao9
	 bP1s/im6BKgDAzjJIrPw5dw/Vp80+LWNOlYSxiv8itAzuhPT52d0iEDkKgGGhJfuFA
	 AYAvUo0/OT1mg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:34 +0200
Subject: [PATCH 03/21] fcntl: refuse F_SET_RW_HINT on an immutable inode
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-3-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3GX40kkgFX04f1M1VBLAGNqLkmuGlBA208POCG1wU+8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x6xYeY3x06v5Q+NirPtku85OCtKaifIWt/aEPUry
 mnn842XOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayWoeR4c3ExJAU/seHIm/t
 kb24RSP1n6kTS+mOqytj3q461JS5uInhf0TZ+3OiJ6ryE68ETzO0/v07Tei+o8tZjdr4T3vKtnh
 VcQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

An immutable inode is never written to so write hints are pointless.
Refuse the hint on an immutable inode the way setattr(), fallocate() and
etxattr() refuse their changes.

Fixes: c75b1d9421f8 ("fs: add fcntl() interface for setting/getting write life time hints")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fcntl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index c158f082f1da..9b71bc9d71d1 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -372,6 +372,9 @@ static long fcntl_set_rw_hint(struct file *file, unsigned long arg)
 	u64 __user *argp = (u64 __user *)arg;
 	u64 hint;
 
+	/* nothing is ever written to it */
+	if (IS_IMMUTABLE(inode))
+		return -EPERM;
 	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
 		return -EPERM;
 

-- 
2.53.0

