Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780418;
	b=vXnQP8/6px3R8yCGlSswSOfT9YCcjUVj/dklE0YgYfDM7ZCDchsgc74QTR68jsssj5tJ
	 E2XwLM0RLfmx7x1WHNy7N5Nw+hFx/8x4td3Kfl4UxQdkP5RdgMG2dXACLcJUzWMZvy/Zr
	 /xAYO/Ss8ztfrhB4Lyh7inCnVEw5Q2YO2HtTDGhNsiIrPXOsXfANTWRR1Kca7uDzlcc+h
	 BR2piJM4BSTwoF5CCFfVtq1a2hNyvb13VYRCwKRbX4NHbQGrsdRD1B24buk8/E2EWgeZi
	 wv0Y6WYJKnH2TiPuEqbmzDrUt/mudWCvxkjN2kmtpdldiQ8R/eywjmzZQWUtThNZ/Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780418;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=SBs5ngltfceoGz65CnfqU4ni/SkBXbisTdH2AJEoDqw=;
	b=yvpZn3rF2gCrxtTJfSeRBoYRrMlnUAtANqZ5pYC+pbooj0m0O3IwIFiJJBRo5uJvPjRi
	 gMtuY5Cyg+7XEwXwPhjfSmu62V0JScffZMCcuycasmbk4c5sRqvulQk8kMwBnFv6CxSmT
	 Q6a7t0WwD7Ye62H/+gFW7z/K/tCHbHsgpGz5Yu1xLSuRUnNB+64g02Cfmn15jD866lnrO
	 G7NilD9qjLKvjEyZCrClZRG74oSlh4rgy0xuTUso2eMdhCz2pk3pOuwDdTsbVmY7xSTnM
	 kCCFFTcYJf1QCZN55oCpsELTDkQ24N2C/htXMN2qYFcSYPYiZbZPlNRA+IrHcb5ouDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=eXIA9Z1v;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=eXIA9Z1v;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CAD606A32C;
	Wed,  4 Nov 2026 08:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9CAD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=eXIA9Z1v;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=eXIA9Z1v
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BD87321F36;
	Wed,  4 Nov 2026 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1793780415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SBs5ngltfceoGz65CnfqU4ni/SkBXbisTdH2AJEoDqw=;
	b=eXIA9Z1vNflgGIOD5PkcOdSYo7dHNT3ZabQ8geK1s2F/ydy0f/2FauA1E/q6xI/G4tZyCD
	hawq/AZcyJTCwHO50k9qt0L16WZYMLIFXjQjBvzvVyyI73gPknSCO1+pjFnwMyy3uAnB33
	nDaHGRkE17aD+t1GHtIKDO3ztODie7c=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1793780415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SBs5ngltfceoGz65CnfqU4ni/SkBXbisTdH2AJEoDqw=;
	b=eXIA9Z1vNflgGIOD5PkcOdSYo7dHNT3ZabQ8geK1s2F/ydy0f/2FauA1E/q6xI/G4tZyCD
	hawq/AZcyJTCwHO50k9qt0L16WZYMLIFXjQjBvzvVyyI73gPknSCO1+pjFnwMyy3uAnB33
	nDaHGRkE17aD+t1GHtIKDO3ztODie7c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D980134F0;
	Wed,  4 Nov 2026 08:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8rhoBb/q6mp9bgAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 04 Nov 2026 08:20:15 +0000
Message-ID: <d6d14b59-66a2-4a1d-ba57-15b86412ed1b@suse.com>
Date: Wed, 4 Nov 2026 09:20:14 +0100
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
Subject: Re: [PATCH] x86/CPU/AMD: Don't print reset reason in VMs
To: Jason Andryuk <jason.andryuk@amd.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Cc: xen-devel@lists.xenproject.org, Ariadne Conill <ariadne@ariadne.space>,
 Sean Christopherson <seanjc@google.com>, stable@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
References: <20261104013026.185392-1-jason.andryuk@amd.com>
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
In-Reply-To: <20261104013026.185392-1-jason.andryuk@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LKuNJD8fzNHF2QkAVsWACpJT"
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-9.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	NEURAL_SPAM_LONG(3.49)[0.998];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -9.80

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------LKuNJD8fzNHF2QkAVsWACpJT
Content-Type: multipart/mixed; boundary="------------aF0OXbWKlvGAtnWy4QKg8fQK";
 protected-headers="v1"; hp="clear"
Message-ID: <d6d14b59-66a2-4a1d-ba57-15b86412ed1b@suse.com>
Date: Wed, 4 Nov 2026 09:20:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/CPU/AMD: Don't print reset reason in VMs
To: Jason Andryuk <jason.andryuk@amd.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Cc: xen-devel@lists.xenproject.org, Ariadne Conill <ariadne@ariadne.space>,
 Sean Christopherson <seanjc@google.com>, stable@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
