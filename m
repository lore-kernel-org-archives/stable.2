Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659F248B37E;
	Thu,  6 Aug 2026 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037568; cv=none; b=TOJx4nd0l6iY2xfXLauIa25Y8M5o4chcqsdVRhz7oQMUm+EcKtS/oo+KHj6CXrE/Oyvq9IVkAF6VuTf8ZDGFJ9zCQ61qMUzDTHxqRoB57sUXPZ/vyamTCb9wsYrOu8O4jiJy10nWug7HaDSmXL7oHnV1ztreesEI1R5v8+qKm1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037568; c=relaxed/simple;
	bh=z1HUJ4YZEy9iPa109jnDYxSbESNy+2mR2HqYHMTH/fU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vp0ncFU47+H0RX8jFClq7Ykepeot1GLEmjKymaHUUcaWPdwe7k/+vf5kDtDjyOMMNiRbMpDZBqzJFasp/0cPw2zaaCijKPmW6o+P3q75celI8lqQyEkg60BHnIHIwP1Wjqi9O5LNs1yOPGyphQAqEwM8zgzB5sPmXrZmCB5Zg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d2cLYZLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d2cLYZLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4FC1F000E9;
	Thu,  6 Aug 2026 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786037567;
	bh=JeBqkxovSe0lxkJ9lNOq2hfEajuIL2PlMbpST+geL+U=;
	h=From:To:Cc:Subject:Date;
	b=d2cLYZLMENuSTMvyryjIH52n9/7rjkLbtfDBeqZOodxmwLViyWjih4QGV3tG8Fsz3
	 gsgglFaEjhhzxdemII37TURh8L7ViCDge9SGiSuJLqpnjTlprcbMWKqC5o1f4af2vE
	 h4x/G8IqMLMwOvvLBqGhOgueqxKw3fR8S4cJMFEo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.43
Date: Thu,  6 Aug 2026 19:32:25 +0200
Message-ID: <2026080626-leverage-humbling-deef@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.43 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                             |    2 -
 arch/x86/entry/entry_64.S            |    8 ++++
 arch/x86/include/asm/nospec-branch.h |   57 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c           |   39 +++++++++++++++++++++++
 arch/x86/lib/retpoline.S             |   20 ++++++++++++
 5 files changed, 124 insertions(+), 2 deletions(-)

Borislav Petkov (AMD) (1):
      x86/bugs: Make Safe-RET robust against interrupt injection

Greg Kroah-Hartman (1):
      Linux 6.18.43

