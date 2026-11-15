Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794741626;
	b=KJVaarHpUCpvDwfz6Pm1sljRXN5Wyp6iS7/UY9E8aoZz6i3MGD3gGDzHXyQxqcPZpL3u
	 5VvzGf7PwvnYRZ5izeEHwKWwySd+mDU8cxsrhIdNLtDtzxgeHKscfyiZlJeFCgssRSoiU
	 Dd52R8yywpAzg1fvU1L9U0RY7K6GFy/MXSvFt9oddjSU2hmQj8VaahFa9GkS+g699IaPJ
	 BA63axaoSy4ZkfpTHg0/8Q5Gud1uca9o3aKfwF37tk6ljrFvmGHnFEmdTT4WGj90Ehqu/
	 GNlSslRjBtdsU6Gk/PS9ZJBWrTvpGLrR9qfs8PafHuG2Kd/QIvsl6KnAMSj2agKZkyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794741626;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=80R9EfORix9MyhYi1pf17AWudSobYjYqJIUm704fLuU=;
	b=qdde3RUNhDHNGV70F+XQr5kOXyQDMTFBWMj62Z6Sya7ohdBsE31Np5lu0K2/veeIHsFj
	 UTzw2HwWRHW4xh1BTtdZF+kY6WSV/fq2EzE//IzC0jwq0CCuZjl1ZYCE9KEFDMqR+MlX1
	 KlzVJig/UYtvtBKvUqVnDzoBJ+exBQmlizcDN6sn4hvqjI+8CRpwGH3UokRR6wcUm+/Vn
	 m0AwbRWCuYvl7v4Ymhf6M/pp+UgihsaaOAvi6AHwivS0Q5fqnxDe64kDu5Kmkpa+EKAw6
	 WG2+X16LP4JxoZd6zUabOEZwEZJ+si/blTeRC1M2M2yZNZidKNElRU/wNq7sN4jBznQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=PyLne98z;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9D606A31A;
	Sun, 15 Nov 2026 11:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDD9D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=PyLne98z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794741541;
	bh=80R9EfORix9MyhYi1pf17AWudSobYjYqJIUm704fLuU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PyLne98z3LWnDqUrLSDm1nbLww33pgoz5tGaYqU8YhShPglZXO6v2V6aUfc3AvMOy
	 A0dGsaYnmGCBr8tvPH78TEhZKSQsxpkJtnzTSUW/0VGC5yu4XX1d4NpU2g3chxYxmu
	 o1UVtypmmt/30tHJZUGsV73njHFOQNtdOtSNw2ZI=
X-QQ-mid: esmtpsz21t1794741536t4686ba69
X-QQ-Originating-IP: XhL8AzStSBSMW5oQl38KzZPC+6Ga/5P8TR9YT+DtGvc=
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 15 Nov 2026 19:18:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12140221221863691289
EX-QQ-RecipientCnt: 21
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH 6.18 000/686] 6.18.64-rc1 review
Date: Sun, 15 Nov 2026 19:18:16 +0800
Message-ID: <B8B7B99F37A65A88+20261115111816.3553925-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113153820.902362109@linuxfoundation.org>
References: <20261113153820.902362109@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N2bAIxLK0eln7YnjYRThX4m4cb3k+iWRaM9W7UUt7garlrJ76kW+bpGp
	o78Hk84mAY2JrKqjDm0k6J4tueXdJGDxvNZJkdRx/k0jI5DxJqubqSAgqzT+rhvKamt3YJp
	anGLezBmsIk9a94Msfx41GJfcbq4S7B0/ejrLo15qXcBugpcxkd95NDALzfbuC/MvyGGr54
	Dj3ybgj9ZREPiHaP/6QAo9gLy7aMQZNpDdpjTWVwVlnrsV6VApstyfC7PBF414jY1bbAcKl
	9IX5jUSOV2L0kO79hYQaN7eIksFHe0aeLgjpl20MkHAnNWY/QSzThiXmE09qU4uy8FnTQpL
	/HYS9BT9hzgggPH8yzVGEPrAxnkQllVIfQexA3++8ZmC2A9ycdJGqBxaxx9FCB+1FKBbJ5X
	uXD4DKCvsfcwmhT56T63Hui4k8bch0K7EoSr8x8y20Og4uIVq5kW98So72kSxe7U7Mx068E
	510nrGn+QruPoxHPdw3Qux+oVAuzkjDdHcMHO4aEg7+9pPZb0cYFcgKAdZHIm1CnAvq4bp1
	ZWPWEm7GYRsCJaGe8JCikXkMr5G3XjoY1NpccLHdbjm1QNLRmnd3UIVmN4GmCAHqIpGLECH
	gyfWygPMZDcxGhqS06wxntzvDYW/U/tzVEaAj56+LoNwICcrKKJtkdYARvDDgZ+4PdyLw+5
	PQ+fGpTVpNLJlbPqZ87f3ce2NDOn/QC0fkOKWKTTH72qB6UJkAMSRb4+zCszu2LzYDfwn6q
	9I3TP+vpjvM9J0i0+0a4xHWaYv5OQPjqCukHQvnnBgWxXy1LsxwlFoiTQBRtFSntAtptrHx
	JK3olP1J05zx88nUc5nreQaKMkPlv1gVU4RHPeSR42PxXfou14SlH/RCDGu4STxkmkYZ8vg
	YY3YLTInX+0fvoqZFG8DWldHl+BLPh2J6v7XTjfX0nVnWqUWaBISublRUsb9dusmJMDIbkm
	rJDKx54xft5jUDTF98H01nlaHW+elStH8eMGOfK3kqnck9gQjXJJewqClfF4Qw5yEbbgb3U
	U+URG7iRpwqHHMIVKGWrNEyj1muZCWjWrbDZva5HTNVcndl/0NRLA4jKI1ECI=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

Best Regards
Wentao Guan

Log:
Linux version 6.18.64-rc1-g910b5c0af479 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT_DYNAMIC Sun Nov 15 18:18:39 CST 2026
Linux version 6.18.64-rc1-g910b5c0af479 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Sun Nov 15 18:36:37 CST 2026
Linux version 6.18.64-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP PREEMPT Sun Nov 15 18:56:07 CST 2026
Linux version 6.18.64-rc1-g910b5c0af479 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin18) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Sun Nov 15 17:54:57 CST 2026

