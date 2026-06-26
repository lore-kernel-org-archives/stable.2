Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E63DB326;
	Fri, 26 Jun 2026 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456496; cv=none; b=bBqGU0/7bJTd2AmzcpgvV40Hr4vYSGRsMK17AqBxVGsG44nKrVy3gtDZ4FlOvWhwOSug9zFkiuVMWYMXuitZtXkyqHtpcGU6zHf/y8d8WeMUi4AAWugYL5ipT+xVe4L1BIgb596Z6Ja/dRpJI77gue7N63mW1DME1jZJaYlNxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456496; c=relaxed/simple;
	bh=uFlidB/EPvdxjB4gnuihhulpIfPWIs49Y9PSiqC2FTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PY18B/RYfoRQTBnfNDT1XcQZUbFKERoif/b1+nD9sa5uMmQnZlTV3XvzA+a7xA/v+aYdhINpRqB+Aau3iUyySuquB2pxhCpcDNkXnRdYnAh+6NpD2EvTABbWfWe5fv+AsFUU3nyB3K9Dt0PevPvqRsGhspyDZQfIXJErC0+mAQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2eJbEqK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2eJbEqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C7D1F000E9;
	Fri, 26 Jun 2026 06:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782456495;
	bh=uFlidB/EPvdxjB4gnuihhulpIfPWIs49Y9PSiqC2FTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A2eJbEqKVK2R/anS1yDAZ0BvZ34dEvDixOVE4MHj10aWXJmTRIXxr3qXi4KyPovV9
	 o9xWBLJYJwzqBMTIS2236JeHHWoL/habvU/Q7A9nEvnfMnb3LWgzWdAL4ilbPU/YvT
	 ZpurofjqDCQwtV7182y/NbfLyB/cWQHwAAh1TmWPVtWse6d11AwWqbwPZ/WAoChZAw
	 rzEMZ4+5HNvSYyc5DqCTV2qEqnpmuutpptNoKFYDJLPScRnau3WxBGYAuisVWdEz43
	 5/JYjuHXIc80EOPN9w0xjkMRE/QSgUlSaC4IqHDSZHA9DNC+LPTabab7zavDcSAUir
	 j8wLt86GIerKA==
Message-ID: <5a0c6597-6b96-4781-a71b-fd1298b2b7bb@kernel.org>
Date: Fri, 26 Jun 2026 15:48:06 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Qi Zheng <qi.zheng@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20260625151554.55105-1-qi.zheng@linux.dev>
 <aj12aVq3he6q7b2C@cmpxchg.org>
 <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
 <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
 <08cf8972-6cfc-4452-9a3c-88e0368dbbf9@linux.dev>
 <afdaff7c-fe6b-40da-8f54-aeeab8fe8867@kernel.org>
 <90fd5300-1016-42e7-abad-08ad85fb62b4@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <90fd5300-1016-42e7-abad-08ad85fb62b4@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cX5ukXFyQlDiVGJNom11010b"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cX5ukXFyQlDiVGJNom11010b
Content-Type: multipart/mixed; boundary="------------LJvK4Zuc5TCvFT3lxqrCEeNR";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Message-ID: <5a0c6597-6b96-4781-a71b-fd1298b2b7bb@kernel.org>
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
References: <20260625151554.55105-1-qi.zheng@linux.dev>
 <aj12aVq3he6q7b2C@cmpxchg.org>
 <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
 <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
 <08cf8972-6cfc-4452-9a3c-88e0368dbbf9@linux.dev>
 <afdaff7c-fe6b-40da-8f54-aeeab8fe8867@kernel.org>
 <90fd5300-1016-42e7-abad-08ad85fb62b4@linux.dev>
In-Reply-To: <90fd5300-1016-42e7-abad-08ad85fb62b4@linux.dev>

--------------LJvK4Zuc5TCvFT3lxqrCEeNR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

