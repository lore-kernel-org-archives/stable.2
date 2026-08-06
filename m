Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE348AE0D;
	Thu,  6 Aug 2026 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037560; cv=none; b=F7sRFfx+JHK+xLwJePMoWGInFmHtgUM8ZJawDXsADaY900ZigdtQTH3yLCcM79g5NaS7AJcRJqmG3kjMLUPL0uxrlcEbMgaI6GioNpkSBhrejVdn1dfM7vvWJqHAop7FeTo5fSLN7dnCGeo7GX1sVO+KR6wXCuIEnO5QrJH0HyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037560; c=relaxed/simple;
	bh=T4mwuKFILlx37kuJ9t5If0b5vSXBqCecakgcIeyn4D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZIpDOUntMScu7Nuo5mp2MkXLRcfpFwA0mIgqOvevt2Zo/Pt5tb0w1ebvD4ejAED+6yCrTengtw2FNcbKopyzYJEh0dd14cX1kCDoD7rN/U5oIYFSII7KnJ1rWU8jJQulWkRFNfeQ7N2FauTUJL5/WY6PyCzFcLooFzmlNGgo7cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uun04To/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uun04To/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA9C1F000E9;
	Thu,  6 Aug 2026 17:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786037559;
	bh=jILN9ogL2+CeYH4ViBT0ThDrfZhBfBAff/50O8fJcrA=;
	h=From:To:Cc:Subject:Date;
	b=Uun04To/X7ie2sAn75CeQbqj+AR5JiesR8I1gejs4VWrfFS0vhz4jSfNPZTBPmGEo
	 /RlDOEUKkTLsIEhjzfaluKegCu5ZXkUHgXmeVKkAbfw7OmbXBgqqa1pohish+nYQRi
	 0j8pjPVSNfQ2CoJP/1qnCi34bOB0j5eyD4AvCErs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.149
Date: Thu,  6 Aug 2026 19:32:17 +0200
Message-ID: <2026080618-mulch-nullify-723f@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.149 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                             |    2 -
 arch/x86/entry/entry_64.S            |    8 ++++-
 arch/x86/include/asm/nospec-branch.h |   56 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c           |   39 ++++++++++++++++++++++++
 arch/x86/lib/retpoline.S             |   20 ++++++++++++
 5 files changed, 123 insertions(+), 2 deletions(-)

Borislav Petkov (AMD) (1):
      x86/bugs: Make Safe-RET robust against interrupt injection

Greg Kroah-Hartman (1):
      Linux 6.6.149

