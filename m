Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A66146D53
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781466831; cv=none; b=Fssg6EpkPyWb+WpamOT+hCy6tEILXgPLc3b6i7PIYtFxxGQ81hRc1CnCMtTJrM63DXGFseJeu/LAPh5hjMdojcajr/T+p4ioltwDBCSjXuvDsszaeQmFhdqjJioinGJwd2XIRY2sSqduk1c6TvCQtOQk4ealq1nziee4gE0VJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781466831; c=relaxed/simple;
	bh=qy6XB5ftcsKKrvYeQQ1x/CaoDMgoBHrsLjrbSIhuOK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nh6tJ+mC34ScSmXqyXUahU8Hr88t28ntAn9Kj6Au4lSrMst6aZIqeKdXgXlpCRs3tW1gH0SHG/jCuKfyA2Jg4+oPG3/NOIZvtSkpEnwQcPQ84iSIsFoqz34wByBt+jM1y05l9kXUh5Bg+tShUexbr9zmI32QXE9hEML41MjajVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.at; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mMbRAbw5; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mMbRAbw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781466829; x=1813002829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qy6XB5ftcsKKrvYeQQ1x/CaoDMgoBHrsLjrbSIhuOK8=;
  b=mMbRAbw5PdN+KK43rv9l2CwhxwDjH6wYr4Ymz2xX0pD2RNP/nqvQgJVd
   RykJy0+vEJU/bKVJzKWd/f0mncfl9I/4srQ+vnHfAV13hsTlQ6GG3z6+B
   A4d2EtruY285y1YnrFwB38Pksxi+7Eg69iKVLsNPHWaZ6phkukmGX1Oc/
   OzPSJ2Q61FG4EV/0j5QVNC3aqGqY/jAZlmlxS3Nem+CF2me13buWCuODw
   fvxCQdNrkGhlnfDucQDDIce9HUXaE/NSqG0r+NrEDf9jJlu9SMCnAmNlc
   gE8oBEbkEwlNkWC1IW32m0qD1GlEhpfJnTpuszv/sQigbpZKKNqf9bmVG
   g==;
X-CSE-ConnectionGUID: RzcBb7dOQY+d3KoMa4Wy4Q==
X-CSE-MsgGUID: blzlnT/cS/2e+HEIqZvDaw==
X-IronPort-AV: E=Sophos;i="6.24,205,1774310400"; 
   d="scan'208";a="21239188"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:53:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:18514]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.143:2525] with esmtp (Farcaster)
 id ce7173d4-7a96-42f6-958f-54e175b5517f; Sun, 14 Jun 2026 19:53:49 +0000 (UTC)
