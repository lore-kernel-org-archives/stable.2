Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424338;
	b=XrTy2eCXLIr+M0j0TfG/gZ3SJk2Ce2SLSvCo5a8b5+zNB1DekrchgqeyIn4E799JKy5h
	 7Sko1YCjYGUs6ptbT5M/L8vcREGER84P8aD+G/WLdJfnCj7XgZzmaoG9FpWpqZqwfMPBY
	 GEM4GiS4Px2u+uNhIdVOm0u6WKH1WwhuSFCt4S+Mzx9lvRVgnVsGxy8zSsAGiJHU8JVws
	 A9fsqJ96lRL2dtQ+vFNilJhqBkQFMqMQcqU4VEZvlBGpog/GCBuox6OXyxkIs8Jwlw3oz
	 p9jb5TxvwgGbIk61dpnzI/FWvHTKKYhC60Sta9CkE8td11qSdvU3lPT3XJzV15a4lOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424338;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=tEOyxuEsk0JOC4PDA4fd08/KnLW7AODcfbwN/MrfZis=;
	b=alAdIZZfR3qbstppztgD8QriUZ76JaUp47qXf1NCHHOucn7uY0yNBusyfMeLg10fN82S
	 dSyDmF4pLnppFhkvb4BreOKdWsLVApp5EAw9B71AgztkZ8EU+zu21npu589fCsU/5F+0r
	 3IH8hraa99fwt1UYGxW9y1NZnoiY9vA5zTS5fkGULGVh5fq1W5IVlvnYWui8tZcsJPiPH
	 FB5A8yqBaDiZ5/uHVGbzM/GYhobok63Bq5cWbrJ856FnxvTL8ZtPLHQBWfMxSjTYCOosv
	 6+jWA0U01reu2xfMw1rzPy1LqoS4JMl6OmHXrkgwuehEu7O6wOoAyX/t8Wt0RObCNUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dyPrjSEF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dpe+g8yd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dwAbpBhI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+KDTEgj0;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46907606A32E;
	Mon, 23 Nov 2026 08:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46907606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dyPrjSEF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dpe+g8yd;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dwAbpBhI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+KDTEgj0
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 831D721BD0;
	Mon, 23 Nov 2026 08:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795424336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEOyxuEsk0JOC4PDA4fd08/KnLW7AODcfbwN/MrfZis=;
	b=dyPrjSEFdQ690ptE3kkO5BDGRPw/uCdmya/lTY2yR7XmEcqW0eWLLTfaEKu8TY6ZLzN8Ap
	Z728unwL1IGaioE+7AFzjmSI9V8z2ZcXSbaKZHxzECzfKxXauWSleiSvJ4LC4sgANCOLCS
	JEW/a/7c7OIV/HOFyPMbKkbGrA6zmek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795424336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEOyxuEsk0JOC4PDA4fd08/KnLW7AODcfbwN/MrfZis=;
	b=dpe+g8yds6TOQIp0DDKiM0TMmkUy7NYCBYl7x8n0jws+oPw+HTlwg5uZXH4inokAqbNZ2Q
	se1anG/j8J331yBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795424335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEOyxuEsk0JOC4PDA4fd08/KnLW7AODcfbwN/MrfZis=;
	b=dwAbpBhIVqCSGI4GavOf8JJwiSsUeAuVgNrB8SnAUFT7kSZkMb6K3KFHYXrTsAA+NX+vq6
	g6UnXh2XLHzqK1i5QAtSa49UCR/VMAkSwLlDgduGqouA560bLwmHuuNH5sdoSjUPPyxcUt
	/RjoOijUHRE/EGjQPYUdnZkElAU8SH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795424335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEOyxuEsk0JOC4PDA4fd08/KnLW7AODcfbwN/MrfZis=;
	b=+KDTEgj0Qtp4uw0kKIubHexu+9b7TQuRaJ9TAKOde7uEaR27YOT0tci/ppWD4OJiR6SMCj
	vBDDVciPZfSbV4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F4F61352B;
	Mon, 23 Nov 2026 08:58:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3yPhNU4ABGuDBAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 23 Nov 2026 08:58:55 +0000
Date: Mon, 23 Nov 2026 09:58:54 +0100
Message-ID: <874id7exf5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v6] ALSA: line6: Stop URBs synchronously via sync_stop callback
In-Reply-To: <20261122104039.7160-1-25031212351@stu.xidian.edu.cn>
References: <87a4n1702t.wl-tiwai@suse.de>
	<20261122104039.7160-1-25031212351@stu.xidian.edu.cn>
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
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30
X-Spam-Level: 
X-Spam-Flag: NO

On Sun, 22 Nov 2026 11:40:39 +0100,
YuanZhe Liu wrote:
> 
> line6_buffer_release() frees the stream buffer after
> line6_wait_clear_audio_urbs() gave up waiting for the URBs that are still
> active.  The buffer is still referenced by those URBs, and the completion
> callback of such an URB resubmits it from submit_audio_out_urb() with
> line6pcm->out.buffer already set to NULL, which ends up in a NULL pointer
> dereference in the memset() in submit_audio_out_urb().
> 
> While the URBs remain queued, the host controller can also write the
> received isochronous data into the freed buffer.  Such a write does not go
> through the KASAN checks, so it silently corrupts the freed slab object;
> the corruption was observed as a bogus KASAN quarantine entry that later
> led to a general protection fault in qlist_free_all().
> 
> The active_urbs bitmap cannot prove that the URBs are gone:
> line6_unlink_audio_urbs() is called outside the stream lock and only marks
> the URBs that are active at that moment, so an URB resubmitted by a
> completion callback right after the scan is never unlinked and keeps being
> resubmitted after the stream was stopped.
> 
> Stop the URBs synchronously instead of polling for them: mark the URBs
> that are currently active under the stream lock, so that the completion
> callbacks cannot resubmit them, and kill them with usb_kill_urb(), which
> waits for the giveback.  Expose this through the sync_stop PCM op, which
> ALSA core invokes before hw_free(), hw_params() and prepare() once the
> stream was stopped, so the buffer is guaranteed to be unused when it is
> released.
> 
> The URBs are marked and killed only while no stream is running on that
> stream, and only those that are active at that moment, so neither a
> stream started concurrently nor another stream type still running
> (software monitoring, impulse or the capture helper) is stopped.
> Unlink marks left on already completed URBs are dropped afterwards, while
> those of still active URBs are kept, so that a later stream start can
> submit the URBs again.
> 
> line6_pcm_acquire() and snd_line6_prepare() keep a synchronous stop for
> an idle stream as well: sync_stop() is invoked only when the substream
> itself was stopped, while the other stream types sharing the same stream
> never set that, and their unlinking URBs would make
> line6_stream_start() skip the submission.  line6_pcm_disconnect() and
> line6_buffer_release() stop the URBs unconditionally, as the device may
> be gone already and the buffer is about to be freed.
> 
> The helper skips the loop when the URBs were not created, as
> line6_pcm_disconnect() may run after a failed probe.
> 
> Fixes: 63e20df1e5b2 ("ALSA: line6: Reorganize PCM stream handling")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

Applied to for-next branch now.  If you have further fix, please give
an incremental fix.


thanks,

Takashi
