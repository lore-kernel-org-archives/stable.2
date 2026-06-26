Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1E211A14;
	Fri, 26 Jun 2026 04:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782449061; cv=none; b=d1knizGCgDLNjrXx2hwluh7IG4iryEXFIF8Cwnd/tSlnHVT/9sCgz01vKBnGS4FtJZbLD0DNK6kHYpN1AVFMm3rQDdIVUTpbc7mPPvEnTo2kvcNC38JZPJ7UuCYCx4NaWS7n4AmBGbDpdkM6uxJub4LBJVcPAH5d/cy0l0HClMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782449061; c=relaxed/simple;
	bh=Cze1Qa+nUCNkuh98Ig4KQ8ORjyuPr/owezKtaxE/ZO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqAl1fQM6c6J0SToTYzT/LTbQ0SRa2YUvDeZ3dJCACJKeb+DC5c7ydYqfgw8O6fDuevoVZ7nYJ5jK7qYDj0m1kgCtDOkedX/SxbtB+G2KU9hp8E1qbWn0oUkZxcsQIC2TdX4+DUltewTi05ZOy923jwQ8eNNh209Ulzwkg9DknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC0Whhqb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC0Whhqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C525B1F000E9;
	Fri, 26 Jun 2026 04:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782449060;
	bh=Cze1Qa+nUCNkuh98Ig4KQ8ORjyuPr/owezKtaxE/ZO4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LC0WhhqbdrDLIPT0IU57lhF1a1Jgdd3D6pnqyHHEwKIgTo547QF3ZwMODuLA6RAKG
	 d20e09AECLe0sM8wijsIwtXk0CYNJyKDbgS+DGlYit/hPmiaOqjRcHSFKQ3kBaLn1Z
	 w9No/6u/gYzd+LSSDOXt9hz8AxoPEeJFYlNr6Ov8tMUmTbeaqXe+xmY77HqFRDCejp
	 71yFj43ijpubQB1FQgK7lFm3GjdYvujYMnAMlu4RT4hNOfkXmWaEdOnIvJZuxrIr0h
	 XyNsgYwzjsaFiG30759W5To9BLmPdnOuvd87cdPA0P11CbxQqmXuskWyy+rf4qxeik
	 zmu/jBCDgI9mw==
Message-ID: <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
Date: Fri, 26 Jun 2026 13:43:51 +0900
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
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fcwqKtIO63ZLewB9aZtXCNcM"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fcwqKtIO63ZLewB9aZtXCNcM
Content-Type: multipart/mixed; boundary="------------VRdUl5kGxsFl2YszOtn90VkD";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Message-ID: <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
References: <20260625151554.55105-1-qi.zheng@linux.dev>
 <aj12aVq3he6q7b2C@cmpxchg.org>
 <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
In-Reply-To: <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>

--------------VRdUl5kGxsFl2YszOtn90VkD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

