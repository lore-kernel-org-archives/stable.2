Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1A34DB56;
	Fri, 21 Aug 2026 05:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787289333; cv=none; b=S8eANFpbek5JAHWWLQPfGtLsJqgstR1BqvanRuD3jirh101Lh1ZvhzV7LJmMbjzHHLL+VeLFcVfSo7bnC2rGW26zCnmR0I76/KSxGwp4f+lZooUza6LIITkdvN192QQu/j0+p/dkrFYhRurGUJPd1AUoeoaQfh00iaW+9r91rGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787289333; c=relaxed/simple;
	bh=RzCA8Q5r6PCYwGE5ii3tF9ssY3PwmRTb3QhHCA0wOWA=;
	h=Content-Type:MIME-Version:From:To:CC:In-Reply-To:References:
	 Subject:Date:Message-ID; b=IVIHr1C8o78KpxuZXJC3hicy6KS6xzdWap1ERAque1ff9jycyMsTwHoUTgy8A1AJwjHnXd/ztI8a82py47+AFxeCbR2JBRwOz0mnDvq6/jNhd1E8sAz/9cj13vRzoH4bCEfpINaArkX9gzszPxeRh+ubgpSQiXMNCBl5LuEKqQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=longcheer.com; spf=pass smtp.mailfrom=longcheer.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=longcheer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=longcheer.com
Received: from mailsrv01.LongCheer.net
        by ssh247.corpemail.net ((D)) with ESMTP (SSL) id 202608211314114182;
        Fri, 21 Aug 2026 13:14:11 +0800
Received: from [127.0.1.1] (172.16.9.238) by mailsrv01.LongCheer.net
 (172.16.8.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.33; Fri, 21 Aug
 2026 13:14:11 +0800
Content-Type: multipart/mixed;
	boundary="===============8284776919896818264=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: liuqi <liuqi@longcheer.com>
To: <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <870f2627-aeaa-400e-9b6d-ee77eac42be6@mailsrv01.LongCheer.net>
References: <870f2627-aeaa-400e-9b6d-ee77eac42be6@mailsrv01.LongCheer.net>
Subject: Re: [PATCH] usb-storage: prevent concurrent URB submission in usb_stor_msg_common
Date: Fri, 21 Aug 2026 13:14:11 +0800
Message-ID: <08b595fd-215e-400c-b090-df030f8f0ff8@mailsrv01.LongCheer.net>
X-ClientProxiedBy: mailsrv01.LongCheer.net (172.16.8.231) To
 mailsrv01.LongCheer.net (172.16.8.231)
tUid: 202682113141257a998b9ef768ad2cfedb3704c4a103d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

--===============8284776919896818264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

RnJvbSAyMTA0ZmM1N2FhY2M3NDE5N2FhODFhNzJkMjgzY2FkMzM1MWU1OWY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBsaXVxaSA8bGl1cWlAbG9uZ2NoZWVyLmNvbT4KRGF0ZTogRnJp
LCAyMSBBdWcgMjAyNiAxMzowODoxNiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHVzYi1zdG9yYWdl
OiBzZXJpYWxpemUgZW5lX2dldF9jYXJkX3R5cGUoKSB3aXRoIGRldl9tdXRleApUbzogZ3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmcKQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcsCiAgICBz
dGFibGVAdmdlci5rZXJuZWwub3JnCgpJbiBlbmVfdWI2MjUwX3Byb2JlKCksIHRoZSBjYXJkLXR5
cGUgcHJvYmUgKGVuZV9nZXRfY2FyZF90eXBlKCkpIHVzZXMgdGhlCnVzYi1zdG9yYWdlIGJ1bGsg
dHJhbnNmZXIgaGVscGVycyB3aGljaCByZXVzZSB1cy0+Y3VycmVudF91cmIuIEhvd2V2ZXIsCnVz
Yl9zdG9yX3Byb2JlMigpIHNjaGVkdWxlcyBhIGRlbGF5ZWQgc2NhbiB3b3JrIChzY2FuX2R3b3Jr
KSB0aGF0IGFsc28KdXNlcyBjdXJyZW50X3VyYiBmb3IgQnVsa19tYXhfbHVuKCkuIFRoZSBzY2Fu
IHdvcmsgaXMgc2VyaWFsaXplZCB3aXRoCnVzLT5kZXZfbXV0ZXgsIGJ1dCB0aGUgcHJvYmUncyBl
bmVfZ2V0X2NhcmRfdHlwZSgpIGNhbGwgaXMgbm90LgoKVGhpcyBsZWFkcyB0byAiVVJCIHN1Ym1p
dHRlZCB3aGlsZSBhY3RpdmUiIHdhcm5pbmdzIHdoZW4gdGhlIGRlbGF5ZWQKc2NhbiBmaXJlcyBk
dXJpbmcgdGhlIHByb2JlJ3MgZW5lX2dldF9jYXJkX3R5cGUoKSBleGVjdXRpb24uIFRoZSB3YXJu
aW5nCnRyaWdnZXIgaXM6CgogIHVzYl9zdG9yX0J1bGtfbWF4X2x1bigpIC0+IHVzYl9zdG9yX21z
Z19jb21tb24oKSAtPiB1c2Jfc3VibWl0X3VyYigpCgpObyBzY3NpX2VoIGludm9sdmVtZW50IHdh
cyBvYnNlcnZlZCBpbiBzeXpib3QgbG9ncy4KCkZpeCBieSBzZXJpYWxpemluZyBlbmVfZ2V0X2Nh
cmRfdHlwZSgpIHdpdGggdXMtPmRldl9tdXRleC4KClNpZ25lZC1vZmYtYnk6IGxpdXFpIDxsaXVx
aUBsb25nY2hlZXIuY29tPgotLS0KIGRyaXZlcnMvdXNiL3N0b3JhZ2UvZW5lX3ViNjI1MC5jIHwg
MiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL3N0b3JhZ2UvZW5lX3ViNjI1MC5jIGIvZHJpdmVycy91c2Ivc3RvcmFnZS9lbmVfdWI2
MjUwLmMKaW5kZXggMmNmZmM1NTlhLi4xM2IzMzJkMWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNi
L3N0b3JhZ2UvZW5lX3ViNjI1MC5jCisrKyBiL2RyaXZlcnMvdXNiL3N0b3JhZ2UvZW5lX3ViNjI1
MC5jCkBAIC0yMzU4LDcgKzIzNTgsOSBAQCBzdGF0aWMgaW50IGVuZV91YjYyNTBfcHJvYmUoc3Ry
dWN0IHVzYl9pbnRlcmZhY2UgKmludGYsCiAJCXJldHVybiByZXN1bHQ7CiAKIAkvKiBwcm9iZSBj
YXJkIHR5cGUgKi8KKwltdXRleF9sb2NrKCZ1cy0+ZGV2X211dGV4KTsKIAlyZXN1bHQgPSBlbmVf
Z2V0X2NhcmRfdHlwZSh1cywgUkVHX0NBUkRfU1RBVFVTLCBpbmZvLT5iYnVmKTsKKwltdXRleF91
bmxvY2soJnVzLT5kZXZfbXV0ZXgpOwogCWlmIChyZXN1bHQgIT0gVVNCX1NUT1JfWEZFUl9HT09E
KSB7CiAJCXVzYl9zdG9yX2Rpc2Nvbm5lY3QoaW50Zik7CiAJCXJldHVybiBVU0JfU1RPUl9UUkFO
U1BPUlRfRVJST1I7Ci0tIAoyLjQzLjAKCg==

--===============8284776919896818264==--
