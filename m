Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.224.83.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529051;
	b=zzUAAi+VZthZRPLMtw1tSF4Arvk93jx4QXrVW4OdG2OKpAIv3UUbNpXek7EMOwxYoNda
	 H6x8tRhf14ntvQ8sP4Qd86jMme+XaoUBWTa+5rCf+ZdRoiGQjHxAJMlM9i0sC3nv71/vu
	 QxdmmfdvGYVUt+iy5dHic7z4IN1xkbxhzRgIREDitoAnFwv3Jkh17OddjKQtEhev43Uq8
	 vV1kHoudUlmf0rVxJVJS9oXx72tRHKKate9KxDT3ntPaHJSko/5Cq75+3O9/gtGz3cnT1
	 HBjFCy4L+ysjnYpE9RFVQZ6sbPUsYX5oayIM6FBNo+IQYXD9pzeWRghWJcg7mwDCq8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529051;
	h=DMARC-Filter:Content-Type:Content-Transfer-Encoding:Message-ID:To:Cc:
	 Subject:X-Priority:X-Mailer:X-Originating-IP:In-Reply-To:References:
	 MIME-Version:Received:From:Date:X-HM-Tid:X-HM-MType:X-HM-NTES-SC:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=zSKRyhmd0FaNVxQea7gNz9sw3xKe3IbUK26AInNTru8=;
	b=xsP4QTYj7OCh51c07HDuvyYLZ5YhAC7KNPhB4lRgalX09J8y2f9zhXs5hvnjOsAnWBjA
	 38b/2T764+CoYNf/mEBWCFPvQGmtBC4QQvROqXJXTD3hULqtcWFarNs9ek/W7OvvOGyDk
	 cOwq3V1MkaylS+JQMUw5sVXfvonogO4EAxPBvfRGg3XVVnGJB4rZfYZ1yTIqCmXZsaF7P
	 aRULzBeycTEr5ri35zxBoq6N0MPX46sNzG94ewNXVxG+16YVaPvplKAFRJFhuZYZcGXGv
	 N0FsFI6FCUljyM3tEEYZRTfD66zBQAAkwQBldZG6IyK8IK8ue2bmCpMuAi7AsVMHYvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=JZqeGIKL;
	arc=none smtp.remote-ip=156.224.83.235
