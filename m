Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FAD2E8DEC;
	Thu,  6 Aug 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029358; cv=none; b=D8/wvg0twN++OVJTyPjn5v5z4hb+Yfe6Jiz+MmRTOYsBmHUXedi9mjTHopfG0U75z2dNaPK8vAB/P+DF/386KBGphm2og+1sk0dSx/T2OzEzfIAej6pmVvZC+OTGWuSr60LWwUDB2/NQEagJKlmt25tbsTgh1PNryeaAZnPUh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029358; c=relaxed/simple;
	bh=+eJEFpnllSO8zHDXDIqlhW8ag09h63LSwuAt5SudmBQ=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=GI8qGX92wxS+ZzrJAv7csVIBGZnsoToUlwqUr2U6dJyjEQNmLdEL8t7YE6jiS6Be/1phQPtK5BKc5np/RyCWj60TUfghEkC9NBE6bDG99rKqyvDrNmcfQNNXn+ufkWiwUHFHu5M2JePJlxJdXhf1IFVE3KZJud2LBEV/04d3CFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=f1vqnIqY; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="f1vqnIqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1786029338;
	bh=+eJEFpnllSO8zHDXDIqlhW8ag09h63LSwuAt5SudmBQ=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=f1vqnIqYUYT5W0vbRxXf4SOXqyf407txCCeFFe2eYgUaZZ92cHJhC5QHC6DllxCl+
	 iDxkhUOKU4kUujvaFXS/Ly5OvTyoea3Tbtv1QL+M747BGeitCzV0aAtcALH2d3iWXc
	 Omjdd0iboYNZnbRyVvCaXkXcEOIwbrsoZH0Mxo0M=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: M0f4gPTjDW7PNCQ2Rm8rV5rY4AXoQNmDGS5GisLzjORpTzTv5JKsNaPTBrolqN
	 fCCe/+xPv21nKITp9kqkKgIiAxyuwoj5BXNpKz1meONCI9WwgmLF9R1hwrSOTRyhYP/oEKvsZzFoz
	 ykILYv1Gb+s5xTc4Sz/7OqUjiAWG2QGOhYtvRFW+nZz/IMZVZzSrMP3GBO2uTDkS9l6VYGmaDdY+2
	 Sclajy80UBfKMNPk9l6o10D7CAkhU61DyTAE6qT6EGuM1SECBqHt4bab8mnHL2GYjLjMw+2O1ho7z
	 TBmIrX8MDiq/dri2MuoCVXWjDCHiuY8ZF6yhc7JUVt95uNcPGu/DIIfk/EGgqZrSlJqF+Sh7uxOZ3
	 MB8RrEfhhyzqY36z0Szhc9z/aIn8ysVsAlqgHK5pqLSsTfxcQxP4CXRSpwzZLsz7G4mIKXYHTUEjV
	 EK0XFwgOz1nmBTiXMEOV2byHbQu9aBwFAk3sXdOwF3ROWSc5X5up1mC6uo2/Smj5Iry12DzDdZru2
	 kOsCGycLj85mldeq0FAWwZv4m93iOPbkqfutj1+YiePpHzqoBsK5+9M2eiT1Ore+wVLahPs8wd82g
	 PClKf7Irxj/VKtWQ2j8voOm9lAG+Lc9unSf3RHrVPYGPy0enW7XR/t+G/9eLzIFGH369so0mxj0qM
	 de+2LUTqfuYA1W7y3v7piBU4TJOtgYi52n4f3aQW2csYcSD5x99TrLCYm/cQGPOWPPB66uDFK4qtd
	 u6X8CZcdKJvbATRG4LED/TaiZmMKOORZny5KMOauWgh5pcTGQ2V/j+AcwNcbHVE6cclJC9zZfGsoD
	 vMwcIF9SuLG//IfWr38QXsnRNYJu7wmnXb2jtyk5omsxPRF+3td93iTHJHm5ZjAHtz47AoREwPjq4
	 Qx93WsRAKmK/VBow4HWCNXqbWgmBLmu2tQaTA1C/0GHWx9FqIcRvw9X7BfGD4jFxISRQ7qDaeEPHb
	 5qUH9IRjF7Es23u/DIGS3wk7aDLUCTvKHAFszgit8HN/Hm8IpwFB8fO1mOl0I+kzjwd6Ex7Ecu+S6
	 ID8rqOC9uiVh13rlT58r0dMkziIWyJ5LuCeEBv9+pQpg/sh/CD9UqdrGtWQBfdu4HrYWyJ5oN1pZC
	 ebGs1BAzTBf6MGb9XAhUJpNBnCb5Wd9lCgo=
