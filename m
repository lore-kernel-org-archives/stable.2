Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C222F0C74;
	Thu, 20 Aug 2026 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787198711; cv=none; b=VRHUuQemc9zS+toMcXBtyxEmpH+wav7R+scOz1tw/sFg8IynDSAnicu6QZO98KVQvNAqzzgWaOHMTJyB3pi7CcLZjz6ccY+moWD7QbLw8Fh4gQzAkJ1H/Ueib7vunaWl4mz2JDwXlr4erO6NFhiXnDnCSNfcgonbphDfXsNN/iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787198711; c=relaxed/simple;
	bh=IncoSXmiVEgh1NOXkvOrRs+CKvgnr4mEUn5Wgd8xDO8=;
	h=Content-Type:MIME-Version:From:To:CC:Subject:Date:Message-ID; b=KDWRdSnBSnIBXanP22A24TEb9JUTODjPZUr80qMf/aKzlX8SxMVCFfGoIwmXepiHQFtu7vWnxbPqngvP/EA6E51lYHB3QmMhgUQj95o4gklJR3Xyd1fTO5+qbJA4J1soUj0aJtG5IU3y6whxEXO7fkyuMHaBZVDzEEOT1f2SdOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=longcheer.com; spf=pass smtp.mailfrom=longcheer.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=longcheer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=longcheer.com
Received: from mailsrv01.LongCheer.net
        by unicom145.biz-email.net ((D)) with ESMTP (SSL) id 202608201203457171;
        Thu, 20 Aug 2026 12:03:45 +0800
Received: from [127.0.1.1] (172.16.9.238) by mailsrv01.LongCheer.net
 (172.16.8.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.33; Thu, 20 Aug
 2026 12:03:45 +0800
Content-Type: multipart/mixed;
	boundary="===============0251864241573272842=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: liuqi <liuqi@longcheer.com>
To: <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] usb-storage: prevent concurrent URB submission in usb_stor_msg_common
Date: Thu, 20 Aug 2026 12:03:45 +0800
Message-ID: <870f2627-aeaa-400e-9b6d-ee77eac42be6@mailsrv01.LongCheer.net>
X-ClientProxiedBy: mailsrv01.LongCheer.net (172.16.8.231) To
 mailsrv01.LongCheer.net (172.16.8.231)
tUid: 20268201203451a44a568158615ebba493432f5cb11cd
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

--===============0251864241573272842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

