Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B572502777;
	Tue, 13 Oct 2026 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896791; cv=none; b=D6ED0x/VhKNnBZd1xklQMmRiMndPBhW3LTCtINeVcZIjDOQnfPTocmqezbKa1vJZtbZjp/uO6tQlUbayp0g9p+60gm/1uuO71NHXG+agCIML7QMrbK0tCghaHcYw/caaVstRSRSzR4yby28ixMl3EktV0cQj+yAPk5wxxi4zhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896791; c=relaxed/simple;
	bh=YA58kepF5/oFO2hgjwCX+vvSGiubieaYMrE8JCbPGRE=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=ggGUoEocPy2+/E1ydWVFpNJNaGyYLqQ6vPzutfMGK5tFCPC6nIug9/Zfice9uuTR/u9ztel9JHtvB8EDIEWujcQ9qv424M4ak+fYblKwala3OXoeITu5d1V3d3cWsf1NM2tP7TB+s4yawJD1c/dMAUUJjbP4VOZyg+/Gj/EPTM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=j7IsN8VB; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="j7IsN8VB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791896783; bh=YA58kepF5/oFO2hgjwCX+vvSGiubieaYMrE8JCbPGRE=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=j7IsN8VBWg65+eB3yIn/pY/Cp7UuHAS1ElrRYG3zZ7ZDXhi4M7thr2ZTlxwosL0Rx
	 fPD04FsKz1HocQJoipo0t6fXxf7LfpjkHyJSjBmW5xK3+MJ2cvCHSei91HaqsooCo9
	 Dl7wl9Kkd0V4VH9581K0y75223OkCnoIsP+AzcaQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: OTkXlZHit/HDB8lz4bZyda8RXw5N5T4WHY6SL+WkAwI1CMWbvphDjR94zYpnKl
	 w9w2c0/v1h6QRIPtC/NIc30bOguGfgMYpH+00L7Qsis+xUpA8Nv+/wuo62ZbSP3XKzEG8uYQVh5DV
	 yok+v9e6ywQ9rWYWeEKwQnhLd2FBs/4ZCSw5Jjf7OCHKIj8cfHpYPJFjwldV6hlDsa84AHGsZpm/a
	 WrQ7bMmfodY02zY0+KHnCfF7q2t+jk3kL0ltDxzU6lqeGHMu1RXJW5QqRACnN3w2UltfYuFlgV4OX
	 N8h/k/ddOQsVYO+J02HXIY95WzCaQub8DB/9KemcUbV7hEjCmlqQ7EVNMdajoct92kC+sJM7kNamx
	 1aE7mDpyf177tcaFixVmtjLQ29Lii7uS3GCMZkNYqSW1L6LBmWXdb6IHRR5MyxStYo38Hm49qFqcm
	 AWAODyxYB/E8n0hAkvlmjShx23PmPggxbzVDcP524fSzoD0CPyLU9+RGVCXoh2k+ANhWnoiluu8/S
	 vgLMF+Kq1kYqdXLdh49+8TnNStwsGtuhEd/iPWQw9Ny7SXxql05T0uPQzac983mEHKD/d3GQeiomp
	 JMl0Cxxk5NTdiOziSbcq6K0OCEjMjOypdYY3K1AWjJcXQAIzHL2Nl5Wsk0YYJv7eeCmPB3oZo+DVl
	 0Vn1E6BVcR/Jd/j5Cc/l7kUEiupH4YunRfFHliQq5jXRuNoZPmvuwqfW16wqTIlrxRsccA75k49SI
	 V2N+NyLy1wpCp3zBNXlsEaa+dDrsKnkZuxPQut0knJM31hCQvTZVX5583eXF2RLgPNrAqB0Qv9H9u
	 i5gcgt2CETH8w7OErtDpFPFTeJOhIN5CWcryAde4jIEKFCwo7eXX5avKAmuFdtSyZXjwd23l0rgBq
	 KwitEBIvRHOhzLvIubCJbpLJ1Oh1hDSmmBSOg6DMCW3xuyAuu1PfIZXKX+p8TBOlIVLnI6z/uWiZA
	 BLGQa5RMF/4qBGUIZJHF3vKGbSnP1CHfUqO6p6hbMxeFyp3djE6SyG23n6H7IIkcbXqpgp/n2zGyX
	 CSm8Y2+bLzij19n+LvRGR5GrnLK3U7I6blTB81jpzuBJxkyg=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>
Cc: "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?U2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcg==?=" <bigeasy@linutronix.de>, "=?utf-8?B?Q2xhcmsgV2lsbGlhbXM=?=" <clrkwllms@kernel.org>, "=?utf-8?B?U3RldmVuIFJvc3RlZHQ=?=" <rostedt@goodmis.org>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
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
Date: Tue, 13 Oct 2026 21:06:21 +0800
X-Priority: 3
Message-ID: <tencent_F9D491A400474428BFE7262F1A1799A88407@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_5802EE88434010229EDF7A53084D994C6106@qq.com>
	<20261013-hissing-saiga-of-endeavor-ef5e03-mkl@pengutronix.de>
