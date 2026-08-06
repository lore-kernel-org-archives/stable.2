Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3808488D83;
	Thu,  6 Aug 2026 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037553; cv=none; b=ALLSREijTP9HBuQx4cXQs7ZLHceHR7Kj4HB7e+xq6S1hz5vkD74pM+HHynxDm66xWBqdpyMTLg66yZjVyDl/AvWT2yD1JJ4DCJ7Gmc7cHWzNfkTXjfkyuClcSGx0nrbm3ws0VbieVR1B44gNf6fI9S/5YwrigpxmTTzwce3XD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037553; c=relaxed/simple;
	bh=ECTZ3A1komgd6/Pj92N3kRhV2eFqAQQVtO60ia/C7IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfsuKNWxpMgXVIG0UorTNCuoJd0er9fV67rnkCJEiXbskq+Ph1Ea8cIVb03lPZ9thKiaep+qRtH2bCuCOA5lqvlsCoQC3Bte97XrzHveAKnjQdxjhV2oYr9+O4mHG3rw7kB9JkkAMudr1zLMSEGUPqYUNnyx0Dfo1Z92VEcWoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AY1NkxWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AY1NkxWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07031F000E9;
	Thu,  6 Aug 2026 17:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786037552;
	bh=7p1uOlrx6pbiStRnbQakNEjFQvwgXmznFcFiYlh37+Y=;
	h=From:To:Cc:Subject:Date;
	b=AY1NkxWOp97EHpWb6YlHhezgGdYyk/b3A4CJKi+vPoId6s/9zJsEbN1eGKZUGrtmb
	 lfIyEBGqp/aKh65A2+fbeKcuhQrQ+VnZBTD3DrC+Xc+uLWpxmU31v2iqqpe7nHgRAO
	 C2MApb4Ib+EtgdHTZyCehHiqR5Z00jwfYY5tTSdU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.181
Date: Thu,  6 Aug 2026 19:32:10 +0200
Message-ID: <2026080611-conceal-wind-93c0@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.181 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
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
      Linux 6.1.181

