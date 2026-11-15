Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=27.111.92.109
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794730645;
	b=KqhfzibLlmKDx+mF6jU8GiP0HV8wZGFIMEgkP9/Wr6oryOaPdxRLkc1wMQJfLpVjo/G5
	 hsiqH85E0pJ7IhKy4MdVbclhUIS0LkT90BTU51+B7CSDG/wtvmF4qymR7pEQMgQyqfJ3P
	 DJNK7lTtEp36cCuCLBY5z6iaWrhFv5tg+YjmTqHTbWJOSNbDF4IlMGa6/2nTUWSHpm/4w
	 wTcJGO69uU59A0244LvcXcMz1gwEjKKVxaWYcdq8TPk88o48SQJkvetEWo5JjIAf00SNd
	 ZQG3civvrLtbOzagrhlyhIZCciLRbj889/H4GgfHU1WACJGva/aw1EsuWjTNI/oBYpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794730645;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Content-Type:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=+xB/EiJURGaS8AnrKP8tu56DXfZyQqbE3+5bWGnca1Y=;
	b=FJN5f++0ye18lOiGw+4tpiJ7DOh6ln23W/SUW4emgj/tJWa6t9Dw8H79PzRf1Te0MZkd
	 65U9yArOpiuXdOajscH8F1UuqH2y+2o+dnL0IBmJkMFagab62QKnYrjTdWQlorszNSuyw
	 Qdfs66VkjaExEoRWXbtrmr0PwPBVERb44ToZoIW+RfmRoX81lDJiVB6uH8ECh9hgQszff
	 sxP4koLSWcNpsstjl6+WnTH44QlVTIFWkGY0mv69EfyBUjTi62Utp4rgZS4Hn2bP6BWo5
	 Ycym3aFXpVYWcy10bBTdlJL+qDwUXm0T66AfHZqiEhDlCdVkDwkoD4jALnXoIViWbAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=advisoft.co.nz;
	spf=pass smtp.mailfrom=advisoft.co.nz;
	dkim=pass header.d=advisoft.co.nz header.i=@advisoft.co.nz header.a=rsa-sha256 header.s=default header.b=ZviZSrwd;
	arc=none smtp.remote-ip=27.111.92.109
Received: from mail-p1-f31.ipv4.au.ds.network (mail-p1-f31.ipv4.au.ds.network [27.111.92.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1829E606A31A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 08:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1829E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=advisoft.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=advisoft.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=advisoft.co.nz header.i=@advisoft.co.nz header.a=rsa-sha256 header.s=default header.b=ZviZSrwd
Received: from server-72-r70.ipv4.per01.ds.network (ip7ac97cc8.ipv4.syd02.ds.network [122.201.124.200])
	by filter-out02.au.ds.network (Halon) with ESMTPS
	id f6ad2fbc-e0cc-11f1-9d06-63c11cf4efbd;
	Sun, 15 Nov 2026 19:17:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=advisoft.co.nz; s=default; h=In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=+xB/EiJURGaS8AnrKP8tu56DXfZyQqbE3+5bWGnca1Y=; b=Z
	viZSrwdxRt3u/UJd+n3kzfKRtqxCrIj8yKHFmNlLspsBPskyhKVqn0japSb6Gc+76G+dyuCXgdsnC
	tON0RL7wVKvA9ey/6ujdlqLuZRYNh/5eZFpB15KIahI4G+Sncs5fK5X0UwI2nNnZW1mebUXOGcIXS
	CLJddU2/dIA84mmBffxb5Z6dhldTDNr+sslOL5Df+bCUX8pQvg0Ovtyg6+ZujdNS4anV+2ZXuLJOv
	fbJ4KglQjtA8ABodBrAHXGXrF78BMPDJoOgv00Zw771FcFtx1WP/OlinhqMSdLeJ6tFF3BuVzUYr2
	4Ch8czkmmJ3/xpf1I4QcYyaKC/eRhlnmA==;
Received: from [115.69.178.245] (port=51528 helo=[192.168.2.211])
	by cp-fp09.syd02.ds.network with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <phil.williams@advisoft.co.nz>)
	id 1xSVQI-000000001wz-0DHJ;
	Sun, 15 Nov 2026 21:17:14 +1300
Content-Type: multipart/mixed; boundary="------------DaHNjVFhfxuojXo2uFT7yvOM"
Message-ID: <6a9cbbcc-bdfb-4af1-a678-4f6f4b8a5f0e@advisoft.co.nz>
Date: Sun, 15 Nov 2026 21:17:13 +1300
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] iio: imu: st_lsm6dsx: fall back to 25 us/tick without a trim
To: Francesco Lavra <flavra@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: mario.tesi@st.com, linux-iio@vger.kernel.org, stable@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
References: <a3a00c75-c830-4d1a-9a89-dd55641a422f@advisoft.co.nz>
 <20261115000940.24215eb0@jic23-hlaptop>
 <2cc30a3e725639667085f3f82d453a7dfc9f853c.camel@baylibre.com>
