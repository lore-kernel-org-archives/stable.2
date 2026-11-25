Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575882;
	b=ql530YQ5rFvymdFKc6Z1pWNBHwKGmweaLOov9oTMTO3lFWiUWX7te6D+19nr/mKcUUX5
	 ZL3R7Mdwc5lNnVpj9D8kyCm26OT5vBH3o0vUlhSwbEhS4s3Ef0CpTGsPLwejurFOngoLs
	 UlIkBVL28Fr5SRKuHCokZXuSHptDJJsOYoxm1Uz67f7YTR1XWp4Oy8zhDxkRrewJXd7MG
	 LtDsKn3R4nkP2wwG4gup7hqiK7ToyhJYe2ZkxqlcpDel2OUOOd57VU0B4vWNEPQtBpDBL
	 uaGKtsHFRk98pp806ycLQqXm1dGRHK2wQu+CY7PUMFBl+ne1ynnD1lBvqwN1XA7tL2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eX4/tC2R5B5mthZ/Pbn5Ck0uCjL/h6zZMuH7cLWUB8o=;
	b=hetB5ikIWCTPDyNii1W901gNuSNbdNV6g6v4di2k9wzj1fTpCDIVw+up6eNLMQyMfCKN
	 ZkPtVzIQBDrrqH7m3RGDvfsSzndNRiMKLVFibntos73h3O9yL0/V6t7qMc0zttSrMESOy
	 dj3jBKmI9tETvW0aueTZj96mMsCz32khUyljpODF7DAXcRaY0FN+YESLH5DOF+k/6rMq+
	 YFEn5V1M1vs7mZ9jOet6S9udaROHZmW89Jf+VOQq3veuBrv47mhsvrRGY1B34sF1WXMRB
	 v+vWM9EThaFhx1ve+OGctPo72rH8Fmy5EAhu6IPO58mow2QqeIrqmpL8RIMnH/qpFBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lQY2HIew;
	arc=none smtp.remote-ip=74.125.227.200
