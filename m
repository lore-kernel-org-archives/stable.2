Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5C48662E;
	Thu,  6 Aug 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037547; cv=none; b=eJE4FS6bnR1KqSl/n8rHAHpm20fJY5/mhshAWmxpdqiR5f2Epex0JY3CYTWZrfwRjDQKrdr5UHwHTG1U5ZlwPRprZ0XfIe8vJQ9r9mJSUzIOdp0ihYcWCyOoFFmQ/9DnDqyrl8sdHRmwOq1MMOcVFqDwdEIEjYnRE/ojOyMNQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037547; c=relaxed/simple;
	bh=Mt6VyDoNVC+ErY2lOJR6k+pwr3Ep7V8kOFyurW3XTdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKaNYmX8Zye45nUGxl3LsiBBSlwmjzi1CToTvHJ7Fd3g1XzqldGuAYrDziTnylzwgkbC+A7Vm0SdkzZJa8596SQnZtc/sMx9fyOBfq/FXe8eLZB3brgyG0ASwCEdob/waJBYqqB1J5OMPLEGe4Yc498BJSmvvDK83YokGIYOv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ioprrkAa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ioprrkAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869291F000E9;
	Thu,  6 Aug 2026 17:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786037546;
	bh=p7kKRKQtcE/h48ogG8SRvRGsW8+emD7G+MseIheTJvA=;
	h=From:To:Cc:Subject:Date;
	b=ioprrkAaa1I58ul7CioVsXWFHFStpkcF7U/B/m0XGCRG5JfQ1VoK5dkDwKFxGp6xE
	 gm2bi4F1Ymom0wA1WL/M7g16aPHLyxFA0iLHED+b+G1DPS7qTZxDg6Q21mbNZ5BGuc
	 niiv8+OgnN9dd+FtjY06OY97a9bKxV/tn5jJ5Y/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.214
Date: Thu,  6 Aug 2026 19:32:04 +0200
Message-ID: <2026080605-mullets-fetch-9e49@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.214 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
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
      Linux 5.15.214

