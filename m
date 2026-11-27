Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795746772;
	b=OfE6lYXzh1e+bEUu95ekKhg/tRWwpf6Ng//ayCbG9kfS80jZspwZN8j/v2m8QRhTAd2V
	 PdZIq4fcfdo3mYFhu0pcuihPbEmvD4z0NI2LfeBaXsd4uHyvbOhW3Xu/bsR33xqnTWXFU
	 T3NFxZmdSgvg7MJmDLmemF9MVQ/WhCdai7WRvSpjRJt/JxeP2TddcEkD9aZFmCU/sRpVJ
	 jk5zhqpMcVGpYq+vts+JUgHKWggEGC3peYYWeQjhp0e7vvNP0lrV1EXcWnwynwS6ojLSj
	 QwFbq1cxTlECXB1AfkbOoSr09DNs/x7ByMhkRk54ony/NHMsVFGMeg3Nr6hlbN9fSWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795746772;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=c+oGnDJwwxehyRrrXPLIjZAd481WLEPRKxHASXZGKfA=;
	b=laJCQ0iPzls8pi07URnSg5e7sWcJp+9sMAQklAtX5r9gm3kxPH06/XIuHghKQL7Zkf9f
	 LJmV7iz4n3HNDlCHMhC20nM+NCdXE05A9iIyQ22Sjshi7JttuKFdpjJPT9xkCO1VRjw1w
	 8iGJDqZFuA/sy7wLDWPG1Ng9yyhX/d36fx2erlCK9YtJ6O4RxWWt6A4EocW0v+bpBNy3v
	 7D2uuQNcaC5fG2mOegZwNUcOMWAUNdDh61hpFQUe72D7n9sdJ1qar7/VxIRRZyn7v0qXz
	 bpwJar8GsenX45pOYGyiaq5/UAafQEo9vOX8H3HSNKHuqOAOEj5G9xoO4SRh/22I6Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Ua9oaYWn;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5654606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5654606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Ua9oaYWn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795746766; bh=c+oGnDJwwxehyRrrXPLIjZAd481WLEPRKxHASXZGKfA=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=Ua9oaYWnO1m3cnr+lfiBvUVmM4dk2MidPPHFE1GORLksrtjQZ16qzxsXszc4RlfC/
	 N7lZutA2NAIB5LdrAVoeuMAvXAzzp45GlCxKE3KX7Xjj2ymXiaPe+9dU/9d5PY+UBH
	 YSwcoEzbN4roTCl8FyxkJXpMnW4j/FJM+ZM9EO+4=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-XMAILINFO: MMrWIrR84bVnl6F4Kn48QrsLzYD8r4M8GGan8Rst9arNRZCimojC4c4Uhi1/is
	 NPSfAfMIqtcaz0NjCgYx2piTvnoDFtNS0t3Vo8NBC3AuCtEroVh39CqQcdlCCgk/eNlOAAxPIYVkr
	 8N13zz1BdL4fhmM0eGZf4T21QhMKDbKuTRTR1mtiYIVe2O4pAoa6JpM1wmFckfJc81EnS1ovMsr5h
	 6ZZq/ugm4KpccTZfChcPS1haH5MU/i6ka/aHxOpiKJW5MdptG2vmtemLTYP0fzbe5P0aYjdjvlDaF
	 kPpGwfiv7faTJtE09ebMUDAr4vDtNDpFxFnKFD5/LUojdHWI1GamE4LHp2ga+Eb6CKzimOXakYPGU
	 zsP3hA7mNM+yhJGNpACpuRLYw1Zl3O3d05q77XuY/zjbhfMUZkuFc56PKZqQSYdnZ4l5lp2FvcxTp
	 GUIaJWeSkl+iXawcwMChW3zPOBDrS5SCEipAx5ob7rNkdvxNTc16zrVnbaDSwiNYJyYVMweWRv727
	 QrVi4pk1mWshqXlhWbgPSNmtPs5vD+wyjK43rbby/HFbH6E3vLIx0lm80dcgzFCqRk7M2eb2+JDLt
	 Qyvf6K/N4++WPXg2xORehvEcGyMcnMZOUlMV/OhpmBmh8fbDp00d8wL/nUt/w7qZQjr/2CIJUkba2
	 SUMz/+a990rdeKVv9FITrdHzW05opb4KaeSd8cWOvdpT9LFLQImmS9N6zZdNAbj67LAfEk75oFb4k
	 /CXg8MdmYAoPYCTqpGe6525M08FJptjXXXHlSZ3m6W052HVGeEYyWLcBU3LEXPiYBZ6ShMEEIrm3B
	 z1uOU/8E6Y9cEyeI50qenAYTOAjWlIPFzNp08JAIHjIC2MPz9lbd0uMkluYZW3AEiJ7G6OBlprip4
	 xiJKxtwXa/c9oAKXHEV1rhnYbixyIEFRwANVmGiJ9phiOYBicXVNMXTCkopnqnqdvy6ynNepCgEKm
	 JZA9SYOklThkm5qqEBYh54Qg1cZNZbeKjSpL0+4ONVgTyQmv7Hkz7NIRoeCXa/Rj+DWbRsHUvX+hM
	 U3eN/k0sJ4otjwI8=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?U2ViYXN0aWFuIFJlaWNoZWw=?=" <sebastian.reichel@collabora.com>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?Q2hyaXMgTW9yZ2Fu?=" <macromorgan@hotmail.com>
