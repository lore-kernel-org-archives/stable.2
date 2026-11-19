Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077798;
	b=tPkC6QeFw9Yxo8ysh0Z00kkSXAipieekmzXLEp8onAiU9+z545LAMb2ZBLc5vQadR20N
	 t9VZO2JSnFWzrmW1LR/6AJcPLi31iVSCD4Ef/RXVl4Dy30vk00YufAzshpEa1BGrWim5u
	 eRQqUPwfyta9G2NOvLLXaP7pFFmzyyRBJaj4VInUtvTv5hkhnZe1NQojtcVi/vLee0aRI
	 Vb0xPl6wK934XchaHzabMBzPtlxrGII6s0W/Dhk6lrNk2QLbr962Mnzw3o8wABPkffvsi
	 pywS/zsgc5kmu3sCcaLvLsri63Z2PvS5mN8Axn5ga8n4JyQRso1fyfY8HWwnEQ0+ZTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077798;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=lpvUcFdcfCKRwb5Cx+YbGLdBgQjkCAW3ss4qQgjYQB4=;
	b=MIRUIQfnknZM5PQn4fh1YzwaXdK8KVB4ILn5mHLi3rEmNpUN0N8xIP50wURos5QMHTHP
	 sYns/SbRfaLF/gnhVlsQ4eipK+qOvwud0SIpEtH7ompM8/Fytm8o/cKfsnrTbDUh3MyMX
	 BzRUReayk/Hawbtx3M8gEldqWAeRdggV8eUqyl9VH5ZFnINaixdxPdbdo7G+JQwv460ov
	 X1i55R6EWFSLdwReQX2xd4Rw4K6AdHqBbvqcYVXrwcc4hquDNCja4z2CNtnN7Xw8LFIWR
	 Bdvg+fzJhzKQ54nmbNgSzLEsIpPdjrRA6M7rM2eLYbDZEJ6S1PP2FCzHy/DsjMbXwkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=XafYExIt;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F9C606A320;
	Thu, 19 Nov 2026 08:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F9C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=XafYExIt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795077731;
	bh=lpvUcFdcfCKRwb5Cx+YbGLdBgQjkCAW3ss4qQgjYQB4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XafYExItyLcBwW0O5vejKgHPbUm5NBGKPk0amrKMWZeu6e3jt7oG4eJEMMZSyDtzR
	 XK4eXhOGsSzaxuXe1exmuJQF/9s9bNYkje19Apj1Y5SK4NU/8Yvcbbg31y0I3vjWUN
	 GKSg5YI2g60Olse0SkRlS2ACzYMDfvyZylCiGZ30=
X-QQ-mid: esmtpgz12t1795077725t62f63861
X-QQ-Originating-IP: bDs//Vc7rTiHiET7Hjj4zCytEBia8xXCEiZKxUC1xs8=
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Nov 2026 16:41:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11313103928963220471
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
Subject: Re: [PATCH 6.18 0000/2151] 6.18.65-rc1 review
Date: Thu, 19 Nov 2026 16:41:13 +0800
Message-ID: <310E160BE2CF5E67+20261119084112.3616604-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118150121.603863898@linuxfoundation.org>
References: <20261118150121.603863898@linuxfoundation.org>
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
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M/ESU50hZOEX1dufSpouXcCbrwQ3ditX3iPeFtGsSinWzIl7JI9uGwmt
	ef2FOdbzvLRmU/bipLEq2VYlfz2dkDAq3s3dcsm1nTPxtd/zCTbszsDp9lBsePY4vWPLtpn
	RczUytMmQzmS3QZRdTQsoZI2tieAHfrQAPw78bgAKVHq1Z2S4qV5Xn2eXUC0F6VV4DHZ4VP
	Mp8OuEOpM3dSluGyAyQ1Ewm9l7vU4XJBW1x4T7jrKknI1q1XcEU8xhqr2Uoai+pQBB6uy/b
	h9EFTSrcFNDXaA4MNaVg3EAl0tu8p6fpCxy2mR/df3q60T+fwQGJNiP1tBs6dACh+rqOoAm
	fLdhHeqRIpeEaSNYEYml+4xi0gOgaWpQshwymjXa7grkZFe/592HSjva6muGpCfDXWyhW3M
	v4Aj9EBStNo7J1LXfvzKB+g6AsK+p0epm8illUWheqx3C+CqaioLM1bprIXrjIVfimBR58u
	J0NNYQ0ro6EmpvWaqBPs/S+dAhbJwvw1zHkfA6zwoutnKWCZVDtxzdXQ1pVIiTZOkOSagDy
	5PbtCkgGCyB22fo0HZzgey8ZeFoWgidqmtVs/3hLhLXi/yUpAabq/rXKgRMwoSDVEjfGjxh
	Q+SsPd6lD6cZ+vwDsSmj/Q81nIu8tXHmSVRBDWpmZINSQGK+f94nmfOPRCZuzcedhorzPVr
	LztQhO3vfOvt7IzY3sLkT0NaXt4aYS/RY7izLsNAPUFSjbj42SHn2torkdZkIq6Jhbx7q2Q
	nJk0wDS0mrK2AfBs8xgqFVrP+WwYyIZO6dNq7fwEUClxoMxVwg85DmZZu7tZ4hqbUwagyuP
	lqAidc8Tl1uMGL2mYUyXfep8+vCgHlfjExpPU2C4NeLv+sBhlyPK8/JXXQNpWP+MTG7jc6q
	tWbo+RhJOLa9V4FvcZiDFbL2XlBV6xDPGFfX9Sy1mhvavwuIg8nzPdgqe9hWrs3BNnUI4UO
	XRa/3Ft1KLpBoiZyMvlbSaRxQTruJG1FflqFtEgEHv3DQ+2I9bZbOS+hACWrrojGDfcozr/
	QtM/jvYIlVaLlYU4LSOImiR+RzDmwhu+dfR+1Y5cTSgEYJXWGAS6V0HmMK0Uf1FLuORKUN4
	UQtYB9AMNUZ
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

Best Regards
Wentao Guan

Log:
Linux version 6.18.65-rc1-gb8cc618d685d (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT_DYNAMIC Thu Nov 19 15:59:55 CST 2026
Linux version 6.18.65-rc1-gb8cc618d685d (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Thu Nov 19 16:17:18 CST 2026
Linux version 6.18.65-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP PREEMPT Thu Nov 19 16:34:22 CST 2026
Linux version 6.18.65-rc1-gb8cc618d685d (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin18) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Thu Nov 19 15:39:59 CST 2026

