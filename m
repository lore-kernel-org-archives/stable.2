Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794055531;
	b=X7YQF5YLXhTRxuecr2uh0KV6yHn4ADlLiRvmDCik8Eri+2PdCPzsHjrOzv4UQQWTEmSg
	 g1QM2hYSEPJeSWoQs5w3e7ZJQ3lIBlTeSkKHnUynT2XPUJ9T8fNZwfh05dhfkLo+zO//o
	 xjOfA9VgZqCqwQuBPqZxk+Go4+5CoIufB1SFbz7YaFpnyW5yjFlR/QooEnMfYBw7Y1XG/
	 6d7zJTdOb1XZNC0TP4/F2Qq75HoEBp1vxqviNflbsiAZtZCsh5IZCxLkmUrLgwdSXAYwt
	 pSscYj8Q8pNMeqJ+m9VvPIY0Gfnqm6rC9dF6cC7Advy0H0VasxH/QAAVhdVa+6toW5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794055531;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Content-Type:Mime-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=uNsoN5s3tYOyQSbYOyF95i0CLIunbzIhBkNsKkisfy0=;
	b=WeTvNsSSNLvIthdfOKOETOH9YBnbUCT/L4HQ9ZAHRs1OktVGjbQ3G0cDdDFl1XNHlTR4
	 StWuyBYLyqEDfHG6tJ2lB+Bn3qQmVIYGFY8JnzUyqSxw+F+uOOp6OxsOYNv2JY0jMrHmq
	 m5zrLRzHb4Jii6RJQk2j/JXL3pD2RBWvYxchOqiytjHRk8SHgcnxR4QzisBTmSqv7z+LA
	 agPFDgFGKBt6GtCQjbSukcBYvLak0DmoWwKqTndVRMWqp/zacXVJ1J8CWedUCKwkzf3RD
	 0kbLCtbR/IE+9i0uWvftXJ/SUvg9llzY7tXNCdwRe8t008HWpcuZk7zFiDVTmKiu6XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=net-swift.com;
	spf=pass smtp.mailfrom=net-swift.com;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183B5606A326;
	Sat,  7 Nov 2026 12:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 183B5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz6t1794055437t87bed325
X-QQ-Originating-IP: Kks6AmWAMtScy7aXEr+FCv9xJRLdC/8Pw7asd+OELOg=
Received: from smtpclient.apple ( [39.182.43.149])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 07 Nov 2026 20:43:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 343597150892611815
EX-QQ-RecipientCnt: 12
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH net v7] net: libwx: fix VF PM suspend/resume flow
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20261106132052.1c719cad@kernel.org>
Date: Sat, 7 Nov 2026 20:43:45 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 pabeni@redhat.com,
 hramamurthy@google.com,
 jacob.e.keller@intel.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A5B93AF-9325-4692-9D21-268FCD47C447@net-swift.com>
References: <20261029104220.77344-1-mengyuanlou@net-swift.com>
 <20261106132052.1c719cad@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MjlOSqg8Riw0RbSeM5RK78vMZC+daFgNTiy65FRnSRg3YBD+ypqH7KcQ
	ekAHsuRJYPG1c0UjHU2NOWvHxSVnWPFa6CtNVlGFr7y8Z4CPKk7n83jzlyWHWlaJihKr1zl
	Ry/qhTPebniLh4g683S/UQsWPEU6apNdradA4uGsZSf6+FdMGRcfl6IHO6FEXp2VYfTaNv3
	f6/Zhty2ZBHThLZPfWKpipgP0zTlETnMVS42T+C+vaHKODS4nhN+4J5DokIxVmr6rg1NW3a
	xdPvLJaH8Bp79gI5/nZ1T0TM3c8NtcqSvuNwu1jeX3sNQbKXejEJlE/NOtTwk6azUay3q5o
	fQeyhFJcE9wLEpGnHFffoh85EPvM5WjyDNOdg6eTnYs/+8lDqmiJvGdc1wogb9Nb2ocdizW
	dBMPCiQ0Fd7ib+zu7LDN/lI5u+zMewqDOwrKL2PZL9GE95nc0dYDBYaIenualbSuui7d0Hh
	LRHOhBg6T16Nw6r3GfJojEugT49f0qvsGzyycPP/tRuLilifVTWCkCO2cUSOsDPCnTgCdq6
	jPCzJ1uo97tHdoKF0UL1TRyvCna/f9xf1JBwAK/AAcCk0KtpKkFu1YgAVu0v0Ia8KcHH+wI
	bPs0ZqvLpbRY9Ho7A+x2KezBwqkrl4Id1llnHaOVF19nvW3VGz6SgPlOleSzDAtlVLZctmF
	AQL+/97an7H0YvHQeBe1CWjO7HWgkKewuL6amU3XGmNGY8I9Wnia5DsD+GFsbYxgoSmACkG
	K6UgXVt88fm20PXueLxB77KUoSHEUBgjpuzJXvrv5yxCs+HzaYll+77nDbqpfPX3Uhy6rdl
	58H3tGvv0iFz2z++LgZ4A+/eAzgZCuR34Z476bOd9pzW1eBGr2Dy6rSPAMNNh9gbUHehHC3
	cq9584+kZV4rJ01/UBk38de/F+PYEYGQP4EY8strsi3D1iIIewBGuIbWGAOZcyF2oKZ15qi
	rgOh79S8is8XTmEpqPqcatlOxK+YChuE3bUIUkZFrfDotF0IcrZ1yTA14GTXwGxjDTZEOLd
	QvzicUvTeyI0KntH7TwUruhP664sJJjUUbI3VMR6NsVAItIQP8H/bYpZll2SI=
X-QQ-XMRINFO: NyFYKkN4Ny6FSweVyh79VVAomnZ9F41EnQ==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B411=E6=9C=887=E6=97=A5 05:20=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, 29 Oct 2026 18:42:20 +0800 Mengyuan Lou wrote:
>> +open_failed:
>> +hard_failure:

Thanks for the feedback.
I'll fix the style issues.

>=20
> The labels should be named after what they do, not the source.
> Please read the coding style guide.
>=20
>> + /* Do not retry interrupt setup or reopen from the service task. =
Keep the
>> +  * netdev detached and down, and disable PCI.
>> +  * Retry by rebinding the driver or through a later PM resume; =
bring the
>> +  * interface up after recovery.
>> +  */
>> + timer_delete_sync(&wx->service_timer);
> --=20
> pw-bot: cr


