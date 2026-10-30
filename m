Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349012;
	b=2wWVQeZw+R1CvW27JxyX4lXfj4hpHdcEjWxn6mnbXvQ6iw23VHb5zKpMY0ex0ubmE1zN
	 +sz8Drzm5/u5YuBFvdwoPjPBrcm/PeAVeqonerDxkxqAAdSzKHX6M8xthX6t6ScF7l72w
	 U0aHvFcC8Imjj2rh2bbhLQHjLu26Luwiw6E/6wAQ+PBCzFY0nDLBq/+7LgmujUg75u7Rz
	 09NqqPO33mfu7oLqDseZGf5nKPGFee3qn2v1pirzCl642MLII6xGcU0/nSZ6NC73VdpEX
	 lDz1Dq62s23qw0GlOFA1mEDPQrAefSWCiKy9p59MqvQKlsNaoTLUjTlBv+O1C8Srt6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349012;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=S6icTSJoX+H0mkq2r9K7dhGu04auJXQZtSzWsa6ywM8=;
	b=ks10t9z3vZiaRKFx84HITOyrUabFfNDSBfje2j0tcOirfQrAc2o9BfbLsv7qUOjYqbVs
	 JAl3AFjbZeW7ILPIusjXQ1fKSGyosOgn5bXpAqOmsAlqJ6C7VXAvSfaUre7K4kyN0beC2
	 Pf9s2ace8n0up5JcXqModn2li2iqLFxp0fXnbXcvPJYHYBzYuJGWG6yOR37wssxBCdZLY
	 GkX1tecqIVXmND7gj2DD9R+tJkr0zQiXc/hnx5GwlabvloUR81IRqF6YcoGyiFgTQfWeV
	 3YJ/PfbkzUIkqINvWz0IckBSZCx4opn5HieeEAiNJyz0u7CuAlTgcoBWzi295r8sMdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b="ky/Io1pL";
	arc=none smtp.remote-ip=54.206.16.166
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB74606A31A;
	Fri, 30 Oct 2026 08:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEB74606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=ky/Io1pL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1793348927;
	bh=S6icTSJoX+H0mkq2r9K7dhGu04auJXQZtSzWsa6ywM8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ky/Io1pLlYQjG/bMGQm8P+xiYQB6o3xeqYa+xzQdV1Q/O0eFmbIEx8iOd23+3NMP8
	 Q8MTyM6xFFyFboeU7oybSlBGzO+aNYTXw3vt9GmI+MY8ypb+d21UjnQI294yV6CXgs
	 P+NFBVhQjCmTQh/e6qN7NuUbF+bUX8k4ORi0k3gU=
X-QQ-mid: esmtpsz19t1793348921t836fef7b
X-QQ-Originating-IP: 3z9nJH5sjaTFKjVPNzs2/PxgNbOo2hmbalbccp788xI=
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 30 Oct 2026 16:28:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14936512090500505238
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
Subject: Re: [PATCH 6.6 000/168] 6.6.161-rc1 review
Date: Fri, 30 Oct 2026 16:28:35 +0800
Message-Id: <20261030082835.297423-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261028165943.089486480@linuxfoundation.org>
References: <20261028165943.089486480@linuxfoundation.org>
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
X-QQ-XMAILINFO: OOYO4i1Nbl+HBmiIRd/geZimNjXs4x7eTz6yCFrazXApJ+KY4RnLqGoa
	pfqRYN66B/09/B5hQ3dZs56IgbRVkVMeG8vNmPA8r5MnOt0KjBdhEAGy6KEFcTArjdEydGm
	Sq/drt07yjR+N0aeWtY9fdbuPOXlzSMGvs4TQwoyo/AHlapYyd/MqsGTL8iwH1/CtPTwV/z
	poReiA81wzIitwwAOkT9+l1Tk3X/cA+gyPShMmGvzXRoITh4NwNnwEzHANOXBC+XoFuCDal
	bG67AcvRdn4T63hkLRhDJsudRwM3e7gOq4wGM4xVepheF/QCFhYGvuVdx788CGvjTWZXf5b
	i/4WGRoqz6Mn4XRTxKFAUXcnmTNxgEuYIVNPrU2CJfClbQh3TzIxGLyVW7l6DzFCJDeDjaC
	3FuXdC/fgyrMv1IA5+FET2CWgILQfKjxqb0/0ML32uj4lXMTxURilxTJL/h+NbM35TarfbZ
	z8MlMFp20li1dq7IIhjvWMyDQSMECfVsLRpn4AG5MY3B6XKbAKdjkmHQWBFn4lmbm+jZSxm
	hBaZcvTllkoYaTzdPt7mbgwTyUnovbT4Z+ev3K7ugWLhqrhZQtXIivKLW0XIDQKjTId5+QN
	GHhRFYNZCDwP/0wHcqyu0Qo0mPrbkxs8i8TK0kXOZ1oSEUVlzIjnM+/dMDKovq4uVMFbk+V
	ty6Nyp4NjrzBj3Zhpp37e51r049cYvDBPes/Wy5wEp7WkbLvySU7GjtOWbR8TZF7btqwv93
	pPO+BQ85Sa34IUF2Jts61TWQf5iN9JUbJkgJY5qZnpu5BXQpJptoVYAFFuEYQez1+/pYcJi
	xoHSK4FyT63nMav46ygFIdXbFSAERi1A+pMwj/UiTmdmQipdu4alhQE/LkJaAWFfnj6rDCW
	9bcmY0cEOJTn3mJm4/+MpWKk0RcTi/0kDYDdQUQCwAPZR35zbgrG0+SEMeIcJBPnvYToSZD
	S6VGPm07pQ7ULCNO/kjxx5h6wFDqDRjpmNwwOMh3cNdi1K+7NAg61tafwh5o685cHjaMaLF
	t7P3r85/XAILbhwW3/koPzN2373AC9B1SLEudvLQHS8oFtZZ3KBowzl3q/NnmxdJE5LE+pr
	SRJQvqaGkAaNADujyWGQJN8SpmryrNkXIfiXRtePm4TYw99K0ixOqHRvIinzgUYeg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

Best Regards
Wentao Guan

Log:
Linux version 6.6.161-rc1-arm64-desktop-hwe-gb6e2b2f6f7e1 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT Fri Oct 30 12:05:39 CST 2026
Linux version 6.6.161-rc1-loong64-desktop-hwe-gb6e2b2f6f7e1 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT Fri Oct 30 12:26:10 CST 2026
Linux version 6.6.161-rc1-riscv64-desktop-hwe+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP Fri Oct 30 12:45:00 CST 2026
Linux version 6.6.161-rc1-amd64-desktop-hwe-gb6e2b2f6f7e1 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin18) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Fri Oct 30 11:47:08 CST 2026

