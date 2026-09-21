Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C4471267;
	Mon, 21 Sep 2026 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986176; cv=none; b=D0FAYAuaX5Db9B9OZsN5MCD+VNhsYc4Oy0ncwuv8/wwYByi8XebYmUtzWA9Pv0JxYKqOfJvpGJNVvr00xOThrrxstGT8JQ8N5Ik6axUffUq/Voikqo9cc9NxQX6gE7wI7qw8DMASphxIXXF4yifhGPX3mz6CDr8ybgprStqQxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986176; c=relaxed/simple;
	bh=yWZZTzVutN+yZSAQpASDLwN7feUPqNIwpiYTj7YNBOU=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=ThK1Nlzc7YL61zL0D9Fq2q2e8nlYoFuXd200wdXPyJYo+kA2n+MfpbWGNbgpXKH9oE79V+0ql89P+4d+8fy0cs/+Wi0I9rqzSLTZLWYkbFBmWTTICwfoGBTIJ6GsO4s/mkyqb4JmAr2xdkN8i/QGXPlGFj0fWa6wgCQllZ7GG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=fslDtdHJ; arc=none smtp.client-ip=115.124.28.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="fslDtdHJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789986165; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=yWZZTzVutN+yZSAQpASDLwN7feUPqNIwpiYTj7YNBOU=;
	b=fslDtdHJI+Ek5Bo0gFLFCrBypNLSetTBOMJNxg+k/8AjZtBee26p+N8y3CsIIsX7XKg1mdauEWqtLf6XsK1RIZd/y8j38pxnU8IgMafeu1lclAbo1P+ye8eAGw1NWtJ9Ks4bR2KryDMY3R4B7OabZ+bThdpJPUb+yxQ9EAI4g9o=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1825962|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0070757-0.000512924-0.992411;FP=6871314568449233201|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=fangxy@xiaopeng.com;NM=1;PH=DW;RN=11;RT=11;SR=0;TI=W4_0.2.3_v5ForWebDing_21251D4C_1789986002711_o7001c100j;
Received: from WS-web (fangxy@xiaopeng.com[W4_0.2.3_v5ForWebDing_21251D4C_1789986002711_o7001c100j] cluster:ay29) at Mon, 21 Sep 2026 18:22:40 +0800
Date: Mon, 21 Sep 2026 18:22:40 +0800
From: "Fang Xieyan" <fangxy@xiaopeng.com>
To: "Bradley Morgan" <brads@mainlining.org>
Cc: "atomlin" <atomlin@atomlin.com>,
  "da.gomez" <da.gomez@kernel.org>,
  "linux-kernel" <linux-kernel@vger.kernel.org>,
  "linux-modules" <linux-modules@vger.kernel.org>,
  "masahiroy" <masahiroy@kernel.org>,
  "mcgrof" <mcgrof@kernel.org>,
  "mmaurer" <mmaurer@google.com>,
  "petr.pavlu" <petr.pavlu@suse.com>,
  "samitolvanen" <samitolvanen@google.com>,
  "stable" <stable@vger.kernel.org>
Reply-To: "Fang Xieyan" <fangxy@xiaopeng.com>
Message-ID: <b80e5e8b-6bf2-417c-a021-5e60b0b382ee.fangxy@xiaopeng.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHYzXSBtb2R1bGU6IFZhbGlkYXRlIHRoZSBfX3ZlcnNpb25fZXh0?=
  =?UTF-8?B?X25hbWVzIHNlY3Rpb24gdHlwZQ==?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Chrome]
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260919154139.52904-1-fangxy@xiaopeng.com>,<C04CC94F-26D0-4823-84F4-7AFEBCDCA9AE@mainlining.org>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_QvNTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzE1My4wLjAuMCBTYWZhcmkvNTM3LjM2La
In-Reply-To: <C04CC94F-26D0-4823-84F4-7AFEBCDCA9AE@mainlining.org>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgQnJhZGxleSwKClRoYW5rcyBmb3IgdGhlIHJlaXZldy4KSSB1c2VkIEFJLWFzc2lzdGVkIHRv
b2xpbmcgZm9yIGNvZGUgYW5hbHlzaXMgYW5kIGRyYWZ0aW5nIHRoZSBjb21tZW50LCBidXQgSSBy
ZXZpZXdlZCAKYW5kIGVkaXRlZCBpdCBteXNlbGYuIEknbGwgc2hvcnRlbiBpdCBpbiB2NC4KCkkg
YWxzbyBjaGVja2VkIHZlcnNfZXh0X2NyYzsgaXQgbG9va3MgbGlrZSBpdCBuZWVkcyB0aGUgc2Ft
ZSBoYW5kbGluZyBpbiB0aGUKc2FtZSBwbGFjZSwgc28gSSdsbCBhZGRyZXNzIGl0IHRvZ2V0aGVy
IGluIHY0IHJhdGhlciB0aGFuIGFzIGEgc2VwYXJhdGUKZm9sbG93LXVwLgoKCgoKCgoK
