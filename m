Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ACA417BF9;
	Wed, 23 Sep 2026 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160517; cv=none; b=bWnYRgjfRQ4wfjzO0tOIkmnw3GK7YlxMEhTpAYO2qJq5xlLDoYNr8/s4cDW/BjYUUv5LMyA7t84gU4pYEstqA4z1iOukNGEbrQObglX87CSm7jLYTzx40Z3biAQ+4aBbnSVYYUWOlCOccXXqxJDIszJelLx2K3dMEYp6D9nQNV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160517; c=relaxed/simple;
	bh=62z1vukC43qxnfphOwPasfQ5eRU/uDnGvpS3jp6QWH4=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=cUZU8zb9oADuNG8MvwwmAwANTM+xzzRB50UxMurYbeREJrs5pOBn4nfpMu/WCsKXbp1dKMeio7OT/rCjat0wxNIThmjridNNisJdD2fycyNBG1aoLa9py7HQfm9/EA4qETwb7bcoZqax2yxHlOsHVmiuPG6FdskcWkA33GkqPWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=Bt/4Bmo5; arc=none smtp.client-ip=115.124.28.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="Bt/4Bmo5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790160489; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=62z1vukC43qxnfphOwPasfQ5eRU/uDnGvpS3jp6QWH4=;
	b=Bt/4Bmo5fAvoBn0ArRGWZUzTJgGWVwugcH3d6SJAI8mU18zbD2f8nHAaI4fYXBGVboiezomtO56wFOPPXrfJ3jRCQ0788dhZ9dn3xRxs3ilraaJwmN/Sqju5LcQmJZvc+WznMRmWDAUC35quqk/cPQqYyX0NrRAYLqHnrKZvlBc=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2604087|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.422661-0.000450884-0.576888;FP=6124244756700317903|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=fangxy@xiaopeng.com;NM=1;PH=DW;RN=6;RT=6;SR=0;TI=W4_0.2.3_v5ForWebDing_0B53043C_1790160338588_o7001c127m;
Received: from WS-web (fangxy@xiaopeng.com[W4_0.2.3_v5ForWebDing_0B53043C_1790160338588_o7001c127m] cluster:ay29) at Wed, 23 Sep 2026 18:48:04 +0800
Date: Wed, 23 Sep 2026 18:48:04 +0800
From: "Fang Xieyan" <fangxy@xiaopeng.com>
To: "Doug Anderson" <dianders@chromium.org>
Cc: "jason.wessel" <jason.wessel@windriver.com>,
  "danielt" <danielt@kernel.org>,
  "kgdb-bugreport" <kgdb-bugreport@lists.sourceforge.net>,
  "linux-kernel" <linux-kernel@vger.kernel.org>,
  "stable" <stable@vger.kernel.org>
Reply-To: "Fang Xieyan" <fangxy@xiaopeng.com>
Message-ID: <f19bdb30-c2db-4c03-a887-e31e1a13101e.fangxy@xiaopeng.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0ga2dkYjogRml4IGJ1ZmZlciBvdmVyZmxvdyBpbiB0aGUgJ00nIGFu?=
  =?UTF-8?B?ZCAnWCcgcGFja2V0IGhhbmRsZXJz?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Chrome]
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260922154907.90535-1-fangxy@xiaopeng.com>,<CAD=FV=UDqPUAWw+h-t4Jkno0Sy0_2T8xfXZgfjsVMM1fTG3JkA@mail.gmail.com>,<f9f9770d-f3de-4d49-b5b8-7d79dcb2d758.fangxy@xiaopeng.com>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_QvNTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzE1My4wLjAuMCBTYWZhcmkvNTM3LjM2La
In-Reply-To: <f9f9770d-f3de-4d49-b5b8-7d79dcb2d758.fangxy@xiaopeng.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgRG91ZywKCk9uZSBjb3JyZWN0aW9uIHRvIG15IHByZXZpb3VzIHJlcGx5OiBhZnRlciBjaGVj
a2luZyB0aGUgcGFja2V0CnBhcnNpbmcgbW9yZSBjbG9zZWx5LCBJIGRvbid0IHRoaW5rIGFuIGV4
cGxpY2l0IGBwdHIgPiBidWZfZW5kYApjaGVjayBpcyBuZWVkZWQuCgpJJ2xsIGtlZXAgdGhlIHYz
IGltcGxlbWVudGF0aW9uIHdpdGhvdXQgdGhpcyByZWR1bmRhbnQgY2hlY2suCgpUaGFua3M=
