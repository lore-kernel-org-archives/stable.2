Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793557630;
	b=ZCyhpDy67zuQcjz/VmcdNT37QuK7wQ2KHYC4Feo8Ax7T3vUQ4esIXjh+DqvKamYprYLh
	 W8EYer1Sfg07HT+qHLAFqk4hDztj8DDGkUU5r+492OcF7fLvnsWcCx8Pnf73Q8CT1bMRK
	 vi1X5KTl5gONvf99MYJJSaj0qGN1HxcXw9Wnrk76I8NopUnGH4N4a04hiRLGAPS1S1/8+
	 /On7LoxstzdANJofXce2Nt8fSgczEZPA2oKpxe69+Z2NveLW1jt5bLT239vJhDQ5VilHI
	 2Bv+6pNUwUTQ6EaY9x/cevsv476ClDb9HF+Dci06ICojcK2CGIZnkxIE4OQv1cnhv6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793557630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	bh=aUU1nGwWnmMrHXGJh08o6CeAPeT6DZPgaa4XD+hq+Ac=;
	b=Ho3ctLLVorI7Rhj7gPrXtbfMpYMMjmpkhm/TxPon1kmIiKVBlC81RIHFCf20nJa3mFNd
	 iLGUXG5vJRtqJ/65T1mSgZ/j9cSwbFJQqPX1Foldxeck8WED1e2r/aiGYSqxwO88l0MMp
	 7U3Q6kXXRNrDx7DjKwrGHepc1RWbUJY/mUKgvdA+Unbk4C0ZGcEWr481WEM9gUF3TyhmM
	 zezs1X+MG3YaxQRBHjO2GiFQs2rEgBxQUB25aRqASVUIGkePNPWI1zInfK/63JKB3W8pa
	 RxxiolWXvKv5spcvBpZKZWFMDUWi98qOn3FO2hv4r45HVt+cfcvO4dHpRQbbx2wLqqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KcWDuxn2;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39758606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 18:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39758606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KcWDuxn2
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35b2c599f43so3269589eec.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 10:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793557629; x=1794162429; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aUU1nGwWnmMrHXGJh08o6CeAPeT6DZPgaa4XD+hq+Ac=;
        b=KcWDuxn20gvoytW1+EZ8rspHSjO3VxEO3gzalycUP3w5PEi9m8V6K6OWVyoyoDkwjj
         CQW8VletrPXp5r2QC9o0hrot1RFcr2tPpXTJePpPaaqtsZrnxBHyBQlDvSTWt3KfQuAR
         N+iWC4pdFwvKHptSvjbbn5s6kCNfmfhFiry4J9pzcthfnxLo3ZxOga7/rzBjAV8tE6Q3
         g1u/OqhNWWYvxejii6EsfUGtL6jVJQ23mDZ0DDxHLoD/YPt5kHU57HM9tQfRSAMOjyH6
         EXxUSLgyIGsFNFo011UGupNZgyKb6rm2eYeC/ZOom0MmhAEL2Rlbt/MTAGijJxGVLbGf
         KTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793557629; x=1794162429;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aUU1nGwWnmMrHXGJh08o6CeAPeT6DZPgaa4XD+hq+Ac=;
        b=ZZU7qpEbz3qlAHKg4UKP0+5AEHXn0zPnr1WISq6oz3YUHdc8Z1pnb0dxMizgrxzx4r
         MufSAMwBrhYQ8D/qZcfabz7x5TpgQAvG76BdIMlRSO5Qz8Fo4DZoQS1sxhgP2AS8Mbj7
         zLF6u7mSUHreSqpsIonWeDyDpULuEnvrCke3o88xcHT7/oRDnPH7Sz2B77p8PhFjMO/9
         n9lKBdkgnQKtcljpr7VlY9+PALnAhDevA3HfHQazuejI5myQXibP3oMQ+grUEpW1HAbw
         qrLjXLo7FmgIFhLgynE4YMpBKWSdBZ48I47pNsLgDBvagMRUJX8+4FEzIi2DO6i3pL5q
         9LIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDpiURRa7d562gioXjolw2ZYjn6QZ+DEe9wkMHufZk2+mjMN49w+l5I8v2yZYyzlxoRKq5tco=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OprCAvPBo14mRYpqrPo17UUFDYTXl3q5Itze85pcPMUX1Z7XL
	ES1H7olco/8urpdCwLp4yd5hJBG8ToyfMKaivA7PH9UYdIQ3beSDMsIredBK3z1Gfsc=
