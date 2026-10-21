Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548423;
	b=C55/eUm/x26tFPIlaa9TS+CukXfKimh6r2RyFUshye+OQJNp+YfUy7r43iGUdh9NxgO+
	 5SA1vM/dyFq5PkGQo1fXRAs4JZWj6fEd2mW71IKtV3nCDAGyzVyTeAHva4YYFyhOtdfAn
	 PLfYS3ZY9nLcQA5aPf0tg1DjSKs+Tj7EN0O0/c47uxsRXEGmppuwMYqeQg/nCC4ZBYdSc
	 nMWrjEjOmDo9lgdNbSPVxqRQRZQUHvMvxo0k5LsuqnoQrPvzBVCEI2DEDZEtQmevjC6zw
	 OO7lVqOgDpTP0v8TcOPLP9bBjLb9yzrrBkMdO4kEcLtb7d2PgSQLFzvDr5BW5Q0HwvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548423;
	h=DMARC-Filter:DKIM-Signature:Received:X-Originating-IP:Date:From:To:
	 Cc:Subject:X-Priority:X-Mailer:In-Reply-To:References:X-NTES-SC:
	 Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	 X-Coremail-Locale:X-CM-TRANSID:X-CM-SenderInfo:X-Coremail-Antispam;
	bh=5X63u9vTyzFm6OXLQtfUe2p61TxTC/Aw6Amh1+249ew=;
	b=03WAPRnsO0pDptDxOpjAL86ElpUjvUWOx1xErzU/HombY7y/RtGPOvtIqiQ46r5f1Ch8
	 1r+VlqVZBlLqgSQ2V9unop/aoXpLIEm1P/HdpQozgdZ7aelhnL/13Q4neRDI7zi9ugvgn
	 PpRHc0X7ZN+bU08zO8ZYLEa0bceF5ZPCn9KN6Jnz7kKo7d2JwzfyPhuQ04rtXK0FgY6je
	 0ZKJ12RhYJBYiMlWWYdozkMfh/03cRz1tdCh2df9hIE5Ei5ekf+YfDsWGgKXFrYMXSG+y
	 YCiqCcgiUS+ziTa9s8uJmTv5iq/AibISpF08wMkptRZ2Hg1KLBwJd19HffUkswduCfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DoItMlBz;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BC7606A319;
	Wed, 21 Oct 2026 02:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2BC7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DoItMlBz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=5X63u9vTyzFm6OXLQtfUe2p61TxTC/Aw6Amh1+249ew=; b=D
	oItMlBzO0zflFD1zhGWKSAezcZAjsrSHkd/5fT7md0ogXxGKpLSKnCj7tbPeQ7O9
	vfkUUlikwezcfgzi1cqjmUPAj1+vD+/77qkYMPX7GJdjr77zVujGRgeT6kgHP6Gk
	Kd1CY8OMpnXDIfjNwHfKGX1Aa6nBhZ25/8TnVFC3Fo=
Received: from slark_xiao$163.com (
 [2408:8459:3c60:67ec:11ce:97fc:3b30:e8ab] ) by ajax-webmail-wmsvr-40-123
 (Coremail) ; Wed, 21 Oct 2026 10:06:37 +0800 (CST)
Date: Wed, 21 Oct 2026 10:06:37 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: mani@kernel.org, jeff.hugo@oss.qualcomm.com,
	krishna.chundru@oss.qualcomm.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re:Re: Re: Re: [PATCH] bus: mhi: host: pci_generic: Update the
 default autosuspend_delay_ms as 5000ms
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAFEp6-2LSJaKHwZdgdHUzJpPF0H+jGXpHgy3YEPzJR4oAFUTgQ@mail.gmail.com>
References: <20261019055109.49922-1-slark_xiao@163.com>
 <CAFEp6-2XUE4AQPm5hinnRGyrrsHok2ftsFXragiHgDSKKtKWow@mail.gmail.com>
 <70714501.3175.1a157532149.Coremail.slark_xiao@163.com>
 <CAFEp6-3o6gCb61hCQTJydiH2aD6CBVRa947tpmLe4L9j85Jg5w@mail.gmail.com>
 <65d8a1b5.8e5b.1a158ddc4de.Coremail.slark_xiao@163.com>
 <CAFEp6-2LSJaKHwZdgdHUzJpPF0H+jGXpHgy3YEPzJR4oAFUTgQ@mail.gmail.com>
