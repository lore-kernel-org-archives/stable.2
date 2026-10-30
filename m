Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384464;
	b=H2ViREE8rrjuIwznjgRpuKazLwB6Knrct2Zvba+KyAXFHo7XBJhvvluF6PvgGUY/leFM
	 rnSlQs9m52MXzxFR2iPZdunEF0pF2PY0BaegWe5BHUxb7tD0eglTvLvPCdN+79r6YX2fk
	 agRVEzbb2UUl59aOB5PmK+UaF5lEjwDllUYSee1/owXVJcH1Eihkqj9ZRfDaS4P10pCIw
	 22sgwInpPTcR8Iw6uhAAbhUfihm8DX4y1NIKUYhy4gpq1gtO6+mxfjvuvxg+ctvppktsK
	 KD5IpJtgr5PHcPdflWYv2yOq09x8UoLxTK687jlbgDzUFbbD5m9uw6muzsP27Xf3alQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384464;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=atuUW4C/Wg4yFbT0KWVDMKUjdmoi9IvBzt6Gv31csng=;
	b=M8hfa44cn0GKGekv6RjgIs96DPmzxM8It6dO2fFUmac+7TiVR00qIYVxY6jlPtHWYx8W
	 6sJ33O9AOshXTVitonPXYlKGbCcG01g+1q/ZXoLQfeC0T0qrCUbYFH12rSeSUtq/EVq0s
	 RwIwlx5jdHHKF2CVI26JZTEgLG/wgCTRLL/CjGypw5IvKVmlqFzHjyYlUAIMnMup4Sd34
	 6kJNeTpOjJxNe3is5gQlqiCLdHLTv0ERE5puXhlcclvMNekSO7p0wdvX0GSWy+OkzOe4H
	 uJu8EAF/qsDaZVfM0xJhPDGm1s1jt8zsNYAFfXKmU3ETLeNA9vG3sLL6f2WNq42mkWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LHczAXS3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="NHvx1k/j";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LHczAXS3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="NHvx1k/j";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC70606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 18:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FC70606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LHczAXS3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NHvx1k/j;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LHczAXS3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NHvx1k/j
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D9C11F813;
	Fri, 30 Oct 2026 18:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793384461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=atuUW4C/Wg4yFbT0KWVDMKUjdmoi9IvBzt6Gv31csng=;
	b=LHczAXS38k+gBkdS91iKumAPuaq4DNgYtPs1QeuFA30DyoFlv2MObUYbZEAEH66+N3vjc9
	XpsCtNoY58YevqlY/GyPx0K423G4zkRAxi8W/5PueaPNDrov8CXSv0cxzz+DReOLE5qaW4
	BXgnJSA1JTw3Xs6GHhbAxJihGAj9We4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793384461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=atuUW4C/Wg4yFbT0KWVDMKUjdmoi9IvBzt6Gv31csng=;
	b=NHvx1k/jA926QzEJPgrtJEC93FowMeleyUtLTwrdp8Obn+/AsqmXk+HCRBOI8RiDDocqre
	O1qSiQJFmM89TlBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793384461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=atuUW4C/Wg4yFbT0KWVDMKUjdmoi9IvBzt6Gv31csng=;
	b=LHczAXS38k+gBkdS91iKumAPuaq4DNgYtPs1QeuFA30DyoFlv2MObUYbZEAEH66+N3vjc9
	XpsCtNoY58YevqlY/GyPx0K423G4zkRAxi8W/5PueaPNDrov8CXSv0cxzz+DReOLE5qaW4
	BXgnJSA1JTw3Xs6GHhbAxJihGAj9We4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793384461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=atuUW4C/Wg4yFbT0KWVDMKUjdmoi9IvBzt6Gv31csng=;
	b=NHvx1k/jA926QzEJPgrtJEC93FowMeleyUtLTwrdp8Obn+/AsqmXk+HCRBOI8RiDDocqre
	O1qSiQJFmM89TlBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38B7813419;
	Fri, 30 Oct 2026 18:21:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QEgINQzg5GpPCwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Fri, 30 Oct 2026 18:21:01 +0000
Message-ID: <c0c771d373e863dbac55e6d487f00a0a0875a5d6.camel@suse.de>
Subject: Re: [PATCH linux-6.18.y] hwmon: (lm90) Consistently use our own
 mutex
From: Jean Delvare <jdelvare@suse.de>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Date: Fri, 30 Oct 2026 19:21:00 +0100
In-Reply-To: <2026103057-sinuous-halves-9ba7@gregkh>
References: <20261030092410.0e585c82@endymion>
	 <2026103057-sinuous-halves-9ba7@gregkh>
Autocrypt: addr=jdelvare@suse.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30

Hi Greg,

On Fri, 2026-10-30 at 09:41 +0100, Greg KH wrote:
> On Fri, Oct 30, 2026 at 09:24:10AM +0100, Jean Delvare wrote:
> > The backport of commits b09a45601094 ("hwmon: (lm90) Stop work before
> > releasing hwmon device") and 873e919e3101 ("hwmon: (lm90) Add lock
> > protection to lm90_alert") to stable branch 6.18 makes use of the
> > hwmon_lock()/hwmon_unlock() API. While this API is available in
> > kernel v6.18, the lm90 driver was not ported to it until v6.19.
> > Mixing the use of different locking models within the same driver is
> > unsafe and should be avoided.
> >=20
> > Update the backports to consistently use the driver's own mutex.
>=20
> Oh that's going to cause problems over time, right?=C2=A0 Why can't we ta=
ke
> the change that did the port instead to make this easier to maintain,
> otherwise we will be hitting this problem constantly for any changes for
> the next X years that this kernel is alive.

Any lm90 backport involving locking will have to be adjusted for all
longterm and distribution kernels < 6.18 anyway, so this does not cause
extra work.

But you are right that it could cause trouble in the future if someone
backports a fix without paying attention to the locking model
difference, as it will not cause a build failure nor even warning, as
it has happened twice already.

Backporting e9b64fae44be ("hwmon: (lm90) Rely on subsystem locking")
should work too, I see it applies nicely on top of kernel 6.18.59, so
you can apply that (to linux-6.18.y only!) instead of my fix-up patch
if you prefer.

Thanks,
--=20
Jean Delvare
SUSE L3 Support
