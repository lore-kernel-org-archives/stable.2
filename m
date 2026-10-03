Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0730F526;
	Sat,  3 Oct 2026 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021950; cv=none; b=T4QP5E2G1ewQMDV6SpMinZy2jRoN6ThRRubEYOsJA5AaepstboSPONA94y5UMwJBcQE8tJiC+4qAsfLYSsJ1ABhvyHLOXbP33U4ybvVP3GIafa4D72TqjPBlGcz9kxRiTRXXCcEyuzQs0HjMstodeGBaet9eV4xVd2oa1OpJPuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021950; c=relaxed/simple;
	bh=CrKUgrI+tlpT8PZeMTD3lCBuPH+nIM53URnJwC/rDuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=rPlYWM0U+20Ug7SzdEaz0Fa9IsTqcuh/3xPOjN147532423I1z+IoS6UAgEJujC1PMTFni3T8/NNcKpyK6E044kRScN8tTcSd/PhgeD6+IXDexnXRtQckRMe3pfh2EZq6ELX2vS9ACeRP255zQ4IqZ2An+0pn84cCgawNwBOwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R13B6I7F; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R13B6I7F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=CrKUgrI+tlpT8PZeMTD3lCBuPH+nIM53URnJwC/rDuE=; b=R
	13B6I7F+EA5cdX6KjG1bAzsF3+Cq4Q4FAgsksL7Xasg7pPVblQco8+/f7H1tpnJ3
	Tc/898i8VxrZE7VUD8iz8qxWJmEc3Ut4jhmUlyZxapVc2+aiMzhX/dxVZc+xEbFP
	f5ZSPnDIV8lhgJF0gZ2/1Ig5cbfrd410PrPUtxZk1A=
Date: Sat, 3 Oct 2026 18:04:41 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: "Paul Barker" <paul@pbarker.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Sergey Shtylyov" <s.shtylyov@omp.ru>,
	"Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re:Re: [PATCH net v3 6/7] net: ravb: release managed IRQs before
 freeing netdev
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261003095921.GB1933679@ragnatech.se>
References: <20261003085940.493951-1-yaojiale02@163.com>
 <20261003085940.493951-7-yaojiale02@163.com>
 <20261003095921.GB1933679@ragnatech.se>
