Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F036F8EE;
	Thu,  8 Oct 2026 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791430312; cv=none; b=CoBiw5EfQFF4Br7XhXgXQPJawGsDycBqt96PpRS5rOi5ZRP3XB+JuiPw8MmKsjJDK/AEFxomNzsrYDr4c/wF9mZtDOn/zx+ZZ7hZVj2TLPlrXBh7s2G2857S6XyAS3QnRGCRH7UGQClYgVKYraZegbcWwGafXFIEfUiNCOmGS68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791430312; c=relaxed/simple;
	bh=rRI2gizuOkmzDt3UCHT/ENcaMAQoOw3qqbRu6ckEfz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=bbJaBpn6eaYIu5vl//QYq3i96h0aiIcqS1mrDATVPGuroDBmcer+JR7rCD1qPy8KLxMe5VjU1sYXzS9rLzgMB5/elr/wtGYz93QvfzfCZo/QgI5nAemuEmKimepFocaqCZhEmgVJNZFIOZikuHpCmUGwvEA/nuVGZOU+7O1r1jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V7gFcyOY; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V7gFcyOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=rRI2gizuOkmzDt3UCHT/ENcaMAQoOw3qqbRu6ckEfz8=; b=V
	7gFcyOY6EVQ2wgR5l+PqYHAG+j77FsRXhEvhlbhksRWHsDLjl/LfXAAT90SqS68F
	LLPky08R+i3u9mK6M4N7DNwtQDyzpSvFqVbDOdLGi8u6D1q91MpNhOmG1cbVgtS0
	M5J9Kdu60hSzZppemIuqt2e0mDkFLBu7U84jlR20mI=
Received: from taozj888$163.com ( [2409:8a20:22c3:d7b0:cce8:b35f:dfc7:fd77]
 ) by ajax-webmail-wmsvr-40-118 (Coremail) ; Thu, 8 Oct 2026 11:30:24 +0800
 (CST)
Date: Thu, 8 Oct 2026 11:30:24 +0800 (CST)
From: taozj888  <taozj888@163.com>
To: =?GBK?Q?Th=A8=A6o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: stable@vger.kernel.org, "Conor Dooley" <conor.dooley@microchip.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, "Jeff Garzik" <jeff@garzik.org>,
	"Haavard Skinnemoen" <hskinnemoen@atmel.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list" <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH net v4] net: macb: rate limit netdev error info print
 in the data path
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <DLYI3O7PFN94.V7VH3HSLKEMD@bootlin.com>
References: <20261007053211.572073-1-taozj888@163.com>
 <DLYI3O7PFN94.V7VH3HSLKEMD@bootlin.com>
