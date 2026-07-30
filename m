Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CA411A18;
	Thu, 30 Jul 2026 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410369; cv=none; b=WT17MZWAYtl52NC8xoojKYKVM5S9Kmx0PG9Gn1oiXe+R4euXlvr70nZ52cpve6E2kWCkPpxSMkGU96PfWJyvWJo4oE3ixIP7jTqCXmbCiTyMfht9/fJPnN1dMXKtXXhSBmS6SiM3uYddSTnf8egMkqgtNoXhSduZG3xeJ7/y0wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410369; c=relaxed/simple;
	bh=fnKG4mp0CEIO4xpS0+UjfbB0muErn/elZz1o7ACX7dE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzJTVGD7yIioz9r4iD2poV31vMY4EYo1ef6eF3bQcyy2KQzNEYfKv9oqTXhTAxYZtKCokwVM5yulaB+tTpeZ6nr50EOywF2xoLjA7+nG7HxSAcr5A+9slRfWJQT67rCpI8/uhRXWnCIJC8Z7dhGcLs8+1eiypSlumDn51rCzQy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o/jaIX/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o/jaIX/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4A61F00A3A;
	Thu, 30 Jul 2026 11:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785410367;
	bh=eCgxIo9WhOor/Ca5TVy5O/iFAvJoxgl8JQNizE+UCko=;
	h=From:To:Cc:Subject:Date;
	b=o/jaIX/Ea7vUMtB9JVA/8JSf8oofNtB1bJVh7KbE5qdLyCDUoMkeDhmlqhd8TAvlj
	 MtaboVCRRr6fpA+zbPq8AusEEXEJYHleB76QWE4fm8mLLehKYi0WT/6QgXa1aOaI9N
	 Sszp8pvZlUTOQMCjg6k4NqErHQVnn43VtVbXJV+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.41
Date: Thu, 30 Jul 2026 13:19:09 +0200
Message-ID: <2026073010-occupier-clay-d7fb@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.41 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                       |    2 
 kernel/exit.c                  |    7 +
 kernel/signal.c                |   10 +-
 kernel/time/alarmtimer.c       |    6 -
 kernel/time/posix-cpu-timers.c |  185 +++++++++++++++++++++++++++--------------
 kernel/time/posix-timers.c     |    6 -
 kernel/time/posix-timers.h     |    4 
 7 files changed, 148 insertions(+), 72 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.18.41

Thomas Gleixner (2):
      posix-timers: Expand timer_[re]arm() callbacks with a boolean return value
      posix-cpu-timers: Prevent UAF caused by non-leader exec() race

