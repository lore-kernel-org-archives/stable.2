Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=208.125.0.237
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284776;
	b=EOCgQQReJf1qQokuckFsA+GrNq3F1ELckWc0pk4yHli4QjSkpL8CutQy0tATM32cpPnh
	 aaRe0p/JUOZrrTwR58QqzGMhGt1DX8DUjoqZ/OjXnl8hhPU+cWsQbcfjJWzbpJMM2WtN/
	 E00rMz7XYo+Rv1PPtZJbug8BAoodQKDWgv8HmD7Cr+0Use0exdi+RAv0ujPfonHAm6Y02
	 GtFvbvpBPQYcmeT9dJH5EykefrUdk7QUgWulB+9cAqr97zZSl0wR7MZrDB9hYJjLqd6+Q
	 SwgfpwiDr9JA63cHm1NGbIbjOSgZGLrQUw09m23P+/W+kVehKno3dVxYPnjGdN7BPSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284776;
	h=DMARC-Filter:DKIM-Signature:X-MDAV-Result:X-MDAV-Processed:Received:
	 X-Spam-Processed:X-MDRemoteIP:X-MDHelo:X-MDArrival-Date:
	 X-MDOrigin-Country:X-Authenticated-Sender:X-Return-Path:
	 X-Envelope-From:X-MDaemon-Deliver-To:Message-ID:Date:MIME-Version:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:
	 Organization:Disposition-Notification-To:In-Reply-To:Content-Type:
	 X-MDCFSigsAdded;
	bh=sUz8PqRjzrgWoVHA9XKjkfqkpc4s0Qv8hYBYtIoFU2Y=;
	b=4YNKWgvgDzbXLQb/dg5Z3bRJ9sTBkrKz5lDkhsW7QV4r5HCb9hvGAeM2DJYlBEQLbIIk
	 nXWVG3vBzUwzsU36NV84JoYwebExWn4Frf0egzPTtl4gSfKR8LnCYmDzLRWSDZn5aWmTc
	 gdd7ZhQqmm5BpnPJn0kIUrGiD/CRZTLN7ak4NEsuq6MaJzMl2OEb7Ng17yXMuRu5YeD7Y
	 QDGr8ywbigdngKDUIma18MuncXsEX+kNmGt5cVTGzPSgzK2D5LwTznQsnlkbiSjeJaXN7
	 T9sWQSmPbRwlsb2P6f1z1S6nzB3ZNqVw92g6kmu/YO/8UzCPrWmpDVrtAvTB3DM5w+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auristor.com;
	spf=pass smtp.mailfrom=auristor.com;
	arc=none smtp.remote-ip=208.125.0.237
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89954606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89954606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=8765; t=1793284727;
	x=1793889527; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	Content-Language:Organization:Disposition-Notification-To:
	In-Reply-To:Content-Type; z=Received:=20from=20[IPV6=3A2603=3A70
	02=3A100=3A8400=3Aecbc=3Ac7b4=3A5760=3A8fe8]=20by=20auristor.com
	=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=2
	0PRO=20v26.5.1a)=20=0D=0A=09with=20ESMTPSA=20id=20md500100583141
	9.msg=3B=20Thu,=2029=20Oct=202026=2010=3A38=3A46=20-0400|Message
	-ID:=20<67b3fef9-254d-41c6-aa7c-47219189ff34@auristor.com>|Date:
	=20Thu,=2029=20Oct=202026=2010=3A39=3A19=20-0400|MIME-Version:=2
	01.0|User-Agent:=20Mozilla=20Thunderbird|From:=20Jeffrey=20E=20A
	ltman=20<jaltman@auristor.com>|Subject:=20Re=3A=20[PATCH=20net=2
	0v2=202/3]=20rxrpc=3A=20Fix=20counting=20of=20in-flight=20transm
	itted=0D=0A=20packets|To:=20Jakub=20Kicinski=20<kuba@kernel.org>
	|Cc:=20Paolo=20Abeni=20<pabeni@redhat.com>,=20netdev@vger.kernel
	.org,=0D=0A=20marc.dionne@auristor.com,=20davem@davemloft.net,=2
	0edumazet@google.com,=0D=0A=20horms@kernel.org,=20linux-afs@list
	s.infradead.org,=0D=0A=20linux-kernel@vger.kernel.org,=20stable@
	vger.kernel.org,=0D=0A=20netdev-bot+sashiko@kernel.org,=20dhowel
	ls@redhat.com|References:=20<20261020201258.290827-3-dhowells@re
	dhat.com>=0D=0A=20<179262720290.3135.1509720869529893686@kernel.
	org>=0D=0A=20<0f7f68bf-d02e-4bc5-accf-5f89a599d37f@redhat.com>=0
	D=0A=20<20261028153510.2c0b0f23@kernel.org>|Content-Language:=20
	en-US|Organization:=20AuriStor,=20Inc.|Disposition-Notification-
	To:=20Jeffrey=20E=20Altman=20<jaltman@auristor.com>|In-Reply-To:
	=20<20261028153510.2c0b0f23@kernel.org>|Content-Type:=20multipar
	t/signed=3B=20protocol=3D"application/pkcs7-signature"=3B=20mica
	lg=3Dsha-256=3B=20boundary=3D"------------ms01050901080004000909
	0202"; bh=sUz8PqRjzrgWoVHA9XKjkfqkpc4s0Qv8hYBYtIoFU2Y=; b=uPC4ke
	8Al4QuQOtL78hQfHFxN1p4E1V6kyUBBbmO2jr4AmD6VbdGbSfy83dX1T0CZ1p1lC
	/9AlRxYuKLZ8UDqTuuN688tzc1YLWVTjy64+5RX9PsWyrKSGN8/KurmzIi5j3mP4
	WTKWn+YtDgp3RNLfi+Dyo1SJEDg0qUc1ChG3A=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Thu, 29 Oct 2026 10:38:47 -0400
