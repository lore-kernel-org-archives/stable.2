Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE05D46EF99
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948940; cv=none; b=fg6jHm73XPugrhPbWrJ8S7wNg+kSXnmw3UJJJ1F1sNXE5na2ja/E/04+h0AG/Q8PeuqbzWuXafaQc3RqAF1703+uNtLc2+E501wX2WyyUzbz6EwP8zg78oKt08TiqKVz1+OMiWZgm7pvYe3Vyr4Zw20NAH7fs7L6Ot09SyOLTr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948940; c=relaxed/simple;
	bh=5VvtgsoTSQ1UX+dvf0GjlKbO76pRAIN1qH0779TMsgM=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=Bkgo6J8t233Tj7WNAyN4v1SpR0yOE2OTjYxArOvzD+PVtAWPdG9uwmGPIgM6ZiKeprvOXMTG4ECdam5p3k6JdnKbG/jsdzvdVeVH2/nrO0DgGnNDvw3ZaP2tRAnDJENxxgnI2X3hCxDO0VKTmppfKTWaUxW46/jmsoTT52T5aYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lvKk5cJN; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lvKk5cJN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785948885;
	bh=5VvtgsoTSQ1UX+dvf0GjlKbO76pRAIN1qH0779TMsgM=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=lvKk5cJNZzcnujBqz+gXDfnpFNVskyxzciqgu+92G3APy7pXIZ5qBRQUc9UM2E3Z9
	 CrvsHGqdkXSQdG1rpV5T9LMNDzOjctqfgnGrQfqYJfnUq+hayxzOyGXLtZAHF+7a8K
	 MLFwvkN3tSqtK/TbKCHl3b1zACIAFXRPscCWGVW4=
EX-QQ-RecipientCnt: 3
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqRAVxdDoxBRm7UtD1tgRPVtQE3tHqLqX/E=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: pQayqbEZM6fvJd8pYi725N6DVtyDyWX1Re0Vt/FoOAeIFp+fVWq+i9Bi+f1GxnQIzuB2sny986yw9+oeWxkXmQ==
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1785948883t1d03ed46
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>
Cc: "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.18.y 0/5] Backport fixes for handshake
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 6 Aug 2026 00:54:42 +0800
X-Priority: 3
Message-ID: <tencent_17E63449525394B22CAE2867@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260805091348.609325-1-guanwentao@uniontech.com>
	<20260805164000.stable-0005@kernel.org>
In-Reply-To: <20260805164000.stable-0005@kernel.org>
X-QQ-ReplyHash: 2038353947
X-BIZMAIL-ID: 15468566386234416369
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 06 Aug 2026 00:54:44 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NSHxYNOPpzDbXaAvLsY462s5Lvmf0YX66/SgxU2jg4PZTfrkJtondlp5
	WKCRCSLFRv6SLoy5dG5Si1Yd5X9Az8gDYrFyF7N+F+VZY4NDcI2B3XZkCDKXL8+xiYp594B
	5Nt/G44qlvZRIB1Ez/dXmbbQE4TXudS9pDJNb9rAXT38xlEgOaNfpLOWKJGxSQHKFh8OHZB
	EGG0LVpXXVCwo6OYBSYCq6ADgUTFH40VZKqwzVypFJnEj/AcsWgiK1ovEynB3a2R1E439Is
	U8a8XwMa+2S4FWJRm4b2ejQqSEZs1EEGp3xuVGn0sL5a42yJ8tgQCAG96pr5YE9oaYTmULb
	f0GN1Rlk2I0QCgMi9l0TvXxGQT9Q+WFIFjMoJESsr70xFKmEbzQGDZoSw8vV4pLmoGxitMP
	u+GLPV9QcLGctsx1Ai8ZH6j8ViH+psA/hAgaYqcKARn3d+YqWVE0WQ+9Td232f08it/I/1q
	gf/BbQX2YDWSRnZQLjmwn/Molfus+vqAyFuNfVC5p72QJaaXGcmmDpVifvSTF0r/dqaqf06
	p3cV8dr+G4URSY7XCTRUDrI0W/2qSxs+XymGxEGYfiLIQC2n6NVqn3ep4UY4wh7aYMjcO+7
	5NzJBR6JfCva/JmBz2REBScXQxdZKpMB/y/LeuqRWxCnxlsBTyUywCk8PsPKvLHfEczuQU6
	d5Bkl3oYYU1oMoP8LiGfe9R5E73N+c9aWSfFZc79WTf4nBB5kdpvhAKxS4KvMcroM9MCuWH
	6LNfOlNIP1GnvrQq32eK7x9o8ZW7Kvv5WUQiu7G0XEl8/vRwScZ3yK5L3myV9Ku97eU9/me
	DOFpK7mkdUwcZwYXM89zgFZjxeKqbk6WsSCBAtfwX67ekCkQyEuEVLeWcYAmuT+Ks5gu9dJ
	9CrbXQOuS/qK8fwLNcMoM1VgHjWsazlqimFu1koSmnG5qWmw3UD+zwV8pDZHRFfStmgVbKA
	7aVUkBQBXhrkvlge5oyC+jpYDmwQ7K5ap1IFuEJegmvTcpLWxLCrelQfXEbHg5L8lqG+a5s
	br34LJFO35vZLKjFCRfZ3/vQ5bXzllKVwmrBEmN3Qifj/6JJdDJihVSXdwcC/0NnBZlw4Va
	7oJdLmtPWrT17QYwNFZ1xs=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

