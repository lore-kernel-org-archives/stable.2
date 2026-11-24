Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=154.81.10.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529022;
	b=EV2RsXlCXkmR0xllkZxabdcms+KcuxMR4SMDgt9quqGOyWdBL0hljk/BLSiTyDIWTTfB
	 DHJf+m+aenAMhzOJJu6LHYbWKEfW7rD1kcSYqO1e/e7hl/7iw6v3D+CsNXITgeplvsccz
	 H26eAbTZvasAs7kV+qP/k+t9645Yfu7EeSC1qKF7/ManNE5dqaYThtl//+CTZff2CQi6/
	 MoAVBh6iaIZT3R/kwn+R6Lg/KWF9MSfnrQAhUSDe4fBhzo89u5ImlaqKt1Y03i1H9fRGm
	 VTFOiwsJr+6Wb2BOkBdddDfMSDKU5jI37OoTq88WMCe77Xw2V2MIl0sSoRdiPqUhY4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529022;
	h=DMARC-Filter:Content-Type:Content-Transfer-Encoding:Message-ID:To:Cc:
	 Subject:X-Priority:X-Mailer:X-Originating-IP:In-Reply-To:References:
	 MIME-Version:Received:From:Date:X-HM-Tid:X-HM-MType:X-HM-NTES-SC:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=HI3+zRoML73VqUDFgUkem+fi9Zk9wVZtNVO6T+O4umo=;
	b=U0OQkIFDYJHSQ6HPzYGiLazbetJMdpcEAhc5pkoutbd9JpSLhary5zqGbS7yNzYcaNOh
	 bfxH4bxp89LRwHLI7tWVUr/clewjx+5FJEsFAzvxRVbH7SvV9Ly8f75Q0LerpAikihpKu
	 RJ+4KzBQ39/lu1cPHGpzEbNnWpWodagwU4Gd3/8Q8Y1yg7FStQCZ6QZeCRB9TaGYGE4vG
	 uTWI3ZKObeBHjI4yM+RT6ROM5kEhJJuIgxw4hLXmyOx/OtnmfsCY8eaP1mwrA06AIMzh5
	 Ltvlnzm6Qnhyv6t9U9dvG58pUVhHNnO+GM4K2+RQSLKA1RPUnAtpq7FiemdDaYN8WwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b="D/uKJ+0u";
	arc=none smtp.remote-ip=154.81.10.94
