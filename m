Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6193E0C75;
	Fri,  7 Aug 2026 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099730; cv=none; b=qwR/D6z6hEObREfioSy93m0GBLkO1TjzJTMRq19tF8GJ7c64QHdFWAxzzFJ8PnNIKnaaAnGeXcXuXUlfyQq05gpb7zKe8JqDnOd9kPtBceSHB3SCkMXPgbHJu3XVHihMoM2gEgM5Y0i1lEXqXMvT9NrzqX8v3u6k5i48s4ndC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099730; c=relaxed/simple;
	bh=MPWeI5N2Qr7gqog2CWrbDpdhNP5QAqnp2SbTt4XT5y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnHfn5amBdyqAxZPKpOBDtnO1v7QRF3gXdsx0Xx3xxAv3wYpmluEhb3rIWsedckVkwpZZl534ixDh0p0uL+VUmrT1tswkGKrf6GkxGizUIVh/VdVvGBWEjY9wmFTuZBD1bMZSHvEGg7tjnIxLCWGWJtrv7ct9EwkIWEkQIH+hQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=otDfhMBV; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="otDfhMBV"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1786099109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HR1aVfxqlRcBazhVxMUTE/+jpK6GdHO/kmeUET9JbL4=;
	b=otDfhMBViNDg/H//BwHikYP5XzOHC4wvA0Zdewo6+0pENC82tv4k6ZAfy6bJSeIBN4aU34
	eKyv4LNLHZauGlqF+/1yyvALuHMXFE5GfFRCjQI+fH6rM8Tfi0NbMugdjSFzIUTLDjYQIY
	qJmXZ5Qh+bTfutCyubsCo59iruM69hw=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10/6.1/6.12] mount: honour SB_NOUSER in the new mount API
Date: Fri,  7 Aug 2026 13:38:27 +0300
Message-ID: <20260807103829.15163-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

commit 6dd3c6884cd9defb511284b566cef5ac8f657dbf upstream.

One should *not* be allowed to mount one of those, new API or not.

Reported-by: Denis Arefev <arefev@swemel.ru>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://patch.msgid.link/20260602020444.GP2636677@ZenIV
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[Denis: rename new_mnt -> newmount.mnt]
[Denis: use goto err_unlock instead of direct return]
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 fs/namespace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 94c06c842902..a596381dba1c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4229,6 +4229,11 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 		ret = PTR_ERR(newmount.mnt);
 		goto err_unlock;
 	}
+	if (newmount.mnt->mnt_sb->s_flags & SB_NOUSER) {
+		mntput(newmount.mnt);
+		ret = -EINVAL;
+		goto err_unlock;
+	}
 	newmount.dentry = dget(fc->root);
 	newmount.mnt->mnt_flags = mnt_flags;
 
-- 
2.43.0

