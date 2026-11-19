Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092378;
	b=ab4HC4XA95zsvleDyI3aBH1UR+LhyUWxRW+VlssTI7b1keh5FOY4lUp1wwVFEYoLCppe
	 n0kmWbzMS81f/BxBv5a5PsVGopDMd5GW7fVk1wHX/EIrlKw0s7EZO6d+GUS0Q6KNIy8ZX
	 1dIK3DBqlYgmkcvsaChy8TRJrPMe4oP85Gj1XB+nUOb47RDis4qKImHziQDtGn/yzCJq9
	 eTX6CNVvy2NYnV54Td/NRSCYd8nmKJoUm75LF6kiBGfDCV6z/GIeEylP06g7+rRI+ZVVv
	 bfuRa8MYCV0ad19sevYxeMn+Euni2DPPC/2MQi43mgm8iMdAnIYIPbRzwtS/Y3pEbRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092378;
	h=DMARC-Filter:Content-Type:Content-Transfer-Encoding:Message-ID:To:Cc:
	 Subject:X-Priority:X-Mailer:X-Originating-IP:In-Reply-To:References:
	 MIME-Version:Received:From:Date:X-HM-Tid:X-HM-MType:X-HM-NTES-SC:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=dBY8CS86QZYf1TpdBjExJrHDGi63C9W6Ery8DeqRoBQ=;
	b=FldZknwoQ8QZftYhgYHscq9GLkiBXfmbNDPoCKYZSO9SzFRGFg8uu9LR4k14lfscXCTy
	 JbtUTLq/XxalooJ4LWR3lgT6rJIhP9JrYZbfcMGqPvTLzEoKLW8q8O9BLhartuJn9P0Eu
	 /CoY/yfG9BbWAsEVaPdNXwHKs1gl3xIvBynBfecEIQjyObW++Vf13l0tvZbm9Ohfbk3b9
	 3oeD82ZxL/fot0dVCAPDtyD30Mc2/OEELE1bWHVZTicNGqkVYpSi9/lsJTN6pi3W2O10e
	 BDeiSjeXJhdWrtnoT3GqRytFPf2XSke8G8bV67jaKE5TQqWq4pI/WLpzlFuQwk96/Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=PRp+NI4e;
	arc=none smtp.remote-ip=103.209.128.122