From: "=?utf-8?B?U2hlbiBZb25nY2hhbw==?=" <grayhat@foxmail.com>
To: "=?utf-8?B?UGFvbG8gQm9uemluaQ==?=" <pbonzini@redhat.com>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?a3Zt?=" <kvm@vger.kernel.org>
Cc: "=?utf-8?B?c2Vhbmpj?=" <seanjc@google.com>, "=?utf-8?B?cGdvbmRh?=" <pgonda@google.com>, "=?utf-8?B?dGhvbWFzLmxlbmRhY2t5?=" <thomas.lendacky@amd.com>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: [PATCH] KVM: SVM: Serialize accesses to the owner and mirror list with separate lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 6 Aug 2026 23:15:36 +0800
X-Priority: 3
Message-ID: <tencent_D374826654C6729D46D938E8F23A96A80E09@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260806145115.2441519-1-pbonzini@redhat.com>
In-Reply-To: <20260806145115.2441519-1-pbonzini@redhat.com>
X-QQ-mid: xmsezc57-0t1786029336tic0yqs44

T24gOC82LzI2IDE2OjUxLCBQYW9sbyBCb256aW5pIHdyb3RlOgo+IFRoZSBzZWNvbmQgaXNz
dWUgbmVlZHMgcGFydGljdWxhciBjYXJlIGJlY2F1c2UgdGhlIG93bmVyIGNvdWxkIGRpc2Fw
cGVhcgo+IGFsdG9nZXRoZXIgKGV2ZW4gdGhvdWdoIHRoZSByYWNlIHdpbmRvdyBpcyBpbXBv
c3NpYmx5IHNtYWxsKSBiZXR3ZWVuCj4gcmVhZGluZyBpdCBhbmQgbG9ja2luZyBpdC4gIFRo
ZXJlIGlzIHRodXMgbm8gd2F5IHRvIHBlcmZvcm0gdGhlIGNoZWNrcwo+IHVuZGVyIHRoZSBv
d25lciBsb2NrIHdpdGhvdXQgcHV0dGluZyBzdHJ1Y3Qga3ZtIHVuZGVyIFNMQUJfVFlQRVNB
RkVfQllfUkNVCj4gKHdoaWNoIHdvdWxkIGFsbG93IGt2bV9nZXRfa3ZtX3NhZmUoKSB1bmRl
ciBSQ1UgY3JpdGljYWwgc2VjdGlvbikuCj4KPiBJdCBpcyBtdWNoIHNpbXBsZXIgdG8ganVz
dCB1c2UgYSBnbG9iYWwgbG9jaywgc2luY2UgdGhlIGNyaXRpY2FsCj4gc2VjdGlvbnMgYXJl
IHNvIHNtYWxsIGFuZCB0aGUgbmV3IGxvY2sgaXMgYWx3YXlzIGEgbGVhZiBsb2NrLgoKWWVz
IOKAlCB0aGUgcmUtY2hlY2sgY291bGQgbmV2ZXIgcnVuIGJlZm9yZSB0aGUgVUFGIGl0c2Vs
Ziwgc28gYSBzaW5nbGUKbGVhZiBsb2NrIGlzIGNsZWFuZXIuICBBbGwgd3JpdGVycyBub3cg
c2VyaWFsaXplIG9uIHNldl9taXJyb3JfbG9jaywKY2xvc2luZyBib3RoIGlzc3Vlcy4KCj4g
KwltdXRleF9sb2NrKCZzZXZfbWlycm9yX2xvY2spOwo+ICsJb3duZXJfa3ZtID0gc2V2LT5l
bmNfY29udGV4dF9vd25lcjsKPiArCWxpc3RfZGVsKCZzZXYtPm1pcnJvcl9lbnRyeSk7Cj4g
KwlzZXYtPmVuY19jb250ZXh0X293bmVyID0gTlVMTDsKPiArCW11dGV4X3VubG9jaygmc2V2
X21pcnJvcl9sb2NrKTsKPiArCWt2bV9wdXRfa3ZtKG93bmVyX2t2bSk7CgpLZWVwaW5nIHRo
ZSBwdXQgb3V0c2lkZSB0aGUgbG9jayBhbHNvIGF2b2lkcyByZS1lbnRlcmluZwpzZXZfdm1f
ZGVzdHJveSgpIHdoZW4gdGhlIG1pcnJvciBob2xkcyB0aGUgbGFzdCByZWZlcmVuY2UuICBM
b29rcyBnb29kLgoKVGhhbmtzIGZvciBmaXhpbmcgdGhpcyBwcm9wZXJseS4KU2hlbg==

