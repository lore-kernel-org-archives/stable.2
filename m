Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28835E94E;
	Wed,  2 Sep 2026 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788316073; cv=none; b=QncdAe0efP5yF7jNw760ZLWs5llIGQfD1s8sC/8VIO0gXj2QqHHiAv4TmFJzvYs5u3leB9CwXktceDMGLxVvnwVYhlai98+ohSESvgc8iyhGY3UYtY/ZlFEbNgaWF/1Oj84zdaD4ZTM2rE9t6nT7h250mj/zNDrcKxqUxqrq+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788316073; c=relaxed/simple;
	bh=Tl9znUrzuN2JJ5gC4Nyi+pxyoOQ8QHSbgC9No28bvZM=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=ZRbeEfHg0Z5FxKR+ohXrEn4gCFoRgO4Ckkxg5taHwWsS0XxJ/wO9PzS/cdkWEjE6RQ1NdBnbcbBS5v/isNjVllIi4bPsKj0uHR3w9Jhy2+PqWB0/Zzt3HFy17KKWhO0kqyZ50xe5cyxVfHfZKwV2CpywBHuGyuNAtQ82EKv3f0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=D84XkZnv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="D84XkZnv"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6822RluP62246492, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788316067; bh=Tl9znUrzuN2JJ5gC4Nyi+pxyoOQ8QHSbgC9No28bvZM=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Message-ID:Date;
	b=D84XkZnvNz65SLQG/gNuMrBj3FgWURRcunkBWdg+6JcUqzLrvfCeRGrUMzGRkre9F
	 33oMpjmcor3pwJBDtEr28C1vtfHWqDpotLpzhPulM+/tamzcbQAVrHT2tCIJrX5Ogu
	 6CBiTNa/vY1h6q9EkzY8oCw2f2BWqkIKv65kHMAvCnlpTPApw5pzVmUZl8XfZlpqIk
	 3ZeTIMpwZx8R7sSNaQo+kIdl/yw4I4Se5YPDV6KEV6GoPSyCkLeTKu2XDSipTUC6MG
	 CQ1qmnoyUwDB8g8Rs92cdSQAaDc9q5YTeIfKvvgvNNXQQwG9bLMmFDGChTHr1IxU/q
	 vPOulR/vkSwvQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6822RluP62246492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 10:27:47 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 2 Sep 2026 10:27:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43 via Frontend
 Transport; Wed, 2 Sep 2026 10:27:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?b?44Kk44Og44OG44Kj44Ok44K6?= <reza1234khan1234@gmail.com>, Ping-Ke
 Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: =?utf-8?b?44Kk44Og44OG44Kj44Ok44K6?= <reza1234khan1234@gmail.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: fix out-of-bounds CAM write when key table is full
In-Reply-To: <20260805210941.75136-1-reza1234khan1234@gmail.com>
References: <20260805210941.75136-1-reza1234khan1234@gmail.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Message-ID: <ec59579b-5d3b-4ee4-8606-555f4566aae2@RTKEXHMBS04.realtek.com.tw>
Date: Wed, 2 Sep 2026 10:27:41 +0800

