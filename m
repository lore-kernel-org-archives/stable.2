Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587418;
	b=DHauvaGBmHehHb3+hlZi4425nC7aZgh6j5Kq4R3zh9/M0sfbZnuBQQDKUFV+93YV/Y90
	 KGqYbuunD+foHU69FyfBBKxD7ZHmgtps8H6cZu82AyX3rhnHJIo814XpbUOxvrnMYbP9a
	 bi4HcVbDxs3FFDTpw9n9ATGydcBffeZOPjPjiuLmEl0aiTN5mcZxTub+a7rtOTt2u/+W5
	 OwK6S8ziP91KrvY1outSDveGD3TzGbh1Vn3a68mrLr9BdiZkysh6z7No1nDCVkDGbBvN3
	 OoyjfX4efc3eNRDLtKYCwZhuWD7GmgATSOy04NK7SvtXILtuSHJc3QJTeeJB+AwE7ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587418;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=2nBydGv9mIiJ5Gr5SDQONXTipJ1tdBIAYvpUitblkuM=;
	b=YV42LxPWYXk/Pk7My9drStUV+OkL3OBqeY9F66MUcsH8xOfkcuqTUkk4rM1ghfyrtlI9
	 A9d7dcUXL4i7HR1Lo9vLk6xqA7ALXzuJrOZGk17l8HjwKHq9tuOZD6TyF5pR5SG+GGY7w
	 2LuPHvaagzuCoh9YZuJMYbUJBEivS4ae1SrSeM85D8vGvnAn2cGOoQaGGb9SBGSmf7KOd
	 OSYhpC3QZx/s3Ze2POCt+S9F24j4/+D5BuKOguiTFFvYeecwOthUTj9SyYPM2UE4bWGWv
	 nxRm6eNrhcKRqiaqbVh/XtrHOCPkK21/pnkKA++ADdTVVSgrWEk8b7oKKInH9AmSqoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dmxV+Vny;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s7Tb8LQe;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dmxV+Vny;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s7Tb8LQe;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A4606A325;
	Wed, 21 Oct 2026 12:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 728A4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dmxV+Vny;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s7Tb8LQe;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dmxV+Vny;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s7Tb8LQe
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B88E21A33;
	Wed, 21 Oct 2026 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792587409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nBydGv9mIiJ5Gr5SDQONXTipJ1tdBIAYvpUitblkuM=;
	b=dmxV+VnyDNluCdG5hbyfKyteWRqN/Cl2b4mG364gEjJRhUGBwN28Ke/vnOasXxlS0guygS
	ON1BPKN8gwGOFdih/xHE94cGT4WG4F9pc4ep6Ji1C+Hr66W2DL1q/fnFS3IBPG34UdIW2Z
	UdsPusohwi2JPEbgVwL2VeoKrGFpvfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792587409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nBydGv9mIiJ5Gr5SDQONXTipJ1tdBIAYvpUitblkuM=;
	b=s7Tb8LQegD2Wm2FjGP671tfZB4yJTjKj/9EjWwbdB1udIsAnSvAIiaWoq+/j4Ty4u18rEH
	Rur75xIUCdJoE4AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792587409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nBydGv9mIiJ5Gr5SDQONXTipJ1tdBIAYvpUitblkuM=;
	b=dmxV+VnyDNluCdG5hbyfKyteWRqN/Cl2b4mG364gEjJRhUGBwN28Ke/vnOasXxlS0guygS
	ON1BPKN8gwGOFdih/xHE94cGT4WG4F9pc4ep6Ji1C+Hr66W2DL1q/fnFS3IBPG34UdIW2Z
	UdsPusohwi2JPEbgVwL2VeoKrGFpvfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792587409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nBydGv9mIiJ5Gr5SDQONXTipJ1tdBIAYvpUitblkuM=;
	b=s7Tb8LQegD2Wm2FjGP671tfZB4yJTjKj/9EjWwbdB1udIsAnSvAIiaWoq+/j4Ty4u18rEH
	Rur75xIUCdJoE4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E372B134A5;
	Wed, 21 Oct 2026 12:56:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IhyJLZC22GoHcQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 21 Oct 2026 12:56:48 +0000
Date: Wed, 21 Oct 2026 14:56:44 +0200
Message-ID: <87v76vdxf7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: henrik.enquist@gmail.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] ALSA: aloop: Update the PCM Slave controls for a matching playback
In-Reply-To: <20261021-aloop-slave-controls-v1-0-62297727177f@gmail.com>
References: <20261021-aloop-slave-controls-v1-0-62297727177f@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-10.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -10.80

On Wed, 21 Oct 2026 09:46:44 +0200,
Henrik Enquist via B4 Relay wrote:
> 
> Hi,
> 
> One more aloop fix, after the notify mode one (ded1060369 "ALSA:
> aloop: Don't constrain playback params in notify mode"). I ran into
> this while working on a new CamillaDSP feature that uses notify mode.
> The "PCM Slave" controls are meant to report the playback's
> parameters, but often they don't. loopback_check_format() returns
> early when a capture is open and the parameters match, before it
> updates the controls. They then keep the module defaults, or the
> values of an earlier stream.
> 
> This isn't specific to notify mode. Without notify, a playback that
> joins a running capture always has matching parameters, so the controls
> are never updated in that case. The early return has been there since
> the driver was added, hence the Fixes tag on the 2010 commit.
> 
> Patch 1 skips only the capture stop when the parameters match, and
> always updates the controls. A value event is still sent only for a
> control whose value changes, so nothing new shows up except where a
> stale value gets corrected.
> 
> Patch 2 adds a test for it to the aloop selftest. It doesn't need to go
> to stable, so it can wait for the next merge window if that's easier.
> 
> Testing: for-linus at 443ed4edc2, arm64 VM, kernel with KASAN,
> lockdep, DEBUG_ATOMIC_SLEEP and DEBUG_LIST, comparing the patched
> driver with the unpatched one built from the same tree.
> - The selftest passes 5 of 5 patched. Unpatched, only the new test
>   fails: the controls keep the earlier stream's values (96000 Hz,
>   S32_LE, 4 channels, non-interleaved) and no value events arrive.
> - The reproducer in patch 1 reports 48000 unpatched and 44100 patched.
> - No KASAN, lockdep or other warnings in dmesg.
> Not tested: real hardware, other architectures.
> 
> AI disclosure: as with the notify series, I used Claude Code (Claude
> Opus 5.5). It traced the bug through the driver and its history, wrote
> both patches and their changelogs, built the test kernels and ran the
> tests. I reviewed all of it.
> 
> Henrik
> 
> ---
> Henrik Enquist (2):
>       ALSA: aloop: Update the PCM Slave controls for a matching playback
>       selftests/alsa: Check the aloop PCM Slave controls for a matching playback

Applied both patches now.  Thanks.


Takashi
