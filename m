Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736391EFF93;
	Tue, 15 Sep 2026 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434368; cv=none; b=EKz6uOSTGqx1unOes1+H3c8MJvREMjmoamu2QJXeJiSeRumJigAVmJxeU2L+DwLs4h07Fts7KRFv1h+OO8f9HYHLqwiBvL+UXaJ0jKknndsQwcPU+iLDvoXMI9AAJ/B5f1Nzxdujvm0eId+DHD5S0Ki5C7q1NQKKIrM60q1cgzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434368; c=relaxed/simple;
	bh=3Tt86Q/NpMlOsDp9916VWkURqNPqTTY/kDBFF4LcTNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=jDOaFzt+r4F2qFh855uusJub0+MI5bsE948/AQEn/HMBLdo1TQJLua0L4+fleJVQHf/9ZSDjhLYUqG7VwQ1yQehdSzdNrEdFrNJi34uKMc92wXeZeK/boK2blx5A3lN6URF2FMIAJP8XBews0p9Gb8Xb7zq34A4PSSB/Sy74WpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=baegioPv; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="baegioPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=3Tt86Q/NpMlOsDp9916VWkURqNPqTTY/kDBFF4LcTNU=; b=b
	aegioPvrCuh4QYCmrJjFuS4y55Nv565CR0BDDQbY+nqLt1GposUKlGATAu3U+DMy
	5q/Bst2GJz1UI9hv9jjtPH+N+/+FYpQJcrhrpkdsR0QDPSntQ1d/c+gn1QU7ynNO
	BMwPLObRXYDXkfDAHc83QcH27B1DkrCcUiUJA0ED4M=
Date: Tue, 15 Sep 2026 09:05:41 +0800 (CST)
From: dd  <zhongling0719@126.com>
To: "Namjae Jeon" <linkinjeon@kernel.org>
Cc: "Hongling Zeng" <zenghongling@kylinos.cn>, hyc.lee@gmail.com,
	ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re:Re: [PATCH] ntfs: mount hibernated volumes read-only regardless
 of errors=
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <CAKYAXd9EFNkofkj1tEg1vs5+1ohs1exYx6mys78X8852x8w6Yg@mail.gmail.com>
References: <20260914034202.52011-1-zenghongling@kylinos.cn>
 <CAKYAXd9EFNkofkj1tEg1vs5+1ohs1exYx6mys78X8852x8w6Yg@mail.gmail.com>
X-NTES-SC: AL_Qu2TC/iYu0sv5yKfbOkWk00RgOk9WsG1vfQi24NQP500ly728SsKQVxoP37pze6IFy6zkCWzdid8y9xQVLVEVZqwQ+uP74z4sdUYKtVXqNu0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5d8908a0.a55.1a0a29927aa.Coremail.zhongling0719@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dikvCgD3H5rlmahq_zpAAA--.55880W
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrgVkNWqomeVBpwAA3i
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgrlnKggMjAyNi0wOS0xNCAyMTo1OToxMO+8jCJOYW1qYWUgSmVvbiIgPGxpbmtpbmplb25Aa2Vy
bmVsLm9yZz4g5YaZ6YGT77yaCj5PbiBNb24sIFNlcCAxNCwgMjAyNiBhdCAxMjo0MuKAr1BNIEhv
bmdsaW5nIFplbmcgPHplbmdob25nbGluZ0BreWxpbm9zLmNuPiB3cm90ZToKPj4KPj4gVGhlIGhp
YmVybmF0aW9uIGNoZWNrIGluIGxvYWRfc3lzdGVtX2ZpbGVzKCkgb25seSBjb252ZXJ0cyB0aGUK
Pj4gc3VwZXJibG9jayB0byByZWFkLW9ubHkgdW5kZXIgZXJyb3JzPXJlbW91bnQtcm8uICBXaXRo
IHRoZSBkZWZhdWx0Cj4+IGVycm9ycz1jb250aW51ZSAoYW5kIHdpdGggZXJyb3JzPXBhbmljKSwg
YSBoaWJlcm5hdGVkIHZvbHVtZSBpcwo+PiBtb3VudGVkIHJlYWQtd3JpdGUgYW5kIHRoZSBtb3Vu
dC10aW1lICRMb2dGaWxlIGVtcHR5aW5nIHdyaXRlcyB0byBpdCwKPj4gYWx0aG91Z2ggYSBoaWJl
cm5hdGVkIHZvbHVtZSBtdXN0IG5vdCBiZSB3cml0dGVuIHRvIGF0IGFsbC4KPj4KPj4gRHJvcCB0
aGUgb25fZXJyb3JzIHRlcm0gc28gdGhhdCBhIGhpYmVybmF0ZWQgdm9sdW1lLCBvciBhIHZvbHVt
ZSB3aG9zZQo+PiBoaWJlcm5hdGlvbiBzdGF0ZSBjYW5ub3QgYmUgZGV0ZXJtaW5lZCwgYWx3YXlz
IG1vdW50cyByZWFkLW9ubHkuCj4+IE5Wb2xFcnJvcnMoKSBpcyBzdGlsbCByZWNvcmRlZCwgc28g
bnRmc19yZWNvbmZpZ3VyZSgpIGtlZXBzIHJlZnVzaW5nCj4+IHJlbW91bnRzIHRvIHJlYWQtd3Jp
dGUsIGFuZCB0aGUgJExvZ0ZpbGUgZW1wdHlpbmcgaXMgc2tpcHBlZCBieSBpdHMKPj4gIXNiX3Jk
b25seSgpIGNoZWNrLgo+Y2hlY2tfd2luZG93c19oaWJlcm5hdGlvbl9zdGF0dXMoKSBjYWxscyBu
dGZzX2Vycm9yKCkgYmVmb3JlIFNCX1JET05MWQo+aXMgc2V0LiBXaXRoIGVycm9ycz1wYW5pYywg
dGhpcyBwYW5pY3MgYmVmb3JlIHJlYWNoaW5nIHRoZSBuZXcKPnJlYWQtb25seSBmYWxsYmFjay4u
LgogIFRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcy4gUmlnaHQgLS0gdGhvc2UgZXJyb3IgcGF0aHMg
Y2FsbCBudGZzX2Vycm9yKCkKICBiZWZvcmUgU0JfUkRPTkxZIGlzIHNldCwgc28gZXJyb3JzPXBh
bmljIGNhbiBmaXJlIGluc2lkZQogIGNoZWNrX3dpbmRvd3NfaGliZXJuYXRpb25fc3RhdHVzKCku
CgogIEkgd2lsbCByZW1vdmUgdGhlIGludGVybmFsIG50ZnNfZXJyb3IoKSBjYWxscyBpbiB2Mjsg
dGhlIGNhbGxlciBhbHJlYWR5CiAgcmVwb3J0cyAiRmFpbGVkIHRvIGRldGVybWluZSBpZiBXaW5k
b3dzIGlzIGhpYmVybmF0ZWQuIiBmb3IgZXZlcnkKICBlcnIgPCAwIGNhc2UuIE5Wb2xFcnJvcnMo
KSBpcyBzdGlsbCByZWNvcmRlZCwgc28gbnRmc19yZWNvbmZpZ3VyZSgpCiAga2VlcHMgcmVqZWN0
aW5nIHJlbW91bnRzIHRvIHJlYWQtd3JpdGUuCgogIFRoYW5rcywKICBIb25nbGluZwoK
