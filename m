Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715FC30C152;
	Sat, 25 Jul 2026 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784959513; cv=none; b=VZirBc7tMPl3mL4oTos7ftV+3HcjtH5akbOJr3SBBkiakjrtvLltTJcNh2+7oq8/SUaVeaGEg5zgzZ4z/1QoCV+h/1lRdMz2RL8b+/fz3bi3lqfSUSGcujaRYdrGVPCQNWttXEyjZhb7MkMA5pelXYoNA1EYyje3XbNEQLBrNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784959513; c=relaxed/simple;
	bh=bNo/BCp8is0bwBLzVMTFmoeIM6ZZhLBU4Iw7fv3GtmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFxcJ6MJWR1tqVyucBZKd4V/vgBN06+zUUBhW2dThmLk+kUQppN1/jxlgZhF1BdsOTnw5o8PKOwBguYJE9UOGcag1Xt/l3ZEbgrxAPS7IjdQRiS48vl2NipVNJBa3blRzwm5cY2+E1ASa54joP5Jul7wbOJgxs7Lx8WRquYYIfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LbZGy0/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LbZGy0/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DA11F000E9;
	Sat, 25 Jul 2026 06:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784959512;
	bh=Pj75V0myELdEepQzT0wRv3orLcTIoWcp826pJIW2/Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LbZGy0/lkcI+qBYTL+wmZcVYsuktx6ulEKsKPISgzu8F5L7DVtTba9upp8Tqw21dI
	 nHr29d6lqVdkGIbHpp2WpiewFp0wWYV0Zqj6BJCnQ5mjld4q0C2tKN90OXwLjXG6fh
	 QfBF9pOZDUKtTOxTDp+kOO1t2JDWTI0nnXEKn+jw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.98
Date: Sat, 25 Jul 2026 08:04:51 +0200
Message-ID: <2026072507-unusable-scooter-378e@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026072506-sepia-baguette-1b41@gregkh>
References: <2026072506-sepia-baguette-1b41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 2eda2cddaace..671079b33674 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 97
+SUBLEVEL = 98
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a8a024bb62b4..e726f9dbc146 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1372,8 +1372,10 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			goto mext_out;
 		}
 
-		if (file_inode(filp)->i_sb != file_inode(fd_file(donor))->i_sb)
-			return -EXDEV;
+		if (file_inode(filp)->i_sb != file_inode(fd_file(donor))->i_sb) {
+			err = -EXDEV;
+			goto mext_out;
+		}
 
 		err = mnt_want_write_file(filp);
 		if (err)