X-NTES-SC: AL_Qu2SAPmft0si4SmcY+kckk4WhuY7WcOyuPkg2YZSc8gEhwDW6xonfV5YDFLU39CPGgWDqQiSbhF04dhKRo5Z9YFWxbw2kBG2pBZzHRQY0w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <f60c2a5.1bc8.1a15c35e387.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eygvCgD3ny0uHthqJdFcAA--.605W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC6A5jx2rYHi6wOQAA3J
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMC0yMCAxOTo0Mjo1MCwgIkxvaWMgUG91bGFpbiIgPGxvaWMucG91bGFpbkBvc3Mu
cXVhbGNvbW0uY29tPiB3cm90ZToKPk9uIFR1ZSwgT2N0IDIwLCAyMDI2IGF0IDEyOjMx4oCvUE0g
U2xhcmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPiB3cm90ZToKPj4KPj4KPj4KPj4gQXQgMjAy
Ni0xMC0yMCAxNToyNzo0MywgIkxvaWMgUG91bGFpbiIgPGxvaWMucG91bGFpbkBvc3MucXVhbGNv
bW0uY29tPiB3cm90ZToKPj4gPkhpIFNsYXJrLAo+PiA+Cj4+ID5PbiBUdWUsIE9jdCAyMCwgMjAy
NiBhdCA1OjIw4oCvQU0gU2xhcmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPiB3cm90ZToKPj4g
Pj4KPj4gPj4KPj4gPj4gQXQgMjAyNi0xMC0xOSAxNTo0MToyNywgIkxvaWMgUG91bGFpbiIgPGxv
aWMucG91bGFpbkBvc3MucXVhbGNvbW0uY29tPiB3cm90ZToKPj4gPj4gPk9uIE1vbiwgT2N0IDE5
LCAyMDI2IGF0IDc6NTLigK9BTSBTbGFyayBYaWFvIDxzbGFya194aWFvQDE2My5jb20+IHdyb3Rl
Ogo+PiA+PiA+Pgo+PiA+PiA+PiBGb3Igc29tZSBNSEkgZGV2aWNlcyBpbiBzb21lIHNwZWNpZmlj
IHNjZW5hcmlvLCB0aGUgZGVmYXVsdCB2YWx1ZQo+PiA+PiA+PiBvZiBhdXRvc3VzcGVuZF9kZWxh
eV9tcyBtYXkgbm90IGVub3VnaCB0byBoYW5kbGUgbGFzdCB3YWtlIGV2ZW50Lgo+PiA+PiA+PiBU
aGlzIG1heSBsZWFkIHRvIHNvbWUgdW5leHBlY3RlZCBwcm9ibGVtcy4KPj4gPj4gPj4KPj4gPj4g
Pj4gUmVmZXIgdG8gdGhlIFF1YWxjb21tJ3MgV2luZG93cyBzZXR0aW5ncyBhbmQgd2UgY2hlY2tl
ZCB0aGlzIHdpdGgKPj4gPj4gPj4gUXVhY2xvbW0gb3ZlciBjYXNlLCBRdWFsY29tbSByZWNvbW1l
bmQgdXMgdG8gc2V0IHRoaXMgYXMgNTAwMG1zLgo+PiA+PiA+Cj4+ID4+ID5RdWFsY29tbQo+PiA+
PiA+Cj4+ID4+ID4+IFF1YWxjb21tIGFsc28gc3VnZ2VzdHMgdXMgdG8gdXBkYXRlIHRoaXMgZm9y
IGFsbCBNSEkgZGV2aWNlcy4KPj4gPj4gPj4gU2luY2UgdGhpcyBzZXR0aW5nIGhhcyBhZmZlY3Rl
ZCBzb21lIGV4aXN0ZWQga2VybmVsIHZlcnNpb25zLCBpdCdzCj4+ID4+ID4+IGJldHRlciB0byBi
ZSBhcHBsaWVkIHRvIHN0YWJsZSB2ZXJzaW9uLgo+PiA+PiA+Cj4+ID4+ID5UaGlzIGxvb2tzIG1v
cmUgbGlrZSBhIHdvcmthcm91bmQgdGhhbiBhIHByb3BlciBmaXguIEl0IHdvdWxkIGJlCj4+ID4+
ID5oZWxwZnVsIHRvIGRlc2NyaWJlIHRoZSB1bmRlcmx5aW5nIGlzc3VlLCBpbmNsdWRpbmcgdGhl
IHRpbWluZyBhbmQKPj4gPj4gPnNlcXVlbmNlIG9mIGV2ZW50cyB0aGF0IG1ha2UgdGhpcyBuZWNl
c3NhcnkuIEluIHByaW5jaXBsZSwgZWl0aGVyIHRoZQo+PiA+PiA+ZGV2aWNlIGNhbiBiZSBzdXNw
ZW5kZWQgYXQgdGhhdCBwb2ludCBvciBpdCBjYW5ub3QuIFJlbHlpbmcgb24gYQo+PiA+PiA+ZGVs
YXllZCBzdXNwZW5kIGZlZWxzIGZyYWdpbGUgYW5kIG1heSBlbmQgdXAgbWFza2luZyB0aGUgcmVh
bCBwcm9ibGVtLgo+PiA+PiA+Cj4+ID4+IEhpIExvaWMsCj4+ID4+IEhvbmVzdGx5LCBRdWFsY29t
bSBoYXMgYmVlbiBhbmFseXppbmcgZm9yIG92ZXIgMiBtb250aHMgYW5kIHN0aWxsIGhhc24ndAo+
PiA+PiBpZGVudGlmaWVkIHRoZSByb290IGNhdXNlLgo+PiA+Pgo+PiA+PiBBY3R1YWxseSBJIGhh
dmUgZXhwbGFpbmVkIHRoZSByZWFzb25zIGJlaGluZCB0aGUgZXZlbnRzIHRvIE1hbmkgaW4gYW5v
dGhlcgo+PiA+PiB0aHJlYWQsIHlvdSBjYW4gcmVmZXIgdG8gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbWhpLzIwMjYwOTE5MDk1NTA2Ljk1NzAtMS1zbGFya194aWFvQDE2My5jb20vCj4+ID4+Cj4+
ID4+IEZyb20gUXVhbGNvbW0ncyBwZXJzcGVjdGl2ZSwgMiBzZWNvbmRzIGlzIG5vdCBlbm91Z2gg
Zm9yIHRoZWlyIGRlZmF1bHQgZGVzaWduLgo+PiA+PiBUaGV5IHJlY29tbWVuZGVkIHVzIHRvIHVw
ZGF0ZSB0aGlzIHZhbHVlIHRvIDUgc2Vjb25kcyBhbmQgTWFuaSBjaGVja2VkIHRoaXMKPj4gPj4g
aW50ZXJuYWxseSBhcyB3ZWxsLiBTbyB3ZSBkZWNpZGVkIHRvIHVwZGF0ZSB0aGlzIDUgc2Vjb25k
cyBzZXR0aW5nIHRvIGFsbCBNSEkgZGV2aWNlcy4KPj4gPgo+PiA+VGhhbmtzLiBJJ20gcmVhbGx5
IHN1cnByaXNlZCB3ZSBzdGlsbCBkb24ndCBoYXZlIGEgbW9yZSBwcmVjaXNlCj4+ID51bmRlcnN0
YW5kaW5nIG9yIGRlc2NyaXB0aW9uIG9mIHRoZSB1bmRlcmx5aW5nIGlzc3VlLiBUaGF0IHNhaWQs
IEkKPj4gPnRoaW5rIGl0J3MgcmVhc29uYWJsZSB0byBwcm9jZWVkIHdpdGggdGhpcyBhcyBhbiBp
bml0aWFsIHdvcmthcm91bmQuCj4+ID4KPj4gPkNvdWxkIHlvdSBwbGVhc2Ugc2VuZCBhIHYyIHRo
YXQgaW50cm9kdWNlcyBhIGRlZmluZSBmb3IgdGhlIDUwMDAgbXMKPj4gPnRpbWVvdXQ/IEl0IHdv
dWxkIGFsc28gYmUgaGVscGZ1bCB0byBhZGQgYSBjb21tZW50IGV4cGxhaW5pbmcgdGhhdAo+PiA+
dGhpcyB2YWx1ZSBpcyByZXF1aXJlZCB0byBhY2NvbW1vZGF0ZSB0aGUgJ2xhdGUgd2FrZS1ldmVu
dCBpc3N1ZScuCj4+ID4KPj4gPlJlZ2FyZHMsCj4+ID5Mb2ljCj4+Cj4+IERvIHlvdSBtZWFuIHNv
bWV0aGluZyBsaWtlIGJlbG93Pwo+Pgo+PiAvKiBBZGQgZGVmaW5lIG9mICBpbml0aWFsIGF1dG9z
dXNwZW5kX2RlbGF5X21zIHRvIGFjY29tbW9kYXRlIGEgcG90ZW50aWFsICdsYXRlIHdha2UtZXZl
bnQnIGlzc3VlICovCj4+ICNkZWZpbmUgTUhJX0FVVE9TVVNQRU5EX0RFTEFZX01TIDUwMDAKPj4g
Li4uLi4uCj4+ICAtICAgICAgICAgICAgICAgcG1fcnVudGltZV9zZXRfYXV0b3N1c3BlbmRfZGVs
YXkoJnBkZXYtPmRldiwgMjAwMCk7Cj4+ICArICAgICAgICAgICAgICAgcG1fcnVudGltZV9zZXRf
YXV0b3N1c3BlbmRfZGVsYXkoJnBkZXYtPmRldiwgTUhJX0FVVE9TVVNQRU5EX0RFTEFZX01TKTsK
Pgo+WWVzLgo+ClVwZGF0ZSBpdCBsYXRlci4gVGhhbmtzIGZvciB5b3VyIGNvbmZpcm1hdGlvbi4K
Pj4KPj4gVGhhbmtzCj4+Cj4+ID4+Cj4+ID4+IFRoYW5rcwo+PiA+PiA+Pgo+PiA+PiA+PiBGaXhl
czogZDM4MDBjMWRjZTI0ICgiYnVzOiBtaGk6IHBjaV9nZW5lcmljOiBBZGQgc3VwcG9ydCBmb3Ig
cnVudGltZSBQTSIpCj4+ID4+ID4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4+ID4+ID4+
IFNpZ25lZC1vZmYtYnk6IFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4KPj4gPj4gPj4g
LS0tCj4+ID4+ID4+ICBkcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jIHwgMiArLQo+
PiA+PiA+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+
ID4+ID4+Cj4+ID4+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2Vu
ZXJpYy5jIGIvZHJpdmVycy9idXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMuYwo+PiA+PiA+PiBpbmRl
eCA3MTkzYTM4NGNjYTQuLjQwNzM1YmViNDZjYiAxMDA2NDQKPj4gPj4gPj4gLS0tIGEvZHJpdmVy
cy9idXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMuYwo+PiA+PiA+PiArKysgYi9kcml2ZXJzL2J1cy9t
aGkvaG9zdC9wY2lfZ2VuZXJpYy5jCj4+ID4+ID4+IEBAIC0xNDgzLDcgKzE0ODMsNyBAQCBzdGF0
aWMgaW50IG1oaV9wY2lfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBw
Y2lfZGV2aWNlX2lkICppZCkKPj4gPj4gPj4KPj4gPj4gPj4gICAgICAgICAvKiBBbGxvdyBydW50
aW1lIHN1c3BlbmQgb25seSBpZiBib3RoIFBNRSBmcm9tIEQzSG90IGFuZCBNMyBhcmUgc3VwcG9y
dGVkICovCj4+ID4+ID4+ICAgICAgICAgaWYgKHBjaV9wbWVfY2FwYWJsZShwZGV2LCBQQ0lfRDNo
b3QpICYmICEoaW5mby0+bm9fbTMpKSB7Cj4+ID4+ID4+IC0gICAgICAgICAgICAgICBwbV9ydW50
aW1lX3NldF9hdXRvc3VzcGVuZF9kZWxheSgmcGRldi0+ZGV2LCAyMDAwKTsKPj4gPj4gPj4gKyAg
ICAgICAgICAgICAgIHBtX3J1bnRpbWVfc2V0X2F1dG9zdXNwZW5kX2RlbGF5KCZwZGV2LT5kZXYs
IDUwMDApOwo+PiA+PiA+PiAgICAgICAgICAgICAgICAgcG1fcnVudGltZV91c2VfYXV0b3N1c3Bl
bmQoJnBkZXYtPmRldik7Cj4+ID4+ID4+ICAgICAgICAgICAgICAgICBwbV9ydW50aW1lX21hcmtf
bGFzdF9idXN5KCZwZGV2LT5kZXYpOwo+PiA+PiA+PiAgICAgICAgICAgICAgICAgcG1fcnVudGlt
ZV9wdXRfbm9pZGxlKCZwZGV2LT5kZXYpOwo+PiA+PiA+PiAtLQo+PiA+PiA+PiAyLjUzLjAKPj4g
Pj4gPj4K
