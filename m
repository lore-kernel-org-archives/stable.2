Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.79.60.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092250;
	b=jfOWuX0+NtJ1T6oFueqNnXid5GrSMADIalbIrBoe/D3Ad68vwfG//R+hEIT8FFrxc5KV
	 7a/aSynHuHs0suamyO3pIkOHFVn1k71DWMTriMG9CDP7Z0l7Ed9qZkRt8+RUDZZzeLVb/
	 tCiBxqvuqgWiDT2dQLs+28jAM5tFXRlMGHQwsXEBTGQrKyp51rNBDspxWswYzuE+t7R0J
	 /wff+nw5V3RsxLdU7RlUwoURgTimcPURVIQ3PNrmOk5kkwokrJjqVEoxgPkaVifsSZ5fQ
	 wOLr6FTgKb1gGWL9QUq2eNXOBNSYUKvRukxRRjCoUFnu5+yRmT09mheerfj8Skx7SQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092250;
	h=DMARC-Filter:Content-Type:Content-Transfer-Encoding:Message-ID:To:Cc:
	 Subject:X-Priority:X-Mailer:X-Originating-IP:In-Reply-To:References:
	 MIME-Version:Received:From:Date:X-HM-Tid:X-HM-MType:X-HM-NTES-SC:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=qLPZEX0epsWd7es1kW82u4+2WFeyQwtuYOTDlogKltk=;
	b=MDJ1Kaij4XeY4hgOc27yfJXvedOkkPPkS4OBdG4DfPEeuiQhBSqPFwyMHqDTNOwSO1zo
	 rtdI1FyPK2Ke7YSMCjCpuQ7wK4KPNlC3I1FG758qVSg5vqjyAwqo/kNs7UudEas7OAPge
	 LIHZ6xPTmWduLQPxh2BYk29jS3Dgw/Ed6195R/iFrDCDp2HChXYDiziJ/NQBEq743hF7b
	 sO1q964KT2b9J/SrmYKNu68smv/ZTQ7aubsDwOT7CGd1hjOhsMlxI2IVujAmoEzDH3qe/
	 fd+II+28VVm4jdLIit3zdqr1CRvDAPKhTEcIX76w8MnwAYRLdRkNHI2LKDMZbSqxnsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b="eaiTa/aG";
	arc=none smtp.remote-ip=210.79.60.96
