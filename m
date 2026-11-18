Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985601;
	b=ekLl7WF8fa7ptOw1IYYaiCJwKzyaSVqCT1Vd/IbvOX2EHo8LidbOlSVZ7OQkINd4hHFh
	 hVNgPNpjnTJm5uyO/wLIGPlbRfgen/rFRCdze7hS0PuJT9g8R4l0BX6wz2f7vG+GRn5rO
	 4umnKcyLqnBu6+I/78suItc6V9RDeUBRUlUcGjZAERB01zWCD1634KDxDpkfcvoTV8CJu
	 yM/+88P7gZu3K0VFPsXE0gbhmQ4Y2bEdZPifFUEOfLURhk75b0kkVALDSgl6LGvBqkS2p
	 fQIs9KG6GNpWdDoLkgJiDLM1EdudmTx24CgrMpGsz8+lEtBiPR5tWxVOlzYnAPrPtNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985601;
	h=DMARC-Filter:DKIM-Signature:Received:X-Originating-IP:Date:From:To:
	 Cc:Subject:X-Priority:X-Mailer:In-Reply-To:References:X-NTES-SC:
	 Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	 X-Coremail-Locale:X-CM-TRANSID:X-CM-SenderInfo:X-Coremail-Antispam;
	bh=7a5lXFvPsBDZAImUeJ6tcNN7UAtc71dfHH1Iy2GAhpU=;
	b=S6vyAduz6caiR/zb1BNB6zNH3Sqsqs5Gd/wF7nDsW0p31kdzCymdhE/h0jvqfZyTWSFj
	 ebNLucjBsD57VwhFltMca4R2HUyXvA8hFMqFtFX+EkCQBKHjdSmimxtlh8VsYjYdY7qP+
	 cvj9iAQArUwVZepgH4Daz8kSCBKyvoA22eprSGx9MStunzqpK58Oj3o/TmWSsiCDsMem3
	 7hh7Pm/WjcRIWUjSAOfg2y2jCDVqZjoPn6Llxv/RfDxb5R/VFop1hVsmRTu9WNsHcATwR
	 NmLzUQa/Ip87LWlLexjD7hZRstE2RL9/+MuHpqVB/ve1flZvY90CDv/ju1vpYY8KtFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Pjgv2f8g;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D915606A31C;
	Wed, 18 Nov 2026 07:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D915606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Pjgv2f8g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=7a5lXFvPsBDZAImUeJ6tcNN7UAtc71dfHH1Iy2GAhpU=; b=P
	jgv2f8gAwy70rOOtBIIf5a46S2XeRACO0FBhbtygIsilrK5+JCOtdCPzGceEeSMK
	upR6/cZtzB5mpv5vU97EuedjQP/6IuaYYtwwecFPkuYDuSh22ZBywx1y5lDDDF+F
	J6ZWJxbXG+OHSlpBcpyCLnkH3hqiBQ6ySj8sJCXeC4=
Received: from slark_xiao$163.com (
 [2408:8459:3880:89f9:65c7:4764:991d:9666] ) by ajax-webmail-wmsvr-40-146
 (Coremail) ; Wed, 18 Nov 2026 15:05:10 +0800 (CST)
Date: Wed, 18 Nov 2026 15:05:10 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Jeff Hugo" <jeff.hugo@oss.qualcomm.com>
Cc: mani@kernel.org, bbhatt@codeaurora.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re:Re: [PATCH] bus: mhi: host: Only expose controller sysfs
 attributes on the controller device
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <826c1746-137b-4a5a-968e-8e0449a25e78@oss.qualcomm.com>
References: <20261111115659.11943-1-slark_xiao@163.com>
 <826c1746-137b-4a5a-968e-8e0449a25e78@oss.qualcomm.com>