Received: from [IPV6:2603:7002:100:8400:ecbc:c7b4:5760:8fe8] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v26.5.1a) 
	with ESMTPSA id md5001005831419.msg; Thu, 29 Oct 2026 10:38:46 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Thu, 29 Oct 2026 10:38:46 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7002:100:8400:ecbc:c7b4:5760:8fe8
X-MDHelo: [IPV6:2603:7002:100:8400:ecbc:c7b4:5760:8fe8]
X-MDArrival-Date: Thu, 29 Oct 2026 10:38:46 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1762367e3e=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Message-ID: <67b3fef9-254d-41c6-aa7c-47219189ff34@auristor.com>
Date: Thu, 29 Oct 2026 10:39:19 -0400
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
From: Jeffrey E Altman <jaltman@auristor.com>
Subject: Re: [PATCH net v2 2/3] rxrpc: Fix counting of in-flight transmitted
 packets
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 netdev-bot+sashiko@kernel.org, dhowells@redhat.com
References: <20261020201258.290827-3-dhowells@redhat.com>
 <179262720290.3135.1509720869529893686@kernel.org>
 <0f7f68bf-d02e-4bc5-accf-5f89a599d37f@redhat.com>
 <20261028153510.2c0b0f23@kernel.org>
Content-Language: en-US
Organization: AuriStor, Inc.
In-Reply-To: <20261028153510.2c0b0f23@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms010509010800040009090202"
X-MDCFSigsAdded: auristor.com

This is a cryptographically signed message in MIME format.

