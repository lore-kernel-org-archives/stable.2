Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A23B27FA
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407380; cv=none; b=UnVl6WVacGgVnq5mRibJBNlaGRtTkt79a6j6ggtMWMHIsJPU0Kl+x/1wDDIpOo/BQcKugDiCjf/qIG9Ozc8+7GdWLTjyetD19EBzfW1qZ8y4dEU+m55fSRt30KHiM1RoKaWiCMw+YOViVce7MyxJkMqimkF9K3ZR/LMsgk3d0Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407380; c=relaxed/simple;
	bh=1Eiz1vL0YJQsi0ERhp5GFmEzi6yhSKnMrwRJXMi3/Kg=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=sJpPRBxGYQkcdQWHXy7A52+GApmAyvQV/e4tFMCUKGBGi3VERW9w4v0BHi/WsAbdICe41XLP5u6t/eoCJ63LXmDYMTGOa2sOUKzdQRSHdqhAyymVjn5fr5nf20w7vVb9bWbZPe7OeKSkM5W/HcRZHMXcEoBAYgPY3MQ9VrJBt/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=QuNMeXrv; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="QuNMeXrv"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-495b27007d0so913723b6e.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 03:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785407375; x=1786012175; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CmGCZ+DaKNJSm2l1SSlvmRFbkZgh5hsCFSUwwQ81z/4=;
        b=QuNMeXrvwWZKfNVSKuMZOJuXDVPK1fLzlXO056LGLjNaV+iwm3o6OObaJyWLWvOg6f
         iqF0s8dQEtwOWkxRgk7ttf7JbuOKBSCHmp4I8UqoZNe8TWZODEIzpcq6Hg4VdUhIJTK2
         wRewjX1UbcfJKpWw0sLlHz6kzo/XzMzwEzCtOZbejOBw6p0XvqVimF9zR9b9AVM5oXhQ
         EwsimC/eYDQurnoR+ZbLHzEE6URWhY2ry3jw0lAyWRABy8BulEzQQMBmoqxemy7dujJz
         9qA7LsVogCSaFksDGiidjFjDwCPncltcZ91IgJn2hiuxwwUHVi6VbWAC8QeAIg1I7uXF
         kaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785407375; x=1786012175;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CmGCZ+DaKNJSm2l1SSlvmRFbkZgh5hsCFSUwwQ81z/4=;
        b=RU/1tQH9xDD+e/6Pk+9veXJmglLydKZ4IIAeT1EQ9keQDzqsJw9ZTf5qQjFfD10Frr
         yDFf6ZKIdMiu2U34IKMazIsJUQmYqXll9PyI4ZEGYihmBCR49VJ3didZPUfr5wcPa9t5
         uDcEZJDcXp5vhoJM+vkBBMpvcKb8/zOHlZTZzpbVfYJJLDS61x2S87nWrokIvuySDfe3
         X2WKeFMc7mkDq8pzsXR1ZMc6vaAIlpo3Z6paYa4dwHtX23+LywmNceZrsHsWnDWYScmP
         Aac1dh60liMJ8GAY6ZhUmnUbNAX3OjkhWar63fO6r1GhC7K3acQb3IooybNvV7nUZ8xe
         In+A==
X-Gm-Message-State: AOJu0YyZeAvtiqaLhsXOMxvSES6SZ+YPn7dMfJg/fUOwU75uy3ejWbVE
	g6HbVy/8FbobR50bJuPTVcoaEiaDaWbjxCxUMWbj8XIbljLPt1ysTvkekje2Xjv3lgPyXva0K1z
	XiagVEzVviw==
X-Gm-Gg: AR+sD13O/n05ufc3d/iFqcn3SjcEgoEFm91B2nQ6OX91ABIuxS41CvgfqCVZYgLf8bB
	tjROMWXp9+9enx2k8pL3weBE9TKWh+lywNzjd1UPeXcRI05O9F82ycbOhd4qNekwEeq6JNmOi8M
	2kJqZ3TxVl1mkP5uSvbumB9Tyo/Zdop2CxbOXKAqRJjEudSrE5p52RvgptWHE8K6KMn/mJeB3Dp
	wfqC45qGrD44D7IH+SBevEfbtsXyMr/V0/CclhrI85r8NasnfleI6vvg//lVofy4lObf3hwe+xN
	JGz1GGfcnU1IOAsVytJxHKYmWcRueh4Ne42BkGhzb2FaGYcJ3Y9/WVmDhWDWLRzGwq2txcu9Mgh
	THr5Rh97JIiY/jlkTobDYr0pau2AiPKcteUyvKZTeDJWBujjmPvJonY2MwXRki2DClPjpcDZ4am
	dmzu5ljD63MFo7KplJFIF7LgfDG3DSD/V40Mvbd/UWHbBGONf3K1UNTlmxR1cqhGjWoYlQQA3u3
	cCm6EeoDcEaXUOI8yKzklamJZIjBZ6WAKVci+gWXAQrIO8=
