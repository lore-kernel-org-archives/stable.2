Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025068;
	b=cRUVHiTsnUWzWWhAgJsqwcktml1NgVSvj7l1d4W52kHHqB+Vckun3oX+aV+eChpq8loB
	 aac31wuuOyl0cunPTyABLTHtqy2q+mHcLBjeXvaD/+Y7UxIjD13PBoIKCOgiCSgUD9rJr
	 DCIJUSk5NAsF/OYXbr+GYaYp+6/xivOTMot3niH3F0/iiTRBShGGp8NBDExQAwyETaN4E
	 6gQoxdcaXbmj2k/VFzwCYDZRDea80Z7Xr57GDpndlxlhbe0bLQrfkneKDHkY3HZo4w+Tq
	 JCdhZKU29S0xFZe1EXztVY39dEf+NG0B16CNSMiG/lOjrrVCe26/DWmqydpUKP8O/Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=S2aF/nJPcL1L7k4kule6+RDBiZtzu5J4Md55u9FTmQA=;
	b=GPWjVC+v0SAsGUOky8Ft8oKWrLeqfhh3/UEN9OEI9TKJH7O7uTWnq+/s8Jr0rR1BUSQc
	 9HLneDKW5YDrnEUyj+t078A8UxShN0Ig1te/IvRKNazaH1kmexKwbWL7+8ASLfBi1upJE
	 Pj39ZM8K9JOUbNiSR9I9D/y4T2aWqpy2PlkvXrgmoF05+l+Zew6PoMpO+XoO4So3ung1Y
	 RKIJ/j8Z8e0qS+G2QzOdpLElUhxFcp3M8wohiDaNxUCQJQEx3BXHTugzLWy5oCw5Wp6QH
	 aMCJ1y+EE5jhvAPGQbqQUSwTVHhz/E5+cJR5GDjzB0lRUT4cC8AfiEhN/zZQ1iP9Nag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="stEoNO/V";
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0206606A31F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0206606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=stEoNO/V
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ea7190aea1so13817885ad.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793025067; x=1793629867; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S2aF/nJPcL1L7k4kule6+RDBiZtzu5J4Md55u9FTmQA=;
        b=stEoNO/Va7L3S2ug5FpXuRDzuQUh59NNi4tR/hLipjRU84Gt+KKsacKw/1TengoaIN
         voRuuIUTWcrDERER+gkc13GEdwXpTJKMGjBjmUVDMUW25QH1h+qQxKRtx0OebRFrN/fR
         kOweUfA6WqwAfiPFHG59LdUiiEW/t00efjNag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025067; x=1793629867;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2aF/nJPcL1L7k4kule6+RDBiZtzu5J4Md55u9FTmQA=;
        b=boIFsBptIaishGuXXDsLy5gwg6ge7gMq6qK+1KVmdG+UPmFSb0Fmu0/YinIZ8/p/ot
         QYar2SQ9m5X4GXhomKecpJtAMljQjm18cfF6+aYYN50B1voKsfjBQjuFT5cQzTVlnaRP
         bTMr4x8ricB4UtShxveiZn4drXLCcPc0Otgbx/wQ9pgNRXojT4ckPOufo+XqNtsIyAOq
         f+emAzAQoPH9liJelO1Ugt1EfULUdIKCVEyGdlLH3RHAVqLpb9nw+PExe41OdfufwKLG
         wauSGEsA9WUL/CZ5LJaeb7s1JlbC+9Nyb8a4mNM4NCJQzx+DBIbalBQ0gw5sf6dUETQ+
         u7Xw==
X-Forwarded-Encrypted: i=1; AKwUvBwYQzGtbVzmnM1EDAVRsUVAylv7ZRRpL0bL8LrsfOerG3OqqbJrCCs2EaR9OW63eTqtf/8SjJc=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3Xw+Ac6vji394v6DJE+gRP8L6L13T9Oetmtl6GHddX8hWT3Vm
	4xrNN5PvsgYxOhVwCQy+SgfHNORUgBNVKI4lznJSU9mM6o3AV3odz7pkEDConB1QNsw=
X-Gm-Gg: AYBFou1OgL3L1IELEIrDSMmlqq3aBtyHATRgq9RK0Yr9Kb8icbBnuf1e4YUFZogjGUB
	SppKuhz6gA1qx56qQx0DVAuHJZTSJtlB2h6cHk6ZORmWEkqvCw7j2Zrns0tTOANlqaqGvuYmwR+
	NrKj/2pe8LKVRmN5QGrxrBSEbYafLLmFwZwJRBjvGEeMMk6Htfa0phwxSMUlR0r4IemVZv3vsji
	fNiYh2BNCehuwaOQGWsNZucYUPT7n2IoG6Q5cMDdm2P6L68zBGjaO+iWwxovxnHo9N4XCe/J8U7
	aIr/yp5R4ZtVttf9KMjkqbErLJ67iA0BlMUUFQ+3HMaddXalVRsPZHhsFg3DAyehQ6Xt8W0to98
	DMljMRHJ88ol3ZS5lfbCkbwVGoB+C9Bx2/RBypsvaysedQfFouUH6QC9IkOEWqnxuOib22gY4mA
	H0pEFk9NwlVso7WNoLoh354UadRIfsNN5sAldrjNGDoSvqwN9WMlsgC583jJVmp9yfCdoouop+Z
	pLq/PuWw+TYyQags8Ic89HHPhX+uaVtutcxkaL+j4TUc8JaAP0ua52+MIXFVQgTVAuihxE0h6hE
	Io2lIVbB0XCLiYhy12p9iXPb+FtKS4K1EcN5z3SUMxuSFJNCZEBltf5NQU4+ttRZXOlrYC/zdS2
	/QtGfWv0/0gs4asipKD1iY/c=
