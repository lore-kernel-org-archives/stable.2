Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87F427FB9
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840411; cv=none; b=YvCjFq7BWKYmIX+bK0L0nk/yR3/3mdNFms5wYzWzmKRrP9rXQjiDu5iaCsqWdAoAHIVxBr2/TCxkPw5B1DJwml5ABZipOFiExHWxFHqgwziNdu7l0bbE/j/d40IRLujdj0BRj772lFCYK/fCs6FpoxqGa0tNRtKwrheTEHRx6JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840411; c=relaxed/simple;
	bh=tfImHvu+oowmfu3pUuQLeL84KWFSBKUclIojlIl827I=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=XIAkCPZbH/eg9XraVuz80Ie5nQnp6MRWgKQh+PPJQThN2B09yQvYLn0avbwsOJLtekBBeio9rbFO4ICWU34ka5MrdPKy2O6PdWqQiSQztvxrcu922uToJlEDeDqHZythrkZwcXOModhlCRc6TAhO7Z+AVc9Wf2gJhQiwu209AZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=BH/rndAw; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="BH/rndAw"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33fb4680717so4230812eec.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791840408; x=1792445208; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wfKdoZf9TR8nt1Lt7jqXgn3vlb0TSOBQ5QaO477YjVo=;
        b=BH/rndAwt6mCghBMgbVTQ2nVLd3RbYpGsnh+7DJcn5lGfIWLBe9Jsgc9L5eiyCB0xN
         fnogvBrI8qkEeIl6v9N8Xfv+YWyW2wutbvNtg3uOxZ4Z8sA+re4ij+6PIFe49xZ+4wfl
         vshaCfnf4m8IDN+yx3FN/uQ7v+Ha5XNwikLvInJX0BFp6EW9AWSBanPly0GP6lrAtQi2
         3XqD29q6x2fbKdJ4efVJ/bYMvWGBq5+x4lU5JLs/o/WfyXhm0g3+0tsTvStW+mavFljE
         lATf6xgi2w26DRlrz3mvWhBrb613EGzcq1rkhleLZ1PBYKEkSqvi3nl/DH7R5hXz9p3W
         YyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791840408; x=1792445208;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wfKdoZf9TR8nt1Lt7jqXgn3vlb0TSOBQ5QaO477YjVo=;
        b=ggvpNmMaHNKX9RrwmIjtixV/JRXOmJ4fJMnZ9DUurQHsKKdG78w5fWmErZyO+AZSUB
         7zBYRd0ebPPE5BoaIo6FpsNAFq5My+zmtZLlyaJ8W8TK1EWJNlHvzD5q/Dawn82icIYD
         BMLJBrk0zaM/tMs+5eQIOBSZZBmcyJ1HSOElaxOBYHie5K+ofNkCIPv/j/Aka2TQOrNU
         kjY+uyJq6O8AJbWc/qEPz6VAaM+M8azXv1xwn2HqKs2J6u9HJwpD7EfwQUISpiTxaFRU
         rMdtsDo8ZfEoCnZk+s8a7nchqu8epeaqBh6kcEG9IPG9HdUTz/R2Ub0ZO5RkpDRwYyy+
         m6Ow==
X-Gm-Message-State: AFq9FYISTIjbzk9YWXX8ubgAVK/RsEmXjeCGf+miBaNGX6CK4AU4co4M
	BzxRSpUF78Gng2MJce6E8UoQDiyPDJlrCRT0tKxKUY4WWdcnoAfzMFnfV1283EAJ0Lw=