X-NTES-SC: AL_Qu2SBvWTuk0q5iCZZekckk4WhuY7WcOyuPkg2YZSc+0GhQfN9RgFWW9qEEPv1s6mMgqVsxKTWz1W7MZEc4x8BB/DMi3foBslU0mB4Bw+Og==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <3cb75687.54e4.1a1ed794488.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kigvCgDnLwYmTv1qQ5twAA--.1499W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC6Aa2G2r9TiZqdwAA3h
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjYtMTEtMTQgMDI6NDI6NDYsICJKZWZmIEh1Z28iIDxqZWZmLmh1Z29Ab3NzLnF1YWxj
b21tLmNvbT4gd3JvdGU6Cj5PbiAxMS8xMS8yMDI2IDQ6NTYgQU0sIFNsYXJrIFhpYW8gd3JvdGU6
Cj4+IFRoZSBzZXJpYWxfbnVtYmVyLCBvZW1fcGtfaGFzaCBhbmQgc29jX3Jlc2V0IGF0dHJpYnV0
ZXMgYXJlIHJlZ2lzdGVyZWQKPj4gdGhyb3VnaCBtaGlfYnVzX3R5cGUuZGV2X2dyb3Vwcywgc28g
dGhlIGRyaXZlciBjb3JlIGNyZWF0ZXMgdGhlbSBmb3IKPj4gZXZlcnkgZGV2aWNlIG9uIHRoZSBN
SEkgYnVzLiAgTUhJIGNsaWVudCBkZXZpY2VzICh0aGUgcGVyLWNoYW5uZWwKPj4gZGV2aWNlcyBz
dWNoIGFzIG1oaTBfRFVOIG9yIG1oaTBfTUJJTSkgYXJlIGFsc28gTUhJIGJ1cyBkZXZpY2VzLCBz
bwo+PiBlYWNoIG9mIHRoZW0gZW5kcyB1cCB3aXRoIGl0cyBvd24gY29waWVzIG9mIHRoZXNlIGZp
bGVzIGV2ZW4gdGhvdWdoCj4+IHRoZXkgYWxsIG9wZXJhdGUgb24gdGhlIHNhbWUgbWhpX2NvbnRy
b2xsZXI6Cj4+IAo+PiAgICAkIGxzIC9zeXMvYnVzL21oaS9kZXZpY2VzL21oaTBfRFVOLwo+PiAg
ICBkcml2ZXIgIG9lbV9wa19oYXNoICBwb3dlciAgc2VyaWFsX251bWJlciAgc29jX3Jlc2V0ICBz
dWJzeXN0ZW0gIHVldmVudAo+PiAKPj4gVGhpcyBpcyB3cm9uZyBmb3Igc2V2ZXJhbCByZWFzb25z
Ogo+PiAKPj4gICAgLSBUaGUgYXR0cmlidXRlcyBkZXNjcmliZSB0aGUgY29udHJvbGxlciwgbm90
IHRoZSBjaGFubmVsLiAgVGhlaXIKPj4gICAgICBjYWxsYmFja3MgYWxsIGRlcmVmZXJlbmNlIG1o
aV9kZXYtPm1oaV9jbnRybCBhbmQgcmVhZCBCSEkgcmVnaXN0ZXJzCj4+ICAgICAgb3IgaXNzdWUg
YSBjb250cm9sbGVyLXdpZGUgU29DIHJlc2V0LCBzbyB3cml0aW5nIHNvY19yZXNldCB0aHJvdWdo
Cj4+ICAgICAgbWhpMF9EVU4gcmVzZXRzIHRoZSB3aG9sZSBkZXZpY2Ugd2hpbGUgbG9va2luZyBs
aWtlIGEgcGVyLWNoYW5uZWwKPj4gICAgICBvcGVyYXRpb24uCj4+ICAgIC0gb2VtX3BrX2hhc2gg
cmVwb3J0cyBmYWlsdXJlcyB3aXRoIGRldl9lcnIoZGV2LCAuLi4pLCBzbyBhIHNpbmdsZQo+PiAg
ICAgIGZhaWxpbmcgY29udHJvbGxlciBwcm9kdWNlcyBvbmUgbG9nIGxpbmUgcGVyIHJlZ2lzdGVy
ZWQgY2hhbm5lbAo+PiAgICAgIGRldmljZSBpbnN0ZWFkIG9mIG9uZS4KPj4gICAgLSBVc2Vyc3Bh
Y2UgaGFzIG5vIHdheSB0byB0ZWxsIHdoaWNoIGNvcHkgaXMgYXV0aG9yaXRhdGl2ZS4KPj4gCj4+
IE1vdmUgdGhlIGF0dHJpYnV0ZXMgb2ZmIHRoZSBidXMgYW5kIGF0dGFjaCB0aGVtIHRvIHRoZSBj
b250cm9sbGVyCj4+IGRldmljZSBvbmx5LiAgbWhpX3JlZ2lzdGVyX2NvbnRyb2xsZXIoKSBub3cg
aW5zdGFsbHMgdGhlIGdyb3VwIHZpYQo+PiBtaGlfZGV2LT5kZXYuZ3JvdXBzIGJlZm9yZSBkZXZp
Y2VfYWRkKCksIHdoaWxlIHRoZSBjaGFubmVsIGRldmljZXMKPj4gY3JlYXRlZCBieSBtaGlfY3Jl
YXRlX2RldmljZXMoKSBhcmUgbGVmdCB1bnRvdWNoZWQuICBObyBmdW5jdGlvbmFsCj4+IGNoYW5n
ZSBmb3IgdGhlIGNvbnRyb2xsZXIgZGV2aWNlOyB0aGUgZmlsZXMgc3RheSBhdCB0aGUgcGF0aHMg
bGlzdGVkCj4+IGluIERvY3VtZW50YXRpb24vQUJJL3N0YWJsZS9zeXNmcy1idXMtbWhpLgo+PiAK
Pj4gTm90ZSB0aGF0IHRyaWdnZXJfZWRsIHdhcyBhbHJlYWR5IGhhbmRsZWQgdGhpcyB3YXksIHRo
cm91Z2ggYW4gZXhwbGljaXQKPj4gc3lzZnNfY3JlYXRlX2ZpbGUoKSBvbiB0aGUgY29udHJvbGxl
ciBrb2JqZWN0LCB3aGljaCBpcyB3aHkgaXQgbmV2ZXIKPj4gYXBwZWFyZWQgb24gdGhlIGNoYW5u
ZWwgZGV2aWNlcy4KPkkgYWdyZWUgd2l0aCB0aGUgcmF0aW9uYWxlLCBidXQgdGhpcyBkb2VzIGFw
cGVhciB0byBjaGFuZ2UgdUFQSS4gQXJlIHlvdSAKPnN1cmUgbm8gb25lIGlzIHVzaW5nIHRoZXNl
IG9uIHRoZSBjaGFubmVsIGRldmljZXM/Cj4KPi1KZWZmCkhpIEplZmYsCkZvciBvZW1fcGtfaGFz
aCBhbmQgc2VyaWFsX251bWJlciwgYWxsIGludGVyZmFjZSByZXR1cm5zIHNhbWUgdmFsdWUuCkkg
dGhpbmsgdGhlcmUgaXMgbm8gbmVlZCB0byBrZWVwIHRoZXNlIGludGVyZmFjZXMgdW5kZXIgdGhl
IGNoYW5uZWwgCmRldmljZXMuIAoKRm9yIHNvY19yZXNldCwgaXQgd3JpdGUgdGhlIHJlZ2lzdGVy
IGRpcmVjdGx5IGFuZCBpdCB3b3JrcyBmb3IgdGhlIGVudGlyZQpkZXZpY2UgcmF0aGVyIHRoYW4g
YSBzaW5nbGUgY2hhbm5lbC4KClNvIEkgdGhpbmsgdGhlcmUgaXMgbm8gcHJvYmxlbSB0byByZW1v
dmUgdGhlbS4KQWRkaXRpb25hbGx5LCBJIHJlcG9ydGVkIHRoaXMgdG8gTWFuaSBhIGxvbmcgdGlt
ZSBhZ28sIGFuZCBoZSBjb25maXJtZWQKdGhhdCBpdCB3YXMgaW5kZWVkIGEgYnVnLgoKMjAyNC83
LzI0OgpTbGFyazogSGkgTWFuaSwgZG8geW91IHRoaW5rIGlmIGl0J3MgYSBidWc/IFRoZSBzb2Nf
cmVzZXQgYW5kIG90aGVyCmF0dHIgd291bGQgYmUgZW51bWVyYXRlZCBib3RoIHRoZSBtaGkwIGFu
ZCBvdGhlciBtaGkwX1BPUlQKTWFuaTogR29zaCwgeWVzIApUaGV5IGJlbG9uZyB0byB0aGUgY29u
dHJvbGxlcgpDYW4geW91IHNlbmQgYSBwYXRjaD8gRWxzZSBJJ2xsIGZpeCBpdAoKVGhhbmtzIAo=

