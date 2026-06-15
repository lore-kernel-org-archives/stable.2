Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7DC3F0AB1
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534325; cv=none; b=lPNO2UYOJ9bAMB/9ZjlY45PAyxsFbKMgc7WFKoik7DuQtmD/ffXea6f4LkKLxx/3KB9efQsGRP1Yg3rmHONmdfqmGgQkT340AHvCH8CNIf/NBAEH34k/RdN6eMwwHE45TQURbrhfDE1pbM66Eu/ZfDDHli4BbcvJYpv21myV5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534325; c=relaxed/simple;
	bh=qBeQ1M7/XRrDXwotUCpa2UJ4IpCdxmtNZa/U6g2Ke+g=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=nxQel0Ns5tPl8dGlEbTbYFtmIsmYegjq23Hk5vRfK1TMH1/zJipc/PLjiRxlu0zpbFF7Fy83VmpBl8b+nPgIZlG4lN7tu9cxGYvijIxps8CvV1Y5DnPI6QYAd3bG/AMPz6uzJ/v2Hwl85F9SxdeLl7NSwB/dyMU3nkBQl6SwV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=PZCI0sYv; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="PZCI0sYv"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6b571750bso2865037a34.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781534321; x=1782139121; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hzImMW9AXbAx6Z6GDoMG7/37MaDKHScKw3Nhz4SZOI=;
        b=PZCI0sYvmiy5E+VyapyD8AcFtiOf0mQaBTV1SroxPV+Vs/SJUdZ+i8BtP9RZfiWvPl
         QgPIodewwxkzrvZzGC5Bx/IlAYmk1v9XH9hgDL5nehGk8vEnSPJehnaNqtcr9tQdAhhc
         jeR4zK903puWLeTwlV/WxnhHsviEQHBmOualmZuqgz/Ip2wDYgQGWn13m8dAjDdCSiS5
         1m6RG1oa/KL2a7tGKIcf3feCiVOXK6QontUoT3N05l1EiDPchh1T1un7+oWmoTpOeJa7
         jO9jGAkik3JzLvgzGlLEHri40AioKGEndjLCcd/vBP+ymEqBAL/ZME5Is0j13y/XZyan
         aJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781534321; x=1782139121;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hzImMW9AXbAx6Z6GDoMG7/37MaDKHScKw3Nhz4SZOI=;
        b=qeVrgcKpcvLt2jgiMPVqKfAZDvPGj+rYcjpgiVdlFjXIsiBIgytX7pVM08TfQ7WHsG
         ah/NjDFoX375FPtkHCT2oxyKwCRy4h716L/7At6jGUqE99TDGrQa3+jR2hzoZFDYxFGc
         ud8tP64/Hoh31Z1NUKs2M0oF5xSQcZaobLHWEbUacrN3B9OeCs9U5tT7A3JXHXdLGmRi
         f2j8yIJDljrqspgjVShhVLww6/gZu5Lj6CY3Jzar5RF+DQllGSlVSsUgPt0RmA5L4tfD
         2m23LYllIAZxD3gqAah325uXV3O2aEn9os1mAI6d9elxMP+jvCZ5JHIbpqBnSGJ7mkM6
         WWnQ==
X-Gm-Message-State: AOJu0YxRSokrULu/W5DAZn7a1drVI15ESQv8AgzGHQuN1wSlzZq25RXS
	lZDBprlXLz4nbKYzg9eeTAfiXfLzt5z9/TfuIQuemaI+Y2/AUbEIGYcNz4t9S0s822VuucWGX05
	zl1UjdZA=
X-Gm-Gg: Acq92OHVxrcRA8+BTlU4yS638goH+Hmd/e4Eu3p3xczP4sZyAgMQa6pznz2cpS7/iar
	NrgJe7Ht8C2qekVSf6QeL37PgsJMtRpzOScu39J+/9g8HCPn2NYKN4PBKkoECTfgS9swVy07U3t
	MDDofsEgaeeo4t4jf6+i+6vhMeNRwes4bBxIriPc5MQsrWxvmQ24oaApeMEmBvTyxt8guWcKYHj
	VXD24cdGBraIrbVferI2ed0vKm8DtpV4a4SyCZHKvCvdcrUWmeClT2sXXR7BKeW8e0eYZD3302h
	xD7z/KMobL6U96wn+r1YPPMrpXz3sBrTSRWxEkl5ZcsgoSiEmzskZvBi9NhDtW2YsztcAzpPKoK
	GILqc1/wx00RezCIiJS51TRz7EpLeGXBoqjbI/0qM9D9iPr6Li7diywtuMnySvG34dX5AKQJ7j8
	ZBGYN/oVsK/HwTc8FdCElLM4hxt1sI2yLBnfewJ0i0WevfhHQJkYW2dp3/ICzeAs3vzdbgH5hOK
	gF9BrbI
X-Received: by 2002:a05:6830:368b:b0:7dc:d2ad:fb29 with SMTP id 46e09a7af769-7e784820e60mr10483681a34.24.1781534321092;
        Mon, 15 Jun 2026 07:38:41 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6dfaf4sm4342643a34.21.2026.06.15.07.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 07:38:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------vZF6c8tUwhgwj5Wnw6sa5MP7"
