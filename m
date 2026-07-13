Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703933502A8
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936954; cv=none; b=QkoY67REzVAAklOlnUdxF/RPle0/NxOyhcdTPZDPG25DLMtghyfbS6UnpsEAlakmAYvrpfDJPjIM9zJDTxg4Y+3WPpRu++2FJfaaRpZ32I9BJklo8O3cKaYKmqv+3PWALppNj4RSO06dbaEXcALlGO/tN/cnKeS+Li+iAMwKVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936954; c=relaxed/simple;
	bh=xtICORQXo2BBb4funtYSGJxNK+ir0SY18hPMCPDEXCQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1LkzMq9zDqJJSoUsPboDf5zV/GTzJ8v+W3EXlwfymxmcNDYHe4ZJB0faehSoeOChHGcluODJpJ3MeGPAkBQM6zMRvfmcpj1zqZKC+mV4CHOHhIIaDoshT8k1DeTDGT3dFYmGS2nKIh7ziHU/GrJfxU2f8NNssnMvjSSrv910z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kkIIUh5D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ARZSpYWk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cxPabTdl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I8PDkS4d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kkIIUh5D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ARZSpYWk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cxPabTdl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I8PDkS4d"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2AD66773F7;
	Mon, 13 Jul 2026 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783936944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XP2a53hPDpisD5o4rYPu5HqEIeNhTTXuEkXL4tU2MIw=;
	b=kkIIUh5DkgfrwKvzLwQQuF+x+sg6lD58QxJAVAuEBr3VBU6URxgKlZZOsv99KO0/+SUTQL
	csj1r7FEGxLoTmzpxIhazzjsz//FH9NcVJtD5SzD8H3w0TQzvstesw8VKUNQTsUJ8CsETw
	2WBDL3pba3VgLhP3zisETHRzZdMgWLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783936944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XP2a53hPDpisD5o4rYPu5HqEIeNhTTXuEkXL4tU2MIw=;
	b=ARZSpYWkHly1TSc6qJZn5hvWVdx465emgZKs4iVix9MTL8lQYFYFbJWedMXxnpwSrJh/NV
	TOKvA7YHzh31f1Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783936943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XP2a53hPDpisD5o4rYPu5HqEIeNhTTXuEkXL4tU2MIw=;
	b=cxPabTdlRbfpRNchVXWpdc37Wj4Qw5OyrsHky4iNJhF7Cuea4CZGcLiaMg2kuhXVCD+HM3
	omi0VIWURPhgLHyCc/QhcfgSiojp8o9df66llMDdJ6Bws+L6gv8nDhM1b2eSUtL4neS9BE
	g8q+/yfHU/jT1DMKb74qM4b3FcsHqkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783936943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XP2a53hPDpisD5o4rYPu5HqEIeNhTTXuEkXL4tU2MIw=;
	b=I8PDkS4dDa7fJtQVKqC1TmZ8mJyIM9kkuoFWXZw8SegFQcL9v0RwUZnuCwEKtrA8RBXYKq
	RPJ1JFYhz0IRR1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0567779AE;
	Mon, 13 Jul 2026 10:02:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mUYyLa63VGr9GgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 13 Jul 2026 10:02:22 +0000
Date: Mon, 13 Jul 2026 12:02:22 +0200
Message-ID: <87wluzyzpt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Evgenii Burenchev <evg28bur@yandex.ru>
Cc: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kees@kernel.org,
	eblennerhassett@audioscience.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] ALSA: hpi: Check transport errors during HPI6000 adapter initialization
In-Reply-To: <20260708141147.18253-1-evg28bur@yandex.ru>
References: <20260708141147.18253-1-evg28bur@yandex.ru>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[yandex.ru];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[yandex.ru];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,linuxtesting.org:url]
X-Spam-Level: 

On Wed, 08 Jul 2026 16:11:44 +0200,
Evgenii Burenchev wrote:
> 
> create_adapter_obj() retrieves adapter information by calling
> hpi6000_message_response_sequence(). This function reports transport-level
> errors through its return value and DSP-reported errors via hr0.error.
> 
> The current code only checks hr0.error, causing transport-level errors to
> be ignored. As a result, adapter initialization may continue with an
> invalid response.
> 
> Check the return value of hpi6000_message_response_sequence() before
> examining hr0.error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 719f82d3987a ("ALSA: Add support of AudioScience ASI boards")
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>

Applied to for-next branch.  Thanks.


Takashi
