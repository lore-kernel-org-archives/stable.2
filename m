Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630630;
	b=eeB26x19ZmEqCLN9VWAkI5E8R+2xdNzU6lk/dKI9FVki69++ixWc+Qjy+3d5hByQP6j3
	 8KyNtBljWo0Bis7vptJLl+Z1rfnAsck/FWA/FBM07F6ig1STDgA1U0IVjnoTX+FWhUa7B
	 wyeW9JzbRaCcM0wsaqTttXVEMV7Y2OPuwQNN/5/AcqP1F2oSUCkfRqOgvHBdDq2iQYl0Y
	 dxCiHgn8GRYGm3R9yCGrTm+Oxnd8UJ0rljBAGPb0KfmXIFkeFcd1a+dWH2Qw1E/tn+RAo
	 hmVQYuk/ErA3gTIgRZmW4ULqtoc42tjMczlOl5l2ySIoZSPwx0fsmBsmHxMWXmv3SKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630630;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=n4oIJJgf6gvjIY7IilFPOFQOtLs+8UdZecco53appoA=;
	b=rsLscz9oR+OgQDnr5Eb/XtLfWxXH/OAMzYoGbjfC3mKjWepBKVWQ6sYLX1WkE55EJydT
	 fQyiluff6dIIKfMI4iZ4eOcIPg0mYnScs+V0Z8M8PNhGmCQHuAS2sl2sTI38ggqEbV8oD
	 /z9aMSMz0/Vl14kTh7abYucVJSHFlFHitsK+eCLoSXhvVZbwVwttL+DJ1y1EevUBeN0Uj
	 haSQPPS9y5ccjGcTe11vLnROvRR3Pio7BTDXVcQXlAyRrisMo8c5PTK4EiQ+N6IHcbVwE
	 H9xuh7SPReg6iGchDXZeM0VVheGJOU77DjCUTah6X38yIaEnk0nKckSiprxzt8fMSGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PcKWUJL0;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC30606A5A6;
	Mon,  2 Nov 2026 14:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AC30606A5A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PcKWUJL0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=n4oIJJgf6gvjIY7IilFPOFQOtLs+8UdZecco53appoA=; b=P
	cKWUJL0Vr33xAQzDs6OcJ9h1w+f23IgYYBGGV/Ch5QqFjp8KlYTu6/Jt533wj0o8
	BF61KothW78si6L699CxzTe12kwJo7T2B5VOkKwRMj+VIsVQyHhB1SbhY2riYt6T
	EykKg6K+qKw6HC7pw9XQWxDIuegw2znrpW/V0lH5yo=
