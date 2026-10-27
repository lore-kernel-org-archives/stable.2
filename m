Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094641;
	b=LlGgcywehWdXwTH5ZVHrtRdk/GWp2amzk0BN6MfbIQ6OtkxzhQR2UKglkTJiYdKS90mL
	 QCUfeoDVDYTZOKJWYFev4xkfH5MJyPULM0XDTLXpsNHBlUs49XeW2GayVYH325aGnLv2n
	 XJh/9eMXvbgBPndAoDeOpL0fBI1RgUhVDCuwm4ypv2ck8N5gHGI2cKY13Pz0ur8OvvXa9
	 HwVzbpF3RseLdszgMd1v/VZbWT7y4LKrLmLr/oEvVe9DOzcLFSKUjXqoHqDfQV8/kF6B+
	 wrIY0SHJp3WIeNwiiFGnkzd46MWDEgamWwsQCuBOXONS1mVA+RKqVNYt0RaaQd2wSAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094641;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Reply-To:Message-ID:Subject:X-Mailer:MIME-Version:
	 x-aliyun-im-through:References:x-aliyun-mail-creator:In-Reply-To:
	 x-aliyun-mailtrack:Content-Type:Content-Transfer-Encoding;
	bh=ip1oIRlDB49atLslRiPykN8t9d8AzZSczSK8OspLXl0=;
	b=LnzEerfjWFLfRZqnw1OCgcdygOprzPpVSuuEhiAYjKsk6aFdXG812EIQxWuS8YNIxjnd
	 eIuohPR0aenFkmQExocVjPwzMFjS6SGZyFM76dXCKPgsfzwWWKZJG2eRgIkVWrZVMjKEP
	 ZE5aEhTlbg8GQnBD1QxPfKTLZr7MAGFvARz1tip/CG2j51SOlYeGjlo+4gpR5+nRHWOlQ
	 NA5qyHuzSilkjmeno3TgzrowzhuNy+yZpjnmESRHl8Xqq8tjxT/x/nNTQMV9IvWuG6BJU
	 mDtUtuVSAolq7UihYqYYUy1qLzcbcqgGZP3b9JUn/xVUIau2BL8NtVaDGP/gc01C+Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	arc=none smtp.remote-ip=115.124.28.172
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9E606A31A;
	Tue, 27 Oct 2026 09:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CC9E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1793094635; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=ip1oIRlDB49atLslRiPykN8t9d8AzZSczSK8OspLXl0=;
	b=PNyM+xBG1a7ta9IFTEyRkcOlGosNU15PM6jlE8qZQwRGLNUkaw1JVxedz8lmCBchz22ezNtqERqExsUDyFJ6ckkk5mfMqbykDWmd/DfNxVhvbxagqUy4aXnXbKQ7lj/gSVgwDx1ww7zQpJpg9fB5IIjmPPoMXCEUJx/Cy+uzuqben5CxL09+YEuRSrOMxRRWr7QMhxyxttHcKbEVyHzDC6i8aneGHehBxKs/eFRjc4kukX/CnqQydMu0fZ9xHgc0Gus9yMttfCiQor61rjEJMv2G+sVqDif2qYTsxJW4VyTckIeO9GQp0+UOkoDkOIFKv1BgjrOJYUzEn4jWQHAAiA==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1443819|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0868312-0.00029554-0.912873;FP=5617034440225324730|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033071099199;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DW;RN=10;RT=10;SR=0;TI=W4_0.2.3_2147711B_1793094628713_o7001c170s;
Received: from WS-web (chunyuzhiqiang@yinhe.ht[W4_0.2.3_2147711B_1793094628713_o7001c170s] cluster:ay29) at Tue, 27 Oct 2026 17:50:35 +0800
Date: Tue, 27 Oct 2026 17:50:35 +0800
From: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>,
  "Vincent Mailhol" <mailhol@kernel.org>
Cc: "netdev-bot+sinfo" <netdev-bot+sinfo@kernel.org>,
  "netdev" <netdev@vger.kernel.org>,
  "linux-can" <linux-can@vger.kernel.org>,
  "mailhol" <mailhol@kernel.org>,
  "kernel" <kernel@pengutronix.de>,
  "haibo.chen" <haibo.chen@oss.nxp.com>,
  "shawnguo" <shawnguo@kernel.org>,
  "imx" <imx@lists.linux.dev>,
  "stable" <stable@vger.kernel.org>
Reply-To: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
Message-ID: <767699b6-86c4-425d-803b-9009dece8d63.chunyuzhiqiang@yinhe.ht>
Subject: =?UTF-8?B?UkXvvJpbUEFUQ0ggdjggMi8yXSBjYW46IGRldjogY2FuX3RkY19maWxsX2luZm8oKTogZG9u?=
  =?UTF-8?B?J3QgcmVhZCBhdXRvbWF0aWMgVERDViBpZiBpbnRlcmZhY2UgaXMgZG93bg==?=
X-Mailer: [Alimail-Mailagent revision 74][W4_0.2.3][null][Chrome]
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20261027065012.191348-1-chunyuzhiqiang@yinhe.ht> <20261027065012.191348-2-chunyuzhiqiang@yinhe.ht>,<20261027-capable-active-leech-1aae56-mkl@pengutronix.de>
x-aliyun-mail-creator: W4_0.2.3_null_QuNTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgNi4xOyBXT1c2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwOS4wLjU0MTQuMTIwIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4xLjAtUmVsZWFzZS42MDIxMTAxKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAyMTAwIChMaW51eDYuMTIuMTAwK2RlYjEzLWFtZDY0OC4xLjAtUmVsZWFzZS42MDIxMTAxKQ==uM
In-Reply-To: <20261027-capable-active-leech-1aae56-mkl@pengutronix.de>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgTWFyYywgVmluY2VudCwKClRoYW5rcyBib3RoIGZvciB0aGUgcmV2aWV3IGFuZCBmb3IgYXBw
bHlpbmcgdGhlIHNlcmllcy4KClZpbmNlbnQ6IHRoYW5rcyBmb3IgdGhlIFJldmlld2VkLWJ5IGFu
ZCBmb3IgY2F0Y2hpbmcgdGhlIG1pc3NpbmcKRml4ZXM6IHRhZyBvbiB0aGUgVERDViBwYXRjaC4K
Ck1hcmM6IHRoYW5rcyBmb3IgZml4aW5nIHRoZSBpbmRlbnRhdGlvbiBhbmQgZm9sZGluZyBpbiB0
aGUgRml4ZXM6IHRhZwp3aGlsZSBhcHBseWluZy4KCkknbGwga2VlcCB0aGUgYjQvY2hlY2twYXRj
aCBsZXNzb25zIGluIG1pbmQgZm9yIGZ1dHVyZSBzdWJtaXNzaW9ucy4KClRoYW5rcywKQ2h1bll1
WmhpUWlhbmc=