Content-Language: en-GB
From: Phil Williams <phil.williams@advisoft.co.nz>
In-Reply-To: <2cc30a3e725639667085f3f82d453a7dfc9f853c.camel@baylibre.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp-fp09.syd02.ds.network
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - advisoft.co.nz
X-Get-Message-Sender-Via: cp-fp09.syd02.ds.network: authenticated_id: phil.williams@advisoft.co.nz
X-Authenticated-Sender: cp-fp09.syd02.ds.network: phil.williams@advisoft.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

This is a multi-part message in MIME format.
--------------DaHNjVFhfxuojXo2uFT7yvOM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

Patch attached. It is the fallback in st_lsm6dsx_init_hw_timer() as 
discussed.

On Toradex Linux 6.6.142, an ISM330DLC on SPI (whoami 0x6a) on a Verdin 
i.MX8M Plus published every FIFO sample with one timestamp until the 
scale was 25000 ns/tick again. After that the timestamp bytes advanced 
and pitch updated. I have not booted this patch on mainline. It applies 
cleanly on mainline 23c62304dde2.

This is my first kernel patch, please let me know if there is anything 
else I need to do.

Thanks,
Phil

On 15/11/2026 8:11 pm, Francesco Lavra wrote:
> On Sun, 2026-11-15 at 00:09 +0000, Jonathan Cameron wrote:
>> On Tue, 10 Nov 2026 02:38:14 +1300
>> Phil Williams <phil.williams@advisoft.co.nz> wrote:
>>
>>> Hey Guys,
>>>
>>> I ran into an issue where every FIFO sample from an ISM330DLC came out
>>> with the same timestamp, so our attitude math froze the pitch. The
>>> accelerometer and gyroscope values were fine. I've patched it locally,
>>> so this is just an FYI.
>>>
>>> Make what you want of it, but here is an AI generated description of
>>> the
>>> issue:
>>>
>>> Commit 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp
>>> calculation") drops the timestamp scale for the older parts in this
>>> driver. Stable backport 981f3da383ce is what we hit, in 6.6.142.
>>>
>>> st_lsm6dsx_init_hw_timer() used to do:
>>>
>>>       hw->ts_gain = ST_LSM6DSX_TS_SENSITIVITY; /* 25000 ns/tick */
>>>
>>> That commit deletes the constant and reads the gain from the per-chip
>>> table:
>>>
>>>       hw->ts_gain = ts_settings->ts_sensitivity;
>>>
>>> ts_sensitivity is only filled in on the entries that already had
>>> freq_fine (LSM6DSO / LSM6DSR / LSM6DSV and that generation). The
>>> untagged-FIFO entries have no freq_fine register, so they were left at
>>> 0:
>>>
>>>       LSM6DS3
>>>       LSM6DS3H
>>>       LSM6DSL, LSM6DSM, ISM330DLC, LSM6DS3TR-C
>>>
>>> st_lsm6dsx_read_fifo() still does:
>>>
>>>       ts = data[1] << 16 | data[0] << 8 | data[3];
>>>       ts *= hw->ts_gain;
>>>       iio_push_to_buffers_with_timestamp(..., sensor->ts_ref + ts);
>>>
>>> With ts_gain == 0 every sample is published as ts_ref, the
>>> CLOCK_REALTIME value taken when the buffer was enabled. The accel and
>>> gyro values are fine. Only the timestamp is stuck. The raw count is
>>> still checked against 0xff0000 before the multiply, so ts_ref is
>>> refreshed when the counter gets there. At 25 µs/tick that is about 7
>>> minutes. The driver comment says 1.638 s, which is 2^16 ticks, but the
>>> test is 0xff0000.
>>>
>>> How we found it: an ISM330DLC on SPI (whoami 0x6a), on a Toradex Verdin
>>> i.MX8M Plus, after moving onto 6.6.142. Userspace integrates attitude
>>> from the delta of the IIO buffer timestamp and treats a non-increasing
>>> timestamp as dt = 0, so pitch, roll and yaw froze at the first sample.
>>> A
>>> strace of the process reading /dev/iio:deviceX showed the xyz int16s
>>> changing and the 8 timestamp bytes identical across samples. The same
>>> binary against the previous kernel, which still used the 25000
>>> constant,
>>> did not do this.
>>>
>>> Setting the old scale on those three entries fixes it. freq_fine stays
>>> unset, so the trim register is not read and the gain stays exactly
>>> 25000, which is what those parts had before:
>>>
>>>       .ts_sensitivity = 25000,
>>>       .ts_trim_coeff = 37500,
>>>
>>> After booting that kernel the timestamp bytes increment and pitch
>>> tracks
>>> the unit again. The entries that already had ts_sensitivity (25000, or
>>> 21701 on the freq_fine 0x4f part) were left alone.
>>>
>>> Fixes: 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp
>>> calculation")
> This analysis looks correct to me too.
> But I wouldn't set .ts_trim_coeff for the parts where .freq_fine is 0: for
> those, there is no trimming to be done.
> So either set .ts_sensitivity = 25000 for all parts that currently don't
> have it set, or maybe better use 25000 in st_lsm6dsx_init_hw_timer() as a
> fallback value when .ts_sensitivity is not set.
--------------DaHNjVFhfxuojXo2uFT7yvOM
Content-Type: text/plain; charset=UTF-8;
 name="0001-iio-imu-st_lsm6dsx-fall-back-to-25-us-tick-without-a-trim.patch"
