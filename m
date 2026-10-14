Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621CD3E0C4D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960513; cv=none; b=DKZ70Z6t1Vqc5iJVv5KhVj/rSBptdk2irHQz5bxQHgdldUuVN3eRqEvkc9RZI4+2ajB84JyKS8EKDSwUfTc3YVQApAHF5YGxMg8mbV9R/gFNqDfg1IID7xdbdrZHoDKWAr/+oAJR9i9qc7wqWRtdCDAoX8PyBi08x3SBpFCeqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960513; c=relaxed/simple;
	bh=e5thbHDIas4UZ0dc2RK5yYennvkn/22hrPyHBBO6PZI=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=jjXfvr2N9uGsXxKMhu83JwSMB6chKvEvpqvTy4ffVqphTpdxeJ4tQuSkvMcEqjVJ8y0wODjoSLsktz3FcpKQNk/6a3jllMeZ3hMsDoKajPELlV/cO4Ky6IzrymbH0nrP3YbVagJsyjYNUq9L/lCITiNwqDFK9mGv//ZdoI2mzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xo7lfztc; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xo7lfztc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791960502; bh=e5thbHDIas4UZ0dc2RK5yYennvkn/22hrPyHBBO6PZI=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=xo7lfztcynIaycOjzrsrRLKc9Wmt36IqF0mooy4VRBsQhLh1ZtzPJvOgtdRIj5g4x
	 hM/U2kqlLWNPTkCoEJa3bacKUUi9KMGqAoriEfA9sEDYglC7tMol/CdUOfVZd4mQDz
	 8TMsIt3wjdI8wYzsJqQfyHeXZeUN4jT0GiOmBYyU=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-XMAILINFO: NqaMgNSdKQxyqHk0HsSnwvpqT2pF3wjU5cgvlf5hAQWOpwbh5ip6E8y5CzVjBk
	 YJlxfNJ7QRFX0fobsBHf2699V8ixGQ3aD1GclqhTx/zNRPSmSO7hGtjfGDSXtmT5uyHLAYA549q3H
	 XvIAwqzOl2Daf6DqsfBW0l3z2MLmJVUTz92Pk2h53W/gGR7e4h5CUurTzdxcXZ23RQ+uLCnWlzQVt
	 kYHIgaZU5arl5Jtq6SxRvAC0BWRvTWdhDpqkKvHXMF1iEIFiB8L+CgrZRjMcA/Cqq61sVv82o6McR
	 lVF87jmv2kjYnV+/ITpjjsxqYmEp4OBG7fJwb+uM6HKtRVanEG0rwExZzmebJU73jvSOxeMuQWYk4
	 ZJw5ka5jnwhr5m+mQ7PSpRTftQPrWbtTX1QbkpGlu3bqXqZbXAwp4rxKe/4PgPerCsOUxZAJqoxDf
	 u6V9cNuy7m0rXrjiP6YDKBQdVrSXou0UiqOpm6qsZH250H8hwXscYXSxBANrw2YtDW+4As7/BAb+l
	 bz2W4HtzA29EhrBRdQ9cHAg0MMUt68qI1EytSQ77xwqAaS58MsqBZ5EpMzuRTs1nfJSvkjMvy251I
	 5TKI+dXHx2riFkWbsi/UjQw9KEK20UeZPsKC4ZzNHRFX3566OjRhTiK8f6ge5INaMQ4k8gLrT+E3h
	 CLxLN85w+kKHn0edNhhDTif2LM61P+6BW+kHF6wI2o/NtZUYRVa5F1Ii0oSenWqsJ/5TQALmCljZ0
	 4u4Ysz12OouxgjIxLqOHnibyZsTdeKGavn3QGKz1EOoN2Sr/2jIhFVmnO8EfMJJnVItOiAepDhCyC
	 hoyKvK+ATL+nCyNtMdnzVtIXOKlsuGLgNuUmxWgIjdlwQiDxkVIFh45Y3kmFjj419Jry2z/9ip4I+
	 YRbHHlRXhfZBqq3EevjOLS9Pl3SBVLHQ+zGXJou2vbkmgeXH60jGc/znZ7hGyqE6JHb5W7I0ddSt8
	 GiTqoIAeDqLyE7jkgA8veBqYiccYsdHxQQqBK/BxN37sDUTjtKCfatpwu7tjgq+PYWe5webfSvRf3
	 nlXrukGv36T1zWOY7BA0Gmw3oMnAXmH/dl7wEetBSZg54KW4=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>
Cc: "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?RGF2aWQgUy4gTWlsbGVy?=" <davem@davemloft.net>, "=?utf-8?B?V29sZmdhbmcgR3JhbmRlZ2dlcg==?=" <wg@grandegger.com>, "=?utf-8?B?T2xpdmVyIEhhcnRrb3Bw?=" <socketcan@hartkopp.net>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH net v2 0/3] can: fix bus-off restart during device close
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 14 Oct 2026 14:48:20 +0800
X-Priority: 3
Message-ID: <tencent_F71C128E473402A41153FC3E9BD269826509@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_82C93561D200C84C24608C80049C23EEF80A@qq.com>
	<20261014-solid-slug-of-tempering-22b862-mkl@pengutronix.de>
In-Reply-To: <20261014-solid-slug-of-tempering-22b862-mkl@pengutronix.de>
X-QQ-mid: xmsezb41-0t1791960500t25ydy0as

SGkgTWFyYywKCj4gRllJOiBUaGUgdGhyZWFkaW5nIG9mIHlvdXIgc2VyaWVzIGlzIGJyb2tl
biwgZHVlIHRvIHdyb25nL2NoYW5nZXMKPiAiTWVzc2FnZS1JRCIuCgpUaGFua3MgZm9yIHRo
ZSBwb2ludGVyLCBhbmQgc29ycnkgYWJvdXQgdGhlIGJyb2tlbiB0aHJlYWRpbmcuCgo+IFlv
dSBjYW4gdXNlIHRoZSBiNCAid2ViIHN1Ym1pc3Npb24iIGluc3RlYWQ/IEl0IGJ5cGFzc2Vz
IGFueSBtYWlsIHN5c3RlbQo+IGNvbXBsZXRlbHkuCgpJJ2xsIHRyeSB1c2luZyB0aGUgYjQg
d2ViIHN1Ym1pc3Npb24gZW5kcG9pbnQgZm9yIHRoZSBuZXh0IHJldmlzaW9uLgoKQmVzdCBy
ZWdhcmRzLApDdW5oYW8gTHU=

