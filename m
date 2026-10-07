Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70422157B;
	Wed,  7 Oct 2026 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352489; cv=none; b=iXiL7Xn2CtLcEByGGMNRCYFSFzqBc3W4d9ACpbIE1FCTj8oVYZyo1WDqFfl7rzNzv3kLXkob0KUWr9DC1RMu41dOsh371LUM+u7Zz9bQAxtZ75+bILR18bbFCMf3wW6V/EnhxnYWlYoLh1/kYsxtEMUB5XCHbPZJHUHY8+pSgFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352489; c=relaxed/simple;
	bh=B33ht6alxBilQwM8rUkbU7t3KLIDYEmRoKcvEHu8Kgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=eKzeUcnvDaCxaoyPegZcH+hQtY0/pQfG4RSn/BgO+FI8cGT/+QawO5q84HorQfj2bnaokzUu4VQwa6AyQ0PDMDY/CkEUTtQHhImQK9KgxPc7OoApuYzD1yqu4zRlC33BzYah+8VBgq19uN4X1Vf8zOxYeMkIph4pkwkDhLnmK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HijKCa+o; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HijKCa+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=B33ht6alxBilQwM8rUkbU7t3KLIDYEmRoKcvEHu8Kgg=; b=H
	ijKCa+ouDIhIelL9OmlFtUWsm7dPHrYvslXbuVhtZ7YHY3UbD3iHHjghGVVb7kH3
	jNuhfZ8KdpOTEmfyjcQgZzWyZpfJ35UBNMSL4XSHgaDgjd88Yh6YP99kz8KXYkiL
	+9UOCuQjlzetXbFGGBISraMsWypHkNfYag2OF3X9Cg=
Received: from taozj888$163.com ( [2409:8a20:22c4:8eb0:343f:2daa:6f8d:39d4]
 ) by ajax-webmail-wmsvr-40-135 (Coremail) ; Wed, 7 Oct 2026 13:52:23 +0800
 (CST)
Date: Wed, 7 Oct 2026 13:52:23 +0800 (CST)
From: taozj888  <taozj888@163.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: =?GBK?Q?Th=A8=A6o_Lebrun?= <theo.lebrun@bootlin.com>,
	stable@vger.kernel.org, "Conor Dooley" <conor.dooley@microchip.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Haavard Skinnemoen" <hskinnemoen@atmel.com>,
	"Jeff Garzik" <jeff@garzik.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH net v2] net: macb: rate limit netdev error info print
 in the data path
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <3e1515e162d084e2200eeaa6074bfbaf@tipi-net.de>
References: <20260930113520.392025-1-taozj888@163.com>
 <b06cb02d9b26ceff272d7e34927a7eac@tipi-net.de>
 <DLUC9MKOACM3.OPW5RYHOYZV1@bootlin.com>
 <7cd93a53.199d.1a10724a8ae.Coremail.taozj888@163.com>
 <3e1515e162d084e2200eeaa6074bfbaf@tipi-net.de>
