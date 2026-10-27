Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071049;
	b=X8m5bRHBelGN41dRo5iDHN6J6E8xYMqbzp11QcjqhoqPvwttYjCd5etbGSCiKpRs4Ngz
	 +cMpC/Iwztowp2mo1UxyS5ZSLzBcVG765ik4AZBD8vauFBL70xsgCvyOK2clHSr6Ck1cL
	 kxZjiyMhSBAbxgJNqi2V6r8e5Wm8q7yrPSIN22tMkGaORFP4wrOowRVsbJ5uu39vsdZ++
	 lbKXavxGiPeNm5wLnfIi5ZcIgefnU5klq/w59tOjddQA0goeCIIxc0oD63i12lU0/voQj
	 14XVu5Nj9Qdz4gdPpl/IoOqWUaJNMXJFAdj3H2OQerwBkv40FaPRYnjv6uFKo0DMNwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071049;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Reply-To:Message-ID:Subject:X-Mailer:MIME-Version:
	 x-aliyun-im-through:References:x-aliyun-mail-creator:In-Reply-To:
	 x-aliyun-mailtrack:Content-Type:Content-Transfer-Encoding;
	bh=DT+LdrP+RywA87lduYJL55VRhqHYCJo5STEb97Zd6BM=;
	b=IU3VDDs1DZbTtAceGn3/+GgZUF9R5bGcdJJdekC+UBhC4kWklGTwzUFCM7pSNmcCg5eF
	 SlJd7DfNbA/sCgus7GM4ulYqNM77i56VOX1vsAutyu1zaHGpzSLk2gMTlNHMlUshB3inz
	 14Qvgndobh96bO4t7WhtwBOJ7/AUsUIFL5mZ3RDClHvxQ34990gPzhZiVeSQi4jikC2Ay
	 xulTOHGD5pnD+vGT2NAprFv0camklDgNtERjnDEP/zRxvDkHWmw4ryagxxPPYFMv67bV3
	 R7SxLr47LNWQtRkPA6iqHmQ7+nE3EsIGwjztIyF70PN5TQAFNHVvDFp9m3vhmt0On3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=BkkWjLT7;
	arc=none smtp.remote-ip=115.124.28.50
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAEF606A31A;
	Tue, 27 Oct 2026 03:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDAEF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=BkkWjLT7
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1793071039; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=DT+LdrP+RywA87lduYJL55VRhqHYCJo5STEb97Zd6BM=;
	b=BkkWjLT7jfFGlvQvO5yPo3eLUWtExAm+omadMkrs97QWNPYiR0/XKdEuuYOo/Gozt8LjqQ+b+scADiH8rAWduHLOl8Sf3vYja84THcsrNvJC0PHENxdIEfw3afMoPt/2KbtJmovbGGzWXyMsBWOAkz6vBe0aoPDlT+XA7v5/Kk9x2FqLTz25R+PKqmtcBUuNx9+Hq1unipjtLNCy9TKXfrfVEHCLn+QRTE2Sz4ain1OxQ8MZBhEio2RSaNZ7SZQQn2Xdx9Bi6B8A6gcrccpI9nc+sfPCJoUTMB4W5CUJzamlbGVkKz/94TuHKjU7k5YqTOmjEzMEw2SBXHqi6pmy7w==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1140783|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00518095-0.000169033-0.99465;FP=16154833637356434733|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DW;RN=11;RT=11;SR=0;TI=W4_0.2.3_21448169_1793071038289_o7001c17h;
Received: from WS-web (chunyuzhiqiang@yinhe.ht[W4_0.2.3_21448169_1793071038289_o7001c17h] cluster:ay29) at Tue, 27 Oct 2026 11:17:18 +0800
Date: Tue, 27 Oct 2026 11:17:18 +0800
From: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
To: "netdev-bot+sashiko" <netdev-bot+sashiko@kernel.org>
Cc: "netdev-bot+sinfo" <netdev-bot+sinfo@kernel.org>,
  "netdev" <netdev@vger.kernel.org>,
  "linux-can" <linux-can@vger.kernel.org>,
  "mkl" <mkl@pengutronix.de>,
  "kernel" <kernel@pengutronix.de>,
  "haibo.chen" <haibo.chen@oss.nxp.com>,
  "shawnguo" <shawnguo@kernel.org>,
  "imx" <imx@lists.linux.dev>,
  "stable" <stable@vger.kernel.org>,
  "kuba" <kuba@kernel.org>