SGksDQoNCj4gT24gV2VkLCBBdWcgMDUsIDIwMjYgYXQgMDU6MTM6NDRQTSArMDgwMCwgV2Vu
dGFvIEd1YW4gd3JvdGU6DQo+ID4gQ2hyaXN0aWFuIEJyYXVuZXIgKDIpOg0KPiA+ICAgZmls
ZTogYWRkIEZEX3tBREQsUFJFUEFSRX0oKQ0KPiA+ICAgbmV0L2hhbmRzaGFrZTogY29udmVy
dCBoYW5kc2hha2VfbmxfYWNjZXB0X2RvaXQoKSB0byBGRF9QUkVQQVJFKCkNCj4gPg0KPiA+
IENodWNrIExldmVyICgzKToNCj4gPiAgIG5ldC9oYW5kc2hha2U6IFRha2UgYSBsb25nLWxp
dmVkIGZpbGUgcmVmZXJlbmNlIGF0IHN1Ym1pdA0KPiA+ICAgbmV0L2hhbmRzaGFrZTogaGFu
ZCBvZmYgdGhlIHBpbm5lZCBmaWxlIHJlZmVyZW5jZSB0byBhY2NlcHRfZG9pdA0KPiA+ICAg
bmV0L2hhbmRzaGFrZTogQ2xvc2UgdGhlIHN1Ym1pdC1zaWRlIHNvY2tfaG9sZCByYWNlDQo+
IA0KPiBUaGUgc2VyaWVzIGlzIG1pc3NpbmcgdHdvIGZvbGxvdy11cHMsIGFuZCB3aXRob3V0
IHRoZW0gNi4xOCBlbmRzIHVwIHdvcnNlDQo+IG9mZiB0aGFuIGl0IGlzIHRvZGF5Og0KPiAN
Cj4gLSBkYWJhYzUxYjgxMDIgKCJuZXQvaGFuZHNoYWtlOiBGaXggbnVsbC1wdHItZGVyZWYg
aW4gaGFuZHNoYWtlX2NvbXBsZXRlKCkiKQ0KPiAgIGZpeGVzIGZlNjdiMDYzZjY4NyAoIm5l
dC9oYW5kc2hha2U6IGNvbnZlcnQgaGFuZHNoYWtlX25sX2FjY2VwdF9kb2l0KCkgdG8NCj4g
ICBGRF9QUkVQQVJFKCkiKSwgeW91ciAyLzUuIEFmdGVyIHRoYXQgY29udmVyc2lvbiB0aGUg
b3JkaW5hcnkgIm5vIHBlbmRpbmcNCj4gICByZXF1ZXN0IiBBQ0NFUFQgcGF0aCBmYWxscyB0
aHJvdWdoIHRvIGhhbmRzaGFrZV9jb21wbGV0ZShOVUxMLCAtRUlPLCBOVUxMKQ0KPiAgIGFu
ZCBkZXJlZmVyZW5jZXMgcmVxLT5ocl9zay4NCj4gDQo+IC0gZDJlYTRkMjU0ZDA0ICgiZmls
ZTogZW5zdXJlIGNsZWFudXAiKSBmaXhlcyAwMTE3MDNhOWFjZDcgKCJmaWxlOiBhZGQNCj4g
ICBGRF97QURELFBSRVBBUkV9KCkiKSwgeW91ciAxLzUuIFdpdGhvdXQgaXQgdGhlIGltcG9y
dGVkIGNsZWFudXAgZ3VhcmQgaXMNCj4gIGVyci1nYXRlZCBhbmQgbm8tb3BzIG9uIHRoZSBh
Y2NlcHQtZmFpbHVyZSBwYXRoLCBsZWFraW5nIGFuIGZkIGFuZCBhDQo+ICBzdHJ1Y3QgZmls
ZS4NCg0KPiBFaXRoZXIgd2F5LCBwbGVhc2UgZ2V0IGFuIGFjayBmcm9tIHRoZSBoYW5kc2hh
a2UgbWFpbnRhaW5lcnMuDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBmb3JnZXRpbmcgZG91
YmxlIGNoZWNrIHRoZSBiYWNrcG9ydCBmaXhlcywNCkkgd2lsbCBmaXggdGhlbSBhbmQgc2Vu
ZCB2Mi4NCg0KQlJzDQpXZW50YW8gR3Vhbg==

