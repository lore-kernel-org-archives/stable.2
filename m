Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACDB32B108;
	Mon, 12 Oct 2026 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790784; cv=none; b=UjNbuHBA7YBsYsJ3B2S0G4lDfNk7J63SBUyHq1gzht1ZC4I3r/0iqMy+UpekCFou8tm/fJhG+gefpS/XvmfpujcRu5jLxTXLsMjoTgGzVpNVybYMSF+t4yRzVdoSNipWUhAA9Nb+Ox+F1zS+l2VhWTDFFPiPkOVm43FTzerXd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790784; c=relaxed/simple;
	bh=GS44J3Aku38fi/SvJDBKrLt4DpMDeYkkRQQtw8dOoH8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvts9sQr/jI47Bc1+8AIhRQqMYFXyZMWmVFzxplD1uLCVDnZvO0vZyXNrRTwBN4irwvPP/uaTWoHD3utCXQ5OW+pvkmGfIjZ5+0u9i3kw/UaztDFwXp44gHSrm0vhfeO5/vXyDkel6ca00cOPmQ/E2chctuFjuOQ++Y9rKir+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tCxs5+JG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fekTLrNX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A0Vq279U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+UtW00LZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tCxs5+JG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fekTLrNX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A0Vq279U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+UtW00LZ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BABE821E00;
	Mon, 12 Oct 2026 07:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791790781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBXoYOmOrPyFfDwIreNIPu+rJ4JmjlF9Jmt0Cg7dZH4=;
	b=tCxs5+JGWGPWGkIZgLNZs++ppp2jghZ++KXMe6GJluNEQLsfPc1wJi7icxyNSeMVBr8ET8
	HNFSKGx44ptLet3TVUgsvD98bPO9aquO2Qw0CmoFSPbIkHtmOaw53G5uEiaHz85SPG1BTQ
	PVk9zVktJ74gWSIyNdfGNcSHYjItQGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791790781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBXoYOmOrPyFfDwIreNIPu+rJ4JmjlF9Jmt0Cg7dZH4=;
	b=fekTLrNXCe9h+KBMXhMzK3zGSNrB/ATPy2u9Wf6/OqwqR2plPHo+sFpfVwfB/bZV8J6nvW
	4/FT+HjmetrP9FBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791790779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBXoYOmOrPyFfDwIreNIPu+rJ4JmjlF9Jmt0Cg7dZH4=;
	b=A0Vq279U90YBAVh+oZ/j919ax9tSuWd/B/jI+ZIzeMNhhlgNpxOudWS79ql7MmneuY1gKq
	su6EaAoHeJKFozHfUTJ3T8sCIiMWLseKfGI0dd88382330jwtPTKiBXeKPVnSxFhS0DrG/
	sfEnMOkRDMfQ6yfIMfILhZjyncsXFwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791790779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBXoYOmOrPyFfDwIreNIPu+rJ4JmjlF9Jmt0Cg7dZH4=;
	b=+UtW00LZi1iSz8qvWCswFAfi9CsxsrGpDPM/UwImDk7CB2fhXi/ym+3pb2zwQGvdqxlui5
	Zpg18qq4yobR05DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EE7613314;
	Mon, 12 Oct 2026 07:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U+M/B7uOzGrLbQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 12 Oct 2026 07:39:39 +0000
Date: Mon, 12 Oct 2026 09:39:38 +0200
Message-ID: <87y0c3gyf9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ma Ke <make_ruc2021@163.com>
Cc: david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure
In-Reply-To: <20261011114251.3257172-1-make_ruc2021@163.com>
References: <20261011114251.3257172-1-make_ruc2021@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO

On Sun, 11 Oct 2026 13:42:51 +0200,
Ma Ke wrote:
> 
> cs35l41_hda_probe() takes an acpi_device through
> cs35l41_hda_read_acpi() and stores it in cs35l41->dacpi. It is
> released in the err: label, which
> is reached from every later failure.
> 
> One failure is not routed there:
> 
>         ret = cs35l41_hda_read_acpi(cs35l41, device_name, id);
>         if (ret)
>                 return dev_err_probe(cs35l41->dev, ret, "...");
> 
> cs35l41->acpi_subsystem_id is allocated inside cs35l41_hda_read_acpi()
> before that point, so it is leaked whenever the function fails.
> 
> Route the failure through a new err_acpi label that releases it.
> 
> That label must not release cs35l41->dacpi a second time.  Every
> failure path in cs35l41_hda_read_acpi() that can be taken after the
> assignment already drops that reference: cs35l41_hda_parse_acpi() does
> so in its own err: label, and the !physdev path does it directly.
> Clear cs35l41->dacpi wherever it is dropped, so the pointer never
> outlives the reference and the put in err_acpi is a no-op on those
> paths.
> 
> Found by code review.
> 
> Fixes: 447106e92a0c ("ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

Now Sashiko complains other things; please verify whether they are
valid or not.

Through those developments, I'm thinking whether it'd be cleaner
rather to move the unref and kfree into the caller side, i.e. doing it
only in cs35l41_hda_probe() error path (but conditionally), instead,
so something like below.


thanks,

Takashi

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index 62296be45c55..e6f0ae39876d 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1907,7 +1907,6 @@ int cs35l41_hda_parse_acpi(struct cs35l41_hda *cs35l41, struct device *physdev,
 	hw_cfg->valid = false;
 	hw_cfg->gpio1.valid = false;
 	hw_cfg->gpio2.valid = false;
-	acpi_dev_put(cs35l41->dacpi);
 
 	return ret;
 }
@@ -1928,10 +1927,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	cs35l41->dacpi = adev;
 	struct device *physdev __free(put_device) =
 		get_device(acpi_get_first_physical_node(adev));
-	if (!physdev) {
-		acpi_dev_put(adev);
+	if (!physdev)
 		return -ENODEV;
-	}
 
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
 	if (IS_ERR(sub))
@@ -1986,8 +1983,10 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	dev_set_drvdata(dev, cs35l41);
 
 	ret = cs35l41_hda_read_acpi(cs35l41, device_name, id);
-	if (ret)
-		return dev_err_probe(cs35l41->dev, ret, "Platform not supported\n");
+	if (ret) {
+		dev_err_probe(cs35l41->dev, ret, "Platform not supported\n");
+		goto err_acpi;
+	}
 
 	if (IS_ERR(cs35l41->reset_gpio)) {
 		ret = PTR_ERR(cs35l41->reset_gpio);
@@ -2076,6 +2075,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 	gpiod_put(cs35l41->reset_gpio);
 	gpiod_put(cs35l41->cs_gpio);
+err_acpi:
 	acpi_dev_put(cs35l41->dacpi);
 	kfree(cs35l41->acpi_subsystem_id);
 
