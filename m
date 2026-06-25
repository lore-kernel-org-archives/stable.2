Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E2221DB3;
	Thu, 25 Jun 2026 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782353397; cv=none; b=OwBZvlLVidNFo5EafF/oi6+QibzuGfxWVxSThr5m8Lg+6QvVwKCMu+o0FaW9A+RCx+qnjQrx3doARVCjIiLM/8nqSNxdJIwroW/hV2E3HiAlEzIPp+l/lkIxLOQIlY6zsVYIR2JQGCJ63fdXPpRJUlfepmD7jKSGR3OZ9Yc4/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782353397; c=relaxed/simple;
	bh=SIzx6P6m/uXY3xFhV06qM0vpTeruR97c00MXBUL9bvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=F0ozrs/zbdmu1QRE4EOlcm9icBcbh2T9/8Q+KvkBm4KsTdZ8Xh8qdzO5GGdyuGXFGn+YueOEw/vUPjMzfgdjm2Wnun+rPA+TO7n+hWOdwCZubY3/WDSvg3YkJDqgwRvydwHR6YZoU9fVDgBELt6FaWCMsFX9zCQ9REODfFrxFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pbGQKSqV; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pbGQKSqV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=SIzx6P6m/uXY3xFhV06qM0vpTeruR97c00MXBUL9bvw=; b=p
	bGQKSqVz/gf6PK3qoEQyNN9qsGnQxnZCehQ/XGF4X7sL0Y7M5i9CnIFt4o8v3OMD
	dJLsJiRKG0r36ZWH9pm9AqsvqOgKTGRG//rR4PZ3lZGhaKiSFJz5rfbpqQXVN5f/
	dKyqiMa9H6w0xSPgv96AitkbSSVhnrOX699dALCd5Y=
Received: from haoxiang_li2024$163.com (
 [240e:604:311:e68d:6832:a84c:abe2:7179] ) by ajax-webmail-wmsvr-40-140
 (Coremail) ; Thu, 25 Jun 2026 10:09:10 +0800 (CST)
Date: Thu, 25 Jun 2026 10:09:10 +0800 (CST)
From: haoxiang_li2024  <haoxiang_li2024@163.com>
To: "Paul Menzel" <pmenzel@molgen.mpg.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, yangyingliang@huawei.com,
	mst@redhat.com, error27@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re:Re: [PATCH] Bluetooth: virtio_bt: unregister HCI device on open
 failure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <17c94df1-3659-4d21-b327-ad52d498ba9c@molgen.mpg.de>
References: <20260624084333.2885144-1-haoxiang_li2024@163.com>
 <17c94df1-3659-4d21-b327-ad52d498ba9c@molgen.mpg.de>