Received: from mail-m6096.netease.com (mail-m6096.netease.com [210.79.60.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD1E606A338;
	Thu, 19 Nov 2026 12:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBD1E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=eaiTa/aG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ACoAEgCeLDq4C5*UjRtdZKp9.3.1795092235677.Hmail.202321181@mail.sdu.edu.cn>
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	linux-omap@vger.kernel.org, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCAzLzZdIG1mZDogcGFsbWFzOiBGaXggcG90ZW50aWFsIElSUSBhY3Rpb24gbGVha3Mgb24gcmVtb3ZhbA==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
In-Reply-To: <179370041880.793788.14407997006744050474@kernel.org>
References: <cover.1793377422.mfd.git.liguangshuo@mail.sdu.edu.cn> <fe4ee2ff4b3ad6675a46a169d6de6410db32b652.1793377422.git.liguangshuo@mail.sdu.edu.cn> <179370041880.793788.14407997006744050474@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 202321181@mail.sdu.edu.cn( [101.76.249.61] ) by ajax-webmail ( [127.0.0.1] ) ; Thu, 19 Nov 2026 20:43:55 +0800 (GMT+08:00)
From: =?UTF-8?B?5p2O5bm/56GV?= <liguangshuo@mail.sdu.edu.cn>
Date: Thu, 19 Nov 2026 20:43:55 +0800 (GMT+08:00)
X-HM-Tid: 0aa1f3d57aaed0cdkusycbd0c45d1600e
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMVHpP02bZAKsMEiErRSAekjx+ys+KNZNl0PLwl
	f2MeqR5lbiqKsoq8sm3hZVy9q3VVBNOjIUwfWq1GfV2NBR9WJV5pp9Gwt04oeFjraKOA9z4Ebfb5
	HaGbLSL75hBggy81rjpsAjN1bCk8YhhNfCILQ=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTBkdVkMfTh9MSBgeSRpMTFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG
DKIM-Signature: a=rsa-sha256;
	b=eaiTa/aGsGbIQ/8Mdo5kvUqyOX9/1GaNuGgnh/funKCyHIn8yUSpxUTYtsujWX0yle5mnVu1/4y+PjYrYQQ26EboSFFmN/+QyOMw0LqqbyJLNPYs9ERCjMBoYGU1N9XIqp4d0XHYG3a6Ne020O5REcTbn1YfFEjJBzO+khZfua8=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=qLPZEX0epsWd7es1kW82u4+2WFeyQwtuYOTDlogKltk=;
	h=date:mime-version:subject:message-id:from;

CkhpIExlZSwKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCkZyb206IExlZSBKb25lcyA8bGVlQGtl
cm5lbC5vcmc+CkRhdGU6IDIwMjYtMTEtMTMgMjE6MDk6MTgKVG86ICBHdWFuZ3NodW8gTGkgPGxp
Z3VhbmdzaHVvQG1haWwuc2R1LmVkdS5jbj4KQ2M6ICBzdGFibGVAdmdlci5rZXJuZWwub3JnLEFh
cm8gS29za2luZW4gPGFhcm8ua29za2luZW5AaWtpLmZpPixBbmRyZWFzIEtlbW5hZGUgPGFuZHJl
YXNAa2VtbmFkZS5pbmZvPixLZXZpbiBIaWxtYW4gPGtoaWxtYW5AYmF5bGlicmUuY29tPixSb2dl
ciBRdWFkcm9zIDxyb2dlcnFAa2VybmVsLm9yZz4sVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRl
LmNvbT4sbGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmcsbWZkQGxpc3RzLmxpbnV4LmRldixsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnClN1YmplY3Q6IFJlOiBbUEFUQ0ggMy82XSBtZmQ6IHBh
bG1hczogRml4IHBvdGVudGlhbCBJUlEgYWN0aW9uIGxlYWtzIG9uIHJlbW92YWw+T24gU2F0LCAz
MSBPY3QgMjAyNiwgR3VhbmdzaHVvIExpIHdyb3RlOgo+Cj4+IFRoZSByZW1vdmUgY2FsbGJhY2sg
ZGVsZXRlcyB0aGUgSVJRIGNoaXAgYmVmb3JlIG1hbmFnZWQgT0YgY2hpbGRyZW4KPj4gYXJlIHJl
bW92ZWQuIFRoZWlyIGxhdGVyIGZyZWVfaXJxKCkgY2FsbHMgY2Fubm90IGZpbmQgdGhlIGRpc3Bv
c2VkIElSUQo+PiBkZXNjcmlwdG9ycywgcG90ZW50aWFsbHkgbGVha2luZyBpbnRlcnJ1cHQgYWN0
aW9ucy4gRGVwb3B1bGF0ZSB0aGUKPj4gY2hpbGRyZW4gYmVmb3JlIGRlbGV0aW5nIHRoZSBJUlEg
Y2hpcCBhbmQgYXV4aWxpYXJ5IEkyQyBjbGllbnRzLgo+Pgo+PiBUaGlzIGlzc3VlIHdhcyBmb3Vu
ZCBieSBvdXIgc3RhdGljIGFuYWx5c2lzIHRvb2wgdW5kZXIgZGV2ZWxvcG1lbnQuCj4+Cj4+IEZp
eGVzOiAxMjRlOWRlYjFjNDAgKCJtZmQ6IHBhbG1hczogVXNlIGRldm1fb2ZfcGxhdGZvcm1fcG9w
dWxhdGUoKSIpCj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4+IEFzc2lzdGVkLWJ5OiBP
cGVuQUk6Z3B0LTYtYXN0cmEKPj4gU2lnbmVkLW9mZi1ieTogR3VhbmdzaHVvIExpIDxsaWd1YW5n
c2h1b0BtYWlsLnNkdS5lZHUuY24+Cj4+IC0tLQo+PiBCdWlsZC10ZXN0ZWQgdGhlIGNoYW5nZWQg
b2JqZWN0IHdpdGggeDg2XzY0IGRlZmNvbmZpZyBwbHVzIENPTVBJTEVfVEVTVAo+PiBhbmQgdGhl
IGRyaXZlciBkZXBlbmRlbmNpZXMgKFc9MSkuCj4+IE5vIHJ1bnRpbWUgb3IgZmF1bHQtaW5qZWN0
aW9uIHRlc3Rpbmcgd2FzIHBlcmZvcm1lZC4KPj4KPj4gIGRyaXZlcnMvbWZkL3BhbG1hcy5jIHwg
MyArKysKPj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbWZkL3BhbG1hcy5jIGIvZHJpdmVycy9tZmQvcGFsbWFzLmMKPj4gaW5kZXgg
N2ZjODg2ZjRmODBlLi44YTBiN2IxZTg5ZDcgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbWZkL3Bh
bG1hcy5jCj4+ICsrKyBiL2RyaXZlcnMvbWZkL3BhbG1hcy5jCj4+IEBAIC02NzcsNiArNjc3LDkg
QEAgc3RhdGljIHZvaWQgcGFsbWFzX2kyY19yZW1vdmUoc3RydWN0IGkyY19jbGllbnQgKmkyYykK
Pj4gIAlzdHJ1Y3QgcGFsbWFzICpwYWxtYXMgPSBpMmNfZ2V0X2NsaWVudGRhdGEoaTJjKTsKPj4g
IAlpbnQgaTsKPj4KPj4gKwlpZiAoaTJjLT5kZXYub2Zfbm9kZSkKPj4gKwkJZGV2bV9vZl9wbGF0
Zm9ybV9kZXBvcHVsYXRlKCZpMmMtPmRldik7Cj4KPkkgdGhpbmsgaXQgd291bGQgYmUgbmljZSB0
byBkZXZtXyogcmVnbWFwX2FkZF9pcnFfY2hpcCgpIGluc3RlYWQuCj4KPklmIHlvdSBhbHNvIGNv
bnZlcnQgdGhlIGF1eGlsaWFyeSBJMkMgY2xpZW50cyBhbmQgJ3BtX3Bvd2VyX29mZicKPnRlYXJk
b3duIHRvIGRldm0sIHlvdSBjb3VsZCBkcm9wIHBhbG1hc19pMmNfcmVtb3ZlKCkgYWx0b2dldGhl
ci4KPgo+PiArCj4+ICAJcmVnbWFwX2RlbF9pcnFfY2hpcChwYWxtYXMtPmlycSwgcGFsbWFzLT5p
cnFfZGF0YSk7Cj4+Cj4+ICAJZm9yIChpID0gMTsgaSA8IFBBTE1BU19OVU1fQ0xJRU5UUzsgaSsr
KSB7Cj4KPi0tIAo+TGVlIEpvbmVzCj4KClRoZSBJUlEgY2hpcCBpcyByZWdpc3RlcmVkIGJlZm9y
ZSBkZXZtX29mX3BsYXRmb3JtX3BvcHVsYXRlKCkuIFdpdGgKZGV2bV9yZWdtYXBfYWRkX2lycV9j
aGlwKCksIHRoZSBjaGlsZHJlbiB3b3VsZCBiZSByZW1vdmVkIHdoaWxlIHRoZWlyCklSUSBtYXBw
aW5ncyBhcmUgc3RpbGwgdmFsaWQuCgpJZiB0aGUgYXV4aWxpYXJ5IEkyQyBjbGllbnRzIGFuZCB0
aGUgcG93ZXItb2ZmIGhhbmRsZXIgdXNlIG1hbmFnZWQKY2xlYW51cCB0b28sIEkgdGhpbmsgcGFs
bWFzX2kyY19yZW1vdmUoKSBjYW4gZ28gYXdheS4gSXMgdGhhdCB3aGF0IHlvdQpoYWQgaW4gbWlu
ZD8gSWYgc28sIEknbGwgc2VuZCBhIHYyIGZvciBwYWxtYXMgYWxvbmcgdGhvc2UgbGluZXMuCgpU
aGFua3MsCkd1YW5nc2h1bwo=
