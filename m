Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572002;
	b=5JyxmXGEMwU797QmZJb09cTM040AiXUOrcY2yrJhsDhgxHUfzlNUWfIUztxaKuOW9BbF
	 B7LKRO7IcnMHT+OXLosczbqJsz2BhKRzD+cO+qWpRPrxtEyPYW3pLE//GvW5jSQfjzJgw
	 ms7NxGybwVxp8oWnlYVGhxyXNetSSbHZacks0TXfV8KpXf8Sw7ptayfKkqmC+PrcU8HEE
	 iaIfGcub+8CRw8z94IUncmnzndQX1A0HL9L8OEinF+bjZLTyk94iYfxp6Oaq1rtAgu0Rm
	 J8Aix2+atDI23ZIggfbVL0+nlnaT5vnWWKCYmIIFnn6BjFEzgov64gL7Uswv57x+zXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572002;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=31/QKicgFPX9q/1cWDp5YzIFHM4bIchknis2TBs9D60=;
	b=1mTsLZw+oP1SpJdRD3PAkaKi/fxJyPTqO8FiMCGqRikqzYDD5bWHw17vuplAlA2vzyvF
	 z4LRLLVdshQ9IPKYcdDiuYry44RyviPeW5WlEYeqnKcAqJZASnu5cOgQOjrs5E1HNDzLS
	 WRBINl7FCcX6wEKvEEXodGtkoELvdQ638WpIyAkYgwUQfwKsx03RtS3jODkZNuN4CunES
	 OHJsaFqBZnhnyjHUkeRQg5/VxmwoD0PVpdCLzlejYImY3MdVY5q1vXPhYzSl5SBnlBoVB
	 H0aKGiRU+UDo9gViUzMAB+JprZhYiQaESikEq//4G1OlguH2WhF+iL7Cn/igVCsM9Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=x7VDIQG7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63660A263A;
	Wed, 21 Oct 2026 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=x7VDIQG7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52431F000CF;
	Wed, 21 Oct 2026 08:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792572001;
	bh=31/QKicgFPX9q/1cWDp5YzIFHM4bIchknis2TBs9D60=;
	h=From:To:Cc:Subject:Date;
	b=x7VDIQG79d355wKxK117eEW0wb8Vm28mBp67wXAufWqLPy9QeQOcpPPKtjMWvG2ne
	 exrurejYigJoK0r41PvUUnlOuB4U3Aql2fr9pmSunr83FzmY/zbVmhopMoOIx0Gm1C
	 DtBDVcvwj5mlQpJ1Ve7bk3PuNkjwxhxax2mPoCw8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.2.12
Date: Wed, 21 Oct 2026 10:38:26 +0200
Message-ID: <2026102127-ambulance-outplayed-835a@gregkh>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.2.12 kernel.

All users of the 7.2 kernel series must upgrade.

The updated 7.2.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.2.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                           |    2 
 arch/x86/kvm/x86.h                                 |    4 -
 drivers/md/dm-integrity.c                          |   55 +++++++++++++++
 drivers/net/ethernet/microsoft/mana/mana_bpf.c     |    8 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   60 ++++++++++++----
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   75 ++++++++++++---------
 drivers/net/wireless/ath/ath9k/wmi.c               |   16 ----
 drivers/net/wireless/ath/ath9k/wmi.h               |    1 
 fs/nfsd/nfs4proc.c                                 |    2 
 fs/nullfs.c                                        |   30 ++++++++
 fs/readdir.c                                       |   13 ++-
 fs/smb/server/smb2pdu.c                            |    2 
 include/linux/fs.h                                 |    2 
 include/net/mana/mana.h                            |   14 +++
 include/sound/cs35l56.h                            |    1 
 kernel/sched/ext/ext.c                             |   29 +++++++-
 kernel/sched/sched.h                               |    5 -
 sound/soc/codecs/cs35l56-sdw.c                     |    9 +-
 sound/soc/codecs/cs35l56.c                         |   54 +++++++++++++++
 19 files changed, 304 insertions(+), 78 deletions(-)

Christian Brauner (2):
      nullfs: refuse file locks
      readdir: take no inode lock on an immutable directory

Dipayaan Roy (1):
      net: mana: refactor mana_get_strings() and mana_get_sset_count() to use switch

Greg Kroah-Hartman (1):
      Linux 7.2.12

Hamza Mahfooz (1):
      net: mana: reserve RX buffer headroom to fix forwarding performance

Ilan Dudnik (1):
      ksmbd: fix heap out-of-bounds write in krb5_authenticate()

Jinu Kim (1):
      KVM: x86: Use active memslots for the per-vCPU MMIO cache

Lubos Rendek (1):
      nfsd: fix all-zero stateid in CB_OFFLOAD for async COPY

Mikulas Patocka (2):
      dm-integrity: fix NULL pointer dereference when the 'R' flag is used
      dm-integrity: validate the superblock on resume

Richard Fitzgerald (1):
      ASoC: cs35l56: Add DAI for SDCA OT25 stream

Tejun Heo (1):
      sched_ext: Fix CPU hotplug hang when a dying CPU's tasks sit in the BPF scheduler

Toke Høiland-Jørgensen (1):
      wifi: atk9k: Revert "wifi: ath9k: reject short WMI command responses"