X-NTES-SC: AL_Qu2SA/yZvkAj5yiaYukdmE8Uges8WcC0svki1YJUc+4GhzHBwiABbHpeBEnt4NmlFwSNnAm9ShFy8/5qb6BZEHm0hyzCcXMZlL66xakoBw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <75941506.13f3.1a1013919eb.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jygvCgD3n1U608BqB0cHAA--.63680W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRrNCGrA0zoFHQAA3J
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMC0wMyAxNzo1OToyMSwgIk5pa2xhcyBTw7ZkZXJsdW5kIiA8bmlrbGFzLnNvZGVy
bHVuZEByYWduYXRlY2guc2U+IHdyb3RlOgo+SGkgSmlhbGUsCj4KPk9uIDIwMjYtMTAtMDMgMTY6
NTk6MzcgKzA4MDAsIEppYWxlIFlhbyB3cm90ZToKPj4gcmF2Yl9yZW1vdmUoKSBmcmVlcyB0aGUg
bmV0ZGV2IGJlZm9yZSBkZXZyZXMgcmVsZWFzZXMgdGhlIG1hbmFnZWQgSVJRcy4KPj4gVGhlIGhh
bmRsZXJzIHVzZSB0aGUgbmV0ZGV2IGFzIHRoZWlyIGRhdGEgcG9pbnRlciwgc28gYW4gaW50ZXJy
dXB0IGR1cmluZwo+PiB0aGF0IHdpbmRvdyBjYW4gYWNjZXNzIGZyZWVkIG1lbW9yeS4gUHJvYmUg
ZXJyb3IgcGF0aHMgaGF2ZSB0aGUgc2FtZQo+PiBvcmRlcmluZyBwcm9ibGVtLgo+PiAKPj4gS2Vl
cCB0aGUgbmV0ZGV2IG1hbnVhbGx5IG1hbmFnZWQgYW5kIHBsYWNlIG9ubHkgdGhlIElSUSByZXNv
dXJjZXMgaW4gYQo+PiBkZWRpY2F0ZWQgZGV2cmVzIGdyb3VwLiBSZWxlYXNlIHRoZSBncm91cCBh
ZnRlciB1bnJlZ2lzdGVyaW5nIHRoZSBuZXRkZXYKPj4gYW5kIGJlZm9yZSBmcmVlaW5nIGl0LCBh
bmQgcmVsZWFzZSBpdCBvbiBwcm9iZSBmYWlsdXJlcyBhcyB3ZWxsLiBUaGlzCj4+IGtlZXBzIHRo
ZSBleGlzdGluZyBydW50aW1lIFBNIGVycm9yIGhhbmRsaW5nIHVuY2hhbmdlZC4KPj4gCj4+IFRo
aXMgaXNzdWUgd2FzIGZvdW5kIGJ5IGEgc3RhdGljIGFuYWx5c2lzIG1ldGhvZCB1c2VkIGluIG91
ciByZXNlYXJjaC4KPgo+V2hhdCBoYXBwZW5lZCB0byBzd2l0Y2hpbmcgdG8gdXNlIGRldm1fYWxs
b2NfZXRoZXJkZXZfbXFzKCkgaW5zdGVhZCBvZiAKPmFkZGluZyB0aGlzIGNvbXBsZXggdGhpbmcs
IGFzIHdlIGRpc2N1c3NlZCBpbiB2Mj8KCllvdSdyZSByaWdodC4gSSBtaXNzZWQgdGhpcyBwb2lu
dCB3aGlsZSB3b3JraW5nIHRocm91Z2ggYSBsYXJnZSBudW1iZXIKb2YgcGF0Y2hlcy4uLj5fPApJ
IHNob3VsZCB0YWtlIGEgYnJlYWsgYW5kIHBvc3QgYW4gdXBkYXRlZCByZXZpc2lvbiBhZnRlciB0
aGUKMjQtaG91ciB3YWl0aW5nIHBlcmlvZC4KCj4KPk5hY2tlZC1ieTogTmlrbGFzIFPDtmRlcmx1
bmQgPG5pa2xhcy5zb2Rlcmx1bmQrcmVuZXNhc0ByYWduYXRlY2guc2U+Cj4KPj4gCj4+IEZpeGVz
OiAzMmYwMTJiOGMwMWMgKCJuZXQ6IHJhdmI6IE1vdmUgZ2V0dGluZy9yZXF1ZXN0aW5nIElSUXMg
aW4gdGhlIHByb2JlKCkgbWV0aG9kIikKPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPj4g
U2lnbmVkLW9mZi1ieTogSmlhbGUgWWFvIDx5YW9qaWFsZTAyQDE2My5jb20+Cj4+IC0tLQo+PiAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVuZXNhcy9yYXZiX21haW4uYyB8IDE4ICsrKysrKysrKysr
KysrLS0tLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVuZXNhcy9yYXZi
X21haW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlbmVzYXMvcmF2Yl9tYWluLmMKPj4gaW5k
ZXggZWExYzdlNTM2NzkxLi5hYjQ3MDM4ODg3NzggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L3JlbmVzYXMvcmF2Yl9tYWluLmMKPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvcmVuZXNhcy9yYXZiX21haW4uYwo+PiBAQCAtMjk2MywyOCArMjk2MywzNSBAQCBzdGF0aWMg
aW50IHJhdmJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4gIAkJcHJpdi0+
bnVtX3J4X3JpbmdbUkFWQl9OQ10gPSBOQ19SWF9SSU5HX1NJWkU7Cj4+ICAJfQo+PiAgCj4+ICsJ
aWYgKCFkZXZyZXNfb3Blbl9ncm91cCgmcGRldi0+ZGV2LCBwcml2LCBHRlBfS0VSTkVMKSkgewo+
PiArCQllcnJvciA9IC1FTk9NRU07Cj4+ICsJCWdvdG8gb3V0X3Jlc2V0X2Fzc2VydDsKPj4gKwl9
Cj4+ICsKPj4gIAllcnJvciA9IHJhdmJfc2V0dXBfaXJxcyhwcml2KTsKPj4gIAlpZiAoZXJyb3Ip
Cj4+IC0JCWdvdG8gb3V0X3Jlc2V0X2Fzc2VydDsKPj4gKwkJZ290byBvdXRfcmVsZWFzZV9pcnFf
Z3JvdXA7Cj4+ICsKPj4gKwlkZXZyZXNfY2xvc2VfZ3JvdXAoJnBkZXYtPmRldiwgcHJpdik7Cj4+
ICAKPj4gIAlwcml2LT5jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgTlVMTCk7Cj4+ICAJ
aWYgKElTX0VSUihwcml2LT5jbGspKSB7Cj4+ICAJCWVycm9yID0gUFRSX0VSUihwcml2LT5jbGsp
Owo+PiAtCQlnb3RvIG91dF9yZXNldF9hc3NlcnQ7Cj4+ICsJCWdvdG8gb3V0X3JlbGVhc2VfaXJx
X2dyb3VwOwo+PiAgCX0KPj4gIAo+PiAgCWlmIChpbmZvLT5ncHRwX3JlZl9jbGspIHsKPj4gIAkJ
cHJpdi0+Z3B0cF9jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgImdwdHAiKTsKPj4gIAkJ
aWYgKElTX0VSUihwcml2LT5ncHRwX2NsaykpIHsKPj4gIAkJCWVycm9yID0gUFRSX0VSUihwcml2
LT5ncHRwX2Nsayk7Cj4+IC0JCQlnb3RvIG91dF9yZXNldF9hc3NlcnQ7Cj4+ICsJCQlnb3RvIG91
dF9yZWxlYXNlX2lycV9ncm91cDsKPj4gIAkJfQo+PiAgCX0KPj4gIAo+PiAgCXByaXYtPnJlZmNs
ayA9IGRldm1fY2xrX2dldF9vcHRpb25hbCgmcGRldi0+ZGV2LCAicmVmY2xrIik7Cj4+ICAJaWYg
KElTX0VSUihwcml2LT5yZWZjbGspKSB7Cj4+ICAJCWVycm9yID0gUFRSX0VSUihwcml2LT5yZWZj
bGspOwo+PiAtCQlnb3RvIG91dF9yZXNldF9hc3NlcnQ7Cj4+ICsJCWdvdG8gb3V0X3JlbGVhc2Vf
aXJxX2dyb3VwOwo+PiAgCX0KPj4gIAljbGtfcHJlcGFyZShwcml2LT5yZWZjbGspOwo+PiAgCj4+
IEBAIC0zMTI0LDYgKzMxMzEsOCBAQCBzdGF0aWMgaW50IHJhdmJfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikKPj4gIAlwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7Cj4+
ICAJcG1fcnVudGltZV9kb250X3VzZV9hdXRvc3VzcGVuZCgmcGRldi0+ZGV2KTsKPj4gIAljbGtf
dW5wcmVwYXJlKHByaXYtPnJlZmNsayk7Cj4+ICtvdXRfcmVsZWFzZV9pcnFfZ3JvdXA6Cj4+ICsJ
ZGV2cmVzX3JlbGVhc2VfZ3JvdXAoJnBkZXYtPmRldiwgcHJpdik7Cj4+ICBvdXRfcmVzZXRfYXNz
ZXJ0Ogo+PiAgCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KHJzdGMpOwo+PiAgb3V0X2ZyZWVfbmV0ZGV2
Ogo+PiBAQCAtMzE0NCw2ICszMTUzLDcgQEAgc3RhdGljIHZvaWQgcmF2Yl9yZW1vdmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4gIAkJcmV0dXJuOwo+PiAgCj4+ICAJdW5yZWdpc3Rl
cl9uZXRkZXYobmRldik7Cj4+ICsJZGV2cmVzX3JlbGVhc2VfZ3JvdXAoZGV2LCBwcml2KTsKPj4g
IAlpZiAoaW5mby0+bmNfcXVldWVzKQo+PiAgCQluZXRpZl9uYXBpX2RlbCgmcHJpdi0+bmFwaVtS
QVZCX05DXSk7Cj4+ICAJbmV0aWZfbmFwaV9kZWwoJnByaXYtPm5hcGlbUkFWQl9CRV0pOwo+PiAt
LSAKPj4gMi4zNC4xCj4+IAo+Cj4tLSAKPktpbmQgUmVnYXJkcywKPk5pa2xhcyBTw7ZkZXJsdW5k
Cg==