Received: from mail-pi2-f8.google.com (mail-pi2-f8.google.com [74.125.227.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738B606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A738B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lQY2HIew
Received: by mail-pi2-f8.google.com with SMTP id 41be03b00d2f7-cddb56fa486so1090474a12.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795575881; x=1796180681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eX4/tC2R5B5mthZ/Pbn5Ck0uCjL/h6zZMuH7cLWUB8o=;
        b=lQY2HIewggLQ9uOUytsbHhnkrpqeWQrscIwbw0/Dx7RAPmFIZFsDKpkTsMgMzibMib
         zmU00Xrjx+aCoJAbH/oF4d1AQnOXRwGQByxv1Em8TNoe1ao/Izi/BQmIrzL/6OcC8WF3
         F40XaKFnC1n2TgDWFRMBZZohy9hzt3E8gv8ksIdjN5vh1Xu7/Xq7qwNi8GjY3lmWG1i3
         SPKYW4A8YznQuGF4E2tojwlWyz3L7j9vjuKbF+Ls2ttBDANT4wl+y+m/TP+VgI0E2YKw
         WMRn+T+7wYoEF0JNEeyA9npMqN5lN1EXn6EPKojEtLq+f0iRLL1GMwUEVXk/KcTTZ4jA
         YpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795575881; x=1796180681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eX4/tC2R5B5mthZ/Pbn5Ck0uCjL/h6zZMuH7cLWUB8o=;
        b=hjfexA7gvjsQgphj1jPB9nOIO1gTOVXTLKUTVmBsAhXJx42E935/nUvvhTxi1A0DVV
         bO/WOnngWyEK0WetXFj9ETUONtkcfkU3YdzbixzXQvoCXebjU3gs8ezhso6iKIJNL7Go
         SR/nllyN/N5WtqspquNKjiaST3nGWN1RWmwlZ1EVbCua+35lRapwJzJJjgqS2Ij0wL0A
         HSkkFA7NUKJKufO+G493+UlpaALFV9e7w7bYpKGHAYUZk3Opma2eoHVA305c/f36hQjP
         GFojoNuiqn8xjnrY+CN3GqODpWZdmIZL71sXamNcRUpSz8/MuzYSuBRSHgUVuM931jvI
         AnFg==
X-Forwarded-Encrypted: i=1; AL+hErEsi01LlhZG8SQEyDgwdj0Qvq5JGUPntReBVS/Jpn+yTpeTb0cbukmy+eEUQxSN7GmB6+DEW10=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qAyZuaMlm2LbryCOL0yID3lFPOjHf7o0/QMPZegSjPtHOBNoj
	NJD2cuVo2euc2SiATvi5YA0CLZWuv0oPn+SU76DZtVncARQT1pU2obWp
X-Gm-Gg: AZFdTZeODttdoBbRZqBBbSeOv/tGEb4PSgLeyt+s/ZvjBLRyxmlGoZRZl6lw7Ys9TfB
	KxdRHhdULk0hRHBbH15C3TTlq60uRKSYC1Oxv82VVe2FRTIdRKz+N6YfWVX01YKs9s1WOzEmnWC
	jpOYW1/p07shC1AIq5Z7KuYzIuMbHypcrAAomiUrVv3NdAu7r8U3+xA1WRlM8Ur1KbQlURNeQrA
	p95uRuCMHm+Gfb4S7RTtkZ9y+Q0KBcgbdJC8k8ZcPIEs2TH+DyTFdA30a1YNm8LucHuSzmnlTsz
	DgJRhqJHAWE9UIBzY9WJZtEPfe5FSnoqVPKw98ALNpO4Fq7gvQVfnzO1jhJmVOzNYKbZUU3Gqg/
	Vw9v+aHRUwGfZcwOdCXBqedGaIBILaGYbBAo4QBCD8Obs71wtxTsdwDXF6AkILz2b/YpFdqqN9l
	Hyc/WxTw9wONfrSkkgziUl9iGUBw/glHrG+17jQvhm2zYpRDxoaKT7feqvx5SrXKKlWI6rVdo8S
	wSFzTCuWnc5jkrMFx++m3lMs+ffWsB9vKVGPDSOj+MZNBjGVf8TkDp63Stj3Pgte71kM+82T+Vx
	5GZD4KR66/jpUEaD2nCOva8yPJd2RTBeITlrPmtCDAjQ2EQq1m2SB1wZetu9uOu1J4FjPfV9zg=
	=
X-Received: by 2002:a05:6372:a705:b0:3fb:3d85:ef60 with SMTP id adf61e73a8af0-4014e45d185mr12947493637.60.1795575880940;
        Tue, 24 Nov 2026 19:04:40 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm8091113a12.2.2026.11.24.19.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:04:39 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: report all-zero cachestat for DAX mappings
Date: Wed, 25 Nov 2026 11:04:32 +0800
Message-ID: <20261125030432.274396-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

filemap_cachestat() treats every xarray value entry as a workingset
shadow.  On DAX mappings, value entries are DAX exceptional entries:
same value bit, different bit layout (flags in the low bits, pfn
above).  Decoded as a shadow, a DAX entry yields a bogus node id;
NODE_DATA() for it can be NULL, and lru_gen_test_recent() then
dereferences it:

  Oops: general protection fault
  RIP: 0010:lru_gen_test_recent+0xde/0x300
  Call Trace:
   workingset_test_recent
   filemap_cachestat
   __x64_sys_cachestat

Any writable file on a DAX mount triggers this once an mmap write
fault has populated entries.

DAX mappings have no page cache, so none of the cachestat fields
make sense for them.  Skip the xarray walk for them and report all
zeros, and document the behaviour in the syscall's kernel-doc.

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
Changes in v2:
- Return all zeros for DAX mappings instead of counting DAX entries as
  cached, per Jan Kara's suggestion (Nhat Pham agreed).  This also drops
  the dirty-accounting gap and the inaccurate PMD-order claim from v1.
- Document the DAX behaviour in the syscall's kernel-doc.

Link: https://lore.kernel.org/linux-mm/lh4cnpy2kw3tdtmhubwhhvim25kxpqxo6xttt7sihyx7x5hqdf@3tvivew2qh7m/ [Jan Kara]
Link: https://lore.kernel.org/linux-mm/CAKEwX=Py7W0vOwxKdWMCZu3d=BbF2OkgDt6Tu_AHhEJZ06w0ew@mail.gmail.com/ [Nhat Pham]
Link: https://sashiko.dev/#/patchset/20261123030014.3116755-1-bsdhenrymartin@gmail.com?part=1

 mm/filemap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a1b2ca5b933cb..4f6fd1f4caedb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4779,7 +4779,8 @@ static inline bool can_do_cachestat(struct file *f)
  * The `flags` argument is unused for now, but is included for future
  * extensibility. User should pass 0 (i.e no flag specified).
  *
- * Currently, hugetlbfs is not supported.
+ * Currently, hugetlbfs is not supported.  DAX mappings have no page
+ * cache, so cachestat() always reports all zeros for them.
  *
  * Because the status of a page can change after cachestat() checks it
  * but before it returns to the application, the returned values may
@@ -4824,7 +4825,10 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
 		csr.len == 0 ? ULONG_MAX : (csr.off + csr.len - 1) >> PAGE_SHIFT;
 	memset(&cs, 0, sizeof(struct cachestat));
 	mapping = fd_file(f)->f_mapping;
-	filemap_cachestat(mapping, first_index, last_index, &cs);
+
+	/* DAX mappings have no page cache; report all zeros. */
+	if (!dax_mapping(mapping))
+		filemap_cachestat(mapping, first_index, last_index, &cs);
 
 	if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
 		return -EFAULT;
-- 
2.53.0

