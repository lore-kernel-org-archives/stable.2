Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF733EB06;
	Wed, 14 Oct 2026 05:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954191; cv=none; b=DQl/eq7XwzUVwEm3r2iraVkYbusKE6t53CB+gSR9SRIMlup67/BXPHJYboIY3SdXyedsY/DdsC3Z50oSXexH35C7oFfW4qQWN9IwO7qX0UGwC844kQ7nkvMXkwMKzhzjHmAd90D8aj3La7z3id4CDxNUXnCnj1mL8TdtlSe9ZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954191; c=relaxed/simple;
	bh=0T0zreJEKXCOs2vAHy9C7aS+rC0OoUQsDz7CaxsQtfg=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=kgHrTA4FRIOuGbQKYgTfQZLVqG2ettteKOqAYaSLp4CLpN4rhZPDsnOoNAb5+RJdAhsKA29T25/kGkC4UFDHP7CfAtcUX6YSAdujME/Us6mLdzKYilK3ZgCQ/Bxxgxj3hoEuT/uO375eewMUmWy1I+q4cbePx3IyXp6Xl5O+/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=No67Yb89; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="No67Yb89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791954184; bh=0T0zreJEKXCOs2vAHy9C7aS+rC0OoUQsDz7CaxsQtfg=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=No67Yb899+Gy5k0t1WYRFaEiPXQEASN0lMGBncIbU4m8e4fnqLIm+fEXsR5UfuJwp
	 yIrJoSxF4pMNGBdwDfBBn0Us2aUNEJN7/ZgcQUsN+oVjkPNya/0lvb6FO+i0L9mCfm
	 /mPcwbtyc9mJSpxq3lCWtLVMGaJYR9gTtyyChNfg=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-XMAILINFO: MxLtP9q6S0tzjLKUKgJphWdmcFHfNjQ+Kg7zfilYfOVLccuCtqBLPDXOU/0AG3
	 hDL/EKnlaE/4Unw/PfxELEMPmMENAGsqik9zbXx65JLzWq3V7par2z3s3fqP0lxb/tS+BeO5Gu3p6
	 /wENtOGv41KbVGOZvRDWC5xLa0bWnalLVMpTNobxlr34gAcXwFbcU7+sEKEqpKvYZhrYrs4ouvi+Y
	 4gECnxuN4+7fD8JXAslDJG/R1qwFg+HuvSXHoXQMTV1CDamooQqWma0WMIq7K1/QMDbprIc9G2jEs
	 e3GD5a8sGYDS6FXCJa7xby38XshjdgNZecatCej30e/sCQZhPQokFNeC1AMMD/7G6JldqgGDQcEpR
	 8r54+y0EGdWvHX9h82jppGKe1BGXL0Xkxwtc9NUf65rTbBddyTkpkbZ0+9vw5IZzLq8XHXVpN9GkO
	 9YOpkySIos4xtYfpPTiCPH8B3NGGzjAlD1UhaTekAD70mundIhUfgbKT7H704tZBLpl5eaqEJwJKY
	 eFHlJZwlxKGagWjnLISVdl0iXGBA+ke6RjWRgx1dv2RlhC3oV9j5RZHKafNToNomSwaZVRP/bot8C
	 LVa1y9inpdOh49gA5e/mHAIHF471W6INM6UsSfdqMuPD4jThwep0vFAVYo7U+EfX3DkFA0OIv5vPO
	 2+4gqjwQ0Qihoujov7LQknNJ7Lg1QU+/2cv/hnHaSayki3+8PWY2vGb5cBeSloV09+kzMqngrEaF5
	 yMX45PfBtrNQeUqcJe83PMsreIHn8irfvpXCJtg8SBCyGHoDq0eyPQSlatJ9OefP1CYtj6hQjr5X4
	 WtplOcUl0FDukpST5Aov9n0Fv8mnYeYvSyp/FMmmog7ajNe90P6m51FWmx3gW8J3hiw6v33G2ihwt
	 SRjJwSTVa2kZ+qW0oJ4GM883eF3s0/Zz+GYQDsh16RPZvPlAG0jO8dHG2LSYxuRr6yzJnLB3O9nID
	 4mPLuNj3oH8wOXjcEChVobv2ru0XNLfM6Jw83mCNqK/XGWC+Sot4MbqME0At8ZvTDGNQegoW9MMWu
	 29dv36fwBYAFDYJgSlKIrftX3a8AIGo5TYxKVh22MaBVmKqs=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzYXNoaWtv?=" <netdev-bot+sashiko@kernel.org>
Cc: "=?utf-8?B?bWts?=" <mkl@pengutronix.de>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?YmlnZWFzeQ==?=" <bigeasy@linutronix.de>, "=?utf-8?B?Y2xya3dsbG1z?=" <clrkwllms@kernel.org>, "=?utf-8?B?cm9zdGVkdA==?=" <rostedt@goodmis.org>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>
Subject: Re: [PATCH net] can: rockchip_canfd: stop bus-off restart before closing the device
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 14 Oct 2026 13:03:02 +0800
X-Priority: 3
Message-ID: <tencent_D5994C4DC2CF087A800762B3DF5F53010D06@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_5802EE88434010229EDF7A53084D994C6106@qq.com>
	<179194843570.434549.16906326776857003512@kernel.org>