RnJvbSAwNTRlZDU1YWFhMGQ4MGVkYzkzZDI1ZTQ3NTBkNjdlOTA2NGJiNzdmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBsaXVxaSA8bGl1cWlAbG9uZ2NoZWVyLmNvbT4KRGF0ZTogVGh1
LCAyMCBBdWcgMjAyNiAxMToyODo0MyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHVzYi1zdG9yYWdl
OiBwcmV2ZW50IGNvbmN1cnJlbnQgVVJCIHN1Ym1pc3Npb24gaW4KIHVzYl9zdG9yX21zZ19jb21t
b24KCnVzYl9zdG9yX21zZ19jb21tb24oKSBvbmx5IGNoZWNrcyB0aGUgQUJPUlRJTkcgZmxhZyBi
ZWZvcmUgc3VibWl0dGluZwp0aGUgVVJCLCBidXQgZG9lcyBub3QgZ3VhcmQgYWdhaW5zdCBjb25j
dXJyZW50IHN1Ym1pc3Npb25zIHdoZW4gYQpwcmV2aW91cyBVUkIgaXMgc3RpbGwgaW4tZmxpZ2h0
IChlLmcuLCBmcm9tIGEgQlVMS19NQVhfTFVOIHByb2JlCnJ1bm5pbmcgaW4gc2Nhbl9kd29yayB3
aGlsZSBzY3NpX2VoIGFsc28gaW52b2tlcyB0aGUgc2FtZSBmdW5jdGlvbikuCgpUaGlzIGxlYWRz
IHRvICJVUkIgc3VibWl0dGVkIHdoaWxlIGFjdGl2ZSIgd2FybmluZ3MgYW5kIC1FSU5QUk9HUkVT
UwpyZXR1cm5zIHdoZW4gdXNiX3N1Ym1pdF91cmIoKSBkZXRlY3RzIGFuIGFscmVhZHktcXVldWVk
L2luLWZsaWdodCBVUkIuCgpGaXggYnkgdXNpbmcgdGVzdF9hbmRfc2V0X2JpdCgpIG9uIFVTX0ZM
SURYX1VSQl9BQ1RJVkUgdG8gbXV0dWFsbHkKZXhjbHVkZSBjb25jdXJyZW50IHN1Ym1pc3Npb25z
LiBJZiBhIFVSQiBpcyBhbHJlYWR5IGFjdGl2ZSwgcmV0dXJuCi1FQUdBSU4gdG8gdGhlIGNhbGxl
ci4KClJlcG9ydGVkLWJ5OiBzeXpib3QrMjJlYTIwZWYzYWZiNjc4NWIxMjJAc3l6a2FsbGVyLmFw
cHNwb3RtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBsaXVxaSA8bGl1cWlAbG9uZ2NoZWVyLmNvbT4K
LS0tCiBkcml2ZXJzL3VzYi9zdG9yYWdlL3RyYW5zcG9ydC5jIHwgMTAgKysrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9z
dG9yYWdlL3RyYW5zcG9ydC5jIGIvZHJpdmVycy91c2Ivc3RvcmFnZS90cmFuc3BvcnQuYwppbmRl
eCBmNzliNDQ5ZDAuLmZmYjE0NTlkMCAxMDA2NDQKLS0tIGEvZHJpdmVycy91c2Ivc3RvcmFnZS90
cmFuc3BvcnQuYworKysgYi9kcml2ZXJzL3VzYi9zdG9yYWdlL3RyYW5zcG9ydC5jCkBAIC0xMjIs
NiArMTIyLDE2IEBAIHN0YXRpYyBpbnQgdXNiX3N0b3JfbXNnX2NvbW1vbihzdHJ1Y3QgdXNfZGF0
YSAqdXMsIGludCB0aW1lb3V0KQogCWlmICh0ZXN0X2JpdChVU19GTElEWF9BQk9SVElORywgJnVz
LT5kZmxhZ3MpKQogCQlyZXR1cm4gLUVJTzsKIAorCS8qCisJICogUHJldmVudCBjb25jdXJyZW50
IHN1Ym1pc3Npb25zIG9mIHRoZSBzYW1lIFVSQi4KKwkgKiBJZiBhIFVSQiBpcyBhbHJlYWR5IGlu
LWZsaWdodCAoZS5nLiwgZnJvbSBhIHByZXZpb3VzCisJICogQlVMS19NQVhfTFVOIHByb2JlIHJ1
bm5pbmcgaW4gc2Nhbl9kd29yayB3aGlsZSBzY3NpX2VoCisJICogYWxzbyBpbnZva2VzIHRoZSBz
YW1lIGZ1bmN0aW9uKSwgcmVqZWN0IG5ldyBzdWJtaXNzaW9ucy4KKwkgKi8KKwlpZiAodGVzdF9h
bmRfc2V0X2JpdChVU19GTElEWF9VUkJfQUNUSVZFLCAmdXMtPmRmbGFncykpCisJCXJldHVybiAt
RUFHQUlOOworCisKIAkvKiBzZXQgdXAgZGF0YSBzdHJ1Y3R1cmVzIGZvciB0aGUgd2FrZXVwIHN5
c3RlbSAqLwogCWluaXRfY29tcGxldGlvbigmdXJiX2RvbmUpOwogCi0tIAoyLjQzLjAKCg==

--===============0251864241573272842==--
