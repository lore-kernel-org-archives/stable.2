Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56603FADE9
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534484; cv=none; b=cLGSShDGBGZj9qdwI+J38i8EaLwMU3dKwkxHtj9nspnGsa6KWN2yO5007n5M8NSND6TM3fVkNyn0KndPlQ8Sor6QxdSkAazAZGCNgzRHvlQGqDZu47Z1iElV2vkhjovVRuyeizjd9EnhWGF6rcQ7aoelp/v6Bio0wuFMWpmrvS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534484; c=relaxed/simple;
	bh=JKSHaKk+guCdYxRe7Vv6fE5X4yQYslPz2+l8BCsSqGM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=hLxrsilgeh25eeVmbLlfEy1t0tndqTkGQjkm109vGE2ICuoU6qvrQVo/2x7HWk69eUc236qKecKK1UmRmcNSjZYKzxbtq27bo5peVx5C0vuM1oKLenz/7YNeDDsXJj93Mge79hzSxdej7RlWvVtCQhzs19KYd3WrXpBKqefpS7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=P/W6Erp3; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="P/W6Erp3"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69e8a8608d7so2088207eaf.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781534480; x=1782139280; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILtnIQxD6DomeJBfmptALas2HKPpvZEBo2oohSNd3Ws=;
        b=P/W6Erp3sSLFVT9eNfz4BSgbZVMOPG3RrEdnjA8khrIZQJse5cJhfMpQQ3D3QEw80H
         mzRWSdCFTdOYnsRf9q1wC9bDO9O2EqXwQK6t/9Zl0U1MCdAAMfb5QwzhUjO1VwnfTlP3
         d8CfDfsXMp/Nx6ATmYAg20yA6O2LcdcEOhpGl/fgRznGf1AB2YKwaAFUaSP/5Qa2bVdO
         iD8VE/1n1j421yWzu1Fvy0JBQK9h2BSsqY3UY7gXNuBDDfb9zFExwRbuVebsGKzo/GZi
         pWj25bHEr/MJRDlrq+39jih+2EFzOuDT/m+SHv4z+7N4/oujL6lyx30OZLD/OMO7xSaf
         IC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781534480; x=1782139280;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILtnIQxD6DomeJBfmptALas2HKPpvZEBo2oohSNd3Ws=;
        b=rCKicmNs9a1KJESzqF0AL4VjG7x/EYqBt1Yj6SF66NrlzfqOv+ckXlyM8/GlXh3IMr
         i9VmyAQLetYevuD7+0fdA7rivEzOMQ1HS00BwG7YjkWwW7xSEw/pDiDD/1No/nhf1fB8
         u6AHqfazhfavLNYm6qo+fgnecd1tnQiGC+wOoV4hMj//+fQJ7kNEk9cghkakzNAGxmqt
         +usZTGlWSaP4fMbEEzuuOQYUILzpr+asDESxwz16tocNWApXAByHY2E4DA2YMXF91bDl
         mqJVA/HKoF+mYGt3eYT7owsxcECEsp1WxFEpn30SwqAvq+6O6aMho2EuvSMfWNBDRf7b
         O3bA==
X-Gm-Message-State: AOJu0YyxbPOjcz/AlKfsn4FB++F7lHlFBM9sjQav/AvJ1szioNtGJ8SN
	B2dQHqcF84HDAq/UG+rwy0q798P3MlpM6lhZb7Q1tKhakyFN3INSPaT53rB0w2jhRdg=
X-Gm-Gg: Acq92OEbg2xRcS8AokebrBW8p2lh7lPOz9xx34Fu5YfXFupnTGUWAek+JDNGJ4Wboex
	P3LE0+1MfaLAAsEFnPZFQwVqkN1aT+EekzlefBiER6C7euSKbTmmyev89CjWsWpZiHEpRyXQ0Sm
	BWgn+RGbtjMs2HR2I8wr10prUGlPirHYXMrJsfXKF8Qj0b/ACaxBa6ExQzbvAb1boXTZzM4bE6n
	l21QNzTXuEFGaUTSyjbmICyvLyAE30S5AbUpgbddwpcizg3ObAcQIxsZAkCaMUQPULn1EyZ3c8S
	r89mMDY7FGzMr73Gcmqhg9e0+vC1oF9V/alYw43JENn8nqjjf8E5whDbT27k7ubUBOYCLeT+LbA
	oK1LvhGrJqKVVsFvPWKudMY2UgbYkksVA+9aWywTQbdkzSH3etJ+tvBkTAQxX6gjcdmnOnJT7Fc
	K1Fps/1sydrIWX9E35N5Ud+oeQlaSGAhyUjedhw+N6Txymr0GpUUrcj2wroPg8BVqUO0vkqTCXf
	fp9ckMhqd/3itEaeOY=
X-Received: by 2002:a05:6820:1a0d:b0:69d:cfb6:4f4a with SMTP id 006d021491bc7-69edc642864mr9081319eaf.15.1781534480489;
        Mon, 15 Jun 2026 07:41:20 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4430866fa15sm58192fac.0.2026.06.15.07.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 07:41:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Mr8rDufnV5LLv0WSKjRUgXsv"
Message-ID: <e14ac015-9540-40d4-9783-4b920319ba70@kernel.dk>
Date: Mon, 15 Jun 2026 08:41:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: don't truncate end buffer
 for bundles" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, federico.brasili@gmail.com
