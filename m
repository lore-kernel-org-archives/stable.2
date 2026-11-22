Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371025;
	b=R28XQ7p58ANrtI7ljkJUCpUFi1SKWnt3JaFpGtc6d/FwZRtP9uxTCl57/WYAlpiy8LNT
	 E++pOD4vQc0DelyTLgk7n+HRFNDG+WW8JRoK5+wCdjK2U4cPMVcO2ai1W+BlFmhJavaEL
	 SPEaGg1FPGWJmD4AnUsnhwDzfLRw7ys/pdPHzXT6yeIzxlMC4LNcrgZzpyLJd1ykuu81X
	 kwa9FpyJRWvCwHRLRAwZOFVWF0bbP++jRo4+u8beKKIdEYL675R1pjPaHB4y5sLmK4M8Z
	 +Ylb3scBF4guP/G+oRNIsl0lMMYH9oucw9PteAqwCFAPe1J5ga3AGqWQImfunnFKpZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371025;
	h=DMARC-Filter:EX-QQ-RecipientCnt:X-QQ-GoodBg:X-QQ-SSF:X-QQ-FEAT:
	 X-QQ-BUSINESS-ORIGIN:X-QQ-Originating-IP:X-Originating-IP:X-QQ-STYLE:
	 X-QQ-mid:From:To:Cc:Subject:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:Date:X-Priority:Message-ID:X-QQ-MIME:
	 X-Mailer:X-QQ-Mailer:X-BIZMAIL-ID:X-Address-Ticket:X-QQ-SENDSIZE:
	 Received:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=OD5NavYjwmYRVbkR8VqwqhIDMwuk3hNu6EvrxHP0U9c=;
	b=dRYWmDgiXLqPJB3XijSbu9C8fMyeqaeUjwcr+U28LZR+mZIBkXsaMcwZ8Yl+tk8bk1RY
	 NDLj0IQXbTlU7NmUzKO2E2uKHZ74fOKfFI4v4GT7YWIK8lMaXyUN2eWKbzU+DRCiLEplu
	 2RuF2qSfNe+nWYkFFR3pRqGStGhcus9yk5Vb01esNHzFoPjREXuRQZn3Yr5SU2tlBYq1x
	 lwp5BINb/KXXCowupzMYaWsXE1/R3HYDMt4NGSsEBxUp6NPYhO8XcTAXcuc4mMBlWUZ3Q
	 eewpB/iCg/4JGn7MP5DpG5w+nsssDyfmxh00W/V+MiMlw9+vSwGhJYdULU+moCuVL+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=e.gzhu.edu.cn;
	spf=pass smtp.mailfrom=e.gzhu.edu.cn;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E2606A320;
	Sun, 22 Nov 2026 18:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 850E2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e.gzhu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e.gzhu.edu.cn