DQoNCk9uIDYvMjYvMjYgMTE6MjcgQU0sIFFpIFpoZW5nIHdyb3RlOg0KPiBIaSBKb2hhbm5l
cywNCj4gDQo+IE9uIDYvMjYvMjYgMjo0MSBBTSwgSm9oYW5uZXMgV2VpbmVyIHdyb3RlOg0K
Pj4gT24gVGh1LCBKdW4gMjUsIDIwMjYgYXQgMTE6MTU6NTRQTSArMDgwMCwgUWkgWmhlbmcg
d3JvdGU6DQo+Pj4gRnJvbTogUWkgWmhlbmcgPHpoZW5ncWkuYXJjaEBieXRlZGFuY2UuY29t
Pg0KPj4+DQo+Pj4gVGhlIG1nbHJ1IHBhZ2UgdGFibGUgd2Fsa2VyIGJhdGNoZXMgcGVyLWdl
bmVyYXRpb24gc2l6ZSBkZWx0YXMgaW4NCj4+PiB3YWxrLT5ucl9wYWdlcyB3aGlsZSB3YWxr
aW5nIHBhZ2UgdGFibGVzIHdpdGhvdXQgaG9sZGluZyB0aGUgbHJ1dmVjDQo+Pj4gbG9jay4N
Cj4+PiBUaGUgcmVzZXRfYmF0Y2hfc2l6ZSgpIGxhdGVyIGZvbGRzIHRob3NlIGRlbHRhcyBp
bnRvIHdhbGstPmxydXZlYyB1bmRlcg0KPj4+IHRoZSBscnV2ZWMgbG9jay4NCj4+Pg0KPj4+
IFRoZSBwYWdlIHRhYmxlIHdhbGtlciBjYW4gcnVuIGNvbmN1cnJlbnRseSB3aXRoIHRoZSBt
ZW1jZyByZXBhcmVudGluZw0KPj4+IHBhdGgNCj4+PiBhcyBmb2xsb3dzOg0KPj4+DQo+Pj4g
Q1BVMMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgQ1BVMQ0KPj4+ID09PT3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgID09PT0NCj4+Pg0KPj4+IHdhbGtfbW0NCj4+PiAtLT4gd2Fsa19w
YWdlX3JhbmdlDQo+Pj4gwqDCoMKgwqAgLS0+IHVwZGF0ZV9iYXRjaF9zaXplDQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoCAtLT4gd2Fsay0+bnJfcGFnZXMgKz0gZGVsdGENCj4+Pg0KPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtZW1fY2dyb3VwX2Nzc19vZmZsaW5lDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0tPiBtZW1jZ19yZXBh
cmVudF9vYmpjZ3MNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtLT4gbG9jayBscnV2ZWMNCj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxydV9nZW5fcmVwYXJlbnRfbWVtY2cNCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC0tPiByZXBhcmVudCBjaGlsZCBmb2xpb3MgdG8NCj4+PiBw
YXJlbnQNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVubG9jayBscnV2ZWMNCj4+Pg0K
Pj4+IMKgwqDCoMKgIGxvY2sgbHJ1dmVjDQo+Pj4gwqDCoMKgwqAgcmVzZXRfYmF0Y2hfc2l6
ZQ0KPj4+IMKgwqDCoMKgIC0tPiBjaGlsZCBscnVnZW4tPm5yX3BhZ2VzICs9IGRlbHRhDQo+
Pj4NCj4+PiBUaGlzIHdpbGwgdHJpZ2dlciB0aGUgZm9sbG93aW5nIHdhcm5pbmcgaW4gbHJ1
X2dlbl9leGl0X21lbWNnKCk6DQo+Pj4NCj4+PiDCoMKgwqDCoFZNX1dBUk5fT05fT05DRSht
ZW1jaHJfaW52KGxydXZlYy0+bHJ1Z2VuLm5yX3BhZ2VzLCAwLA0KPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YobHJ1dmVjLT5scnVnZW4ubnJfcGFn
ZXMpKSk7DQo+Pj4NCj4+PiBBbmQgdGhlIHVzZXItdmlzaWJsZSBpbXBhY3Qgb2YgdW5kZXJl
c3RpbWF0ZWQgbnJfcGFnZXMgaW4gTUdMUlUgd2FzDQo+Pj4gcHJlbWF0dXJlIE9PTXMgYmVj
YXVzZSBNR0xSVSBkb2VzIG5vdCB0cnkgdG8gcmVjbGFpbSBtZW1vcnkgd2hlbg0KPj4+IG5y
X3BhZ2VzDQo+Pj4gcmVhY2hlcyB6ZXJvLCBidXQgdGhlcmUgYXJlIHN0aWxsIG1vcmUgcGFn
ZXMuDQo+Pj4NCj4+PiBUbyBmaXggaXQsIG1ha2UgcmVzZXRfYmF0Y2hfc2l6ZSgpIGNoZWNr
IENTU19EWUlORyB1bmRlciBSQ1UgYmVmb3JlDQo+Pj4gZmx1c2hpbmcgdGhlIHBlbmRpbmcg
YmF0Y2guIEEgbm9uLWR5aW5nIG1lbWNnIGtlZXBzIHRoZSBvcmlnaW5hbCBscnV2ZWMNCj4+
PiBzdGFibGUgYWdhaW5zdCBSQ1UtZGVsYXllZCBvZmZsaW5pbmc7IGEgZHlpbmcgbWVtY2cg
cmVkaXJlY3RzIHRoZSBkZWx0YXMNCj4+PiB0byB0aGUgZmlyc3Qgbm9uLWR5aW5nIGFuY2Vz
dG9yLg0KPj4+DQo+Pj4gUmVwb3J0ZWQtYnk6IFBlaXlhbmcgSGUgPHBlaXlhbmdfaGVAc21h
aWwubmp1LmVkdS5jbj4NCj4+PiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC81QTlFOTI5RDgyNzE3MTAxKzEyZmNmNjQzLQ0KPj4+IGVmYjgtNGI5YS1hNTNhLTFlMjhj
Yzg5NGYwYkBzbWFpbC5uanUuZWR1LmNuDQo+Pj4gRml4ZXM6IGYzMDQ2NTI2MDllYSAoIm1t
OiB2bXNjYW46IHByZXBhcmUgZm9yIHJlcGFyZW50aW5nIE1HTFJVIGZvbGlvcyIpDQo+Pj4g
Q2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFFpIFpo
ZW5nIDx6aGVuZ3FpLmFyY2hAYnl0ZWRhbmNlLmNvbT4NCj4+PiAtLS0NCj4+PiBDaGFuZ2Vz
IGluIHYzOg0KPj4+IMKgIC0gcmUtaW1wbGVtZW50IGxvY2tfYmF0Y2hfbHJ1dmVjKCkgYnkg
Y2hlY2tpbmcgQ1NTX0RZSU5HIHVuZGVyIHRoZQ0KPj4+IFJDVSBsb2NrDQo+Pj4gwqDCoMKg
IChzdWdnZXN0ZWQgYnkgSGFycnkpDQo+Pj4gwqAgLSB1cGRhdGUgdGhlIGNvbW1pdCBtZXNz
YWdlIChzdWdnZXN0ZWQgYnkgSGFycnkpDQo+Pj4gwqAgLSB0ZW1wb3JhcmlseSBkcm9wIHRo
ZSBwcmV2aW91cyBSZXZpZXdlZC1ieSB0YWdzDQo+Pj4gwqDCoMKgIChzaW5jZSB0aGUgc3lu
YyBtZXRob2QgaGFzIGNoYW5nZWQpDQo+Pj4gwqAgLSByZWJhc2Ugb250byB0aGUgbmV4dC0y
MDI2MDYyNA0KPj4+DQo+Pj4gQ2hhbmdlcyBpbiB2MjoNCj4+PiDCoCAtIHVwZGF0ZSB0aGUg
Y29tbWl0IG1lc3NhZ2UgKHBvaW50ZWQgYnkgQmFycnkpDQo+Pj4gwqAgLSBjb2xsZWN0IFJl
dmlld2VkLWJ5DQo+Pj4NCj4+PiDCoCBtbS92bXNjYW4uYyB8IDQ1ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAzOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdp
dCBhL21tL3Ztc2Nhbi5jIGIvbW0vdm1zY2FuLmMNCj4+PiBpbmRleCAzNWMzYmIxNWFlOTYu
LjFlYzhjMjNjNzJiOSAxMDA2NDQNCj4+PiAtLS0gYS9tbS92bXNjYW4uYw0KPj4+ICsrKyBi
L21tL3Ztc2Nhbi5jDQo+Pj4gQEAgLTMyNjIsMTAgKzMyNjIsNDQgQEAgc3RhdGljIHZvaWQg
dXBkYXRlX2JhdGNoX3NpemUoc3RydWN0DQo+Pj4gbHJ1X2dlbl9tbV93YWxrICp3YWxrLCBz
dHJ1Y3QgZm9saW8gKmZvbGlvLA0KPj4+IMKgwqDCoMKgwqAgd2Fsay0+bnJfcGFnZXNbbmV3
X2dlbl1bdHlwZV1bem9uZV0gKz0gZGVsdGE7DQo+Pj4gwqAgfQ0KPj4+IMKgICsjaWZkZWYg
Q09ORklHX01FTUNHDQo+Pj4gK3N0YXRpYyBzdHJ1Y3QgbHJ1dmVjICpsb2NrX2JhdGNoX2xy
dXZlYyhzdHJ1Y3QgbHJ1dmVjICpscnV2ZWMpDQo+Pj4gK3sNCj4+PiArwqDCoMKgIHN0cnVj
dCBwZ2xpc3RfZGF0YSAqcGdkYXQgPSBscnV2ZWNfcGdkYXQobHJ1dmVjKTsNCj4+PiArwqDC
oMKgIHN0cnVjdCBtZW1fY2dyb3VwICptZW1jZyA9IGxydXZlY19tZW1jZyhscnV2ZWMpOw0K
Pj4+ICsNCj4+PiArwqDCoMKgIHJjdV9yZWFkX2xvY2soKTsNCj4+DQo+PiBXaGVyZSBpcyB0
aGlzIHVubG9ja2VkPw0KPiANCj4gVGhlIGxydXZlY191bmxvY2tfaXJxKCkgaW4gcmVzZXRf
YmF0Y2hfc2l6ZSgpIHdpbGwgaGFuZGxlIHRoZSB1bmxvY2tpbmcuDQo+IA0KPj4NCj4+PiAr
wqDCoMKgIC8qDQo+Pj4gK8KgwqDCoMKgICogVGhlIG1lbWNnIGNhbiBiZSBOVUxMIHdoZW4g
dGhlIG1lbW9yeSBjb250cm9sbGVyIGlzIGRpc2FibGVkLg0KPj4+ICvCoMKgwqDCoCAqIE90
aGVyd2lzZSwgdGhlIGNhbGxlciBrZWVwcyB0aGUgbWVtY2cgb3duaW5nIEBscnV2ZWMgYWxp
dmUuDQo+Pj4gK8KgwqDCoMKgICovDQo+Pj4gK8KgwqDCoCBpZiAoIW1lbWNnIHx8ICFjc3Nf
aXNfZHlpbmcoJm1lbWNnLT5jc3MpKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGxvY2s7
DQo+Pj4gKw0KPj4+ICvCoMKgwqAgZG8gew0KPj4+ICvCoMKgwqDCoMKgwqDCoCBtZW1jZyA9
IHBhcmVudF9tZW1fY2dyb3VwKG1lbWNnKTsNCj4+PiArwqDCoMKgIH0gd2hpbGUgKG1lbWNn
ICYmIGNzc19pc19keWluZygmbWVtY2ctPmNzcykpOw0KPj4+ICvCoMKgwqAgbHJ1dmVjID0g
bWVtX2Nncm91cF9scnV2ZWMobWVtY2csIHBnZGF0KTsNCj4+DQo+PiDCoMKgwqDCoHdoaWxl
ICh1bmxpa2VseShtZW1jZyAmJiBjc3NfaXNfZHlpbmcoJm1lbWNnLT5jc3MpKSkgew0KPj4g
wqDCoMKgwqDCoMKgwqAgbWVtY2cgPSBwYXJlbnRfbWVtX2Nncm91cChtZW1jZyk7DQo+PiDC
oMKgwqDCoMKgwqDCoCBscnV2ZWMgPSBtZW1fY2dyb3VwX2xydXZlYyhtZW1jZywgcGdkYXQp
Ow0KPiANCj4gVGhlcmUgaXMgbm8gbmVlZCB0byBhY3F1aXJlIHRoZSBscnV2ZWMgYmVmb3Jl
IGZpbmRpbmcgdGhlIGZpcnN0DQo+IG5vbi1keWluZyBtZW1jZy4NCg0Kc3RydWN0IHBnbGlz
dF9kYXRhICpwZ2RhdCA9IGxydXZlY19wZ2RhdChscnV2ZWMpOw0Kc3RydWN0IG1lbV9jZ3Jv
dXAgKm1lbWNnID0gbHJ1dmVjX21lbWNnKGxydXZlYyk7DQoNCnJjdV9yZWFkX2xvY2soKQ0K
DQp3aGlsZSAodW5saWtlbHkobWVtY2dfaXNfZHlpbmcobWVtY2cpKSkNCiAgICAgICAgbWVt
Y2cgPSBwYXJlbnRfbWVtX2Nncm91cChtZW1jZyk7DQoNCmxydXZlYyA9IG1lbV9jZ3JvdXBf
bHJ1dmVjKG1lbWNnLCBwZ2RhdCk7DQpzcGluX2xvY2tfaXJxKCZscnV2ZWMtPmxydV9sb2Nr
KTsNCg0KcmV0dXJuIGxydXZlYzsNCg0Kc2hvdWxkIHdvcms/DQoNCmlmIHRoZSBtZW1vcnkg
Y29udHJvbGxlciBpcyBkaXNhYmxlZCwgaXQncyBlcXVpdmFsZW50IHRvOg0KDQpyY3VfcmVh
ZF9sb2NrKCk7DQpzcGluX2xvY2tfaXJxKCZscnV2ZWMtPmxydV9sb2NrKTsNCnJldHVybiBs
cnV2ZWM7DQoNCi0tIA0KQ2hlZXJzLA0KSGFycnkgLyBIeWVvbmdnb24NCg0K

--------------VRdUl5kGxsFl2YszOtn90VkD--

--------------fcwqKtIO63ZLewB9aZtXCNcM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaj4DhwAKCRCGXBN6rc5S
1g0jAP4gPmEfwbi90g27GCghV+IzxczoQOCOWa20F/P8O/GaGQEAz9q0GcAIPYvQ
X1vtqvldrANXaQpzeDsROAQOZoUadAo=
=taly
-----END PGP SIGNATURE-----

--------------fcwqKtIO63ZLewB9aZtXCNcM--
