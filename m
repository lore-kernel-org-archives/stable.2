Received: from mail-m15567.qiye.163.com (mail-m15567.qiye.163.com [101.71.155.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758C292B2E
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781950609; cv=none; b=qjoTMZVBxmtIK4hj1r1NjbfUk5huQtoBVpOEnZrTGHVmq3XflchxbR1LzhEIfnENywifdWqEoM19MSuCETU8/xuFXBr9jonuxg40zSsWBqEdlSLPAO3bmIRHUNbHUX7wLv6q0DBaqBMTeseLfIvvr3s9rI2b/AHvMdk45Zld7VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781950609; c=relaxed/simple;
	bh=jKdUFOxSFfw2CIXMaNErLvEKlvwiKYMIWgbfx+3spL4=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=WJndtoKWHw5srr6ilBkYWnSzKVr0qh0yRRua/+gMpOYKaKh1UBkNDUINMbOgft/hneivwmUNwmtpApNXEhTLGQ1O+U3KfuPe4srvVMSjVFTtjrgZb82pmRBwvEXNoeYKE+/w9pkIT/bzpzbuOuyrlIqYGL0NpPw3SanR/fKQQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hEcr3ZnC; arc=none smtp.client-ip=101.71.155.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hEcr3ZnC"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AGUAvgD7KqAX5vkMllTuJarw.3.1781949676685.Hmail.220255722@seu.edu.cn>
To: David Laight  <david.laight.linux@gmail.com>
Cc: Taras Chornyi <taras.chornyi@plvision.eu>, netdev <netdev@vger.kernel.org>, 
	andrew+netdev <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	Oleksandr Mazur <oleksandr.mazur@plvision.eu>, 
	Andrii Savka <andrii.savka@plvision.eu>, 
	Vadym Kochan <vadym.kochan@plvision.eu>, 
	Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Jianhao Xu <jianhao.xu@seu.edu.cn>, stable <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXRdIG5ldDogbWFydmVsbDogcHJlc3RlcmE6IHVzZSB1bmFsaWduZWQgYWNjZXNzb3JzIGZvciBEU0EgdGFn?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_WIN_1.64.1
In-Reply-To: <20260620104750.5270a11c@pumpkin>
References: <20260620093739.2164921-1-runyu.xiao@seu.edu.cn> <20260620104750.5270a11c@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 220255722@seu.edu.cn( [223.112.146.162] ) by ajax-webmail ( [127.0.0.1] ) ; Sat, 20 Jun 2026 18:01:16 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Sat, 20 Jun 2026 18:01:16 +0800 (GMT+08:00)
X-HM-Tid: 0a9ee4735fdd02f2kunm2404b49df170
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTUS6Y2fHkyPT6dc03QDwVaZPGiA09TnwhbhTj
	hLfuFZO94YXwX6xgvkjGVFFRKj5HlnR/0mP2qfaD/1op6Ml5grsg0dkSS+RAAMENcdXCRYIETeNg
	LD+KDgT/C0CF3MmlBs8v3Zl6+ZI2MBtOc/JNE=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGEtCVhlMGENOSBhIS0tMHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVU
	pLSEpOT0xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hEcr3ZnCWF18P65lRyf9OSWyUuCoSmyqXFiwp1pxx+EupSiG9sOXBgQioecYRkVJx6uG6NixUbEPDBEPGO2RMWmK56NpELwr732CUCl8HxHECEiKQzRLCWt2NW7v4PPWh7xhcK4Tsq1HOkcbZnjBQKJMi9Z+WxQvfXnuYMIhtao=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=jKdUFOxSFfw2CIXMaNErLvEKlvwiKYMIWgbfx+3spL4=;
	h=date:mime-version:subject:message-id:from;

T24gU2F0LCAyMCBKdW4gMjAyNiAxNzo0Nzo1MCArMDgwMCwgRGF2aWQgTGFpZ2h0IHdyb3RlOgom
Z3Q7IFN0b3Agc2VuZGluZyB0aGVzZSAnZml4ZXMnIHVubGVzcyB5b3UgY2FuIGRvIHByb3BlciBh
bmFseXNpcy4KJmd0OyBza2IgZGF0YSBpcyBndWFyYW50ZWVkIHRvIGJlIGFsaWduZWQgc28gdGhh
dCB0aGVzZSByZWFkcyAoYW5kIG9uZXMgb2YKJmd0OyB0aGUgSVAvVENQL1VEUCBoZWFkZXJzKSBh
cmUgYWxpZ25lZC4KCllvdSBhcmUgcmlnaHQuIEkgdHJlYXRlZCB0aGUgRFNBIHRhZyBidWZmZXIg
YXMgYSBnZW5lcmljIGJ5dGUgYnVmZmVyIGFuZApkaWQgbm90IGFjY291bnQgZm9yIHRoZSBza2Ig
ZGF0YSBhbGlnbm1lbnQgZ3VhcmFudGVlcyBpbiB0aGlzIHBhdGguCgpQbGVhc2UgZHJvcCB0aGlz
IHBhdGNoLiBJIHdpbGwgcmUtY2hlY2sgdGhlIHJlbWFpbmluZyByZXBvcnRzIGFnYWluc3QKdGhl
IHJlbGV2YW50IHN1YnN5c3RlbSBhbGlnbm1lbnQgY29udHJhY3RzIGJlZm9yZSBzZW5kaW5nIGFu
eXRoaW5nIGVsc2UuCgpwdy1ib3Q6IGNoYW5nZXMtcmVxdWVzdGVkCgpUaGFua3MsClJ1bnl1
