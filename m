Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721890;
	b=e6R2VsvpndlwWoDotAvv1HANO8ujpA9b+3UnUeSFY0tyu3eWjmBi7rfe4WY4lV/Tg322
	 n3sj2orSya6cpUL7qFfDnzC5xymPrHtJ35Z0CN5IzU3XjWQ5QcAzWCTtWbQLKyk8yukE1
	 qCoaqfhp7Ll/I2cZYaK9Fmvf8icaiAnrQbWT+m8l64UTNfySJ9g9bTZnDnfm/2Jyocvlv
	 aMTjrzEmzcCsokr/DZtG+PFpicNKYCZMp5HKkdznORM+seGzccMOmCjW+wV4fDFCbe3tI
	 5xBTp6T5g+sVUOSg5FtBPeHVgbv/lox7wN7OFyDXDose+E1pfHgP0IBWS1NMN8weWaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721890;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Organization:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=oVGUgjjgmlBvU8YntDEymYcNZsWZdS15hRLGR6BGcjE=;
	b=DQtDzAc1psgKaJX3d1DnkNxf4+fSQwWg+SSiIRd6F06Thx+HNKl0ZTkxqcah3VgiN0H9
	 y2YUdynveLLW2HWvTF0MYYTxjlHFf6UbrLSoVVxPxKEMM1wt6/4Z0QuTTQNGlscy9E0Te
	 LEmtOeRtRjlhCm/WTXr0HzEum4fHCfbShuSL0YcBfylYR8giyUz3bDG629Pe39Gl9J/YS
	 R/58L8YDYff/WBDAXLYC2ch7WEqH4KkwDrVOgHAgkJA7WuCfhexBkJ1xly440hdjuJrfb
	 AYri9vNoiAebkHDGS6RwiwB+pKvxLeAHMvTbo3rWDqaYAQcOPLQs/0ayiMv6/zXBWQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=p5N9FDD6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IUEXKCCH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=p5N9FDD6;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IUEXKCCH;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A983606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A983606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=p5N9FDD6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IUEXKCCH;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=p5N9FDD6;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IUEXKCCH
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 525D61F7B6;
	Tue,  3 Nov 2026 16:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793721888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oVGUgjjgmlBvU8YntDEymYcNZsWZdS15hRLGR6BGcjE=;
	b=p5N9FDD6gZFdN3mhkxxllPNHBOonGC/vVik6103sQvBf0g4bcfGAYefpkHXgw7GoKCOTFD
	m7g5dibSmh+f7iwO1P7gP3plxu1N8KlJYGUhlWItHUD5bNa1sOWUdo3JtIw9c92pvfuWv1
	iEXD3rA8Sz7ZCBgolOaa6xUYBU1kwe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793721888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oVGUgjjgmlBvU8YntDEymYcNZsWZdS15hRLGR6BGcjE=;
	b=IUEXKCCHHGjnewG0YKidIH8gHxjWVeii76pedPPhWAsl34YWqQ171ITwfrku1QKco+avH5
	xOZCRU+C/QhXZwCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793721888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oVGUgjjgmlBvU8YntDEymYcNZsWZdS15hRLGR6BGcjE=;
	b=p5N9FDD6gZFdN3mhkxxllPNHBOonGC/vVik6103sQvBf0g4bcfGAYefpkHXgw7GoKCOTFD
	m7g5dibSmh+f7iwO1P7gP3plxu1N8KlJYGUhlWItHUD5bNa1sOWUdo3JtIw9c92pvfuWv1
	iEXD3rA8Sz7ZCBgolOaa6xUYBU1kwe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793721888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oVGUgjjgmlBvU8YntDEymYcNZsWZdS15hRLGR6BGcjE=;
	b=IUEXKCCHHGjnewG0YKidIH8gHxjWVeii76pedPPhWAsl34YWqQ171ITwfrku1QKco+avH5
	xOZCRU+C/QhXZwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04455134B8;
	Tue,  3 Nov 2026 16:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G15fMR8G6mplZgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 03 Nov 2026 16:04:47 +0000
Date: Tue, 3 Nov 2026 17:04:39 +0100
From: Jean Delvare <jdelvare@suse.de>
To: stable@vger.kernel.org
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo
 <qiuxu.zhuo@intel.com>
Subject: [PATCH stable] EDAC/mc: Really fix error path ordering in
 edac_mc_alloc()
Message-ID: <20261103170439.2f918d14@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.50; x86_64-suse-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

The backport of 51520e03e70d ("EDAC/mc: Fix error path ordering in
edac_mc_alloc()") to stable kernel branches is incomplete due to a
different memory allocation scheme. In v6.19 and earlier, the device
initialization must be moved further up so that all jumps to the
error label are covered.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: stable@kernel.org # v6.19-
---
I believe that CVE-2026-31689 is not properly fixed in kernels v6.19 and
older as of today, and the patch below shall address that. Affected
branches still under maintenance would be v6.18, v6.12, v6.6 and v6.1.
v6.19 is equally affected but no longer maintained.

I wrote to Borislav earlier about this but I'm unsure if my message
reached him as I did not hear back. So I'm sending it to the stable
kernel list this time.

 drivers/edac/edac_mc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-6.18.orig/drivers/edac/edac_mc.c
+++ linux-6.18/drivers/edac/edac_mc.c
@@ -366,13 +366,13 @@ struct mem_ctl_info *edac_mc_alloc(unsig
 	if (!mci)
 		return NULL;
 
+	mci->dev.release = mci_release;
+	device_initialize(&mci->dev);
+
 	mci->layers = kcalloc(n_layers, sizeof(struct edac_mc_layer), GFP_KERNEL);
 	if (!mci->layers)
 		goto error;
 
-	mci->dev.release = mci_release;
-	device_initialize(&mci->dev);
-
 	mci->pvt_info = kzalloc(sz_pvt, GFP_KERNEL);
 	if (!mci->pvt_info)
 		goto error;


-- 
Jean Delvare
SUSE L3 Support
