Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217212;
	b=xjsOv/thzMm1nlGJ3tgT71oFjkoIivpu6/s8mBBK4Dh54ITU21icku0o/gZYkFnGgfKv
	 /uNa8AxnjevoVjt2H28osCku9y2zMA3644wAWY4fpAipXxI12TMAK5lDZ5XFDf41+9D41
	 KO7stSqntIxaZ0kl9ISAfgYsY7wjArte5OU/iOtZvspSKULwdpyqSKSHWEwmQnzD8iDDs
	 inSgVnLx5St4Ayq1FJ3TWQiACFZqDRvAihxQPsddfjv+moCcIhNBXdJEG1eUIFsxfXWFk
	 m2169XVSCYRv2rg+bBaN944VTzzT5H/p42ThNPEhbB/MflU+c5/yksFNEkhXV/UIB9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217212;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=Aymv5QYuun1dCJMjw5Ayh+jzeyO/+fbZcIwDOryNHNg=;
	b=5ry7xTTaOvTfAD54RYmnfJ/NatRmXdjqcVTCp4Zk1EYdwWNUtArqHuSHFqHg7LVz/Dlc
	 +DFehhb1x1XX6kOCW0L6yBzb1FEJTMhYEWpJFv82tCwvVy6ngNpUeBglUj0fNUtg+waEi
	 j2pYyvBKN5mhkCvqneuuUEE/Vmcr3sYgINYTAL4OsPfGZFr49x26SaospceRE2rcYtnlR
	 9Sa+/bsP5rssyCngG55DgjDXJ9xcvf2nUb7hC7Kf8p0ChpxlNUnZ/TG8DAOQBeBQDlptD
	 RX9ZOdPV4fKr8qkkdt82m4ADjp/bW5Ar7V5sXCMfgXbYLGjt9wppIhVEnPYLqAYpNWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=F7fhBQoD;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=BIvkgADB;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD2606A321;
	Mon,  9 Nov 2026 09:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44DD2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=F7fhBQoD;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=BIvkgADB
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB13821F17;
	Mon,  9 Nov 2026 09:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794217209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Aymv5QYuun1dCJMjw5Ayh+jzeyO/+fbZcIwDOryNHNg=;
	b=F7fhBQoDGNVnmxC2PhE5Ni5yhwVTVpBkQv3VMF2RoFfhj+nuGyN3I5c9Os4TviZ+/3sx0X
	PocE8eaA9p4xPFtQaJ15N/MSFQZWD1ENr6Jh9Qh8OlzRHkf82TcAw9LkirugwNTvydeyQD
	s0frLco1iVgqVlZ53KdHoYxwtV+eTZA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=BIvkgADB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794217207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Aymv5QYuun1dCJMjw5Ayh+jzeyO/+fbZcIwDOryNHNg=;
	b=BIvkgADBIvrjxGA7ePEmtczxknVGgQagRcLhlTeyBc1TwI4x+1NMsK+RE5tsqms9XwJN/F
	wPhexNS7GUbI1PUapC9jpOcynnSoZ0evaKf9FPw8u3VMENe+tUhrQ5QEnTgJhRM/I0GNOY
	AP1fNuSXVjRuKwGt6RwOAdfR+s3ASyU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4378813302;
	Mon,  9 Nov 2026 09:40:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BpYBCfeU8WrhNgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 09 Nov 2026 09:40:07 +0000
