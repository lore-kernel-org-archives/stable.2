Received: from mail-ej2-f40.google.com (mail-ej2-f40.google.com [74.125.228.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD245D1BF
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149782; cv=none; b=DOkurO4jALDw9q029NVS5+2phxukf08Bd/pFbpP76u3az2JLzOwLiEBDGuB2jFyTgu7ovaY64MBBZZPgf+9icJTJa+gtEK2JUiWY2rzAUTpx7IxN6FrBR/g/8RExGPMLq2clGM61cx0gkHlWSMpZzqwh65Itg0u+JHyUEnq6+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149782; c=relaxed/simple;
	bh=x1EO1t+RhKNeTSsJq6ZLnxGbgzYj7ObuT+4PdV8PdPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/LBbi6fcRTZRZa1jW925g0rVxo+UF7i5V4NF+OvtrS88FRE1G83RklMrUyljRMw5U08zbvHs/XLnN5nrkggtHXVCS/PgZZft05bgCWKKSsEKgMMY7uPskcGstD4fhaiPnBdKf/rY4Zove1J53U55ndy/loZ2kR6OZYbbTSYRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1Ao9z2v; arc=none smtp.client-ip=74.125.228.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1Ao9z2v"
Received: by mail-ej2-f40.google.com with SMTP id a640c23a62f3a-c2a1a631f6aso68696166b.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 00:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790149776; x=1790754576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jgp+ZrcyR2hZuyp2AvG7ZUXVguQdflnbvJs857sicKc=;
        b=E1Ao9z2vHp1r7M2uqh+YkOjFPoiVDGg18ym4TRyYXszviGJuWGRj/PFG56sP5OpEmA
         RjDE2Hha1XGocy69q414mvVmsl+j3E3+fiImx/UjYwDC2KNGn5TyC6w1X8TwstfoeG8T
         2YdAV7IdBK2Mzr4D28bnksiMqXLl1gGey8AGpaKBdwqD4FKXQBVQNIEjnlv+geAOmWl8
         zqGp/cZcx1EChlOMGEYISVJ3J2StBqZ1V0gPfhFeAhSAOvSQxbTHE7qY6ONOwHOuNWBX
         Nh0ZNNF/Jf/W+J8hE9UE0ywqJtSdpkfUz70AxryVc/cVHOZAsB2r00PwoGfXqS/VrrYp
         wtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149776; x=1790754576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jgp+ZrcyR2hZuyp2AvG7ZUXVguQdflnbvJs857sicKc=;
        b=W0YrDjAaqL2/o6NKJKZpKTwvPDXvhBw+vE/5mPxk9XQl4LTQAROf8SnPWVVydS3qwV
         8Ae4tcPGJYPSxkSi8UfG+Jqm8B0lPS9IPMR6NVPHSoegQy0kXMqmGtqjk2ylHqIbwgh2
         FZhZj0sn/Ci0m80b2hp2JeWxSlR+JnMKbP30NsJLby6DPIxbO5vbR9nU1FxxY8YjIXsV
         0W7YKyosfdIohK75p4ExyHI9EdCJ/IsoPm9QGfYvFtmVFaUvtevwFrTd0Q1RAfpkVfYC
         CnZmg8/jgdLj5w423+UG2oITwxiiio/wGA/8PpZ73AiFOnlPJFExMOOAnAlAWAFQfxP8
         7QzQ==
X-Forwarded-Encrypted: i=1; AKwUvByKuE+K9P/qy6fnePl1gOIlfeV6qxetKxp10FZdx3hURSry9/G4+nl95zTDr0dPPwDy1c+baEQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nlLt6a4tr6oPsjy+BwV82+hFxRMbs/ynJODHHoGj6Mju9Zzfjz
	f+Rt+jAp8LJFhim8IhdefI4cKUIH2dYOaOi9RSs2Pn5vBaaW7AovC0yP
X-Gm-Gg: AYBFou00oCUUeEMk1/whK8Aflv6WvbaTQM7qxquAQL+LLnOAmPwUo5osZR3Eo4RwceR
	6xAXilJtACcSenpTjHhxYYO9dp7Bm4MaZl31SFqWmIrb+yzX1AWMsOz6tGLIe8imFr3t/91dwyI
	2qupqbQNGe0YoTqfHQyu+sTmQtCPueaJRnkcN9QfjIR7XtIUQ/REgTQ1MBhymKDpQqdAqtIqAiz
	bv1TjHeiZvmsfmPzVwNfr3QHi2qqxWLXRaDPHTQMNqG6Q/9A2sxUkSlzombuF7XNtC4z929rkK4
	cECeBCReyPV8ynyFItoMKTEHEnYvXyJBOGhNt4DImxTnJPrTSSLE0F6dSZpinjejp5DKqsWfl+Z
	BNLEYMcl0IdxPQGmq/N5rE5OxNJVshJN+GAcmFvRQGHRiCI4opxY/j3Hd/ioXzZv9dIAslWLL4T
	9PakDhJTrC+c3q+YnX7kzWpOsi3cUo28aUaBKXOrF5heoi0A+G/vmWnsSBzqJJ6CKk9CRT2q4IA
	2wlmy4qno92qVuPVYJjIVCzPPyJVlKGCcc8Y0CK
X-Received: by 2002:a17:907:3e8c:b0:c29:f5d5:5a96 with SMTP id a640c23a62f3a-c2aae1d27damr126462866b.32.1790149776099;
        Wed, 23 Sep 2026 00:49:36 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f5asm64951366b.15.2026.09.23.00.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:49:35 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 7/7] alpha: invalidate the local context in flush_icache_user_page()
Date: Wed, 23 Sep 2026 09:47:50 +0200
Message-ID: <20260923074903.862898-8-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923074903.862898-1-linmag7@gmail.com>
References: <20260923074903.862898-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flush_icache_user_page() has the same caller-CPU omission that the
previous patch fixed in flush_tlb_mm(): when the target mm is not the
calling CPU's active_mm nothing happens locally, and smp_call_function()
handles only the other CPUs, so this CPU may later reuse the old ASN
together with the translations it still holds.

This matters here in particular because the function exists for
operating on another process's mappings: the comment above it describes
setting breakpoints through ptrace, and access_remote_vm() reaches it
through copy_to_user_page(). The calling CPU is therefore often running
something other than the target mm.

As in flush_tlb_mm(), the uniprocessor implementation in
asm/cacheflush.h already has the missing case.

No imb() is needed, here or in ipi_flush_icache_page(). Alpha's
user-space I-cache flush works by allocating a new ASN rather than by
invalidating the I-cache: the entries stay, but they are tagged with the
old ASN and can no longer match. An imb() is only required when the ASN
space wraps and numbers are reused, and __get_new_mm_context() already
does one in that case.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 988e397b0b8a..e21bc3920bec 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -758,6 +758,9 @@ flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 			preempt_enable();
 			return;
 		}
+	} else {
+		/* smp_call_function() does not call back into this CPU.  */
+		flush_tlb_other(mm);
 	}
 
 	smp_call_function(ipi_flush_icache_page, mm, 1);
-- 
2.43.0

