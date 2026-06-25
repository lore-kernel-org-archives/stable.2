Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E768A3BB4A;
	Thu, 25 Jun 2026 05:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364709; cv=none; b=D5LKFHH2D5wwVyBF6DVQYGsuDkBJQhHNxxeNTPVKvXv2yjrheKF3TQ5bi56vnz3YUAz1qMl58S2tLA74oXkIGmPkrNrUf3AYKyj/D7PeOo6u7dncyyoNoMabZXGzVaFbsVSjV9XqbUs3kfEvd+rfYYqK0kZbTXHL633hYEzz6uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364709; c=relaxed/simple;
	bh=afAJe646dpCo+BLlH+iFnf5H0cWnJaU+tgNuHlFT67c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TB7b5KJIAxr2XfwycvvFpGagZnlE3qgFFf20RSfhdN/h957ZkMLeFL2AyBszWclj0HT1m8Tv90H6jjCeYoBk8reRr4q/ViwKKAOldgKm01WW8ti6Yw/E2vDIh8EIKkXnS03FdS98Npj83U1R9YgmaEvM7lCSxhCRAudyQhkc2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=Qhy6g2H0; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="Qhy6g2H0"
From: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>
To: Philipp Reisner <philipp.reisner@linbit.com>
CC: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>, Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?utf-8?B?Q2hyaXN0b3BoIELDtmhtd2FsZGVy?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>, Andreas Gruenbacher <agruen@linbit.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] drbd: Fix potential NULL pointer dereference in
 _drbd_set_state()
Thread-Topic: [PATCH] drbd: Fix potential NULL pointer dereference in
 _drbd_set_state()
Thread-Index: AQHdBF/o8AC8bC0OUUmJsIphGb6N3g==
Date: Thu, 25 Jun 2026 05:03:06 +0000
Message-ID: <20260625050016.12004-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 6/24/2026 10:04:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=afAJe646dpCo+BLlH+iFnf5H0cWnJaU+tgNuHlFT67c=;
 b=Qhy6g2H0akYEnv/YdYOQNZJ3bqI6vzY5GEBdK/unMORx25+dluuQFAi1FCZrebjPLHikiSiqwu3g
	av/VU0S9aS8oOUMCM7r5yDQH0Ga3T0FpvsXmJB2M9E1CCgz+QLYpQsMQYoS0M2pND83eJ9hEgzXz
	S6iXtgLw/bPwlahZxQjBliaaNbb/jkoMh24IsPCQAPNruNeGjBLpCAvyLZGWYU8Xx5AUDWF8Onwu
	erJ+Iv4sk+rGmQQ07THTywWIWtu8Rx2C8ajUBzmwtTDjl2QDSq0aWDABL1y5a6a5iT2pQVfUiH5h
	zHryP/ZJN6FpfzgJSk3ZdVTMuPcn753d5Lz1Aw==

RnJvbTogQW5kcmV5IFZhdG9yb3BpbiA8YS52YXRvcm9waW5AY3JwdC5ydT4NCg0KVGhlIGNvbm5l
Y3Rpb24gcG9pbnRlciByZWNlaXZlcyBhIHZhbHVlIGluIHRoZSBfZHJiZF9zZXRfc3RhdGUoKQ0K
ZnVuY3Rpb24sIGluY2x1ZGluZyB0aHJvdWdoIGEgY2FsbCB0byB0aGUgZmlyc3RfcGVlcl9kZXZp
Y2UoKSBmdW5jdGlvbi4NClRoaXMgZnVuY3Rpb24gcmV0dXJucyBhIHBvaW50ZXIgdG8gYSBsaXN0
IGVsZW1lbnQuIElmIHRoZSBsaXN0IGlzIGVtcHR5LCBpdA0KcmV0dXJucyBhIE5VTEwgcG9pbnRl
ciwgd2hpY2ggaXMgbGF0ZXIgYXNzaWduZWQgdG8gdGhlIGNvbm5lY3Rpb24NCnBvaW50ZXIuIFN1
YnNlcXVlbnRseSwgdGhpcyBwb2ludGVyIHdpbGwgYmUgZGVyZWZlcmVuY2VkLg0KDQpBZGQgYSBO
VUxMIGNoZWNrIGZvciB0aGUgY29ubmVjdGlvbiBwb2ludGVyIHRvIGF2b2lkIGRlcmVmZXJlbmNp
bmcgYW4NCmludmFsaWQgcG9pbnRlci4NCg0KRm91bmQgYnkgTGludXggVmVyaWZpY2F0aW9uIENl
bnRlciAobGludXh0ZXN0aW5nLm9yZykgd2l0aCBTVkFDRS4NCiAgICAgICANCkZpeGVzOiBhNmIz
MmJjM2NlYmQgKCJkcmJkOiBJbnRyb2R1Y2UgInBlZXJfZGV2aWNlIiBvYmplY3QgYmV0d2VlbiAi
ZGV2aWNlIiBhbmQgImNvbm5lY3Rpb24iIikNCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQpT
aWduZWQtb2ZmLWJ5OiBBbmRyZXkgVmF0b3JvcGluIDxhLnZhdG9yb3BpbkBjcnB0LnJ1Pg0KLS0t
DQogZHJpdmVycy9ibG9jay9kcmJkL2RyYmRfc3RhdGUuYyB8IDUgKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL2RyYmQv
ZHJiZF9zdGF0ZS5jIGIvZHJpdmVycy9ibG9jay9kcmJkL2RyYmRfc3RhdGUuYw0KaW5kZXggYWRj
YmE3ZjFkOGVhLi5lYTk4MmQ0ODAxN2UgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Jsb2NrL2RyYmQv
ZHJiZF9zdGF0ZS5jDQorKysgYi9kcml2ZXJzL2Jsb2NrL2RyYmQvZHJiZF9zdGF0ZS5jDQpAQCAt
MTI4MSw2ICsxMjgxLDExIEBAIF9kcmJkX3NldF9zdGF0ZShzdHJ1Y3QgZHJiZF9kZXZpY2UgKmRl
dmljZSwgdW5pb24gZHJiZF9zdGF0ZSBucywNCiAJaWYgKHJ2IDwgU1NfU1VDQ0VTUykNCiAJCXJl
dHVybiBydjsNCiANCisJaWYgKCFjb25uZWN0aW9uKSB7DQorCQlkcmJkX2VycihkZXZpY2UsICJO
byBjb25uZWN0aW9uIHRvIHBlZXIsIGFib3J0aW5nIVxuIik7DQorCQlyZXR1cm4gU1NfQUxSRUFE
WV9TVEFOREFMT05FOw0KKwl9DQorDQogCWlmICghKGZsYWdzICYgQ1NfSEFSRCkpIHsNCiAJCS8q
ICBwcmUtc3RhdGUtY2hhbmdlIGNoZWNrcyA7IG9ubHkgbG9vayBhdCBucyAgKi8NCiAJCS8qIFNl
ZSBkcmJkX3N0YXRlX3N3X2Vycm9ycyBpbiBkcmJkX3N0cmluZ3MuYyAqLw0KLS0gDQoyLjQzLjAN
Cg==
