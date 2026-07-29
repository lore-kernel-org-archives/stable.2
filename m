Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484D411A14;
	Wed, 29 Jul 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341869; cv=none; b=kC+x24d8QqsyqRJbr5FlOKcjGHF6p3Q27eb826zhnzLY4i9tckLgnmf+jmMEb26Vf7wgK/K78OzhwDhWcWLf0tf6NRXq/c6kkwHLKHWRAOORdOD02Ok22g6RnMv3XOT65leNVGbpBNbM0fEJh9z1DJfPLtaIgxkOAG4IyqUvN3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341869; c=relaxed/simple;
	bh=CYCz1VyLY7i/k/FaMlaI1WnqApjH0G7CctWDlz1MxqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXHEHQYuJriRzRpG8lfxvWxJ5fp1wbfiIBe9k9+ITvvE23re+oG0+vr2Zp5xiHuzud8exIHz4g32yc+j9Pgn5kfVGaxrUYX86uA7CViyBaCuxCOkZUb0PKgBH+DMRtH06VLWyDIzyax9kAuLV0qJ5iGlp6xjhsbwLNqALYJ987Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zFyqtaMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zFyqtaMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59351F00A3E;
	Wed, 29 Jul 2026 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785341868;
	bh=CussL7jUaI1TeoIAQ+Zp9kRc1gdaZbWJLKhF4u8A9uc=;
	h=From:To:Cc:Subject:Date;
	b=zFyqtaMxykKa6e1LhuCc6SKtOgGrEWoRqzWCTa2g7hUFHRC802+PAKl2Tc8hpa4Jt
	 P0il+rCmw6NElEc84mXnWSU5X9Hijqcc8elXYOI8Ls0MnPDHeQyxYNVSaOdeiEkUBs
	 s9fcymJma5lDl2vzmDuIjdDSKeI0zdXAnedk5TiQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.99
Date: Wed, 29 Jul 2026 18:17:30 +0200
Message-ID: <2026072931-buddhist-lethargy-769b@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.99 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
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
      Linux 6.12.99

Lorenzo Stoakes (1):
      mm: refactor mm_access() to not return NULL

