Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5134973B6;
	Thu,  8 Oct 2026 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456146; cv=none; b=qNWY9KN+mqeM64jlNe+LBbBFUiGG1YqHUhzSG0y4m9ZeXCyTLijdOPwcJv0ZUNlrWosZp1RZiDCdmxl8O0uJjymyFglkSiGSwZPC5YKzmhDZFygGZmVKe9Uc+xA5WPphKeF+vjw0/QLyT7DEfVeaqp3dRguzEwHhqkFUkiAmkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456146; c=relaxed/simple;
	bh=eoI1FEozjJg4EnkzMM5yYgPekd5qbolFDYT/6/hc/tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHx6Q5NkSpQVIja3OvkAXjjEkCrbDbMuBOjJQ5ALOxbjPDBOk+iYlOa5fHVMnt3fLqziebSBQH+HPkK67jhz7AyAGfOB/NkW3w7JcJREoKSQSdBKTL6+sCrn5TuOfIRR7EMCL/rTy9iNINLceMt+DQKIChT63HWQ4tdjWxgoCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RLup9rsk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RLup9rsk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RLup9rsk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RLup9rsk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 962E221C1A;
	Thu,  8 Oct 2026 10:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1791456142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eoI1FEozjJg4EnkzMM5yYgPekd5qbolFDYT/6/hc/tw=;
	b=RLup9rskSabgbEvEvLb4y/0leudSkl7gJTPZdiW4iDeMA2+KG/i9Ili8X/loqDFOy1Zi9B
	c4ycpQh4TiJgQ2QzhgvZOEMIOpC05akErgLkjJIjtBsqrxlB4SgY4O4LOKZqzl2nCqH+Uj
	zWJFBpwnu8mYI+JWe7iSkv3T8R0CC10=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1791456142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eoI1FEozjJg4EnkzMM5yYgPekd5qbolFDYT/6/hc/tw=;
	b=RLup9rskSabgbEvEvLb4y/0leudSkl7gJTPZdiW4iDeMA2+KG/i9Ili8X/loqDFOy1Zi9B
	c4ycpQh4TiJgQ2QzhgvZOEMIOpC05akErgLkjJIjtBsqrxlB4SgY4O4LOKZqzl2nCqH+Uj
	zWJFBpwnu8mYI+JWe7iSkv3T8R0CC10=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CA621339F;
	Thu,  8 Oct 2026 10:42:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W4/EOo1zx2oVTwAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 08 Oct 2026 10:42:22 +0000
Message-ID: <4d97500e-a489-4e64-aa11-29c3430909f3@suse.com>
Date: Thu, 8 Oct 2026 12:42:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p/xen: drain response work after unbinding IRQ
To: Dominique Martinet <asmadeus@codewreck.org>,
 Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>,
 Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>,
 Ke Xu <xuke@tsinghua.edu.cn>, Stefano Stabellini <sstabellini@kernel.org>
