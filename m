Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217916;
	b=AoN4gvXvfb/rXR5bYv88dRHLQjvx3hAQbEnxMGGNvMYzeaRnJs1iF7w0VcUYo9PYnnP0
	 q8LFHXZaYnFihxaOrgA7mO+03Hh0xA0Ws7jPpBe1UV+fLsMbpcyWxpWplYb4bYFbWxy0+
	 D5jEDxbM6jID3a1K32LwDtHYDlsVsAEp9+ks9adWhABIc+jVHT7kCX0jzWYPl7pre3+0O
	 qkZMQ+/0en3PzwaSmMWffr9nrM6+ye31hSsV8t54Zr4ifKsTGGqdx8ncGdCUyEUuVJRUE
	 DHSGI3D5+62LZgrso3xQHpKU5XnbnuTu95Ect6vC4DGiKDEFtLSYm1j/al1X3lPQ8tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217916;
	h=DMARC-Filter:DKIM-Signature:Received:X-Originating-IP:Date:
	 X-CM-HeaderCharset:From:To:Cc:Subject:X-Priority:X-Mailer:In-Reply-To:
	 References:Content-Transfer-Encoding:Content-Type:MIME-Version:
	 Message-ID:X-Coremail-Locale:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=XA7B63YEOoPoc69XLHUfY2ziq2BhVYlvpPt16lzHQhk=;
	b=YBaf3vzCv027QSfuRFEH6kJVUtRiVq9civJfVPaeyGB3dEsDJA1f0W0M/NyyXmKqGwFC
	 4maq2rMHLXLAlsSDZJwRkVLd1o3/Al3UitBkv1drf4dWsblwUmpWiYySV3s+dMVqOTZZ2
	 iz/d+g7NG4gGTMb33695YjueuLIqSARxPqLNcBSLupZrUo+pGw+wlitkRta9z0Xk7CtRh
	 MB4LbDB/5h8+W4dzzgldlUkjjfuFGJJWGUvlXAVeLrJkCKznT/1bP3IEKrPMDp1v1D1hx
	 ixNcysUmw69rgf7Hx/WhaRKWgw3RkPmEoBvLt+gvHPNZgj9s0n/Zs1d94T1svR0y1ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=fail reason="signature verification failed" header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=IizY26EI;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353EB606D810;
	Mon,  9 Nov 2026 09:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 353EB606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=IizY26EI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Cc:
	Subject:In-Reply-To:References:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID; bh=3HsrWzOE7DDbArLklASgrUy
	VLEgk980VLxEZaQWsK9M=; b=IizY26EIsvlgZxr7czGr3xwnyv2flxyAEd4dH8M
	kfqvK575XjMlY3S4XJmo/RwzD4eTBqcPx+jSPwKV1BusAA4x4Ms2sbajDo4hKtL1
	KXeSUzMqg3X7ajg52L2CzMeaAWKA5Ol5rjPM2Y98lF9Zkk1MOmddnzbWm+SNOMM1
	hu9I=
Received: from zhangmh25$mails.tsinghua.edu.cn ( [183.173.160.112] ) by
 ajax-webmail-web1 (Coremail) ; Mon, 9 Nov 2026 17:51:34 +0800 (GMT+08:00)
Date: Mon, 9 Nov 2026 17:51:34 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangmh25@mails.tsinghua.edu.cn
To: "Ido Schimmel" <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pshelar@nicira.com, stable@vger.kernel.org
Subject: Re: Re: [PATCH net] net: ipv4: fix tnl_update_pmtu negative MTU
 advertisement
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20261010(691d8f62) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <20261103151844.GA1234870@shredder>
References: <20261102155444.2658518-1-zhangmh25@mails.tsinghua.edu.cn>
 <20261103151844.GA1234870@shredder>
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
Message-ID: <d8f76d6.23b1e.1a1bfb862e2.Coremail.zhangmh25@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:yAQGZQCXDj+ml_FqaFwaAg--.28789W
X-CM-SenderInfo: x2kd0wlpkskqxpdlz2oowvx0pjkxthxhgxhubq/1tbiAgAGB2rw+M
	7ntAAIs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgSWRvLAoKVGhhbmtzIGZvciB0aGUgcmV2aWV3LCBhbmQgc29ycnkgZm9yIHRoZSBkZWxheWVk
IHJlcGx5LgoKSSBhZ3JlZSB0aGF0IHRoZSByb3V0ZSBNVFUgdXNlZCBpbiB0aGlzIHJlcHJvZHVj
ZXIgYWxyZWFkeSBtYWtlcyB0aGUgdHVubmVsIHVudXNhYmxlLiBUaGUgdGVzdCBkZW1vbnN0cmF0
ZXMgaW5jb3JyZWN0IElDTVAgZmVlZGJhY2sgaW4gdGhhdCBjb25maWd1cmF0aW9uLCBidXQgZG9l
cyBub3QgZXN0YWJsaXNoIGFuIGFkZGl0aW9uYWwgb3BlcmF0aW9uYWwgaW1wYWN0LiBBIHNlbmRl
ciB3aG9zZSBjdXJyZW50IFBNVFUgaXMgc21hbGxlciB0aGFuIHRoZSBhZHZlcnRpc2VkIHZhbHVl
IHNob3VsZCBhbHNvIGlnbm9yZSBpdC4KCkkgd2lsbCBzZXQgdGhpcyBwYXRjaCBhc2lkZSBmb3Ig
bm93LiBJZiBJIGZpbmQgYSBwcmFjdGljYWwgY2FzZSB3aGVyZSB0aGUgYmVoYXZpb3IgYWZmZWN0
cyBhbiBvdGhlcndpc2UgdXNhYmxlIGNvbmZpZ3VyYXRpb24sIEkgd2lsbCBmb2xsb3cgdXAgd2l0
aCB0aGUgcmVsZXZhbnQgZXZpZGVuY2UuCgpUaGFua3MsCk1pbmdoYW8gWmhhbmcK