Received: from mail-m1094.netease.com (mail-m1094.netease.com [154.81.10.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599DB606A326;
	Tue, 24 Nov 2026 14:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 599DB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=D/uKJ+0u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ALsAxABOLObQtvY4cNh8h4ri.3.1795529011462.Hmail.202321181@mail.sdu.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Neill Kapron <nkapron@google.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	stable@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCAxLzJdIHVzYjogZ2FkZ2V0OiBmc2xfdWRjOiBGaXggcG90ZW50aWFsIHVzZS1hZnRlci1mcmVlIGR1cmluZyByZW1vdmFs?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
In-Reply-To: <2026112015-lumber-flyer-d8f6@gregkh>
References: <20261118-324f82bd41-usb-gadget-0@mail.sdu.edu.cn> <20261118-324f82bd41-usb-gadget-1@mail.sdu.edu.cn> <2026112015-lumber-flyer-d8f6@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 202321181@mail.sdu.edu.cn( [101.76.249.61] ) by ajax-webmail ( [127.0.0.1] ) ; Tue, 24 Nov 2026 22:03:31 +0800 (GMT+08:00)
From: =?UTF-8?B?5p2O5bm/56GV?= <liguangshuo@mail.sdu.edu.cn>
Date: Tue, 24 Nov 2026 22:03:31 +0800 (GMT+08:00)
X-HM-Tid: 0aa20dde1987d0cdkusyef3b67ad248cc
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMVHpP02bZAKsMEiErRSAekjx+ys+KNZNl0PLwl
	f2MeqR5lbiqKsoq8sm3hZVy9q3VetZ+Wq0Te/EdHEVk+2W3XygE0t2b+veD5v+x2w+urvHGDFo8E
	1w4QTE3rOb9NJ317UcvoSbBVgCnZeqAYiPp08=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTktDVh8eSU5PQhpPGk8dSVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG
DKIM-Signature: a=rsa-sha256;
	b=D/uKJ+0uwPuQOme/sVt2TP4G6VPwy62d+GMDXMtIrTTShkyH0r3pSRn8f/YzLIMUeoHDoKJHy2pq070Mr0I4lxhjimhb52/HJvxpCMb1U9efMRFuT/rsq1K7a/QiYST4zIKCVKvR8SUDuWv24uaDQGMhBx0TLMT73Dr5iNTsogI=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=HI3+zRoML73VqUDFgUkem+fi9Zk9wVZtNVO6T+O4umo=;
	h=date:mime-version:subject:message-id:from;

CgoKSGkgR3JlZywKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCgoKRnJvbTogR3JlZyBLcm9haC1I
YXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KRGF0ZTogMjAyNi0xMS0yMCAyMDox
MDo1NApUbzogIEd1YW5nc2h1byBMaSA8bGlndWFuZ3NodW9AbWFpbC5zZHUuZWR1LmNuPgpDYzog
IE5laWxsIEthcHJvbiA8bmthcHJvbkBnb29nbGUuY29tPixsaW51eC11c2JAdmdlci5rZXJuZWwu
b3JnLGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsbGludXhwcGMtZGV2QGxpc3RzLm96bGFi
cy5vcmcsc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gdXNi
OiBnYWRnZXQ6IGZzbF91ZGM6IEZpeCBwb3RlbnRpYWwgdXNlLWFmdGVyLWZyZWUgZHVyaW5nIHJl
bW92YWw+T24gV2VkLCBOb3YgMTgsIDIwMjYgYXQgMTA6MTA6NTNQTSArMDgwMCwgR3VhbmdzaHVv
IExpIHdyb3RlOgo+PiB1c2JfZGVsX2dhZGdldF91ZGMoKSBjYW4gZHJvcCB0aGUgbGFzdCBnYWRn
ZXQgZGV2aWNlIHJlZmVyZW5jZSBhbmQgY2FsbAo+PiBmc2xfdWRjX3JlbGVhc2UoKSwgd2hpY2gg
ZnJlZXMgdWRjX2NvbnRyb2xsZXIuIFRoZSByZW1haW5pbmcgcmVtb3ZlIHBhdGgKPj4gdGhlbiBk
ZXJlZmVyZW5jZXMgaXQgdG8gcmVsZWFzZSBpdHMgcmVxdWVzdHMsIGVuZHBvaW50cyBhbmQgRE1B
IHBvb2wuCj4+IAo+PiBIb2xkIGEgZ2FkZ2V0IGRldmljZSByZWZlcmVuY2UgdW50aWwgdGhpcyBj
bGVhbnVwIGhhcyBmaW5pc2hlZC4KPj4gCj4+IFRoaXMgaXNzdWUgd2FzIGZvdW5kIGJ5IG91ciBz
dGF0aWMgYW5hbHlzaXMgdG9vbCB1bmRlciBkZXZlbG9wbWVudC4KPj4gCj4+IEZpeGVzOiBlYWIz
NWM0ZTZkOTUgKCJ1c2I6IGdhZGdldDogZnNsX3VkY19jb3JlOiBsZXQgdWRjLWNvcmUgbWFuYWdl
IGdhZGdldC0+ZGV2IikKPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPj4gU2lnbmVkLW9m
Zi1ieTogR3VhbmdzaHVvIExpIDxsaWd1YW5nc2h1b0BtYWlsLnNkdS5lZHUuY24+Cj4+IC0tLQo+
PiAgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9mc2xfdWRjX2NvcmUuYyB8IDIgKysKPj4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9nYWRnZXQvdWRjL2ZzbF91ZGNfY29yZS5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9mc2xf
dWRjX2NvcmUuYwo+PiBpbmRleCA4NzhkNzBiNTU1MzAuLjlkOWQyMTY0YzViZiAxMDA2NDQKPj4g
LS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9mc2xfdWRjX2NvcmUuYwo+PiArKysgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2ZzbF91ZGNfY29yZS5jCj4+IEBAIC0yNTM3LDYgKzI1MzcsNyBA
QCBzdGF0aWMgdm9pZCBmc2xfdWRjX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQo+PiAgCURFQ0xBUkVfQ09NUExFVElPTl9PTlNUQUNLKGRvbmUpOwo+PiAgCj4+ICAJdWRjX2Nv
bnRyb2xsZXItPmRvbmUgPSAmZG9uZTsKPj4gKwlnZXRfZGV2aWNlKCZ1ZGNfY29udHJvbGxlci0+
Z2FkZ2V0LmRldik7Cj4KPlRoaXMgZmVlbHMgd3JvbmcsIHdoeSBhcmUgeW91IG5lZWRpbmcgYSBm
YWtlIHJlZmVyZW5jZSBoZXJlPwo+Cj4+ICAJdXNiX2RlbF9nYWRnZXRfdWRjKCZ1ZGNfY29udHJv
bGxlci0+Z2FkZ2V0KTsKPgo+VGhpcyBpcyB3aGVyZSBpdCBzaG91bGQgYWxsIGdvIGF3YXkuICBJ
ZiBub3QsIHRoZW4gcmVvcmRlciB0aGUgY29kZQo+cHJvcGVybHkuCj4KCkkgdW5kZXJzdGFuZCB0
aGF0IHRoZSBkcml2ZXIncyBjbGVhbnVwIHNob3VsZCBwcmVjZWRlIHRoZSBmaW5hbCBnYWRnZXQK
cmVsZWFzZSwgd2l0aG91dCBhZGRpbmcgYW5vdGhlciByZWZlcmVuY2UuIHVzYl9kZWxfZ2FkZ2V0
X3VkYygpIGNvbWJpbmVzCnVucmVnaXN0ZXJpbmcgdGhlIGdhZGdldCB3aXRoIHRoYXQgZmluYWwg
cHV0LgoKV291bGQgdXNpbmcgdXNiX2RlbF9nYWRnZXQoKSBmaXJzdCwgdGhlbiBjbGVhbmluZyB1
cCB0aGUgZHJpdmVyIHJlc291cmNlcwpiZWZvcmUgdXNiX3B1dF9nYWRnZXQoKSwgYmUgdGhlIG9y
ZGVyaW5nIHlvdSBtZWFudCBmb3IgdjI/CgpUaGFua3MsCkd1YW5nc2h1bwo=
