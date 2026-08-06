Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8E48CD40;
	Thu,  6 Aug 2026 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037579; cv=none; b=lBHcSClg9zbwGJ3xSCO0SN3VSFgwhPXOC7T9z9KhYD4reBRsL/4OSqnLTYNx4tjlNp6QWtZSUjPCSddQVENO7OtELjuulBiMqEal48GuaXE1qwpdV+HJMnDdFwNMqJe2IUZbrrLPFnpA8npYo4Ox5QTQYa0aL2u6s3DLbGIBaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037579; c=relaxed/simple;
	bh=dAFeu77O8KiFIIgFlCWfo9apTb4ak3Yx6xyDF9rY+ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/iizCBBOM0pfAPoj967+rc6H0LL9PGNU7W1oE2wfdC3GGuyAbT0ubhariFITHJTRH+z0UHBb8bkMGWzLKV1Nw2A1Rvyqsb7ZcrIqhcCWj/HqfBur73oAn9UMUltIyyrKYgN62fwBhYfFoIc70dngkiZ3oXdG1WG/le5kWRdJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wQ/j4OlE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wQ/j4OlE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B079C1F000E9;
	Thu,  6 Aug 2026 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786037578;
	bh=3GGF1ZlE2N4GRKI8h+ZIFsTfoplSkO2PBzHNLDQfKLc=;
	h=From:To:Cc:Subject:Date;
	b=wQ/j4OlEZ0Hgyt5EHbOukvAEmkbVoz2b0ff530BjKMbmy8E+BIfnbhuwlnd+AGOhR
	 uUDkKp1gAGmkgKmucFjJf76nQ6oIAvzj+zt79f3Q8Si08/7Uboq8ANlDJuatXdruiM
	 bSQbUXiSn74wUaBGQ7Kj1V+ZOsHmEzUYccQS4/9I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.1.7
Date: Thu,  6 Aug 2026 19:32:33 +0200
Message-ID: <2026080634-nervy-batch-bdbe@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.1.7 kernel.

All users of the 7.1 kernel series must upgrade.

The updated 7.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.1.y
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
      Linux 7.1.7

