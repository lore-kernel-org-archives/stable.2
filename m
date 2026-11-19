Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082825;
	b=Lle1MBk6hJeVcG59lhKK38fY5j3i0QfCn4HgJwwUGkUf3qa9y+OVxPP7WHLLZ8BNRLWc
	 cw7jAlj0pZTjUzX+TTWTJZo9SKm2tdft1A0Ko4mIwH9wd76oFxnTN8RrcfqX3V/qtCzU/
	 YejYtQ+fCSVJJrCvQFE3/YQS7Lflxvd/xrME236q5dk2UmQ/V19Rlr3o2hjidzifq1HFM
	 S2+QEwWhuluiSiDjoOCiBqROdkfgapjhsFINwM7JbiNzg4WaKaNu149m02FqwJipBSPB4
	 Xa2bKiJGdAWqW6ugR5mBgDuCYeAQ2kbnyWhYZihJnbXB88nPDbyV3gzSfAQhdrucVbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082825;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=1pu3s1RNhCfYBQVBqWt1xNmbqy5Z06xt9peEDYwPftA=;
	b=kEsyZ46b1XOmNqYXE/Dw8akkCpa4auKeS1q2GcRghwsH9tLEJDUcd6rBtoggGHuZjhtS
	 RJs+rJFnqh8TCU2wyUa3Q2ytqrzUN24dJ8DDIILS6HJOl24hP9SRTjiDDj/ygtNsUwRwO
	 PrZYm70qcjXMyogFH5qOgZuKsgsM40llDIFclko3UFzKHauH8l1BD6X9tLZkIzBr2bOOs
	 21SshCGcQMbO+e7vdv40JlnkA/6IDh9tCgoA31lEM0D+g1Ry1Tot8gN5bnfppwA+OoZW2
	 4sqQVBQ3y1M2Bczz+b0XsAhEFDW2zm/UD8aZw+i858yZqew0tMq15B4wnXAxMwzgdQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=jkDI3NPL;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CB560A2600;
	Thu, 19 Nov 2026 10:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88CB560A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=jkDI3NPL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795082734;
	bh=1pu3s1RNhCfYBQVBqWt1xNmbqy5Z06xt9peEDYwPftA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jkDI3NPLdMkFK2BCcK3fQfR1YStoYxgU9UZ82qRcYh7OL9l5zpYj4j7e5J/oNjxgf
	 4xSC9NtFg8A/vy1wCRTL/5NU7tJMJqdituA2sofQGpGjtEExLe+Qf5Zu8VvLm9grZV
	 QIwKnuU5+jGH9QDWodrO0BS/D6eY/RQMTDMLd2YI=
X-QQ-mid: zesmtpgz1t1795082728t675d45dd
X-QQ-Originating-IP: R2mHRb551O+Bb2eEepRyzrHSHdKjf6nxen43zPbnCnE=
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Nov 2026 18:04:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2637527613255995905
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
Subject: Re: [PATCH 6.6 0000/3318] 6.6.163-rc1 review
Date: Thu, 19 Nov 2026 18:04:51 +0800
Message-ID: <C37A4482F2CF010D+20261119100450.3648618-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118150313.527275416@linuxfoundation.org>
References: <20261118150313.527275416@linuxfoundation.org>
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
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N7JPoHYNfxrhtafgv6X4Orr1aMbDgg/dzTxA/Jxdrar4oH8j/9NiBHla
	eBysXL/hIgpa58JSoVKM1CXtctomEhNKbbZW3QgrG/AZJkD1WapV1ZfH0QMYAx5NY+ddkUP
	tdZzR9SkObk2pm1Xf5iOgvnl5lOEo1ks7n3Q1+Z56ffkzrUlVkr72gAFbICmggIUwr49Sgw
	0EbSE+63N3zaANoJzKEuSee2eEX+JZyZmsGTaLejj7VcpMks6Ku9KfseMsRCMrLDZdwQLsU
	36azqv2XWLKhlJgNQXQLyLNlQgMDh56HhR6TRxte4Px7LlUh91GMVsRlHWwTGV7Bs+wea8i
	/EVWxh/xT/OVbbiMaM0FBp3CMmbAk17aXEjQZ20UDKK5KIzzv9xNHGTWCwh34owWD2cttD1
	JE4qQRj0y7Gde9wu9L+QEjuhAeqkiIMmtRKmfFttD+HTVAvmi5A/qLqLMGBuXXxKVX0YUdX
	tdMFggXB+QseGrJJv8E6ws+5RIiLlirh7osfiehZDUYufynlcOmL7RmYcXWpbG0FF1RLMyj
	czdcejKisD7PTFnxF/POOfK9+K7nxCqN+5i17pRi1NfZDYxmTNacTenhv0VmwGLDOjw5HcB
	UWTRpSwM1bel91UWaWD57mUcZVH4N6/mK0lMa49YDQ9tr0ou745y7htI8esX/j2WXvN+Smf
	8XP8pb7TdRI+3A1XT8aKoG0DWGO2UzEQesKBkpzpFZqLoVjH0Dd4U5mamovL7nH4BaakQAl
	M3TsqTM5sigFQYgq3v0gHVI4qV6LrTd1wprhaVEG2zrMtxtimh0hhynV8ubO9uw0Wcm/SoO
	shBl0ZKvDNM+AOeUAJaZXvBIAlfuz+HHOE2tg8mo38zv5kaayxJA7DOfcnPYwB2nIX5ytrF
	yBtIj5LltRWsT+c0G2IC22oDb28b7CSlHyeKeKsNaWKXbonSCHZ/EQY2eB2cpNFfywMrKmZ
	e+L9hOn15St/cbnujO0DN6q1Adu5JhjvaiCXaOZ8mNJQWFUI6hLq3Rl8k26dnO3ROvaY79b
	iscY0bKjGUvhU4fSQ3CeO52law8xqFc8M6Sb3ZHMg6U5MTEPQT2QQNXlgy0TcWEDYxaQXri
	TkUj7T78lMQLzWL5JBIdOMbx8j7qOoF/8SWTdNMk/TM6pYPzSrSwjzC0v5mq5tEPkBMicF+
	Rpm6
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

Best Regards
Wentao Guan

Log:
Linux version 6.6.163-rc1-arm64-desktop-hwe-gc4e45e560351 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT Thu Nov 19 17:25:15 CST 2026
Linux version 6.6.163-rc1-loong64-desktop-hwe-gc4e45e560351 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT Thu Nov 19 17:41:44 CST 2026
Linux version 6.6.163-rc1-riscv64-desktop-hwe+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP Thu Nov 19 17:58:25 CST 2026
Linux version 6.6.163-rc1-amd64-desktop-hwe-gc4e45e560351 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin18) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Thu Nov 19 17:07:17 CST 2026

