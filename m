Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006CF3E834D
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337925; cv=none; b=IiraZyCQGc+QBY0kMlq2MZ/k9obcabqOy0+X9N8Nf4TpZ+eVxGeuIDUbHlvfjY/m5z0i3oryNgSLvnl8Nv7r71UEkJOsd3LqFG0EzFAGRv+en2bKSmy0pf0EMhQSYw7Bnk+UL5zeztIUmjX8nQRiChRNMz6RbTb+OduZ0OsT/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337925; c=relaxed/simple;
	bh=souoJ6/izhpzI/lCowRs9VlUo/lT49GZDbVkLuoK+4Q=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=YJ2EgGcUXPnGABcl9DwCScRcBH44UBcXKljXQRy73YXW2fwqv3Izs9njXUI4qn9AJukCu8C4HsbAIAxd0ja7X13fKVsPJzxNHrgVCcA0n+p5Lve+NV3yXetWlFHnREnlTYA7sZsytFx+Rsxqb7Cs9GcruRhv/KpDIOZOC8IR82E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=a8UHcrzS; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="a8UHcrzS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1788337918; bh=souoJ6/izhpzI/lCowRs9VlUo/lT49GZDbVkLuoK+4Q=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=a8UHcrzSasJf+sPF7HaPOFzkldbIKxm3M0hZHTNJ0jTPZVjlAk9UpzBhBfxfZBzAQ
	 rqhxaJ7CP8pmTWRQOp6PNj/dTpwTsyMhv6kMiofYYw63poqJvXl6QeQL8rec6lDRew
	 qwPbfJ7x1DZbC+yyt8/9tEPmn8Bxrwv4S98pjFdA=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-XMAILINFO: MgnhPuxgWIORQx+YFIaDDDWtBSUkCrKZy5QhKSRfamG9xmKIA/lK320lhf0+Sj
	 DdXs50nYIChmQyrH6Z+RPcxdBDx/SfjNQRwiTeHMAA1LwvYWevPAzdV3FFQTkz0iUqoJM78sbaeim
	 ayZ+3IkFE0S2BhLC4wu/PYUzBAULzH1aowtC/uQ8XntEM3Zj8lVJ/IVX0inzO55ThaTmAH3/A60ak
	 sqCQzsK8k0b8mK3nRhNwR064zD41u1wzVRhyaNcQofcDYnbuHT5Iel+0PBCIfmTa794BLdpDVWEyA
	 i80o7BePcCu7hihBxM26epsv7PPyrtDjnPEqY/PfKdfQO6SZAm1NogL5T1ICW8xjcNo1qpwtkgGpm
	 xbNaxJsiiYqyZj/c5lVfeBuleK6mCu7Ft42HKIBvvny4utND9Jzkowq23qrsdGUJn92cnpGdAiQfm
	 gU9pj3VTqbpnS2K/VS8hmVR9Ua53n4smcR9teOlBv1k50eT8ak5ijix0UpgVSa0FZKglaXGWs8IBv
	 BJy7g2oAo++AO61Nt8M5KYGPJsDpSPojzRGQMUR1VaPz4LOctmW0aV0ujBIQ12E5V9h1f8yKDtDSd
	 engd9EtqDtHMJvUL6K9y4sW2JXk3zwbacNG75pYIkb4QZhJeORa1UYPCBMvPJxPBos9f3xOo5/heC
	 ItXlvDZzLG5F/Iz4JBW7CG7seN4HOj5bheAfQW848VBrbaB7WVtTna9Qd7W4Id98LkW2OLmfdcS1L
	 JZRF5v8VmGMsCbGVokDhLwWNIp1VEE5NdBlvX0fE+uVVcPeiQS8PmR7VBvoAUlHtxnNUOk70NJXvy
	 E0uLxoDLXdDyR/G9Ogc4Sr1chwvRXf+aBpUBYFFalub/99y4qVWlLHt9P/TzB2bzXh8UmfK38pl5k
	 4iQtL1TaFFayyQpPdzAXif4KXSOQKUZM4brv0CztCAEnqdgB/GUCAk37dLPtGFK9E941t1TmeHLFS
	 KgwtSY8pXUsK8k38F4OoIpu67i5oEHF8jDeUNB42L6h7oxWoItEi5QRNufLTk=