PHJlemExMjM0a2hhbjEyMzRAZ21haWwuY29tPiB3cm90ZToKCj4gSW4gcnR3X29wc19zZXRfa2V5
KCksIHdoZW4gdGhlIENBTSB0YWJsZSBpcyBmdWxsLAo+IHJ0d19zZWNfZ2V0X2ZyZWVfY2FtKCkg
cmV0dXJucyBSVFdfTUFYX1NFQ19DQU1fTlVNICgzMikgYmVjYXVzZQo+IGZpbmRfbmV4dF96ZXJv
X2JpdCgpL2ZpbmRfZmlyc3RfemVyb19iaXQoKSByZXR1cm4gdGhlIGJpdG1hcCBzaXplCj4gd2hl
biBubyBmcmVlIHNsb3QgZXhpc3RzLiBUaGUgYm91bmRzIGNoZWNrIGNvbXBhcmVzIHRoZSByZXR1
cm5lZAo+IGluZGV4IHdpdGggIj4iIGFnYWluc3QgdG90YWxfY2FtX251bSAoMzIpLCBzbyB0aGUg
aW52YWxpZCBpbmRleCAzMgo+IHBhc3NlcyB0aGUgY2hlY2suCj4gCj4gcnR3X3NlY193cml0ZV9j
YW0oKSB0aGVuIGluZGV4ZXMgY2FtX3RhYmxlWzMyXSwgYW4gYXJyYXkgZGVjbGFyZWQKPiB3aXRo
IFJUV19NQVhfU0VDX0NBTV9OVU0gKDMyKSBlbnRyaWVzLCBjYXVzaW5nIGFuIG91dC1vZi1ib3Vu
ZHMKPiB3cml0ZSB0aGF0IGNvcnJ1cHRzIHRoZSBjYW1fbWFwIGFsbG9jYXRpb24gYml0bWFwLiBU
aGUgd3JpdGUgYWxzbwo+IHNldHMgYml0IDMyIG9mIGNhbV9tYXAsIHdoaWNoIG92ZXJydW5zIHRo
ZSBiaXRtYXAgYXMgd2VsbC4KPiAKPiBGaXggdGhlIG9mZi1ieS1vbmUgYnkgcmVqZWN0aW5nIGlu
ZGljZXMgPj0gdG90YWxfY2FtX251bS4KPiAKPiBGaXhlczogZTMwMzc0ODVjNjhlICgicnR3ODg6
IG5ldyBSZWFsdGVrIDgwMi4xMWFjIGRyaXZlciIpCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcKPiAKPiBUZXN0ZWQgb246IFJUTDg4MjFDRSAoUENJZSkgb24ga2VybmVsCj4gNy4yLjAtcmM2
LXJ0dzg4dGVzdC0wMDA1OS1nMGQ4Mzk1NzA3NjUxLiBUaGUgcGF0Y2hlZCBtb2R1bGUgbG9hZGVk
Cj4gYW5kIGFzc29jaWF0ZWQgdG8gYSBXUEEyIG5ldHdvcms7IHBpbmcgdHJhZmZpYyBwYXNzZWQg
d2l0aCAwJSBwYWNrZXQKPiBsb3NzLiBSZWFzc29jaWF0aW9uIGFuZCBkaXNjb25uZWN0L3JlY29u
bmVjdCBjeWNsZXMgY29tcGxldGVkCj4gd2l0aG91dCBlcnJvcnMsIGFuZCB0aGUgQ0FNIHRhYmxl
IChkZWJ1Z2ZzIGR1bXBfY2FtKSBzaG93ZWQgdmFsaWQKPiBrZXkgZW50cmllcy4gVGhlIENBTS1m
dWxsIGJvdW5kYXJ5ICgyOCsgcGFpcndpc2Uga2V5cykgcmVxdWlyZXMgYW4KPiBhY2Nlc3MgcG9p
bnQgd2l0aCAyOCsgY2xpZW50cyBhbmQgaXMgbm90IHJlYWNoYWJsZSBpbiBhCj4gc2luZ2xlLWNs
aWVudCBzZXR1cCwgc28gdGhhdCBwYXRoIHdhcyB2ZXJpZmllZCBieSBjb2RlIGluc3BlY3Rpb24u
Cj4gCj4gVGVzdGVkLWJ5OiDjgqTjg6Djg4bjgqPjg6TjgrogPHJlemExMjM0a2hhbjEyMzRAZ21h
aWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IOOCpOODoOODhuOCo+ODpOOCuiA8cmV6YTEyMzRraGFu
MTIzNEBnbWFpbC5jb20+Cj4gQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsu
Y29tPgoKMSBwYXRjaChlcykgYXBwbGllZCB0byBydHctbmV4dCBicmFuY2ggb2YgcnR3LmdpdCwg
dGhhbmtzLgoKMTBkNTg4MjNjYjQ0IHdpZmk6IHJ0dzg4OiBmaXggb3V0LW9mLWJvdW5kcyBDQU0g
d3JpdGUgd2hlbiBrZXkgdGFibGUgaXMgZnVsbAoKLS0tCmh0dHBzOi8vZ2l0aHViLmNvbS9wa3No
aWgvcnR3LmdpdAoK