X-Gm-Gg: AYBFou0C2zxMPK8zvz3LO5AHis+qF4PKevDwv97Fb0/n9NWzkeNqYoQf5DLZsPIGEMX
	u4MtsBQ0vwC2anydtK7Tm6/xMfz3gvJN/Z/ehLon3SS6N/0/6sFcd3u+tg5hwb3ynxJWxjKP0J2
	A3Iq/+tOon2Xx8VREF5dgNaarFWjzqr1AlXA7ucYSsAOubhUwWCL9rqWMeckmjQ8ZTkpf9jT44a
	NLFdup5e6DcR0lJ6uaCXFSQNQLRybSooGMS8eq/ngyTmgtKszVO/hdw73ViJ/xdldiv+Am6C9ql
	cAOAYhpvysZvdiqZi3PMPsidnXyEva3biYvpYT22DBARpusc59Q88PbpgaJrmtZn3FxEZllYo9O
	oRf6XBAuDHoMzaLxOIeOYkbGkBm6DlE4H8NDdmXODJiM9sljEazmjRcKenz/HzV3gZ67bh141nX
	MY2JD9j2d6BbFssNqJlD2LEkNSezXYKhB+tI7azJ8VkPHGmZYTwaQn+SflXLF1f/DT8LOIMu0b7
	/cfzR7iu/R2PTCXn/LrNB/lBw+aLqho7EUoiNQg9JVXZ/6+bTGFmfxvug==
X-Received: by 2002:a05:701b:2607:b0:144:f096:4dd1 with SMTP id a92af1059eb24-16a611c76a1mr13290149c88.41.1791840407481;
        Mon, 12 Oct 2026 14:26:47 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a42407e7sm32979216c88.15.2026.10.12.14.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:26:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ZRzk5eHxcaI0l76H2M6IZ93E"
Message-ID: <6ed8abf0-15d3-4de9-88e2-a44a7a11b32b@kernel.dk>
Date: Mon, 12 Oct 2026 15:26:46 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/waitid: fix KCSAN warning on
 io_waitid->head" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2026093018-boneless-remorse-ee12@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026093018-boneless-remorse-ee12@gregkh>

This is a multi-part message in MIME format.
--------------ZRzk5eHxcaI0l76H2M6IZ93E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/26 8:59 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x b994ace83a2bc7699420f6a4c6b860c8da133159
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026093018-boneless-remorse-ee12@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'
> 
> Possible dependencies:

Missing dependency, here's the dep with the commit too.

