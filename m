Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA964499A1;
	Fri,  7 Aug 2026 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083600; cv=none; b=Afa11n1LtgoXOIm0mI9iGgZUOytJihB0qIKXSPKNsKic5DKOqVLAC6gST6MsfMuTRdfuQpdqwH63eq+1EljU5iD24rfpAcUNbt8UKDewm+YI+tNkiEXUxPFx8wOlyTSWWcwDslzRQhxbFG+iSYhO5R9i/hVX1QSQLPHQ1YYlJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083600; c=relaxed/simple;
	bh=1sJxEbhCK6yJm72K5DL75yfmaXx8y8Sg9Ft7ksw5CgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PP2iQPInkynCw55ywODOaFPGAMWwtJpYtctNyJozk21FqGmTmzv6JN3vkuCSCd1fKEHK/FnTsSrY7ogn/Up/hvd1+Zn/i/JZY2+A/f9GtTq/3OfQ8DT1bVg2rriOyXZf0vxT+XEi0Hh070xURvCsmTZGhOh88ymnu0W6jliI6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GP/q8y62; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GP/q8y62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BCB1F000E9;
	Fri,  7 Aug 2026 06:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786083598;
	bh=ksqp90LGcX1N64dA4u2ZM7UEXJpRhwxNU8jYFKt+/Ng=;
	h=From:To:Cc:Subject:Date;
	b=GP/q8y62QOrK5uaXrue+MQ1eQtVtZt83a6XH7YAqcbT7itr9UYeRUj2yu+NsTPsCP
	 3fAonsmor6gpGDrkF9vxTxEGErJrVkhBFtprZt5ynlr1BSu5epKaCK3u2K8YzM3ecS
	 aLasLKpiR8rzmqkqxDBYTihZLGAL43oZjgSDO2v8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.215
Date: Fri,  7 Aug 2026 08:19:36 +0200
Message-ID: <2026080737-driver-overreact-28ff@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.215 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
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
      Linux 5.15.215