Cc: stable@vger.kernel.org
References: <2026061526-unroasted-disbelief-650a@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026061526-unroasted-disbelief-650a@gregkh>

This is a multi-part message in MIME format.
--------------Mr8rDufnV5LLv0WSKjRUgXsv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/26 8:18 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's one for 6.12-stable.

-- 
Jens Axboe

--------------Mr8rDufnV5LLv0WSKjRUgXsv
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-kbuf-don-t-truncate-end-buffer-for-bundles.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-kbuf-don-t-truncate-end-buffer-for-bundles.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSBjYTQ4NGEzYjk1NDIwYjI4NDE1MzliOWJjNTE0MzUwNzkyOWVhZDBhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFN1biwgNyBKdW4gMjAyNiAxNjowNTo0NyAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMi8y
XSBpb191cmluZy9rYnVmOiBkb24ndCB0cnVuY2F0ZSBlbmQgYnVmZmVyIGZvciBidW5kbGVz
CgpDb21taXQgNzBmNDg4NmJjYmI5MjllODgwMzhjODgwN2YxZGFmN2ZjNTg3YWU3YyB1cHN0
cmVhbS4KCklmIGJ1ZmZlcnMgaGF2ZSBiZWVuIHBlZWtlZCBmb3IgYSBidW5kbGUgcmVjZWl2
ZSwgdGhlIGtlcm5lbCB3aWxsCnRydW5jYXRlIHRoZSBlbmQgYnVmZmVyLCBpZiB0aGUgYXZh
aWxhYmxlIGxlbmd0aCBpcyBzaG9ydGVyIHRoYW4gdGhlCmJ1ZmZlciBpdHNlbGYuIFRoaXMg
aXMgdW5uZWNlc3NhcnksIGFzIGFwcGxpY2F0aW9ucyBpdGVyYXRpbmcgYnVuZGxlCnJlY2Vp
dmVzIG11c3QgYWx3YXlzIHVzZSB0aGUgbWluaW11bSBzaXplIG9mIHRoZSBidWZmZXIgbGVu
Z3RoIGFuZCB0aGUKcmVtYWluaW5nIG51bWJlciBvZiBieXRlcyBpbiB0aGUgYnVuZGxlLiBU
aGUgZXhhbXBsZXMgaW4gbGlidXJpbmcgZG8KdGhhdCBhcyB3ZWxsLCBlZyBleGFtcGxlcy9w
cm94eS5jLgoKSWYgdGhlIGtlcm5lbCBkb2VzIHRydW5jYXRlIHRoaXMgYnVmZmVyIEFORCB0
aGUgY3VycmVudCB0cmFuc2ZlciBmYWlscywKdGhlbiB0aGUgYnVmZmVyIHdpbGwgYmUgbGVm
dCB3aXRoIGEgc21hbGxlciBzaXplIHRoYW4gd2hhdCBpcyBvdGhlcndpc2UKYXZhaWxhYmxl
LgoKSnVzdCByZW1vdmUgdGhlIGJ1ZmZlciB0cnVuY2F0aW9uLCBhcyBpdCdzIG5vdCBuZWNl
c3NhcnkgaW4gdGhlIGZpcnN0CnBsYWNlLgoKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvaW8tdXJpbmcvQ0FBRXI4amJZNjBub0dqMWZ3X2s5MVVKUkJreWlSVm9TNj1uTGhaN1N2
d2lkam40Q0FBQG1haWwuZ21haWwuY29tLwpSZXBvcnRlZC1ieTogRmVkZXJpY28gQnJhc2ls
aSA8ZmVkZXJpY28uYnJhc2lsaUBnbWFpbC5jb20+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnCkZpeGVzOiAzNWM4NzExYzhmYzQgKCJpb191cmluZy9rYnVmOiBhZGQgaGVscGVycyBm
b3IgZ2V0dGluZy9wZWVraW5nIG11bHRpcGxlIGJ1ZmZlcnMiKQpTaWduZWQtb2ZmLWJ5OiBK
ZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcva2J1Zi5jIHwgMSAt
CiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5n
L2tidWYuYyBiL2lvX3VyaW5nL2tidWYuYwppbmRleCBmNjdlY2FjZDI1NDMuLmRmNWJhMGQ3
ZmJiMyAxMDA2NDQKLS0tIGEvaW9fdXJpbmcva2J1Zi5jCisrKyBiL2lvX3VyaW5nL2tidWYu
YwpAQCAtMjkzLDcgKzI5Myw2IEBAIHN0YXRpYyBpbnQgaW9fcmluZ19idWZmZXJzX3BlZWso
c3RydWN0IGlvX2tpb2NiICpyZXEsIHN0cnVjdCBidWZfc2VsX2FyZyAqYXJnLAogCQkJCWFy
Zy0+cGFydGlhbF9tYXAgPSAxOwogCQkJCWlmIChpb3YgIT0gYXJnLT5pb3ZzKQogCQkJCQli
cmVhazsKLQkJCQlXUklURV9PTkNFKGJ1Zi0+bGVuLCBsZW4pOwogCQkJfQogCQl9CiAKLS0g
CjIuNTMuMAoK

--------------Mr8rDufnV5LLv0WSKjRUgXsv--