X-Received: by 2002:a05:6808:159a:b0:494:18ad:8a5b with SMTP id 5614622812f47-4ad878bbcc7mr1190356b6e.17.1785407375571;
        Thu, 30 Jul 2026 03:29:35 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6ed2dedasm4130248b6e.7.2026.07.30.03.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 03:29:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------FkWF13RviL00rEE6UVExpNtb"
Message-ID: <818fbace-d4be-4ae3-937c-5cf95713886d@kernel.dk>
Date: Thu, 30 Jul 2026 04:29:32 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS
 conversion in read paths" failed to apply to 6.1-stable tree
To: Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
 yi1tang.yang@gmail.com
Cc: stable@vger.kernel.org
References: <d9ec68af-793d-41f4-9b9c-d68b1cd51200@kernel.dk>
 <20260729223316.stable-0027@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260729223316.stable-0027@kernel.org>

This is a multi-part message in MIME format.
--------------FkWF13RviL00rEE6UVExpNtb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 8:40 PM, Sasha Levin wrote:
>> And here's the _actual_ 6.1-stable patch.
> 
> The 6.12 and 6.6 ones came through fine and are queued, thanks.
> 
> The 6.1 one didn't make it out though - both of your mails in this thread
> arrived here with no attachment and an empty body apart from the quoted notice.
> The only attachment in this thread is identical to the 6.12 patch, and its
> pre-image doesn't match 6.1.
> 
> Could you resend the 6.1 version?

Here it is.


-- 
Jens Axboe

