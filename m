Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466452;
	b=1vluTdA6K9i2zxOwwvi5c7gW8+era/HdI0xA/9GwqEWIQBs/hes4cWsNhOIuI3NEjGmj
	 AGplw9Rc7aEf8pCwv3xPKcBrep+GAsEYQo1fNbflxZVNJM8L+CyTX/bbgvL687OqNbNIb
	 G286lR2PhArbPSmaCUwbk78vH0nqoegb7x2mSyhNZ4xwgVnJDagGyfnEdtltbtcRpI7Cs
	 iiQ0+pkyqD7zGg4PjGoXW35hK1G7Vz/jDysCPvTRFbABF8tmXkebVRH9iJH1+WK6rCaTh
	 UCn4zs1Azi8sXU0Z6dD4ErX6sOJQRk2uAhyA/FNEPCy3whJPz/4P+pVPN98UUTWD6iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466452;
	h=DMARC-Filter:DKIM-Signature:Received:X-Originating-IP:Date:From:To:
	 Cc:Subject:X-Priority:X-Mailer:In-Reply-To:References:X-NTES-SC:
	 Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	 X-Coremail-Locale:X-CM-TRANSID:X-CM-SenderInfo:X-Coremail-Antispam;
	bh=9w5uahAcrB4Q3cZDy78yDCkRWPZKYjgKEi8M73VfoLg=;
	b=0IeKrWSml1DV5E1nR2bzKL5OqrM3wRSSyCAnCnkMC2Wlqldq4QvIPJlVkFmyogh9F68f
	 m7NsgPPThdCy1rKUx5rEbahDtbF/k3hfWLRugArOggt9u2VoOxPnoB6wJ/PwVD9B++h5w
	 owFSXp9n4r4QMws6KHRIZOGG6P8h43tjf/z6hrJWI/S3FAL2bltoIuqdAomdLWiPa4DX0
	 eSSKMFejVEuhk3o3HiO/doAoGCjV4jqBFj6ZKYt0qV5wAz9Afn+Vpvs5bUYS04YFKuWq6
	 I4DSoCMN+VX2dijOJdeUk7cjKeI0ZO4wA846nKzx2rmVddH/Wi7jKZDuh1vhSwUUzxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="RWJcf5F/";
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B8606A319;
	Tue, 20 Oct 2026 03:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 778B8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RWJcf5F/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=9w5uahAcrB4Q3cZDy78yDCkRWPZKYjgKEi8M73VfoLg=; b=R
	WJcf5F/aR4Quea9q7OrvV+aHrH4UobdVEzRGlIs7iJSonQQ3h9RbYfby7iRjxhhz
	ehZFpgb66gxwo2L53y1sHq9VljYq5hn/ncfHUPHQj5ucHMDtLVMdfyXnzNjjruB1
	EbJKOnIC8HLDXaYJd0QBEThWvLw5maCLuODRbYAsxw=
Received: from slark_xiao$163.com (
 [2408:8459:3c10:539b:d4b2:3883:2280:43f4] ) by ajax-webmail-wmsvr-40-103
 (Coremail) ; Tue, 20 Oct 2026 11:20:28 +0800 (CST)
Date: Tue, 20 Oct 2026 11:20:28 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: mani@kernel.org, jeff.hugo@oss.qualcomm.com,
	krishna.chundru@oss.qualcomm.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re:Re: [PATCH] bus: mhi: host: pci_generic: Update the default
 autosuspend_delay_ms as 5000ms
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAFEp6-2XUE4AQPm5hinnRGyrrsHok2ftsFXragiHgDSKKtKWow@mail.gmail.com>
References: <20261019055109.49922-1-slark_xiao@163.com>
 <CAFEp6-2XUE4AQPm5hinnRGyrrsHok2ftsFXragiHgDSKKtKWow@mail.gmail.com>
