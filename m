Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14273B05BD;
	Wed, 29 Jul 2026 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341855; cv=none; b=Romf8Rg9BdQBVNruVR4VDL3gCWm6Wr7Wqyic2lT+wwa4cYVzgbGnfN/IImVh5+PjyER/PkRW8DO9KKV8dgeCKCnSmN8b0hrqFSJYVaiOLljDCzNmLm8cwj/5xvenc5JrVBQIViTxI6/9pABr+zQu7Ou1ixbb5nKEb9ysdnRXGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341855; c=relaxed/simple;
	bh=KraBC3KWGHgyUGjQ8RRUtgQCLR/lVB6FspOF4sfQ6RU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hrgkerdiztw+RzLzn8DvkFp3TbhrO91bDKOpc5xZaGUoXmXfSQgchB6YMG9Vbh8j9hTuq635Wozx6ZINp/T0K6a5riMzAIF51+2i7gZ70ASneEh6vCkBHZe01Zfnx1rJakKMbAcKLvq/kKZtmqaVbXpLMpYcvAiDJkMPXPFmCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oS1QXnp2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oS1QXnp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C561F00A3A;
	Wed, 29 Jul 2026 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785341853;
	bh=QdmZdJw4N++zMt90F+PtdWN4X5lZoR4oDCEelCOhd94=;
	h=From:To:Cc:Subject:Date;
	b=oS1QXnp2VwUln/NDwmAiapEJb0kFO7mwc1dcmP2IZu6uCdOsDS8WxTlG3xn4XPM6G
	 LAfttyWkm5dqBszC0ZoCbnu3Kz1PXPJT6Fio6gGQFxH+FVQuP7wMio02AnqxpXAYmY
	 BR3RhiNKgv4tFeBTJnJVkOuhPXEt/APz2w6Iy55w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.179
Date: Wed, 29 Jul 2026 18:17:18 +0200
Message-ID: <2026072919-yin-grudging-7b3e@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.179 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile               |    2 +-
 fs/proc/base.c         |   26 ++++++++++++++------------
 kernel/fork.c          |    5 +++--
 mm/madvise.c           |    4 ++--
 mm/process_vm_access.c |    4 ++--
 5 files changed, 22 insertions(+), 19 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.1.179

Lorenzo Stoakes (1):
      mm: refactor mm_access() to not return NULL

