Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A736EA98
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792209252; cv=none; b=LWJSyDdrNlcePifkwNLFd8c0jBjOnzT19IC6SjNk7jLS+9qqXOX/OSmLUKLROQrkxKhNWTbKWP6u0LGnAk/jUrAeiWAsU4ELTuWL0MeCJOZYrPBkPNj7ij2kBDrskIoaMz3YhJtm9w84/LR6h+D2aWV920MQvVJ2SvjZPuxGafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792209252; c=relaxed/simple;
	bh=BiIpDiNO+A5zvu0yb7FPXXF68Vr0h0A6t93DHhTsnoY=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=AVUG/hMqoDgdXfLeJKO0gFBHrlWIU87wddUmRMHAcb3eys5LYDlV8Fjjl1YrsO5dW/Ac8sY/OT89Ha5NgRT18yDGlbWdzepZXpq5aW6UUE85fzYx2W1Vl/eBsS7lyYYyKk4ZzQKakuEpXSrgnpwHpvCzfMAqSYHHwtz5RhPEa4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=c8KYv1Il; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="c8KYv1Il"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792209246; bh=BiIpDiNO+A5zvu0yb7FPXXF68Vr0h0A6t93DHhTsnoY=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=c8KYv1IlkDwxF5UNekDmtO+A+XX+nT/FlPS9BrchF9gqyzu70bG5M1Bbwb8qmtnMl
	 Bh1FH2zjKqC18jaikYs04xeJBfJf3Ke1IreDvJxY1tXOMJPQOd6IPHThsgrVxI8twY
	 MjtqLNlk9RH1xQ5ZzPntpr1KmnrZ9kg0rZg/MHL8=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: NH2c3QqomeNikxeJuDQAEIQjSXALw5wWoyJKWbS38jUGjjE+0FUKEOE6/HeRya
	 9vOjAxN/dM/jrxLKVIQucQSTNctilefGfiRmjeyzL35MZx7leZFPU1QdOKDb6VZu3vdldRNN+2lAv
	 ixAo6Aijx4ND0GKKh/b/awJmMvGPmrvriJXXLz6V3PVaB/oZlAcYSzWNCH3+KB/GNPU+VUz89XEKj
	 q9fAz6xHnF6VzTe6hxOWuoBvxdTVCp72UWN6eI2FWZTgHFkAJ2NanBXp3vIJOtw4BBVyZjaywRxxS
	 UC7VqtoEhYfUhpnHWbL5TNU0A3LkfLDHrREaFm2+gpUPP5J6pHm4Qih7yUdpczynuT1lRw4XZ2x4W
	 JK9Xbj5pHOKtowYmzk0G3E6uqbsRjDwWbO7ibzzcr7gujPk3mpz1XL4kE3t2vBVenyFtZZngxy/fN
	 3CM9ywJo3xXNLxTQq+wITtbOQYffVTgRM8eYAanankf1G8jQbAZsadVoNW1YBQzOf+0zmHB6+yWe6
	 hjpNEtyaCehh0T9ztuUKr1iSbvAa9NGAUbUlqIstdOOh7XGuhW0C7G0p8bmqWwa3H6y0xQIfPqucB
	 BtZ9/HpBGDoN0rQsqelTfvbe6bsjrNsUzpbTpUcMSPCpAY3ELxXURV+2YQC3RY0v1czVZuvlyKqgd
	 jR2WqLVtTjuCw4RFsVysSoRX3+hx7Oyj80nLitTjhJ/YHyhcrRAOtiJPGdjnXRZA0ec71dO3XXuUN
	 H6CxKzMbvqnILU86Ef2KHLhyaCM9FShN8q357N53bIE0HnAylyjMJ13yjO2nUNpdacMY1qgNp3g1K
	 G8LdxkB6kYsXDA7rvwKLhn5LstWZL7Y/ivKW+mkwPcFqPwpXtgla38OwkJ5nfVm5j6tiPEbgfn3+9
	 Y770mMgHxgwzLXxGXYAEaRYGkrJRsrDK9MBsqhNMuJMexbRe5ZU+rMemmFKIq5EguEkkCnzN0gxks
	 lCnMnUAsx468MpAX1LhV/R73TcpFLXWCtfUQasXEl8tj+Y5BKO+vjxclMCZ+ei+SsVnio+PTOOJIQ
	 rWJey/VF2o3OrQuXoWl8Vl+pFP4RGgCUbjg3V0Lq5Ioek+iVFEmN+/o+vNzX6qPW4FC553xy6O/PA
	 o1g+ZQpJ4jLJjknypRuXz9qZkSWsbiOOHM8=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzYXNoaWtv?=" <netdev-bot+sashiko@kernel.org>