X-Gm-Gg: AYBFou3uY+PKqMTnhwWYmKmj1giP1CAAENuT95qzPp0AYH5zsejBKDHu1ULEPAn44jk
	KlhEoPbi8ECTMhGeDQ0L+EFy1n1OgKO6mvVLwcx7kwAqJVOFhcNrBPxO/RumrNsGzy9lLDrDm5N
	KtdFptNPkTTR483FxdwiVXN9J/MY3z9lahHDm0oaNmPK/FxLE+IWKuAQqwkO6eCrs3Ndlt2Sk3n
	AOYWgMg8hCgddZ17dueFqyEjky4sS0rnGcc7jKaZBHj1pNETisQymfcH3jDKULHCLGhCHoRww0k
	SuXlLRpHqQE8CyqHVB3sNm1R1zAa8EFzZxqk9P7geaKMvulxbzuVw1k5GukSsAKglcMNrHGnFJV
	oyV9xCFSFg9+7y7QeSdyVCZ4tuBiuujXM3cg59eVLxPRFZAu55McHYRtcn/LqqIug4sn5YLfwXg
	EX9/VXauu/m3W+u9w4mhZRRe6sWr6kMfZIRNafRq0FKkwJER7mnxATo5hZLTaVHRwjEsLCaphuW
	RwnSjiEuTfTmbGYPEm6rS5EBrDNdyKD4bqLRqc4puCgHcRYRQyBAoY2vlSoUE0SjYj9daXS5/Ig
	vYDO+c3mH25x3/5Q974cDpCYlEI1BS6DuqA=
X-Received: by 2002:a05:693c:69d1:b0:358:3426:d601 with SMTP id 5a478bee46e88-36a4221b3c6mr13335197eec.2.1793557629049;
        Sun, 01 Nov 2026 10:27:09 -0800 (PST)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:b5a0:ac44:5583:ef02])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42952e1csm31758645eec.20.2026.11.01.10.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 10:27:08 -0800 (PST)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: David Hildenbrand <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Liam R . Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Kalesh Singh <kaleshsingh@google.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: check THP exclusivity for each subpage
Date: Sun, 01 Nov 2026 10:27:03 -0800
Message-ID:
 <179355762314.2759535.4568050479263510899.pagemap-thp-repro@gmail.com>
In-Reply-To: <da1dc033-9131-4b77-9443-a8cc82fd7e58@kernel.org>
References: <4c1b393a4b04bd94e4f1c7879ae04e1793eb0931.1793552446.git.zhangxp1998@gmail.com>
 <54617273-262f-4e17-b912-8b07113ca45c@kernel.org>
 <da1dc033-9131-4b77-9443-a8cc82fd7e58@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5072210820627741972=="

--===============5072210820627741972==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi David,

Thanks for the clarification.

I don't have a real application depending on precise per-subpage bit 56
values, or a production failure to report. This is a review/test-driven
report, with LLM assistance, rather than something found through a failing
workload. I followed it up with an actual old/new kernel comparison.

So I have no workload-based objection to switching to the conservative
whole-folio behavior you described. The attached kselftest-style reproducer
is just to make the current CONFIG_PAGE_MAPCOUNT=y behavior reproducible,
not to argue that exact subpage reporting must be preserved as an ABI.

The test forks with a PMD-mapped anonymous THP, then has the child unmap
one base page while the parent retains its PMD mapping. On the unpatched
kernel, unmapping subpage 0 makes the parent's bulk pagemap read report
all 512 subpages exclusive; unmapping subpage 1, 256 or 511 reports none
exclusive. With the one-line fix, only the unmapped-in-child subpage is
reported exclusive in each case. The fully private/shared controls pass
on both kernels.

Tested on x86-64 QEMU/KVM with 4KB base pages, 2MB PMD THPs and
CONFIG_PAGE_MAPCOUNT=y, using mm-hotfixes-unstable at 64703f0fee74 and
that same base plus this patch. Three runs of the same binary gave:

  Before: 20 PASS, 8 FAIL per run
  After:  28 PASS, 0 FAIL per run

