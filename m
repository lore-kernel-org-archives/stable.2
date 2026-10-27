Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084127;
	b=FH0pkxlgh5Nc+vzuoEGlvZ+XHdCItr+meIgAJRV8huPljFIQ53jkN2EcoAW7coU4Shp1
	 86hAM6H6zUNk0q6RwLQHmiGjk+CG6RR1dV0HX+J6CABhbPaUbXv5jDIBlgiVJln+ayG7+
	 912xpOLyNfVKYLBrUDFlPy6txCs9VDAaitLwG7BaSt1CvSKDkx0VOBLGcYtvyXvOW+EPk
	 9NNStr7FCBZ5HYI2VR3ZUCrvtvm0b906f4v7UlUmHeQzkSOpbcEolPOd8f+TpV4vZVIbW
	 xxlC4kp2Fsx17dH9Rpfmryu6iOtX/Zoph+j2i2rbeJwkhb+BWX7Fb4t2FTVjqruDhNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084127;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Reply-To:Message-ID:Subject:X-Mailer:MIME-Version:
	 x-aliyun-im-through:References:x-aliyun-mail-creator:In-Reply-To:
	 x-aliyun-mailtrack:Content-Type:Content-Transfer-Encoding;
	bh=TUYyE2x5X4GA3HF7Xndot+b/wLGj5J9nNHL/77ySVmw=;
	b=MIh7Dut0xbn54szI/8LOFhkLsd55mczdCcQ8byHfmCRNta0UmQ7/dOsk7qyt4GA9XtjR
	 icNNCAkKSHWqWAlBYmCQB9ro2hIlWwJdNds1tRzw3nTqRHOwk/cKWlSNhwJEdFCJOUCZw
	 shBqmOaZwZvjRmHx6tSxZrylBxwcBk8hdLQ3IGwlR7cW2Yh4eQaTZWj9cAm4tFeZhx8rC
	 G9n02R3nvL6gYtuf4Wd3izI+aoLVorKs5/gFzYpTHrpVsGdLn+gwNvWBQY4YjRnldlrjW
	 4Kj7NHBJ3QbUfIZmLb3QnxeAsVLVibgFQ0Jw3snH+DEHr/OcSUtXfdP5sMpzTqf3qzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=NoJf4wtu;
	arc=none smtp.remote-ip=115.124.28.98
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD78606A31A;
	Tue, 27 Oct 2026 06:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AD78606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=NoJf4wtu
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1793084122; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=TUYyE2x5X4GA3HF7Xndot+b/wLGj5J9nNHL/77ySVmw=;
	b=NoJf4wtu+a/dIi4mSesuDxxpIiW7aJeqq9ElQnX1LDckL74Ajq71kh8ciDKs6yrfTa4dWzbndRvWnt4X+5c//p7RasN4B3QEder/LIXAXXROjBJOQ3iABUVHBJuj4/HFuIwpd8cthh02Q3Y7zLcQkjhITm8jPAFCV9LtETU4t8183lJ1VD/U9LPado7f/UEJrO1DG8hvmzJ3ekSKVk3cBRGz8tJUby3sCo5K3yUodluMhv7swNX0wAG626Th+pyT+N0O8a0F3gESl3gKuft1owL1/xmEucU4b+knxnV5JWnyzMynuX6uWHYsB/0xik62C/zoBJ1nbNX3qo/IV9jpQg==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.4037504|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.45685-0.00107847-0.542072;FP=5220689412969219928|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DW;RN=10;RT=10;SR=0;TI=W4_0.2.3_21251927_1793084116573_o7001c83m;
Received: from WS-web (chunyuzhiqiang@yinhe.ht[W4_0.2.3_21251927_1793084116573_o7001c83m] cluster:ay29) at Tue, 27 Oct 2026 14:55:16 +0800
Date: Tue, 27 Oct 2026 14:55:16 +0800
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
Message-ID: <c1461eae-f544-435b-a046-81abb5f3af8c.chunyuzhiqiang@yinhe.ht>
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
UlJfQ09VTlRFUiAqLwo+Cj4gKGl0IHNsaWdodGx5IGV4Y2VlZHMgdGhlIDgwIGNvbHVtbiBsaW1p
dCwgYnV0IHNvIGRvZXMgdGhlIHN1cnJvdW5kaW5nCj4gY29kZSkuCj4KPiBTYW1lLCB0aGlzIGZp
dCBpbiBvbmUgbGluZToKPgo+ICAgfSBlbHNlIGlmIChkYnRfcGFyYW1zLT5kb19nZXRfYXV0b190
ZGN2ICYmIG5ldGlmX3J1bm5pbmcoZGV2KSkgewoKQWdyZWVkLCBib3RoIHdpbGwgYmUgb24gYSBz
aW5nbGUgbGluZSBpbiB2OCBhcyB5b3Ugc3VnZ2VzdGVkLgoKVGhhbmtzLApDaHVuWXVaaGlRaWFu
Zw==