Content-Disposition: attachment;
 filename*0="0001-iio-imu-st_lsm6dsx-fall-back-to-25-us-tick-without-a-tr";
 filename*1="im.patch"
Content-Transfer-Encoding: base64

RnJvbSAxNDFhYTMxNDU0YmQ4N2VkMjBiMTg1NTQ0NDU2YmYyODY5MmM0YzJkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsIFdpbGxpYW1zIDxwaGlsLndpbGxpYW1zQGFk
dmlzb2Z0LmNvLm56PgpEYXRlOiBTdW4sIDE1IE5vdiAyMDI2IDIxOjA0OjA2ICsxMzAwClN1
YmplY3Q6IFtQQVRDSF0gaWlvOiBpbXU6IHN0X2xzbTZkc3g6IGZhbGwgYmFjayB0byAyNSB1
cy90aWNrIHdpdGhvdXQgYSB0cmltCgpDb21taXQgOGFiYmY0NWZjZGEwICgiaWlvOiBzdF9s
c202ZHN4OiBGaXhlZCBjYWxpYnJhdGVkIHRpbWVzdGFtcApjYWxjdWxhdGlvbiIpIHRha2Vz
IHRoZSBGSUZPIHRpbWVzdGFtcCBzY2FsZSBmcm9tIHRzX3NlbnNpdGl2aXR5LgpUaGF0IGZp
ZWxkIGlzIG9ubHkgZmlsbGVkIGluIGZvciBwYXJ0cyB0aGF0IGhhdmUgZnJlcV9maW5lLiBU
aGUKdW50YWdnZWQtRklGTyBwYXJ0cyBhcmUgbGVmdCBhdCB6ZXJvOgoKICBMU002RFMzCiAg
TFNNNkRTM0gKICBMU002RFNMLCBMU002RFNNLCBJU00zMzBETEMgYW5kIExTTTZEUzNUUi1D
CgpzdF9sc202ZHN4X3JlYWRfZmlmbygpIG11bHRpcGxpZXMgdGhlIHJhdyBjb3VudGVyIGJ5
IGh3LT50c19nYWluLCBzbwpldmVyeSBzYW1wbGUgaXMgcHVibGlzaGVkIHdpdGggdGhlIHRp
bWVzdGFtcCB0YWtlbiB3aGVuIHRoZSBidWZmZXIKd2FzIGVuYWJsZWQuIFRoZSBhY2NlbGVy
b21ldGVyIGFuZCBneXJvc2NvcGUgdmFsdWVzIHN0aWxsIHVwZGF0ZS4KVXNlcnNwYWNlIHRo
YXQgaW50ZWdyYXRlcyBhdHRpdHVkZSBmcm9tIHRoZSB0aW1lc3RhbXAgZGVsdGEgdHJlYXRz
IGEKc3R1Y2sgdGltZXN0YW1wIGFzIGR0ID0gMC4KClRoZXNlIHBhcnRzIGhhdmUgbm8gZnJl
cV9maW5lIHJlZ2lzdGVyLCBzbyB0aGVyZSBpcyBubyB0cmltIHRvIGFwcGx5LgpVc2UgdGhl
IHByZXZpb3VzIGZpeGVkIHNjYWxlIG9mIDI1MDAwIG5zL3RpY2sgd2hlbiB0c19zZW5zaXRp
dml0eSBpcwp1bnNldC4gRW50cmllcyB0aGF0IGFscmVhZHkgc2V0IGl0IGFyZSBsZWZ0IGFs
b25lLgoKRml4ZXM6IDhhYmJmNDVmY2RhMCAoImlpbzogc3RfbHNtNmRzeDogRml4ZWQgY2Fs
aWJyYXRlZCB0aW1lc3RhbXAgY2FsY3VsYXRpb24iKQpDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZwpTdWdnZXN0ZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+
ClNpZ25lZC1vZmYtYnk6IFBoaWwgV2lsbGlhbXMgPHBoaWwud2lsbGlhbXNAYWR2aXNvZnQu
Y28ubno+Ci0tLQogZHJpdmVycy9paW8vaW11L3N0X2xzbTZkc3gvc3RfbHNtNmRzeF9jb3Jl
LmMgfCA4ICsrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11L3N0X2xzbTZkc3gvc3Rf
bHNtNmRzeF9jb3JlLmMgYi9kcml2ZXJzL2lpby9pbXUvc3RfbHNtNmRzeC9zdF9sc202ZHN4
X2NvcmUuYwppbmRleCA4MjNmOGFjLi45OGRiOTBhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lp
by9pbXUvc3RfbHNtNmRzeC9zdF9sc202ZHN4X2NvcmUuYworKysgYi9kcml2ZXJzL2lpby9p
bXUvc3RfbHNtNmRzeC9zdF9sc202ZHN4X2NvcmUuYwpAQCAtMjUyNSw4ICsyNTI1LDE0IEBA
IHN0YXRpYyBpbnQgc3RfbHNtNmRzeF9pbml0X2h3X3RpbWVyKHN0cnVjdCBzdF9sc202ZHN4
X2h3ICpodykKIAkJCXJldHVybiBlcnI7CiAJfQogCi0JLyogY2FsaWJyYXRlIHRpbWVzdGFt
cCBzZW5zaXRpdml0eSAqLworCS8qCisJICogUGFydHMgd2l0aCBubyBmcmVxX2ZpbmUgcmVn
aXN0ZXIgaGF2ZSBubyB0cmltIGFuZCBsZWF2ZQorCSAqIHRzX3NlbnNpdGl2aXR5IHVuc2V0
LiBUaG9zZSBwYXJ0cyB1c2VkIGEgZml4ZWQgMjUgdXMvdGljay4KKwkgKiBBIHplcm8gZ2Fp
biBwdWJsaXNoZXMgZXZlcnkgRklGTyBzYW1wbGUgd2l0aCBvbmUgdGltZXN0YW1wLgorCSAq
LwogCWh3LT50c19nYWluID0gdHNfc2V0dGluZ3MtPnRzX3NlbnNpdGl2aXR5OworCWlmICgh
aHctPnRzX2dhaW4pCisJCWh3LT50c19nYWluID0gMjUwMDA7CiAJaWYgKHRzX3NldHRpbmdz
LT5mcmVxX2ZpbmUpIHsKIAkJZXJyID0gcmVnbWFwX3JlYWQoaHctPnJlZ21hcCwgdHNfc2V0
dGluZ3MtPmZyZXFfZmluZSwgJnZhbCk7CiAJCWlmIChlcnIgPCAwKQotLSAKMi41My4wCgo=


--------------DaHNjVFhfxuojXo2uFT7yvOM--