EX-QQ-RecipientCnt: 8
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000000040
X-QQ-FEAT: D4aqtcRDiqS21hctRIwgrWppQSBgmW2wb6dRneOslG0=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: ssPzF9ThNV/vUaMJznugGAsWDLKqtAwhOAZ8ZpSZRvs=
X-QQ-STYLE: 
X-QQ-mid: v3sz3b-12t1795370946t337e6a40
From: "=?utf-8?B?6buE5Y2O5oiQ?=" <1112433017@e.gzhu.edu.cn>
To: "=?utf-8?B?bGludXgtcmlzY3Y=?=" <linux-riscv@lists.infradead.org>
Cc: "=?utf-8?B?cGFsbWVy?=" <palmer@dabbelt.com>, "=?utf-8?B?cGp3?=" <pjw@kernel.org>, "=?utf-8?B?YW91?=" <aou@eecs.berkeley.edu>, "=?utf-8?B?YWxleA==?=" <alex@ghiti.fr>, "=?utf-8?B?ZGVidWc=?=" <debug@rivosinc.com>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: [PATCH 0/1] riscv: usercfi: bind signal shadow-stack restore to the active shadow stack
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
Date: Mon, 23 Nov 2026 02:09:06 +0800
X-Priority: 3
Message-ID: <tencent_009592B86559C9177427E98A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 4503553002980438403
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 23 Nov 2026 02:09:07 +0800 (CST)
Feedback-ID: v:e.gzhu.edu.cn:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N4WhQbLQyIqSuvWlBh58XioR6WOTTPxNT25mudBrnCIRfrZugK+43r3f
	XUFrjVOwmR2GkADKDnEGQuOTP0mpTuHIfWVuBA2FBu5a9YcINP24oNA0f8lCKnO6KlxxtWa
	NsUoP40qC4Rs8Sx12S6LZN5pdpU1u4lYxYdxW46Ww5ybTJdibTTLcmFUEjyPiROfMBu9HiN
	Hb2SIpZJ9pGBNbKHYo3W2t4yG7StbUS1/Berh0FXx5nK23pkI7w/gaVkBTMtw0Hoa86Uplk
	SAFuERNj7ecvV8xTDVANb0L+Dmku4zM2ws8WwVnc+SGzIYO+DgQWxWNmL3S3McKXJc4puYE
	u0QgzMxfNB3za7eYUaU/xzWAt0cML7q37mbPoIuMWbQYNdM8Gm8YHAacP4EwU2KD0/58Tli
	EZcU4ljgCb/445UWMaYmaY0eo4NwHsBdtFRmuI2y+D4ZqLA4ZZ0YVV9DtCEvVXc76Qc41MC
	Wd+UPcjqRuta/YPSBTVtvNOzBbo7gFIjDawlylXQ7/kTKjsM5D6e61oCdcB5PS7931sIRzC
	ceCJzmvEJS/Hdc30g1wOYwETFmMj/C2CuXz55CP+5rabewQ475oJ5fCRsaovnij1BJQczjv
	fJhXICJu0Eu8bMZLKchoCd7u4gpZrJTgYXLJy0l0U4pbQJ87HNqesm/MkTobiwIY7LS4WHH
	6cXshbtl2rMZrezFlej3/N/VtHd3SpudGvkXdpfswN3jkmu6w1kmCjMD4Y1kwgTuG+oklIS
	sRPUYg3E4zTaC1EdlBJ0fQgP3qVKs0rDxdEXW9byZpJJTkYwL+PReSrAJzU1WK7rKKPYFp6
	8lYL9+suCzqD5QANT60C6MocZUPRS1ncKqGL9vFebhrCVGAFlmC7Q5uzItEfnmp6MqaXZOx
	AiedjZEiNFdkxF1FQKc2SBHDMqLxwqXafa1vWYM/Jvee8xEVmPOpbpXjjkSr2fAEUzmAx1u
	U4m38myTR/WL9oYhQ5+n34iPrQKem3zPXGgLY8PhVnEqxa2mAit5JUS4w
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