X-Received: by 2002:a17:902:e947:b0:2e9:4f21:91ef with SMTP id d9443c01a7336-2ea9c876333mr51977345ad.36.1793025066909;
        Mon, 26 Oct 2026 07:31:06 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9af332d9sm17635845ad.11.2026.10.26.07.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:31:06 -0700 (PDT)
Date: Mon, 26 Oct 2026 22:31:03 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Kelley Nielsen <kelleynnn@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: [PATCH v2] mm: Make swapoff interruptible when unusing mms/shmem
Message-ID: <at9kJwdGkHPsWwgG@chrisdown.name>
References: <ar2YlFYjYUZ49ZA5@chrisdown.name>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar2YlFYjYUZ49ZA5@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

try_to_unuse() only checks for a pending signal between mms, and
shmem_unuse() doesn't check at all. That means that once swapoff gets to
a process or a shmem file with a lot swapped out, nothing can interrupt
it until every last page of it has been read back in.

Just as one example of where this can concretely show up, freezing tasks
for suspend or hibernation has to wait for swapoff to notice the
freezer's fake signal, and gives up after freeze_timeout_msecs (20
seconds by default).

Here's a facetious example where one swaps out 2GiB of one process to a
swap file on ext4, starts swapoff, and half a second later tries to
freeze with pm_test=freezer. Writing to /sys/power/state then fails with
EBUSY and this in dmesg:

    Freezing user space processes failed after 20.003 seconds (1 tasks refusing to freeze, wq_busy=0):
    task:swapoff         state:D stack:0     pid:3175  tgid:3175  ppid:2955   task_flags:0x400100 flags:0x00000419
    Call trace:
     [...]
     io_schedule+0x44/0x70
     folio_wait_bit_common+0x1ec/0x3d0
     __folio_lock+0x24/0x40
     unuse_pte_range+0x2d0/0x348
     unuse_vma+0x158/0x248
     unuse_mm+0xfc/0x150
     try_to_unuse+0x104/0x3f8
     __do_sys_swapoff+0x220/0x5d8
     [...]

The same goes for anything else that wants swapoff to stop, like an
admin hitting ^C in a panic, of course.

Prior to commit b56a2d8af914 ("mm: rid swapoff of quadratic complexity")
try_to_unuse() was driven by find_next_to_unuse() which checks for a
signal before every entry, so let's restore that behaviour.

Just as an example of the improvements, here's how long freezing takes
in the same test while swapoff is happening on my computer:

                      before                  after
    400MiB anon       8.925s                  0.028s
    400MiB shmem      1.639s                  0.003s
    2GiB anon         failed after 20.003s    0.011s

Fixes: b56a2d8af914 ("mm: rid swapoff of quadratic complexity")
Cc: stable@vger.kernel.org
Acked-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
Changes in v2:
- Return -ERESTARTSYS at both new signal checks and at the existing
  try_to_unuse() signal exit (Baolin).
- Request stable backporting with Cc: stable@vger.kernel.org (Andrew).

 mm/shmem.c    | 4 ++++
 mm/swapfile.c | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index fadf23f9e21e..13e0786436cd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1742,6 +1742,10 @@ static int shmem_unuse_inode(struct inode *inode, unsigned int type)
 		if (ret < 0)
 			break;
 
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
 		start = indices[folio_batch_count(&fbatch) - 1];
 	} while (true);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 254ce86fa923..0f72a5b23a3a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2689,6 +2689,8 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 	pmd = pmd_offset(pud, addr);
 	do {
 		cond_resched();
+		if (signal_pending(current))
+			return -ERESTARTSYS;
 		next = pmd_addr_end(addr, end);
 		ret = unuse_pte_range(vma, pmd, addr, next, type);
 		if (ret)
@@ -2922,7 +2924,7 @@ static int try_to_unuse(unsigned int type)
 	if (swap_usage_in_pages(si)) {
 		if (!signal_pending(current))
 			goto retry;
-		return -EINTR;
+		return -ERESTARTSYS;
 	}
 
 success:

base-commit: 0c06cb3fccd831787a8e46c929d6c5bf6ea22652
-- 
2.54.0