X-Farcaster-Flow-ID: ce7173d4-7a96-42f6-958f-54e175b5517f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 14 Jun 2026 19:53:48 +0000
Received: from bcd0741a98fd.amazon.com (10.106.100.56) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 14 Jun 2026 19:53:47 +0000
From: Michael Tautschnig <tautschn@amazon.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Michael Tautschnig <tautschn@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH] staging: vme_user: fix heap OOB in buffer_from_user and buffer_to_user
Date: Sun, 14 Jun 2026 21:53:08 +0200
Message-ID: <20260614195318.40397-1-tautschn@amazon.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhlIFNMQVZFLXBhdGggcmVhZC93cml0ZSBoZWxwZXJzIGJ1ZmZlcl90b191c2VyKCkgYW5kCmJ1
ZmZlcl9mcm9tX3VzZXIoKSBjb3B5ICdjb3VudCcgYnl0ZXMgaW50by9vdXQgb2YgdGhlIGZpeGVk
LXNpemUKa2Vybl9idWYgKFBDSV9CVUZfU0laRSA9IDB4MjAwMDAgPSAxMjggS2lCKSB3aXRob3V0
IGJvdW5kaW5nCmNvdW50IGFnYWluc3Qgc2l6ZV9idWYuCgpUaGUgY2FsbGVyIHZtZV91c2VyX3dy
aXRlKCkvdm1lX3VzZXJfcmVhZCgpIG9ubHkgY2xhbXBzIGNvdW50IHRvCnRoZSBWTUUgd2luZG93
IHNpemUgKGltYWdlX3NpemUgPSB2bWVfZ2V0X3NpemUocmVzb3VyY2UpKSwgd2hpY2gKVk1FX1NF
VF9TTEFWRSBzZXRzIGZyb20gdXNlci1zdXBwbGllZCBzbGF2ZS5zaXplIOKAlCB2YWxpZGF0ZWQK
YWdhaW5zdCB0aGUgVk1FIGFkZHJlc3Mgc3BhY2UgKHVwIHRvIFZNRV9BMzJfTUFYID0gNCBHaUIp
LCBOT1QKYWdhaW5zdCBQQ0lfQlVGX1NJWkUuICBXaGVuIHRoZSB3aW5kb3cgZXhjZWVkcyAxMjgg
S2lCLCBhCndyaXRlKCkvcmVhZCgpIGNvcGllcyBwYXN0IHRoZSBrZXJuX2J1ZiBhbGxvY2F0aW9u
LgoKRml4IGJ5IGNsYW1waW5nIGNvdW50IGFnYWluc3Qgc2l6ZV9idWYgaW4gYm90aCBidWZmZXJf
ZnJvbV91c2VyKCkKYW5kIGJ1ZmZlcl90b191c2VyKCksIHdpdGggYW4gZWFybHkgcmV0dXJuIHdo
ZW4gKnBwb3MgPj0gc2l6ZV9idWYuClRoaXMgbWlycm9ycyB0aGUgZXhpc3RpbmcgYm91bmRzIGNo
ZWNrIGluIHJlc291cmNlX2Zyb21fdXNlcigpICh0aGUKTUFTVEVSLXBhdGggaGVscGVyKS4KClRo
ZSBidWcgd2FzIGZvdW5kIGJ5IHN0YXRpYyBhbmFseXNpcyAoQ29kZVFMIHRhaW50IHRyYWNraW5n
ICsgQ0JNQwpib3VuZGVkIG1vZGVsIGNoZWNraW5nKSBhbmQgZHluYW1pY2FsbHkgY29uZmlybWVk
IHVuZGVyIEtBU0FOIHdpdGgKdGhlIHZtZV9mYWtlIGJyaWRnZToKCiAgQlVHOiBLQVNBTjogc2xh
Yi1vdXQtb2YtYm91bmRzIGluIF9jb3B5X2Zyb21fdXNlcisweDJkLzB4ODAKICBXcml0ZSBvZiBz
aXplIDI2MjE0NCBhdCBhZGRyIGZmZmY4ODgwMDQxMDAwMDAgYnkgdGFzayB0cmlnZ2VyLzY4CiAg
ICBfY29weV9mcm9tX3VzZXIrMHgyZC8weDgwCiAgICB2bWVfdXNlcl93cml0ZSsweDEzZS8weDI0
MCBbdm1lX3VzZXJdCiAgICB2ZnNfd3JpdGUrMHgxYjgvMHg3YTAKICAgIGtzeXNfd3JpdGUrMHhi
OC8weDE1MAoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogTWljaGFl
bCBUYXV0c2NobmlnIDx0YXV0c2NobkBhbWF6b24uY29tPgotLS0KIGRyaXZlcnMvc3RhZ2luZy92
bWVfdXNlci92bWVfdXNlci5jIHwgMTggKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMTggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy92bWVfdXNl
ci92bWVfdXNlci5jIGIvZHJpdmVycy9zdGFnaW5nL3ZtZV91c2VyL3ZtZV91c2VyLmMKaW5kZXgg
NTgyOWE0MTQxLi5iYWNmNmE3ZDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy92bWVfdXNl
ci92bWVfdXNlci5jCisrKyBiL2RyaXZlcnMvc3RhZ2luZy92bWVfdXNlci92bWVfdXNlci5jCkBA
IC0xNTYsNiArMTU2LDE1IEBAIHN0YXRpYyBzc2l6ZV90IGJ1ZmZlcl90b191c2VyKHVuc2lnbmVk
IGludCBtaW5vciwgY2hhciBfX3VzZXIgKmJ1ZiwKIHsKIAl2b2lkICppbWFnZV9wdHI7CiAKKwkv
KiBDbGFtcCB0byB0aGUgZml4ZWQga2Vybl9idWYgKHNpemVfYnVmKTogdGhlIFZNRSB3aW5kb3cK
KwkgKiAoaW1hZ2Vfc2l6ZSkgbWF5IGV4Y2VlZCBQQ0lfQlVGX1NJWkUsIHNvICpwcG9zICsgY291
bnQgY2FuCisJICogcnVuIHBhc3Qga2Vybl9idWYgb3RoZXJ3aXNlLgorCSAqLworCWlmICgqcHBv
cyA+PSBpbWFnZVttaW5vcl0uc2l6ZV9idWYpCisJCXJldHVybiAwOworCWlmIChjb3VudCA+IGlt
YWdlW21pbm9yXS5zaXplX2J1ZiAtICpwcG9zKQorCQljb3VudCA9IGltYWdlW21pbm9yXS5zaXpl
X2J1ZiAtICpwcG9zOworCiAJaW1hZ2VfcHRyID0gaW1hZ2VbbWlub3JdLmtlcm5fYnVmICsgKnBw
b3M7CiAJaWYgKGNvcHlfdG9fdXNlcihidWYsIGltYWdlX3B0ciwgKHVuc2lnbmVkIGxvbmcpY291
bnQpKQogCQlyZXR1cm4gLUVGQVVMVDsKQEAgLTE2OCw2ICsxNzcsMTUgQEAgc3RhdGljIHNzaXpl
X3QgYnVmZmVyX2Zyb21fdXNlcih1bnNpZ25lZCBpbnQgbWlub3IsIGNvbnN0IGNoYXIgX191c2Vy
ICpidWYsCiB7CiAJdm9pZCAqaW1hZ2VfcHRyOwogCisJLyogQ2xhbXAgdG8gdGhlIGZpeGVkIGtl
cm5fYnVmIChzaXplX2J1Zik6IHRoZSBWTUUgd2luZG93CisJICogKGltYWdlX3NpemUpIG1heSBl
eGNlZWQgUENJX0JVRl9TSVpFLCBzbyAqcHBvcyArIGNvdW50IGNhbgorCSAqIHJ1biBwYXN0IGtl
cm5fYnVmIG90aGVyd2lzZS4KKwkgKi8KKwlpZiAoKnBwb3MgPj0gaW1hZ2VbbWlub3JdLnNpemVf
YnVmKQorCQlyZXR1cm4gMDsKKwlpZiAoY291bnQgPiBpbWFnZVttaW5vcl0uc2l6ZV9idWYgLSAq
cHBvcykKKwkJY291bnQgPSBpbWFnZVttaW5vcl0uc2l6ZV9idWYgLSAqcHBvczsKKwogCWltYWdl
X3B0ciA9IGltYWdlW21pbm9yXS5rZXJuX2J1ZiArICpwcG9zOwogCWlmIChjb3B5X2Zyb21fdXNl
cihpbWFnZV9wdHIsIGJ1ZiwgKHVuc2lnbmVkIGxvbmcpY291bnQpKQogCQlyZXR1cm4gLUVGQVVM
VDsKLS0gCjIuNDMuMAoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgQXVzdHJpYSBHbWJICkJy
dWVja2Vua29wZmdhc3NlIDEKODAyMCBHcmF6Ck9lc3RlcnJlaWNoClNpdHogaW4gR3JhegpGaXJt
ZW5idWNobnVtbWVyOiBGTiA0Mzk0NTMgZgpGaXJtZW5idWNoZ2VyaWNodDogTGFuZGVzZ2VyaWNo
dCBmdWVyIFppdmlscmVjaHRzc2FjaGVuIEdyYXoKCgo=

