Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A3040860E;
	Thu, 30 Jul 2026 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410344; cv=none; b=oZL//gTW+ag024MeW3SZobZJv2DNl5yt/bzM5szcaXgdFyfz9/TW/qZqjO/kYrMQtOC5eOZH0UuvNSICPTRO1UCb4NWM6BDYwozyJBD8qYKkWt55QLdYqUXpEW6NYJhmY6DqR2MyMVtrA8cQ6hNsJjP4BdS/FUDKSg/V1D44v10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410344; c=relaxed/simple;
	bh=WZ8EJbezD3Oknl61pCuq0JA62pZVtOtjF/ldlmeqpUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crr1R4hl8B0ZBPTqZkhVfSW9RCPQh7Ly767AJ2t5b60/EaP7NW+R7JQCDxH4NQEeheHq5YUeR+50wLzTa53ppaNLnUMixvTbNDVVaiyEsVQdIOwWpKLa91OUABiHqPTxBk/ikT1KuPTlV6hbzEv3WuTjd4ooI+JntE+rzoeIUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BSlxFDl6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BSlxFDl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C35C1F000E9;
	Thu, 30 Jul 2026 11:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785410342;
	bh=Kf8FtM5xEhcPaLq/4c558Xv6MVu37r4lZv9GlMaouqk=;
	h=From:To:Cc:Subject:Date;
	b=BSlxFDl6S1BjuU0enVuraVDqa2sC5xC0KRwIUT5YiWuPwFsT9HGFreWyBmhjEbJdC
	 3R6fneXC9Tgg1wi+4wfB2+u/qVoKrXi3pS6gl6RNmFGq5YnHDvOzs9FWDJHw7mBhWm
	 FyT71r6Dh850fDTzP7MMLDUXQMqCD7v0kLC3ouIk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.213
Date: Thu, 30 Jul 2026 13:18:44 +0200
Message-ID: <2026073045-premises-broadcast-8510@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.213 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                       |    2 
 kernel/exit.c                  |    8 +
 kernel/signal.c                |   10 +
 kernel/time/posix-cpu-timers.c |  212 ++++++++++++++++++++++++-----------------
 4 files changed, 144 insertions(+), 88 deletions(-)

Greg Kroah-Hartman (1):
      Linux 5.15.213

Thomas Gleixner (1):
      posix-cpu-timers: Prevent UAF caused by non-leader exec() race