To build, save the attachment under tools/testing/selftests/mm/ and run
from the kernel root:

  cc -O2 -Wall -Wextra tools/testing/selftests/mm/pagemap_thp_exclusive.c \
     -o /tmp/pagemap_thp_exclusive
  /tmp/pagemap_thp_exclusive

It uses the existing ../kselftest.h and skips if a 2MB PMD THP cannot be
obtained. Its expectations are deliberately limited to the current
CONFIG_PAGE_MAPCOUNT=y implementation, not the conservative variant.

Thanks,
Kelvin

--===============5072210820627741972==
Content-Type: text/x-c
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pagemap_thp_exclusive.c"
MIME-Version: 1.0

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKLyoKICogRGlhZ25vc3RpYyBmb3Ig
dGhlIENPTkZJR19QQUdFX01BUENPVU5UPXkgcGFnZW1hcCBQTUQgcGF0aCwgbm90IGEgZ2VuZXJp
YwogKiBiaXQtNTYgQUJJIHRlc3Q6IG90aGVyIGNvbmZpZ3VyYXRpb25zIG1heSByZXBvcnQgZm9s
aW8td2lkZSBleGNsdXNpdml0eS4KICogUmVxdWlyZXMgNEtCIGJhc2UgcGFnZXMgYW5kIDJNQiBh
bm9ueW1vdXMgUE1EIFRIUHMuCiAqCiAqIFNhdmUgdW5kZXIgdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvbW0vIGFuZCBidWlsZCBmcm9tIHRoZSBrZXJuZWwgcm9vdDoKICogY2MgLU8yIC1XYWxsIC1X
ZXh0cmEgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vcGFnZW1hcF90aHBfZXhjbHVzaXZlLmMg
XAogKiAgICAtbyAvdG1wL3BhZ2VtYXBfdGhwX2V4Y2x1c2l2ZQogKi8KI2RlZmluZSBfR05VX1NP
VVJDRQojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8c3Rk
aW50Lmg+CiNpbmNsdWRlIDxzeXMvbW1hbi5oPgojaW5jbHVkZSA8c3lzL3dhaXQuaD4KI2luY2x1
ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSAiLi4va3NlbGZ0ZXN0LmgiCgojaWZuZGVmIE1BRFZfQ09M
TEFQU0UKI2RlZmluZSBNQURWX0NPTExBUFNFIDI1CiNlbmRpZgojZGVmaW5lIFBBR0VfQllURVMg
NDA5NlVMCiNkZWZpbmUgVEhQX0JZVEVTICgyVUwgKiAxMDI0ICogMTAyNCkKI2RlZmluZSBOUl9Q
QUdFUyAoVEhQX0JZVEVTIC8gUEFHRV9CWVRFUykKI2RlZmluZSBQUkVTRU5UICgxVUxMIDw8IDYz
KQojZGVmaW5lIEVYQ0xVU0lWRSAoMVVMTCA8PCA1NikKCnN0YXRpYyB2b2lkIHJlcXVpcmUoaW50
IG9rLCBjb25zdCBjaGFyICp3aGF0KQp7CglpZiAoIW9rKQoJCWtzZnRfZXhpdF9mYWlsX21zZygi
JXMgZmFpbGVkIChlcnJubz0lZClcbiIsIHdoYXQsIGVycm5vKTsKfQoKc3RhdGljIHZvaWQgbm90
aWZ5KGludCBmZCkKewoJcmVxdWlyZSh3cml0ZShmZCwgIngiLCAxKSA9PSAxLCAicGlwZSB3cml0
ZSIpOwp9CgpzdGF0aWMgdm9pZCBhd2FpdChpbnQgZmQpCnsKCWNoYXIgYzsKCglyZXF1aXJlKHJl
YWQoZmQsICZjLCAxKSA9PSAxLCAicGlwZSByZWFkIik7Cn0KCnN0YXRpYyB1bnNpZ25lZCBsb25n
IGFub25faHVnZV9ieXRlcyh2b2lkICphZGRyKQp7CglGSUxFICpmID0gZm9wZW4oIi9wcm9jL3Nl
bGYvc21hcHMiLCAiciIpOwoJdW5zaWduZWQgbG9uZyBzdGFydCwgZW5kLCBrYiA9IDA7Cglib29s
IHNlbGVjdGVkID0gZmFsc2U7CgljaGFyIGxpbmVbNTEyXTsKCglyZXF1aXJlKGYgIT0gTlVMTCwg
Im9wZW4gc21hcHMiKTsKCXdoaWxlIChmZ2V0cyhsaW5lLCBzaXplb2YobGluZSksIGYpKSB7CgkJ
aWYgKHNzY2FuZihsaW5lLCAiJWx4LSVseCIsICZzdGFydCwgJmVuZCkgPT0gMikKCQkJc2VsZWN0
ZWQgPSAodWludHB0cl90KWFkZHIgPj0gc3RhcnQgJiYgKHVpbnRwdHJfdClhZGRyIDwgZW5kOwoJ
CWlmIChzZWxlY3RlZCAmJiBzc2NhbmYobGluZSwgIkFub25IdWdlUGFnZXM6ICVsdSBrQiIsICZr
YikgPT0gMSkKCQkJYnJlYWs7Cgl9CglmY2xvc2UoZik7CglyZXR1cm4ga2IgKiAxMDI0Owp9Cgov
KiBob2xlID09IC0xOiBhbGwgc2hhcmVkOyBob2xlID09IC0yOiBhbGwgZXhjbHVzaXZlLiAqLwpz
dGF0aWMgdm9pZCBjaGVja19idWxrKGludCBmZCwgY2hhciAqYWRkciwgaW50IGhvbGUsIGNvbnN0
IGNoYXIgKmxhYmVsKQp7Cgl1aW50NjRfdCBlbnRyaWVzW05SX1BBR0VTXTsKCXVuc2lnbmVkIGlu
dCBpLCB3cm9uZyA9IDAsIGV4Y2x1c2l2ZSA9IDA7CglvZmZfdCBvZmZzZXQgPSAodWludHB0cl90
KWFkZHIgLyBQQUdFX0JZVEVTICogc2l6ZW9mKHVpbnQ2NF90KTsKCglyZXF1aXJlKHByZWFkKGZk
LCBlbnRyaWVzLCBzaXplb2YoZW50cmllcyksIG9mZnNldCkgPT0gc2l6ZW9mKGVudHJpZXMpLAoJ
CSJyZWFkIHBhZ2VtYXAiKTsKCWZvciAoaSA9IDA7IGkgPCBOUl9QQUdFUzsgaSsrKSB7CgkJYm9v
bCB3YW50ID0gaG9sZSA9PSAtMiB8fCBob2xlID09IChpbnQpaTsKCgkJZXhjbHVzaXZlICs9ICEh
KGVudHJpZXNbaV0gJiBFWENMVVNJVkUpOwoJCXdyb25nICs9ICEoZW50cmllc1tpXSAmIFBSRVNF
TlQpIHx8CgkJCSAhIShlbnRyaWVzW2ldICYgRVhDTFVTSVZFKSAhPSB3YW50OwoJfQoJa3NmdF90
ZXN0X3Jlc3VsdCghd3JvbmcsICIlczogaG9sZT0lZCBleGNsdXNpdmU9JXUvJWx1IHdyb25nPSV1
XG4iLAoJCQkgbGFiZWwsIGhvbGUsIGV4Y2x1c2l2ZSwgTlJfUEFHRVMsIHdyb25nKTsKfQoKc3Rh
dGljIHZvaWQgY2hlY2tfc2luZ2xlKGludCBmZCwgY2hhciAqYWRkciwgdW5zaWduZWQgaW50IGlu
ZGV4LCBib29sIGV4Y2x1c2l2ZSkKewoJdWludDY0X3QgZW50cnk7CglvZmZfdCBvZmZzZXQgPSAo
KHVpbnRwdHJfdClhZGRyIC8gUEFHRV9CWVRFUyArIGluZGV4KSAqIHNpemVvZihlbnRyeSk7CgoJ
cmVxdWlyZShwcmVhZChmZCwgJmVudHJ5LCBzaXplb2YoZW50cnkpLCBvZmZzZXQpID09IHNpemVv
ZihlbnRyeSksCgkJInJlYWQgc2luZ2xlIHBhZ2VtYXAgZW50cnkiKTsKCWtzZnRfdGVzdF9yZXN1
bHQoKGVudHJ5ICYgUFJFU0VOVCkgJiYgISEoZW50cnkgJiBFWENMVVNJVkUpID09IGV4Y2x1c2l2
ZSwKCQkJICJzaW5nbGUgcmVhZDogc3VicGFnZT0ldSBleHBlY3RlZCBleGNsdXNpdmU9JWRcbiIs
CgkJCSBpbmRleCwgZXhjbHVzaXZlKTsKfQoKc3RhdGljIHZvaWQgcnVuX2Nhc2UodW5zaWduZWQg
aW50IGhvbGUpCnsKCWNoYXIgKnJlc2VydmUsICphZGRyOwoJaW50IGdvWzJdLCBkb25lWzJdLCBm
ZCwgc3RhdHVzOwoJcGlkX3QgY2hpbGQ7CgoJLyogTGVhdmUgUFJPVF9OT05FIGd1YXJkcyBvbiBi
b3RoIHNpZGVzIHRvIHByZXZlbnQgVk1BIG1lcmdpbmcuICovCglyZXNlcnZlID0gbW1hcChOVUxM
LCAzICogVEhQX0JZVEVTLCBQUk9UX05PTkUsCgkJICAgICAgIE1BUF9QUklWQVRFIHwgTUFQX0FO
T05ZTU9VUywgLTEsIDApOwoJcmVxdWlyZShyZXNlcnZlICE9IE1BUF9GQUlMRUQsICJyZXNlcnZl
IGFkZHJlc3Mgc3BhY2UiKTsKCWFkZHIgPSAoY2hhciAqKSgoKHVpbnRwdHJfdClyZXNlcnZlICsg
VEhQX0JZVEVTKSAmIH4oVEhQX0JZVEVTIC0gMSkpOwoJcmVxdWlyZShtbWFwKGFkZHIsIFRIUF9C
WVRFUywgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwKCQkgICAgIE1BUF9QUklWQVRFIHwgTUFQX0FO
T05ZTU9VUyB8IE1BUF9GSVhFRCwgLTEsIDApID09IGFkZHIsCgkJIm1hcCBhbm9ueW1vdXMgbWVt
b3J5Iik7CglyZXF1aXJlKCFtYWR2aXNlKGFkZHIsIFRIUF9CWVRFUywgTUFEVl9IVUdFUEFHRSks
ICJNQURWX0hVR0VQQUdFIik7CgltZW1zZXQoYWRkciwgMHg1YSwgVEhQX0JZVEVTKTsKCWlmIChh
bm9uX2h1Z2VfYnl0ZXMoYWRkcikgIT0gVEhQX0JZVEVTKQoJCW1hZHZpc2UoYWRkciwgVEhQX0JZ
VEVTLCBNQURWX0NPTExBUFNFKTsKCWlmIChhbm9uX2h1Z2VfYnl0ZXMoYWRkcikgIT0gVEhQX0JZ
VEVTKSB7CgkJZm9yICh1bnNpZ25lZCBpbnQgaSA9IDA7IGkgPCA3OyBpKyspCgkJCWtzZnRfdGVz
dF9yZXN1bHRfc2tpcCgiaG9sZT0ldTogbm8gMk1CIFBNRCBUSFBcbiIsIGhvbGUpOwoJCW11bm1h
cChyZXNlcnZlLCAzICogVEhQX0JZVEVTKTsKCQlyZXR1cm47Cgl9CglmZCA9IG9wZW4oIi9wcm9j
L3NlbGYvcGFnZW1hcCIsIE9fUkRPTkxZKTsKCXJlcXVpcmUoZmQgPj0gMCwgIm9wZW4gcGFnZW1h
cCIpOwoJY2hlY2tfYnVsayhmZCwgYWRkciwgLTIsICJiZWZvcmUgZm9yayIpOwoJcmVxdWlyZSgh
cGlwZShnbykgJiYgIXBpcGUoZG9uZSksICJwaXBlIik7CgljaGlsZCA9IGZvcmsoKTsKCXJlcXVp
cmUoY2hpbGQgPj0gMCwgImZvcmsiKTsKCWlmICghY2hpbGQpIHsKCQljbG9zZShnb1sxXSk7CgkJ
Y2xvc2UoZG9uZVswXSk7CgkJYXdhaXQoZ29bMF0pOwoJCXJlcXVpcmUoIW11bm1hcChhZGRyICsg
aG9sZSAqIFBBR0VfQllURVMsIFBBR0VfQllURVMpLCAiY2hpbGQgbXVubWFwIik7CgkJbm90aWZ5
KGRvbmVbMV0pOwoJCWF3YWl0KGdvWzBdKTsKCQlfZXhpdCgwKTsKCX0KCWNsb3NlKGdvWzBdKTsK
CWNsb3NlKGRvbmVbMV0pOwoJY2hlY2tfYnVsayhmZCwgYWRkciwgLTEsICJhZnRlciBmb3JrLCBi
ZWZvcmUgY2hpbGQgbXVubWFwIik7Cglub3RpZnkoZ29bMV0pOwoJYXdhaXQoZG9uZVswXSk7Cglr
c2Z0X3Rlc3RfcmVzdWx0KGFub25faHVnZV9ieXRlcyhhZGRyKSA9PSBUSFBfQllURVMsCgkJCSAi
aG9sZT0ldTogcGFyZW50IHN0aWxsIFBNRCBtYXBwZWRcbiIsIGhvbGUpOwoJY2hlY2tfYnVsayhm
ZCwgYWRkciwgaG9sZSwgImFmdGVyIGNoaWxkIG11bm1hcCIpOwoJY2hlY2tfc2luZ2xlKGZkLCBh
ZGRyLCBob2xlLCB0cnVlKTsKCWNoZWNrX3NpbmdsZShmZCwgYWRkciwgaG9sZSA/IDAgOiAxLCBm
YWxzZSk7Cglub3RpZnkoZ29bMV0pOwoJcmVxdWlyZSh3YWl0cGlkKGNoaWxkLCAmc3RhdHVzLCAw
KSA9PSBjaGlsZCAmJiBXSUZFWElURUQoc3RhdHVzKSAmJgoJCSFXRVhJVFNUQVRVUyhzdGF0dXMp
LCAiY2hpbGQgZXhpdCIpOwoJY2hlY2tfYnVsayhmZCwgYWRkciwgLTIsICJhZnRlciBjaGlsZCBl
eGl0Iik7CgljbG9zZShnb1sxXSk7CgljbG9zZShkb25lWzBdKTsKCWNsb3NlKGZkKTsKCXJlcXVp
cmUoIW11bm1hcChyZXNlcnZlLCAzICogVEhQX0JZVEVTKSwgInVubWFwIHJlc2VydmF0aW9uIik7
Cn0KCmludCBtYWluKHZvaWQpCnsKCXVuc2lnbmVkIGludCBob2xlc1tdID0geyAwLCAxLCBOUl9Q
QUdFUyAvIDIsIE5SX1BBR0VTIC0gMSB9OwoKCWtzZnRfcHJpbnRfaGVhZGVyKCk7CglpZiAoc3lz
Y29uZihfU0NfUEFHRVNJWkUpICE9IFBBR0VfQllURVMpCgkJa3NmdF9leGl0X3NraXAoIlRoaXMg
cmVwcm9kdWNlciByZXF1aXJlcyA0S0IgYmFzZSBwYWdlc1xuIik7Cglrc2Z0X3ByaW50X21zZygi
UmVxdWlyZXMgQ09ORklHX1BBR0VfTUFQQ09VTlQ9eTsgbm90IGEgZ2VuZXJpYyBBQkkgdGVzdFxu
Iik7Cglrc2Z0X3NldF9wbGFuKDcgKiBBUlJBWV9TSVpFKGhvbGVzKSk7CglhbGFybSgzMCk7Cglm
b3IgKHVuc2lnbmVkIGludCBpID0gMDsgaSA8IEFSUkFZX1NJWkUoaG9sZXMpOyBpKyspCgkJcnVu
X2Nhc2UoaG9sZXNbaV0pOwoJa3NmdF9maW5pc2hlZCgpOwp9Cg==

--===============5072210820627741972==--