--------------ms010509010800040009090202
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAvMjgvMjAyNiA2OjM1IFBNLCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCg0KPiBPbiBU
dWUsIDI3IE9jdCAyMDI2IDEwOjA3OjE0ICswMTAwIFBhb2xvIEFiZW5pIHdyb3RlOg0KPj4g
T24gMTAvMjIvMjYgMDI6MDAsbmV0ZGV2LWJvdCtzYXNoaWtvQGtlcm5lbC5vcmcgd3JvdGU6
DQo+Pj4gVGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZp
ZXcgZm91bmQgMiBwb3RlbnRpYWwNCj4+PiBpc3N1ZShzKSB0byBjb25zaWRlci4NCj4+Pg0K
Pj4+IENyaXRpY2FsOiAwIMK3IEhpZ2g6IDAgwrcgTWVkaXVtOiAyIMK3IExvdzogMCAoMSkN
Cj4+Pg0KPj4+IElmIHlvdSBiZWxpZXZlIG5vbmUgb2YgdGhlIGlzc3VlcyBhcmUgbGVnaXRp
bWF0ZSwgcGxlYXNlIHJlcGx5IHRvIGVhY2gNCj4+PiBpc3N1ZSBvZiBNZWRpdW0gc2V2ZXJp
dHkgb3IgaGlnaGVyIGFuZCBleHBsYWluIHdoeSB0aGUgQUkgaXMgd3JvbmcuDQo+Pj4gSWYg
YW55IG9mIHRoZW0gYXJlIGxlZ2l0aW1hdGUgYW5kIHlvdSBwbGFuIHRvIHJlc3BpbiwgcGxl
YXNlIGxldCBwYXRjaHdvcmsNCj4+PiBrbm93IGJ5IGluY2x1ZGluZyAicHctYm90OiBjciIg
YXMgYSBzZXBhcmF0ZSBsaW5lIGF0IHRoZSBlbmQgb2YgeW91ciByZXBseQ0KPj4+IChvbmUg
c3VjaCByZXBseSBwZXIgc2VyaWVzIGlzIGVub3VnaCkuDQo+Pj4NCj4+PiAtIFtNZWRpdW1d
IEluY29tcGxldGUgaW4tZmxpZ2h0IGFjY291bnRpbmc6IGlmIGEgc2VnbWVudCB0aGF0IGlz
IGFscmVhZHkNCj4+PiAgICAgc29mdC1BQ0tlZCBnZXRzIHJldHJhbnNtaXR0ZWQsIGl0cyB0
cS0+aW5fZmxpZ2h0IGJpdCBpcyBzZXQgYWdhaW4gYW5k4oCmDQo+Pj4gLSBbTWVkaXVtXSBC
ZWhhdmlvdXIgY2hhbmdlIG9uIHNvZnQtQUNLIHJlbmVnaW5nIChBQ0stPk5BSyBmbGlwKS4N
Cj4+IEJhc2ljYWxseSBzYXNoaWtvIHNheXMgdGhhdCB0aGUgYWNjb3VudGluZyBsb29rcyBz
dGlsbCBub3QgcGVyZmVjdC4gSXMgbm90DQo+PiBjbGVhciB0byBtZSB0aGUgbmV3IHN0YXR1
cyBpcyBnb29kIGVub3VnaC4NCj4+DQo+PiBTaWRlIG5vdGVzOiBzYXNoaWtvIGNvbW1lbnRz
IG9uIHBhdGNoIDMvMyBhcmUgbm90IGJsb2NrZXJzLCBidXQgeW91IHNob3VsZA0KPj4gcmV2
aXNpdCB0aGUgY29tbWl0IG1lc3NhZ2UgaW4gY2FzZSBvZiBhIHJlcG9zdCAoYW5kIGRvIG5v
dCBpbmNsdWRlIHBhdGNoIDEvMywNCj4+IHBvc3Rwb25lZCB0byBuZXQtbmV4dCkuDQo+IERh
dmlkLCB0aGlzIHBvc3RpbmcgaXMgYWxtb3N0IDkgZGF5cyBvbGQgKHdoaWNoIGlzIGEgY3V0
IG9mZiBwb2ludCBmb3INCj4gc29tZSBvZiBvdXIgdHJhY2tlcnMpLiBDb3VsZCB5b3UgcGxl
YXNlIHJlc3BvbmQ/DQoNCkpha3ViLA0KDQpUaGUgc2FzaGlrbyBjb21tZW50cyBvbiBpbi1m
bGlnaHQgYWNjb3VudGluZyBhcmUgc3RpbGwgdW5kZXIgcmV2aWV3LsKgIA0KVGhlcmUgaXNu
J3QgYSBuZXcgcGF0Y2ggcmVhZHkgdG8gc3VibWl0IHlldC4NCg0KVGhhbmtzLg0KDQpKZWZm
cmV5IEFsdG1hbg0KDQoNCg==