-- 
Jens Axboe
--------------ZRzk5eHxcaI0l76H2M6IZ93E
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-waitid-fix-KCSAN-warning-on-io_waitid-head.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-waitid-fix-KCSAN-warning-on-io_waitid-head.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSA3MDliNjQwN2ZmNmQ3Mzk5OGYwYmVjMGUzOWUzYmQwNWNjMDRiMDk5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMTkgSmFuIDIwMjYgMTk6NDY6MjYgLTA3MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gaW9fdXJpbmcvd2FpdGlkOiBmaXggS0NTQU4gd2FybmluZyBvbiBpb193YWl0aWQtPmhl
YWQKCkNvbW1pdCBiOTk0YWNlODNhMmJjNzY5OTQyMGY2YTRjNmI4NjBjOGRhMTMzMTU5IHVw
c3RyZWFtLgoKU3RvcmluZyBvZiB0aGUgaXctPmhlYWQgZW50cnkgaW5zaWRlIHRoZSB3YWl0
X3F1ZXVlIGNhbGxiYWNrLCBvciB3aGVuCnJlbW92aW5nIGEgd2FpdGlkIGl0ZW0sIHJlYWxs
eSBzaG91bGQgdXNlIHByb3BlciBsb2FkL3N0b3JlCmFjcXVpcmUvcmVsZWFzZSBzZW1hbnRp
Y3MsIGFuZCBLQ1NBTiBjb3JyZWN0bHkgd2FybnMgb2YgdGhhdC4gRW5zdXJlCnRoYXQgdGhl
eSBkbyBzby4KClJlcG9ydGVkLWJ5OiBzeXpib3QrZWI0NDE3NzVmNGY5NDhhMDkwMmZAc3l6
a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpGaXhlczogYTQ4YzBjYmYyOGMwICgiaW9fdXJpbmcv
d2FpdGlkOiBoYXZlIGlvX3dhaXRpZF9jb21wbGV0ZSgpIHJlbW92ZSB3YWl0IHF1ZXVlIGVu
dHJ5IikKU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0K
IGlvX3VyaW5nL3dhaXRpZC5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvd2FpdGlk
LmMgYi9pb191cmluZy93YWl0aWQuYwppbmRleCA4NTIwNjVkZjgwMjQuLjdmM2E2YzJkOWY4
MCAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvd2FpdGlkLmMKKysrIGIvaW9fdXJpbmcvd2FpdGlk
LmMKQEAgLTEyMCwxMSArMTIwLDExIEBAIHN0YXRpYyB2b2lkIGlvX3dhaXRpZF9yZW1vdmVf
d3Eoc3RydWN0IGlvX2tpb2NiICpyZXEpCiAJc3RydWN0IGlvX3dhaXRpZCAqaXcgPSBpb19r
aW9jYl90b19jbWQocmVxLCBzdHJ1Y3QgaW9fd2FpdGlkKTsKIAlzdHJ1Y3Qgd2FpdF9xdWV1
ZV9oZWFkICpoZWFkOwogCi0JaGVhZCA9IFJFQURfT05DRShpdy0+aGVhZCk7CisJaGVhZCA9
IHNtcF9sb2FkX2FjcXVpcmUoJml3LT5oZWFkKTsKIAlpZiAoaGVhZCkgewogCQlzdHJ1Y3Qg
aW9fd2FpdGlkX2FzeW5jICppd2EgPSByZXEtPmFzeW5jX2RhdGE7CiAKLQkJaXctPmhlYWQg
PSBOVUxMOworCQlzbXBfc3RvcmVfcmVsZWFzZSgmaXctPmhlYWQsIE5VTEwpOwogCQlzcGlu
X2xvY2tfaXJxKCZoZWFkLT5sb2NrKTsKIAkJbGlzdF9kZWxfaW5pdCgmaXdhLT53by5jaGls
ZF93YWl0LmVudHJ5KTsKIAkJc3Bpbl91bmxvY2tfaXJxKCZoZWFkLT5sb2NrKTsKQEAgLTI5
MSw3ICsyOTEsNyBAQCBzdGF0aWMgaW50IGlvX3dhaXRpZF93YWl0KHN0cnVjdCB3YWl0X3F1
ZXVlX2VudHJ5ICp3YWl0LCB1bnNpZ25lZCBtb2RlLAogCQlyZXR1cm4gMDsKIAogCWxpc3Rf
ZGVsX2luaXQoJndhaXQtPmVudHJ5KTsKLQlpdy0+aGVhZCA9IE5VTEw7CisJc21wX3N0b3Jl
X3JlbGVhc2UoJml3LT5oZWFkLCBOVUxMKTsKIAogCS8qIGNhbmNlbCBpcyBpbiBwcm9ncmVz
cyAqLwogCWlmIChhdG9taWNfZmV0Y2hfaW5jKCZpdy0+cmVmcykgJiBJT19XQUlUSURfUkVG
X01BU0spCi0tIAoyLjU2LjAKCg==
--------------ZRzk5eHxcaI0l76H2M6IZ93E
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-waitid-use-io_waitid_remove_wq-consistently.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-waitid-use-io_waitid_remove_wq-consistently.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjOGU3NmIzNzE2NmM4NTRlYmVlMDQ1NjBjNzllMDNmNjUxMWU1ZGZlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgOSBPY3QgMjAyNSAxMDo1NTowOCAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBpb191cmluZy93YWl0aWQ6IHVzZSBpb193YWl0aWRfcmVtb3ZlX3dxKCkgY29uc2lzdGVu
dGx5CgpDb21taXQgYWI2NzNjMWJjYWYyMGFjNzAzNTJlZWI2YmY1YjgyODQ2MjY3NjY5MyB1
cHN0cmVhbS4KClVzZSBpdCBldmVyeXdoZXJlIHRoYXQgdGhlIHdhaXRfcXVldWVfZW50cnkg
aXMgcmVtb3ZlZCBmcm9tIHRoZSBoZWFkLAphbmQgYmUgYSBiaXQgbW9yZSBjYXV0aW91cyBp
biB6ZXJvaW5nIG91dCBpdy0+aGVhZCB3aGVuZXZlciB0aGUgZW50cnkgaXMKcmVtb3ZlZCBm
cm9tIHRoZSBsaXN0LgoKU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVs
LmRrPgotLS0KIGlvX3VyaW5nL3dhaXRpZC5jIHwgMTUgKysrKysrKysrKystLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9pb191cmluZy93YWl0aWQuYyBiL2lvX3VyaW5nL3dhaXRpZC5jCmluZGV4IGUwZjA0
OWNlNTI4MC4uODUyMDY1ZGY4MDI0IDEwMDY0NAotLS0gYS9pb191cmluZy93YWl0aWQuYwor
KysgYi9pb191cmluZy93YWl0aWQuYwpAQCAtMjI1LDE4ICsyMjUsMTggQEAgYm9vbCBpb193
YWl0aWRfcmVtb3ZlX2FsbChzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwgc3RydWN0IHRhc2tf
c3RydWN0ICp0YXNrLAogc3RhdGljIGlubGluZSBib29sIGlvX3dhaXRpZF9kcm9wX2lzc3Vl
X3JlZihzdHJ1Y3QgaW9fa2lvY2IgKnJlcSkKIHsKIAlzdHJ1Y3QgaW9fd2FpdGlkICppdyA9
IGlvX2tpb2NiX3RvX2NtZChyZXEsIHN0cnVjdCBpb193YWl0aWQpOwotCXN0cnVjdCBpb193
YWl0aWRfYXN5bmMgKml3YSA9IHJlcS0+YXN5bmNfZGF0YTsKIAogCWlmICghYXRvbWljX3N1
Yl9yZXR1cm4oMSwgJml3LT5yZWZzKSkKIAkJcmV0dXJuIGZhbHNlOwogCisJaW9fd2FpdGlk
X3JlbW92ZV93cShyZXEpOworCiAJLyoKIAkgKiBXYWtldXAgdHJpZ2dlcmVkLCByYWNpbmcg
d2l0aCB1cy4gSXQgd2FzIHByZXZlbnRlZCBmcm9tCiAJICogY29tcGxldGluZyBiZWNhdXNl
IG9mIHRoYXQsIHF1ZXVlIHVwIHRoZSB0dyB0byBkbyB0aGF0LgogCSAqLwogCXJlcS0+aW9f
dGFza193b3JrLmZ1bmMgPSBpb193YWl0aWRfY2I7CiAJaW9fcmVxX3Rhc2tfd29ya19hZGQo
cmVxKTsKLQlyZW1vdmVfd2FpdF9xdWV1ZShpdy0+aGVhZCwgJml3YS0+d28uY2hpbGRfd2Fp
dCk7CiAJcmV0dXJuIHRydWU7CiB9CiAKQEAgLTI5MSw2ICsyOTEsNyBAQCBzdGF0aWMgaW50
IGlvX3dhaXRpZF93YWl0KHN0cnVjdCB3YWl0X3F1ZXVlX2VudHJ5ICp3YWl0LCB1bnNpZ25l
ZCBtb2RlLAogCQlyZXR1cm4gMDsKIAogCWxpc3RfZGVsX2luaXQoJndhaXQtPmVudHJ5KTsK
Kwlpdy0+aGVhZCA9IE5VTEw7CiAKIAkvKiBjYW5jZWwgaXMgaW4gcHJvZ3Jlc3MgKi8KIAlp
ZiAoYXRvbWljX2ZldGNoX2luYygmaXctPnJlZnMpICYgSU9fV0FJVElEX1JFRl9NQVNLKQpA
QCAtMzExLDYgKzMxMiw3IEBAIGludCBpb193YWl0aWRfcHJlcChzdHJ1Y3QgaW9fa2lvY2Ig
KnJlcSwgY29uc3Qgc3RydWN0IGlvX3VyaW5nX3NxZSAqc3FlKQogCWl3LT53aGljaCA9IFJF
QURfT05DRShzcWUtPmxlbik7CiAJaXctPnVwaWQgPSBSRUFEX09OQ0Uoc3FlLT5mZCk7CiAJ
aXctPm9wdGlvbnMgPSBSRUFEX09OQ0Uoc3FlLT5maWxlX2luZGV4KTsKKwlpdy0+aGVhZCA9
IE5VTEw7CiAJaXctPmluZm9wID0gdTY0X3RvX3VzZXJfcHRyKFJFQURfT05DRShzcWUtPmFk
ZHIyKSk7CiAJbWVtc2V0KCZpdy0+aW5mbywgMCwgc2l6ZW9mKGl3LT5pbmZvKSk7CiAJcmV0
dXJuIDA7CkBAIC0zNDgsMTEgKzM1MCwxNiBAQCBpbnQgaW9fd2FpdGlkKHN0cnVjdCBpb19r
aW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpCiAJICogY2FsbGJhY2suCiAJ
ICovCiAJaW9fcmluZ19zdWJtaXRfbG9jayhjdHgsIGlzc3VlX2ZsYWdzKTsKKworCS8qCisJ
ICogaXctPmhlYWQgaXMgdmFsaWQgdW5kZXIgdGhlIHJpbmcgbG9jaywgYW5kIGFzIGxvbmcg
YXMgdGhlIHJlcXVlc3QKKwkgKiBpcyBvbiB0aGUgd2FpdGlkX2xpc3Qgd2hlcmUgY2FuY2Vs
YXRpb25zIG1heSBmaW5kIGl0LgorCSAqLworCWl3LT5oZWFkID0gJmN1cnJlbnQtPnNpZ25h
bC0+d2FpdF9jaGxkZXhpdDsKIAlobGlzdF9hZGRfaGVhZCgmcmVxLT5oYXNoX25vZGUsICZj
dHgtPndhaXRpZF9saXN0KTsKIAogCWluaXRfd2FpdHF1ZXVlX2Z1bmNfZW50cnkoJml3YS0+
d28uY2hpbGRfd2FpdCwgaW9fd2FpdGlkX3dhaXQpOwogCWl3YS0+d28uY2hpbGRfd2FpdC5w
cml2YXRlID0gcmVxLT50YXNrOwotCWl3LT5oZWFkID0gJmN1cnJlbnQtPnNpZ25hbC0+d2Fp
dF9jaGxkZXhpdDsKIAlhZGRfd2FpdF9xdWV1ZShpdy0+aGVhZCwgJml3YS0+d28uY2hpbGRf
d2FpdCk7CiAKIAlyZXQgPSBfX2RvX3dhaXQoJml3YS0+d28pOwpAQCAtMzc1LDcgKzM4Miw3
IEBAIGludCBpb193YWl0aWQoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBp
c3N1ZV9mbGFncykKIAl9CiAKIAlobGlzdF9kZWxfaW5pdCgmcmVxLT5oYXNoX25vZGUpOwot
CXJlbW92ZV93YWl0X3F1ZXVlKGl3LT5oZWFkLCAmaXdhLT53by5jaGlsZF93YWl0KTsKKwlp
b193YWl0aWRfcmVtb3ZlX3dxKHJlcSk7CiAJcmV0ID0gaW9fd2FpdGlkX2ZpbmlzaChyZXEs
IHJldCk7CiAKIAlpb19yaW5nX3N1Ym1pdF91bmxvY2soY3R4LCBpc3N1ZV9mbGFncyk7Ci0t
IAoyLjU2LjAKCg==

--------------ZRzk5eHxcaI0l76H2M6IZ93E--
