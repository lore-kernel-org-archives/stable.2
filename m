Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707FC3563F6
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346176; cv=none; b=B5Va+6TvefR+hCc7lnw9SCLvc3J6bfQr69ZrJxaX7T71wr/4t62LMOwYZpHGd7Nvsw/FJlkEaQP58JfYz3WxPx+IH/Ub7QQeTC3gsBaqHnqAe2coqcS/DNc0HfjheL4jv0Tzgz8tT9luGsDwS81uXROSIvu0vM6ewbVhEOE+Bt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346176; c=relaxed/simple;
	bh=m2uV96cCFdepXN0e08nHVyMoWcOqlv6Ws6OPzffdUGM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=VsN9DlLZ9+AuIQ6xYmG1ltV6AUPQimooAncn/BwIaO5gF8fI34Ypi2WsYXDOco0MD9wVu3ThyQWLdfkId4CdYk/flASfARItjhHWiHx56aX527VHvGUiig46KBmG9nQ3phZrf+yOyCTcrOETqGfTxGp46PnzP9FkbMYXQD1ojHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=NMLRSW/B; arc=none smtp.client-ip=74.125.231.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="NMLRSW/B"
Received: by mail-oo2-f4.google.com with SMTP id 46e09a7af769-7e9f9a3167aso441424a34.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785346172; x=1785950972; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g9gxttqVSsUM9TSQcnJzRZpTojk6sKF7tku1XSr0RPg=;
        b=NMLRSW/BpJikrFNHU0I0oiHlyDR+LyiFDRrm2Rl/ArVA091QkBpTRtz0fiGNgnFJVJ
         oF1KccKg4hKi3Jc8Mk+5UcufWBISJzOiKmDx7ahyhB6d9G+8lkx0U6dIVF1DpHIy8eRg
         Zh3Dt/MRze3VvOFyAmSkPcIYMKMbpBfwuaDIELVNdzs18AhPRt+r+olW0XrwZD4YE5iA
         Ppc+2wQS7eUUHfPMw6AlyTneJlbisrnOOwefuflvfYc2iT3qC/36oKzTN0MHY90p+Yfv
         +S16tgXmNQeFu0KpqWBpJRs62rJ/tuqHWULxJlOSIaI/YKovoWH9otvFDONZeiLcp+/G
         YsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785346172; x=1785950972;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9gxttqVSsUM9TSQcnJzRZpTojk6sKF7tku1XSr0RPg=;
        b=e3BLpIF2nxtU5KJwRrzyjuw/mujBVe8Ma9VW0PNScMutVyVixxd80qjWtBCXhcSX9+
         jzbycMtUJhRgmY1d/5ImoVqQlY273ZC+7kss/orp5K7TBvqV2hkp/nLKeS8MmLGz0rv3
         GPU/pV0c4zhGh3soceizzMB36k5t4sNIhRe0kpqwL4BR338FUTR8ITo35aIKBFaQHSJp
         AhlUN8V2jGf+0If9xp//Y/B7ueS1bp+H8EfaPC/q16dDD2EenrjjdnSAuAODirwAY7bx
         xLDz4qfVNem5ZkeoRPdSoVOwX/aIKx0osvsfGs7sIO5u/PpSmpUYfI0Rg5Lj2TWxHz8w
         oAbA==
X-Gm-Message-State: AOJu0YzA0psps8LdixtkJIMH4xtCQ11sSnzyezTxFQUXn81lS4K4Qihg
	yZv9shGoRzXulqCmRL4EBt/TZScORpwCwoHt7pKaxHamlwc1SIofl4vHDw5OYfIs57DCvPt9iCC
	AVP4ecEqwXzSj
X-Gm-Gg: AR+sD11ERElKErUnN+scUYu4AVGNGiakRdQwFDxcBnaUxic7Htj9hVXwn898RXCDJh7
	zvn9FWP/thz22lVVzaFs92/4Pp8HvwMxEY9S1iNxTp3to0aPgSbFxqH6/vfm/mGOGjR7ghiljoP
	qLebXJODDnyWVO2pUrmyztKC1VKdXX6RTNAQzKkxY3u9i0IDajrOf/uR6mVRCD/F/w/abllImIJ
	todTWCbYQtrRfuVI94Nk/kO6z3FOBU4jYmOxtEwQijj7eu9UshDh5yEHvuzuOX+jdtyCqmERS7Q
	pVCXrOI5rTYtdjA7kBkqVHoycOaot3X9Wxw0uDWnRBYI1/dYv5M23HqioqHncpwrmlyGNwP5vJZ
	3BHPUzDcjQd9bqU+eh3kWbx6uOudAgA2h9oskyDJtcc88noy4Vs/x7IiO0+9aLN+Wx8NC+TGhR+
	nzTiNFKpjznYYolfsTR6yZR38u6Z2smvGHXF30VWJMFfn8Rb3DszxzHHvbN/hlozrt8NIeeJrVD
	PxlcIyq/kO+NQ==
X-Received: by 2002:a05:6830:6f49:b0:7e9:ea18:d1ea with SMTP id 46e09a7af769-7efff2f0dacmr4011733a34.28.1785346171904;
        Wed, 29 Jul 2026 10:29:31 -0700 (PDT)
Received: from [172.19.0.220] ([99.196.129.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d591d97sm2868764a34.3.2026.07.29.10.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 10:29:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------hiLeIIb4lz5D6rM2vgrpUOlU"
Message-ID: <db6e185e-85be-4906-b99f-9085a5fe619a@kernel.dk>
Date: Wed, 29 Jul 2026 11:29:21 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS
 conversion in read paths" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, yi1tang.yang@gmail.com
Cc: stable@vger.kernel.org
References: <2026072912-barn-caddy-3cea@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026072912-barn-caddy-3cea@gregkh>

This is a multi-part message in MIME format.
--------------hiLeIIb4lz5D6rM2vgrpUOlU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 7:50 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x ab05caca123c6d0b41850b7c05b246e4dca4a770
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072912-barn-caddy-3cea@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'
> 
> Possible dependencies:

Here's a version for 6.12 - which begs the question, why aren't we just
having LLMs do this work? Is it really worth punting this to the
maintainer? We could still punt for review, but trivial conflict
resolution seems like an area where we'd be better of having an LLM do
it. At least compared to using maintainer time.

-- 
Jens Axboe
--------------hiLeIIb4lz5D6rM2vgrpUOlU
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

--------------hiLeIIb4lz5D6rM2vgrpUOlU--
