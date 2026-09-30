Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74C78F3A;
	Wed, 30 Sep 2026 01:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733315; cv=none; b=UJYmogtzIJgOQPqmxtEvkLfLKgXARmHRy2sKrwO6yLzqWOVzVTuVxOhf0ucoG7cclWRdyvAUprQbm/TuKMLU6WlSXiZWPvv65QkIBGcwUhj3+0tUBTqQGlw0YG3Cb5L94PLA5Csy1XET7OJMfkEF9SVWgBkbQWZ4Z4m6WIMktw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733315; c=relaxed/simple;
	bh=ALEbsJltOkykfd6BXNzzWhlmAYuW9n9nkjjO2PKULX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=oLF8ql8Ybt+hITpY2x93Spu9g4wPBHHATk1rdjJdxe04sq3GOEmArjp1QLSEkEClQc6FdPgF+rm6t6DX+RfYy1hDi3GB+KnpV944iEM3+iNcUXs43J+9NI7QTnOwV4hDOpYPWSnHcdRW/tUoljnnfhlrYYAS0MFlJkKNVgy3jHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JBPae0KO; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JBPae0KO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ALEbsJltOkykfd6BXNzzWhlmAYuW9n9nkjjO2PKULX4=; b=J
	BPae0KO32wEDNzRUqiM03x4zjHSqjEBAt988tx7zqrsYPViVc00kjIQslbiQfYgQ
	m00MnPV3W36ZfVfB4h4ODHxJSEu04TvyWClpbj4fzgh6rHY3fV6SNsQgPo9QVwW4
	MA1eVuhKzCRiJyV9tB3pV6convlQAUdIQ27fBPehrc=
Date: Wed, 30 Sep 2026 09:53:59 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Sergey Shtylyov" <s.shtylyov@omp.ru>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Paul Barker" <paul@pbarker.dev>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Mitsuhiro Kimura" <mitsuhiro.kimura.kc@renesas.com>,
	"Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re:Re: [PATCH v2 6/7] net: ravb: fix resource teardown ordering
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <3b43b4fb-8479-4eb2-be58-1df6f0f747b9@omp.ru>
References: <20260927144741.1320558-1-yaojiale02@163.com>
 <20260927144741.1320558-7-yaojiale02@163.com>
 <3b43b4fb-8479-4eb2-be58-1df6f0f747b9@omp.ru>
