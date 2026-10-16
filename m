Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA893921ED
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131171; cv=none; b=AInK731Rhz+hKebfNJDNin08ESQiRRLSkzO5k03N/2HKkz20yyX0qAnI4CU9gcjbjwB94XjZoT2t6m+b18efjINyHsULTmMvhjOuDRcTCI62RKkK3/oDULlDC9rTggLEsBKD9T191uLhojCrZdRQrj4r9FvDVI8qy6EJFAEmlxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131171; c=relaxed/simple;
	bh=Pcl2raRurZjpnn71jo5ShnqVzuQQYqLtZN6GcJ3U5JE=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=AA+qzI9rv7NQL65Mn1NGrzcEZqQvIUJvdLwcrzwejNp+iqdcqUwGhmRBXrU2EDtgjQ7TlUyuSzDycWecusQFhQHKQW2IkKzLqggZo5t/MXPZMJG5RCMdVByW4xcdtT6j+2QXjL3iuNSDy9PWJV0bR9vp+wIT4UY+d8NyiN/vpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AgUD//DG; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AgUD//DG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792131166; bh=Pcl2raRurZjpnn71jo5ShnqVzuQQYqLtZN6GcJ3U5JE=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=AgUD//DG+Ve4rkVO5rLSaJ0nFGR4PRADs9+UY8WLOn6FrUgaW971WOkfSUF+jQ6JJ
	 UW3NApjr0PvEu4vQ9WtUCJjmJu3cxejj9z350qZvjh3TyJRc8S3kHDuUBYNtxYcGUI
	 f+QIfzLb5jHn6KCpgAVBRdRhGcWg03PnnRlZeefU=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-XMAILINFO: NX669osvFPDayi99gxpQuJ5Uim9/ETPpsz/R+MRP7zb3FlPNPPqVrV/eiVBKBk
	 0r937APbrZezjhcDpwft/cUe1KJ2ME0knMVgmKG8IjP4U159evzMO2hDea6wE8x/8I14tAsCc50YZ
	 BUU4s9LdyZWCNUx1rz2s3X3HYsZ6Cw/kcTUpVcaqyA5IsCl+yJeNxI3iP+1muR4FxGzmaQVU6UX8D
	 aaN2YXjbJS8IVBuN+XEJ1zG9ohgJxm6q/RaBx0Rzo7X5DKe4MO3XicjJ8jyyr3qZXB6OpjGEqRY/e
	 g5m+wHv052bM5XAj0Mfx9gBofvroamiCxIrAUAPkYlGNoux5g9AmoAIOWYYIfoyvyiYrrMoHYcMDk
	 7fxiy3vEUo0GDEEBzJECW+JZfX002qJaI+H/826KKBlixCv6ER1PD24srODetyKd6FCTYiKGIux8f
	 7Q8Q1ZFFWixaju7lbEI6UFq9trM2hA/D27E/nhX+Hi0ZtCcNlKmbkxE6mIa+ULtBPqw7IaXtdx3Fb
	 x0mnYcJeCnetApOLKQqMqX3rb6igl+2a9rMSD3yHaEP0zeu9L/CBswbv/OkuS7qNLOD8vvYrwzcTi
	 mNhMUAysO2LAvs7AskJcYZu11gKXpflgj74g8YT3JmztovAJW3Q9rvgV9pXASJVk0kkRSKP03rvEO
	 MIHq2hbRSvtV2A9CDjTEqcN5eNQJ5g8ekO1y/Hwp4sh0jitxI4sWe3uKu/Z+pfsZZWo54wr65QaDP
	 QiWxLNBFEHbPRy5bE9pX68lJdn9dElpuFbie5Z5fqvU5AIZq959ou3ydgUpgtCtW3YfuzoV44++/g
	 Mn/h/EKeS4dxCd47Et0Lhi+i4h5K7b7c3VM2oAN02ugFF+wo0IUEfhJpTaZ5oBHDo4KeaIt8uyDRu
	 T/6f/I514tefHRpi10MqhfvR8GPtTlL9K3+Rub8YbldEHwLR9kQ20cFgrYhwJs1IZVur1lLzB09kg
	 rklYQMyxCDStUfUkQF2v3iHwRXYczulBlB9895sKThQ5ws+ffGFTOHt1XqQUDRMnSUBkL+B4vMwxk
	 ba3HMKOymbZGtghfAXC6CyUfS8EEiMTXaSNvH9ld33fdLN64=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzYXNoaWtv?=" <netdev-bot+sashiko@kernel.org>
Cc: "=?utf-8?B?bWts?=" <mkl@pengutronix.de>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?d2c=?=" <wg@grandegger.com>, "=?utf-8?B?c29ja2V0Y2Fu?=" <socketcan@hartkopp.net>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>
Subject: Re: [PATCH net v2 3/3] can: rockchip_canfd: cancel bus-off restart before closing the device
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 16 Oct 2026 14:12:43 +0800
X-Priority: 3
Message-ID: <tencent_DD06B1C5CFBB499BE647A639417E0420C005@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_B15E13184DA04C4382F48848C006A2B51F06@qq.com>
	<179208227384.1406898.15110321342582191229@kernel.org>
In-Reply-To: <179208227384.1406898.15110321342582191229@kernel.org>
X-QQ-mid: xmsezb41-0t1792131163tpme4vw8z

SGksCgo+IC3CoFtNZWRpdW1dwqBjYW46wqByb2NrY2hpcF9jYW5mZDrCoGRpc2FibGVfaXJx
KCnCoGNhbGxlZMKgb27CoHNoYXJlZMKgSVJRCj4gCj4gUHJlLWV4aXN0aW5nwqBpc3N1ZXM6
Cj4gLcKgW0hpZ2hdwqBUaGlzwqBwcm9ibGVtwqB3YXNuJ3TCoGludHJvZHVjZWTCoGJ5wqB0
aGlzwqBwYXRjaCzCoGJ1dMKgdGhlwqByZXN0YXJ0Cj4gwqDCoGNhbGxiYWNrwqB0aGXCoHBh
dGNowqBtb2RpZmllc8KgcmUtaW5pdGlhbGl6ZXPCoGHCoGRlbGF5ZWRfd29ya8KgdGhhdMKg
bWF54oCmCgpCb3RoIGlzc3VlcyB3ZXJlIGFkZHJlc3NlZCBpbiB2MywgYW5kIHRoZSBmaXhl
cyBhcmUgcmV0YWluZWQgaW4gdjUuCgpSZWdhcmRzLApDdW5oYW8gTHUK