Message-ID: <b3189608-5ff3-497f-a1a1-f5e8219da914@kernel.dk>
Date: Mon, 15 Jun 2026 08:38:38 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/wait: fix min_timeout behavior"
 failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org, lk@c--e.de, tip@tenbrinkmeijs.com
Cc: stable@vger.kernel.org
References: <2026061509-unwatched-transpire-cd39@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026061509-unwatched-transpire-cd39@gregkh>

This is a multi-part message in MIME format.
--------------vZF6c8tUwhgwj5Wnw6sa5MP7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/26 8:18 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's one for 6.18-stable.

-- 
Jens Axboe

--------------vZF6c8tUwhgwj5Wnw6sa5MP7
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-wait-fix-min_timeout-behavior.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-wait-fix-min_timeout-behavior.patch"
Content-Transfer-Encoding: base64

RnJvbSBmM2JkZjU2YTViMTY3NzE1M2Q3ZmYzOGUwYTJhNjljODdiYzUwZjdjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiQ2hyaXN0aWFuIEEuIEVocmhhcmR0IiA8bGtAYy0t
ZS5kZT4KRGF0ZTogU2F0LCA2IEp1biAyMDI2IDIyOjExOjIwICswMjAwClN1YmplY3Q6IFtQ
QVRDSCAxLzJdIGlvX3VyaW5nL3dhaXQ6IGZpeCBtaW5fdGltZW91dCBiZWhhdmlvcgoKQ29t
bWl0IDI5ZmUxYmQwMWI5OTcxNGYzMTM2ZjkyMjIzMGE2NDNjMjc0MmNkYTkgdXBzdHJlYW0u
CgpUaGUgd2FrZXVwIGNvbmRpdGlvbiBpZiBhIG1pbiB0aW1lb3V0IGlzIHByZXNlbnQgYW5k
IGhhcyBleHBpcmVkIGlzIHRoYXQKYXQgbGVhc3QgX29uZV8gQ1FFIHdhcyBwb3N0ZWQuIFRo
dXMgc2V0IHRoZSBjcV90YWlsIHRhcmdldCB0bwotPmNxX21pbl90YWlsICsgMS4gV2l0aG91
dCB0aGlzIGNvbW1pdCBhIHNwdXJpb3VzIHdha2V1cCBjYW4gcmVzdWx0IGluIGEKcHJlbWF0
dXJlIHdha2V1cCBiZWNhdXNlIGlvX3Nob3VsZF93YWtlKCkgd2lsbCByZXR1cm4gdHJ1ZSBl
dmVuIGlmIF9ub18KQ1FFIHdhcyBwb3N0ZWQgYXQgYWxsLgoKQ2M6IFRpcCB0ZW4gQnJpbmsg
PHRpcEB0ZW5icmlua21laWpzLmNvbT4KRml4ZXM6IGUxNWNiMjIwMGI5MyAoImlvX3VyaW5n
OiBmaXggbWluX3dhaXQgd2FrZXVwcyBmb3IgU1FQT0xMIikKQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEEuIEVocmhhcmR0IDxsa0BjLS1l
LmRlPgpMaW5rOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjA2MDYyMDExMjAuMTQ0
MTQ0Ny0xLWxrQGMtLWUuZGUKU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2Vy
bmVsLmRrPgotLS0KIGlvX3VyaW5nL2lvX3VyaW5nLmMgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pb191cmlu
Zy9pb191cmluZy5jIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCAwM2U3YjlkNmI0NDgu
LjdmMzk4YzRhM2E2ZSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9p
b191cmluZy9pb191cmluZy5jCkBAIC0yNTg2LDcgKzI1ODYsNyBAQCBzdGF0aWMgZW51bSBo
cnRpbWVyX3Jlc3RhcnQgaW9fY3FyaW5nX21pbl90aW1lcl93YWtldXAoc3RydWN0IGhydGlt
ZXIgKnRpbWVyKQogCX0KIAogCS8qIGFueSBnZW5lcmF0ZWQgQ1FFIHBvc3RlZCBwYXN0IHRo
aXMgdGltZSBzaG91bGQgd2FrZSB1cyB1cCAqLwotCWlvd3EtPmNxX3RhaWwgPSBpb3dxLT5j
cV9taW5fdGFpbDsKKwlpb3dxLT5jcV90YWlsID0gaW93cS0+Y3FfbWluX3RhaWwgKyAxOwog
CiAJaHJ0aW1lcl91cGRhdGVfZnVuY3Rpb24oJmlvd3EtPnQsIGlvX2NxcmluZ190aW1lcl93
YWtldXApOwogCWhydGltZXJfc2V0X2V4cGlyZXModGltZXIsIGlvd3EtPnRpbWVvdXQpOwot
LSAKMi41My4wCgo=

--------------vZF6c8tUwhgwj5Wnw6sa5MP7--