References: <20261104013026.185392-1-jason.andryuk@amd.com>
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
In-Reply-To: <20261104013026.185392-1-jason.andryuk@amd.com>

--------------aF0OXbWKlvGAtnWy4QKg8fQK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMTEuMjYgMDI6MzAsIEphc29uIEFuZHJ5dWsgd3JvdGU6DQo+IHByaW50X3M1X3Jl
c2V0X3N0YXR1c19tbWlvKCkgZXhwZWN0cyB0byByZWFkIEZDSCBNTUlPIG9uIGJhcmVtZXRh
bC4gIFZNcw0KPiBkb24ndCBoYXZlIGVtdWxhdGVkIEZDSCByZWdpc3RlcnMsIHNvIHRoZXJl
IGlzIG5vdGhpbmcgdG8gY2hlY2suICBBZGQgYW4NCj4gZWFybHkgZXhpdCB3aGVuIHJ1bm5p
bmcgb24gYSBoeXBlcnZpc29yLg0KPiANCj4gVGhlIHJlYWwgbW90aXZhdGlvbiBpcyBYZW4g
UFYgZG9tVXMgY2FuJ3QgYm9vdCBvbiBaZW4gQ1BVcy4gIFBWIGRvbVVzDQo+IFBURSBjb250
YWluIHN5c3RlbSBwaHlzaWNhbCBhZGRyZXNzZXMgLSB0aGV5IGRvbid0IGhhdmUgY29uY2Vw
dCBvZiBndWVzdA0KPiBwaHlzaWNhbCBhZGRyZXNzZXMuICBkb21VcyBjYW4gb25seSBtYXAg
cGh5c2ljYWwgYWRkcmVzc2VzIHRoZXkgYXJlDQo+IGFzc2lnbmVkLCBzbyBhIGRvbVUgZmFp
bHMgdG8gbWFwIHRoZSBGQ0ggTU1JTyBhZGRyZXNzZXMuICBIb3dldmVyDQo+IHNldF9wdGUo
KSBkb2VzIG5vdCByZXR1cm4gZmFpbHVyZSwgc28gaW9yZW1hcCgpIHJldHVybnMgYSBwb2lu
dGVyIHdoaWxlDQo+IHRoZSBQVEVzIGFyZSB1bnBvcHVsYXRlZC4gIHByaW50X3M1X3Jlc2V0
X3N0YXR1c19tbWlvKCkgZmF1bHRzIHdoZW4NCj4gcmVhZGluZyB0aHJvdWdoIHRoZSBwb2lu
dGVyLCBicmVha2luZyB0aGUgYm9vdC4gIFRoaXMgY2hhbmdlIGZpeGVzIFhlbg0KPiBQViBk
b21VcyBib290aW5nIG9uIFplbiBDUFVzLg0KPiANCj4gZG9tMCBjYW4gbWFwIHRoZSBGQ0gg
TU1JTywgYnV0IGl0IGhhcyBYODZfRkVBVFVSRV9IWVBFUlZJU09SIHNldC4gIFdpdGgNCj4g
dGhpcyBjaGFuZ2UsIGl0IG5vIGxvbmdlciBwcmludHMgdGhlIHJlc2V0IHJlYXNvbi4NCj4g
DQo+IEZpeGVzOiBhYjgxMzEwMjg3MTAgKCJ4ODYvQ1BVL0FNRDogUHJpbnQgdGhlIHJlYXNv
biBmb3IgdGhlIGxhc3QgcmVzZXQiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
PiBTdWdnZXN0ZWQtYnk6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKYXNvbiBBbmRyeXVrIDxqYXNvbi5hbmRyeXVrQGFtZC5jb20+DQpSZXZp
ZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4N
Cg==

--------------aF0OXbWKlvGAtnWy4QKg8fQK--

--------------LKuNJD8fzNHF2QkAVsWACpJT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmrq6r4FAwAAAAAACgkQsN6d1ii/Ey+X
Ngf+NSERpLNaHp3iNP/+G4bYmYAUbmiwYtU4yyLTSMiNx1rDMcPEAKSlzfKJxhvL400QiamrqdMU
eQQgp+A1yz3WYp+7q5AIf7XFq9uNjXAxknysZorXcaTYdi0X3OgAmyGClfHbBQ/d9FMqh1WYoFFE
cv3Nd25TdM5PXq5WVLrK565FnrgBHJB/b6AgX+kQGHQpy5qFvEEC1eOP+mGim9KZrMIibKgLoztb
tJaE0SFruiJehG/ueh6qSaEIKYl3KUSzNq7k2Czn/o5H83dE6eQ79k+YszaQkRDJXepCumXqmYD9
E3DBL8fcA5OvWQVs6B6+AWbWMqkfE9MWSB0a8W88Zw==
=Os7j
-----END PGP SIGNATURE-----

--------------LKuNJD8fzNHF2QkAVsWACpJT--
