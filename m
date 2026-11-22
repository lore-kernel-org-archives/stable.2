Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371550;
	b=Mvl0XFeT6c4ukqho4Posv1USk1kjIaFWjxzfWzDZKRFukZ/ADQj/AFkgTLmwnA5l0NA8
	 2Giijaaerlx+jtfTOT2NblbVMkCJ6s6FaUYX56SKfOoJ6ekhT+Vyi5pwTtHwh0UsO5P8r
	 JwQF/UZUOk9ly+Up5iWLUZ3z1seb9u6BzYtuCQYkULxQWsGNe+DiT/588vjkw9bFSmIvi
	 4kVQdkIDPD449XmpjvfqSjea+LQ6T+5iU2d8iU/Nj1SMmEvr+4vLGTXMvvfbYi469wRoy
	 dkqwFr4VSkXI9AWD7us27da1az906ghomdwAFbgowFdN0aowcHGs3zGmP6A+pimn8qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371550;
	h=DMARC-Filter:EX-QQ-RecipientCnt:X-QQ-GoodBg:X-QQ-SSF:X-QQ-FEAT:
	 X-QQ-BUSINESS-ORIGIN:X-QQ-Originating-IP:X-Originating-IP:X-QQ-STYLE:
	 X-QQ-mid:From:To:Cc:Subject:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:Date:X-Priority:Message-ID:X-QQ-MIME:
	 X-Mailer:X-QQ-Mailer:X-BIZMAIL-ID:X-Address-Ticket:X-QQ-SENDSIZE:
	 Received:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=i/wjVIPlP2R9gNT5vq11Y2G1w8pd22813D7FBe33Oqw=;
	b=a0Ym9YbyiEnLjBFzwIFQ5szcNOs+OjToPFsT9XVZZnKv5npksHKNvWvEDqoi/D3J8RzB
	 UGen6e2l4xJSw/PyCyACeUnI/iI+K2iWcN5C4lBUJjIpW81akRyzqZgqB4OQ4vVbqaVNA
	 Yfu2oAeCy7G0tfdFu/is7zKzkqcdZg3xiq2A0LgtrMg+tVRvTlhvoARm+WWz6RJgaAJ6K
	 DuYv67zCPe8RfMf4oeThU3h+8eAQWHDcchPfKD4hJp6/6f8atLuDO/SULd7Dyr2ch3qJ2
	 xiDm/dJIX/6yEq0a1H4RubM3IdbnLbFkpyq+lwpQqhbtvqE/TcFXSht+uxLfuaPysmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=e.gzhu.edu.cn;
	spf=pass smtp.mailfrom=e.gzhu.edu.cn;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16C9606A320;
	Sun, 22 Nov 2026 18:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C16C9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e.gzhu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e.gzhu.edu.cn
