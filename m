Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5412C3251
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994386; cv=none; b=UK/p+bLS8+g1fu8DCcng529FtQ16HCnILPk4G3rLuQ8PvupszczAc/luT6zmrwgTV7X3juKqCzHrDb+OO0dS718A4t9O2BeLAaDMKHlOs/6Kwo5qDU41oDn/HYqKQfxOcBTbdgUx39P7Thby3WKgJmYB2KLgmdHycAAzaGHqrrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994386; c=relaxed/simple;
	bh=0fhPlVvNsP0hwGxke4V3uI6jnAwGyLqeCd4wJv68qRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/Jg91cHjjWbxnBFSi8g4qN1jik+AUF8JZqxl4IcrEOi/Kz4ql3by4T59nJxerhwqABFyCqtMUulFaBU0++ezgSgGT9i9CrowlZ0vDw1ILaAPr7M8aF2kAkEGguvDrhBBk9qZlvxHpaqGPJa7riAf3pBCYsgh70RHMM822+HuZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTki5s1w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTki5s1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058FF1F00ACA
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782994385;
	bh=YzjQY79XGNZ+LFZpH+wjUaUB1nrxoAh1KX9E4w9I4w4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cTki5s1wKmJol0EC5fXO25dMuk14JF18T7DZcFsf6dCaAUp4lWklR3adSqgCZByg1
	 r9sBJR2wgd1vhzvKMNu/HSfzf/IjlRoDxIwtvZKELHOEAlo+h8UIFH5hamDTkx1s0D
	 NI1SdGwsW32KoL3YwzgtdjB8ZD9wAjCC0B26wqG6LOsYQsAIB5hHzWWSGkLYnQeN5f
	 xkDCcFDAHla/hWTu3voCQIC6+Mx9xSd6qEQDJqDfXds0Vu/JReAHHRcwB0uV8tlp2+
	 hPo2VFIqz7lxzPO/nvxJG4qb9BTXrJbEuRxKT19uYZpM2htwpESd3vuEV8CoZ9Lk8/
	 tX4irhTcHvmXQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c126fe7d0f3so221279766b.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 05:13:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr8xFlI++BiBcIevK+ogVNYv9nBok0fMNf0dYdc6zC0bZXW3fBt1j2ATjeMaCIC5tyRlNPMKzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJMa5Sd7bOPUniET57AdyyvpKsHFURYhtan6eMAaY/r/z793fW
	33IpXJJnqmC2SHzumY8hjsgVIAtxoeBqiwlFJOo3pH6hgAZuSCIzTzqie3BmPWfXWXj9KyI6anC
	CNVZFLz6gUR0LTDnCDdFKrLNZpPTtXHQ=
X-Received: by 2002:a17:906:144f:b0:c07:e025:1549 with SMTP id
 a640c23a62f3a-c12a9d5c624mr194517566b.15.1782994383662; Thu, 02 Jul 2026
 05:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702090627.137915-1-zenghongling@kylinos.cn>
In-Reply-To: <20260702090627.137915-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 2 Jul 2026 21:12:50 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9018ondtRRa6mGexej-SDCm3-LeWV0W4TCUwBZ5hOXvg@mail.gmail.com>
X-Gm-Features: AVVi8CdTxV0aGnIGUJ1IeTIXlGuw1ZsJja-f_yFrJ3-5S4_xC3RrgJkLogLL2sc
Message-ID: <CAKYAXd9018ondtRRa6mGexej-SDCm3-LeWV0W4TCUwBZ5hOXvg@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: prevent write access to $MFT inode
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, charsyam@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e0321a06559fbaa2"

--000000000000e0321a06559fbaa2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 6:06=E2=80=AFPM Hongling Zeng <zenghongling@kylinos.=
cn> wrote:
>
> Malicious NTFS images can expose $MFT to userspace and allow write
> operations, leading to potential kernel NULL pointer dereference
> since ntfs_mft_aops lacks write_begin support.
>
> The vulnerability affects both write_iter and mmap-based write paths:
> 1. write_iter path: ntfs_file_write_iter()
> 2. mmap write path: ntfs_filemap_page_mkwrite()
>
> Without protecting both paths, attackers can bypass single-path
> protection by using the alternative write method.
>
> Fix by adding write protection in ntfs_file_write_iter() to prevent
> any write operations to FILE_MFT.
>
> Fixes: 1e9ea7e04472d ("Revert \"fs: Remove NTFS classic\"")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Can you check if the attached file fixes this issue ?
Thanks.

--000000000000e0321a06559fbaa2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ntfs-make-system-files-immutable-to-prevent-corrupti.patch"
Content-Disposition: attachment; 
	filename="0001-ntfs-make-system-files-immutable-to-prevent-corrupti.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mr3gsc6j0>
X-Attachment-Id: f_mr3gsc6j0