DQoNCk9uIDYvMjYvMjYgMzoyNCBQTSwgUWkgWmhlbmcgd3JvdGU6DQo+IA0KPiANCj4gT24g
Ni8yNi8yNiAxMjo1OSBQTSwgSGFycnkgWW9vIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiA2LzI2
LzI2IDE6NDggUE0sIFFpIFpoZW5nIHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiA2LzI2LzI2
IDEyOjQzIFBNLCBIYXJyeSBZb28gd3JvdGU6DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDYvMjYv
MjYgMTE6MjcgQU0sIFFpIFpoZW5nIHdyb3RlOg0KPj4+Pj4gSGkgSm9oYW5uZXMsDQo+Pj4+
Pg0KPj4+Pj4gT24gNi8yNi8yNiAyOjQxIEFNLCBKb2hhbm5lcyBXZWluZXIgd3JvdGU6DQo+
Pj4+Pj4gT24gVGh1LCBKdW4gMjUsIDIwMjYgYXQgMTE6MTU6NTRQTSArMDgwMCwgUWkgWmhl
bmcgd3JvdGU6DQo+Pj4+Pj4+IEZyb206IFFpIFpoZW5nIDx6aGVuZ3FpLmFyY2hAYnl0ZWRh
bmNlLmNvbT4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVGhlIG1nbHJ1IHBhZ2UgdGFibGUgd2Fsa2Vy
IGJhdGNoZXMgcGVyLWdlbmVyYXRpb24gc2l6ZSBkZWx0YXMgaW4NCj4+Pj4+Pj4gd2Fsay0+
bnJfcGFnZXMgd2hpbGUgd2Fsa2luZyBwYWdlIHRhYmxlcyB3aXRob3V0IGhvbGRpbmcgdGhl
IGxydXZlYw0KPj4+Pj4+PiBsb2NrLg0KPj4+Pj4+PiBUaGUgcmVzZXRfYmF0Y2hfc2l6ZSgp
IGxhdGVyIGZvbGRzIHRob3NlIGRlbHRhcyBpbnRvIHdhbGstPmxydXZlYw0KPj4+Pj4+PiB1
bmRlcg0KPj4+Pj4+PiB0aGUgbHJ1dmVjIGxvY2suDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoZSBw
YWdlIHRhYmxlIHdhbGtlciBjYW4gcnVuIGNvbmN1cnJlbnRseSB3aXRoIHRoZSBtZW1jZw0K
Pj4+Pj4+PiByZXBhcmVudGluZw0KPj4+Pj4+PiBwYXRoDQo+Pj4+Pj4+IGFzIGZvbGxvd3M6
DQo+Pj4+Pj4+DQo+Pj4+Pj4+IENQVTDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIENQVTENCj4+Pj4+Pj4gPT09PcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPT09PQ0KPj4+Pj4+Pg0K
Pj4+Pj4+PiB3YWxrX21tDQo+Pj4+Pj4+IC0tPiB3YWxrX3BhZ2VfcmFuZ2UNCj4+Pj4+Pj4g
wqDCoMKgwqDCoMKgIC0tPiB1cGRhdGVfYmF0Y2hfc2l6ZQ0KPj4+Pj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAtLT4gd2Fsay0+bnJfcGFnZXMgKz0gZGVsdGENCj4+Pj4+Pj4NCj4+Pj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBtZW1fY2dyb3VwX2Nzc19vZmZsaW5lDQo+Pj4+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLS0+IG1lbWNnX3JlcGFyZW50X29iamNncw0KPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLS0+IGxvY2sgbHJ1dmVjDQo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGxydV9nZW5fcmVwYXJlbnRfbWVtY2cNCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLS0+IHJlcGFyZW50IGNoaWxkDQo+Pj4+Pj4+IGZvbGlvcyB0bw0KPj4+Pj4+PiBw
YXJlbnQNCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5sb2NrIGxydXZl
Yw0KPj4+Pj4+Pg0KPj4+Pj4+PiDCoMKgwqDCoMKgwqAgbG9jayBscnV2ZWMNCj4+Pj4+Pj4g
wqDCoMKgwqDCoMKgIHJlc2V0X2JhdGNoX3NpemUNCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgIC0t
PiBjaGlsZCBscnVnZW4tPm5yX3BhZ2VzICs9IGRlbHRhDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRo
aXMgd2lsbCB0cmlnZ2VyIHRoZSBmb2xsb3dpbmcgd2FybmluZyBpbiBscnVfZ2VuX2V4aXRf
bWVtY2coKToNCj4+Pj4+Pj4NCj4+Pj4+Pj4gwqDCoMKgwqDCoCBWTV9XQVJOX09OX09OQ0Uo
bWVtY2hyX2ludihscnV2ZWMtPmxydWdlbi5ucl9wYWdlcywgMCwNCj4+Pj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YobHJ1dmVjLT5scnVn
ZW4ubnJfcGFnZXMpKSk7DQo+Pj4+Pj4+DQo+Pj4+Pj4+IEFuZCB0aGUgdXNlci12aXNpYmxl
IGltcGFjdCBvZiB1bmRlcmVzdGltYXRlZCBucl9wYWdlcyBpbiBNR0xSVSB3YXMNCj4+Pj4+
Pj4gcHJlbWF0dXJlIE9PTXMgYmVjYXVzZSBNR0xSVSBkb2VzIG5vdCB0cnkgdG8gcmVjbGFp
bSBtZW1vcnkgd2hlbg0KPj4+Pj4+PiBucl9wYWdlcw0KPj4+Pj4+PiByZWFjaGVzIHplcm8s
IGJ1dCB0aGVyZSBhcmUgc3RpbGwgbW9yZSBwYWdlcy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVG8g
Zml4IGl0LCBtYWtlIHJlc2V0X2JhdGNoX3NpemUoKSBjaGVjayBDU1NfRFlJTkcgdW5kZXIg
UkNVIGJlZm9yZQ0KPj4+Pj4+PiBmbHVzaGluZyB0aGUgcGVuZGluZyBiYXRjaC4gQSBub24t
ZHlpbmcgbWVtY2cga2VlcHMgdGhlIG9yaWdpbmFsDQo+Pj4+Pj4+IGxydXZlYw0KPj4+Pj4+
PiBzdGFibGUgYWdhaW5zdCBSQ1UtZGVsYXllZCBvZmZsaW5pbmc7IGEgZHlpbmcgbWVtY2cg
cmVkaXJlY3RzIHRoZQ0KPj4+Pj4+PiBkZWx0YXMNCj4+Pj4+Pj4gdG8gdGhlIGZpcnN0IG5v
bi1keWluZyBhbmNlc3Rvci4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gUmVwb3J0ZWQtYnk6IFBlaXlh
bmcgSGUgPHBlaXlhbmdfaGVAc21haWwubmp1LmVkdS5jbj4NCj4+Pj4+Pj4gQ2xvc2VzOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNUE5RTkyOUQ4MjcxNzEwMSsxMmZjZjY0My0N
Cj4+Pj4+Pj4gZWZiOC00YjlhLWE1M2EtMWUyOGNjODk0ZjBiQHNtYWlsLm5qdS5lZHUuY24N
Cj4+Pj4+Pj4gRml4ZXM6IGYzMDQ2NTI2MDllYSAoIm1tOiB2bXNjYW46IHByZXBhcmUgZm9y
IHJlcGFyZW50aW5nIE1HTFJVDQo+Pj4+Pj4+IGZvbGlvcyIpDQo+Pj4+Pj4+IENjOiA8c3Rh
YmxlQHZnZXIua2VybmVsLm9yZz4NCj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUWkgWmhlbmcg
PHpoZW5ncWkuYXJjaEBieXRlZGFuY2UuY29tPg0KPj4+Pj4+PiAtLS0NCj4+Pj4+Pj4gQ2hh
bmdlcyBpbiB2MzoNCj4+Pj4+Pj4gwqDCoMKgIC0gcmUtaW1wbGVtZW50IGxvY2tfYmF0Y2hf
bHJ1dmVjKCkgYnkgY2hlY2tpbmcgQ1NTX0RZSU5HDQo+Pj4+Pj4+IHVuZGVyIHRoZQ0KPj4+
Pj4+PiBSQ1UgbG9jaw0KPj4+Pj4+PiDCoMKgwqDCoMKgIChzdWdnZXN0ZWQgYnkgSGFycnkp
DQo+Pj4+Pj4+IMKgwqDCoCAtIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UgKHN1Z2dlc3Rl
ZCBieSBIYXJyeSkNCj4+Pj4+Pj4gwqDCoMKgIC0gdGVtcG9yYXJpbHkgZHJvcCB0aGUgcHJl
dmlvdXMgUmV2aWV3ZWQtYnkgdGFncw0KPj4+Pj4+PiDCoMKgwqDCoMKgIChzaW5jZSB0aGUg
c3luYyBtZXRob2QgaGFzIGNoYW5nZWQpDQo+Pj4+Pj4+IMKgwqDCoCAtIHJlYmFzZSBvbnRv
IHRoZSBuZXh0LTIwMjYwNjI0DQo+Pj4+Pj4+DQo+Pj4+Pj4+IENoYW5nZXMgaW4gdjI6DQo+
Pj4+Pj4+IMKgwqDCoCAtIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UgKHBvaW50ZWQgYnkg
QmFycnkpDQo+Pj4+Pj4+IMKgwqDCoCAtIGNvbGxlY3QgUmV2aWV3ZWQtYnkNCj4+Pj4+Pj4N
Cj4+Pj4+Pj4gwqDCoMKgIG1tL3Ztc2Nhbi5jIHwgNDUgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tDQo+Pj4+Pj4+IMKgwqDCoCAxIGZpbGUgY2hhbmdl
ZCwgMzggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4NCj4+Pj4+Pj4g
ZGlmZiAtLWdpdCBhL21tL3Ztc2Nhbi5jIGIvbW0vdm1zY2FuLmMNCj4+Pj4+Pj4gaW5kZXgg
MzVjM2JiMTVhZTk2Li4xZWM4YzIzYzcyYjkgMTAwNjQ0DQo+Pj4+Pj4+IC0tLSBhL21tL3Zt
c2Nhbi5jDQo+Pj4+Pj4+ICsrKyBiL21tL3Ztc2Nhbi5jDQo+Pj4+Pj4+IEBAIC0zMjYyLDEw
ICszMjYyLDQ0IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9iYXRjaF9zaXplKHN0cnVjdA0KPj4+
Pj4+PiBscnVfZ2VuX21tX3dhbGsgKndhbGssIHN0cnVjdCBmb2xpbyAqZm9saW8sDQo+Pj4+
Pj4+IMKgwqDCoMKgwqDCoMKgIHdhbGstPm5yX3BhZ2VzW25ld19nZW5dW3R5cGVdW3pvbmVd
ICs9IGRlbHRhOw0KPj4+Pj4+PiDCoMKgwqAgfQ0KPj4+Pj4+PiDCoMKgwqAgKyNpZmRlZiBD
T05GSUdfTUVNQ0cNCj4+Pj4+Pj4gK3N0YXRpYyBzdHJ1Y3QgbHJ1dmVjICpsb2NrX2JhdGNo
X2xydXZlYyhzdHJ1Y3QgbHJ1dmVjICpscnV2ZWMpDQo+Pj4+Pj4+ICt7DQo+Pj4+Pj4+ICvC
oMKgwqAgc3RydWN0IHBnbGlzdF9kYXRhICpwZ2RhdCA9IGxydXZlY19wZ2RhdChscnV2ZWMp
Ow0KPj4+Pj4+PiArwqDCoMKgIHN0cnVjdCBtZW1fY2dyb3VwICptZW1jZyA9IGxydXZlY19t
ZW1jZyhscnV2ZWMpOw0KPj4+Pj4+PiArDQo+Pj4+Pj4+ICvCoMKgwqAgcmN1X3JlYWRfbG9j
aygpOw0KPj4+Pj4+DQo+Pj4+Pj4gV2hlcmUgaXMgdGhpcyB1bmxvY2tlZD8NCj4+Pj4+DQo+
Pj4+PiBUaGUgbHJ1dmVjX3VubG9ja19pcnEoKSBpbiByZXNldF9iYXRjaF9zaXplKCkgd2ls
bCBoYW5kbGUgdGhlDQo+Pj4+PiB1bmxvY2tpbmcuDQo+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4+
ICvCoMKgwqAgLyoNCj4+Pj4+Pj4gK8KgwqDCoMKgICogVGhlIG1lbWNnIGNhbiBiZSBOVUxM
IHdoZW4gdGhlIG1lbW9yeSBjb250cm9sbGVyIGlzDQo+Pj4+Pj4+IGRpc2FibGVkLg0KPj4+
Pj4+PiArwqDCoMKgwqAgKiBPdGhlcndpc2UsIHRoZSBjYWxsZXIga2VlcHMgdGhlIG1lbWNn
IG93bmluZyBAbHJ1dmVjIGFsaXZlLg0KPj4+Pj4+PiArwqDCoMKgwqAgKi8NCj4+Pj4+Pj4g
K8KgwqDCoCBpZiAoIW1lbWNnIHx8ICFjc3NfaXNfZHlpbmcoJm1lbWNnLT5jc3MpKQ0KPj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgZ290byBsb2NrOw0KPj4+Pj4+PiArDQo+Pj4+Pj4+ICvC
oMKgwqAgZG8gew0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgbWVtY2cgPSBwYXJlbnRfbWVt
X2Nncm91cChtZW1jZyk7DQo+Pj4+Pj4+ICvCoMKgwqAgfSB3aGlsZSAobWVtY2cgJiYgY3Nz
X2lzX2R5aW5nKCZtZW1jZy0+Y3NzKSk7DQo+Pj4+Pj4+ICvCoMKgwqAgbHJ1dmVjID0gbWVt
X2Nncm91cF9scnV2ZWMobWVtY2csIHBnZGF0KTsNCj4+Pj4+Pg0KPj4+Pj4+IMKgwqDCoMKg
wqAgd2hpbGUgKHVubGlrZWx5KG1lbWNnICYmIGNzc19pc19keWluZygmbWVtY2ctPmNzcykp
KSB7DQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNnID0gcGFyZW50X21lbV9jZ3Jv
dXAobWVtY2cpOw0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBscnV2ZWMgPSBtZW1fY2dy
b3VwX2xydXZlYyhtZW1jZywgcGdkYXQpOw0KPj4+Pj4NCj4+Pj4+IFRoZXJlIGlzIG5vIG5l
ZWQgdG8gYWNxdWlyZSB0aGUgbHJ1dmVjIGJlZm9yZSBmaW5kaW5nIHRoZSBmaXJzdA0KPj4+
Pj4gbm9uLWR5aW5nIG1lbWNnLg0KPj4+Pg0KPj4+PiBzdHJ1Y3QgcGdsaXN0X2RhdGEgKnBn
ZGF0ID0gbHJ1dmVjX3BnZGF0KGxydXZlYyk7DQo+Pj4+IHN0cnVjdCBtZW1fY2dyb3VwICpt
ZW1jZyA9IGxydXZlY19tZW1jZyhscnV2ZWMpOw0KPj4+Pg0KPj4+PiByY3VfcmVhZF9sb2Nr
KCkNCj4+Pj4NCj4+Pj4gd2hpbGUgKHVubGlrZWx5KG1lbWNnX2lzX2R5aW5nKG1lbWNnKSkp
DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1jZyA9IHBhcmVudF9tZW1fY2dyb3VwKG1l
bWNnKTsNCj4+Pj4NCj4+Pj4gbHJ1dmVjID0gbWVtX2Nncm91cF9scnV2ZWMobWVtY2csIHBn
ZGF0KTsNCj4+Pg0KPj4+IElmIHRoZSBmaXJzdCBtZW1jZyBpcyBhbHJlYWR5IG5vbi1keWlu
ZywgdGhlcmUncyBubyBuZWVkIHRvIHJlLWFjcXVpcmUNCj4+PiB0aGUgbHJ1dmVjLiA7KQ0K
Pj4NCj4+IE9oLCByaWdodCA6KQ0KPj4NCj4+IEhtbSBidXQgSSBzdGlsbCB0aGluayBKb2hh
bm5lcycgc3VnZ2VzdGlvbiBtYWtlcyB0aGUgY29kZSBjbGVhbmVyLg0KPiANCj4gSSBkb24n
dCBoYXZlIGEgc3Ryb25nIHByZWZlcmVuY2Ugb24gd2hpY2ggb2YgdGhlIHR3byBjb2Rpbmcg
c3R5bGVzIGlzDQo+IG1vcmUgcmVhZGFibGUuIEJUVywgaXMgdGhlcmUgYW55IGtlcm5lbCBk
b2N1bWVudGF0aW9uIEkgY291bGQgcmVmZXIgdG8NCj4gZm9yIHRoaXM/DQoNCkkgZG9uJ3Qg
dGhpbmsgdGhlcmUncyBhIGNvZGluZyBzdHlsZSBndWlkZSB0aGF0IHNwZWNpZmljYWxseQ0K
bWVudGlvbnMgdGhpcy4gSnVzdCB0aG91Z2h0IGl0J3MgY2xlYW5lciBiZWNhdXNlIGl0IG1l
cmdlcyBpZiAoLi4uKSBnb3RvDQpsb2NrOyBhbmQgZG8td2hpbGUgaW50byBhIHNpbmdsZSB3
aGlsZSBsb29wLg0KDQo+PiBPYnNlcnZpbmcgYSBkeWluZyBjZ3JvdXAgc2hvdWxkIGJlIHJh
cmUgYW55d2F5LCBpdCdzIHdvcnRoIGZvY3VzaW5nDQo+PiBtb3JlIG9uIHJlYWRhYmlsaXR5
Pw0KPiANCj4gV2hpbGUgaXQncyByYXJlIHRvIGVuY291bnRlciBjb25zZWN1dGl2ZSBkeWlu
ZyBtZW1jZ3MsIGl0IGNhbiBzdGlsbA0KPiBoYXBwZW4sIHJpZ2h0Pw0KDQpCdXQgaXMgd29y
dGggc2F2aW5nIGEgZmV3IGluc3RydWN0aW9uIGluIGEgYmFzaWMgYmxvY2sgdGhhdCBpcw0K
dW5saWtlbHkoKSB0byBiZSBleGVjdXRlZD8NCg0KSSdtIG5vdCBhIG1lbWNnIG1haW50YWlu
ZXIgbXlzZWxmLCB0aG91Z2guIGp1c3QgbXkgMiBjZW50cy4NCg0KLS0gDQpDaGVlcnMsDQpI
YXJyeSAvIEh5ZW9uZ2dvbg0KDQo=

--------------LJvK4Zuc5TCvFT3lxqrCEeNR--

--------------cX5ukXFyQlDiVGJNom11010b
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaj4gpgAKCRCGXBN6rc5S
1rDcAP4ygpzRUkuMkjporBYJzPsnen0DkH09BkvSo7aiybr/HQD/eDhGLFt5NxEM
eb8EG9w1TyS+gbQJoKUa33njhsKqEwc=
=ScuO
-----END PGP SIGNATURE-----

--------------cX5ukXFyQlDiVGJNom11010b--
