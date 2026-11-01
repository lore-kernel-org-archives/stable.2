Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499236;
	b=ilUYgrI3lyRjgBtJuz77WA854JxKeGRK8wdhCBYAjDTfKPjFCefe6Xe+99VLUC9SYozd
	 m89BH0hm+bZqX0wgnO7huz7jxojU2IhJ6u83vh+EeurmWCQICdeQTqONFMVHrO0TmCFT8
	 qbW3Ys5FNQxMi79zXwzuES+r9aSWVIj3eEGk1fP0HNNYzlxaOy4hVeB7chswXlPoTduow
	 a8MMhqwFh/Ymtw0H1Refk09M3zS7ICqVXjymO7djVTITqVCwJ3XFuOFsA8b9OOB8tRMsi
	 4cEOQ+zPL7U3nWddttiBfkIxv8xlsSzE5bIO2g00lJ+Kk3NYg4KokTyfw/VdkF7FtOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Eix5k5b+jwvTTGRDCXBmAoEN+puq/mJ3KZwbyS9PKSk=;
	b=O0wasObcRCrgLrgiLl3WYqtkIpW5sVm7IO0odVDdzlTXtII6KUDxveQSlK2A4QDNKnhw
	 SL4xTyigwfBvIASd4fFZs5D0e6sFYt8UIZ/owCuZknjvMF0yD3VJs4jQ8PNXnQhYdFn9R
	 2YYxwCrrxOOj5FoHRRqPteAZcZCXbuJ6gjV+/bRY3ZBpjsce5HtvvklIVT7nqMlyfufjC
	 Fkow6GjZaSsg9Mp5Z14JloWLr9XpQ8MZYimfICViol9oBy7FtwoljkqCXkyr+mtPKnumm
	 oW1eR1qE6bK4AkZKDHhoDJWBQPbwoyjAB8PyoBhAotxgRyPYOUgRVdkuxpl2hinZyqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TpVI1F15;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD710606A327
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 02:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD710606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TpVI1F15
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f3c89594cso129809385a.2
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499235; x=1794104035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eix5k5b+jwvTTGRDCXBmAoEN+puq/mJ3KZwbyS9PKSk=;
        b=TpVI1F15EqWq+9Dt7LnuohChw9c1xQWLhpz+mP0apOhCRXWYe2F1ZJ1JkwKCTkdS4a
         C6LjtMChI0Gg5j5QbVZ1rteVHi/71GkW5i5xIE/y65dDvDtea1kq0uFea+ZbEik4iL43
         wKlIkGAdaWTjJhEDGdcKDK3DdjFn8W8126Si5zWOgrQojds8AtCC4e3a0xtnQXohbSlZ
         +WRlCX4awxDeV4qV8hRB6+BdbCjWINKo43CmjvBIxq/rLp/MoAxJaZKeGzzwPbpZGwSO
         xOP9eM2PHPHHeAt8D1yunZzFxvJqhnyKFt3kXmJKMwwHS37kopOVP/Z3BzWWHfCpRRST
         aqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499235; x=1794104035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eix5k5b+jwvTTGRDCXBmAoEN+puq/mJ3KZwbyS9PKSk=;
        b=JnNB4sXTub/DqRb5ydvNPJr5xWyOZhvUdxcgYOle0PjAt3LFtsYKmsgsp0OLGnvEee
         /Z+Ql57tglNw9UxNCsFO0OxyssBNbak+HY8cIunNh5q4Hl4cL5lrL/zuwd5VCMFiPooD
         WmtJX0EQro1Idm8FBBfJw0aA1ihVpG4k5RpUnUQ158Z9Igs7GSNY/YCgLpbIRdJp+1Yf
         m9+Ca86+Vs4JzYC5bz8Vlx8HNMbPR7WM09lNLttxwDOncpc4ejxl8LModDImTYsyOad6
         NP3VPZ3LrR2OkTlaT7yQk419y+NqyyHAotuJ+Sqv078QZhorenxIOEmJLT3Zgqw+g8MZ
         A+0w==
X-Forwarded-Encrypted: i=1; AKwUvBxEYQmJJxfG6BOfpOYuYgfAGCOFTcO4DFQ3Wlen9o6PUtxFfabvQ8voeiLFzOOPDIaSjKvGmuA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsvGGQPkBEwZmkLgM18x5Nwuj/6o8seZRYd+riwfJ+2O0keBGE
	pT4X+k56g4MfKFvkR9oRLd4wnI7NkOSWk8PRe8YlQ3mgClSBACchWRrFFQ1yuyg52Is=
X-Gm-Gg: AYBFou2Kz5Jd+93erStY5Zr82mLlpGQjYfjhovfgGAQxIHavY8SZu+CsLXTMwVSv1Ls
	Vt+CT8s/otA8k1Vode9xOcx3LvglWJGnmxzK46T7H21/alJUQRFbxlbklwK5e3uGEgUfdQAqo7r
	+Q49/XxJ4SETKlxls5cYtG06g33OCWaoIsPi+bTfp3pPcqW1Q3fwGVbIOfEyMJ/P4i5SYjljy7a
	xIoOOv2p8rRYdXURkq/lWJ0Py0mBVeLiK/AmcYCEzrr4xbEePOxKECpiezJsJafPWOekvxf4hnG
	5AQKreEgR1tcgPcx+bGRLsYstPWv0qHo8tseDNSEU4K6Iwe8irBkdoI8TSeafqXVI5YmpwPwbhk
	dyR0GL+E98v6XNQ93Jobbuzj6YYzs4VPPSLzX0a5d/9kN6X1NV7JihgLJn+3Y8xNl4ogjRhsqpw
	p+qjT6cAfCT45BIo1e7j7Yljs9BS22RFO0zwAblvk2bjWO+Qo3xJHE5Qdko409RiqsxKt9t/S9W
	IKxvZpYL0n5GC37ODaM3mp+6oQyKRBD11GGfExi6cLSbA8j6mtk2xTRRwhxWOSk2pbLJf4I1PWI
	0koTQqQ/Pu0dPgwkfHcrP0zhhQ45x3SEU3zHIByzCC4ts499RBIOC+wZ8Kg6fpWF3FlDd0NQLXo
	rDxtPFtY2Dg==
X-Received: by 2002:a05:620a:17a3:b0:93e:6a4b:3ea6 with SMTP id af79cd13be357-94421659b40mr1079691685a.24.1793499234785;
        Sat, 31 Oct 2026 19:13:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:54 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v5 05/12] mm/mmzone: read the zoneref slot once in zonelist_zone()
Date: Sat, 31 Oct 2026 22:13:33 -0400
Message-ID: <20261101021340.2251928-6-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101021340.2251928-1-gourry@gourry.net>
References: <20261101021340.2251928-1-gourry@gourry.net>
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

Memory hotplug rebuilds zonelists in place while allocations walk them,
so a zoneref slot can change between two loads of it.

zonelist_zone() loads the slot with a plain access.  The compiler may
load it again later instead of keeping the zone it already read, so a
caller can check one zone and then use another, or the NULL terminator.

Use READ_ONCE().  Callers that take a zone from a slot and keep using
it, such as get_page_from_freelist() with ac->preferred_zoneref, need
that single load.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/mmzone.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ecd1ebd49756..4bc2318ac37f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1855,7 +1855,8 @@ extern struct zone *next_zone(struct zone *zone);
 
 static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 {
-	return zoneref->zone;
+	/* Memory hotplug rewrites zonelists in place. */
+	return READ_ONCE(zoneref->zone);
 }
 
 static inline int zonelist_zone_idx(const struct zoneref *zoneref)
-- 
2.56.0