In-Reply-To: <20261013-hissing-saiga-of-endeavor-ef5e03-mkl@pengutronix.de>
X-QQ-mid: xmsezb41-0t1791896781t2k02as9b

SGkgTWFyYywKCj4gQUZBSUNTIHRoaXMgaXMgYSBzeXN0ZW1hdGljIHByb2JsZW0gYW5kIHNo
b3VsZCBJTUhPIG5vdCB3b3JrZWQgYXJvdW5kIGluCj4gb25lIGRyaXZlciBvbmx5LgoKQWdy
ZWVkLiBJIGluaXRpYWxseSBvbmx5IG5vdGljZWQgdGhlIHByb2JsZW0gaW4gdGhlIFJvY2tj
aGlwIENBTi1GRApkcml2ZXIgYW5kIGRpZCBub3QgY29uc2lkZXIgdGhlIGNvbW1vbiBDQU4g
Y29kZS4KCj4gbmV0aWZfcnVubmluZygpIHRlc3RzIF9fTElOS19TVEFURV9TVEFSVCwgd2hp
Y2ggaXMgcmVtb3ZlZCBpbgo+IF9fZGV2X2Nsb3NlX21hbnkoKSBwcmlvciB0byBjYWxsaW5n
IHRoZSBkcml2ZXIncyBuZG9fc3RvcCgpLgo+Cj4gQ2FuIHdlIG1ha2UgdXNlIG9mIG5ldGlm
X3J1bm5pbmcoKSBwcmlvciB0byBjYWxsaW5nIGRvX3NldF9tb2RlKGRldiwKPiBDQU5fTU9E
RV9TVEFSVCk/IGZyb20gY2FuX3Jlc3RhcnQoKT8KCklmIHlvdSBoYXZlIG5vIG9iamVjdGlv
bnMsIEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIHB1dCB0aGUKbmV0aWZfcnVubmlu
ZygpIGNoZWNrIGFmdGVyIHRoZSBleGlzdGluZyAhcHJpdi0+ZG9fc2V0X21vZGUgY2hlY2sg
YW5kCmJlZm9yZSBuZXRpZl9jYXJyaWVyX29rKCk6CgogICAgICAgIGlmICghcHJpdi0+ZG9f
c2V0X21vZGUpCiAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7CgogICAgICAg
IGlmICghbmV0aWZfcnVubmluZyhkZXYpKQogICAgICAgICAgICAgICAgcmV0dXJuIC1FTkVU
RE9XTjsKClRoaXMgd291bGQgcHJlc2VydmUgdGhlIGV4aXN0aW5nIGVycm9yIHByZWNlZGVu
Y2UgZm9yIGRldmljZXMgdGhhdCBkbwpub3Qgc3VwcG9ydCByZXN0YXJ0LgoKPiBjYW5fYnVz
X29mZigpIHNob3VsZCBub3Qgc2NoZWR1bGVfZGVsYXllZF93b3JrKCkgaWYgIW5ldGlmX3J1
bm5pbmcoKS4KCkFncmVlZC4gQWx0aG91Z2ggdGhpcyB3b3VsZCBjaGFuZ2UgdGhlIGJlaGF2
aW9yIG9mIHNvbWUgZHJpdmVycywgSSB0aGluawppdCBzaG91bGQgaGVscCBpbXByb3ZlIHN0
YWJpbGl0eS4KCj4gV2Ugc3RpbGwgaGF2ZSB0byBjYWxsIGNhbmNlbF9kZWxheWVkX3dvcmtf
c3luYygmcHJpdi0+Y2FuLnJlc3RhcnRfd29yaykKPiBmcm9tIGVhY2ggZHJpdmVyLCB0aG91
Z2guCgpJIGNhbiBtYWtlIGNoYW5nZXMgdG8gdGhlIG90aGVyIGRyaXZlcnMuIEhvd2V2ZXIs
IEkgZG8gbm90IGhhdmUgdGhlCmNvcnJlc3BvbmRpbmcgaGFyZHdhcmUgYW5kIHdvdWxkIG5v
dCBiZSBhYmxlIHRvIHRlc3QgdGhlIGNoYW5nZXMgb24KcmVhbCBkZXZpY2VzLCBzbyBJIGFt
IGNvbmNlcm5lZCBhYm91dCB0aGUgcmlzay4gSSB3b3VsZCBsaWtlIHRvIGNvbmZpcm06CmRv
IEkgbmVlZCB0byBhdWRpdCBhbmQgZml4IHRoZSByZXN0YXJ0IGJlaGF2aW9yIG9mIGV2ZXJ5
IENBTiBkZXZpY2UKZHJpdmVyPwoKPiBXaGF0IGRvIHlvdSB0aGluaz8KCkkgd2lsbCBhZGRy
ZXNzIHRoZXNlIGNvbW1lbnRzIGluIHYyLiBUaGFua3MgZm9yIHlvdXIgcmV2aWV3LgoKUmVn
YXJkcywKQ3VuaGFvIEx1Cg==