EX-QQ-RecipientCnt: 8
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000000040
X-QQ-FEAT: D4aqtcRDiqQtbsZxYg5kKrZhFlAOQ0dvpr/wz5oBo58=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: IMdIvrQZYyLhY+74ZVC1JV8JkWdl0Lly2jAWj97/dkM=
X-QQ-STYLE: 
X-QQ-mid: v3sz3b-12t1795371479t8cade204
From: "=?utf-8?B?6buE5Y2O5oiQ?=" <1112433017@e.gzhu.edu.cn>
To: "=?utf-8?B?bGludXgtcmlzY3Y=?=" <linux-riscv@lists.infradead.org>
Cc: "=?utf-8?B?cGFsbWVy?=" <palmer@dabbelt.com>, "=?utf-8?B?cGp3?=" <pjw@kernel.org>, "=?utf-8?B?YW91?=" <aou@eecs.berkeley.edu>, "=?utf-8?B?YWxleA==?=" <alex@ghiti.fr>, "=?utf-8?B?ZGVidWc=?=" <debug@rivosinc.com>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: [PATCH 1/1] riscv: usercfi: bind signal shadow-stack restore to the active shadow stack
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 23 Nov 2026 02:17:59 +0800
X-Priority: 3
Message-ID: <tencent_7D0AC8F176A26AB26D61F6A8@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 3799301788162156059
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 23 Nov 2026 02:18:00 +0800 (CST)
Feedback-ID: v:e.gzhu.edu.cn:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NafziRg7Bx695yxYMRy+91ZtTDESzRZMc/4mUZ6G5JcVjkNGJ8Ll/uER
	rZjJkxeJkjDjEGQePQBIyhUPdY0r7+vKL40HqHVexrJu+KcQeGf5/vV5W7MoKjz9nODWj6r
	we+B+n/DKchS0bqdtbbcAM5hDDgJVUtM3uKlTLGsFhncbz1uTklRHO69X9zPE62dBGYu1rW
	QMEPOqDlptwp9rFfwTIfIUFCiCatJ1teli/CWjd+6tyfWUwN5EKLlGk2xUwcYyD1XsSgBLl
	qqJUxRizAqKNBPF+ChpwHJ/TKy9Li4nFsNorhZ7BPJxMvKAPCwYjEfJVkXRfPqKMIrJ6ecD
	qYkHAsJvRhDV2YPt3qf1m1qe7cqbN/yZeS6pnIaRvHOZaQFMn1oSiZvi9e2zv2Wp4KYGp42
	vIaHmjcvFke9yzRvdkGfsvccSxdrXo1GtI6iVtjbOIGglk2bc0SEgqBdDDAVjZAEDWqPyUQ
	e7D5cddWrGf8Yqe9svARYvKr89hbrlJwvvteE/Qcv7wCjyPMltEfl09L09xQ0EvaSO8le6k
	BMPAS5kJqf3kkOV0wVv/0ajSMXVtyF5Ez0Udyci1zGIiPukmapMVX3SxiyI/t1pDT+ZP7AB
	c1yqJUB36ufzqQ+ZX75eJ23OnOWs3ndBVYP2C0ZK2eze4n9MCLNKyxm4QtHqh5vjrIy4fS4
	2HdyUjNx9EYEqhnUQlXWFQvrGDhQK33s0neHx8Fn+3yhTXOQGGFaDYxJbjtBHY/LN1N1N65
	7xLLTpWpBq2/lfts31xYgm3sDM5WHHOoFmJCNQlDui9Rzba2519u9yye/H5jA1zA6DNuSLg
	sfavJD2AloK5bEaAH+N9laV5aD5qOIfAMP1jIGBW6sZDj9ezDiMiR0eW85SPxFYp++ukFtJ
	C+P06NjPNbk0F6JNoW3pXzZW4d7jZ1LtQ7Dbv6hY+tKXEqeV7cTH5ePUBcxYFjpibyhl7hb
	6abYq+PUMRCe7kxM8tNv6T2KXDLRI1QTF8kUwPfPWuM/n+tlsrwRYVHGFTlrg2lLdVT1uEp
	r3nfk2/5rGgbTmpbP+
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

