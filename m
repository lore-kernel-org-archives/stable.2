Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D27395AD5;
	Tue, 15 Sep 2026 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461314; cv=none; b=VH2ngpgT1lRTWV1Z0TNvynNAxAfPcyMZeBVMZpvUu2NuLEKhiKAofOQfYE2+1fdCu45+pBk6ZWF29nLcecaN9OP5HZj6GGI7IYLrR88Eum5+q5Zirvy+Du4ZDqBZJJW3mRHyzj+HI7mM4eeZd6FIYAcmIhp54jn7KixAo3U6Qkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461314; c=relaxed/simple;
	bh=zzH2S5BlnGSOM+izbNuo1WGDo4uV7wWtFJPDQdoB9h8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=ED+uLLC9lZWPdbGzcvIibNzeSIRX5ZhiwsRVNaxqf+ncQzGpk8lodAr3mIhkagA2X2yhn9QOv+yX16KaiXKbwpgkHD4L6TGYIt/9GnYA6L6QEm9Ebyq9qPi9QxuoCKP66X3j2RFtMdaP+m/YvGXj1JYlKo0/G71M5BcZ53gX6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=h4iVunvt; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="h4iVunvt"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789461303; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=zzH2S5BlnGSOM+izbNuo1WGDo4uV7wWtFJPDQdoB9h8=;
	b=h4iVunvtQIdrpUzpD3YWl9larbJmS8YjtstEm9oUsZpb+77jRH+oAQTEXuhZAS6J+24pjI0SYz0KbTD/fOrLMCmB2e+rlv5NdF59X9aTSK812NK3hdvCHNhnt/CNQV9dgAKOzZCNRoGCU+DGGVTVPWuYjiQLva4bF2iRcsamuEo=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2357507|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0723163-0.00488047-0.922803;FP=9654510142605670331|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=fangxy@xiaopeng.com;NM=1;PH=DW;RN=6;RT=6;SR=0;TI=W4_0.2.3_v5ForWebDing_21251644_1789461189392_o7001c776;
Received: from WS-web (fangxy@xiaopeng.com[W4_0.2.3_v5ForWebDing_21251644_1789461189392_o7001c776] cluster:ay29) at Tue, 15 Sep 2026 16:34:58 +0800
Date: Tue, 15 Sep 2026 16:34:58 +0800
From: "=?UTF-8?B?WGlleWFu77yITWF0aW7vvIkgRmFuZyBGYW5nIFhpZXlhbg==?=" <fangxy@xiaopeng.com>
To: "Doug Anderson" <dianders@chromium.org>
Cc: "jason.wessel" <jason.wessel@windriver.com>,
  "danielt" <danielt@kernel.org>,
  "kgdb-bugreport" <kgdb-bugreport@lists.sourceforge.net>,
  "linux-kernel" <linux-kernel@vger.kernel.org>,
  "stable" <stable@vger.kernel.org>
Reply-To: "=?UTF-8?B?WGlleWFu77yITWF0aW7vvIkgRmFuZyBGYW5nIFhpZXlhbg==?=" <fangxy@xiaopeng.com>
Message-ID: <403793dd-d7cf-45f8-99c7-dc6b3aadfac1.fangxy@xiaopeng.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0ga2dkYjogRml4IGJ1ZmZlciBvdmVyZmxvdyBpbiB0aGUgJ20nIHBhY2tl?=
  =?UTF-8?B?dCBoYW5kbGVy?=
X-Mailer: [Alimail-Mailagent revision 3][W4_0.2.3][v5ForWebDing][Chrome]
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260914180344.15485-1-fangxy@xiaopeng.com>,<CAD=FV=V1-gNZ8yTsC+D8inePWv=A+9H09hWJojQf5NRpcNvK+Q@mail.gmail.com>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_QvNTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzE1Mi4wLjAuMCBTYWZhcmkvNTM3LjM2La
In-Reply-To: <CAD=FV=V1-gNZ8yTsC+D8inePWv=A+9H09hWJojQf5NRpcNvK+Q@mail.gmail.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgRG91ZywKClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgdGhlIFJldmlld2VkLWJ5LiBJJ2xs
IHNlbmQgdGhlIHBhdGNoZXMKc2VwYXJhdGVseS4gSSdsbCB0YWtlIGEgbG9vayBhdCBxUmNtZCBh
cyB3ZWxsLgoKVGhhbmtzLApGYW5nIFhpZXlhbgoKCg==
