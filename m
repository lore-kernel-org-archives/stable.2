Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DDC329C60
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581900; cv=none; b=j0wAiXUnT0paQXm6+wR1yTxoOrhcGraEuWYr+rhMEqLzutOIo/yXnAmqOyZEqUhbJ/BnbIwWuIFZkbX5jinC5SsmMXOMbKa8oD2CYJTbnkm/tmBd09NTRmb9eHYyxA5i01GmQNw8pW+exr48beNChujVYwOnE2r1HtVeKNzKAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581900; c=relaxed/simple;
	bh=wBPuf1t19yNaSNgxaMnPM8I4sf3kNA+ALxOofFb02Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ff/y0Hnaawf1HjLJHMVBVOviJTKn6TCx2ythpV4GzgntyMVlYZCwCNxMarvw6N+v5yyTlvFj85o6mgmn3carkjuroznytN6hpIAwBGR7tz4+XUWPmtnYvGQ2ThGJHlW6RvLS/Zx3PGqLF2lIzzO7T90mkjKAliqf2WhrMwpE07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0SjrU8GT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p+iDD+4V; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0SjrU8GT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p+iDD+4V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0SjrU8GT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p+iDD+4V";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0SjrU8GT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p+iDD+4V"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D23E75D4F;
	Thu,  9 Jul 2026 07:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783581897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WzGOb7tWbnjoVpSBBnx/JpfpjBqdBffhLBq4WBVADeA=;
	b=0SjrU8GTsBnZi7TXBIPNgEsn73F1FwaXMUkKCIjIh+8fc/fZhH3TnTKnfpBtbZCIthMsA5
	LwVKfnynmPZbrsF1oqIKcEbNL05n+aw2Vr/FfLYpzuyXWJ29UIhqasfg8L8E+Nx1djm4Io
	EblT5Q/uyPDUfkaSflfDKU+PPmHP9rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783581897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WzGOb7tWbnjoVpSBBnx/JpfpjBqdBffhLBq4WBVADeA=;
	b=p+iDD+4VtVbl+/EKCXQ90rjGwtzK4fFIdnY5fJ752h3pefnCNoU7+tSIByl9xvy7nCB+iG
	FmbTerkS4XJzQXCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783581897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WzGOb7tWbnjoVpSBBnx/JpfpjBqdBffhLBq4WBVADeA=;
	b=0SjrU8GTsBnZi7TXBIPNgEsn73F1FwaXMUkKCIjIh+8fc/fZhH3TnTKnfpBtbZCIthMsA5
	LwVKfnynmPZbrsF1oqIKcEbNL05n+aw2Vr/FfLYpzuyXWJ29UIhqasfg8L8E+Nx1djm4Io
	EblT5Q/uyPDUfkaSflfDKU+PPmHP9rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783581897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WzGOb7tWbnjoVpSBBnx/JpfpjBqdBffhLBq4WBVADeA=;
	b=p+iDD+4VtVbl+/EKCXQ90rjGwtzK4fFIdnY5fJ752h3pefnCNoU7+tSIByl9xvy7nCB+iG
	FmbTerkS4XJzQXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1483D779AA;
	Thu,  9 Jul 2026 07:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WI7+AclMT2rTRQAAD6G6ig
	(envelope-from <clopez@suse.de>); Thu, 09 Jul 2026 07:24:57 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: stable@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
Subject: [PATCH RESEND 6.18.y 0/3] KVM: x86: Backports for VM entry failure due to stale CR8 intercept
Date: Thu,  9 Jul 2026 09:22:44 +0200
Message-ID: <20260709072247.3305784-2-clopez@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -3.30

Backport for bb365a506b1e ("KVM: x86: Unconditionally recompute CR8
intercept on PPR update") with two prerequisite patches.

Resend: fix destination emails (did not properly send first version to
stable@)

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


base-commit: e46dc0adfe39724bcf52cea47b8f9c9aed86a394
-- 
2.51.0