SGVsbG8sV2hpbGUgYXVkaXRpbmcgdGhlIHNpZ25hbCBwYXRoIG9mIHRoZSBSSVNDLVYgdXNl
cmNmaSBpbXBsZW1lbnRhdGlvbiAoWmljZmlzcyBzaGFkb3cgc3RhY2tzKSBhZ2FpbnN0IHg4
NiBDRVQgYW5kIGFybTY0IEdDUywgd2UgZm91bmQgdGhhdCByZXN0b3JlX3VzZXJfc2hzdGso
KSB2YWxpZGF0ZXMgdGhlIHJlc3RvcmUgdG9rZW4gb25seSBieSBhIHZhbHVlIHJlbGF0aW9u
ICh0b2tlbiA9PSBzaHN0a19wdHIgKyBTSFNUS19FTlRSWV9TSVpFKSBhdCBhIHBvaW50ZXIg
dGFrZW4gZnJvbSB0aGUgdXNlciBzaWduYWwgZnJhbWUgKHNjX2V4dGRlc2Muc3NfcHRyKSwg
d2l0aG91dCBiaW5kaW5nIHRoYXQgcG9pbnRlciB0byB0aGUgc2hhZG93LXN0YWNrIHBvc2l0
aW9uIHRoZSBrZXJuZWwgaXRzZWxmIHJlY29yZGVkIGF0IHNpZ25hbCBkZWxpdmVyeS5BIGNv
cnJ1cHRlZCBzaWdmcmFtZSBjYW4gdGhlcmVmb3JlIHBvaW50IHRoZSByZXN0b3JlIGF0IGEg
c3RhbGUgYnV0IHN0aWxsLWxpdmUgdG9rZW4gZnJvbSBhbm90aGVyLCBuZXZlci1yZXN0b3Jl
ZCBzaWduYWwgY29udGV4dCAodGhpcyBpcyBhbiBpbi1ib3VuZHMsIGdlbnVpbmVseSB2YWxp
ZCB0b2tlbiwgc28gaXQgcGFzc2VzIHRoZSBib3VuZHMgY2hlY2sgYWRkZWQgYnkgZGYzMzNi
NzJjMGUxKS4gIFRoZSBrZXJuZWwgdGhlbiBzd2FwcyB0aGUgdG9rZW4gb3V0IGFuZCByZXdp
bmRzIHNzcCB0byB0aGF0IHRva2VuJ3MgcG9zaXRpb24gLSBhbiBhdHRhY2tlci1jaG9zZW4g
aGlzdG9yaWNhbCBzaGFkb3ctc3RhY2sgZGVwdGggLSBhZnRlciB3aGljaCBzc3BvcGNoaygp
IHZhbGlkYXRlcyBhIHJldHVybiBhZGRyZXNzIHRoYXQgaXMgb25seSAidmFsaWQiIGF0IHRo
ZSByZXdvdW5kIGRlcHRoLiAgV2UgY2FsbCB0aGlzIHJlcGxheSBjbGFzcyBBLVJFV0lORC4g
IHg4NiBDRVQgZG9lcyBub3QgaGF2ZSB0aGlzIHNoYXBlOiBpdHMgc2lnZnJhbWUgY29udGFp
bnMgbm8gc2hhZG93LXN0YWNrIHBvaW50ZXIgYXQgYWxsIGFuZCB0aGUgdG9rZW4gaXMgcmVh
ZCBmcm9tIHRoZSBrZXJuZWwtY3VycmVudCBTU1AuVGhyZWF0IG1vZGVsOiB0aGUgYXR0YWNr
ZXIgYWxyZWFkeSBoYXMgYSBtZW1vcnktY29ycnVwdGlvbiBwcmltaXRpdmUgc3VmZmljaWVu
dCB0byBjb3JydXB0IHRoZSBzaWdmcmFtZS4gIFRoYXQgaXMgZXhhY3RseSB0aGUgdGhyZWF0
IG1vZGVsIHNoYWRvdyBzdGFja3MgZXhpc3QgZm9yLCBzbyB0aGUgcmVzdG9yZSBwYXRoIG11
c3Qgbm90IHdpZGVuIGl0IGludG8gYSBjb250cm9sbGVkIENGSSBieXBhc3MuV2UgZGVtb25z
dHJhdGVkIHRoZSBmdWxsIGNoYWluIGVuZCB0byBlbmQgb24gYSBmdWxseSBoYXJkZW5lZCB0
YXJnZXQgKFBJRSArIEFTTFIgKyBjYW5hcnkgKyBGdWxsIFJFTFJPICsgTlggKyByZWFsIGNs
YW5nIFppY2Zpc3MgaW5zdHJ1bWVudGF0aW9uLCBydW5uaW5nIHVuZGVyIExpbnV4L3Jpc2N2
NjQgdXNlcmNmaSk6IHRoZSBjb3JydXB0ZWQgc2lncmV0dXJuIHJld2luZHMgc3NwIHRvIGEg
Y2hvc2VuIGRlcHRoLCBzc3BvcGNoayBwYXNzZXMgb24gdGhlIHJld291bmQgc2xvdCwgYW5k
IGV4ZWN1dGlvbiByZXN1bWVzIGF0IGFuIGF0dGFja2VyLWNob3NlbiBzaXRlIHRoYXQgcGVy
Zm9ybXMgYSBwcm90ZWN0ZWQgYWN0aW9uIG9ic2VydmFibGUgb25seSB2aWEgdGhlIHJld2lu
ZC4gIFdpdGggdGhlIHNpeC1saW5lIGJpbmRpbmcgYmVsb3cgdGhlIHNhbWUgY2hhaW4gaXMg
YmxvY2tlZCBhdCB0aGUga2VybmVsIGNoZWNrLlN0YXRpc3RpY3MgZnJvbSAxMzAgaW5kZXBl
bmRlbnQgZXhlY3ZlIHJvdW5kcyAoNzAgdW5wYXRjaGVkIC8gNjAgcGF0Y2hlZCwgQVNMUiBv
bik6IHVucGF0Y2hlZCA2Ny82NyBzdWNjZXNzIGFtb25nIHJvdW5kcyB0aGF0IGNvbXBsZXRl
ZCByZWNvbm5haXNzYW5jZSAoMyByb3VuZHMgbG9zdCB0byBhIGxlYWstd2luZG93IGFydGlm
YWN0IHVucmVsYXRlZCB0byB0aGUgcGF0Y2gpOyBwYXRjaGVkIDUyLzUyIGJsb2NrZWQgYW1v
bmcgY29tcGxldGVkIHJvdW5kcy4gIE9mZmljaWFsIGtzZWxmdGVzdHMgKHJpc2N2L3NpZ3Jl
dHVybiwgc2lnbmFsL3Nhcywgc2lnbmFsL21hbmdsZV91Y19zaWdtYXNrKSBwYXNzIGlkZW50
aWNhbGx5IG9uIGJvdGgga2VybmVscywgYXMgZG8gbm9ybWFsL25lc3RlZC9zaWdhbHRzdGFj
ay8gc2lnbG9uZ2ptcC9zZXRjb250ZXh0L3N3YXBjb250ZXh0IHNjZW5hcmlvcy4gIE92ZXJo
ZWFkIG9mIHRoZSBhZGRlZCBjb21wYXJpc29uIGlzIGJlbG93IG1lYXN1cmVtZW50IG5vaXNl
IChzdWItbnMgbmF0aXZlOyBUQ0cgcnVucyBzaG93IG5vIG1lYXN1cmFibGUgZGVsdGEgYWJv
dmUgYm9vdC10by1ib290IHZhcmlhbmNlKS5UaGUgZml4IHVzZXMgdGhlIGV4aXN0aW5nIGdl
dF9hY3RpdmVfc2hzdGsoKSBib29ra2VlcGluZyB0aGF0IHNhdmVfdXNlcl9zaHN0aygpIGFs
cmVhZHkgbWFpbnRhaW5zIGF0IGRlbGl2ZXJ5LCBzbyB0aGUgYWRkZWQgY29zdCBhdCBzaWdy
ZXR1cm4gaXMgb25lIGNvbXBhcmlzb24uICBUaGUgcGF0Y2ggaXMgZ2VuZXJhdGVkIGFnYWlu
c3QgdGhlIHRyZWUgd2UgdmFsaWRhdGVkIG9uOyBpdCB0cml2aWFsbHkgcmViYXNlcyAoc2lu
Z2xlIGh1bmsgaW4gcmVzdG9yZV91c2VyX3Noc3RrLCBwbGFjZWQgYWZ0ZXIgdGhlIGRmMzMz
YjcyYzBlMSBib3VuZHMgY2hlY2spLlJlcHJvZHVjZXIgKHByb2JlLCBzY3JpcHRzLCBwaW5u
ZWQga2VybmVsLWltYWdlIGhhc2hlcywgbG9ncykgYXZhaWxhYmxlIG9uIHJlcXVlc3Qgb3Ig
dmlhIGEgYnJhbmNoLlRoYW5rcyxMb29raW5nIGZvcndhcmQgdG8geW91ciByZXBsee+8gQ==

