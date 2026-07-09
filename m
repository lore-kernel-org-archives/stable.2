Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E47296BCC
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603737; cv=none; b=P4JHU/B3w5nDSzx3bHtR4kAzlEQ650M098je4ccSVgsSuhARA2xSxho/cdAc98Fbf5cjaPvXuzqfoLv3MdRnOTeUI3jcWsbzVaKTL8AT3/E1ojFvVjEAtgAUJBeVvl0DOiZZ7Fd/SFufVIMVC5TTd/2w4XQ5zbu11rieSZBZrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603737; c=relaxed/simple;
	bh=/zYeT0KdD3zKJAfr9LeThMHhDSmbPOHMEgQBTCGOzTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EmrFCPaXihp3oMtaf9D56XUqhJnxUB3zz9K1XDKfrCMi9hJ1KUBes2AfqwdhK+9Sw+/ySm13GqMGC8oI7U57iJM38aAX3rW2RM8be4I7j0lbxO+pu0jag42d04MWcSu3WQB4aBI+JRZrT9WzgJ2hrrrTWPPwu+jKtdWvKjM6Tpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e2jFa6Az; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QkLnFrLI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e2jFa6Az; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QkLnFrLI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e2jFa6Az";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QkLnFrLI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e2jFa6Az";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QkLnFrLI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CEE874E08;
	Thu,  9 Jul 2026 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783603734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uy1/x5hxq476QX+TCjtaIN6O479+bX6YVH8RpGgjd6s=;
	b=e2jFa6AzfcJbLg7saWj28aDHQc7MnlG+RHPrWPsb/0WvMtyHDTU76V52BVS607ESKrp7QR
	5Lw7B8R0SErY2OcnzAqi5odDDN5JF0yQ7Qfh6lQgRYIrhvnRYwddN/sOaqfaFMadBYZ962
	rac0CyujV7A0VTOS/Q0WvC9hvldOLIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783603734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uy1/x5hxq476QX+TCjtaIN6O479+bX6YVH8RpGgjd6s=;
	b=QkLnFrLIl8qIZ1NA0B5BC/raEhnxX+KNFukEqMUMzJhsGo6Nfumclc7IFv1HSbHP6Y2B1g
	wuFVTgefrkcVCvCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783603734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uy1/x5hxq476QX+TCjtaIN6O479+bX6YVH8RpGgjd6s=;
	b=e2jFa6AzfcJbLg7saWj28aDHQc7MnlG+RHPrWPsb/0WvMtyHDTU76V52BVS607ESKrp7QR
	5Lw7B8R0SErY2OcnzAqi5odDDN5JF0yQ7Qfh6lQgRYIrhvnRYwddN/sOaqfaFMadBYZ962
	rac0CyujV7A0VTOS/Q0WvC9hvldOLIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783603734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uy1/x5hxq476QX+TCjtaIN6O479+bX6YVH8RpGgjd6s=;
	b=QkLnFrLIl8qIZ1NA0B5BC/raEhnxX+KNFukEqMUMzJhsGo6Nfumclc7IFv1HSbHP6Y2B1g
	wuFVTgefrkcVCvCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B20C2779AA;
	Thu,  9 Jul 2026 13:28:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ybTNKBWiT2qaMQAAD6G6ig
	(envelope-from <clopez@suse.de>); Thu, 09 Jul 2026 13:28:53 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: stable@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
Subject: [PATCH 7.1.y 0/3] KVM: x86: Backports for VM entry failure due to stale CR8 intercept
Date: Thu,  9 Jul 2026 15:21:06 +0200
Message-ID: <20260709132109.3423488-2-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.30

Backport for bb365a506b1e ("KVM: x86: Unconditionally recompute CR8
intercept on PPR update") with two prerequisite patches.

Carlos López (1):
  KVM: x86: Unconditionally recompute CR8 intercept on PPR update

Sean Christopherson (2):
  KVM: x86: Move update_cr8_intercept() to lapic.c
  KVM: VMX: Grab vmcs12 on CR8 interception update iff vCPU is in guest
    mode

 arch/x86/kvm/lapic.c   | 28 ++++++++++++++++++++++++++++
 arch/x86/kvm/lapic.h   |  1 +
 arch/x86/kvm/vmx/vmx.c |  3 +--
 arch/x86/kvm/x86.c     | 35 ++---------------------------------
 4 files changed, 32 insertions(+), 35 deletions(-)


base-commit: 199c9959d3a9b53f346c221757fc7ac507fbac50
-- 
2.51.0

