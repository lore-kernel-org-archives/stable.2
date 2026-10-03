Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B02931E1;
	Sat,  3 Oct 2026 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018768; cv=none; b=mA7n8NB9IGallOjGdKs3cxnnadeKdbwXHuVMhsTzdQ3Wn5AYFeoEShm7OnA6jGbTnFnJZlm0CzLkMmlSteIFYL4tt0LOpQswnRBV34edXf+oUenNXTmAmY6MWq4mwioeFuOYXwKqtrD8LiOlpYDpcrAjx2OR07EtB61PC67XhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018768; c=relaxed/simple;
	bh=vC8ddiyqywijrV/+4QU38Ua9tWhoJ4QrxcmYMUa2fqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=htGQe2zahTas1FGdz+WAw9X9vqQUjRRm82I/CS0jTNC17FYuf3P2TxEfIdGSdwOwvh14YOAJCtuiGdMb7HoqcmQHuFENQDp7C7DtxEKrZXhQ5bmbhKtmE/34bi4c1jqDBm8jOH1zjaUvok2QnRMe2Wrf0eg7E6vU9yQwbnVyt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lI4SfSPK; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lI4SfSPK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=vC8ddiyqywijrV/+4QU38Ua9tWhoJ4QrxcmYMUa2fqU=; b=l
	I4SfSPKwB1B/hbSV81X4S0VnEN4yvCS3ZhWbNru1tLWhvB2wSUHUhr0ZIKCfrxZ+
	nGydpzOmjypFoU3a1tBFi1s4BUWsuXZQYFglj/aCLDdSy/Oa1iVD/UdYZMLWxxFx
	77XWWrQMuOTxEsCFyds2QHxS3z4ZYbSCi+TeGwITTg=
Date: Sat, 3 Oct 2026 17:11:33 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Sergey Shtylyov" <s.shtylyov@omp.ru>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Paul Barker" <paul@pbarker.dev>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Mitsuhiro Kimura" <mitsuhiro.kimura.kc@renesas.com>,
	"Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re:Re: [PATCH v2 6/7] net: ravb: fix resource teardown ordering
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <b85d8dc9-b787-40e0-bbaf-027df2c3bf49@omp.ru>
References: <20260927144741.1320558-1-yaojiale02@163.com>
 <20260927144741.1320558-7-yaojiale02@163.com>
 <3b43b4fb-8479-4eb2-be58-1df6f0f747b9@omp.ru>
 <12190bf2.18c1.1a0f004c539.Coremail.19888972804@163.com>
 <b85d8dc9-b787-40e0-bbaf-027df2c3bf49@omp.ru>
X-NTES-SC: AL_Qu2SA/yat04i5SafbekdmE8Uges8WcC0svki1YJUc+4GhzHBwiABbHpeBEnt4NmlFwSNnAm9ShFy8/5qb6BZLJONpcJRKovhDnNg6gWKzw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <222db01f.1264.1a101087434.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jygvCgD3fxjFxsBq3EQHAA--.32561W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgWt52rAxsWEfAAA3Q
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgU2VyZ2V5LApBdCAyMDI2LTA5LTMwIDIzOjUwOjEzLCAiU2VyZ2V5IFNodHlseW92IiA8cy5z
aHR5bHlvdkBvbXAucnU+IHdyb3RlOgo+T24gOS8zMC8yNiA0OjUzIEFNLCBqaWFsZSB5YW8gd3Jv
dGU6Cj4KPlsuLi5dCj4KPj4gVGhhbmtzIGZvciB5b3VyIHJldmlldy4KPgo+ICAgVG9wLXBvc3Rp
bmcgb24gdGhlIGtlcm5lbCBNTHMgaXMgYSBiYWQgaWRlYS4uLiA6LSkKPgo+PiBZb3UncmUgcmln
aHQg4oCUIEknbGwgc3BsaXQgdGhpcyBpbnRvIHR3byBwYXRjaGVzOgo+PiBPbmUgcGF0Y2ggZm9y
IHRoZSBJUlEvbmV0ZGV2IG9yZGVyaW5nIGlzc3VlLgo+PiBPbmUgcGF0Y2ggZm9yIHRoZSBydW50
aW1lIFBNIHJlc3VtZSBmYWlsdXJlIGhhbmRsaW5nLgo+PiBJJ2xsIHVzZSAtLW5vLWdpdC1mYWxs
YmFjayBuZXh0IHRpbWUsIHNvcnJ5IGZvciB0aGlzLgoKdjMgaW4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjYxMDAzMDg1OTQwLjQ5Mzk1MS03LXlhb2ppYWxlMDJAMTYzLmNvbS8KSXQg
b25seSBhZGRyZXNzZXMgdGhlIElSUS9uZXRkZXYgdGVhcmRvd24gb3JkZXJpbmcgaXNzdWUuIFRo
ZSBydW50aW1lClBNIHJlc3VtZSBmYWlsdXJlIGhhbmRsaW5nIGhhcyBiZWVuIGxlZnQgdW5jaGFu
Z2VkLgoKSSBwbGFuIHRvIHN1Ym1pdCB0aGUgcnVudGltZSBQTSBmaXggc2VwYXJhdGVseSBhZnRl
ciB0aGUgcGF0Y2ggYWJvdmUKaGFzIGJlZW4gYXBwbGllZCwgdG8gYXZvaWQgY29uZmxpY3RzIGJl
dHdlZW4gdGhlIHR3byBjaGFuZ2VzLCBvciBhbnkKb3RoZXIgc3VnZ2VzdGlvbj8KCj4KPiAgIExv
b2tpbmcgYXQgaXQgYWdhaW4sIGl0IHNlZW1zIGxpa2UgbXkgZGVhZCBlbWFpbCAoYW5kIHRoZSBv
dGhlcnMgdGhhdAo+SSB0aG91Z2h0IHNob3VsZG4ndCBiZSB0aGVyZSkgd2VyZSBhZGRlZCBhcyBh
IHJlc3VsdCBvZiB1c2luZyB0aGUgRml4ZXMKPnRhZ3MuCj4gICBIb3dldmVyLCBzcGVjaWZ5aW5n
IC0tbm8tZ2l0LWZhbGxiYWNrIHNlZW1zIGEgZ29vZCBpZGVhIGdlbmVyYWxseS4uLiA6LSkKPgo+
Wy4uLl0KPgo+TUJSLCBTZXJnZXkK