X-NTES-SC: AL_Qu2SAvuYvEoo7yaYZOkdnEkQgO0/WsS1vfQu2Y5Wc+8GoB7n+ToEZnBvNlr04eWOBi+JjBKMXilN6cVecJZ2eEB1MuQwr0ubnaC2dOtXcA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <12190bf2.18c1.1a0f004c539.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kygvCgD3FwK3a7xqAetQAA--.481W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRfRDGq8a7eSJAAA37
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgU2VyZ2V5LAoKVGhhbmtzIGZvciB5b3VyIHJldmlldy4KWW91J3JlIHJpZ2h0IOKAlCBJJ2xs
IHNwbGl0IHRoaXMgaW50byB0d28gcGF0Y2hlczoKT25lIHBhdGNoIGZvciB0aGUgSVJRL25ldGRl
diBvcmRlcmluZyBpc3N1ZS4KT25lIHBhdGNoIGZvciB0aGUgcnVudGltZSBQTSByZXN1bWUgZmFp
bHVyZSBoYW5kbGluZy4KSSdsbCB1c2UgLS1uby1naXQtZmFsbGJhY2sgbmV4dCB0aW1lLCBzb3Jy
eSBmb3IgdGhpcy4KCkF0IDIwMjYtMDktMzAgMDM6MDc6NTIsICJTZXJnZXkgU2h0eWx5b3YiIDxz
LnNodHlseW92QG9tcC5ydT4gd3JvdGU6Cj5IZWxsbyEKPgo+ICAgSSBndWVzcyB5b3UgdXNlZCBz
Y3JpcHRzL2dldF9tYWludGFpbmVyLnBsIC0tIGlmIHNvLCBJIHN1Z2dlc3QgdGhhdAo+eW91IGFk
ZCAtLW5vLWdpdC1mYWxsYmFjayBuZXh0IHRpbWUuIFlvdXIgY3VycmVudCBUbzogbGlzdCBpcyBw
YWluZnVsbHkKPmxvbmcgYW5kIGNvbnRhaW5zIHNvbWUgbG9uZyBkZWZ1bmN0IGFkZHJlc3NlcyAo
bGlrZSBtaW5lKS4uLgo+Cj5PbiA5LzI3LzI2IDU6NDcgUE0sIEppYWxlIFlhbyB3cm90ZToKPgo+
PiByYXZiX3JlbW92ZSgpIGZyZWVzIHRoZSBuZXRkZXYgYmVmb3JlIGRldnJlcyByZWxlYXNlcyB0
aGUgbWFuYWdlZCBJUlFzLgo+PiBUaGUgaGFuZGxlcnMgdXNlIHRoZSBuZXRkZXYgYXMgdGhlaXIg
ZGF0YSBwb2ludGVyLCBzbyBhbiBpbnRlcnJ1cHQgZHVyaW5nCj4+IHRoYXQgd2luZG93IGNhbiBh
Y2Nlc3MgZnJlZWQgbWVtb3J5LiBQcm9iZSBlcnJvciBwYXRocyBoYXZlIHRoZSBzYW1lCj4+IG9y
ZGVyaW5nIHByb2JsZW0uCj4+IAo+PiBUaGUgcmVtb3ZlIGNhbGxiYWNrIGFsc28gcmV0dXJucyB3
aGVuIHJ1bnRpbWUgcmVzdW1lIGZhaWxzLiBUaGF0IGxlYXZlcwo+PiB0aGUgbmV0ZGV2IHJlZ2lz
dGVyZWQgd2hpbGUgdGhlIGRyaXZlciBjb3JlIHN0aWxsIHJlbGVhc2VzIGl0cyBtYW5hZ2VkCj4+
IHJlc291cmNlcy4gQSBydW5uaW5nIGludGVyZmFjZSBhbHJlYWR5IGhvbGRzIGEgcnVudGltZSBQ
TSByZWZlcmVuY2UsIHNvCj4+IHRoZSBleHRyYSBnZXQgY2Fubm90IGludm9rZSBhIGZhaWxpbmcg
cmVzdW1lLiBBIHJlc3VtZSBmYWlsdXJlIHRoZXJlZm9yZQo+PiBvY2N1cnMgd2hpbGUgdGhlIGlu
dGVyZmFjZSBpcyBkb3duIGFuZCBuZG9fc3RvcCgpIHdpbGwgbm90IGJlIGNhbGxlZC4KPgo+ICAg
U2VlbXMgbGlrZSBhIHNlcGFyYXRlIHByb2JsZW0/Cj4KPj4gUGxhY2UgdGhlIElSUSByZXNvdXJj
ZXMgaW4gYSBkZWRpY2F0ZWQgZGV2cmVzIGdyb3VwIGFuZCByZWxlYXNlIGl0IGJlZm9yZQo+PiBm
cmVlaW5nIHRoZSBuZXRkZXYuIENvbnRpbnVlIHVucmVnaXN0ZXJpbmcgYW5kIGZyZWVpbmcgc29m
dHdhcmUgcmVzb3VyY2VzCj4+IHdoZW4gcnVudGltZSByZXN1bWUgZmFpbHMsIGJ1dCBza2lwIHRo
ZSB1bm1hdGNoZWQgcnVudGltZSBQTSBwdXQuCj4+IAo+PiBGaXhlczogYzE1NjYzM2YxMzUzICgi
UmVuZXNhcyBFdGhlcm5ldCBBVkIgZHJpdmVyIHByb3BlciIpCj4+IEZpeGVzOiA0OGY4OTRhYjA3
YzQgKCJuZXQ6IHJhdmI6IEFkZCBydW50aW1lIFBNIHN1cHBvcnQiKQo+PiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZwo+PiBTaWduZWQtb2ZmLWJ5OiBKaWFsZSBZYW8gPHlhb2ppYWxlMDJAMTYz
LmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9yZW5lc2FzL3JhdmJfbWFpbi5j
IHwgMjMgKysrKysrKysrKysrKysrKystLS0tLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L3JlbmVzYXMvcmF2Yl9tYWluLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZW5l
c2FzL3JhdmJfbWFpbi5jCj4+IGluZGV4IGVhMWM3ZTUzNjc5MS4uYTI1ZjVhYzcwNjJmIDEwMDY0
NAo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZW5lc2FzL3JhdmJfbWFpbi5jCj4+ICsr
KyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlbmVzYXMvcmF2Yl9tYWluLmMKPlsuLi5dPiBAQCAt
MzEyNCw2ICszMTMxLDggQEAgc3RhdGljIGludCByYXZiX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpCj4+ICAgICAgICAgcG1fcnVudGltZV9kaXNhYmxlKCZwZGV2LT5kZXYpOwo+
PiAgICAgICAgIHBtX3J1bnRpbWVfZG9udF91c2VfYXV0b3N1c3BlbmQoJnBkZXYtPmRldik7Cj4+
ICAgICAgICAgY2xrX3VucHJlcGFyZShwcml2LT5yZWZjbGspOwo+PiArb3V0X3JlbGVhc2VfaXJx
czoKPgo+ICAgU29tZXdoYXQgdW5vYnZpb3VzIGxhYmVsIG5hbWUsIGdpdmVuIHRoZSBmb2xsb3dp
bmcgY2FsbC4uLgo+Cj4+ICsgICAgICAgZGV2cmVzX3JlbGVhc2VfZ3JvdXAoJnBkZXYtPmRldiwg
cHJpdik7Cj4+ICBvdXRfcmVzZXRfYXNzZXJ0Ogo+PiAgICAgICAgIHJlc2V0X2NvbnRyb2xfYXNz
ZXJ0KHJzdGMpOwo+PiAgb3V0X2ZyZWVfbmV0ZGV2Ogo+PiBAQCAtMzE0MSw5ICszMTUwLDEwIEBA
IHN0YXRpYyB2b2lkIHJhdmJfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+
IAo+PiAgICAgICAgIGVycm9yID0gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldChkZXYpOwo+PiAg
ICAgICAgIGlmIChlcnJvciA8IDApCj4+IC0gICAgICAgICAgICAgICByZXR1cm47Cj4+ICsgICAg
ICAgICAgICAgICBkZXZfd2FybihkZXYsICJmYWlsZWQgdG8gcmVzdW1lIGRldmljZTogJWRcbiIs
IGVycm9yKTsKPj4gCj4+ICAgICAgICAgdW5yZWdpc3Rlcl9uZXRkZXYobmRldik7Cj4+ICsgICAg
ICAgZGV2cmVzX3JlbGVhc2VfZ3JvdXAoZGV2LCBwcml2KTsKPj4gICAgICAgICBpZiAoaW5mby0+
bmNfcXVldWVzKQo+PiAgICAgICAgICAgICAgICAgbmV0aWZfbmFwaV9kZWwoJnByaXYtPm5hcGlb
UkFWQl9OQ10pOwo+PiAgICAgICAgIG5ldGlmX25hcGlfZGVsKCZwcml2LT5uYXBpW1JBVkJfQkVd
KTsKPj4gQEAgLTMxNTMsNyArMzE2Myw4IEBAIHN0YXRpYyB2b2lkIHJhdmJfcmVtb3ZlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+ICAgICAgICAgZG1hX2ZyZWVfY29oZXJlbnQobmRl
di0+ZGV2LnBhcmVudCwgcHJpdi0+ZGVzY19iYXRfc2l6ZSwgcHJpdi0+ZGVzY19iYXQsCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcHJpdi0+ZGVzY19iYXRfZG1hKTsKPj4gCj4+IC0gICAg
ICAgcG1fcnVudGltZV9wdXRfc3luY19zdXNwZW5kKCZwZGV2LT5kZXYpOwo+PiArICAgICAgIGlm
IChlcnJvciA+PSAwKQo+PiArICAgICAgICAgICAgICAgcG1fcnVudGltZV9wdXRfc3luY19zdXNw
ZW5kKCZwZGV2LT5kZXYpOwo+Cj4gICBIbSwgZGVmaW5pdGVseSBzZWVtcyBsaWtlIGEgbWF0ZXJp
YWwgZm9yIGEgc2VwYXJhdGUgcGF0Y2guLi4KPgo+Wy4uLl0KPgo+TUJSLCBTZXJnZXkKSmlhbGUK