X-NTES-SC: AL_Qu2SA/iYv0op4iKeY+kfm04bju07UMu2v/4l2Y9SOp9wjDDp5gA9U11FN3vbyviEOzq8qyWnYgl32+5QQatlb5MJzNhTQU+YBErd1idYAWYRfA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <63731290.3f0c.1a1198fe993.Coremail.taozj888@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:digvCgD3_y5QDsdq_blTAA--.1610W
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC3hAk62rHDlAehwAA3r
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKSGkgVGhlbzoKCgpQbGVhc2Ugc2VlIG15IGNvbW1lbnRzIGlubGluZS4KCgpUaGFua3Ms
CgoKWmlqaW4gVGFvCgoKCgoKQXQgMjAyNi0xMC0wNyAxNzozMzowMywgIlRoqKZvIExlYnJ1biIg
PHRoZW8ubGVicnVuQGJvb3RsaW4uY29tPiB3cm90ZToKPkhlbGxvIHRhb3pqODg4LAo+Cj5JIHdh
cyByZXZpZXdpbmcgeW91ciBwYXRjaCBidXQgeW91IHNlbnQgVjQgYXQgdGhlIHNhbWUgdGltZSEK
Pgo+T24gV2VkIE9jdCA3LCAyMDI2IGF0IDc6MzIgQU0gQ0VTVCwgIHdyb3RlOgo+PiBGcm9tOiB0
YW96aWppbiA8dGFvemo4ODhAMTYzLmNvbT4KPgo+V2UgbmVlZCBmdWxsIG5hbWVzIGluIGtlcm5l
bCBwYXRjaGVzLCB5b3UgaGF2ZSB0aGF0IGluIHlvdXIKPlNpZ25lZC1vZmYtYnkuCj4KPj4gTm93
IHRoZSBNQUNCIGV0aGVybmV0IGRyaXZlciBwcmludCB0aGUgbmV0ZGV2IGVycm9yIGluZm9ybWF0
aW9uCj4+IGRpcmVjdGx5IGJ5IG5ldGRldl9lcnIoKSwgd2hpY2ggd291bGQgbGVhZCB0byBhIGxh
cmdlIG51bWJlciBvZgo+PiBlcnJvciBpbmZvcm1hdGlvbiBwcmludCBpZiB0aGVyZSB3YXMgYSBz
aWduaWZpY2FudCBudW1iZXIgb2YKPj4gZXJyb3Igb3IganVzdCBqdW1ibyBwYWNrZXRzIGV4Y2Vl
ZGluZyB0aGUgTVRVIHJlY2VpdmVkIHdoZW4gYm9vdGluZy4KPj4gRm9yIGV4YW1wbGUsIGl0IHdv
dWxkIHByaW50IGEgbGFyZ2UgbnVtYmVyIG9mOgo+Pgo+PiBtYWNiIFBIWVQwMDM2OjAwIGV0aDA6
IG5vdCB3aG9sZSBmcmFtZSBwb2ludGVkIGJ5IGRlc2NyaXB0b3IKPj4gbWFjYiBQSFlUMDAzNjow
MCBldGgwOiBub3Qgd2hvbGUgZnJhbWUgcG9pbnRlZCBieSBkZXNjcmlwdG9yCj4+IC4uLgo+Pgo+
PiBpbiBnZW1fcngoKSBieSByZWNlaXZlZCBhIGxhcmdlIG51bWJlciBvZiBwYWNrZXRzIHdpdGhv
dXQKPj4gUlhfRU9GIGZsYWcgc2V0LCBlc3BlY2lhbGx5IHdpdGggdW5rbm93biBwYWNrZXQKPj4g
dHlwZSB0aGF0IHdvdWxkIHBlbmV0cmF0ZSB0aGUgaGFyZHdhcmUgb2ZmbG9hZCBmb3IgdGhlIElQ
IHBhY2tldHMuCj4+Cj4+IFRoZSB1bmxpbWl0ZWQgcHJpbnRzIGhlcmUgd291bGQgZ3JlYXRseSBi
b3RoZXIgYW5kIGRlbGF5Cj4+IHRoZSBzeXN0ZW0gYm9vdGluZyBwcm9jZXNzIHVubGVzcyB0aGUg
c291cmNlIHN0b3Agc2VuZGluZwo+PiBwYWNrZXRzIHNpbmNlIHRoZXkgb2NjdXB5IHRoZSBjb25z
b2xlIG91dHB1dCBiYW5kd2lkdGggYW5kCj4+IG90aGVyIHByb2Nlc3NlcyBoYXZlIHRvIHdhaXQg
Zm9yIHRoZSBjb21wbGV0aW9uIG9mIHByaW50aW5nIHRob3NlCj4+IG1lc3NhZ2VzLgo+Pgo+PiBT
byByYXRlIGxpbWl0IHRoZSBuZXRkZXYgZXJyb3IgaW5mb3JtYXRpb24gcHJpbnQgaW4gdGhlIHJl
Y2VpdmUKPj4gYW5kIHRyYW5zbWl0IGRhdGEgcGF0aC4KPj4KPj4gRml4ZXM6IDg5ZTU3ODVmYzhh
NiAoIltQQVRDSF0gQXRtZWwgTUFDQiBldGhlcm5ldCBkcml2ZXIiKQo+PiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZwo+Cj5XaGF0IGhhcHBlbmVkPyBUaGlzIGRvZXNuJ3QgbWF0Y2ggeW91ciBk
aXNjdXNzaW9uIHdpdGggTmljb2xhaS4KCj5odHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYv
M2UxNTE1ZTE2MmQwODRlMjIwMGVlYWE2MDc0YmZiYWZAdGlwaS1uZXQuZGUvCgoKQFRoZW8sIGlu
IHRoZSBsaW5rIHRoYXQgeW91IHByb3ZpZGVkLCBOaWNvbGFpIHN1Z2dlc3RlZCB0byB1c2UgdGhl
IGNvbW1pdCBpZCAKIjRkZjk1MTMxZWE4MCIsIGFuZCB0aGUgb3JpZ2luYWwgdGV4dCBpcyBxdW90
ZWQgYmVsb3c6CiIKCj4+Pj4gRml4ZXM6IDg5ZTU3ODVmYzhhNiAoIltQQVRDSF0gQXRtZWwgTUFD
QiBldGhlcm5ldCBkcml2ZXIiKQo+Pj4gCj4+PiBJTUhPIHRoZSBjb3JyZWN0IHRhZyBpcyA0ZGY5
NTEzMWVhODAgKCJuZXQvbWFjYjogY2hhbmdlIFJYIHBhdGggZm9yCj4+PiBHRU0iKT8KPj4+IEF0
IGxlYXN0IHRoZSBnZW1fcngoKSBtZXNzYWdlcyB3ZXJlIGludHJvZHVjZWQgaGVyZS4KPj4gCj4+
IFRoZSBwYXRjaCB1c2VkIHRvIHRvdWNoIG1hY2Jfc3RhcnRfeG1pdCgpLCB3aGljaCBleHBsYWlu
cyB3aHkgSSB0b2xkCj4+IFppamluIHRvIHRhcmdldCB0aGUgaW5pdGlhbCBjb21taXQgb24gcHJl
dmlvdXMgcmV2aXNpb24uCj4+IAo+IE9LLCBJIHdpbGwgc3RpbGwgdXNlIHRoZSBpbml0aWFsIGNv
bW1pdCBpbmRpY2F0ZWQgYnkgVGhlby4KClBsZWFzZSByZS1yZWFkIFRoqKZvJ3MgcmVwbHk6IGhl
IG9ubHkgc3VnZ2VzdGVkIHRoZSBpbml0aWFsCmJlY2F1c2UgdjEgYWxzbyB0b3VjaGVkIG1hY2Jf
c3RhcnRfeG1pdCgpLiB2MiBkb2Vzbid0IGFueW1vcmUsCjg5ZTU3ODVmYzhhNiBpcyBubyBsb25n
ZXIgdGhlIHJpZ2h0IHRhcmdldC4gUGxlYXNlIHVzZToKCkZpeGVzOiA0ZGY5NTEzMWVhODAgKCJu
ZXQvbWFjYjogY2hhbmdlIFJYIHBhdGggZm9yIEdFTSIpCiIKU28gSSBjaGFuZ2VkIHRoZSBjb21t
aXQgaWQgZnJvbSAiODllNTc4NWZjOGE2IiB0byAiNGRmOTUxMzFlYTgwIgppbiB0aGUgdjQgcGF0
Y2gsIGFuZCBzb21lYm9keSBzdWdnZXN0ZWQgdG8gc2V0IHRoZSBjaGFuZ2Vsb2cganVzdAppbiB0
aGUgcGF0Y2ggYmVsb3cgaXRzICItLS0iIHBhcnQgaWYgdGhlcmUgaXMgb25seSBqdXN0IDEgcGF0
Y2gsIGJ1dApub3QgaW4gdGhlIGNvdmVyLWxldHRlciwgc28gSSBhZGRlZCB0aGUgY2hhbmdsb2cg
aW4gdGhlIHY0IHBhdGNoLgoKCklmIHlvdSBkaWRuJ3QgYWdyZWUgdGhlIGNoYW5nZXMgaW4gdGhl
IHY0IHBhdGNoIEkgd291bGQgbGlrZSB0byBqdXN0IGFiYW5kb24KaXQsIG9yIEkgd2lsbCBzZW5k
IGEgdjUgcGF0Y2ggdG8gcmVzdG9yZSB0byB0aGUgY29udGVudHMgb2YgdGhlIHYzIHBhdGNoIHdp
dGgKdGhlIGNoYW5nZWxvZyBhZGRlZCBpbiB0aGUgcGF0Y2ggaXRzZWxmLgoKCkZvciB0aGUgYXV0
b3JzaGlwLCBJIHdvdWxkIGxpa2UgdG8gdXNlIHRoZSAiWmlqaW4gVGFvIDx0YW96ajg4OEAxNjMu
Y29tPiIgZm9yIGFsbApwYXJ0cyBpbiB0aGUgcGF0Y2ggKGZvciB0aGUgc2lnbmVkLW9mZi1ieSBh
bmQgRnJvbSkuCgo+Cj5UTERSLCBiZWNhdXNlIHRob3NlIHRocmVhZHMgYXJlIGEgbWVzczoKPiAt
IHdoeSBkcm9wIHN0YXJ0X3htaXQgZGlmZj8KPiAtIGZpeCB5b3VyIHBhdGNoIGF1dG9yc2hpcAo+
IC0gY2hlY2sgeW91ciBjaGFuZ2Vsb2chCj4gLSBjaGVjayB5b3VyIGZpeGVzIQo+Cj5UaGFua3Ms
Cj4KPi0tCj5UaKimbyBMZWJydW4sIEJvb3RsaW4KPkVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwg
ZW5naW5lZXJpbmcKPmh0dHBzOi8vYm9vdGxpbi5jb20K
