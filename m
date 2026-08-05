Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766681E98E3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890194; cv=none; b=FA9xxoVr1cR1VaXB17rKS7SBflxyW1SfOgtE/urcTR9x6abKYAfomqv2qwwa+Z3u1DAl8KHAvP15OJk0MmcBrzR4OLxAxLnZESeDUCW7hUXaiNLTxCuvRhVL6Iu0nhsYAZHbi2ySPcM2j09k2mAx8RhA9tL2TLaz4iJRfbQv6kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890194; c=relaxed/simple;
	bh=tCMRq5T5EeCnBg7XZI4HEg9q2Obn746+qtFe7plmxXs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e9PyrF40vJNpr8bPC3PTZgnpKT4+w4rUUBqpWuawbgrF9OdwfLfMIy4wpq4jeVmJPtNj7Jee3C0LO2RcpU0jOr9z+hCU/XPA/86ATDry4/QfKIZADT/Twghvl5P3obNggVkfq/cwLmBtG/FU0JtJgKvhAiePbCOFnZLHnOFZN9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iz5y+l1n; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iz5y+l1n"
Message-ID: <effdf56b-8fd4-0c60-8761-183bec9bedb9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785890189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCMRq5T5EeCnBg7XZI4HEg9q2Obn746+qtFe7plmxXs=;
	b=iz5y+l1nuUsUuP1A5H6HN+8Qjuh7eIF3KHJnQMzsIm5bLEvLDoDzVJpOHdLGWBIL21MVWz
	51as0c3JYeZ64utFKiXz7/r26KyhtVHTNr62/Zqwswk/ksZb30BSK7SihqtvkgI5S1yfiw
	mPWqjiWBsfbWmoOpnvNIxxL9kYtpaeA=
Date: Tue, 4 Aug 2026 20:36:23 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "phy: zynqmp: Allow variation in refclk rate" has been
 added to the 6.1-stable tree
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Michal Simek <michal.simek@amd.com>
References: <20260805001127.3931192-1-sashal@kernel.org>
 <bf336886-fa6a-e69f-e669-5dc823ec755e@linux.dev>
In-Reply-To: <bf336886-fa6a-e69f-e669-5dc823ec755e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Migadu-Flow: FLOW_OUT

T24gOC80LzI2IDIwOjI5LCBTZWFuIEFuZGVyc29uIHdyb3RlOg0KPiBPbiA4LzQvMjYgMjA6
MTEsIFNhc2hhIExldmluIHdyb3RlOg0KPj4gVGhpcyBpcyBhIG5vdGUgdG8gbGV0IHlvdSBr
bm93IHRoYXQgSSd2ZSBqdXN0IGFkZGVkIHRoZSBwYXRjaCB0aXRsZWQNCj4+DQo+PiDCoMKg
wqDCoCBwaHk6IHp5bnFtcDogQWxsb3cgdmFyaWF0aW9uIGluIHJlZmNsayByYXRlDQo+Pg0K
Pj4gdG8gdGhlIDYuMS1zdGFibGUgdHJlZSB3aGljaCBjYW4gYmUgZm91bmQgYXQ6DQo+PiDC
oMKgwqDCoCBodHRwOi8vd3d3Lmtlcm5lbC5vcmcvZ2l0Lz9wPWxpbnV4L2tlcm5lbC9naXQv
c3RhYmxlL3N0YWJsZS1xdWV1ZS5naXQ7YT1zdW1tYXJ5DQo+Pg0KPj4gVGhlIGZpbGVuYW1l
IG9mIHRoZSBwYXRjaCBpczoNCj4+IMKgwqDCoMKgwqAgcGh5LXp5bnFtcC1hbGxvdy12YXJp
YXRpb24taW4tcmVmY2xrLXJhdGUucGF0Y2gNCj4+IGFuZCBpdCBjYW4gYmUgZm91bmQgaW4g
dGhlIHF1ZXVlLTYuMSBzdWJkaXJlY3RvcnkuDQo+Pg0KPj4gSWYgeW91LCBvciBhbnlvbmUg
ZWxzZSwgZmVlbHMgaXQgc2hvdWxkIG5vdCBiZSBhZGRlZCB0byB0aGUgc3RhYmxlIHRyZWUs
DQo+PiBwbGVhc2UgbGV0IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiBrbm93IGFib3V0IGl0
Lg0KPj4NCj4+DQo+Pg0KPj4gY29tbWl0IDQ1NWM1NDZmMmMwOWNkMzZmYzIxMTE4ODIwYzkw
Yjk3YWMzMTU3ODUNCj4+IEF1dGhvcjogU2VhbiBBbmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBs
aW51eC5kZXY+DQo+PiBEYXRlOsKgwqAgVHVlIEp1bCAxMSAxNTo0NTozOSAyMDIzIC0wNDAw
DQo+Pg0KPj4gwqDCoMKgwqAgcGh5OiB6eW5xbXA6IEFsbG93IHZhcmlhdGlvbiBpbiByZWZj
bGsgcmF0ZQ0KPj4gwqDCoMKgwqAgWyBVcHN0cmVhbSBjb21taXQgNzYwMDllZTc2ZTA1ZTMw
ZTI5YWFkZTAyZTc4OGFlYmU5Y2U5ZmZkMiBdDQo+PiDCoMKgwqDCoCBEdWUgdG8gbGltaXRl
ZCBhdmFpbGFibGUgZnJlcXVlbmN5IHJhdGlvcywgdGhlIHJlZmVyZW5jZSBjbG9jayByYXRl
IG1heQ0KPj4gwqDCoMKgwqAgbm90IGJlIGV4YWN0bHkgdGhlIHNhbWUgYXMgdGhlIHJlcXVp
cmVkIHJhdGUuIEFsbG93IGEgc21hbGwgKDEwMCBwcG0pDQo+PiDCoMKgwqDCoCBkZXZpYXRp
b24uDQo+PiDCoMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBTZWFuIEFuZGVyc29uIDxzZWFuLmFu
ZGVyc29uQHNlY28uY29tPg0KPj4gwqDCoMKgwqAgTGluazogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8yMDIzMDcxMTE5NDU0Mi44OTgyMzAtMS1zZWFuLmFuZGVyc29uQHNlY28uY29t
DQo+PiDCoMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwu
b3JnPg0KPj4gwqDCoMKgwqAgU3RhYmxlLWRlcC1vZjogZTQ3NzllMmExNmQ2ICgicGh5OiB6
eW5xbXA6IGZpeCBjbG9jayBlcnJvciBoYW5kbGluZyBpbiB4cHNndHJfcGh5X2luaXQoKSIp
DQoNCihhbmQgYXMgaXQgdHVybnMgb3V0IGl0ICppcyogYSBkZXBlbmRlbmN5KQ0KDQo+PiDC
oMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+
DQo+Pg0KPiBGV0lXIHRoaXMgaXNuJ3QgYSBidWcgZml4LiBTbyBwcm9iYWJseSBub3QgbmVj
ZXNzYXJ5IGZvciBzdGFibGUgdW5sZXNzIGl0J3MgYSBkZXBlbmRlbmN5Lg0KPiANCj4gLS1T
ZWFuDQoNCg==
