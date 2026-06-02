Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98053161A4;
	Tue,  2 Jun 2026 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365889; cv=none; b=fV8f6drWFHPPONoZjTNuOunJYZcIbreHdPUivkEgmsePIcgQ7TvqYkUhOLlrdpXKRpYVjljBOUMh/yfG+EaPwQgtZIcZXFS1ZNiNkRx+48oos8Zz4h7arGoQyX5g/CEa4tS9S4varq29xkFFoIBBIAkOIdQ1mAxHvJCjOPT5Qow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365889; c=relaxed/simple;
	bh=T4I31M0PLTEwTn8WEOdyD4QByeRGNlWXuxameENdrkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzgIbO5ohjmwMk3SiGb6DdI1iNzsW5CbtdfXcOWJv7+KIrIUB6TX7weBMu7+HjXD6jH94brs7BlnR41gt9+0Rxx82QwQ+CXKzPoT+Nr+LzHBl/+fumfOkHF1N4+9jjimvm0z0TDg+dGCvxR9cVBibQ88BpWDFXJK4lZOQy/OLvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nIVkQ2OE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nIVkQ2OE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LeFlYkjUmS3153POexTFVk/hRyqELYXfJyWxbUFn0ec=; b=nIVkQ2OEloPOV+48X+lLM1OUeC
	fgoztAFUyllJbj5tHe22c8jd/NklR+nnAXs3sSHZ+vzPAfr9rGUBilcbmSvr+c4xrY4b/uhX0ehzi
	w4VarDH2CI4RXNWdaKKEiG3uzB3x8VVpGmXAWeYE4sTlHmJxN6Hos8uaAueTO7LnItyC9LFywPsuQ
	lfT09AyO703q63bRf214goZ6A/Loc7EWs8R9whGpDQahAQsSsHNopLlGNiOkXzQD7xtI9nAB+QNIB
	vI7fuD3Lf3qN05DQaxIcRZehkpYGC4QMbcjG6f18qY0cwqlE/u3JQbflVSXC05ODuE5XTYIhCsnPF
	DudVPeTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUEUm-00000005Q2B-2HVb;
	Tue, 02 Jun 2026 02:04:44 +0000
Date: Tue, 2 Jun 2026 03:04:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org,
	Denis Arefev <arefev@swemel.ru>
Subject: [PATCH] make new mount API honour SB_NOUSER (was Re: [PATCH] block:
 Avoid mounting the bdev pseudo-filesystem in userspace)
Message-ID: <20260602020444.GP2636677@ZenIV>
References: <20260521072857.5078-1-arefev@swemel.ru>
 <20260602011907.GM2636677@ZenIV>
 <20260602013526.GO2636677@ZenIV>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602013526.GO2636677@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

one should *not* be allowed to mount one of those, new API or not.

Reported-by: Denis Arefev <arefev@swemel.ru>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
[[ I still want to see the rest of the reproducer - report smells like a missing
d_can_lookup() somewhere, on top of fsmount(2) bug]]
diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..17777c837683 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4499,6 +4499,10 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	new_mnt = vfs_create_mount(fc);
 	if (IS_ERR(new_mnt))
 		return PTR_ERR(new_mnt);
+	if (new_mnt->mnt_sb->s_flags & SB_NOUSER) {
+		mntput(new_mnt);
+		return -EINVAL;
+	}
 	new_mnt->mnt_flags = mnt_flags;
 
 	new_path.dentry = dget(fc->root);