Received: from mail-m128122.netease.com (mail-m128122.netease.com [103.209.128.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A93260A2625;
	Thu, 19 Nov 2026 12:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A93260A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=PRp+NI4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AB2AtQBLLG04vL*MjX4Nuap6.3.1795092368475.Hmail.202321181@mail.sdu.edu.cn>
To: Helge Deller <deller@gmx.de>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZmJkZXY6IHMzYy1mYjogRml4IHBvdGVudGlhbCByZWdpc3RyYXRpb24gY29ycnVwdGlvbiBvbiBwcm9iZSBmYWlsdXJl?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
In-Reply-To: <4fba8bdb-de77-4418-8ffc-7ad6982e8027@gmx.de>
References: <20261118-324f82bd41-fbdev-0@mail.sdu.edu.cn> <4fba8bdb-de77-4418-8ffc-7ad6982e8027@gmx.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 202321181@mail.sdu.edu.cn( [101.76.249.61] ) by ajax-webmail ( [127.0.0.1] ) ; Thu, 19 Nov 2026 20:46:08 +0800 (GMT+08:00)
From: =?UTF-8?B?5p2O5bm/56GV?= <liguangshuo@mail.sdu.edu.cn>
Date: Thu, 19 Nov 2026 20:46:08 +0800 (GMT+08:00)
X-HM-Tid: 0aa1f3d795c3d0cdkusy309171cb1601f
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMVHpP02bZAKsMEiErRSAekjx+ys+KNZNl0PLwl
	f2MeqR5lbiqKsoq8sm3hZVy9q3VVBNOjIUwfWq1GfV2NBR9WJV5pp9Gwt04oeFjraKOA9zEyL3vE
	n+LQX4zQhIbxZm+In4xyL2K8J8TailzhGVoxc=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGE9KVkweHUhCTB8eSEpDQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG
DKIM-Signature: a=rsa-sha256;
	b=PRp+NI4eALnkYh9Hsk8tyTPvzcrEnYqzDucBQ5CHP7qMfoD7ARx6CZcO+eV5Vv3hdiBql6H/dVgDo4HXkFkketkdYtHxVSQLgw+RV0FesUdUxsDzMLJQ0/KvK2ce3JiLP67zBET4JRrK8ANy4Ht1vPg/u8TTHHSPiWVBaILeSkg=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=dBY8CS86QZYf1TpdBjExJrHDGi63C9W6Ery8DeqRoBQ=;
	h=date:mime-version:subject:message-id:from;

CgpIaSBIZWxnZSwKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCkZyb206IEhlbGdlIERlbGxlciA8
ZGVsbGVyQGdteC5kZT4KRGF0ZTogMjAyNi0xMS0xOSAwMjoxNzowOApUbzogIEd1YW5nc2h1byBM
aSA8bGlndWFuZ3NodW9AbWFpbC5zZHUuZWR1LmNuPixKaW5nb28gSGFuIDxqaW5nb29oYW4xQGdt
YWlsLmNvbT4KQ2M6ICBsaW51eC1mYmRldkB2Z2VyLmtlcm5lbC5vcmcsZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZyxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKU3ViamVjdDogUmU6IFtQQVRDSF0gZmJkZXY6IHMzYy1mYjogRml4IHBvdGVu
dGlhbCByZWdpc3RyYXRpb24gY29ycnVwdGlvbiBvbiBwcm9iZSBmYWlsdXJlPk9uIDExLzE4LzI2
IDE1OjIyLCBHdWFuZ3NodW8gTGkgd3JvdGU6Cj4+IFByb2JlIGZhaWx1cmUgY2xlYW51cCBjYWxs
cyB1bnJlZ2lzdGVyX2ZyYW1lYnVmZmVyKCkgZXZlbiB3aGVuIHRoZQo+PiB3aW5kb3cgaGFzIG5v
dCBiZWVuIHJlZ2lzdGVyZWQuIEl0cyB6ZXJvLWluaXRpYWxpemVkIG5vZGUgY2FuIHRoZW4KPj4g
cmVtb3ZlIGFub3RoZXIgZnJhbWVidWZmZXIgZnJvbSByZWdpc3RlcmVkX2ZiWzBdLgo+PiAKPj4g
VHJhY2sgc3VjY2Vzc2Z1bCByZWdpc3RyYXRpb24gYW5kIG9ubHkgdW5yZWdpc3RlciB0aG9zZSBm
cmFtZWJ1ZmZlcnMuCj4+IEFsc28gc2tpcCBlbXB0eSB3aW5kb3cgc2xvdHMgd2hpbGUgdW53aW5k
aW5nIGEgZmFpbGVkIHByb2JlLgo+PiAKPj4gVGhpcyBpc3N1ZSB3YXMgZm91bmQgYnkgb3VyIHN0
YXRpYyBhbmFseXNpcyB0b29sIHVuZGVyIGRldmVsb3BtZW50Lgo+Cj5JIHRoaW5rIHMzY19mYl9w
cm9iZV93aW4oKSBuZWVkcyB0byBjbGVhbiB1cCB3aGVuIHNvbWUgdGhpbmdzCj5saWtlIGNtYXAg
ZmFpbCB0byBiZSBhbGxvY2F0ZWQuCj5Zb3VyIHBhdGNoIHNlZW1zIHRvIGp1c3Qgd29yayBhcm91
bmQgb25lIG9mIHRoZSBwb3NzaWJsZSBwaXRmYWxscy4KPgo+SGVsZ2UKPgoKczNjX2ZiX3Byb2Jl
X3dpbigpIHNldHMgKnJlcyBlYXJseSBhbmQgY2FycmllcyBvbiBpZiBmYl9hbGxvY19jbWFwKCkK
ZmFpbHMuIEkgdGhpbmsgaXQgc2hvdWxkIHVud2luZCB0aGUgY3VycmVudCB3aW5kb3cgb24gZmFp
bHVyZSBhbmQgc2V0CipyZXMgb25seSBhZnRlciByZWdpc3Rlcl9mcmFtZWJ1ZmZlcigpIHN1Y2Nl
ZWRzLiBUaGF0IHdvdWxkIGxlYXZlIHRoZQpjYWxsZXIgd2l0aCBqdXN0IHRoZSByZWdpc3RlcmVk
IHdpbmRvd3MgdG8gY2xlYW4gdXAuCgpJcyB0aGF0IHdoZXJlIHlvdSdkIHB1dCB0aGUgY2xlYW51
cD8gSWYgc28sIEknbGwgc2VuZCBhIHYyIHdpdGhvdXQKdGhlIGV4dHJhIHJlZ2lzdHJhdGlvbiBm
bGFnLgoKVGhhbmtzLApHdWFuZ3NodW8K