aGVsbG8sDQpXcml0ZSBpdCdzIGZvciB1c2VyY2ZpLA0KcmVzdG9yZV91c2VyX3Noc3RrKCkg
cmVhZHMgdGhlIHNoYWRvdy1zdGFjayBwb2ludGVyIGZyb20gdGhlIHVzZXIgc2lnbmFsIGZy
YW1lIChzY19leHRkZXNjLnNzX3B0cikgYW5kIHZhbGlkYXRlcyB0aGUgdG9rZW4gZm91bmQg
dGhlcmUgb25seSBieSB0aGUgdmFsdWUgcmVsYXRpb24gdG9rZW4gPT0gc2hzdGtfcHRyICsg
U0hTVEtfRU5UUllfU0laRS4gIE5vdGhpbmcgYmluZHMgc3NfcHRyIHRvIHRoZSBzaGFkb3ct
c3RhY2sgcG9zaXRpb24gdGhlIGtlcm5lbCByZWNvcmRlZCB3aGVuIHRoZSBzaWduYWwgd2Fz
IGRlbGl2ZXJlZC4NCg0KQSBjb3JydXB0ZWQgc2lnZnJhbWUgY2FuIHRoZXJlZm9yZSByZWRp
cmVjdCB0aGUgcmVzdG9yZSB0byBhIHN0YWxlIGJ1dCBzdGlsbC1saXZlIHRva2VuIGJlbG9u
Z2luZyB0byBhbm90aGVyIHNpZ25hbCBjb250ZXh0IChpbi1ib3VuZHMgYW5kIGdlbnVpbmVs
eSB2YWxpZCwgc28gdGhlIGRmMzMzYjcyYzBlMSBib3VuZHMgY2hlY2sgcGFzc2VzKTsgdGhl
IGtlcm5lbCBhY2NlcHRzIGl0LCBzd2FwcyBpdCBvdXQsIGFuZCByZXdpbmRzIHNzcCB0byB0
aGF0IHRva2VuJ3MgcG9zaXRpb24uICBUaGUgcmVzdWx0IGlzIGEga2VybmVsLW1lZGlhdGVk
IHNoYWRvdy1zdGFjayByZXdpbmQgdG8gYW4gYXR0YWNrZXItY2hvc2VuIGRlcHRoLCBhZnRl
ciB3aGljaCBzc3BvcGNoaygpIGFjY2VwdHMgcmV0dXJuIGFkZHJlc3NlcyB0aGF0IGFyZSBv
bmx5IHZhbGlkIGF0IHRoYXQgaGlzdG9yaWNhbCBkZXB0aCAtIGEgYmFja3dhcmQtQ0ZJIGJ5
cGFzcyByZWFjaGFibGUgZnJvbSBhbiBvcmRpbmFyeSBtZW1vcnktY29ycnVwdGlvbiBwcmlt
aXRpdmUuICB4ODYgQ0VUIGRvZXMgbm90IGhhdmUgdGhpcyBzaGFwZTppdHMgc2lnZnJhbWUg
Y29udGFpbnMgbm8gc2hhZG93LXN0YWNrIHBvaW50ZXIgYXQgYWxsLg0KDQpCaW5kIHRoZSBy
ZXN0b3JlIHBvaW50ZXIgdG8gZ2V0X2FjdGl2ZV9zaHN0ayh0c2spLCB0aGUgcG9zaXRpb24g
c2F2ZV91c2VyX3Noc3RrKCkgcmVjb3JkZWQgYXQgZGVsaXZlcnksIGFuZCBmYWlsIHdpdGgg
LUVJTlZBTCBvbiBtaXNtYXRjaC4gIFZhbGlkIHJldHVybnMgYXJlIHVuYWZmZWN0ZWQgYmVj
YXVzZSBvbiB0aGUgaGFwcHkgcGF0aCB0aGUgZnJhbWUncyBzc19wdHIgZXF1YWxzIHRoZSBh
Y3RpdmUgcG9zaXRpb24gYnkgY29uc3RydWN0aW9uLg0KDQpWZXJpZmllZCBvbiBhIGZ1bGx5
IGhhcmRlbmVkIGluc3RydW1lbnRlZCB0YXJnZXQgKFBJRS9BU0xSL2NhbmFyeS9SRUxSTy9O
WCwgY2xhbmcgWmljZmlzcyk6IHRoZSBzdGFsZS10b2tlbiByZXBsYXkgY2hhaW4gc3VjY2Vl
ZHMgb24gdGhlIHVucGF0Y2hlZCBrZXJuZWwgKDY3LzY3IGFtb25nIGNvbXBsZXRlZCByZWNv
biByb3VuZHMpIGFuZCBpcyBibG9ja2VkIG9uIGhlIHBhdGNoZWQgb25lICg1Mi81MiksIHdo
aWxlIG5vcm1hbCBhbmQgbmVzdGVkIHNpZ25hbHMsIHNpZ2FsdHN0YWNrLCBzaWdsb25nam1w
IGZvbGxvd2VkIGJ5IGEgbGF0ZXIgc2lnbmFsLCBzZXRjb250ZXh0IGFuZCBzd2FwY29udGV4
dCBhbGwgYmVoYXZlIGlkZW50aWNhbGx5IG9uIGJvdGgga2VybmVscywgYXMgZG8gdGhlIG9m
ZmljaWFsIHNpZ25hbCBrc2VsZnRlc3RzLg0KDQpGaXhlczogNjZjOWM3MTNkZTU5ICgicmlz
Y3Yvc2lnbmFsOiBzYXZlIGFuZCByZXN0b3JlIHRoZSBzaGFkb3cgc3RhY2sgb24gYSBzaWdu
YWwiKQ0KDQoNCi0tLQ0KIGFyY2gvcmlzY3Yva2VybmVsL3VzZXJjZmkuYyB8IDkgKysrKysr
KysrDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
YXJjaC9yaXNjdi9rZXJuZWwvdXNlcmNmaS5jIGIvYXJjaC9yaXNjdi9rZXJuZWwvdXNlcmNm
aS5jDQotLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC91c2VyY2ZpLmMNCisrKyBiL2FyY2gvcmlz
Y3Yva2VybmVsL3VzZXJjZmkuYw0KQEAgLTIwNyw2ICsyMDcsMTUgQEAgaW50IHJlc3RvcmVf
dXNlcl9zaHN0ayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaywgdW5zaWduZWQgbG9uZyBzaHN0
a19wdHIpDQogew0KIAl1bnNpZ25lZCBsb25nIHRva2VuID0gMDsNCg0KKwkvKg0KKwkgKiBU
aGUgZnJhbWUgY29udHJvbHMgc3NfcHRyOyBiaW5kIGl0IHRvIHRoZSBrZXJuZWwtcmVjb3Jk
ZWQgYWN0aXZlDQorCSAqIHNoYWRvdyBzdGFjayBzbyBhIGNvcnJ1cHRlZCBzaWdmcmFtZSBj
YW5ub3QgcmVkaXJlY3QgdGhlIHJlc3RvcmUNCisJICogYXQgYSBzdGFsZSBidXQgc3RpbGwt
bGl2ZSB0b2tlbiBmcm9tIGFub3RoZXIgc2lnbmFsIGNvbnRleHQuDQorCSAqLw0KKwlpZiAo
c2hzdGtfcHRyICE9IGdldF9hY3RpdmVfc2hzdGsodHNrKSkgew0KKwkJcHJfaW5mb19yYXRl
bGltaXRlZCgiJXNbJWRdOiBzaGFkb3cgc3RhY2sgcHRyIG1pc21hdGNoIGluICVzOiBleHBl
Y3RlZD0lcHgsIGdvdD0lcHhcbiIsDQorCQkJCSAgICB0c2stPmNvbW0sIHRhc2tfcGlkX25y
KHRzayksIF9fZnVuY19fLA0KKwkJCQkgICAgKHZvaWQgKilnZXRfYWN0aXZlX3Noc3RrKHRz
ayksDQorCQkJCSAgICAodm9pZCAqKXNoc3RrX3B0cik7DQorCQlyZXR1cm4gLUVJTlZBTDsN
CisJfQ0KKw0KIAl0b2tlbiA9IGFtb191c2VyX3Noc3RrKCh1bnNpZ25lZCBsb25nIF9fdXNl
ciAqKXNoc3RrX3B0ciwgMCk7DQoNCiAJaWYgKHRva2VuID09IC0xKQ0KLS0NCjIuNDMuMA0K
DQpUaGFua3MsDQpMb29raW5nIGZvcndhcmQgdG8geW91ciByZXBseSE=

