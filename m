Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E844BE424;
	Thu, 10 Sep 2026 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056703; cv=none; b=oMGD8lZrLMP8EKQknwXW3jz8NS75cHay00DetZfMLPGYX4pXRdbsc++V9WFy4Izc5VhpydKeMYrBZSbs0bCDd2ns9rOtacNaC+fJYjebNJ4j5Ja+fxLb9cIj0YcQlxxCphRBUueryMkdq+HEzx4uWZuLpCmHF0uF0ueSUmNhAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056703; c=relaxed/simple;
	bh=m9IMd72Q+Du6fhOKO1Umo1pX/Zuz0nCkmCAKuAygOG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CXEK2fOP9nkFBWRfqG+KCQvRVeJqzaka6VMrStw0TN+ssyy30QWytHIxivFf6Pv+gjigvEYeXgIrD5fWR23XnXGL61YF29hP8eprrtmxD7qKtMTDQ0p6Q1eoAC8lmNLsFGeiIT0GNvRBnp5TgIvuuVSxI7lnQudLwYHt1UYC5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jSy2W0qE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O9m8z2Gm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FjNCkmJn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O4J+5s1p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jSy2W0qE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O9m8z2Gm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FjNCkmJn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O4J+5s1p"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EEB921DA5;
	Thu, 10 Sep 2026 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789056695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTJVoTokhIxtKUnUKZO8I6RmqLBJbGupbbqv0tLZXP8=;
	b=jSy2W0qE1MPWAekOFD2Nl85p9ExS8vGsjYy2xGZMDEzx+cxuTelULAF4M/I/xUIUlCcUq4
	iGj/ih7+xOsbzRSl2HcUt1ThgcINYJdOLdIMgrY3+cNDGZui+KuUl3unrEQ4UidOfrgzT+
	HEI+E2T11m+rDv9/McXFCu1SF6kc9qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789056695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTJVoTokhIxtKUnUKZO8I6RmqLBJbGupbbqv0tLZXP8=;
	b=O9m8z2GmEVWX8etqjfTSkpuTIFNSklpy81YXay7gNvh8VNRPnmHFy/j/d5rPOqpGLCfoGY
	zvPTTRZ2c9jzG+BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789056691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTJVoTokhIxtKUnUKZO8I6RmqLBJbGupbbqv0tLZXP8=;
	b=FjNCkmJn1su2ZbL3fNxG0P5OLAiAAjaJHwvOKlDIe4RWPaqAegpih5VMv5KIvey71OBsIX
	D6ydSlHifkavf1S40psX4oyB1TJcU3GCrsq4E2jJ6cLIPSpfv58yUWA1hY31e0PNDKJmlX
	tbtUEuwcEiIpEPg0xhjaJdD8m2QDaa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789056691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTJVoTokhIxtKUnUKZO8I6RmqLBJbGupbbqv0tLZXP8=;
	b=O4J+5s1pEtaIStHzMuGc+ZCldcmfMIv7GSd3KzeFqCGlqnB2zLLFCstukroG1jcoqwh+aI
	x/44feG2IpMAzDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 860401326D;
	Thu, 10 Sep 2026 16:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S3dDDrLWomqlPQAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 10 Sep 2026 16:11:30 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] io_uring/net: don't overconsume buffers when using
 MSG_TRUNC
In-Reply-To: <87a4pp2iog.fsf@mailhost.krisman.be>
Organization: SUSE
References: <20260902230041.1320658-1-krisman@suse.de>
 <20260902230041.1320658-3-krisman@suse.de>
 <0f5e8693-dcba-4fa8-87d1-570ac08e2d83@kernel.dk>
 <87a4pp2iog.fsf@mailhost.krisman.be>
Date: Thu, 10 Sep 2026 13:11:27 -0300
Message-ID: <875x0d2ij4.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,mailhost.krisman.be:mid]

Gabriel Krisman Bertazi <krisman@suse.de> writes:


> I'm folding your fix up in the v3, modulo a compilation error.  It only
> changes the error path, the bug is still fixed on 7.3 with your patch
> folded in.

Please scratch that.  I misunderstood your previous email. I see you
applied it on io_uring-7.3 with your fix up.  Looks good and the
test still passes. I'll turn it into a liburing test.



> Any suggestions on how to test this error path for liburing?
> I got a test for the bug, but testing ret<0 means failing the socket.
>
>
> -- 
> Gabriel Krisman Bertazi

-- 
Gabriel Krisman Bertazi
