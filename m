Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96463381AE0
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346705; cv=none; b=kvDqGyPklF3xZ03CcFIqwI33AxK2xH/U3LgRlKbwC1uVLyhpKt9nmlVaqL5i4vLUNaw0q7vlnU9K9PEfTi4PEmk81jr+XyUf7UeS0lIdX2K4/TJqxpDodphyBiFnOPRb/fBwGtB5S8Y58n8PrOJUFnwAikY0g6rpGvEkEDN2TXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346705; c=relaxed/simple;
	bh=5EfUiy0L9MzkfOnMhjMEm/ip/RAlFX7bGfVmuxQmZAs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=aqzPhinC2YRSETtqF8TxmvYrIMihvwK8Ch0RC8LwqZbupt9XVImkfMsz9VZg0FDB6X/50X33GoS9VbDsLxC5Ou8ubi+YXQBFLlFdvC8eSqB8WklMZNtqm3oU+bjsp/O/LUKBHHrAoCQysXAhidIjuBAlw7cXmSHFYQJPB25dr2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=WhIARgbW; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="WhIARgbW"
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-45837c2330eso846895fac.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785346698; x=1785951498; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=npIddUayJcWvzRHQwDYe02BvpNvh49n2fzy3zxKWtCs=;
        b=WhIARgbWJyVbQ5Nnn+P9wW2EIkqQJ0M6YVqIq1g6hOFjLP101je2QPyiLfDeBGcnAs
         CInzAnTxq6AQ2oIRTg10skrh9Apr8V/0tH1oy8FrNQgVeSlwQZCk+hADlgFN7s241HB8
         HAczCaRBSREN9sxSDDP9GVXaqXV+UejSKWy5Cx2jE3VnnLSnZA9eq6+Q5zdvTnfAIleR
         5JnPyW3qMRCfvAexg4I1Bx2j/LMJuCX+tYCUWaDFH9KiXBk+OFyR3nIgaPDlt9OlbsW4
         pq4yJVPAWUB3bjiVA/X3RCAGjI+wnRSSVKFEpk6pKqKzopPZOtp/yKjfA2jcgeR6aDMt
         sZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785346698; x=1785951498;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=npIddUayJcWvzRHQwDYe02BvpNvh49n2fzy3zxKWtCs=;
        b=QUXTQwCgNE/83+xtoh/YeJ6xP5/KLm+i4A0Cvhs4vTS9zrJt5NZjKRJRGKYRdeKQtu
         NcF4oerr5Xn66SMseNcrdSsjFIBhC5YK1zvsIXMpbu9hyHQNO/wV+sZlKJKFcyNtI2z4
         4P4weO/VFFJRQYI/9dLj9212aNbU+i049dgibDofFE00vqrlvOTEUwByqR5ChW0rrohm
         1ZJIgjdHvjgNmenWhYe2sqZBJ+aEi66kfWTKd0Myma3JLTEzorQxATB+6B02i5v1QNEd
         QcgdSicq21+3Xj/hU+gRda74mbBO240slu8dC2RIfewKoMA4FbcSwiiGGmx2EEW9Ounl
         cBiA==
X-Gm-Message-State: AOJu0YzmI2qSuf2WnjGOOGKrGpg6XbHcpHTvR9qsoSeB0+BCcoxQ/YR0
	+NbbqAnWnylMCBHwmpqeq727Gd6E+rMKK+MMI+niQ57qY/jS6+K8D0VMrePwxIQBZyU=
X-Gm-Gg: AR+sD1359D1clV1OfGhnB+SugaIb/jYcAK/j4MD05NTZda0b+/73nC6yTjycJs8RGwS
	NlFuIWMvkagUWal5eMDvtB4Im8A52Vpo0ZKiGJ9Y4syxRS/VfNMYhxJDWS4ZvhYyWiZNvcFAKJn
	os3O2VOxKX4p+NyRljtP9Tfpnh+oYOF6TlqB5Rl1YCYdCzv9xo1ERkLxApLS3aQxsjLN6mVxPeB
	kOLLsAfU9L/M30BK+0yy6AsPRx6Fv5FqCNbprZXBycU3P1SZFJmhtc9gxRwx1E+EG+e13vPek/b
	nf6nHG3o4tUNCJ3TXRUJ01VvRxXNeWgu4U1Api4o9EAzJ2xayVvLOPExtnLhPQl14N/ortMerCd
	91BnlXzlyXoS2OgeWMraWoFgK1y0LnSrpDhNYfvalljJQ2o9FBiJlhNtLMjeNKrhHgai9Hoir11
	F7lyCBGsoOQ12WMJ/k/+RLtGKp3+yhqgyvUVg5MDrndBQ1rLv27+geUFwbOxOFIS9GCki4P+glT
	MReIu9WNEBGcdkkbFaAuhAt