Reply-To: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
Message-ID: <9538d32d-88c2-4919-84eb-66daf77b3ad2.chunyuzhiqiang@yinhe.ht>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHY3XSBjYW46IGRldjogY2FuX2ZpbGxfaW5mbygpOiBkb24ndCB3?=
  =?UTF-8?B?YWtlIHVwIGNvbnRyb2xsZXIgaWYgaW50ZXJmYWNlIGlzIGRvd24=?=
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
References: <20261021145115.153107-1-chunyuzhiqiang@yinhe.ht>,<179272890958.3130.8901186354506678802@kernel.org>
x-aliyun-mail-creator: W4_0.2.3_null_QuNTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgNi4xOyBXT1c2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwOS4wLjU0MTQuMTIwIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4xLjAtUmVsZWFzZS42MDIxMTAxKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAyMTAwIChMaW51eDYuMTIuMTAwK2RlYjEzLWFtZDY0OC4xLjAtUmVsZWFzZS42MDIxMTAxKQ==uM
In-Reply-To: <179272890958.3130.8901186354506678802@kernel.org>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGksCgo+IFtTZXZlcml0eTogTWVkaXVtXQo+IElzICJhIGdlbmVyaWMgbG9naWMgcHJvYmxlbSB0
aGF0IGV4aXN0cyBvbiBhbGwgcGxhdGZvcm1zIiBhbiBhY2N1cmF0ZQo+IGRlc2NyaXB0aW9uIG9m
IHdoYXQgaXMgZ29pbmcgb24gaGVyZT8KCk5vLCB0aGF0IHBocmFzZSBpcyBpbmFjY3VyYXRlIGFu
ZCBJJ2xsIGRyb3AgaXQgaW4gdjguIFRoZSBmbGV4Y2FuCmJlcnItY291bnRlciBwYXRoIGFscmVh
ZHkgdGFrZXMgYSBydW50aW1lIFBNIHJlZmVyZW5jZTsgdGhlIFNFQSBvbgppLk1YOFFYUCBpcyBj
YXVzZWQgYnkgdGhlIExQQ0cgY2xvY2sgd2luZG93IGFmdGVyCnBtX3J1bnRpbWVfcmVzdW1lX2Fu
ZF9nZXQoKSByZXR1cm5zLCBub3QgYnkgYSBtaXNzaW5nIHdha2V1cC4gVGhpcyBwYXRjaApyZW1v
dmVzIG9uZSB0cmlnZ2VyIChuZXRsaW5rIHF1ZXJ5IHdoaWxlIGRvd24pLCBpdCBpcyBub3QgYSBy
b290LWNhdXNlCmZpeCBmb3IgdGhlIExQQ0cgd2luZG93LgoKdjggd2lsbCBkZXNjcmliZSBpdCBh
cyBhIGRlZmVuc2l2ZSBmaXggdGhhdCBhdm9pZHMgY2FsbGluZyBkcml2ZXIKY2FsbGJhY2tzIHdo
aWxlIHRoZSBpbnRlcmZhY2UgaXMgZG93biwgYW5kIHBvaW50IHRvIHRoZSBMUENHIGNsb2NrCndp
bmRvdyBhcyB0aGUgcGxhdGZvcm0tc3BlY2lmaWMgcm9vdCBjYXVzZS4gVGhlIEZpeGVzOiB0YWcg
c3RheXMKYmVjYXVzZSB0aGlzIHN1cGVyc2VkZXMgdGhlIGRvd24taW50ZXJmYWNlIHJlYWRiYWNr
IGJlaGF2aW9yIGludHJvZHVjZWQKYnkgZWM1NmFjZmVmMmFmMSwgYnV0IHRoZSBjaGFuZ2Vsb2cg
d2lsbCBtYWtlIGNsZWFyIHRoYXQgdGhlIGkuTVg4UVhQClNFQSBpcyBub3QgZnVsbHkgcm9vdC1j
YXVzZWQgYnkgdGhpcyBwYXRjaC4KCj4gW1NldmVyaXR5OiBMb3ddCj4gVGhlIEZpeGVzOiBhbmQg
Q2M6IHN0YWJsZSB0YWdzIG1hcmsgdGhpcyBmb3IgYmFja3BvcnRpbmcgdG8gc3RhYmxlLgo+IEhv
d2V2ZXIsIHRoZSBwYXRjaCBpcyBiYXNlZCBvbiBuZXQtbmV4dCBhbmQgZGVwZW5kcyBvbiB0aGUg
Q0FOIFhMCj4gbmV0bGluayBzdXBwb3J0IGZyb20gZTYzMjgxNjE0NzQ3Lgo+IC4uLgo+IFdvdWxk
IGl0IGhlbHAgc3RhYmxlIHJldmlld2VycyBpZiB0aGUgVERDViBnYXRpbmcgd2VyZSBhIHNlcGFy
YXRlCj4gcGF0Y2g/CgpBZ3JlZWQuIHY4IHNwbGl0cyB0aGlzIGludG8gdHdvIHBhdGNoZXM6Cgox
LiBiZXJyLWNvdW50ZXIgZ2F0aW5nLCBoYXJkd2FyZS10ZXN0ZWQgb24gaS5NWDhRWFAsIENjOiBz
dGFibGUsCiAgIG5vIGRlcGVuZGVuY3kgb24gQ0FOIFhMOwoyLiBURENWIGdhdGluZywgbmV0LW5l
eHQgb25seSwgZGVwZW5kcyBvbiB0aGUgQ0FOIFhMIG5ldGxpbmsgc3VwcG9ydCwKICAgYmFzZWQg
b24gY29kZSBpbnNwZWN0aW9uLgoKVGhlIHN0YWJsZS10YWdnZWQgcGF0Y2ggd2lsbCBvbmx5IGNv
bnRhaW4gdGhlIGJlcnItY291bnRlciBjaGFuZ2UuCgo+IFtTZXZlcml0eTogTG93XQo+IFRoaXMg
aXNuJ3QgYSBidWcgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLCBidXQgc2hvdWxkIHRoaXMgYmUK
PiBubGFfdG90YWxfc2l6ZShzaXplb2YocHJpdi0+Yml0cmF0ZV9tYXgpKT8KClRoaXMgaXMgcHJl
LWV4aXN0aW5nIGFuZCBub3QgY2hhbmdlZCBieSB0aGlzIHNlcmllcy4gSSdsbCBsZWF2ZSBpdCBv
dXQKb2YgdGhpcyBzZXJpZXMgdG8ga2VlcCB0aGUgc2NvcGUgZm9jdXNlZC4KCnB3LWJvdDogY3I=