In-Reply-To: <179194843570.434549.16906326776857003512@kernel.org>
X-QQ-mid: xmsezb41-0t1791954182tg1aae6rv

SGksCgpJIGNoZWNrZWQgYWxsIGZvdXIgZmluZGluZ3MgYWdhaW5zdCB0aGUgY3VycmVudCBi
cmFuY2guCgo+IC0gW01lZGl1bV0gVGhlIHBhdGNoIG5vdyBoYXMgcmtjYW5mZF9zZXRfbW9k
ZSgpIHJldHVybiAtRU5FVERPV04gd2hlbiBpdAo+ICAgc2VlcyBwcml2LT5jbG9zaW5nLgo+
IC0gW01lZGl1bV0gcmtjYW5mZF9zdG9wKCkgcHVibGlzaGVzIHByaXYtPmNsb3NpbmcgPSB0
cnVlIChsaW5lIDc3NikKPiAgIGJlZm9yZSBpdCBtYXNrcyB0aGUgY29udHJvbGxlciBpbnRl
cnJ1cHRzIHdpdGjigKYKClRoZSB0d28gaXNzdWVzIGludm9sdmluZyBjbG9zaW5nIHdlcmUg
YWRkcmVzc2VkIGluIHYyLgoKPiBbU2V2ZXJpdHk6IEhpZ2hdCj4gVGhpcyBpc24ndCBhIGJ1
ZyBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIGJ1dCB0aGlzIHBhdGNoIGhhcmRlbnMgdGhl
Cj4gcmVzdGFydCBwYXRoLCBzbyBpcyBpdCBzYWZlIHRvIHJlaW5pdGlhbGl6ZSB0aGUgdGlt
ZXN0YW1wIGRlbGF5ZWRfd29yawo+IGhlcmU/Cj4gLi4uCj4gV291bGQgaXQgd29yayB0byBj
YWxsIElOSVRfREVMQVlFRF9XT1JLKCkgb25jZSBhdCBwcm9iZSB0aW1lLCBhbmQgdG8gY2Fs
bAo+IGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmcHJpdi0+dGltZXN0YW1wKSBpbiB0aGUg
cHJvY2Vzcy1jb250ZXh0IHJlc3RhcnQKPiBwYXRoIGJlZm9yZSB0aGUgdGltZWNvdW50ZXIg
aXMgcmVpbml0aWFsaXplZD8KCkFncmVlZC4gRXhjbHVkaW5nIHRoZSBJUlEgaGFuZGxlciBk
b2VzIG5vdCBzdG9wIHRoZSB0aW1lc3RhbXAgd29ya2VyLgpJIHdpbGwgaW5pdGlhbGl6ZSB0
aGUgZGVsYXllZF93b3JrIG9uY2UgYXQgcHJvYmUgdGltZSBhbmQgc3luY2hyb25vdXNseQpj
YW5jZWwgaXQgaW4gdGhlIHByb2Nlc3MtY29udGV4dCByZXN0YXJ0IHBhdGgsIGFmdGVyIGV4
Y2x1ZGluZyB0aGUgSVJRCmhhbmRsZXIgYW5kIGJlZm9yZSBya2NhbmZkX2NoaXBfc3RhcnQo
KSByZWluaXRpYWxpemVzIHRoZSB0aW1lc3RhbXAKc3RhdGUuIFRoZSBidXMtb2ZmIElSUSBw
YXRoIHdpbGwga2VlcCBpdHMgbm9uLXN5bmNocm9ub3VzIGNhbmNlbGxhdGlvbi4KCgo+IFtT
ZXZlcml0eTogSGlnaF0KPiBUaGlzIGlzIGEgcHJlLWV4aXN0aW5nIGlzc3VlLCBidXQgdGhp
cyBodW5rIHRvdWNoZXMgdGhlIHJlcXVlc3RfaXJxKCkKPiBwYXRoIGluIHJrY2FuZmRfb3Bl
bigpLiBXaGF0IGhhcHBlbnMgdG8gTkFQSSBpZiByZXF1ZXN0X2lycSgpIGZhaWxzPwo+IC4u
Lgo+IFNob3VsZCBjYW5fcnhfb2ZmbG9hZF9kaXNhYmxlKCZwcml2LT5vZmZsb2FkKSBiZSBh
ZGRlZCB0byB0aGlzIGVycm9yIHBhdGg/CgpZZXMuIEkgd2lsbCBhZGQgaXQgdG8gdGhlIHJl
cXVlc3RfaXJxKCkgZmFpbHVyZSBwYXRoLCBiZWZvcmUgc3RvcHBpbmcgdGhlCmNvbnRyb2xs
ZXIsIHRvIGJhbGFuY2UgY2FuX3J4X29mZmxvYWRfZW5hYmxlKCkuIEkgd2lsbCBhZGRyZXNz
IHRoaXMgYW5kCnRoZSB0aW1lc3RhbXAgd29yayBpc3N1ZSBpbiBzZXBhcmF0ZSBwYXRjaGVz
LgoKSSB3aWxsIGZpeCB0aGVzZSBidWdzIGluIHYzLgoKUmVnYXJkcywKQ3VuaGFvIEx1