X-NTES-SC: AL_Qu2SA/+evUsv5SaRbOkfm04bju07UMu2v/4l2Y9SOp9wjB7o6gYwQ19jPl3k/tKrLyeSrye4aDhI+M53XaxnWb8MQCejPyjqwlsP9F6pf6uEEw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <37f9ba8b.1682.1a114eb8ca0.Coremail.taozj888@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hygvCgD3n54X3sVq0REcAA--.14518W
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC3RfIkGrF3heKZwAA3Z
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCgpIaSBOaWNvbGFpOgoKClBsZWFzZSBzZWUgbXkgYW5zd2VyIGlubGluZS4K
CgpUaGFuayB5b3UsClppamluIFRhbwoKQXQgMjAyNi0xMC0wNCAyMjowNjoyNCwgIk5pY29sYWkg
QnVjaHdpdHoiIDxuYkB0aXBpLW5ldC5kZT4gd3JvdGU6Cj5IaQo+Cj5PbiA0LjEwLjIwMjYgMTU6
NDAsIHRhb3pqODg4IHdyb3RlOgo+PiBIZWxsbyBUaGVvLCBOaWNvbGFpOgo+PiAKPj4gUGxlYXNl
IHNlZSBhbnN3ZXIgaW5saW5lLgo+Cj4+IFsuLi5dCj4KPj4+Pj4gRml4ZXM6IDg5ZTU3ODVmYzhh
NiAoIltQQVRDSF0gQXRtZWwgTUFDQiBldGhlcm5ldCBkcml2ZXIiKQo+Pj4+IAo+Pj4+IElNSE8g
dGhlIGNvcnJlY3QgdGFnIGlzIDRkZjk1MTMxZWE4MCAoIm5ldC9tYWNiOiBjaGFuZ2UgUlggcGF0
aCBmb3IKPj4+PiBHRU0iKT8KPj4+PiBBdCBsZWFzdCB0aGUgZ2VtX3J4KCkgbWVzc2FnZXMgd2Vy
ZSBpbnRyb2R1Y2VkIGhlcmUuCj4+PiAKPj4+IFRoZSBwYXRjaCB1c2VkIHRvIHRvdWNoIG1hY2Jf
c3RhcnRfeG1pdCgpLCB3aGljaCBleHBsYWlucyB3aHkgSSB0b2xkCj4+PiBaaWppbiB0byB0YXJn
ZXQgdGhlIGluaXRpYWwgY29tbWl0IG9uIHByZXZpb3VzIHJldmlzaW9uLgo+Pj4gCj4+IE9LLCBJ
IHdpbGwgc3RpbGwgdXNlIHRoZSBpbml0aWFsIGNvbW1pdCBpbmRpY2F0ZWQgYnkgVGhlby4KPgo+
UGxlYXNlIHJlLXJlYWQgVGiopm8ncyByZXBseTogaGUgb25seSBzdWdnZXN0ZWQgdGhlIGluaXRp
YWwKPmJlY2F1c2UgdjEgYWxzbyB0b3VjaGVkIG1hY2Jfc3RhcnRfeG1pdCgpLiB2MiBkb2Vzbid0
IGFueW1vcmUsCj44OWU1Nzg1ZmM4YTYgaXMgbm8gbG9uZ2VyIHRoZSByaWdodCB0YXJnZXQuIFBs
ZWFzZSB1c2U6Cj4KPkZpeGVzOiA0ZGY5NTEzMWVhODAgKCJuZXQvbWFjYjogY2hhbmdlIFJYIHBh
dGggZm9yIEdFTSIpCgo+CgoKT0ssIEkgd2lsbCB1c2UgdGhlIGNvbW1pdCBpZCA0ZGY5NTEzMWVh
ODAgaW5zdGVhZCBpbiBteSBuZXh0IHBhdGNoLiAKCj4+IFsuLi5dCj4KPj4+PiBUaGlzIHdpbGwg
anVzdCBoaWRlIHRoZSBlcnJvciBtZXNzYWdlLCBidXQgdGhlIHNwbGl0L2Ryb3AgaXMgc3RpbGwK
Pj4+PiBwcmVzZW50Lgo+Pj4+IEhvdyBhYm91dCBsaW1pdGluZyBKTUwgaW4gbWFjYl9pbml0X2h3
KCkgcHJvcGVybHk/Cj4+Pj4gCj4+Pj4gICAgICAgICAgaWYgKChicC0+Y2FwcyAmIE1BQ0JfQ0FQ
U19KVU1CTykgJiYgYnAtPmp1bWJvX21heF9sZW4pIHsKPj4+PiAgICAgICAgICAgICAgICAgIHUz
MiBqbWwgPSBicC0+cnhfYnVmZmVyX3NpemUgLSBORVRfSVBfQUxJR04gKwo+Pj4+IEVUSF9GQ1Nf
TEVOOwo+Pj4+ICAgICAgICAgICAgICAgICAgZ2VtX3dyaXRlbChicCwgSk1MLCBtaW4oam1sLCBi
cC0+anVtYm9fbWF4X2xlbikpOwo+Pj4+ICAgICAgICAgIH0KPj4+PiAKPj4+PiBUaGUgY29kZSBh
Ym92ZSBpcyB1bnRlc3RlZCwgc28gcHJvYmFibHkgbmVlZHMgZnVydGhlciB0d2Vha2luZy4gQW4K
Pj4+PiBhbHRlcm5hdGl2ZSBjb3VsZAo+Pj4+IGJlIHRvIGhhbmRsZSB0aGUgc3BsaXQgZnJhbWVz
IGluIGdlbV9yeCgpIGNvcnJlY3RseS4KPj4+IAo+Pj4gSSBhZ3JlZSB3aXRoIHlvdSBidXQgdG8g
Y2xhcmlmeSBmb3IgWmlqaW46IGlmIHlvdSBkbyB0aGlzIHRoZW4gaXQgCj4+PiBzaG91bGQKPj4+
IGJlIGEgc2VwYXJhdGUgcGF0Y2ggYXMgY2hhbmdlcyBhcmUgcHJldHR5IHVucmVsYXRlZC4KPj4g
Cj4+IFllcywgd2l0aCB5b3VyIGV4cGVyaWVuY2UgaW4gdGhpcyBhcmVhLCBtYXliZSBhIHNlcGFy
YXRlIHBhdGNoIGZvciBpdCAKPj4gaXMgcHJlZmVycmVkLgo+PiBJIHRoaW5rIHRoZSBlcnJvciBy
ZXBvcnRlZCBpcyBub3QganVzdCByZWxhdGVkIHRoZSBKdW1ibyBmcmFtZSwgYnV0IHRoZSAKPj4g
anVtYm8gZnJhbWUKPj4gd291bGQgdHJpZ2dlciB0aGUgZXJyb3IuIFNvIHJhdGUgbGltaXQgcHJp
bnRpbmcgdGhpcyBraW5kIG9mIG1zZyBpcyAKPj4gbmVlZGVkIGJ1dCBub3QKPj4gdG90YWxseSBo
aWRlIHRob3NlIG1zZ3MuCj4KPldoaWNoIG90aGVyIGNhc2VzIGRvIHlvdSBoYXZlIGluIG1pbmQ/
Cj4KPlJhdGUgbGltaXRpbmcgdGhlIG1lc3NhZ2UgaW4gdGhpcyBwYXRjaCBpcyBmaW5lIHdpdGgg
bWUuIEkgY2FuIGxvb2sKPmludG8gdGhlIEpNTCBwYXRjaCBzZXBhcmF0ZWx5LCBvciB5b3UgY2Fu
IGdpdmUgaXQgYSB0cnkuCj4KCj4+IFsuLi5dCgoKQ3VycmVudGx5IEkgaGF2ZSBub3QgZGlyZWN0
IGNhc2VzIGhlcmUsIGJ1dCBmb3Igc29tZSB0b3VnaCBuZXR3b3JrIGVudmlyb25tZXRzLAp0aGVy
ZSBtYXkgYmUgc29tZSBlcnJvciBwa3RzIHJlY2VpdmVkLCBlc3BlY2lhbGx5IGZvciBvdXIgY3Vz
dG9tZWQgSFcvU1cgbmV0d29yayByZXF1aXJlbWVudAp3aGljaCBtYXkgdHJpZ2dlciB0aGlzIGtp
bmQgb2YgbWVzc2FnZS4gCkJ1dCBsaW1pdGluZyB0aGUgSk1MIHJlY2VpdmUgdXBwZXIgbGltaXQg
ZnJvbSBIVyBpcyBzdGlsbCB2YWx1YWJsZSwgcGVyaGFwcyBpdCBzdGlsbCBuZWVkIG1vcmUKdGVz
dHMuCgoKVGhhbmtzIGZvciB5b3VyID4KPlRoYW5rcywKCj5OaWNvbGFpCgoKCgoKCgo=