Date: Mon, 2 Nov 2026 22:43:17 +0800 (CST)
From: =?GBK?B?wO7T07roIA==?= <dayou5941@163.com>
To: "Biju Das" <biju.das.jz@bp.renesas.com>
Cc: "wbg@kernel.org" <wbg@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Cosmin-Gabriel Tanislav" <cosmin-gabriel.tanislav.xa@renesas.com>,
	"Li Youhong" <liyouhong@kylinos.cn>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re:RE: [PATCH v3] counter: rz-mtu3-cnt: put runtime PM ref if
 counter init fails
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <TY3PR01MB1134693BA02E518FE0A498205866A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261101130746.1724364-1-dayou5941@163.com>
 <TY3PR01MB1134693BA02E518FE0A498205866A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-NTES-SC: AL_Qu2SAfqYv00i4SiQY+kckk4Wjug8Wcexufwj34NTc+MGlyLC1RIGTUF7EXf4/v2AMRyQjye6fBxU1MFHfIhlu2wF6Ow+Yid27nzZJuc1bg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <5fefeec.a792.1a19cb6f306.Coremail.dayou5941@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:lSgvCgD33zmHoehqEB5mAA--.1701W
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+gZeDWrooYZ4AQAA3z
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCkhpIEJpanUsCgoKCgoKQXQgMjAyNi0xMS0wMiAxNTo0MDozMSwgIkJpanUgRGFzIiA8Ymlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOgo+SGkgTGkgWW91aG9uZywKPgo+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBMaSBZb3Vob25nIDxkYXlvdTU5NDFAMTYz
LmNvbT4KPj4gU2VudDogMDEgTm92ZW1iZXIgMjAyNiAxMzowOAo+PiBTdWJqZWN0OiBbUEFUQ0gg
djNdIGNvdW50ZXI6IHJ6LW10dTMtY250OiBwdXQgcnVudGltZSBQTSByZWYgaWYgY291bnRlciBp
bml0IGZhaWxzCj4+IAo+PiBGcm9tOiBMaSBZb3Vob25nIDxsaXlvdWhvbmdAa3lsaW5vcy5jbj4K
Pj4gCj4+IENvdW50ZXIgZW5hYmxlIHRha2VzIGEgcnVudGltZSBQTSByZWZlcmVuY2UgYmVmb3Jl
IGluaXRpYWxpemF0aW9uIGJ1dCBvbmx5IHB1dHMgaXQgb24gZGlzYWJsZS4gRHJvcCB0aGUKPj4g
cmVmZXJlbmNlIGlmIGluaXRpYWxpemF0aW9uIGZhaWxzLgo+PiAKPj4gRml4ZXM6IDBiZTg5MDcz
NTlkZiAoImNvdW50ZXI6IEFkZCBSZW5lc2FzIFJaL0cyTCBNVFUzYSBjb3VudGVyIGRyaXZlciIp
Cj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4+IFNpZ25lZC1vZmYtYnk6IExpIFlvdWhv
bmcgPGxpeW91aG9uZ0BreWxpbm9zLmNuPgo+PiAtLS0KPj4gdjM6Cj4+IC0gU2V0IGNvdW50X2lz
X2VuYWJsZWQgZnJvbSBlbmFibGUgYWZ0ZXIgZWl0aGVyIGJyYW5jaCBzdWNjZWVkcy4KPj4gLSB2
MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYxMDMxMTQyODEzLjI1MjI0NDQtMS1k
YXlvdTU5NDFAMTYzLmNvbS8KPj4gCj4+IHYyOgo+PiAtIEFkZCBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZy4KPj4gLSB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYxMDA4MDIw
NTA2LjIxMTU2Ni0xLWRheW91NTk0MUAxNjMuY29tLwo+PiAKPj4gIGRyaXZlcnMvY291bnRlci9y
ei1tdHUzLWNudC5jIHwgOSArKysrKystLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jb3VudGVy
L3J6LW10dTMtY250LmMgYi9kcml2ZXJzL2NvdW50ZXIvcnotbXR1My1jbnQuYyBpbmRleAo+PiA3
YmZiNjk3OTE5M2MuLmU3ZmU4YmY0NTE2NCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9jb3VudGVy
L3J6LW10dTMtY250LmMKPj4gKysrIGIvZHJpdmVycy9jb3VudGVyL3J6LW10dTMtY250LmMKPj4g
QEAgLTUwNiwxNCArNTA2LDE3IEBAIHN0YXRpYyBpbnQgcnpfbXR1M19jb3VudF9lbmFibGVfd3Jp
dGUoc3RydWN0IGNvdW50ZXJfZGV2aWNlICpjb3VudGVyLAo+PiAgCWlmIChlbmFibGUpIHsKPj4g
IAkJcG1fcnVudGltZV9nZXRfc3luYyhjb3VudGVyLT5wYXJlbnQpOwo+PiAgCQlyZXQgPSByel9t
dHUzX2luaXRpYWxpemVfY291bnRlcihjb3VudGVyLCBjb3VudC0+aWQpOwo+Cj5SZXZpZXdlZC1i
eTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPgo+Cj5Ob3cgZGF5cyBib3Rz
IHN0YXJ0ZWQgY29tcGxhaW5pbmcgaWYgcG1fcnVudGltZV9nZXRfc3luYygpIGZhaWxzCj5UaGVu
IHJ6X210dTNfaW5pdGlhbGl6ZV9jb3VudGVyKCkgd2lsbCBsZWFkIHRvIGtlcm5lbCBjcmFzaChz
eXNuY2hyb25vdXMgYWJvcnQpCj5hcyBpdCBpcyBhY2Nlc3NpbmcgcmVnaXN0ZXJzIHdpdGhvdXQg
dGhlIGNsay4KPgo+U2luY2UgeW91IGhhdmUgYWRkZWQgZml4ZXMgdGFnLCBub3Qgc3VyZSB0aGlz
IHRvIGJlIGZpeGVkIGluIHRoaXMgcGF0Y2g/PwoKPgoKVGhlIHJ1bnRpbWUgUE0gZ2V0IGNoZWNr
cyBhcmUgcGF0Y2ggMiBvZiB0aGlzIHNlcmllczoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjYwOTAzMDkwNzE5LjM0OTg5NTUtMS1kYXlvdTU5NDFAMTYzLmNvbS8KCldlIGFscmVhZHkg
ZGlzY3Vzc2VkIHRoYXQgaGVyZToKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzY2NTc1ZDhk
LjIxNGQuMWExMTkzZmQyYmEuQ29yZW1haWwuZGF5b3U1OTQxQDE2My5jb20vCgpTbyBJIGRvbid0
IHRoaW5rIHRoZSBwbV9ydW50aW1lX2dldF9zeW5jKCkgcmV0dXJuIHZhbHVlIG5lZWRzIHRvIGJl
CmhhbmRsZWQgaW4gdGhpcyBwYXRjaC4gQ29zbWluJ3MgcGF0Y2ggc2VyaWVzIGNvdmVycyB0aGF0
LgoKVGhhbmtzLApMaQoKPkNoZWVycywKPkJpanUKPgo+PiAtCQlpZiAocmV0ID09IDApCj4+IC0J
CQlwcml2LT5jb3VudF9pc19lbmFibGVkW2NvdW50LT5pZF0gPSB0cnVlOwo+PiArCQlpZiAocmV0
IDwgMCkgewo+PiArCQkJcG1fcnVudGltZV9wdXQoY291bnRlci0+cGFyZW50KTsKPj4gKwkJCWdv
dG8gZXhpdDsKPj4gKwkJfQo+PiAgCX0gZWxzZSB7Cj4+ICAJCXJ6X210dTNfdGVybWluYXRlX2Nv
dW50ZXIoY291bnRlciwgY291bnQtPmlkKTsKPj4gLQkJcHJpdi0+Y291bnRfaXNfZW5hYmxlZFtj
b3VudC0+aWRdID0gZmFsc2U7Cj4+ICAJCXBtX3J1bnRpbWVfcHV0KGNvdW50ZXItPnBhcmVudCk7
Cj4+ICAJfQo+PiAKPj4gKwlwcml2LT5jb3VudF9pc19lbmFibGVkW2NvdW50LT5pZF0gPSBlbmFi
bGU7Cj4+ICsKPj4gIGV4aXQ6Cj4+ICAJbXV0ZXhfdW5sb2NrKCZwcml2LT5sb2NrKTsKPj4gCg==