Message-ID: <36064075-fbf0-40ac-8448-60bd36ad2a28@suse.com>
Date: Mon, 9 Nov 2026 10:40:06 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/xen: Fix lazy MMU pause count wrap-around
To: "M. Vefa Bicakci" <m.v.b@runbox.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261102-xen-lazy-mmu-v1-1-d99a3050b76d@runbox.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20261102-xen-lazy-mmu-v1-1-d99a3050b76d@runbox.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LygJjHqW8pY12708uQxPxyDh"
X-Spamd-Result: default: False [-13.31 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	NEURAL_SPAM_LONG(0.19)[0.054];
	MIME_BASE64_TEXT(0.10)[];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[runbox.com,oracle.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,amd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[runbox.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,runbox.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.31
X-Spam-Level: 
X-Rspamd-Queue-Id: EB13821F17

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------LygJjHqW8pY12708uQxPxyDh
Content-Type: multipart/mixed; boundary="------------pqceB7wYf1PbgMBK47JtVF9K";
 protected-headers="v1"; hp="clear"
Message-ID: <36064075-fbf0-40ac-8448-60bd36ad2a28@suse.com>
Date: Mon, 9 Nov 2026 10:40:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/xen: Fix lazy MMU pause count wrap-around
To: "M. Vefa Bicakci" <m.v.b@runbox.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261102-xen-lazy-mmu-v1-1-d99a3050b76d@runbox.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20261102-xen-lazy-mmu-v1-1-d99a3050b76d@runbox.com>

--------------pqceB7wYf1PbgMBK47JtVF9K
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMTEuMjYgMTY6MzEsIE0uIFZlZmEgQmljYWtjaSB3cm90ZToNCj4gQ29tbWl0IGJl
YzZmNDFhNmZlNSAoIng4Ni94ZW46IEdldCByaWQgb2YgbGFzdCBYRU5fTEFaWV9NTVUgdXNl
cyIpDQo+IHVuaW50ZW50aW9uYWxseSBwcmV2ZW50cyB0aGUgYWN0aXZhdGlvbiBvZiBsYXp5
IE1NVSBtb2RlIGZvciBtb3N0IHRhc2tzDQo+IHJ1bm5pbmcgb24gWGVuIFBWIFZNcyAoaW5j
bHVkaW5nIGRvbTApLg0KPiANCj4gVGhhdCBjb21taXQgbWFkZSB4ZW5fZW5kX2NvbnRleHRf
c3dpdGNoKCkgY2FsbA0KPiBfX3Rhc2tfbGF6eV9tbXVfbW9kZV9yZXN1bWUoKSB3aXRoIHRo
ZSB0YXNrIGJlaW5nIHN3aXRjaGVkIHRvLiBIb3dldmVyLA0KPiB0aGUgbGF0dGVyIGZ1bmN0
aW9uIGRlY3JlbWVudHMgdGhlIHBhdXNlX2NvdW50IGZpZWxkIG9mIHRoZSB0YXNrIHdpdGhv
dXQNCj4gY2hlY2tpbmcgd2hldGhlciB0aGF0IHRhc2sncyBsYXp5IE1NVSBtb2RlIHdhcyBw
YXVzZWQgb3Igbm90LiBBIHRhc2sNCj4gYmVpbmcgc3dpdGNoZWQgdG8gZm9yIHRoZSBmaXJz
dCB0aW1lIGhhcyBuZXZlciBiZWVuIHN3aXRjaGVkIGZyb20sIHNvDQo+IGF0dGVtcHRpbmcg
dG8gcmVzdW1lIGxhenkgTU1VIG1vZGUgY2FuIHdyYXAtYXJvdW5kICh1bmRlcmZsb3cpIHRo
ZQ0KPiBwYXVzZV9jb3VudCBmcm9tIDAgdG8gMjU1IChVOF9NQVgpLg0KPiANCj4gRnVydGhl
cm1vcmUsIHRoZSBub24temVybyBwYXVzZV9jb3VudCBpcyBjb3BpZWQgdG8gY2hpbGQgdGFz
a3MgYXQgZm9yaywNCj4gc28gYWxsIGRlc2NlbmRhbnRzIChpbmNsdWRpbmcgdGhlIGlkbGUg
dGFza3Mgb2YgdGhlIG5vbi1ib290IENQVXMpDQo+IGluaGVyaXQgdGhlIG5vbi16ZXJvIHBh
dXNlX2NvdW50LiBUaGlzIHByZXZlbnRzIGVuYWJsaW5nIGxhenkgTU1VIG1vZGUNCj4gZm9y
IHRoZW0sIGJlY2F1c2UgbGF6eV9tbXVfbW9kZV9lbmFibGUoKSBkb2VzIG5vdCBkbyBhbnl0
aGluZyB3aGVuDQo+IHBhdXNlX2NvdW50IGlzIG5vbi16ZXJvLg0KPiANCj4gSGVuY2UsIGNh
bGwgX190YXNrX2xhenlfbW11X21vZGVfcmVzdW1lKCkgZnJvbSB4ZW5fZW5kX2NvbnRleHRf
c3dpdGNoKCkNCj4gb25seSBpZiBsYXp5IE1NVSBtb2RlIHdhcyBwYXVzZWQuDQo+IA0KPiBU
aGlzIGlzc3VlIHdhcyBkaXNjb3ZlcmVkIHdpdGggQ09ORklHX0RFQlVHX1ZNPXksIHdoaWNo
IGVuYWJsZXMNCj4gcGF1c2VfY291bnQgdW5kZXJmbG93IGFuZCBvdmVyZmxvdyB3YXJuaW5n
cy4gSW4gdGhlIGV4YW1wbGVzIHF1b3RlZA0KPiBiZWxvdywgdGhlIGZpcnN0IHdhcm5pbmcg
c2hvd3MgdGhlIHVuZGVyZmxvdyB3aXRoIFBJRCAxLiBUaGUgc2Vjb25kDQo+IHdhcm5pbmcg
c2hvd3MgdGhlIG92ZXJmbG93IGZyb20gMjU1IChVOF9NQVgpIHRvIDAsIGFsc28gZm9yIFBJ
RCAxLCBhcw0KPiBpbmRpY2F0ZWQgYnkgdGhlIHNhbWUgUkRJIHJlZ2lzdGVyIHZhbHVlLg0K
PiANCj4gRXhhbXBsZSBwYXVzZV9jb3VudCB1bmRlcmZsb3cgd2FybmluZzoNCj4gDQo+ICAg
IFdBUk5JTkc6IGluY2x1ZGUvbGludXgvcGd0YWJsZS5oOjM2MiBhdCB4ZW5fZW5kX2NvbnRl
eHRfc3dpdGNoKzB4NGUvMHg2MCwgQ1BVIzA6IHN3YXBwZXIvMC8wDQo+ICAgIENQVTogMCBV
SUQ6IDAgUElEOiAwIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA3LjIuNC0xICMyIFBS
RUVNUFQoZnVsbCkNCj4gICAgUklQOiBlMDMwOnhlbl9lbmRfY29udGV4dF9zd2l0Y2grMHg0
ZS8weDYwDQo+ICAgIC4uLg0KPiAgICBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAw
MDAwMDAwMDAwMDAwIFJESTogZmZmZjg4ODAwNDkzMDAwMA0KPiANCj4gTm90ZTogVGhlIFBJ
RCBpcyBzaG93biBhcyAwIGFib3ZlLCBiZWNhdXNlIGN1cnJlbnRfdGFzayBpcyB1cGRhdGVk
IGluDQo+IF9fc3dpdGNoX3RvKCkgYWZ0ZXIgYXJjaF9lbmRfY29udGV4dF9zd2l0Y2goKS4g
YXJjaF9lbmRfY29udGV4dF9zd2l0Y2goKQ0KPiBjYWxscyB4ZW5fZW5kX2NvbnRleHRfc3dp
dGNoKCkgaW5kaXJlY3RseS4NCj4gDQo+IEV4YW1wbGUgcGF1c2VfY291bnQgb3ZlcmZsb3cg
d2FybmluZzoNCj4gDQo+ICAgIFdBUk5JTkc6IGluY2x1ZGUvbGludXgvcGd0YWJsZS5oOjMx
OSBhdCB4ZW5fc3RhcnRfY29udGV4dF9zd2l0Y2grMHg2NC8weDcwLCBDUFUjMDogc3dhcHBl
ci8wLzENCj4gICAgQ1BVOiAwIFVJRDogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIFRhaW50
ZWQ6IEcgICAgICAgIFcgIDcuMi40LTEgIzIgUFJFRU1QVChmdWxsKQ0KPiAgICAuLi4NCj4g
ICAgUklQOiBlMDMwOnhlbl9zdGFydF9jb250ZXh0X3N3aXRjaCsweDY0LzB4NzANCj4gICAg
Li4uDQo+ICAgIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMTNmNzg5NGQg
UkRJOiBmZmZmODg4MDA0OTMwMDAwDQo+ICAgIC4uLg0KPiAgICBDYWxsIFRyYWNlOg0KPiAg
ICAgPFRBU0s+DQo+ICAgICBfX3NjaGVkdWxlKzB4MzZhLzB4MWE5MA0KPiAgICAgc2NoZWR1
bGUrMHgyNy8weGEwDQo+ICAgICBzY2hlZHVsZV90aW1lb3V0KzB4YmQvMHgxMDANCj4gICAg
IF9fd2FpdF9mb3JfY29tbW9uKzB4OTcvMHgxYjANCj4gICAgIHdhaXRfZm9yX2NvbXBsZXRp
b25fa2lsbGFibGUrMHgyNC8weDQwDQo+ICAgICBfX2t0aHJlYWRfY3JlYXRlX29uX25vZGUr
MHgxM2UvMHgyNDANCj4gICAgIGt0aHJlYWRfY3JlYXRlX3dvcmtlcl9vbl9ub2RlKzB4ZWUv
MHgxYzANCj4gICAgIHdvcmtxdWV1ZV9pbml0KzB4MjYvMHg0MjANCj4gICAgIGtlcm5lbF9p
bml0X2ZyZWVhYmxlKzB4MTAxLzB4MzYwDQo+ICAgICBrZXJuZWxfaW5pdCsweDFhLzB4MTMw
DQo+ICAgICByZXRfZnJvbV9mb3JrKzB4MmIwLzB4MzQwDQo+ICAgICByZXRfZnJvbV9mb3Jr
X2FzbSsweDFhLzB4MzANCj4gICAgIDwvVEFTSz4NCj4gDQo+IEZpeGVzOiBiZWM2ZjQxYTZm
ZTUgKCJ4ODYveGVuOiBHZXQgcmlkIG9mIGxhc3QgWEVOX0xBWllfTU1VIHVzZXMiKQ0KPiBD
Yzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDcuMi54DQo+IFNpZ25lZC1vZmYtYnk6IE0u
IFZlZmEgQmljYWtjaSA8bS52LmJAcnVuYm94LmNvbT4NCj4gLS0tDQo+ID09PSBUZXN0aW5n
IG5vdGVzID09PQ0KPiBUaGlzIGNvbW1pdCB3YXMgdGVzdGVkIHdpdGgga2VybmVsIHY3LjMt
MTY3NTUtZ2QxMzVhYjQ1M2E3NCBhbmQgdjcuNC1yYzENCj4gd2l0aCBhIGRvbVUgUFYgVk0s
IGFuZCB2ZXJzaW9ucyBmcm9tIHY3LjIuNCB0byB2Ny4yLjE0IHdpdGggZG9tMCBhbmQNCj4g
ZG9tVSBQViBWTXMgcnVubmluZyBvbiBYZW4gdjQuMTkuNS4gQ09ORklHX0RFQlVHX1ZNPXkg
d2FzIHNldCBmb3IgYWxsDQo+IHRlc3RzLCBhbmQgbm8gd2FybmluZ3Mgd2VyZSBvYnNlcnZl
ZC4NCj4gDQo+ID09PSBEZWJ1Z2dpbmcgbm90ZXMgPT09DQo+IEZvciBkZWJ1Z2dpbmcsIEkg
aW5zdHJ1bWVudGVkIHhlbl9zdGFydF9jb250ZXh0X3N3aXRjaCgpLA0KPiB4ZW5fZW5kX2Nv
bnRleHRfc3dpdGNoKCkgYW5kIGNvcHlfcHJvY2VzcygpLCBhbmQgSSBjb25maXJtZWQgdGhh
dCB0aGUNCj4gaW5oZXJpdGVkIHBhdXNlX2NvdW50IHZhbHVlIGlzIGRlY3JlbWVudGVkIGZv
ciBlYWNoIGxldmVsIG9mIHRoZSBwcm9jZXNzDQo+IHRyZWUsIHN0YXJ0aW5nIGZyb20gMjU1
Lg0KPiANCj4gPT09IENyZWRpdHMgPT09DQo+IFRoZSBwYXRjaCB3YXMgaGFuZC13cml0dGVu
LCBidXQgdGhlIGNvbW1pdCBtZXNzYWdlIHdhcyBwb2xpc2hlZCB3aXRoIGENCj4gZmV3IHJv
dW5kcyBvZiBMTE0gcmV2aWV3Lg0KPiAtLS0NCj4gICBhcmNoL3g4Ni94ZW4vZW5saWdodGVu
X3B2LmMgfCAxMCArKysrKysrKystDQo+ICAgaW5jbHVkZS9saW51eC9zY2hlZC5oICAgICAg
IHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L3hlbi9lbmxpZ2h0ZW5fcHYuYyBiL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYw0KPiBp
bmRleCBjNTExN2E3NzMwZDYuLjY4ZjhhOTc3OTk5YiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94
ODYveGVuL2VubGlnaHRlbl9wdi5jDQo+ICsrKyBiL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5f
cHYuYw0KPiBAQCAtNDMxLDcgKzQzMSwxNSBAQCBzdGF0aWMgdm9pZCB4ZW5fZW5kX2NvbnRl
eHRfc3dpdGNoKHN0cnVjdCB0YXNrX3N0cnVjdCAqbmV4dCkNCj4gICANCj4gICAJeGVuX21j
X2ZsdXNoKCk7DQo+ICAgCXRoaXNfY3B1X3dyaXRlKHhlbl9jcHVfbGF6eV9tb2RlLCBmYWxz
ZSk7DQo+IC0JX190YXNrX2xhenlfbW11X21vZGVfcmVzdW1lKG5leHQpOw0KPiArDQo+ICsJ
LyoNCj4gKwkgKiBBIG5ld2x5IGNyZWF0ZWQgdGFzayBjYW4gYmUgc3dpdGNoZWQgdG8gd2l0
aG91dCBldmVyIGhhdmluZyBiZWVuDQo+ICsJICogc3dpdGNoZWQgZnJvbSwgc28gaXQgd2ls
bCBub3QgaGF2ZSBhIHByaW9yIGxhenkgTU1VIHBhdXNlIHRvIHVuZG8NCj4gKwkgKiBmcm9t
IHhlbl9zdGFydF9jb250ZXh0X3N3aXRjaCgpLiBIZW5jZSwgcmVzdW1lIGxhenkgTU1VIG9u
bHkgaWYgaXQNCj4gKwkgKiB3YXMgcGF1c2VkLg0KPiArCSAqLw0KPiArCWlmIChfX3Rhc2tf
bGF6eV9tbXVfbW9kZV9wYXVzZWQobmV4dCkpDQo+ICsJCV9fdGFza19sYXp5X21tdV9tb2Rl
X3Jlc3VtZShuZXh0KTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHVuc2lnbmVkIGxvbmcg
eGVuX3N0b3JlX3RyKHZvaWQpDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjaGVk
LmggYi9pbmNsdWRlL2xpbnV4L3NjaGVkLmgNCj4gaW5kZXggMWM5M2RhNzUyMjZlLi4zZjkz
NDFmMWY4MjcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc2NoZWQuaA0KPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3NjaGVkLmgNCj4gQEAgLTE3OTEsNiArMTc5MSwyNSBAQCBzdGF0
aWMgaW5saW5lIGJvb2wgaXNfbGF6eV9tbXVfbW9kZV9hY3RpdmUodm9pZCkNCj4gICANCj4g
ICAJcmV0dXJuIF9fdGFza19sYXp5X21tdV9tb2RlX2FjdGl2ZShjdXJyZW50KTsNCj4gICB9
DQo+ICsNCj4gKy8qKg0KPiArICogX190YXNrX2xhenlfbW11X21vZGVfcGF1c2VkKCkgLSBS
ZXR1cm4gYSB0YXNrJ3MgbGF6eSBNTVUgbW9kZSBwYXVzZSBzdGF0ZQ0KPiArICogQHRzazog
VGhlIHRhc2sgdG8gY2hlY2suDQo+ICsgKg0KPiArICogVGVzdCB3aGV0aGVyIEB0c2sgaGFz
IGl0cyBsYXp5IE1NVSBtb2RlIHN0YXRlIHNldCB0byBwYXVzZWQNCj4gKyAqIChpLmUuLCBw
YXVzZV9jb3VudCA+IDApLg0KPiArICoNCj4gKyAqIFRoaXMgZnVuY3Rpb24gaXMgaW50ZW5k
ZWQgZm9yIGFyY2hpdGVjdHVyZXMgdGhhdCBpbXBsZW1lbnQgdGhlIGxhenkgTU1VDQo+ICsg
KiBtb2RlOyBpdCBtdXN0IG5vdCBiZSBjYWxsZWQgZnJvbSBnZW5lcmljIGNvZGUuDQo+ICsg
Kg0KPiArICogUmV0dXJuOiBXaGV0aGVyIHRhc2sgQHRzayBoYXMgcGF1c2VkIGxhenkgTU1V
IG1vZGUuDQo+ICsgKi8NCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBfX3Rhc2tfbGF6eV9tbXVf
bW9kZV9wYXVzZWQoc3RydWN0IHRhc2tfc3RydWN0ICp0c2spDQo+ICt7DQo+ICsJc3RydWN0
IGxhenlfbW11X3N0YXRlICpzdGF0ZSA9ICZ0c2stPmxhenlfbW11X3N0YXRlOw0KPiArDQo+
ICsJcmV0dXJuIHN0YXRlLT5wYXVzZV9jb3VudCA+IDA7DQo+ICt9DQo+ICAgI2VuZGlmDQo+
ICAgDQo+ICAgZXh0ZXJuIHN0cnVjdCBwaWQgX19yY3UgKmNhZF9waWQ7DQpUaGFua3MgZm9y
IGZpbmRpbmcgdGhpcyBpc3N1ZS4NCg0KV2hpbGUgeW91ciBwYXRjaCBpcyBmaXhpbmcgdGhl
IHByb2JsZW0sIEknZCBwcmVmZXIgZml4aW5nIHRoZSByb290IGNhdXNlOg0KV2hlbiBzZXR0
aW5nIHVwIGEgbmV3IHN0cnVjdCB0YXNrX3N0cnVjdCwgdGhlIGluaXRpYWwgbGF6eV9tbXVf
c3RhdGUgc3RhdGUNCnNob3VsZCBiZSBpbml0aWFsaXplZCBhY2NvcmRpbmdseS4gVGhpcyB3
b3VsZCByZXF1aXJlIGFub3RoZXIgbGF6eV9tbXVfc3RhdGUNCmhvb2sgZm9yIGluaXRpYWxp
emluZyBpdCwgcHJvYmFibHkgdmlhIGEgc2ltcGxlIHN0YXRpY19jYWxsKCkuIFhlbiBjb3Vs
ZCB1c2UNCnRoYXQgZm9yIHNldHRpbmcgdGhlIHBhdXNlIGNvdW50IHRvIDEuDQoNCkF0IHRo
ZSBzYW1lIHRpbWUgX190YXNrX2xhenlfbW11X21vZGVfcmVzdW1lKCkgc2hvdWxkIHByb2Jh
Ymx5IFdBUk4oKSBpZg0KdGhlIHBhdXNlIGNvdW50IGlzIDAgYWxyZWFkeSBhbmQgTk9UIGRl
Y3JlbWVudCB0aGUgcGF1c2UgY291bnQuDQoNClRob3VnaHRzPw0KDQoNCkp1ZXJnZW4NCg==


--------------pqceB7wYf1PbgMBK47JtVF9K--

--------------LygJjHqW8pY12708uQxPxyDh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmrxlPYFAwAAAAAACgkQsN6d1ii/Ey+C
zAf+IuacIwk33LXPHoftfl7snVFyN5Q7BMLR80TJosfJZAumOx5J3AyjNQu2O1WQxt/3Ln2BQ2w/
0KFPi4ykhbUH2r6J3WJ7QlyrfhtgUn6ED8/blt8W6GEbQajKxPdp3pvJenl6o93Ll1Hpy/djSsqQ
V+juNZCZkIoypPtTBmsm2qic3GJD+50UNFTdwphguouL2OnVNxvsPjoaNafzxG5Ju+YAxkgNdGVI
+ZYKUJ33e7XjHsRXpPxspelM716xKXvCFxSBA+fY6rgJnY045p/tELoCX3rcy2dqK0oeh7fP2np8
JEVcmwXk3pSiCBNK/AK3HPqNn/uB9sVXrosM7y1msg==
=TfXG
-----END PGP SIGNATURE-----

--------------LygJjHqW8pY12708uQxPxyDh--
