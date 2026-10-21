Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578381;
	b=Yr4QPbk9l6U3c6LrfIpNC4aaxL4dkCnp2oM0Xdx698LNTl1D4x2V1DHIue2gLzBxil2R
	 yZ5OSC9V0pG5OAMojbpUXgF+go3mQiuq5INniQY+KkpHVl/HOM+K5glJPX3Ftqn83JIl2
	 W3K4szYkeITm13qNCWx6AhQY8tMi6VAtXqGGKiVGvc8etmIiu1dcxHe/QXUkHcx1b+eaF
	 1zr/mQ6YgNJYsgCd4x9KJnAa7AC/g/w9ibAgkf+VXqqvjDdlwSUwJ8rl3Sv24v6sb+sFq
	 /E9DSLNspkvPMiXAmlQVpqczrMPoBY3Zf6MuQPS+ajLrEFT4q2kfcLYjnOW7jwltVxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578381;
	h=DMARC-Filter:DKIM-Signature:Received:X-Originating-IP:Date:From:To:
	 Cc:Subject:X-Priority:X-Mailer:In-Reply-To:References:X-NTES-SC:
	 Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	 X-Coremail-Locale:X-CM-TRANSID:X-CM-SenderInfo:X-Coremail-Antispam;
	bh=THn4vf0WmM9gASDJiZm+zWzqXjDDcV8NyV2K//0Z5jk=;
	b=yfM/f9ZAf1KAVEiBQnzM45kfwFTYsT9JRHjnmrfvtw3JpWGmY6KmoxVV/DEw2fa1wxMW
	 mve8+YlaO3zw8bCD60m+ziGvm+ayppIIPb8ZRSEnQDtciRmjpxykFn5xpsTZQMzpCknCU
	 q0Bnedrr3fRbGd1wF6Sq/xB1Wbxl0seZm4ZL77Tjij8YUBDzYS/d5o0WItfpncpOh5PoL
	 I8A5xL5WLynyqNaxXVpKbJNz+sYwFR5ub7/kxyZT023mRPbI7tU/T+LR4LfUHd9Y/TV0D
	 nLtOy2wdf6rgTVRnTeuVwkjIx0WLketPH+zOwkC2gcWu41SaH2NvlOIHBXhzdVsbpqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TqcMEr6C;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802F606A324;
	Wed, 21 Oct 2026 10:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0802F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TqcMEr6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=THn4vf0WmM9gASDJiZm+zWzqXjDDcV8NyV2K//0Z5jk=; b=T
	qcMEr6CnhNyNlT9zCwdI2AeXGYuy/aLS/Rc2tEDg3XWsXpUOdxqL1Us6tvimP3dz
	vlh5+1Ne0u3QGsLFyWogxyFvU5WO5Eiet30mKZ+P4kQpQERldUvQS3UvcDsf5rua
	tFxsC18Atjwyb6MHIQn+NuFJe5Sbs5VJxOtDOLjcoQ=
Received: from slark_xiao$163.com (
 [2408:8459:3c60:67ec:11ce:97fc:3b30:e8ab] ) by ajax-webmail-wmsvr-40-131
 (Coremail) ; Wed, 21 Oct 2026 18:25:51 +0800 (CST)
Date: Wed, 21 Oct 2026 18:25:51 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Val Packett" <val@packett.cool>
Cc: mani@kernel.org, jeff.hugo@oss.qualcomm.com,
	krishna.chundru@oss.qualcomm.com, loic.poulain@oss.qualcomm.com,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re:Re: [PATCH v2] bus: mhi: host: pci_generic: Update the default
 autosuspend_delay_ms as 5000ms
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <bfc5414e-5616-4a64-becc-d16c2b01ecf4@packett.cool>
References: <20261021024038.17127-1-slark_xiao@163.com>
 <bfc5414e-5616-4a64-becc-d16c2b01ecf4@packett.cool>
