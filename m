Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330935;
	b=5J9uKgxc7hFX4LHt7ZLboeEuYtq83MTMN0K8hitO01RjAJRk7pCfbZZOYlO6vHIrtTMD
	 HHifzqHczZ5AagITYlsfR/Y3vkB7L4up7+YZoCDYiD4kPEbGBXgmmNFpT6uMkka6cSbUO
	 7SfSqlIpTtTqCALRhGjQlVV9sUD8AgK3nKAEKsz8NlZsiE4SLvDdYmric0GMH6je8JWvz
	 orJ5M5hAn3JTRQaEMqhQFGwpHL28svs9jIQl/eugz2Vmn3CJIZ8w6JDhwBGIZBYvIvcqp
	 ThjaBaXxR7uzgSIPDNY0L+Sn+j3w4odSCX+KFGC3fMRov62DkTj8sAjtxvGyrgXzF0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330935;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=IW2Cl4SHOxvWSFVojee5Sx3pcpaW0fjFwnHxfiNXgN0=;
	b=A4lzfpbkShtps6ZcECHPuGkTSn+s73YbnjBYTm/hBt6sIxmZMzUJT6peP6i7y6v7EfkT
	 g+Q+wWr6Ed9WQftxrB7NsF8UgZGF5Fzu7PjQpl7dv2wWkmwJ6Q+4pdlegvgoAnM0FSVG2
	 20Kws4xs/4VDBoIzN6UlXml5oEgMTud0eGb0qBMRBn8Ttmx3+EZ989/A6ZGE2mz9x/iAA
	 vgINv7Uy2HaG3TypadTuk6j/wB9dxBZLGdXCBQVSQvopqE5v6p0xTHnurcaYyBa9vRh10
	 xNA0mKrX9+1IjsbRWaT/suP7/Do2159z05eWh4oXWo6B2+su4i5oq6iVGjMYUmgK/Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=nsgQwBPn;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD6606A31A;
	Fri, 30 Oct 2026 03:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1DD6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=nsgQwBPn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1793330859;
	bh=IW2Cl4SHOxvWSFVojee5Sx3pcpaW0fjFwnHxfiNXgN0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=nsgQwBPnYMRb7QS8Jwn+VzweqoNuaAsO8bOjOSNdbXZHYkhQRwwwq8qkmJ9yYdte9
	 Y5nZl+mPx8tVTQbeqyvomQSdRhM6SVD/CYBbDwXEVGM++hUWFHxGE0QmBbys42gWLF
	 j2YAjx0UeJOlX7uCaj8gctzJusCnxZEYtJrJ2UUo=
X-QQ-mid: zesmtpgz8t1793330853tf8fe4688
X-QQ-Originating-IP: kim+uP8orrWf46bKIuliiyq4PAv1FVtYifD40rDqovA=
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 30 Oct 2026 11:27:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16277551824698748877
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
Subject: Re: [PATCH 6.18 000/109] 6.18.60-rc1 review
Date: Fri, 30 Oct 2026 11:27:24 +0800
Message-Id: <20261030032723.271234-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261028165942.357251485@linuxfoundation.org>
References: <20261028165942.357251485@linuxfoundation.org>
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
X-QQ-XMAILINFO: NupK0iGZGlzS+lTzz3Cid+RJWJrljbql7TccKaQk2IEiIFXUe0T2U6Ro
	GU4YpsguEsdMRn5ayAi5uymO8l2SlvYEF67rdZV4F38P1xaIriWwTgkJeV2M4VqOK4n6EVK
	L0HBLJwnSy/HaBp8cMvbLv3hJQW1NzRJ1ac4C7v3y5EQsxiRLs2HClzezGCsQv8fDFDJmOU
	R8XJ/mIk3cHIx9hEQTWwTCafy9Dilkeb8aOGKzHOjS7O1alvolzhfu8524rWHupwaFaTOcf
	Asbe4Fb8q9c+gM5bsdec0oWhPJRyGxEdxPHaPQ6rYCbfspHoe8LqduPnAj4gG9+ur54+Kt9
	OvZq64QFudh0Jk+ARVMVA99ctbfwgAgrhP0exi+8mRjTJ08hKtz3SyGLQETdH8u+2/9sWDi
	AHbhCNs+CdCxJS8lkl5qr7rdHzGmvnv56lF2Ks0Cwai1V1KmNmIe4C7Bhps54Yv+Hxk1ElW
	b/JnPKx8GZU5aSywoXDMyCmskjQfQgAsL3hx16DkZsuUvA0ymQ86xFnzkG5SI6CPdsAsVIE
	wh7iw93kxyvnXhtk/7n5hm2/Yw8TuZ3ufWk1ygRKwuEWhBWpGL9ODJ0u5Z/5OqSpOXKv2lm
	PIquN6FTYLdcBmtBEvjOLCn/4TnqI4K9qABLKkFi4zPzcMa/ej4g7Nae/b1yRFLBv6YNomH
	xe8XsMV/F84CKXaXoVZGKJ7tSWjFz1jUyoNkLyG8V8KASIeXEUhy4z3nQEzr170reXH7qhm
	Wk/MdeBizbnoZ0QrH5alQgI8HmIkmw/Mn9I0LkQhCd407vr8NazskzXsRP2uSyOX+xnXO5I
	cjRwMo7tf7GYvuH3c0pC+VDNtAp6ARcnH3wr7Cp6Rpv0x7ooZAU6A6bmFh2ZaXBUXLbbV5a
	uAROWA836/VC/qBMsEGr8NAsHr0rE46EVindW4nBpsuBXydY9mPCfIqXS2fGFAG2Wa/PRsb
	rZydlU+G8zjW8IiYIv5KcsNNwCqGuaSiODxq0jz7zKkXpC8+xP5F9Gtt95D3r62HksYal/8
	YQHDdySrhNXxlFZrlVr+miby+reNHfCaB//goMY6i4/Wz+70ed
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

Best Regards
Wentao Guan

Log:
Linux version 6.18.60-rc1-g61d622c89a02 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT_DYNAMIC Fri Oct 30 10:31:06 CST 2026
Linux version 6.18.60-rc1-g61d622c89a02 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Fri Oct 30 10:51:18 CST 2026
Linux version 6.18.60-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP PREEMPT Fri Oct 30 11:10:20 CST 2026
Linux version 6.18.60-rc1-g61d622c89a02 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin18) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Fri Oct 30 10:10:24 CST 2026
