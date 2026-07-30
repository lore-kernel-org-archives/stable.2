Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C521A7262E;
	Thu, 30 Jul 2026 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410336; cv=none; b=dZEgWCkIU++nev6b0PJ3hFPCVXCrg4nPjc17B+rz2JFwhlEJmO0SWx41VhriyC4mRVTmh4XwleT3pbOQ1YF7NmktD3LYcOwGNZYKr/XfrCVGU67RFUcr16CRV0K0/eJjxyYJUemUT606Ok6gcKLPVjENxIAgOJTEv0RukjE+/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410336; c=relaxed/simple;
	bh=zNOhop4V6lPezmj2xD6HTQCexUxaDlDIQYGukesRwLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YiglYW/q2Fs54tEPh0MYMSkNHlhj1HCo2aViOgUZo4d/Ux2WzrJUT/RBWSjxs+eQfvMpuhldm4WWhBRYLC3FpRHmUobgtNXyxqTne7ObCV20q1U0C09oqdA7PcpbGIrGyYn4DIporWqXvT01TltvbMnt5F9Y6ir2PTOAW0kF8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LFjCFsri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LFjCFsri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EAA1F000E9;
	Thu, 30 Jul 2026 11:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785410335;
	bh=f4NdWEY+yXT1iZ/NuIHYUXL5A2TEvmqkglAAhOE+sJE=;
	h=From:To:Cc:Subject:Date;
	b=LFjCFsriUbbYX40yCNmDcpgy5HPzqGbd72GD/X7E+M5lPVmAJzMoxzIjsscBDJgfO
	 7UtTtG5cFnE1ZuTWiOEVfPMV3g9K4OosOXcuW3gwk/ar9/lEbmZx0B09SR52xqz+Dk
	 hIsHuFnf7jtw69/U4iII090EIs5yw4ugYaMtx9yA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.262
Date: Thu, 30 Jul 2026 13:18:39 +0200
Message-ID: <2026073040-renderer-backfire-4996@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.262 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                       |    2 
 kernel/exit.c                  |    8 +
 kernel/signal.c                |   10 +-
 kernel/time/posix-cpu-timers.c |  185 ++++++++++++++++++++++++++---------------
 4 files changed, 138 insertions(+), 67 deletions(-)

Greg Kroah-Hartman (1):
      Linux 5.10.262

Thomas Gleixner (1):
      posix-cpu-timers: Prevent UAF caused by non-leader exec() race