--------------ms010509010800040009090202
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DTAwggY0MIIEHKADAgECAhBAAZimBAJ19t4m6OTgn3OxMA0GCSqGSIb3DQEBCwUAMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTE0
MB4XDTI1MDgxNDAwMzg1N1oXDTI3MTEwMTAwMzc1N1owgcwxKDAmBgNVBAUTH0EwMTQxMEMw
MDAwMDE5OEE2MDQwMjY3MDAxMEYyNjIxGTAXBgNVBGETEE5UUlVTK05ZLTM1ODIyMzcxFTAT
BgNVBAoTDEF1cmlTdG9yIEluYzEZMBcGA1UEAxMQSmVmZnJleSBFIEFsdG1hbjEPMA0GA1UE
BBMGQWx0bWFuMRAwDgYDVQQqEwdKZWZmcmV5MSMwIQYJKoZIhvcNAQkBFhRqYWx0bWFuQGF1
cmlzdG9yLmNvbTELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDKtXD1tqgXxlJvgI10FM0ZvyWukq2IeXgVhbgOk4k4PbRk1TvrGB04QatXac9soW7yHv6R
hoovQ+URaXBEpBYxOE8Tsx+XfKZNkGbWj9bEdWgi8HPb33rf8eKFuhjx1QEv/YtD7lGIp7Rh
KWC5kBfvyut8o3XJmJF0hCR1m663wsttrn89dwZczLU4JUjbTF0ukM0DbDk55ItDB4dXnW/u
RfhrVuemMvbDily+etLCWsuJjtrjRBCQ805eYRHq5LonX3oNLdXituSHXLKvq+uChgFN/veD
HKpeBnBWmoNtOQnV8fsq5NCz/WswIACeZj+xGmZsWx7fyuzee78ZePfBAgMBAAGjggGhMIIB
nTAMBgNVHRMBAf8EAjAAMA4GA1UdDwEB/wQEAwIE8DCBhAYIKwYBBQUHAQEEeDB2MDAGCCsG
AQUFBzABhiRodHRwOi8vY29tbWVyY2lhbC5vY3NwLmlkZW50cnVzdC5jb20wQgYIKwYBBQUH
MAKGNmh0dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20vY2VydHMvdHJ1c3RpZGNhYTE0
LnA3YzAfBgNVHSMEGDAWgBTC1ESZoHHPSFa+DI5oOFynt/dFvDAjBgNVHSAEHDAaMAkGB2eB
DAEFAwIwDQYLYIZIAYb5LwAGAgEwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL3ZhbGlkYXRp
b24uaWRlbnRydXN0LmNvbS9jcmwvdHJ1c3RpZGNhYTE0LmNybDAfBgNVHREEGDAWgRRqYWx0
bWFuQGF1cmlzdG9yLmNvbTAdBgNVHQ4EFgQUY4JHedU4owyskKPvw4gOjSyBJZUwKQYDVR0l
BCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3CgMMMA0GCSqGSIb3DQEBCwUAA4IC
AQCeOjCscMFctL6UG8WBsFMIOHc7MpbrX7EIvO34SGVKhrbqS1RTIBQiVVWnQ4VI6qVw/n9d
adUv4o1/F23s0uXE8/lGJAGn51kkw1xHU+0PGODOTWvAQOiPhSmaXG5xM4BgleroGggumd8f
HRSKFK7DIdWcMMNbS6LpMAOUfXYzNBvcHbAcjJMHQ7N8pNXdEQDB9c6yIw4paVD6XDE5VFhL
df6749jGqSWXpyTMjXzrPMaDyxKiNOtsUrdT/fh8+Xx84nGpwiV9PA9/cGSAPcAc/qMBgPb4
Qj9met/RUvCHPWr68Zlirgx48W/7TTZFhXKZg3U+zCj4ASOfLJ6WT4PPoM+eLHbB402WNMFk
QDmWBH4bMqUcbQWxarMxdQ/jHKTsJIkvg+rTCbWbDm7hgJbnPEZrJEghy69Opa9+F1HB90AQ
mb41N1PLZytu8pCGBJufyqjzNU0eyWkHJCwHDLFhoCENk/vujFCmsJUSh7a6ZMPSXf3PR4TP
Kkcgs9JBT0dyPGHEfC/Lp9ZHTGSO6zswK1BddBufYi3xqHNBO/s7ft6gpNvht7oKUhVcjM7E
mQCA6t2ok44PNfeG8rJZxiDv04IruCbzLFwkPczWS5uCIuP3PWCfVtMnUPDamMVWAr4Ui/s6
fy3TZbPUAPDjFRi7zpkFIKHlCS/HIHNR6Gr1lzCCBvQwggTcoAMCAQICEEABif/SaQvad8Lp
1U2SCE0wDQYJKoZIhvcNAQELBQAwSjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVz
dDEnMCUGA1UEAxMeSWRlblRydXN0IENvbW1lcmNpYWwgUm9vdCBDQSAxMB4XDTIzMDgxNjE5
Mjg0NloXDTMzMDgxMjE5Mjg0NVowOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVz
dDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTQwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
AoICAQDoqfW8senk2X/L7Viky0ZgZYnwlxqsE/vDQWARa1i7gZ0wRJ7ZOWIbjYDccsGFBhCb
8VLx1dershozyPcOizZ1LxAhstZhpz8KvKc4bHhu1+6ZJftmrDyAELLRu1gkPS0BvongGBin
xoTNo0XwafmS67jFRtYHe2VQSLvy0t9xRUsgdEeYgCUAnKO5eRVQMmBBNhnsTFtO5FzNmNKn
uw/TDcBbOpGrQ1FSCuOZTHw3njDtZGqiRXSruX3MCpV190CefwryeGLXCsawSz2wMQZkqtjY
V9Au73Zrqg1yDVj9KGKoRnJ8cUcg1Inxs/+Bo3xcM43y2h10yDrSWFTfvPSQhUJwYKHCYJSV
QLFbeH9vxFJeLlewivaKQMGEg8PpnjevzDu8PVVzr9gkWcLubhztussqdAPF+dvyXIYJb/7l
6idZkS4NeHAsrAtcv+UF+SGzSS5F28s376Kx35LUaJeOW4hQOjSj/118F9cyYAd2WlgGdBda
K2PSvH7aANZQfyEhNNMzk2GP83pHXXeXy+09LkTcIlgXr2rrXepxP+WBp+Ihu4Jh5uZWQkpG
UUNqKSjxIpUJ6sDIIgGIqSY/uBFSp2ff+4OLLS3Z+XQ9gBu1Szd3kQ8PrGXAI5DXayXjM9Yp
psHld3OojXhoOsLdCji+be0mAgvbNa6AaSJcT7RF3QIDAQABo4IB5DCCAeAwEgYDVR0TAQH/
BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkGCCsGAQUFBwEBBH0wezAwBggrBgEFBQcw
AYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3QuY29tMEcGCCsGAQUFBzAChjto
dHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL3Jvb3RzL2NvbW1lcmNpYWxyb290Y2Ex
LnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C5yZUyI42djBfBgNVHSAEWDBWMFQGBFUd
IAAwTDBKBggrBgEFBQcCARY+aHR0cHM6Ly9zZWN1cmUuaWRlbnRydXN0LmNvbS9jZXJ0aWZp
Y2F0ZXMvcG9saWN5L3RzL2luZGV4Lmh0bWwwSgYDVR0fBEMwQTA/oD2gO4Y5aHR0cDovL3Zh
bGlkYXRpb24uaWRlbnRydXN0LmNvbS9jcmwvY29tbWVyY2lhbHJvb3RjYTEuY3JsMB0GA1Ud
DgQWBBTC1ESZoHHPSFa+DI5oOFynt/dFvDBBBgNVHSUEOjA4BggrBgEFBQcDAgYIKwYBBQUH
AwQGCisGAQQBgjcKAwwGCisGAQQBgjcUAgIGCisGAQQBgjcKAwQwDQYJKoZIhvcNAQELBQAD
ggIBAJXyFF1baV3jUq5o3Q5FIysADRg5knGSFzcliSyYTBd5YZ4FYFZSDxrQ25J87EFzq8q9
a1lQxNwcj2R3IFNfx5QWU6EApuGwiOgX9igx3EAJuOa8JnSoLUI5zKflmNqTVHSz3b94UQy/
MF+s8+OwbM8+FscUY0CxXRlOEETsW6MFXfliOSIEnQFmm5NraqzYHecXC8DJF6yTxbu1+101
T66oqkp9+EAvU+SXgSIcHDpNxAmbm6XcSQFwEZLOLSctCVeZzLsvCE1Ozr5hvEAstYh07Qm/
FtuZ+M540l2qSydFaI4yD7uH6/SsjQAARQXYzezBauwR8YOTS7PUDWejFUpHzPy4q2JdYdU2
jYTst4G7gW0+y6EQyXIiSEEaKePUrnIiRImK6ySZXDTB7A+td6giMATY61GcJUS9kdCHZ4br
FJiLBg9az11c15e5SbS2bCNAMOIK6NwakjsWmh2jX+C6LJX37ehqQT0GVekYT4nGMBH89MiQ
1kFnIQcIWTagA/QqFHMhHFlUH5mWyby/6alKXu0ZeODdBRR/Tn39K6awTCVSbQH8P+KbF5kM
ky9b7IFzJI/fwxr/ZVoEKCj0aoicm2TTsXgqRUI7MgiLU6hE5ersxFh5yM2IBc8za+kvkB7S
eXPhzloFqmayuM2QfrqjsX1F0CopS11iOE4QVaJmMYIEKDCCBCQCAQEwTjA6MQswCQYDVQQG
EwJVUzESMBAGA1UEChMJSWRlblRydXN0MRcwFQYDVQQDEw5UcnVzdElEIENBIEExNAIQQAGY
pgQCdfbeJujk4J9zsTANBglghkgBZQMEAgEFAKCCAqswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYxMDI5MTQzOTIwWjAvBgkqhkiG9w0BCQQxIgQgC6e/
MyY1mv5lCK2XoXGYN48dbC/KTDmdoU9Q/EcFKRUwXQYJKwYBBAGCNxAEMVAwTjA6MQswCQYD
VQQGEwJVUzESMBAGA1UEChMJSWRlblRydXN0MRcwFQYDVQQDEw5UcnVzdElEIENBIEExNAIQ
QAGYpgQCdfbeJujk4J9zsTBfBgsqhkiG9w0BCRACCzFQoE4wOjELMAkGA1UEBhMCVVMxEjAQ
BgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTQCEEABmKYEAnX23ibo
5OCfc7EwggF+BgkqhkiG9w0BCQ8xggFvMIIBazALBglghkgBZQMEAS4wCwYJYIZIAWUDBAEa
MAsGCWCGSAFlAwQBBjALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0G
CCqGSIb3DQMCAgEFMA0GCCqGSIb3DQMCAgEFMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEFMAcG
BSsOAwIaMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIDMAsGCWCGSAFl
AwQCBDALBglghkgBZQMEAgcwCwYJYIZIAWUDBAIIMAsGCWCGSAFlAwQCCTALBglghkgBZQME
AgowCwYJKoZIhvcNAQEBMAsGCSuBBRCGSD8AAjAIBgYrgQQBCwAwCAYGK4EEAQsBMAgGBiuB
BAELAjAIBgYrgQQBCwMwCwYJK4EFEIZIPwADMAgGBiuBBAEOADAIBgYrgQQBDgEwCAYGK4EE
AQ4CMAgGBiuBBAEOAzANBgkqhkiG9w0BAQEFAASCAQCjzrEahMJOCsLGvbpCPmofj4Tg5b+h
enf/arl6JYFH7RpyCkf1UldYfanERKYFes366MIvMZ8NtOO4CEPgF1MgOEU3fXaoBHlRUFk2
XC5VUgIXc6/nRdy2gumGk9a16sbA5lk/r+SnjDrDf7iwXdIoe0xSMfxDeIWkJdHbSWjoAxR5
BHtG/82Fk19VIUMuNF5P0UaaIFBwkiHV2wGTuPNHT5pDcdxY8EJ0ES0BSmU488KrTWgIbM8v
9/C5HGox1KRaphUGIZfufUsGmGn7ZsdtMzoswjCQiE3Vytf+X4aMVk4HSyX2LAgA9NysxCKX
xA8UV6faitxNsXwMqHhIMweIAAAAAAAA
--------------ms010509010800040009090202--