X-Received: by 2002:a4a:e917:0:b0:6aa:f7ac:fb01 with SMTP id 006d021491bc7-6ac96cacd74mr4313577eaf.51.1785346698502;
        Wed, 29 Jul 2026 10:38:18 -0700 (PDT)
Received: from [172.19.0.220] ([99.196.129.79])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aca500bf69sm2416067eaf.0.2026.07.29.10.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 10:38:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Qku28JXaQ83Ir2GX9vkWIG23"
Message-ID: <386b57ff-d042-4507-b09f-84283b84b37b@kernel.dk>
Date: Wed, 29 Jul 2026 11:38:06 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS
 conversion in read paths" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, yi1tang.yang@gmail.com
Cc: stable@vger.kernel.org
References: <2026072912-brick-favoring-9892@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026072912-brick-favoring-9892@gregkh>

This is a multi-part message in MIME format.
--------------Qku28JXaQ83Ir2GX9vkWIG23
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 7:50 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x ab05caca123c6d0b41850b7c05b246e4dca4a770
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072912-brick-favoring-9892@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'
> 
> Possible dependencies:

Here's one for 6.6.

-- 
Jens Axboe

--------------Qku28JXaQ83Ir2GX9vkWIG23
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-rw-fix-missing-ERESTARTSYS-conversion-in-re.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-rw-fix-missing-ERESTARTSYS-conversion-in-re.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiZTUzMGI1ODBkNDFmODM4N2NkZWEwYzhmYzJhNmM3NmJjNzg0MGM1IE1vbiBTZXAg
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
ZCgpLCBhbmQgaW9fcmVhZF9tc2hvdCgpLgoKWyA2LjYgZG9lc24ndCBoYXZlIG11bHRpc2hv
dCByZWFkLCBkcm9wIHRoZSBpb19yZWFkX21zaG90KCkgaHVuayBhbmQKICBhZGFwdCBpb19y
d19kb25lKCkgdG8gdGhlIG9sZGVyIGNhbGxpbmcgY29udmVudGlvbiBdCgpGaXhlczogYTA4
ZDE5NWI1ODZhICgiaW9fdXJpbmcvcnc6IHNwbGl0IGlvX3JlYWQoKSBpbnRvIGEgaGVscGVy
IikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogWWl0YW5nIFlh
bmcgPHlpMXRhbmcueWFuZ0BnbWFpbC5jb20+Ckxpbms6IGh0dHBzOi8vcGF0Y2gubXNnaWQu
bGluay8yMDI2MDcyMjEyNDU1MS4xMzA1NjMtMS15aTF0YW5nLnlhbmdAZ21haWwuY29tClNp
Z25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmlu
Zy9ydy5jIHwgMjggKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDE5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9f
dXJpbmcvcncuYyBiL2lvX3VyaW5nL3J3LmMKaW5kZXggNGZmMzQ0MmFjMmVlLi5mMmFiOTY3
Yjk1MDcgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL3J3LmMKKysrIGIvaW9fdXJpbmcvcncuYwpA
QCAtMTQwLDI3ICsxNDAsMzcgQEAgdm9pZCBpb19yZWFkdl93cml0ZXZfY2xlYW51cChzdHJ1
Y3QgaW9fa2lvY2IgKnJlcSkKIAlrZnJlZShpby0+ZnJlZV9pb3ZlYyk7CiB9CiAKLXN0YXRp
YyBpbmxpbmUgdm9pZCBpb19yd19kb25lKHN0cnVjdCBraW9jYiAqa2lvY2IsIHNzaXplX3Qg
cmV0KQorc3RhdGljIGlubGluZSBzc2l6ZV90IGlvX2ZpeHVwX3Jlc3RhcnRfcmVzKHNzaXpl
X3QgcmV0KQogewogCXN3aXRjaCAocmV0KSB7Ci0JY2FzZSAtRUlPQ0JRVUVVRUQ6Ci0JCWJy
ZWFrOwogCWNhc2UgLUVSRVNUQVJUU1lTOgogCWNhc2UgLUVSRVNUQVJUTk9JTlRSOgogCWNh
c2UgLUVSRVNUQVJUTk9IQU5EOgogCWNhc2UgLUVSRVNUQVJUX1JFU1RBUlRCTE9DSzoKIAkJ
LyoKIAkJICogV2UgY2FuJ3QganVzdCByZXN0YXJ0IHRoZSBzeXNjYWxsLCBzaW5jZSBwcmV2
aW91c2x5Ci0JCSAqIHN1Ym1pdHRlZCBzcWVzIG1heSBhbHJlYWR5IGJlIGluIHByb2dyZXNz
LiBKdXN0IGZhaWwgdGhpcwotCQkgKiBJTyB3aXRoIEVJTlRSLgorCQkgKiBzdWJtaXR0ZWQg
c3FlcyBtYXkgYWxyZWFkeSBiZSBpbiBwcm9ncmVzcy4gSnVzdCBmYWlsCisJCSAqIHRoaXMg
SU8gd2l0aCBFSU5UUi4KIAkJICovCi0JCXJldCA9IC1FSU5UUjsKLQkJZmFsbHRocm91Z2g7
CisJCXJldHVybiAtRUlOVFI7CiAJZGVmYXVsdDoKLQkJa2lvY2ItPmtpX2NvbXBsZXRlKGtp
b2NiLCByZXQpOworCQlyZXR1cm4gcmV0OwogCX0KIH0KIAorc3RhdGljIGlubGluZSB2b2lk
IGlvX3J3X2RvbmUoc3RydWN0IGtpb2NiICpraW9jYiwgc3NpemVfdCByZXQpCit7CisJLyog
SU8gd2FzIHF1ZXVlZCBhc3luYywgY29tcGxldGlvbiB3aWxsIGhhcHBlbiBsYXRlciAqLwor
CWlmIChyZXQgPT0gLUVJT0NCUVVFVUVEKQorCQlyZXR1cm47CisKKwkvKiB0cmFuc2Zvcm0g
aW50ZXJuYWwgcmVzdGFydCBlcnJvciBjb2RlcyAqLworCWlmICh1bmxpa2VseShyZXQgPCAw
KSkKKwkJcmV0ID0gaW9fZml4dXBfcmVzdGFydF9yZXMocmV0KTsKKworCWtpb2NiLT5raV9j
b21wbGV0ZShraW9jYiwgcmV0KTsKK30KKwogc3RhdGljIGlubGluZSBsb2ZmX3QgKmlvX2tp
b2NiX3VwZGF0ZV9wb3Moc3RydWN0IGlvX2tpb2NiICpyZXEpCiB7CiAJc3RydWN0IGlvX3J3
ICpydyA9IGlvX2tpb2NiX3RvX2NtZChyZXEsIHN0cnVjdCBpb19ydyk7CkBAIC04ODUsNyAr
ODk1LDcgQEAgaW50IGlvX3JlYWQoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGlu
dCBpc3N1ZV9mbGFncykKIAlpZiAocmV0ID49IDApCiAJCXJldHVybiBraW9jYl9kb25lKHJl
cSwgcmV0LCBpc3N1ZV9mbGFncyk7CiAKLQlyZXR1cm4gcmV0OworCXJldHVybiBpb19maXh1
cF9yZXN0YXJ0X3JlcyhyZXQpOwogfQogCiBzdGF0aWMgYm9vbCBpb19raW9jYl9zdGFydF93
cml0ZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgc3RydWN0IGtpb2NiICpraW9jYikKLS0gCjIu
NTMuMAoK

--------------Qku28JXaQ83Ir2GX9vkWIG23--