Cc: "=?utf-8?B?bWts?=" <mkl@pengutronix.de>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?d2c=?=" <wg@grandegger.com>, "=?utf-8?B?c29ja2V0Y2Fu?=" <socketcan@hartkopp.net>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>
Subject: Re: [PATCH net v5 5/6] can: rockchip_canfd: serialize TX with bus-off and restart
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 17 Oct 2026 11:54:03 +0800
X-Priority: 3
Message-ID: <tencent_C91338471C02F811B1FC329B56683265FE09@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261015-rockchip-canfd-restart-close-v5-5-ae77327037c9@qq.com>
	<179219884425.1406898.18319979032484933416@kernel.org>
In-Reply-To: <179219884425.1406898.18319979032484933416@kernel.org>
X-QQ-mid: xmsezb41-0t1792209243t8ya42z76

SGksCgo+IFtTZXZlcml0eTogTG93XQo+IFRoaXMgbG9jayBzdGF5cyBoZWxkIHdpdGggaGFy
ZCBJUlFzIGRpc2FibGVkIHVudGlsIHRoZSBlbmQgb2YKPiBya2NhbmZkX3N0YXJ0X3htaXQo
KS4gVGhlIGxvY2tlZCByZWdpb24gaW5jbHVkZXMgdGhlIGVjaG8gc2tiIGhhbmRsaW5nOgo+
IAo+IGRyaXZlcnMvbmV0L2Nhbi9yb2NrY2hpcC9yb2NrY2hpcF9jYW5mZC10eC5jOnJrY2Fu
ZmRfc3RhcnRfeG1pdCgpIHsKPiAgICAgLi4uCj4gZnJhbWVfbGVuID0gY2FuX3NrYl9nZXRf
ZnJhbWVfbGVuKHNrYik7Cj4gZXJyID0gY2FuX3B1dF9lY2hvX3NrYihza2IsIG5kZXYsIHR4
X2hlYWQsIGZyYW1lX2xlbik7Cj4gaWYgKCFlcnIpCj4gbmV0ZGV2X3NlbnRfcXVldWUocHJp
di0+bmRldiwgZnJhbWVfbGVuKTsKPiAgICAgLi4uCj4gfQo+IAo+IGNhbl9wdXRfZWNob19z
a2IoKS0+Y2FuX2NyZWF0ZV9lY2hvX3NrYigpIGNsb25lcyB0aGUgc2tiIGFuZCB0aGVuIGNh
bGxzCj4gY29uc3VtZV9za2IoKSBvbiB0aGUgb3JpZ2luYWwuIElmIHRoZSBjbG9uZSBmYWls
cywgaXQgY2FsbHMga2ZyZWVfc2tiKCkKPiBpbnN0ZWFkLiBjYW5fcHV0X2VjaG9fc2tiKCkg
YWxzbyBjYWxscyBrZnJlZV9za2IoKSBpbiB0aHJlZSBjYXNlczogSUZGX0VDSE8KPiBpcyBj
bGVhciwgdGhlIHByb3RvY29sIGNoZWNrIGZhaWxzLCBvciB0aGUgZWNobyBzbG90IGlzIHN0
aWxsIG9jY3VwaWVkLgo+IAo+IEZyZWVpbmcgdGhlIG9yaWdpbmFsIHNrYiBydW5zIHRoZSBz
b2NrZXQgZGVzdHJ1Y3RvciAoc29ja193ZnJlZSgpKS4gSWYgdGhpcwo+IGlzIHRoZSBsYXN0
IFRYIHNrYiBvZiBhIGNsb3NlZCBzb2NrZXQsIHRoYXQgY2FuIGNvbnRpbnVlIGludG8gX19z
a19mcmVlKCkuCj4gCj4gVGhlIGNvbW1lbnQgYWJvdmUgZGV2X2tmcmVlX3NrYl9pcnEoKSBp
biBpbmNsdWRlL2xpbnV4L25ldGRldmljZS5oIHNheXMKPiBrZnJlZV9za2IoKSBhbmQgY29u
c3VtZV9za2IoKSBtdXN0IG5vdCBiZSBjYWxsZWQgd2l0aCBoYXJkd2FyZSBpbnRlcnJ1cHRz
Cj4gZGlzYWJsZWQuIEJlZm9yZSB0aGlzIHBhdGNoLCBuZG9fc3RhcnRfeG1pdCgpIHJhbiB3
aXRoIG9ubHkgQkggZGlzYWJsZWQuCgpZb3UgYXJlIHJpZ2h0LiBPbiBub24tUFJFRU1QVF9S
VCBrZXJuZWxzLCB0aGUgbmV3IGxvY2tpbmcgcGxhY2VzIHRoZQpvcmlnaW5hbCBza2IncyBy
ZWxlYXNlIGluc2lkZSBhbiBJUlEtZGlzYWJsZWQgc2VjdGlvbi4gSSB3aWxsIGZpeCB0aGlz
CmluIHRoZSBuZXh0IHJldmlzaW9uIHdoaWxlIHByZXNlcnZpbmcgdGhlIHN5bmNocm9uaXph
dGlvbiB3aXRoIGJ1cy1vZmYKYW5kIGNsb3NlLgoKPiBbU2V2ZXJpdHk6IE1lZGl1bV0KPiBU
aGlzIGlzIGEgcHJlLWV4aXN0aW5nIGlzc3VlIHRoYXQgdGhpcyBwYXRjaCBkaWQgbm90IGlu
dHJvZHVjZS4gV2hhdAo+IGhhcHBlbnMgd2hlbiBjYW5fcHV0X2VjaG9fc2tiKCkgZmFpbHMg
ZWFybGllciBpbiB0aGlzIGZ1bmN0aW9uPwoKWWVzLCB0aGUgZXhpc3RpbmcgY29kZSBzdGls
bCBhZHZhbmNlcyB0eF9oZWFkIGFuZCBzdWJtaXRzIHRoZSBmcmFtZSBhZnRlcgplY2hvIGFs
bG9jYXRpb24gZmFpbHMuIFdoZW4gdHhfdGFpbCByZWFjaGVzIHRoZSBlbXB0eSBzbG90LCBj
b21wbGV0aW9uCm1hdGNoaW5nIGZhaWxzIGFuZCB0eF90YWlsIGNhbm5vdCBhZHZhbmNlLCB3
aGljaCBjYW4gc3RhbGwgVFguCgpUaGlzIHByZWRhdGVzIHRoZSBzZXJpZXMuIEkgaGF2ZSBy
ZWNvcmRlZCBpdCBhcyBhIHNlcGFyYXRlIGZvbGxvdy11cCBmaXgKYW5kIHdpbGwga2VlcCBp
dCBvdXRzaWRlIHRoaXMgcmVzdGFydC9jbG9zZSBzZXJpZXMuCgpSZWdhcmRzLApDdW5oYW8g
THUKCnB3LWJvdDogY3IK