References: <20260609155202.1706-1-zhaoyz24@mails.tsinghua.edu.cn>
 <aqagvTnrIOGl8nfi@codewreck.org>
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
In-Reply-To: <aqagvTnrIOGl8nfi@codewreck.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------l8KNOMf2PfPTKuamRy9w54Mo"
X-Spam-Flag: NO
X-Spam-Score: -2.62
X-Spam-Level: 
X-Spamd-Result: default: False [-2.62 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_LONG(2.56)[0.731];
	SIGNED_PGP(-2.00)[];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.19)[-0.970];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MIME_BASE64_TEXT(0.10)[];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[126.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,ionkov.net,crudebyte.com,vger.kernel.org,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	HAS_ATTACHMENT(0.00)[]

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------l8KNOMf2PfPTKuamRy9w54Mo
Content-Type: multipart/mixed; boundary="------------gVcOBNeZMJ3pK29BomJKytZ9";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
 Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>,
 Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>,
 Ke Xu <xuke@tsinghua.edu.cn>, Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <4d97500e-a489-4e64-aa11-29c3430909f3@suse.com>
Subject: Re: [PATCH] 9p/xen: drain response work after unbinding IRQ
References: <20260609155202.1706-1-zhaoyz24@mails.tsinghua.edu.cn>
 <aqagvTnrIOGl8nfi@codewreck.org>
In-Reply-To: <aqagvTnrIOGl8nfi@codewreck.org>

--------------gVcOBNeZMJ3pK29BomJKytZ9
Content-Type: multipart/mixed; boundary="------------fTMD43gl6ZYvBy00XAlzVJyI"

--------------fTMD43gl6ZYvBy00XAlzVJyI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDkuMjYgMTU6MTAsIERvbWluaXF1ZSBNYXJ0aW5ldCB3cm90ZToNCj4gWWl6aG91
IFpoYW8gd3JvdGUgb24gVHVlLCBKdW4gMDksIDIwMjYgYXQgMTE6NTI6MDFQTSArMDgwMDoN
Cj4+IGNvbW1pdCBlYTRmMTAwOTQwOGUgKCI5cC94ZW4gOiBGaXggdXNlIGFmdGVyIGZyZWUg
YnVnIGluDQo+PiB4ZW5fOXBmc19mcm9udF9yZW1vdmUgZHVlIHRvIHJhY2UgY29uZGl0aW9u
IikgYWRkZWQgY2FuY2VsX3dvcmtfc3luYygpDQo+PiB0byBrZWVwIHhlbl85cGZzX2Zyb250
X2ZyZWUoKSBmcm9tIGZyZWVpbmcgYSByaW5nIHdoaWxlDQo+PiBwOV94ZW5fcmVzcG9uc2Uo
KSBpcyBzdGlsbCBydW5uaW5nLg0KPj4NCj4+IFRoZSB3b3JrIGlzIGN1cnJlbnRseSBkcmFp
bmVkIGJlZm9yZSB0aGUgZXZlbnQgY2hhbm5lbCBJUlEgaXMgdW5ib3VuZC4NCj4+IFRoYXQg
bGVhdmVzIGEgcmFjZSB3aW5kb3cgd2hlcmUgeGVuXzlwZnNfZnJvbnRfZXZlbnRfaGFuZGxl
cigpIGNhbiBydW4NCj4+IGFmdGVyIGNhbmNlbF93b3JrX3N5bmMoKSByZXR1cm5zIGFuZCBx
dWV1ZSBwOV94ZW5fcmVzcG9uc2UoKSBhZ2Fpbi4gIFRoZQ0KPj4gZm9sbG93aW5nIHVuYmlu
ZF9mcm9tX2lycWhhbmRsZXIoKSBzeW5jaHJvbml6ZXMgd2l0aCB0aGUgSVJRIGhhbmRsZXIs
IGJ1dA0KPj4gaXQgZG9lcyBub3QgY2FuY2VsIHdvcmsgdGhhdCB0aGUgaGFuZGxlciBhbHJl
YWR5IHF1ZXVlZC4gIFRoZSB0ZWFyZG93bg0KPj4gY2FuIHRoZW4gZnJlZSB0aGUgcmluZyBh
bmQgcHJpdmF0ZSBkYXRhIHdoaWxlIHRoZSByZXNwb25zZSB3b3JrIHJlbWFpbnMNCj4+IHBl
bmRpbmcsIGFuZCB0aGUgd29ya2VyIGxhdGVyIGRlcmVmZXJlbmNlcyByaW5nLT5wcml2IGFu
ZCBwcml2LT5jbGllbnQuDQo+Pg0KPj4gVW5iaW5kIHRoZSBldmVudCBjaGFubmVsIElSUSBi
ZWZvcmUgZHJhaW5pbmcgdGhlIHdvcmsuICBPbmNlIHRoZSBJUlEgaXMNCj4+IHVuYm91bmQs
IG5vIG5ldyByZXNwb25zZSB3b3JrIGNhbiBiZSBxdWV1ZWQgYnkgdGhlIGJhY2tlbmQgZXZl
bnQgY2hhbm5lbCwNCj4+IGFuZCBjYW5jZWxfd29ya19zeW5jKCkgd2FpdHMgZm9yIGFueSB3
b3JrIHRoYXQgd2FzIHF1ZXVlZCBiZWZvcmUgb3INCj4+IGR1cmluZyB0aGUgdW5iaW5kLiAg
SXQgaXMgdGhlbiBzYWZlIHRvIHJlbGVhc2UgdGhlIHJpbmcgcmVzb3VyY2VzLg0KPj4NCj4+
IEZpeGVzOiBlYTRmMTAwOTQwOGUgKCI5cC94ZW4gOiBGaXggdXNlIGFmdGVyIGZyZWUgYnVn
IGluIHhlbl85cGZzX2Zyb250X3JlbW92ZSBkdWUgdG8gcmFjZSBjb25kaXRpb24iKQ0KPj4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IFJlcG9ydGVkLWJ5OiBZaXpob3UgWmhh
byA8emhhb3l6MjRAbWFpbHMudHNpbmdodWEuZWR1LmNuPg0KPj4gUmVwb3J0ZWQtYnk6IFl1
eGlhbmcgWWFuZyA8eWFuZ3l4MjJAbWFpbHMudHNpbmdodWEuZWR1LmNuPg0KPj4gUmVwb3J0
ZWQtYnk6IEFvIFdhbmcgPHdhbmdhb0BzZXUuZWR1LmNuPg0KPj4gUmVwb3J0ZWQtYnk6IFh1
ZXdlaSBGZW5nIDxmZW5neHcwNkAxMjYuY29tPg0KPj4gUmVwb3J0ZWQtYnk6IFFpIExpIDxx
bGkwMUB0c2luZ2h1YS5lZHUuY24+DQo+PiBSZXBvcnRlZC1ieTogS2UgWHUgPHh1a2VAdHNp
bmdodWEuZWR1LmNuPg0KPj4gQXNzaXN0ZWQtYnk6IEdMTTpHTE0tNS4xDQo+PiBTaWduZWQt
b2ZmLWJ5OiBZaXpob3UgWmhhbyA8emhhb3l6MjRAbWFpbHMudHNpbmdodWEuZWR1LmNuPg0K
PiANCj4gVGhpcyBvbmUgbWFrZXMgc2Vuc2UgdG8gbWUgYW5kIEkndmUgcGlja2VkIGl0IHVw
LCBidXQgSSB0aGluaw0KPiAiOXAveGVuOiBmaXggdXNlLWFmdGVyLWZyZWUgaW4gcDlfeGVu
X3JlcXVlc3QiWzFdIGFkZGluZyBhIHJlZmNvdW50IHRvDQo+IHRoZSBmcm9udF9wcml2IGlz
IHRvbyBtdWNoIGNvbXBsZXhpdHkgdnMuIG15IHVuZGVyc3RhbmRpbmcgb2YgdGhlDQo+IGN1
cnJlbnQgdGhyZWF0IG1vZGVsIC0tIEkgY2FuIHBpY2sgaXQgdXAgaWYgc29tZW9tZSB3aG8g
dW5kZXJzdGFuZHMgeGVuDQo+IGJldHRlciB0aGFuIG1lIGhhcyBhIHByb3BlciBsb29rLg0K
PiANCj4gU3RlZmFubyBvciBKw7xyZ2VuIGlmIHlvdSBjYXJlIC8gaGF2ZSB0aW1lPw0KPiAN
Cj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjA1MjkxMDM0MTYuODEzNzgt
MS16aGFveXoyNEBtYWlscy50c2luZ2h1YS5lZHUuY24NCg0KSSB0aGluayBbMV0gc2hvdWxk
IGJlIHRha2VuLg0KDQpXZSB0cnkgdG8gaGFyZGVuIGZyb250ZW5kcyBhZ2FpbnN0IHBvdGVu
dGlhbGx5IG1hbGljaW91cyBiYWNrZW5kcyBydW5uaW5nDQppbiBhIGRyaXZlciBkb21haW4u
IFN1Y2ggYSBiYWNrZW5kIGNvdWxkIGNhdXNlIHRoZSBkZXZpY2UgdG8gYmUgcmVtb3ZlZCBv
bg0KdGhlIGZyb250ZW5kIHNpZGUsIHNvIHRoZSBhdHRhY2sgdmVjdG9yIGlzIHByZXNlbnQu
DQoNClRoZSBvbmx5IHJlYXNvbiB0aGlzIGRvZXNuJ3QgcXVhbGlmeSBhcyBhIFhlbiBzZWN1
cml0eSBpc3N1ZSBpcyB0aGF0IHRoZQ0KOXBmcyBmcm9udGVuZCBoYXNuJ3QgYmVlbiB5ZXQg
ZGVjbGFyZWQgdG8gYmUgc2VjdXJpdHkgc3VwcG9ydGVkIHJlZ2FyZGluZw0KYXR0YWNrcyBi
eSB0aGUgYmFja2VuZC4gSG9wZWZ1bGx5IHdlIHdpbGwgZ2V0IHRoZXJlLg0KDQoNCkp1ZXJn
ZW4NCg==
--------------fTMD43gl6ZYvBy00XAlzVJyI
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------fTMD43gl6ZYvBy00XAlzVJyI--

--------------gVcOBNeZMJ3pK29BomJKytZ9--

--------------l8KNOMf2PfPTKuamRy9w54Mo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmrHc40FAwAAAAAACgkQsN6d1ii/Ey+N
lAf7BC4ICeOCBge/EbgFuwV7/MOC+boPkx/R/Awse3NqkGgm1hEIYNj35ugamqZOmFELjpYC3FZF
/gZPziL2C4qH1mCXHQXu9P4vsZ0OeExGsfYK3Qqw/uED/UTbAZmzdY+0Bsowy3YweyUSY/rG3tb0
+OOtvUGvqNSdeWmQGZGjlfug7GaVh2xqrmlMwZ0bxadhlWuHRVtKejwcSXp2lL9fHLWnpJrL9Hr3
P99VqT6ZlFh+bSRQzATXNUoO9Ci2D22VkD9+lR4ieMyKfijehujtyxSnkCwCKbiNuAQSnONx+E4p
y05NrkZawfvCITgy7Mw6Sv7ImdLmS6jq981qGrZolg==
=fJBp
-----END PGP SIGNATURE-----

--------------l8KNOMf2PfPTKuamRy9w54Mo--