RnJvbSAxZDllYzQwZmVmZmNmMmQwNTRkZjAxYjU4NTY0MzM0OTc3ZWNkZjliIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBUaHUsIDIgSnVsIDIwMjYgMjA6MzY6NTkgKzA5MDAKU3ViamVjdDogW1BBVENIXSBudGZz
OiBtYWtlIHN5c3RlbSBmaWxlcyBpbW11dGFibGUgdG8gcHJldmVudCBjb3JydXB0aW9uCgpXaGVu
IGEgc3lzdGVtIGZpbGUgc3VjaCBhcyAkQml0bWFwIGlzIGV4cG9zZWQgdmlhIHNob3dfc3lzX2Zp
bGVzIGFuZAp3cml0dGVuIGZyb20gdXNlcnNwYWNlLCB0aGUgdm9sdW1lIGlzIGNvcnJ1cHRlZCBh
bmQsIGJlY2F1c2UgdGhlIGNsdXN0ZXIKYWxsb2NhdG9yIHNjYW5zICRCaXRtYXAgdGhyb3VnaCB0
aGUgc2FtZSBpbm9kZSdzIHBhZ2UgY2FjaGUsIGEgd3JpdGUgdG8KJEJpdG1hcCBhbHNvIGRlYWRs
b2NrcyB3cml0ZWJhY2sgYWdhaW5zdCB0aGUgZm9saW8gaXQgYWxyZWFkeSBob2xkcyBsb2NrZWQu
CgpUaGVzZSBmaWxlcyBhcmUgbWFpbnRhaW5lZCBieSB0aGUgZHJpdmVyIGl0c2VsZiBhbmQgaGF2
ZSBubyB2YWxpZCByZWFzb24KdG8gYmUgd3JpdHRlbiB0aHJvdWdoIHRoZSBmaWxlIGludGVyZmFj
ZS4gTWFyayBiYXNlIG1ldGFkYXRhIGZpbGVzCihtZnRfbm8gPCBGSUxFX2ZpcnN0X3VzZXIpIGFz
IGltbXV0YWJsZSBkdXJpbmcgaW5vZGUgcmVhZCBzbyB0aGUgVkZTCnJlamVjdHMgd3JpdGUsIG1t
YXAsIHRydW5jYXRlIGFuZCB1bmxpbmsgd2l0aCAtRVBFUk0uIERpcmVjdG9yaWVzIGFyZQpza2lw
cGVkIHNvIHRoZSByb290IGFuZCAkRXh0ZW5kIHJlbWFpbiB1c2FibGUuIEludGVybmFsIG1ldGFk
YXRhIHVwZGF0ZXMKZG8gbm90IGdvIHRocm91Z2ggdGhlIFZGUyB3cml0ZSBwYXRoIGFuZCBhcmUg
dW5hZmZlY3RlZC4KClNpZ25lZC1vZmYtYnk6IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtlcm5l
bC5vcmc+Ci0tLQogZnMvbnRmcy9pbm9kZS5jIHwgOSArKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9udGZzL2lub2RlLmMgYi9mcy9udGZz
L2lub2RlLmMKaW5kZXggYzI3MTU1MjFlNTYyLi43MzgxYTE4Y2ZhZGQgMTAwNjQ0Ci0tLSBhL2Zz
L250ZnMvaW5vZGUuYworKysgYi9mcy9udGZzL2lub2RlLmMKQEAgLTExOTEsNiArMTE5MSwxNSBA
QCBzdGF0aWMgaW50IG50ZnNfcmVhZF9sb2NrZWRfaW5vZGUoc3RydWN0IGlub2RlICp2aSkKIAkg
ICAgIVNfSVNGSUZPKHZpLT5pX21vZGUpICYmICFTX0lTU09DSyh2aS0+aV9tb2RlKSAmJiAhU19J
U0xOSyh2aS0+aV9tb2RlKSkKIAkJdmktPmlfZmxhZ3MgfD0gU19JTU1VVEFCTEU7CiAKKwkvKgor
CSAqIFN5c3RlbSBmaWxlcyBzdWNoIGFzICRCaXRtYXAgYW5kICRNRlQgYXJlIG1haW50YWluZWQg
YnkgdGhlIGRyaXZlcgorCSAqIGl0c2VsZiwgYW5kIHdyaXRpbmcgdGhlbSBmcm9tIHVzZXJzcGFj
ZSBjb3JydXB0cyB0aGUgdm9sdW1lLgorCSAqIEFsd2F5cyBtYWtlIHRoZW0gaW1tdXRhYmxlIHJl
Z2FyZGxlc3Mgb2YgdGhlIHN5c19pbW11dGFibGUgb3B0aW9uLgorCSAqIERpcmVjdG9yaWVzIGFy
ZSBza2lwcGVkIHNvIHRoZSByb290IGFuZCAkRXh0ZW5kIHN0YXkgdXNhYmxlLgorCSAqLworCWlm
IChuaS0+bWZ0X25vIDwgRklMRV9maXJzdF91c2VyICYmIFNfSVNSRUcodmktPmlfbW9kZSkpCisJ
CXZpLT5pX2ZsYWdzIHw9IFNfSU1NVVRBQkxFOworCiAJLyoKIAkgKiBUaGUgbnVtYmVyIG9mIDUx
Mi1ieXRlIGJsb2NrcyB1c2VkIG9uIGRpc2sgKGZvciBzdGF0KS4gVGhpcyBpcyBpbiBzbwogCSAq
IGZhciBpbmFjY3VyYXRlIGFzIGl0IGRvZXNuJ3QgYWNjb3VudCBmb3IgYW55IG5hbWVkIHN0cmVh
bXMgb3Igb3RoZXIKLS0gCjIuMjUuMQoK
--000000000000e0321a06559fbaa2--
