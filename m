Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283636195F;
	Thu,  6 Aug 2026 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037538; cv=none; b=c/G3FXPysUWmTA8jvlPqwGATElTxL7sJOvq/nAe3EYTAO0qYuhaBCTefaOFdnmAytY8tzrtEFH0VtwgqYiOK6oWZA4RzJ7+PTM4rK6tvngIsyNq80kS3wnu11USHsU0isu9XnBjXrJbjU0oljyJLwjEyhNXF03Jd9y0x+jvodFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037538; c=relaxed/simple;
	bh=mNGM3PyzDPjdUfpuYOYAJ5Ci61MTs+Qj7kBkm98/XeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ChKV/gZIa6oBo9dzHi23kL0KsuF4ihK15U5NlpQo/qXBDVowDr4MMISvlKyE60sU01wDZg674tjour8EC5sjtKazTCjk/miOKMtM6D7iKIaE0cHPuJ/ucD4btSSZ6K+CFOT3u6AjLbmYdPvg34UPWG4YZci8RmDYtIj8WHx7XtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mWpemWHI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mWpemWHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7BC1F00A3D;
	Thu,  6 Aug 2026 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786037536;
	bh=w+r9aRj7FuO7WxOuAt6jfO5bBGXoimJ/FWvCchiIdfc=;
	h=From:To:Cc:Subject:Date;
	b=mWpemWHIFonLW/VTPgdF2wy6mfiPSV8a6nMK77h71FmOZWFRYshRripT9ht5uExTH
	 lZhdqU2iZBHxWHRFFc7iJN6e9hu5Oh0E44dQYKctrnAa+xU03BMykniUP3c/KXGmD+
	 hhb86VB9StfXCc4f6/eGgW8W66rzISItap77b95M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.263
Date: Thu,  6 Aug 2026 19:31:57 +0200
Message-ID: <2026080658-providing-resilient-d339@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.263 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                             |    2 -
 arch/x86/entry/entry_64.S            |    5 +++
 arch/x86/include/asm/nospec-branch.h |   56 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c           |   39 ++++++++++++++++++++++++
 arch/x86/lib/retpoline.S             |   20 ++++++++++++
 5 files changed, 121 insertions(+), 1 deletion(-)

Borislav Petkov (AMD) (1):
      x86/bugs: Make Safe-RET robust against interrupt injection

Greg Kroah-Hartman (1):
      Linux 5.10.263

