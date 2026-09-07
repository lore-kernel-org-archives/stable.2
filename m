Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED150AC29;
	Mon,  7 Sep 2026 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795795; cv=none; b=TekhVumCDtD3k/ioSIH3u4zce8AcxSbU2EwctLWTnr80ywDVANBANztNtW/0KQursGsVGLlwezBpGpgF7+TIHcfo8JgyQ6HZtYpiB0Me9Sw0pM6PRDWw1GgWJWSX7BI1J9rJtPAFGKl1Ejf3zJfWR5eAfEEAMrwhZuf7wcjBLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795795; c=relaxed/simple;
	bh=MjwqLhvdC94YpeNeflpXfTcBgH+sSiY7j2H5nHkw874=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ph/hjgnN5Sylnv6HLAhG7ggRjOGeQ4cWaKhJFW+0UzLAKFZTaSUf9LNraUNxpdGZXY7ulgLPJvZEsSJvCxBxnhMyjwWRPGB46UZ+cA2cmB6c7mE9b2Kl2jXABVnfV6wv1J69swWXv/NVuXeNF8UAz4M97wkDBXYmmqAjTLSW3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nWTLJvyO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sKSQXusY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nWTLJvyO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sKSQXusY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED60621241;
	Mon,  7 Sep 2026 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1788795786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7A6lEeo3jzIaoAAZp8uXAn3dzvIf0S4LYiCo7+I82iQ=;
	b=nWTLJvyOJyJfR2M+LBNeYKYuifCWYsJaGVZSYR2J8emKOruZZffR+AAcqyG97nxT0nawen
	vAy3zEwJNdiGf+Wahm6Wx0NO1bJV/o26h9Xccqpf/4DmVDaMdKmsSdxpTWPq/+BcGoJ6MQ
	hOg0Ezf3EUJVJmKoFFe2lz5+h7Yzvsc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sKSQXusY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1788795781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7A6lEeo3jzIaoAAZp8uXAn3dzvIf0S4LYiCo7+I82iQ=;
	b=sKSQXusYNkl/d5IsC15wG085Z73dDOuTqN1oZu3xCdnnfFO2T/FQvM7apmkr8PSSt5sRby
	LHWCQNHyesRwk5JPSXYQqvFg7cdQgto4kShx+KECRuIHOOMBFeBSDq1wIVJX5EVYTT6Uv3
	SqoN10f8yXVmDEAsRqo+UVPNB2Dpzxc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8E7B1339B;
	Mon,  7 Sep 2026 15:43:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qjIQKIXbnmqPcAAAD6G6ig
	(envelope-from <mwilck@suse.com>); Mon, 07 Sep 2026 15:43:01 +0000
Message-ID: <c62efbd06eefc637eac2a7b358edb1297afb444d.camel@suse.com>
Subject: Re: [PATCH v3] md/raid5: validate payload size before calculating
 payload_len
From: Martin Wilck <mwilck@suse.com>
To: yukuai@fygo.io, Song Liu <song@kernel.org>
Cc: Xiao Ni <xiao@kernel.org>, Li Nan <magiclinan@didiglobal.com>, 
	linux-raid@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
	stable@vger.kernel.org
Date: Mon, 07 Sep 2026 17:43:01 +0200
In-Reply-To: <b6f56e58-fcfc-482b-999a-b9ad8d5af023@fygo.io>
References: <20260902181819.267431-1-mwilck@suse.com>
	 <b6f56e58-fcfc-482b-999a-b9ad8d5af023@fygo.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: ED60621241
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,didiglobal.com,vger.kernel.org,outlook.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO

On Mon, 2026-09-07 at 14:29 +0800, yu kuai wrote:
> Hi,
>=20
> =E5=9C=A8 2026/9/3 2:18, Martin Wilck =E5=86=99=E9=81=93:
> > Commit b0cc3ae97e89 ("md/raid5: validate payload size before
> > accessing
> > journal metadata") introduced a bounds check to verify that a given
> > payload
> > fits into the current metadata block. In order to calculate the
> > payload
> > size, it has to access the members payload->header.type and
> > payload->size,
> > the offset of which may already be past the end of the metadata
> > block,
> > because the loop condition only checks that the first byte of the
> > payload
> > is inside, and the payload entries have variable sizes. Later on,
> > payload->checksum[0] and payload->checksum[1] are accessed without
> > verifying that payload->size is large enough.
> >=20
> > Add another check to make sure that payload->size can be safely
> > accessed, and make sure that the checksum fields are accessible.
> >=20
> > This issue has been found by AI (gemma4, Gemini) during a backport
> > review.
> >=20
> > Cc: Junrui Luo <moonafterrain@outlook.com>
> > Cc: stable@vger.kernel.org
> > Fixes: b0cc3ae97e89 ("md/raid5: validate payload size before
> > accessing journal metadata")
> > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > ---
> > Changes v2 -> v3: Fixed another issue reported by Sashiko
> >=20
> > * Modify loop condition to make sure the payload->header.type can
> > be accessed
> >=20
> > Changes v1 -> v2: Fixed issues reported by Sashiko
> >=20
> > * fix use of wrong variable name payload_len instead of mb_offset
> > * add checks to ensure payload->size is large enough to hold the
> > checksum values
> >=20
> > ---
> > =C2=A0 drivers/md/raid5-cache.c | 34 ++++++++++++++++++++++++++--------
> > =C2=A0 1 file changed, 26 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> > index 7b7546bfa21f..031a89faddae 100644
> > --- a/drivers/md/raid5-cache.c
> > +++ b/drivers/md/raid5-cache.c
> > @@ -2001,27 +2001,36 @@
> > r5l_recovery_verify_data_checksum_for_mb(struct r5l_log *log,
> > =C2=A0=C2=A0	if (!page)
> > =C2=A0=C2=A0		return -ENOMEM;
> > =C2=A0=20
> > -	while (mb_offset < le32_to_cpu(mb->meta_size)) {
> > +	while (mb_offset + sizeof(struct r5l_payload_header) <
> > le32_to_cpu(mb->meta_size)) {
>=20
> Offset can't be meta_size, however, is it possible that the remaining
> space is exactly one
> payload size? If so I think <=3D should be used here.

Right. But practically speaking, as this must be either a struct
r5l_payload_data_parity or a struct r5l_payload_flush, and both contain
additional elements besides the header, if "=3D=3D" applies here, we will
run into one of the following error conditions later, because the size
element won't be accessible.

Anyway, for the sake of correctness, I'll change it to "<=3D".

>=20
> > +		uint32_t payload_size;
>=20
> checkpatch report u32 is prefered.

Strange, it did not for me. I'll change it.

Thanks,
Martin


--=20
Dr. Martin Wilck <mwilck@suse.com>
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg,
Germany
Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald (HRB 36809,AG N=C3=
=BCrnberg)
