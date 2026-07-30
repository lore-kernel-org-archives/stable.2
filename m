Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED48417368;
	Thu, 30 Jul 2026 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410376; cv=none; b=S7oHenMoQiVU++SrnMnLP1ynVQK+qb8JMNgk6IiEZFhlGSWw8ih4uyupY6fU7ZbymcIS5I0DTTRBxkOelZIqTzZjPPpu5vnH7IYmw+gGCBB6QfTLaz/FGSrkSUv6KGY8oYDtLhHkIz17w+H3qe/MTXP1/XmgdGc6NBAe336jeAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410376; c=relaxed/simple;
	bh=0avSNdj1BIqvx6iJ1nLiS6OHYN1olSDo7zx9wjZJP0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpjTEn+5HyCiapUX7tWPbAiVULmyHI5xuljrFG4/9DKFSlCvRbJ7SdhBwWhkp7ADhl81Ybe3xjIYHMWw0wvM67lWyAUgn0D2DOssKJG1iQ/hP7ZpwDFNkcAnr3gOWJ2Nn7uWYKBqr54Eu5dYDgVaGO37nBaOnkzioxLmyJFea3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVY7uanV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVY7uanV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E831F000E9;
	Thu, 30 Jul 2026 11:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785410374;
	bh=xRNvUV8EJ8y21TDuXnLKvgD4qi7VPfTdkUjUFePabq4=;
	h=From:To:Cc:Subject:Date;
	b=NVY7uanVDnGt8yaksA7R0A66kL+Jvx7BFhmmgkF+vEh+YHry2dRjZFbn8quniT/Sl
	 vxWwgj318H1ga/Fqo2D+i1y8YgjBxTGHQ0mxDtTD3MmKsk6wqpiriEJi+lplwOFvzU
	 S1l5GucAExf3KRdgEPtA/llohAKVM7Z+ksmw8WDw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.147
Date: Thu, 30 Jul 2026 13:19:16 +0200
Message-ID: <2026073017-ninth-perfectly-ea28@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.147 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
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
      Linux 6.6.147

Thomas Gleixner (1):
      posix-cpu-timers: Prevent UAF caused by non-leader exec() race

