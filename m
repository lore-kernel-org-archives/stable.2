Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4CB40A940;
	Fri,  7 Aug 2026 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083591; cv=none; b=beb/1SPuxsVbwPoWYrwuAtAZFWIu4a2vnZMvnPM8S+cXJuehGMLa7k7v2PS8JSFgjoYybr5QiUve5nuoAiB7RxA2Ic2laVSKDFgaH54NKwk8HgI28J8A4Lp+6t+FPE1z6g0oKchpMf66guPHi91AaKgRH8Fcj8xtsHQU3xYtge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083591; c=relaxed/simple;
	bh=K0h0jGUsdiqnUzJO6GrxQZ93esVAMbEq1uquRq7lPsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RD8c+l23O6U/ODVBGUugar74nbl1tC+pwUHqPNapNCHL/dQqWBkZWeInrQB5Sf4xLein3rkCB+jANw0nAlajhbrSXbGYlGu6reLE7TwnjGzsQlpqzyjhLbGA6eciCZrMNdFs+akQZ+S6kxMQLXad0t4eUaeeo4kGGg0G43G5ymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aEVKz2da; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aEVKz2da"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABB71F00A3A;
	Fri,  7 Aug 2026 06:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786083590;
	bh=cKzmu91O/Iaw/CYx6FjnoXcFZQMkFBvt2p+6RDRiClc=;
	h=From:To:Cc:Subject:Date;
	b=aEVKz2dar03oCwvVNIPm/+KRjgtyS95Xb9Tdr8JtUzqZBPTu8eHLgHixmk9407Vah
	 Oe9Fgk8sFuPxA10AqXERM51fN8WnbbJGrLn9MW8cU49WvUmq3ilkphf1XsHzFiezJZ
	 RNWqqLcL7irnG06cC0/seiU4+R23mcaAnj4GvEZY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.264
Date: Fri,  7 Aug 2026 08:19:30 +0200
Message-ID: <2026080731-puma-cautious-ef1e@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.264 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                             |    2 -
 arch/x86/include/asm/nospec-branch.h |   61 +++++------------------------------
 arch/x86/kernel/cpu/bugs.c           |    8 ++--
 arch/x86/lib/retpoline.S             |   61 ++++++++++++++++++++++++++++++++++-
 4 files changed, 74 insertions(+), 58 deletions(-)

Borislav Petkov (AMD) (1):
      x86/bugs: Make Safe-RET robust against interrupt injection

Greg Kroah-Hartman (2):
      Revert "x86/bugs: Make Safe-RET robust against interrupt injection"
      Linux 5.10.264

