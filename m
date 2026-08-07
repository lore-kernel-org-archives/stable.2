Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF744C50A;
	Fri,  7 Aug 2026 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083615; cv=none; b=cFMq1Bg7MoVttaIKhXlcalzPLg+lE5b/wmljNIg/+miLoF4KlNmCdGogkUr9OmNiufDRE+NWHLkLO+QRLHlaD/C0jdffUHPSK3MFM9gZSqQMbWWj6kjfiVbg5mFDBT+tZJr1PQGfnUHPidfG4Q8i/rrirbisLJgteYJhG3YTy8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083615; c=relaxed/simple;
	bh=NIezIbheGejgcNMFQX2ONCY9kdB7l75WTJUp5UxhDmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgjGLj15b0hIv4BjwCta1rB37e1/dqqne/2RCvzRa63jygV1bFCbqCnUAcd5WcJQanDQ53zy06C+MzoxaL5IAhKzKc2A7GmMJxHJ9YbNirg0WjLiQl4a32d5SgOzXFG5QKDi/y2fgD9isGStyEcixXhzRWljoNpD9hIZJYLGpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qjzji0qo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qjzji0qo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D460F1F000E9;
	Fri,  7 Aug 2026 06:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786083613;
	bh=f1d43tfCObnHTOIF3mzUEsKsmRXE+YbbWj0MHjSmPhw=;
	h=From:To:Cc:Subject:Date;
	b=Qjzji0qo8Po965YYils78DE5InQ2/8gFMmeBaIl3kzG9K8WxQ1JqMVXR3LnLNfnVI
	 EGYJdCujdlQlrSxRM07dAEgAtFVKLJXUy+VO2vIfvW09nJTezFtAW/LvI4axsrtyE1
	 GWx//Et9WV723L82MZ5/GkLBgkEe4Fa2KTU6VQBo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.150
Date: Fri,  7 Aug 2026 08:19:48 +0200
Message-ID: <2026080748-herring-unsocial-031b@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.150 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                             |    2 +-
 arch/x86/include/asm/nospec-branch.h |    9 ++++++---
 arch/x86/kernel/cpu/bugs.c           |    4 ++--
 3 files changed, 9 insertions(+), 6 deletions(-)

Borislav Petkov (AMD) (1):
      x86/bugs: Make Safe-RET robust against interrupt injection

Greg Kroah-Hartman (2):
      Revert "x86/bugs: Make Safe-RET robust against interrupt injection"
      Linux 6.6.150

