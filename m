Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9385464C;
	Sat, 22 Aug 2026 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787360888; cv=none; b=UDhTXhS5LiRrHfbvgjv/6UGqvxygqp+VoNG9S7aOGdCiGRRPmpvM4H4g2hsTWJ7wgWnqaR6VVKrYsdcXk02f/VWRyvyIBgm+fd9xaADseqVplRQbJlI+ZJF873vOm0OhYCstDhgoQGzHg3aS9LOmHjF2SpvrlVEyH5W8V6oXA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787360888; c=relaxed/simple;
	bh=FCsi3Y1KDyNSGcEAFG/s8S9olPYJT1CYp9IvVlK5bPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fnm40kVOmtYdUu7SLlegpj1FHmA236kpxT5V+fwB8Hd1vpH9vwDxGejdvQxAjCY4ijxaqrK1DM6PoTXUvISHk7n3D8NREHrmXS9bfT9epEsbadUfKJ0n7umz0jqbf4OllJgX0jWkY38mBAN9F4IO+7nIVci4VQ9jWHS3yreXLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=n/N0m02W; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="n/N0m02W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787360738;
	bh=/HS6PnY6GECRlkKYKvplYAOEPpIQsku/irOMbzAN7CE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=n/N0m02WEJFpPo6Wo0LTTOuu4HLJ8ttyum3csSAyULnThNjfASzSJIATWtkr67zb+
	 u0z4jtw3Q8w4Hyf/1up7C16uvk2fV2ZchRxV9TcpkhmilpCt7kC+hsqC/EbWHfp33M
	 jRhQq6BSZtWfWrmhuMcvSJ75Skd0Utmh49tKAOgc=
X-QQ-mid: zesmtpgz1t1787360732tf9e0090e
X-QQ-Originating-IP: PMct6n+kEVa+wlm+1om0uYJtww66orNUE59JRHxrFRI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 22 Aug 2026 09:05:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3598378241932703062
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
Subject: Re: [PATCH 6.18 000/217] 6.18.46-rc1 review
Date: Sat, 22 Aug 2026 09:05:27 +0800
Message-Id: <20260822010527.3523140-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260820145237.531699751@linuxfoundation.org>
References: <20260820145237.531699751@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M1rZNAdVNTve8vFlV7AOhiquNkStjW65W9akYt4CmSJFDMo/27joPGMM
	jn/9TS6QQZVaF2SX+qe6Q9mPnDKL9e7XrEEz4k3S5AaHAH1P6ukFFnsoT6AapWBJ4DQoyZB
	tQOP5qeo6ShVorUM0FVAop63rdFErRthAx21aXllAOuT9dNdyPMsmwGdH4LxqQuoDiSq6kn
	Iz7eWWr7TD1zsmdiITjS36AvdwFHJJklH2TkZMko9NMk4v+Ls+eDKXu+16hsCwVTTof3c45
	NEOhzub6O5Ov1PrdJ5aP0uJQz8AAxjMOSRhwj9WBcNfPjjj8DA7ybFJEvMs9smiiEZtoN6v
	qday7nule9IIFJX1FBqD25USNdVAhteyLaFF0ZHrMig9wgdqXi++1rarPmRkJcPYBghUrcK
	kRL5YLUHbG+nWfEgb6aH2q3wFwYfLzb4zm+owV3IGE3JLS+l7jwBQUd+rTD4lit6a3Ml8Pv
	gp8Mb4o61V+Ox0h5doA8kZ1MXNR7u1O/Cj1vMLyXscA2ZhpzBQ3XEqUDd0NgAKNz4xq0lME
	QuS8IZEAu/HISjrEm/z58dXI6OW6s6+TLgx2wGWe80PA3Ds+fhbs7kMH+YKaS9EgIKkvHVd
	zVgdLAB5u1RorDJF86FHzEmFCscKNpFmskSQ0I234xP9p1w0akVKHl4tf5+7aRIj+HXXhmH
	BH81NQnNWkLckYCOwK5XhRSVEUXxkNpFNfD1jDa49kyqrtAJ4TtEY0xQj+OqxMJdxSgmhXD
	DFfeAJ3+I0PK5abVaEFyaqDzFSZwayrrOPBP3m4dT01aS+lMAPtRDplKwPOhY2FUKYCq+BL
	BB+dyNLpA8ItwpAgKI19nUlBDuH9//tNXCSraLVsV7vWNPt736zeBdwfVZHDk+ofwHUJ1Yy
	cLi/w6B0DiN2L/JRQWHU9UCURvc+B/qjeRnYtQW7l4DDAclJ+tSKMk1E7WjWoey6sgTR2ET
	PT24/UivHix9Nh3l9Son03mbNZg6DfdTdToSft0XMzTbjo0FMQ9F/vAfUNr3eZVggOo5kbt
	AEKmcuoKjM3ra1jYAsQW5H5jvHDPmDu2Z0YTimBonIcWynRIulSfJMm01x20pDdM20u0r3X
	LTwi6yK9WfF6GDJJw2QCqYiXZhXoPnfLQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Hi,

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

Best Regards
Wentao Guan

Log:
Linux version 6.18.46-rc1-g5025dd57f7da (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC 
Linux version 6.18.46-rc1-g5025dd57f7da (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT_DYNAMIC Sat Aug 22 03:39:19 CST 2026
Linux version 6.18.46-rc1-g5025dd57f7da (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC 
Linux version 6.18.46-rc1-g5025dd57f7da (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Sat Aug 22 03:57:08 CST 2026
Linux version 6.18.46-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT 
Linux version 6.18.46-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP PREEMPT Sat Aug 22 04:14:38 CST 2026
Linux version 6.18.46-rc1-g5025dd57f7da (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC 
Linux version 6.18.46-rc1-g5025dd57f7da (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Sat Aug 22 03:18:44 CST 2026

