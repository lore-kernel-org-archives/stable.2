Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095BB14883F
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791019097; cv=none; b=gchKD4I6zGEuIrK8+XumUbzvbD+mQ0HeJDINd+1FTNajfB6sfl3vsbaVIagen/IqPES569Wgz8aePNA7+WwbIr5VIbx5BHdJU0VMA1R3pRAIO1LXBOl9jppPox7qszXutQMXfobmKjUZBtVi8wuyad451kjJsr90/qfL7uwjwjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791019097; c=relaxed/simple;
	bh=Yi7gRouWiMK2ZIVXAcOMOJyvDWGT5VTwa57PBxkSXlM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cyb5sIDhkLDXI8lI45xEplVsk2VAx5+++kLRzILW1+X6tE7VThh6W/0n/BXa3JMwilN4mJxN3vTUaXVYGNc3w2OD0tx4GhTXgq41s1dRN/ovJX5uHwA19NrugkOa5fnGdlY4xKOsLKtHCNOtyZwo4JK98LCa3vB1NP3XecN0KAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U7G380CX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yOfxQT5C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aeNqO6FB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=snrEbHPN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U7G380CX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yOfxQT5C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aeNqO6FB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="snrEbHPN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09FE721B67;
	Sat,  3 Oct 2026 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791019082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQbsbpZx7YMZ7tyixugFc4QCd1/TpXvvp9Ysf7an1c8=;
	b=U7G380CXbIswGXqWfiq1EQvoCtfhXAM72vgXsDAJibodrYXXiZv87N25V6oHUfcbsePXW8
	X6mQRGnCZmyqMMG9S0UH+1L0NGdDzpSZt/q0fOmAdHmr02KzFNpb+kqb3rTVcHRpZIBLoD
	B09i+31l7ujRemaHNLhn2hs1nlRYGS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791019082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQbsbpZx7YMZ7tyixugFc4QCd1/TpXvvp9Ysf7an1c8=;
	b=yOfxQT5CuQuOr5JqkHLehETKHyYx6ELV+qFLHseidRTisA2l2Wo2t6pubUcNMU6h7qIVPh
	qkz/HnvSfjNcCjAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791019078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQbsbpZx7YMZ7tyixugFc4QCd1/TpXvvp9Ysf7an1c8=;
	b=aeNqO6FBFR/kXzt55vynS89EnWOQ00Zb+3zb4/5inFBXNPV8Kqt8RJ0yJUwNGmFaMnbtmP
	bDDyMVMDQwPsaxz41S5Rn32Q+28T7H6yj1VQRlzsbbFayfBplhHoiRkQBNTfuKRH5mAQRP
	SxVNorUGey8VPrAAeOsaKLkswQAh7jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791019078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQbsbpZx7YMZ7tyixugFc4QCd1/TpXvvp9Ysf7an1c8=;
	b=snrEbHPNm71AyUOWF+xhNEr58fweTpdSv74+7WH1hStb2JVo9EmwrmOqOPb6Xjd5nMREg6
	lY5uY9DLPu/BXKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A956313712;
	Sat,  3 Oct 2026 09:17:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uEz9H0XIwGrFJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 03 Oct 2026 09:17:57 +0000
Date: Sat, 03 Oct 2026 11:17:57 +0200
Message-ID: <87h5j3xhve.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: med.jebabli@gmail.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/tas2781: Accept V1 calibration data without CRC
In-Reply-To: <20261001-tas2781-v1-nocrc-v1-1-ff0c1032ce76@gmail.com>
References: <20261001-tas2781-v1-nocrc-v1-1-ff0c1032ce76@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, 01 Oct 2026 12:24:42 +0200,
Mohamed Yassine Jebabli via B4 Relay wrote:
> 
> From: Mohamed Yassine Jebabli <med.jebabli@gmail.com>
> 
> Some Lenovo BIOSes (e.g. Legion Pro 7 16IRX9H, SSID 17aa:38cd) store
> valid V1 calibration data in the CALI_DATA EFI variable but leave the
> TimeStamp and CRC fields zeroed. The driver rejects such data, so the
> amplifiers always run with default parameters on these machines.
> 
> The rejection was silent until
> commit 4fe238513407 ("ALSA: hda/tas2781: Move and unified the
> calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
> turned it into "V1 CRC error".
> 
> The stored values are consistent (R0 = 3.82/3.83 ohm, 1/R0 matching
> within 1e-4), so accept V1 data when both TimeStamp and CRC are zero
> and the first device entry is non-zero, and emit a warning.
> 
> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohamed Yassine Jebabli <med.jebabli@gmail.com>

Applied now.  Thanks.


Takashi