Received: from mail-m83235.xmail.ntesmail.com (mail-m83235.xmail.ntesmail.com [156.224.83.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56C606A31E;
	Tue, 24 Nov 2026 14:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B56C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=JZqeGIKL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ADEAHADeLNTQDfbncJKL7aqN.3.1795529038798.Hmail.202321181@mail.sdu.edu.cn>
To: Nicolas.Ferre@microchip.com
Cc: Ludovic.Desroches@microchip.com, linusw@kernel.org, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gcGluY3RybDogYXQ5MTogRml4IHBvdGVudGlhbCB1c2UtYWZ0ZXItZnJlZSBvbiBtYW51YWwgdW5iaW5k?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
In-Reply-To: <a52a58d4-d452-42e1-be3b-db2df2211549@microchip.com>
References: <20261120173530.3924083-1-liguangshuo@mail.sdu.edu.cn> <a52a58d4-d452-42e1-be3b-db2df2211549@microchip.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 202321181@mail.sdu.edu.cn( [101.76.249.61] ) by ajax-webmail ( [127.0.0.1] ) ; Tue, 24 Nov 2026 22:03:58 +0800 (GMT+08:00)
From: =?UTF-8?B?5p2O5bm/56GV?= <liguangshuo@mail.sdu.edu.cn>
Date: Tue, 24 Nov 2026 22:03:58 +0800 (GMT+08:00)
X-HM-Tid: 0aa20ddea1d6d0cdkusy30eac201248d0
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMVHpP02bZAKsMEiErRSAekjx+ys+KNZNl0PLwl
	f2MeqR5lbiqKsoq8sm3hZVy9q3VetZ+Wq0Te/EdHEVk+2W3XygE0t2b+veD5v+x2w+urvHcVQ88O
	KIeU6xc/wtPDRFdmxrBa9NzKTwXOEkgAJVHto=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkxPVk9KTkJPTRgeQ0xLTlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG
DKIM-Signature: a=rsa-sha256;
	b=JZqeGIKLmmWjY8YmW+rNKvRiTa2lICFPDFYWm2NdF502gPuz8US675aAnc2/5E1GMwSgiWSmUeN14e6SlzIECwULSW4QmzlXJ/JrbsgL3VY1LwkuS86gS6ie2J9vYU+tdNMo3xrTB4lK7ix2EAqSDBzacBVUGfZ3jcVGw4YPJok=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=zSKRyhmd0FaNVxQea7gNz9sw3xKe3IbUK26AInNTru8=;
	h=date:mime-version:subject:message-id:from;

CkhpIE5pY29sYXMsCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuCgpGcm9tOiBOaWNvbGFzLkZlcnJl
QG1pY3JvY2hpcC5jb20KRGF0ZTogMjAyNi0xMS0yMiAyMTowMDozNwpUbzogIGxpZ3VhbmdzaHVv
QG1haWwuc2R1LmVkdS5jbixMdWRvdmljLkRlc3JvY2hlc0BtaWNyb2NoaXAuY29tLGxpbnVzd0Br
ZXJuZWwub3JnLGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tLGNsYXVkaXUuYmV6bmVhQHR1
eG9uLmRldgpDYzogIGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZyxsaW51eC1n
cGlvQHZnZXIua2VybmVsLm9yZyxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcKU3ViamVjdDogUmU6IFtQQVRDSF0gcGluY3RybDogYXQ5MTogRml4IHBv
dGVudGlhbCB1c2UtYWZ0ZXItZnJlZSBvbiBtYW51YWwgdW5iaW5kPk9uIDIwLzExLzIwMjYgYXQg
MTg6MzUsIEd1YW5nc2h1byBMaSB3cm90ZToKPj4gVGhlIGJ1aWx0LWluIEdQSU8gYW5kIHBpbmN0
cmwgZHJpdmVycyBzaGFyZSBHUElPIHJhbmdlcyBhbmQgZ2xvYmFsIGJhbmsKPj4gcG9pbnRlcnMg
YnV0IHByb3ZpZGUgbm8gdGVhcmRvd24gZm9yIHRob3NlIHJlbGF0aW9uc2hpcHMuIE1hbnVhbGx5
Cj4+IHVuYmluZGluZyBhIEdQSU8gYmFuayBmcmVlcyBpdHMgcHJpdmF0ZSBkYXRhIHdoaWxlIHBp
bmN0cmwgc3RpbGwgaG9sZHMKPj4gaXRzIGVtYmVkZGVkIHJhbmdlLCB3aGljaCBpcyBhY2Nlc3Nl
ZCBkdXJpbmcgcGluY3RybCBjbGVhbnVwLgo+PiAKPj4gU3VwcHJlc3MgdGhlIGJpbmQgYXR0cmli
dXRlcyBmb3IgdGhlc2Ugbm9uLXJlbW92YWJsZSBTb0MgY29udHJvbGxlcnMKPj4gc28gdXNlcnNw
YWNlIGNhbm5vdCB0cmlnZ2VyIHRoaXMgdW5zdXBwb3J0ZWQgdGVhcmRvd24uCj4+IAo+PiBUaGlz
IGlzc3VlIHdhcyBmb3VuZCBieSBvdXIgc3RhdGljIGFuYWx5c2lzIHRvb2wgdW5kZXIgZGV2ZWxv
cG1lbnQuCj4KPldlbGwsIHdobyB3aWxsIGV2ZXIgd2FudCB0byByZW1vdmUgZ3BpbyBvciBwaW5j
dHJsIG9uIHRoZXNlIHBsYXRmb3JtcywgCj5rbm93aW5nIHRoYXQgaXQncyBvbmUgYW5kIG9ubHkg
SVAgZm9yIHRoZSB0d28/Cj5Eb2VzIGl0IGhhdmUgYSByZWFsIHVzZS1jYXNlPwo+SSBkb24ndCBz
ZWUgdGhlIHBvaW50Lgo+Cj5SZWdhcmRzLAo+ICAgTmljb2xhcwo+Cj4+IEZpeGVzOiA2NzMyYWU1
Y2I0N2MgKCJBUk06IGF0OTE6IGFkZCBwaW5jdHJsIHN1cHBvcnQiKQo+PiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZwo+PiBTaWduZWQtb2ZmLWJ5OiBHdWFuZ3NodW8gTGkgPGxpZ3VhbmdzaHVv
QG1haWwuc2R1LmVkdS5jbj4KPj4gLS0tCj4+ICAgZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5
MS5jIHwgMiArKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPj4gCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMgYi9kcml2ZXJzL3BpbmN0
cmwvcGluY3RybC1hdDkxLmMKPj4gaW5kZXggMGE1N2VkNTFkNGM5Li44MWI1OGE3YTQ0YmUgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEuYwo+PiArKysgYi9kcml2
ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMKPj4gQEAgLTE5MTEsNiArMTkxMSw3IEBAIHN0YXRp
YyBERUZJTkVfTk9JUlFfREVWX1BNX09QUyhhdDkxX2dwaW9fcG1fb3BzLCBhdDkxX2dwaW9fc3Vz
cGVuZCwgYXQ5MV9ncGlvX3JlCj4+ICAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYXQ5
MV9ncGlvX2RyaXZlciA9IHsKPj4gICAgICAgICAgLmRyaXZlciA9IHsKPj4gICAgICAgICAgICAg
ICAgICAubmFtZSA9ICJncGlvLWF0OTEiLAo+PiArICAgICAgICAgICAgICAgLnN1cHByZXNzX2Jp
bmRfYXR0cnMgPSB0cnVlLAo+PiAgICAgICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IGF0
OTFfZ3Bpb19vZl9tYXRjaCwKPj4gICAgICAgICAgICAgICAgICAucG0gPSBwbV9zbGVlcF9wdHIo
JmF0OTFfZ3Bpb19wbV9vcHMpLAo+PiAgICAgICAgICB9LAo+PiBAQCAtMTkyMCw2ICsxOTIxLDcg
QEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYXQ5MV9ncGlvX2RyaXZlciA9IHsKPj4g
ICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBhdDkxX3BpbmN0cmxfZHJpdmVyID0gewo+
PiAgICAgICAgICAuZHJpdmVyID0gewo+PiAgICAgICAgICAgICAgICAgIC5uYW1lID0gInBpbmN0
cmwtYXQ5MSIsCj4+ICsgICAgICAgICAgICAgICAuc3VwcHJlc3NfYmluZF9hdHRycyA9IHRydWUs
Cj4+ICAgICAgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gYXQ5MV9waW5jdHJsX29mX21h
dGNoLAo+PiAgICAgICAgICB9LAo+PiAgICAgICAgICAucHJvYmUgPSBhdDkxX3BpbmN0cmxfcHJv
YmUsCj4+IAo+PiBiYXNlLWNvbW1pdDogNjYyOGU3ZDRjNmIyNWM4ZDE4ZjEzNDVlM2EyMGQyMTgy
OWFhZTdlNAo+CgpJIGRvbid0IGhhdmUgYSB1c2UgY2FzZSB0aGF0IG5lZWRzIHRoZXNlIGNvbnRy
b2xsZXJzIHRvIGJlIHVuYm91bmQuClRoZSBpbnRlbnRpb24gd2FzIHRvIG1ha2UgdGhlIHN5c2Zz
IGludGVyZmFjZSBtYXRjaCB0aGUgZHJpdmVycycgbGFjawpvZiB0ZWFyZG93biBzdXBwb3J0OiB1
bmJpbmQgaXMgZXhwb3NlZCwgYnV0IG5laXRoZXIgZHJpdmVyIHJlbW92ZXMgdGhlCnNoYXJlZCBH
UElPIHJhbmdlcyBhbmQgYmFuayBwb2ludGVycy4KCldvdWxkIHN1cHByZXNzaW5nIHRoYXQgdW5z
dXBwb3J0ZWQgaW50ZXJmYWNlIGJlIHVzZWZ1bCBoZXJlLCBvciB3b3VsZAp5b3UgcHJlZmVyIHRv
IGxlYXZlIGl0IHVuY2hhbmdlZD8KClRoYW5rcywKR3VhbmdzaHVvCg==