X-NTES-SC: AL_Qu2SAPiduUwp7iKaZukckk4WhuY7WcOyuPkg2YZSc+wEiCD8/T0YeENYM0fkyPmKLiG8rTuLeSll0dRndoB7gaq5LtroiC5CN9PvgnAYVQ==
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
Message-ID: <70714501.3175.1a157532149.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgDn14X83dZqHH1cAA--.206W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5xwHa2rW3fzSKQAA3x
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjYtMTAtMTkgMTU6NDE6MjcsICJMb2ljIFBvdWxhaW4iIDxsb2ljLnBvdWxhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4gd3JvdGU6Cj5PbiBNb24sIE9jdCAxOSwgMjAyNiBhdCA3OjUy4oCvQU0g
U2xhcmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPiB3cm90ZToKPj4KPj4gRm9yIHNvbWUgTUhJ
IGRldmljZXMgaW4gc29tZSBzcGVjaWZpYyBzY2VuYXJpbywgdGhlIGRlZmF1bHQgdmFsdWUKPj4g
b2YgYXV0b3N1c3BlbmRfZGVsYXlfbXMgbWF5IG5vdCBlbm91Z2ggdG8gaGFuZGxlIGxhc3Qgd2Fr
ZSBldmVudC4KPj4gVGhpcyBtYXkgbGVhZCB0byBzb21lIHVuZXhwZWN0ZWQgcHJvYmxlbXMuCj4+
Cj4+IFJlZmVyIHRvIHRoZSBRdWFsY29tbSdzIFdpbmRvd3Mgc2V0dGluZ3MgYW5kIHdlIGNoZWNr
ZWQgdGhpcyB3aXRoCj4+IFF1YWNsb21tIG92ZXIgY2FzZSwgUXVhbGNvbW0gcmVjb21tZW5kIHVz
IHRvIHNldCB0aGlzIGFzIDUwMDBtcy4KPgo+UXVhbGNvbW0KPgo+PiBRdWFsY29tbSBhbHNvIHN1
Z2dlc3RzIHVzIHRvIHVwZGF0ZSB0aGlzIGZvciBhbGwgTUhJIGRldmljZXMuCj4+IFNpbmNlIHRo
aXMgc2V0dGluZyBoYXMgYWZmZWN0ZWQgc29tZSBleGlzdGVkIGtlcm5lbCB2ZXJzaW9ucywgaXQn
cwo+PiBiZXR0ZXIgdG8gYmUgYXBwbGllZCB0byBzdGFibGUgdmVyc2lvbi4KPgo+VGhpcyBsb29r
cyBtb3JlIGxpa2UgYSB3b3JrYXJvdW5kIHRoYW4gYSBwcm9wZXIgZml4LiBJdCB3b3VsZCBiZQo+
aGVscGZ1bCB0byBkZXNjcmliZSB0aGUgdW5kZXJseWluZyBpc3N1ZSwgaW5jbHVkaW5nIHRoZSB0
aW1pbmcgYW5kCj5zZXF1ZW5jZSBvZiBldmVudHMgdGhhdCBtYWtlIHRoaXMgbmVjZXNzYXJ5LiBJ
biBwcmluY2lwbGUsIGVpdGhlciB0aGUKPmRldmljZSBjYW4gYmUgc3VzcGVuZGVkIGF0IHRoYXQg
cG9pbnQgb3IgaXQgY2Fubm90LiBSZWx5aW5nIG9uIGEKPmRlbGF5ZWQgc3VzcGVuZCBmZWVscyBm
cmFnaWxlIGFuZCBtYXkgZW5kIHVwIG1hc2tpbmcgdGhlIHJlYWwgcHJvYmxlbS4KPgpIaSBMb2lj
LApIb25lc3RseSwgUXVhbGNvbW0gaGFzIGJlZW4gYW5hbHl6aW5nIGZvciBvdmVyIDIgbW9udGhz
IGFuZCBzdGlsbCBoYXNuJ3QKaWRlbnRpZmllZCB0aGUgcm9vdCBjYXVzZS4gCgpBY3R1YWxseSBJ
IGhhdmUgZXhwbGFpbmVkIHRoZSByZWFzb25zIGJlaGluZCB0aGUgZXZlbnRzIHRvIE1hbmkgaW4g
YW5vdGhlcgp0aHJlYWQsIHlvdSBjYW4gcmVmZXIgdG8gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bWhpLzIwMjYwOTE5MDk1NTA2Ljk1NzAtMS1zbGFya194aWFvQDE2My5jb20vCgpGcm9tIFF1YWxj
b21tJ3MgcGVyc3BlY3RpdmUsIDIgc2Vjb25kcyBpcyBub3QgZW5vdWdoIGZvciB0aGVpciBkZWZh
dWx0IGRlc2lnbi4KVGhleSByZWNvbW1lbmRlZCB1cyB0byB1cGRhdGUgdGhpcyB2YWx1ZSB0byA1
IHNlY29uZHMgYW5kIE1hbmkgY2hlY2tlZCB0aGlzCmludGVybmFsbHkgYXMgd2VsbC4gU28gd2Ug
ZGVjaWRlZCB0byB1cGRhdGUgdGhpcyA1IHNlY29uZHMgc2V0dGluZyB0byBhbGwgTUhJIGRldmlj
ZXMuCgpUaGFua3MKPj4KPj4gRml4ZXM6IGQzODAwYzFkY2UyNCAoImJ1czogbWhpOiBwY2lfZ2Vu
ZXJpYzogQWRkIHN1cHBvcnQgZm9yIHJ1bnRpbWUgUE0iKQo+PiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZwo+PiBTaWduZWQtb2ZmLWJ5OiBTbGFyayBYaWFvIDxzbGFya194aWFvQDE2My5jb20+
Cj4+IC0tLQo+PiAgZHJpdmVycy9idXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMuYyB8IDIgKy0KPj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9idXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMuYyBiL2RyaXZlcnMvYnVz
L21oaS9ob3N0L3BjaV9nZW5lcmljLmMKPj4gaW5kZXggNzE5M2EzODRjY2E0Li40MDczNWJlYjQ2
Y2IgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvYnVzL21oaS9ob3N0L3BjaV9nZW5lcmljLmMKPj4g
KysrIGIvZHJpdmVycy9idXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMuYwo+PiBAQCAtMTQ4Myw3ICsx
NDgzLDcgQEAgc3RhdGljIGludCBtaGlfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBj
b25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCj4+Cj4+ICAgICAgICAgLyogQWxsb3cgcnVu
dGltZSBzdXNwZW5kIG9ubHkgaWYgYm90aCBQTUUgZnJvbSBEM0hvdCBhbmQgTTMgYXJlIHN1cHBv
cnRlZCAqLwo+PiAgICAgICAgIGlmIChwY2lfcG1lX2NhcGFibGUocGRldiwgUENJX0QzaG90KSAm
JiAhKGluZm8tPm5vX20zKSkgewo+PiAtICAgICAgICAgICAgICAgcG1fcnVudGltZV9zZXRfYXV0
b3N1c3BlbmRfZGVsYXkoJnBkZXYtPmRldiwgMjAwMCk7Cj4+ICsgICAgICAgICAgICAgICBwbV9y
dW50aW1lX3NldF9hdXRvc3VzcGVuZF9kZWxheSgmcGRldi0+ZGV2LCA1MDAwKTsKPj4gICAgICAg
ICAgICAgICAgIHBtX3J1bnRpbWVfdXNlX2F1dG9zdXNwZW5kKCZwZGV2LT5kZXYpOwo+PiAgICAg
ICAgICAgICAgICAgcG1fcnVudGltZV9tYXJrX2xhc3RfYnVzeSgmcGRldi0+ZGV2KTsKPj4gICAg
ICAgICAgICAgICAgIHBtX3J1bnRpbWVfcHV0X25vaWRsZSgmcGRldi0+ZGV2KTsKPj4gLS0KPj4g
Mi41My4wCj4+Cg==