X-NTES-SC: AL_Qu2SAPmct0su5yaebekckk4WhuY7WcOyuPkg2YZSc84FvxzN2wMjTVZPMkH1wt6tJh6KlTGsdjF2xuBhfpFXasRVWrbzS1a+UW0sZuwzsg==
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
Message-ID: <47bdad69.9245.1a15dfef241.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gygvCgD3n2kvk9hqZdMmAA--.472W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC6A-AJWrYky8y2QAA3n
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI2LTEwLTIxIDEzOjIyOjQ4LCAiVmFsIFBhY2tldHQiIDx2YWxAcGFja2V0dC5jb29s
PiB3cm90ZToKPgo+T24gMTAvMjAvMjYgMTE6NDAgUE0sIFNsYXJrIFhpYW8gd3JvdGU6Cj4+IEZv
ciBzb21lIE1ISSBkZXZpY2VzIGluIHNvbWUgc3BlY2lmaWMgc2NlbmFyaW8sIHRoZSBkZWZhdWx0
IHZhbHVlCj4+IG9mIGF1dG9zdXNwZW5kX2RlbGF5X21zIG1heSBub3QgZW5vdWdoIHRvIGhhbmRs
ZSBsYXN0IHdha2UgZXZlbnQuCj5NaXNzaW5nIHZlcmIuLiBtYXkgbm90ICpiZSogZW5vdWdoCj4+
IFRoaXMgbWF5IGxlYWQgdG8gc29tZSB1bmV4cGVjdGVkIHByb2JsZW1zLgo+U291bmRzIHZhZ3Vl
LCBhcmUgdGhlcmUgYW55IGV4YW1wbGVzIG9mIHRoZSBwcm9ibGVtcz8gQSBzaG9ydCAKPmRlc2Ny
aXB0aW9uIG9mIGEgY29uY3JldGUgZXJyb3IgbWVzc2FnZSBvciBzb21ldGhpbmcgd291bGQgYmUg
bmljZS4KPj4gUmVmZXIgdG8gdGhlIFF1YWxjb21tJ3MgV2luZG93cyBzZXR0aW5ncyBhbmQgd2Ug
Y2hlY2tlZCB0aGlzIHdpdGgKPj4gUXVhY2xvbW0gb3ZlciBjYXNlLCBRdWFsY29tbSByZWNvbW1l
bmQgdXMgdG8gc2V0IHRoaXMgYXMgNTAwMG1zLgo+Cj5zcGVsbGlpaWlpbmcuIFF1YWNsb21tPyA6
KQo+Cj4oYWxzbyAib3ZlciBjYXNlIiBzb3VuZHMgb2RkKQo+Cj4+IFF1YWxjb21tIGFsc28gc3Vn
Z2VzdHMgdXMgdG8gdXBkYXRlIHRoaXMgZm9yIGFsbCBNSEkgZGV2aWNlcy4KPj4gU2luY2UgdGhp
cyBzZXR0aW5nIGhhcyBhZmZlY3RlZCBzb21lIGV4aXN0ZWQga2VybmVsIHZlcnNpb25zLCBpdCdz
Cj4+IGJldHRlciB0byBiZSBhcHBsaWVkIHRvIHN0YWJsZSB2ZXJzaW9uLgo+UGxlYXNlIGxlYXZl
IHRoZSAibWV0YSIgc3R1ZmYgYWJvdXQgd2hlcmUgdGhlIGNvbW1pdCBhcHBsaWVzIG91dHNpZGUg
b2YgCj50aGUgY29tbWl0IG1lc3NhZ2UuCj4+IEZpeGVzOiBkMzgwMGMxZGNlMjQgKCJidXM6IG1o
aTogcGNpX2dlbmVyaWM6IEFkZCBzdXBwb3J0IGZvciBydW50aW1lIFBNIikKPj4gQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcKPj4gU2lnbmVkLW9mZi1ieTogU2xhcmsgWGlhbyA8c2xhcmtfeGlh
b0AxNjMuY29tPgo+PiAtLS0KPj4gdjI6IGRlZmluZSBhIGF1dG9zdXNwZW5kIGRlbGF5IHRpbWVv
dXQgYW5kIGV4cGxhaW4gdGhlIHJlYXNvbgo+PiAtLS0KPj4gICBkcml2ZXJzL2J1cy9taGkvaG9z
dC9wY2lfZ2VuZXJpYy5jIHwgNSArKysrLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYnVzL21oaS9o
b3N0L3BjaV9nZW5lcmljLmMgYi9kcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jCj4+
IGluZGV4IDcxOTNhMzg0Y2NhNC4uMWY1MjU0Mjc5NGQ3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jCj4+ICsrKyBiL2RyaXZlcnMvYnVzL21oaS9ob3N0
L3BjaV9nZW5lcmljLmMKPj4gQEAgLTIxLDYgKzIxLDkgQEAKPj4gICAKPj4gICAjZGVmaW5lIE1I
SV9QT1NUX1JFU0VUX0RFTEFZX01TIDIwMDAKPj4gICAKPj4gKy8qIEFkZCBkZWZpbmUgb2YgIGlu
aXRpYWwgYXV0b3N1c3BlbmRfZGVsYXlfbXMgdG8gYWNjb21tb2RhdGUgYSBwb3RlbnRpYWwgJ2xh
dGUgd2FrZS1ldmVudCcgaXNzdWUgKi8KPgo+Tm90IGEgdmVyeSBuZWNlc3NhcnkgY29tbWVudCwg
YnV0IGlmIHlvdSBkbyBhZGQgaXQsIHBsZWFzZSBkb24ndCB3cml0ZSAKPnRoaW5ncyBsaWtlICJB
ZGQgZGVmaW5lIG9mIi4gVGhpcyAqaXMqIHRoZSBkZWZpbmUsIHdlJ3JlIGxvb2tpbmcgYXQgaXQu
Lgo+Cj5BbHNvLCBpdCdzIG5vdCAiaW5pdGlhbCIgaWYgaXQncyBub3QgYSB0dW5hYmxlIG9yIGFu
eXRoaW5nLCBpdCdzIGp1c3QgCj4qdGhlKiBkZWxheSB2YWx1ZS4KPgpUaGFua3MgZm9yIHlvdXIg
Z29vZCBzdWdnZXN0aW9uLiBXaWxsIGNvbW1pdCBhIFYzIHZlcnNpb24gbGF0ZXIuCgo+PiArI2Rl
ZmluZSBNSElfQVVUT1NVU1BFTkRfREVMQVlfTVMgNTAwMAo+PiArCj4+ICAgI2RlZmluZSBIRUFM
VEhfQ0hFQ0tfUEVSSU9EIChIWiAqIDIpCj4+ICAgCj4+ICAgLyogUENJIFZJRCBkZWZpbml0aW9u
cyAqLwo+PiBAQCAtMTQ4Myw3ICsxNDg2LDcgQEAgc3RhdGljIGludCBtaGlfcGNpX3Byb2JlKHN0
cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCj4+ICAg
Cj4+ICAgCS8qIEFsbG93IHJ1bnRpbWUgc3VzcGVuZCBvbmx5IGlmIGJvdGggUE1FIGZyb20gRDNI
b3QgYW5kIE0zIGFyZSBzdXBwb3J0ZWQgKi8KPj4gICAJaWYgKHBjaV9wbWVfY2FwYWJsZShwZGV2
LCBQQ0lfRDNob3QpICYmICEoaW5mby0+bm9fbTMpKSB7Cj4+IC0JCXBtX3J1bnRpbWVfc2V0X2F1
dG9zdXNwZW5kX2RlbGF5KCZwZGV2LT5kZXYsIDIwMDApOwo+PiArCQlwbV9ydW50aW1lX3NldF9h
dXRvc3VzcGVuZF9kZWxheSgmcGRldi0+ZGV2LCBNSElfQVVUT1NVU1BFTkRfREVMQVlfTVMpOwo+
PiAgIAkJcG1fcnVudGltZV91c2VfYXV0b3N1c3BlbmQoJnBkZXYtPmRldik7Cj4+ICAgCQlwbV9y
dW50aW1lX21hcmtfbGFzdF9idXN5KCZwZGV2LT5kZXYpOwo+PiAgIAkJcG1fcnVudGltZV9wdXRf
bm9pZGxlKCZwZGV2LT5kZXYpOwo+Cj4KPlRoYW5rcywKPn52YWwK