X-NTES-SC: AL_Qu2TAP+evEsu5iebZukfmUwSj+s8WsO0vf4i245fO5B+jB/o4Q4tRFhsE0Xk4MWRNDqAryW1XBl/2v17bIpVcY8WCgTKpxqsvFou/vOZx0GQYQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7d587d87.1fca.19efc89d056.Coremail.haoxiang_li2024@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jCgvCgD3nzXGjTxqcyAQAA--.606W
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxgY+rGo8jcaXhgAA3e
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIFBhdWwsCgpBdCAyMDI2LTA2LTI0IDE3OjEwOjU1LCAiUGF1bCBNZW56ZWwiIDxwbWVuemVs
QG1vbGdlbi5tcGcuZGU+IHdyb3RlOgo+Cj5TaG91bGQgeW91IHJlc2VuZCwgcGxlYXNlIHJlLWZs
b3cgZm9yIDcyLzc1IGNoYXJhY3RlcnMsIHNvIG9ubHkgdGhyZWUgCj5saW5lcyBhcmUgdXNlZC4K
PgoKVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IQoKRm9sbG93aW5nIERhbidzIHN1Z2dlc3Rpb25z
LCBJIHJld29ya2VkIHRoZSBwYXRjaCBpbiB2Mi4gSSBhbHNvIG1hZGUgdGhlCmNvbW1pdCBtZXNz
YWdlIG1vcmUgY29tcGFjdCBiYXNlZCBvbiB5b3VyIHN1Z2dlc3Rpb24uIAoKPgo+UFM6IGdlbWlu
aS9nZW1pbmktMy4xLXByby1wcmV2aWV3IGZvdW5kIGFuIHVucmVsYXRlZCBpc3N1ZSB0byB0aGUg
cGF0Y2ggCj5kdXJpbmcgcmV2aWV3IG9mIHRoaXMgcGF0Y2ggWzFdLgo+Cj4+IFRoaXMgaXMgYSBw
cmUtZXhpc3RpbmcgaXNzdWUsIGJ1dCBkb2VzIHRoaXMgZXJyb3IgcGF0aCBzYWZlbHkgY2xlYW4g
dXAgdGhlCj4+IGFjdGl2ZSB2aXJ0cXVldWVzPyAKPj4gRWFybGllciBpbiB2aXJ0YnRfcHJvYmUo
KSwgdmlydGlvX2RldmljZV9yZWFkeSh2ZGV2KSBtYXJrcyB0aGUgZGV2aWNlIGFzCj4+IGFjdGl2
ZS4gSWYgdmlydGJ0X29wZW5fdmRldigpIHN1YnNlcXVlbnRseSBmYWlscywgdGhlIGNvZGUganVt
cHMgdG8gdGhlCj4+IG9wZW5fZmFpbGVkIGxhYmVsIGFuZCBldmVudHVhbGx5IHJlYWNoZXMgaGVy
ZSB0byBjYWxsIGRlbF92cXModmRldikuCj4+IERlbGV0aW5nIHZpcnRxdWV1ZXMgd2l0aG91dCBj
YWxsaW5nIHZpcnRpb19yZXNldF9kZXZpY2UodmRldikgZmlyc3QgdmlvbGF0ZXMKPj4gdGhlIFZp
cnRJTyBBUEkgY29udHJhY3QgZm9yIGFjdGl2ZSBkZXZpY2VzLiBJdCBjb3VsZCBhbGxvdyB0aGUg
aG9zdCBvcgo+PiBoeXBlcnZpc29yIHRvIGFjY2VzcyBndWVzdCBtZW1vcnkgdGhhdCBoYXMgYWxy
ZWFkeSBiZWVuIGZyZWVkIGJ5IGRlbF92cXMoKSwKPj4gcG90ZW50aWFsbHkgbGVhZGluZyB0byBh
IHVzZS1hZnRlci1mcmVlLgo+PiBTaG91bGQgdmlydGlvX3Jlc2V0X2RldmljZSh2ZGV2KSBiZSBj
YWxsZWQgYmVmb3JlIHRlYXJpbmcgZG93biB0aGUKPj4gdmlydHF1ZXVlcyBpbiB0aGlzIGVycm9y
IHBhdGg/Cj4KPk5vIGlkZWEsIGhvdyB0byBiZXN0IHRyYWNrIHRoZXNlIHRoaW5ncy4KPgoKVGhl
IGlzc3VlIG5vdGVkIGluIHlvdXIgUFMgaXMgbm93IGhhbmRsZWQgYnkgcmVzZXR0aW5nIHRoZSB2
aXJ0aW8gZGV2aWNlCmJlZm9yZSB0ZWFyaW5nIGRvd24gdGhlIHZpcnRxdWV1ZXMgaW4gdGhlIHZp
cnRidF9vcGVuX3ZkZXYoKSBmYWlsdXJlIHBhdGguCgpTaW5jZSB2MiBjaGFuZ2VzIG1vcmUgdGhh
biB0aGUgb3JpZ2luYWwgb25lLWxpbmUgZml4LCBJIGRpZCBub3QgY2FycnkgeW91cgpSZXZpZXdl
ZC1ieSB0YWcuIFRoYW5rcyBhZ2FpbiEKClRoYW5rcywKSGFveGlhbmc=