--------------FkWF13RviL00rEE6UVExpNtb
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-rw-fix-missing-ERESTARTSYS-conversion-in-re.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-rw-fix-missing-ERESTARTSYS-conversion-in-re.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3ZTBkYTdjNGRlNzI3OGJmZjNiZDQyYTFmMjljMjE3NmRiZmI0NGUxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBZaXRhbmcgWWFuZyA8eWkxdGFuZy55YW5nQGdtYWls
LmNvbT4KRGF0ZTogV2VkLCAyMiBKdWwgMjAyNiAyMDo0NTo1MSArMDgwMApTdWJqZWN0OiBb
UEFUQ0hdIGlvX3VyaW5nL3J3OiBmaXggbWlzc2luZyBFUkVTVEFSVFNZUyBjb252ZXJzaW9u
IGluIHJlYWQgcGF0aHMKCkNvbW1pdCBhYjA1Y2FjYTEyM2M2ZDBiNDE4NTBiN2MwNWIyNDZl
NGRjYTRhNzcwIHVwc3RyZWFtLgoKQm90aCByZWFkIGFuZCB3cml0ZSBtYXkgcmVjZWl2ZSBp
bnRlcm5hbCByZXN0YXJ0IGVycm9yIGNvZGVzIGZyb20KdGhlIGZpbGVzeXN0ZW0gbGF5ZXIg
YW5kIHNob3VsZCBiZSBjb252ZXJ0ZWQgdG8gLUVJTlRSLiBIb3dldmVyLAp3aGVuIG11bHRp
c2hvdCByZWFkIHN1cHBvcnQgd2FzIGFkZGVkLCB0aGUgZXJyb3IgY29kZSBub3JtYWxpemF0
aW9uCndhcyBsb3N0IGZvciBib3RoIGlvX3JlYWQoKSBhbmQgaW9fcmVhZF9tc2hvdCgpLgoK
RXh0cmFjdCB0aGUgY29udmVyc2lvbiBpbnRvIGlvX2ZpeHVwX3Jlc3RhcnRfcmVzKCkgYW5k
IGFwcGx5IGl0CmluIGFsbCB0aHJlZSBsb2NhdGlvbnM6IGlvX3J3X2RvbmUoKSwgaW9fcmVh
ZCgpLCBhbmQgaW9fcmVhZF9tc2hvdCgpLgoKRml4ZXM6IGEwOGQxOTViNTg2YSAoImlvX3Vy
aW5nL3J3OiBzcGxpdCBpb19yZWFkKCkgaW50byBhIGhlbHBlciIpCkNjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IFlpdGFuZyBZYW5nIDx5aTF0YW5nLnlhbmdA
Z21haWwuY29tPgpMaW5rOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjA3MjIxMjQ1
NTEuMTMwNTYzLTEteWkxdGFuZy55YW5nQGdtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBKZW5z
IEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvcncuYyB8IDI4ICsrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25z
KCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL3J3LmMgYi9pb191
cmluZy9ydy5jCmluZGV4IGI3NWY2MmRjY2NlNi4uY2JkM2VlOWE5MzczIDEwMDY0NAotLS0g
YS9pb191cmluZy9ydy5jCisrKyBiL2lvX3VyaW5nL3J3LmMKQEAgLTEyOSwyNyArMTI5LDM3
IEBAIHZvaWQgaW9fcmVhZHZfd3JpdGV2X2NsZWFudXAoc3RydWN0IGlvX2tpb2NiICpyZXEp
CiAJa2ZyZWUoaW8tPmZyZWVfaW92ZWMpOwogfQogCi1zdGF0aWMgaW5saW5lIHZvaWQgaW9f
cndfZG9uZShzdHJ1Y3Qga2lvY2IgKmtpb2NiLCBzc2l6ZV90IHJldCkKK3N0YXRpYyBpbmxp
bmUgc3NpemVfdCBpb19maXh1cF9yZXN0YXJ0X3Jlcyhzc2l6ZV90IHJldCkKIHsKIAlzd2l0
Y2ggKHJldCkgewotCWNhc2UgLUVJT0NCUVVFVUVEOgotCQlicmVhazsKIAljYXNlIC1FUkVT
VEFSVFNZUzoKIAljYXNlIC1FUkVTVEFSVE5PSU5UUjoKIAljYXNlIC1FUkVTVEFSVE5PSEFO
RDoKIAljYXNlIC1FUkVTVEFSVF9SRVNUQVJUQkxPQ0s6CiAJCS8qCiAJCSAqIFdlIGNhbid0
IGp1c3QgcmVzdGFydCB0aGUgc3lzY2FsbCwgc2luY2UgcHJldmlvdXNseQotCQkgKiBzdWJt
aXR0ZWQgc3FlcyBtYXkgYWxyZWFkeSBiZSBpbiBwcm9ncmVzcy4gSnVzdCBmYWlsIHRoaXMK
LQkJICogSU8gd2l0aCBFSU5UUi4KKwkJICogc3VibWl0dGVkIHNxZXMgbWF5IGFscmVhZHkg
YmUgaW4gcHJvZ3Jlc3MuIEp1c3QgZmFpbAorCQkgKiB0aGlzIElPIHdpdGggRUlOVFIuCiAJ
CSAqLwotCQlyZXQgPSAtRUlOVFI7Ci0JCWZhbGx0aHJvdWdoOworCQlyZXR1cm4gLUVJTlRS
OwogCWRlZmF1bHQ6Ci0JCWtpb2NiLT5raV9jb21wbGV0ZShraW9jYiwgcmV0KTsKKwkJcmV0
dXJuIHJldDsKIAl9CiB9CiAKK3N0YXRpYyBpbmxpbmUgdm9pZCBpb19yd19kb25lKHN0cnVj
dCBraW9jYiAqa2lvY2IsIHNzaXplX3QgcmV0KQoreworCS8qIElPIHdhcyBxdWV1ZWQgYXN5
bmMsIGNvbXBsZXRpb24gd2lsbCBoYXBwZW4gbGF0ZXIgKi8KKwlpZiAocmV0ID09IC1FSU9D
QlFVRVVFRCkKKwkJcmV0dXJuOworCisJLyogdHJhbnNmb3JtIGludGVybmFsIHJlc3RhcnQg
ZXJyb3IgY29kZXMgKi8KKwlpZiAodW5saWtlbHkocmV0IDwgMCkpCisJCXJldCA9IGlvX2Zp
eHVwX3Jlc3RhcnRfcmVzKHJldCk7CisKKwlraW9jYi0+a2lfY29tcGxldGUoa2lvY2IsIHJl
dCk7Cit9CisKIHN0YXRpYyBpbmxpbmUgbG9mZl90ICppb19raW9jYl91cGRhdGVfcG9zKHN0
cnVjdCBpb19raW9jYiAqcmVxKQogewogCXN0cnVjdCBpb19ydyAqcncgPSBpb19raW9jYl90
b19jbWQocmVxLCBzdHJ1Y3QgaW9fcncpOwpAQCAtODU0LDcgKzg2NCw3IEBAIGludCBpb19y
ZWFkKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpCiAJ
aWYgKHJldCA+PSAwKQogCQlyZXR1cm4ga2lvY2JfZG9uZShyZXEsIHJldCwgaXNzdWVfZmxh
Z3MpOwogCi0JcmV0dXJuIHJldDsKKwlyZXR1cm4gaW9fZml4dXBfcmVzdGFydF9yZXMocmV0
KTsKIH0KIAogc3RhdGljIGJvb2wgaW9fa2lvY2Jfc3RhcnRfd3JpdGUoc3RydWN0IGlvX2tp
b2NiICpyZXEsIHN0cnVjdCBraW9jYiAqa2lvY2IpCi0tIAoyLjUzLjAKCg==

--------------FkWF13RviL00rEE6UVExpNtb--