Cc: "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?a2VybmVs?=" <kernel@collabora.com>, "=?utf-8?B?U2ViYXN0aWFuIFJlaWNoZWw=?=" <sebastian.reichel@collabora.com>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH 02/11] arm64: dts: rockchip: Fix USBDP ports for LubanCat 5IO board
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 27 Nov 2026 10:32:44 +0800
X-Priority: 3
Message-ID: <tencent_4909B12347019988CD7E8B4D3A345432CA08@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261126-rockchip-usb-c-dp-altmode-v1-0-7991eb5bb426@collabora.com>
	<20261126-rockchip-usb-c-dp-altmode-v1-2-7991eb5bb426@collabora.com>
In-Reply-To: <20261126-rockchip-usb-c-dp-altmode-v1-2-7991eb5bb426@collabora.com>
X-QQ-mid: xmsezb41-0t1795746764t45j0irwa

SGksCgo+IEZpeMKgdGhlwqBVU0JEUMKgUEhZwqBwb3J0c8KgZGVzY3JpcHRpb27CoGZvcsKg
dGhlwqBMdWJhbkNhdMKgNUlPLMKgc2/CoHRoYXTCoGl0Cj4gZm9sbG93c8KgdGhlwqBkb2N1
bWVudGVkwqBBQkkuwqBUaGXCoGN1cnJlbnTCoGJpbmRpbmfCoGNvbmZ1c2VzwqBlbmRwb2lu
dHPCoHdpdGgKPiBwb3J0c8KgYW5kwqBtYWtlc8Kgbm/CoHNlbnNlwqBhdMKgYWxsLgo+IAo+
IENjOsKgc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+IEZpeGVzOsKgZjdiNTc2ZjM1MzU2wqAo
ImFybTY0OsKgZHRzOsKgcm9ja2NoaXA6wqBBZGTCoEx1YmFuQ2F0wqA1SU/CoGJvYXJkIikK
PiBTaWduZWQtb2ZmLWJ5OsKgU2ViYXN0aWFuwqBSZWljaGVswqA8c2ViYXN0aWFuLnJlaWNo
ZWxAY29sbGFib3JhLmNvbT4KClRoYW5rcyBmb3IgZml4aW5nIHRoaXMuCgpJIGJhY2twb3J0
ZWQgdGhpcyBwYXRjaCBhbmQgcGF0Y2ggMS8xMSAoImFybTY0OiBkdHM6IHJvY2tjaGlwOiBG
aXgKVVNCLUMgRFAgQWx0TW9kZSB2ZG8iKS4gSSB0ZXN0ZWQgdGhlbSBvbiBteSBMdWJhbkNh
dCA1SU8gd2l0aCBBcm1iaWFuCmtlcm5lbHMgNi4xOC42MCBhbmQgNy40LXJjNC4KCk9uIDYu
MTguNjAsIHRoZSBVU0JEUCBQSFkgc2NoZW1hIHJlamVjdHMgdGhlIHBvcnRzIG5vZGUuIEkg
Z290IHZpZGVvCm92ZXIgVVNCLUMgd2l0aCBib3RoIHRoZSBiYXNlbGluZSBhbmQgcGF0Y2hl
ZCBEVEJzLgoKTXkgNy40LXJjNCBidWlsZCBpbmNsdWRlcyB0aGUgdGhyZWUgZHJpdmVyIHNl
cmllcyBsaXN0ZWQgaW4gdGhlIGNvdmVyCmxldHRlci4gV2l0aCB0aGUgYmFzZWxpbmUgRFRC
LCBEVy1EUCBmYWlsZWQgdG8gZmluZCBpdHMgZm9sbG93LXVwCmJyaWRnZSwgc28gRFAtMSBk
aWQgbm90IHJlZ2lzdGVyLiBXaXRoIGJvdGggcGF0Y2hlcyBhcHBsaWVkLCBEUC0xCnJlZ2lz
dGVyZWQgYW5kIEkgZ290IHZpZGVvIGF0IDI1NjB4MTQ0MCBhdCA2MCBIei4KCkZlZWwgZnJl
ZSB0byBhZGQgbXkgVGVzdGVkLWJ5IHRhZyBpZiB1c2VmdWwuCgpUZXN0ZWQtYnk6IEN1bmhh
byBMdSA8MTU3OTU2NzU0MEBxcS5jb20+CgpCZXN0IHJlZ2FyZHMsCkN1bmhhbyBMdQ==