From: "=?utf-8?B?MzQ3MjI3NDYxMw==?=" <3472274613@qq.com>
To: "=?utf-8?B?YXN0?=" <ast@kernel.org>, "=?utf-8?B?ZGFuaWVs?=" <daniel@iogearbox.net>, "=?utf-8?B?YnBm?=" <bpf@vger.kernel.org>
Cc: "=?utf-8?B?bWFydGluLmxhdQ==?=" <martin.lau@linux.dev>, "=?utf-8?B?c29uZw==?=" <song@kernel.org>, "=?utf-8?B?am9sc2E=?=" <jolsa@kernel.org>, "=?utf-8?B?emh1eWlmZWk=?=" <zhuyifei@google.com>, "=?utf-8?B?YW5kcmlp?=" <andrii@kernel.org>, "=?utf-8?B?ZWRkeXo4Nw==?=" <eddyz87@gmail.com>, "=?utf-8?B?bWVteG9y?=" <memxor@gmail.com>, "=?utf-8?B?Y29ydnVz?=" <corvus@tencent.com>, "=?utf-8?B?QW9oYW4gTWVp?=" <henrymei@tencent.com>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf: Enforce cgroup storage map consistency for freplace attach
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 2 Sep 2026 16:31:57 +0800
X-Priority: 3
Message-ID: <tencent_5F0F74447E7E5B64AC75AF770908016C1B08@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260814130650.634992-1-3472274613@qq.com>
	<tencent_05AD70D6BED7A204CB00860D0C3A303FDC07@qq.com>
In-Reply-To: <tencent_05AD70D6BED7A204CB00860D0C3A303FDC07@qq.com>
X-QQ-mid: xmsezc57-0t1788337917tbw9eb4bb

R2VudGxlIHBpbmcg4oCUIGl0IGhhcyBiZWVuIHR3byB3ZWVrcyBzaW5jZSB2Mi4KClRoZSBv
bmx5IGZlZWRiYWNrIHNvIGZhciB3YXMgdGhlIGJwZiBDSSBxdWVzdGlvbiBhYm91dCB0aGUg
Rml4ZXMgdGFnLAphbnN3ZXJlZCB1cHRocmVhZDogN2Q5YzM0Mjc4OTRmIHdhcyBrZXB0IHRv
IHN0YXkgYWxpZ25lZCB3aXRoIHRoZQphbmFsb2dvdXMgZml4IGFiYWQzZDBiYWQ3MiAoImJw
ZjogRml4IG9vYiBhY2Nlc3MgaW4gY2dyb3VwIGxvY2FsCnN0b3JhZ2UiKSwgYW5kIGFsbCBt
YWludGFpbmVkIHN0YWJsZSB0cmVlcyBjb250YWluIGJvdGggY2FuZGlkYXRlCmNvbW1pdHMs
IHNvIHRoZSBiYWNrcG9ydCBzZXQgaXMgdW5hZmZlY3RlZCBlaXRoZXIgd2F5LiBIYXBweSB0
byByZXNwaW4Kd2l0aCBiZTg3MDRmZjA3ZDIgaW5zdGVhZCBpZiBtYWludGFpbmVycyBwcmVm
ZXIuCgpUaGUgcGF0Y2ggc3RpbGwgYXBwbGllcyBjbGVhbmx5IG9uIHRoZSBsYXRlc3QgYnBm
IHRyZWUuIEFueSBmZWVkYmFjawp3b3VsZCBiZSBhcHByZWNpYXRlZC4KClRoYW5rcywKQW9o
YW4KCgkKCg==

