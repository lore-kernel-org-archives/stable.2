Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64642DA48;
	Thu, 30 Jul 2026 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415213; cv=none; b=fIsxe4PVHYEtNpc666hjDUEk86pKBmCPhIPbSUAJAwbMld0knqW86Gtr0dZ3gXcRXlGx9FBwHq7qWnZLFkNIhyu+IzOdUkKefzfrZEnO4knrVEXnpZvohT4FrSpmYWobEFgZBSv6/TjI/hf1ZU0rgzoMndD03u1r2lMdI5WdgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415213; c=relaxed/simple;
	bh=6dOH+TfUL4DYiYVvqDYePxfLIBEPe3+uTngEu84Kchk=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=uPQqUZfYL7tI3PR+HjOtE1hc5f24zb1uW8rzYjH1oCozQBEsRN99slRj4aiZUY27KWMiDrYCeoC35i1y+nsgu8FZaBucj9HFnsb/xTMYBUESqvsWTztuJObU+Qgi8eAgPvXejNsQLfbTlKUHnkaXANiY6Zd7whGm4pf8V0nZ7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UlhsuYmv; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UlhsuYmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785415183; bh=6dOH+TfUL4DYiYVvqDYePxfLIBEPe3+uTngEu84Kchk=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=UlhsuYmv7yMEsXAjFGqZvjpxJnFEwFt9j+nfSea9QinpemgyNX/cjEiot/npVW9SA
	 aAbW7RoVc6xBv+GGuVvTACLhO6Tu60safPmEgojc9RH6g0RqCzkA3LTlh1VpO6psd9
	 5zhO8DhlP9ZSWJeMagYStYPnse3UWGre7nR53p9c=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: M6SBtOKpYQFc6/SqSlCZJwcYFzT17HCWNyXinNYju8qs0SlvZX+Vow8Wou8P/B
	 BVi0NjpUPuMcEMI3NPrlFWiFKtEAKiF952iP22L6OGSyRrY4O2D/onys8rXUaCse6x7Vuih2KYWhm
	 JB1QY7Lxlgb/5wZKbkQv0FJiKKUDIU+wuLtPZBayz+5nG9SEFL7cntbOHyXTBBej1c3Qe0vlndSQX
	 xwfuCiDWzfSy8lXryy9gNLKywzZ/sO85s4vTZYH/1lAEdLWo+J6UyAWAqvV6wn35WAIIi0QLuNatm
	 XflhByjDnvdMfN7qb4rrPeSQTS5RwB8V0JSk4IR5r+kDQ/7ScFcnwTZzgqcD2TUFMVyIuKnWSprqE
	 ZsFaHR79tIhOrqcS+fl8UTvv6dTVj/4JV+66hrdKceFXjJfJOeGqbGn6/tzOzDyLfbWSFZYOsTEdH
	 p83g/8dEWM/pW1FpIj8LJ6WRZ6C+PTQe0W6rqQ305FIE3HehRaz8bjCDamK7NQWrVoMlJdtvhTm8T
	 ZaYSHZ4YmzvSnhTZdiP8GH7EaCgOdKtJUOucFOCNuChu46gKeiA+hNJpPLiDXkhIOIsiodUZKKhgt
	 RX8d40jWyekDvwzafNjtmbgi5TDW9A7G8x9m1qF9VTMMa3C/LurOHw/XIX2f8ObJubBpsejXMFWzE
	 vwl6Vt6WjPc6mjYyRIT8c/WV+D5kc61VN7QB5L9HZ7b5RiXMqsj22loXXib1b11itU+B9zJYHFb8M
	 7zeFBJEO9wLFyfq53N60R2sOSPjX+VF77pWmWOZRexnA31kqgJnsc7OQBNxfYvc54ingPmP0/iJqs
	 wkf66Mmu8bJvH4gYSEO8BqJdTjlIhgv7rXubAoNA/gPvHdmUU9HA19MIvg22mWXLoOcDqA+cQ/Ykx
	 +vtNbHTrQYwnDygjzrq2YmVN502ONS5rjUCfrnzI/L2b6PEihDASyiclcXTL9Bvfh/g8DzRpqw64A
	 FJVHHi0Wc1g3Ypr0eWRL5+p3XO1AEzyDmg6rlpYwznGzHcil3zPaMbNHPzZnUtBLu9J2UfYhvJhib
	 hPS6aUkAOZM27Aq+Qc8cjo7emGA==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>
Cc: "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] can: rockchip_canfd: prevent TX stall on echo skb failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 30 Jul 2026 20:39:42 +0800
X-Priority: 3
Message-ID: <tencent_31EFA63F9A19198A04D8919580584442BF07@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_D802EB485A801362BF9F54130C0D990C6206@qq.com>
 <tencent_5E44473FC626379A34998A84DF11E6000807@qq.com>
	<20260730-secret-soft-swallow-4da108-mkl@pengutronix.de>
In-Reply-To: <20260730-secret-soft-swallow-4da108-mkl@pengutronix.de>
X-QQ-mid: xmsezb41-0t1785415182tuairg04l

SGkgTWFyYywKCk9uIDMwLjA3LjIwMjYsIE1hcmMgS2xlaW5lLUJ1ZGRlIHdyb3RlOgo+IENh
biB5b3UgdXBkYXRlIGNhbl9wdXRfZWNob19za2IoKSB0byBhbHdheXMgZnJlZSB0aGUgc2ti
IGluIHRoZSBlcnJvciBjYXNlPwoKWWVzLiBJbiB2MywgSSB3aWxsIHVwZGF0ZSBjYW5fcHV0
X2VjaG9fc2tiKCkgdG8gYWxzbyBmcmVlIHRoZSBza2Igb24KLUVJTlZBTCwgc28gdGhhdCBp
dCBjb25zaXN0ZW50bHkgY29uc3VtZXMgdGhlIHNrYiBvbiBldmVyeSBlcnJvciBwYXRoLgpJ
IHdpbGwgcmVtb3ZlIHRoZSBjb3JyZXNwb25kaW5nIC1FSU5WQUwgc3BlY2lhbCBjYXNlIGZy
b20gdGhlIFJvY2tjaGlwCkNBTi1GRCBkcml2ZXIuCgo+IElzIHRoaXMgZXJyb3IgbWVzc2Fn
ZSBuZWVkZWQ/IEluIHRoZSAtRUlOVkFMIGNhc2UgY2FuX3B1dF9lY2hvX3NrYigpCj4gYWxy
ZWFkeSBlbWl0cyBhbiBlcnJvci4gSWYgc2tiIGFsbG9jYXRpb24gSSB0aGluayBpbiAtRU5P
TUVNIGNhc2UgdGhlCj4ga2VybmVsIGFscmVhZHkgdGhyb3dzIGFuIGVycm9yLCByaWdodD8K
CkFncmVlZC4gVGhlIGFkZGl0aW9uYWwgZHJpdmVyIGVycm9yIG1lc3NhZ2UgaXMgcmVkdW5k
YW50LiBJIHdpbGwgcmVtb3ZlCml0IGluIHYzIGFuZCByZXRhaW4gb25seSB0aGUgZHJvcHBl
ZC1mcmFtZSBhY2NvdW50aW5nIGFuZCBlcnJvciBoYW5kbGluZy4KClRoYW5rcyBmb3IgdGhl
IHJldmlldy4KCkJlc3QgcmVnYXJkcywKQ3VuaGFv

