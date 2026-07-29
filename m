Received: from mail-oo2-f9.google.com (mail-oo2-f9.google.com [74.125.231.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4634386561
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346794; cv=none; b=H8bPULx8I/RByPYE4jVaE+vx9fV+2Fqi1IUUQAjJwk6DtXDsLkSnA/3LVgNE0CKkLafK/zWW10fyz9ZcgfqZpaVhAASx/FMXrbWpjyDf9rlBE0J/k/bjk57H0D+W/bUiIg5zhcZ1MjAuazZR4303aKoTBR19UEItxMLI0Sor0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346794; c=relaxed/simple;
	bh=w4+TMhlMAPig3+fMG14kt7ikEeuix0GC8aK/4By2m6w=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=C8BjyqyyJKrKYMnZ23LX+OkCavjKKejeSBpIiNFD23r5gySzj903oWbzEPOShJ36uHRDfcL/n8NN8B7196hKsmP5J9r3PU97ti2Gi+umszyaz/CE+6zVYdthLAyOHLSeENq/+wOwZVzPw/Q25gq9gJmzYALoe+WdrK5ofcwMSZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=UzbXTYZH; arc=none smtp.client-ip=74.125.231.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="UzbXTYZH"
Received: by mail-oo2-f9.google.com with SMTP id 006d021491bc7-6acae2d21f6so188765eaf.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785346789; x=1785951589; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pRf55YmU3cktAKaSZXjRA+XY5EsLbzsOXbe0q6kz8ac=;
        b=UzbXTYZH+pvzCZPDOuGCoEfP5I3/dOEajurPjQD/cTelxMAnvF45AMVJpJLfZBQnza
         rxdVAEiOyl3uZ+AYB++w3L3sbHcWSceT1DZm7WOi1ytBTG6wBtDYkZOqab4cEQS6B/8F
         gfpJmsmbFXpvfplGGkJyKTXrJu3WYUWAw8ujug/MQO9GZh7mBk4O/NX6YV9Q+31Fl+bj
         qWsBU219+rmQJ4TAEFKsNJ6W4zC18JVeVcP/waEKGUrwow+wlJ/GJvLKfBjFPXETt9ji
         mPwV4ym/34IVW74tfKmMa/ZF48wuP9cs9NJYUCaAKK2J9yoqofanYeeo8lbBqKcyWvkQ
         yg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785346789; x=1785951589;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pRf55YmU3cktAKaSZXjRA+XY5EsLbzsOXbe0q6kz8ac=;
        b=KVIKra+gMTQaSznntdrSol77H1Lbvq36hTgE/M3ajBdHtUCGdAg1CmsBIvoro2cad3
         o6o9Mrf7VEfBXfLcmetAOxWC7lmq+VNHQSEhJl/GL/SwigqdRyY8m2xmyKWT0Re8FFYC
         jIZb5XmBfkGFX2u/0pe9Mk+HkTQ4GqKIYKCan+QU7uju0SKn9BTxcvbIoBUyHbEElh43
         A9QFxl8f1DzaERVUkPDJC3i5vEMtKjbXxwz/3L549stIA5q4rfiRU2IQoQ/PFimS9Gc/
         DEPwWFlNVPelMEhdVbSlb6GiZtYib8wxhS0+9sqA1F3y6jaUhsY5ZvPq1VX5n2VxJtCo
         hc3Q==
X-Gm-Message-State: AOJu0YxKDPb2W1cqcc0ANiSypan1OSt2sQHadBROT8Klt5NIjVE+e7ks
	vL7oJAwgRC6GYPz57O7cNxcpI/80nRAFcrMAv+7c6qd2dJe4Ol0iVzzWcoXF5vX8uIU=
X-Gm-Gg: AR+sD10D1VpNFpd2X0qhHgtHqIKTirgY9A/cGZNLnuVbpM/zVrSXgcqhBHWWE2B2GNv
	Wf2xLL7e7mmljIsN9N9km/5xpJvORWHHkQGHCc9KgH5WhEU8lcLQK2I0kaef0/xOdVHyURi+ZwK
	VbKfTncSA57jKrcimXfxUlF19XyUuHOJG8zHfR2a0XGldMY5OuVN83kZOtnJTd7kKg12f1QKrs6
	2iGGG0czc5qKhDrNdcZfGWOlMeiAF0b4zRn41y5EVwH51kuU/6jwYUutZ0eeVWJ9Mb+Xy1cFQc5
	jsBryNxPs9zc77MWvHGJripplx1kmOxg5XCF1eU5kbolu1Bj01n3m6h85CrAMa1jh8KvySFQrZ8
	dqnc1LjXkToU/XkPWTJyPbcLomxuy1NzbBXe0xQAablBMPRp/SszoRq3pAT7uub8iyRTIlWv6lZ
	XOBM63M8JidK07HUrpfF16sePvfgnVsc/TArsI/IQtm6PIL9R32BGXb7Zq1xKyJFaBzXyddlw/G
	Gk4gufXCASyMQ==
X-Received: by 2002:a4a:ee12:0:b0:6a5:1a26:a95a with SMTP id 006d021491bc7-6ac96c96817mr3961204eaf.37.1785346789610;
        Wed, 29 Jul 2026 10:39:49 -0700 (PDT)
Received: from [172.19.0.220] ([99.196.129.79])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4588646ade0sm2840561fac.5.2026.07.29.10.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 10:39:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------57YVaeSDtNWrE27ePNaCnXFQ"
Message-ID: <12e797ce-62e3-48a3-9584-065d491750f9@kernel.dk>
Date: Wed, 29 Jul 2026 11:39:38 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS
 conversion in read paths" failed to apply to 6.12-stable tree
From: Jens Axboe <axboe@kernel.dk>
To: gregkh@linuxfoundation.org, yi1tang.yang@gmail.com
Cc: stable@vger.kernel.org
References: <2026072912-manpower-thrift-f2fd@gregkh>
 <34c09190-027c-4b00-92f4-17b5da059af5@kernel.dk>
 <d7716c35-8b74-4d91-9830-3bd4b2509e14@kernel.dk>
Content-Language: en-US
In-Reply-To: <d7716c35-8b74-4d91-9830-3bd4b2509e14@kernel.dk>

This is a multi-part message in MIME format.
--------------57YVaeSDtNWrE27ePNaCnXFQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 10:44 AM, Jens Axboe wrote:
> On 7/29/26 10:35 AM, Jens Axboe wrote:
>> On 7/29/26 7:50 AM, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 6.12-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x ab05caca123c6d0b41850b7c05b246e4dca4a770
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072912-manpower-thrift-f2fd@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'
>>
>> Seems that's already in 6.12-stable?
> 
> No sorry, I'm blind. I'll take care of this and the 6.6 one.

Here's the 6.12-stable one, sorry for the mixed emails.

-- 
Jens Axboe

--------------57YVaeSDtNWrE27ePNaCnXFQ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-rw-fix-missing-ERESTARTSYS-conversion-in-re.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-rw-fix-missing-ERESTARTSYS-conversion-in-re.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2OTQwNTZhNDE3MGRmNjk0ZjA2ODlhYTYyZDQxM2Y4NzI4NjM4YzliIE1vbiBTZXAg
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
IEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvcncuYyB8IDQyICsrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDI1IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2lvX3Vy
aW5nL3J3LmMgYi9pb191cmluZy9ydy5jCmluZGV4IGE3NDRjYjVkMjM1YS4uYTc0NjY0YzRh
MDVlIDEwMDY0NAotLS0gYS9pb191cmluZy9ydy5jCisrKyBiL2lvX3VyaW5nL3J3LmMKQEAg
LTU2MCw2ICs1NjAsMjQgQEAgc3RhdGljIHZvaWQgaW9fY29tcGxldGVfcndfaW9wb2xsKHN0
cnVjdCBraW9jYiAqa2lvY2IsIGxvbmcgcmVzKQogCXNtcF9zdG9yZV9yZWxlYXNlKCZyZXEt
PmlvcG9sbF9jb21wbGV0ZWQsIDEpOwogfQogCitzdGF0aWMgaW5saW5lIHNzaXplX3QgaW9f
Zml4dXBfcmVzdGFydF9yZXMoc3NpemVfdCByZXQpCit7CisJc3dpdGNoIChyZXQpIHsKKwlj
YXNlIC1FUkVTVEFSVFNZUzoKKwljYXNlIC1FUkVTVEFSVE5PSU5UUjoKKwljYXNlIC1FUkVT
VEFSVE5PSEFORDoKKwljYXNlIC1FUkVTVEFSVF9SRVNUQVJUQkxPQ0s6CisJCS8qCisJCSAq
IFdlIGNhbid0IGp1c3QgcmVzdGFydCB0aGUgc3lzY2FsbCwgc2luY2UgcHJldmlvdXNseQor
CQkgKiBzdWJtaXR0ZWQgc3FlcyBtYXkgYWxyZWFkeSBiZSBpbiBwcm9ncmVzcy4gSnVzdCBm
YWlsCisJCSAqIHRoaXMgSU8gd2l0aCBFSU5UUi4KKwkJICovCisJCXJldHVybiAtRUlOVFI7
CisJZGVmYXVsdDoKKwkJcmV0dXJuIHJldDsKKwl9Cit9CisKIHN0YXRpYyBpbmxpbmUgdm9p
ZCBpb19yd19kb25lKHN0cnVjdCBraW9jYiAqa2lvY2IsIHNzaXplX3QgcmV0KQogewogCS8q
IElPIHdhcyBxdWV1ZWQgYXN5bmMsIGNvbXBsZXRpb24gd2lsbCBoYXBwZW4gbGF0ZXIgKi8K
QEAgLTU2NywyMSArNTg1LDggQEAgc3RhdGljIGlubGluZSB2b2lkIGlvX3J3X2RvbmUoc3Ry
dWN0IGtpb2NiICpraW9jYiwgc3NpemVfdCByZXQpCiAJCXJldHVybjsKIAogCS8qIHRyYW5z
Zm9ybSBpbnRlcm5hbCByZXN0YXJ0IGVycm9yIGNvZGVzICovCi0JaWYgKHVubGlrZWx5KHJl
dCA8IDApKSB7Ci0JCXN3aXRjaCAocmV0KSB7Ci0JCWNhc2UgLUVSRVNUQVJUU1lTOgotCQlj
YXNlIC1FUkVTVEFSVE5PSU5UUjoKLQkJY2FzZSAtRVJFU1RBUlROT0hBTkQ6Ci0JCWNhc2Ug
LUVSRVNUQVJUX1JFU1RBUlRCTE9DSzoKLQkJCS8qCi0JCQkgKiBXZSBjYW4ndCBqdXN0IHJl
c3RhcnQgdGhlIHN5c2NhbGwsIHNpbmNlIHByZXZpb3VzbHkKLQkJCSAqIHN1Ym1pdHRlZCBz
cWVzIG1heSBhbHJlYWR5IGJlIGluIHByb2dyZXNzLiBKdXN0IGZhaWwKLQkJCSAqIHRoaXMg
SU8gd2l0aCBFSU5UUi4KLQkJCSAqLwotCQkJcmV0ID0gLUVJTlRSOwotCQkJYnJlYWs7Ci0J
CX0KLQl9CisJaWYgKHVubGlrZWx5KHJldCA8IDApKQorCQlyZXQgPSBpb19maXh1cF9yZXN0
YXJ0X3JlcyhyZXQpOwogCiAJSU5ESVJFQ1RfQ0FMTF8yKGtpb2NiLT5raV9jb21wbGV0ZSwg
aW9fY29tcGxldGVfcndfaW9wb2xsLAogCQkJaW9fY29tcGxldGVfcncsIGtpb2NiLCByZXQp
OwpAQCAtOTYxLDcgKzk2Niw4IEBAIGludCBpb19yZWFkKHN0cnVjdCBpb19raW9jYiAqcmVx
LCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpCiAKIAlpZiAocmVxLT5mbGFncyAmIFJFUV9G
X0JVRkZFUlNfQ09NTUlUKQogCQlpb19rYnVmX3JlY3ljbGUocmVxLCBzZWwuYnVmX2xpc3Qs
IGlzc3VlX2ZsYWdzKTsKLQlyZXR1cm4gcmV0OworCisJcmV0dXJuIGlvX2ZpeHVwX3Jlc3Rh
cnRfcmVzKHJldCk7CiB9CiAKIGludCBpb19yZWFkX21zaG90KHN0cnVjdCBpb19raW9jYiAq
cmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpCkBAIC05OTUsOCArMTAwMSwxMCBAQCBp
bnQgaW9fcmVhZF9tc2hvdChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlz
c3VlX2ZsYWdzKQogCQlyZXR1cm4gLUVBR0FJTjsKIAl9IGVsc2UgaWYgKHJldCA8PSAwKSB7
CiAJCWlvX2tidWZfcmVjeWNsZShyZXEsIHNlbC5idWZfbGlzdCwgaXNzdWVfZmxhZ3MpOwot
CQlpZiAocmV0IDwgMCkKKwkJaWYgKHJldCA8IDApIHsKKwkJCXJldCA9IGlvX2ZpeHVwX3Jl
c3RhcnRfcmVzKHJldCk7CiAJCQlyZXFfc2V0X2ZhaWwocmVxKTsKKwkJfQogCX0gZWxzZSBp
ZiAoIShyZXEtPmZsYWdzICYgUkVRX0ZfQVBPTExfTVVMVElTSE9UKSkgewogCQljZmxhZ3Mg
PSBpb19wdXRfa2J1ZihyZXEsIHJldCwgc2VsLmJ1Zl9saXN0KTsKIAl9IGVsc2UgewotLSAK
Mi41My4wCgo=

--------------57YVaeSDtNWrE27ePNaCnXFQ--
