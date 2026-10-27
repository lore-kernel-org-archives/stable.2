Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084180;
	b=f3sV0MTrSIaggnHDFu8JKL7iE+dUCOEXZtTWbUpTUOUThfvkEAGoy7UEWWP7nQvCfFeA
	 Xc256F6uSgHTDK9IkgZAm0HTHn+bvYDuftld2HCDeVMRGCNjNKTXCKk2fELccYw1dfBlW
	 avIX0Op8m0+HZ4gJhWrqUcAro32DXo0njvy2B35LXoLZivJTRjfi+vS5KU+Y+MJc4cqqE
	 KTE4CuU6f7K7isH7TwogI1BDpT3CVU9y4zfJKKqNNbsDI0GS6BUvFmpV4IQ80AgG4tDhG
	 ieTjhxQ6zqH9axZ/oaiHTz7g7dL193BCT2xvd7+0cF/FSmlnEA6goKIhhkpHzRA0EDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084180;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Reply-To:Message-ID:Subject:X-Mailer:MIME-Version:
	 x-aliyun-im-through:References:x-aliyun-mail-creator:In-Reply-To:
	 x-aliyun-mailtrack:Content-Type:Content-Transfer-Encoding;
	bh=GxCHiLYhIq7p2zI3/Y+9yVNjrpMmu1YiPNARHI/SAvg=;
	b=N6u0T1mwuQ8G9A8hQpc1PP34egElgSd+YXg7oRCmWnL8+a+IPH1LoxxM6slnL2mhJAWm
	 JUlbC5M0roBSBZWr5MK9YJiHYGAkUwbeuLM7lsHFNNbIJxtG7jq2fw4omocCKp4hKuPUU
	 w+XmKRhQ0pRyLMb2zcKcaMia6sPCOeClDYhog32RK+YURZnFgZsKw7IRWokTYblWNvo1P
	 3V+Wiqw12Y6nzfTmLKsJJDKg8D+y1O+HYBgsE8okg0H79Sbl0g8q2H+UBCQ50w8Cb7s5A
	 dlq6w++ls8kT4wVyjdNQE8gdHp64RqstnVbSw5PmzeUc9JTawOhmq0haroRdXj3K/UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=SY8dgKZm;
	arc=none smtp.remote-ip=115.124.28.98
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCCC606A31A;
	Tue, 27 Oct 2026 06:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CCCC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=SY8dgKZm
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1793084171; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=GxCHiLYhIq7p2zI3/Y+9yVNjrpMmu1YiPNARHI/SAvg=;
	b=SY8dgKZm6uLdqQHniXj6PJE20nkRLK1Y/TSRpRRYHN/I/aKm0Eshfi87/8HuGcUnaDi02+Z4sgovZbX4acaAKFmJXcrRzpiKayuvvQRf+MoM/cvEG9af7UXTb20UkGn3o8TaWUFP26TcwsPgukyXXUDqVSiiQ0JESlKHGA0fviz/Vmj8JqvEhbyNhLF4SgWo6TXj47qLw7+SEu/eLi8G65J4linC5CrYvtGPgm/XjCpoJSknwYxsqNC2aClwZDbn7BskhMphIP8WO7uVSSwe7MjkgnwAAzi4fvZWSiz/pP7XyVEfRg6KHiWWaF7NmicOzsOcyc9+sLi/3WMZgvglEg==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3520985|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.324253-0.00504887-0.670698;FP=662468230579382141|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033071099199;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DW;RN=10;RT=10;SR=0;TI=W4_0.2.3_2125170E_1793084166474_o7001c76i;
Received: from WS-web (chunyuzhiqiang@yinhe.ht[W4_0.2.3_2125170E_1793084166474_o7001c76i] cluster:ay29) at Tue, 27 Oct 2026 14:56:06 +0800
Date: Tue, 27 Oct 2026 14:56:06 +0800
From: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
To: "Vincent Mailhol" <mailhol@kernel.org>,
  "netdev-bot+sinfo" <netdev-bot+sinfo@kernel.org>
Cc: "netdev" <netdev@vger.kernel.org>,
  "linux-can" <linux-can@vger.kernel.org>,
  "mkl" <mkl@pengutronix.de>,
  "kernel" <kernel@pengutronix.de>,
  "haibo.chen" <haibo.chen@oss.nxp.com>,
  "shawnguo" <shawnguo@kernel.org>,
  "imx" <imx@lists.linux.dev>,
  "stable" <stable@vger.kernel.org>
Reply-To: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
Message-ID: <635d5817-f715-40c4-94e1-306204ca5521.chunyuzhiqiang@yinhe.ht>
Subject: =?UTF-8?B?UkXvvJpbUEFUQ0ggdjddIGNhbjogZGV2OiBjYW5fZmlsbF9pbmZvKCk6IGRvbid0IHdha2Ug?=
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
References: <20261021145115.153107-1-chunyuzhiqiang@yinhe.ht>,<b0d3e7bf-ddd3-4eaa-8ebc-fbe5e7d8443f@kernel.org>
x-aliyun-mail-creator: W4_0.2.3_null_QuNTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgNi4xOyBXT1c2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwOS4wLjU0MTQuMTIwIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4xLjAtUmVsZWFzZS42MDIxMTAxKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAyMTAwIChMaW51eDYuMTIuMTAwK2RlYjEzLWFtZDY0OC4xLjAtUmVsZWFzZS42MDIxMTAxKQ==uM
In-Reply-To: <b0d3e7bf-ddd3-4eaa-8ebc-fbe5e7d8443f@kernel.org>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgVmluY2VudCwKCj4gUHV0IHRoaXMgb24gYSBzaW5nbGUgbGluZToKPgo+ICBpZiAocHJpdi0+
ZG9fZ2V0X2JlcnJfY291bnRlciAmJiBuZXRpZl9ydW5uaW5nKGRldikpIC8qIElGTEFfQ0FOX0JF
UlJfQ09VTlRFUiAqLwo+Cj4gU2FtZSwgdGhpcyBmaXQgaW4gb25lIGxpbmU6Cj4KPiAgIH0gZWxz
ZSBpZiAoZGJ0X3BhcmFtcy0+ZG9fZ2V0X2F1dG9fdGRjdiAmJiBuZXRpZl9ydW5uaW5nKGRldikp
IHsKClRoYW5rcyBmb3IgdGhlIG5pdHBpY2tzLiBVbmZvcnR1bmF0ZWx5IHY4IHdlbnQgb3V0IGJl
Zm9yZSBJIHNhdyB0aGlzCm1haWw6CgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jYW4v
MjAyNjEwMjcuLi4KClRoZSB0d28gY29uZGl0aW9ucyBhcmUgc3RpbGwgc3BsaXQgYWNyb3NzIHR3
byBsaW5lcyBpbiB2OC4gV291bGQgeW91CnByZWZlciB0aGF0IEkgc2VuZCBhIHY5IHdpdGggdGhl
c2UgZm9sZGVkIGluLCBvciBpcyB0aGlzIHNvbWV0aGluZyB5b3UKY2FuIGFkanVzdCB3aGVuIGFw
cGx5aW5nPwoKSSdtIGhhcHB5IHRvIHJlc3BpbiBpZiB0aGVyZSBhcmUgb3RoZXIgY2hhbmdlcyBu
ZWVkZWQgYW55d2F5LgoKVGhhbmtzLApDaHVuWXVaaGlRaWFuZw==
