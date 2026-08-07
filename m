Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013844E672;
	Fri,  7 Aug 2026 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083622; cv=none; b=JzynTS/4IPVU6XFMlvtOckDseo9kExm4q8aP+DZk3F0p9jBNoFSEUJhlLv3702SUYzIvH1glk/NmqeOxRuIoNqm3eocpBjb2Y3SNmmkguiLAEUFzmnTa+xQHTRQ5OwhC9AoEHQGpJ6pE7uvaHxvcL9qlLGYUfFEP9zIfJkFLfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083622; c=relaxed/simple;
	bh=RYXNjunXOtuNi0UmOG1wmrH99Rw/2najcjD1VMyVkPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/QXwnlhSeAGnIvmH3pZcdOGnlcDqcMV9FRIPqvh5DSb9m/wYnUDJl05W6QY/jnxLtnGDBz0xnb4ziAMEYZkw3mIkfefLJsWwR3Ur4TZeYRqsj2J/c78/YWb2RvkhtGwlmmN955esBt1oUaZf52rHFETITqs42JuMsK9KOY6oQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZgDa+Jyg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZgDa+Jyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136FF1F000E9;
	Fri,  7 Aug 2026 06:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786083620;
	bh=Zd7hrqVsLAbKyUg+espsh5EYWWQUhwZxTqWkmr+5B7Q=;
	h=From:To:Cc:Subject:Date;
	b=ZgDa+Jygx1xMVpI5UySy4U+p9zdwrhAEktiaS5LyQySBRldSDZqYlclP5WnzyVGBd
	 p+Ct94RsQ/mMbNlghcd9qEQfE6c8LcgRZAMeV2NOdKggyGZZlFZKEmG0lH3wIxICXP
	 j1Xliguo9SkIPEm3DDdkR4HvPnYl487pIufoN8GE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.102
Date: Fri,  7 Aug 2026 08:19:54 +0200
Message-ID: <2026080754-sway-blurt-3855@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.102 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                             |    2 -
 arch/x86/entry/entry_64.S            |    8 ++++
 arch/x86/include/asm/nospec-branch.h |   59 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c           |   39 +++++++++++++++++++++++
 arch/x86/lib/retpoline.S             |   20 +++++++++++
 5 files changed, 126 insertions(+), 2 deletions(-)

Borislav Petkov (AMD) (1):
      x86/bugs: Make Safe-RET robust against interrupt injection

Greg Kroah-Hartman (1):
      Linux 6.12.102

