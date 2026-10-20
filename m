Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487659;
	b=R+6x/7JXAbS6jHfoOXHnvs2EQFb3KSkObuuULE61FK/kW4KSrFhmnaZdZatENhNHXbvq
	 m5yVmV0bxjsKGlviNY4n9D+Xq5zipe41mmImugVMXAf2LKT4DbyF1TqIkU4WEqn0Vp9RA
	 jDGfaC6PGu9FZdnaq3uAo3HFSHlxB0oNyxL0sbBonu6IwMEql/bKL385fs+yg4S6BPcrb
	 ObyI1MIR7kdVReUOv8UNVNAJfflDtYJNp8K8Y5Yz4YVoN5BcbMid7ok4GorBgKFtDDp7V
	 zDhHzJQugGZVS0ALgrOWkpWsH2fUEa+R3uuDxVfTdJBJYuYCenaDO6gCh/l/1vu68DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487659;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Reply-To:Message-ID:Subject:X-Mailer:MIME-Version:
	 x-aliyun-im-through:References:x-aliyun-mail-creator:In-Reply-To:
	 x-aliyun-mailtrack:Content-Type:Content-Transfer-Encoding;
	bh=fJssb/JemlsZHxSdI31pU9LtOV8CRFz+KtmHHMh8J48=;
	b=SQxmecRfka/E59r2L85onNsHzi1DlzFm0sX43R1sjz0XGM+buNo8ECziMeKc16ohUQ8d
	 +dP59yPNS7EKihMZLQReEWNc6slZO+l1wyP2Rhb9ijAQCs64z9fDV78RPDNN0cgfAp7gn
	 bbV+O25EKbAxYWIdURux96Sgg5icfIWEPoW4opVV5osIxJZhW6OkZCJRCNzb1L35I9wB1
	 vFrNaMCllndSJQpyXpeLWGChtUdGI7a8GZW9q9CRNdpjEULVItyrSf1Yudap+M/pHGxlb
	 20WtXbYOOijXMZXMOKlGdYTtpJM6JZoZtubTsH2qsQ2BAUt6+siQppv2CkK2LITWRCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=W5dI1uEQ;
	arc=none smtp.remote-ip=115.124.28.149
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D8606A31B;
	Tue, 20 Oct 2026 09:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D8D8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=W5dI1uEQ
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1792487647; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=fJssb/JemlsZHxSdI31pU9LtOV8CRFz+KtmHHMh8J48=;
	b=W5dI1uEQRRJzNXa5pj7JA2jznVHEXyF/txbFizA/f/VLY940yNdAr+sNj0wDxIi14V3bDhZU4Ta/fiMoB8nC40wuYJK0WrWM+mCIKUdeKMO47R2okHYHDm9sQiKBWbtRdGAH8WXUP+Htj197nUcdhc8U50iNpldFAzW7aQJObzzGe20zfTf9DeVB3zBtIUPg5H9UXzgr1CzVbMf0MWxUtOwUKgLHYL7yd56Al/b0l2iGOJnSmGnQstH+gzSHmAG7tCM6qTk2Nje3DrQEqhB9z5kcFPwSO2GNa5+C1KrK5bPO5/UGJRfUjnnpN4XyDypSCiMPfukbiHhfv47qgqjzQg==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3885555|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.261227-0.00109014-0.737683;FP=2599619405778432795|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083032240;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DW;RN=9;RT=9;SR=0;TI=W4_0.2.3_2125168E_1792487647042_o7001c537;
Received: from WS-web (chunyuzhiqiang@yinhe.ht[W4_0.2.3_2125168E_1792487647042_o7001c537] cluster:ay29) at Tue, 20 Oct 2026 17:14:07 +0800
Date: Tue, 20 Oct 2026 17:14:07 +0800
From: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "netdev-bot+sinfo" <netdev-bot+sinfo@kernel.org>,
  "netdev" <netdev@vger.kernel.org>,
  "linux-can" <linux-can@vger.kernel.org>,
  "kernel" <kernel@pengutronix.de>,
  "haibo.chen" <haibo.chen@oss.nxp.com>,
  "shawnguo" <shawnguo@kernel.org>,
  "imx" <imx@lists.linux.dev>,
  "stable" <stable@vger.kernel.org>
Reply-To: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
Message-ID: <ac8ad731-c77d-4088-aeb7-b7e472cdbf0d.chunyuzhiqiang@yinhe.ht>
Subject: =?UTF-8?B?UkXvvJpbUEFUQ0ggdjVdIGNhbjogZGV2OiBjYW5fZmlsbF9pbmZvKCk6IGRvbid0IHdha2Ug?=
  =?UTF-8?B?dXAgY29udHJvbGxlciBpZiBpbnRlcmZhY2UgaXMgZG93bg==?=
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
References: <20261018101744.93657-1-chunyuzhiqiang@yinhe.ht> <20261020075340.417899-1-chunyuzhiqiang@yinhe.ht>,<20261020-purring-cute-ocelot-54ef8b-mkl@pengutronix.de>
x-aliyun-mail-creator: W4_0.2.3_null_QuNTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgNi4xOyBXT1c2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwOS4wLjU0MTQuMTIwIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4xLjAtUmVsZWFzZS42MDIxMTAxKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAyMTAwIChMaW51eDYuMTIuMTAwK2RlYjEzLWFtZDY0OC4xLjAtUmVsZWFzZS42MDIxMTAxKQ==uM
In-Reply-To: <20261020-purring-cute-ocelot-54ef8b-mkl@pengutronix.de>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgTWFyYyw+IFRoYW5rcyBmb3IgdGhlIHBhdGNoLiBJbiB0aGUgZnV0dXJlLCBwbGVhc2UgZG9u
J3Qgc2VuZCB2TisxIGFzIGEgcmVwbHkKPiB0byB2Ti4KVW5kZXJzdG9vZCwgdGhhbmtzIGZvciB0
aGUgcmVtaW5kZXIuIEknbGwgcG9zdCBmdXR1cmUgdmVyc2lvbnMgYXMgYSBuZXcsCmluZGVwZW5k
ZW50IHRocmVhZC4KVGhhbmtzLApDaHVuWXVaaGlRaWFuZwo=
