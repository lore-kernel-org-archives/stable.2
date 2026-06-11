Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C8C40D593
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140994; cv=none; b=lB4O1YoUpAr7o6oAwkz+nAfWS1hz5tiCgI93NsWSytUsoLdDAWzblQCssEzMEii/ohwoj6N2VbO3KDuqcRfGxC7/2SGyzus6bM+q7CZfUGsQLUMLKrMP1rJ2KA3PE1Htgpg7YhtR41wMZ/SQKSVdsscRgO+MBIHYPsk/KBvlyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140994; c=relaxed/simple;
	bh=gck/DeVDDWTzBKyZWa0PRS0mDw28Zfsifbm4nLZLUAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=il1MiIWajGsYzZLIGPXRI0s5JuDsPaADZmBJmUQali926PlPkZnSY9qiVEWBZtEOduLKIUVZJI+OZiqTjA7cB+NDHfzZNUDsV7ybXY2z3Aor6KUsilAgrcLWpXZ297i6MBa6JjNXcS6I90RXQvB8i97/b2I+9PimT+s+cTaCmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pafV0ytK; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pafV0ytK"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1363fe80fe8so10769539c88.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781140992; x=1781745792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WT+fivEx36NO5awPOrGIa04kuZ3OK/PwrNjHMoyylI=;
        b=pafV0ytKgIRw5Cew3l+4sdihmv26NDl9678gSGg7UJzaLvrJxVqhJIk3VCWztLujeA
         0qY71gjoooRdL9I+1f9zuEJjK/INxX+KYmIg7wjyEcR0/+/M2oJNCmiibsYKnJfuePxq
         1KjGTEzFmCljj5uQ5kjpGbwXbidNiubVBc0sxW1j9K8TLe0TgwnmfEZ4vLjooUHV3Ex5
         cQE9rYac6KnySvSPkjF3dvvbyBc+z3IX893t5SENVTEc0StNleq78kHNFgGbYW1+QRiN
         NPm2KAHGtnSfTl3PlgRUDOQ/ngejnvZvIonD/MYX6Bd6/O4SuKhz0puQcoZWMiuxMPAa
         E+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781140992; x=1781745792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WT+fivEx36NO5awPOrGIa04kuZ3OK/PwrNjHMoyylI=;
        b=cr/rG3mPoYhlsiuOupe7uzukTq3/5hx/4DMYj6MwJ30EYXR71CSwAZ4MN2ipwlDvx8
         bksfOTMGRBCvbpQfWpckf/lDzLxujbYbQkWSME5Sm8QeZnOXfYWpMIsLdOm5TSVDdpgI
         gz7Ckr7DHNnTA+zaoWcgK79XAPb71nVp/4LETPfXEpMXwGcAMRvx8eoY6DuztjmY0L+5
         Jh2+VmEwcT5dLTrBnTnO2yIZZmXHeyUHyL7Duyjf5Ru2EJq/viXprTuPIxTKfFtpmDDQ
         OKy5/qUxKcsqp2NyxpfrIAdrcqHTnrysofOflHH1K4wSFncr8ssaRpsLwWYmpgpGtfOl
         yjKg==
X-Forwarded-Encrypted: i=1; AFNElJ9IOgGZOT0bzgB33g82erfjR8VnODpjYBOZiZ8VahDNjRlfcH0hoseH1VffOm+tGDjj0H6PLOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4BLCnxeRNnQUSdPT3lc0Z04OliJIwS8d8P0T/+jlK3++ORuhD
	tk+LSYdvIXUtvstRCnV8ICKUOD/vzjns/XcG6AmDzVNEdmiK6xHnLNfxIlulnflp
X-Gm-Gg: Acq92OHUPa099wdDfjVNLKYFqZkL4PipVbd1LdIXgTRqRNQEA7nLJz9Ez4SGlrU2TJp
	aaylpkj3DXlED8YuT9ETpAbgxnWcLFFoe3J3n8zM9j6WAEzTCO8lwTBRPKHzQrPgyhbtSbcstJn
	dc7zYPBq8Z182StXhv1QQ3oNkwjNKem5diIgaxESX3C4/KTNytHbyRNmnZIJz/jZoX9IKzWdsKq
	IRNPZ8zvkPRosBS6zWGv0MTPKTkTcqrtbKkm7Zc36a3OTAUkrHVr4K/uGrNlm8OAXv6YIy1E2aa
	3V8hs36V+/FU3j3uLeou1V0z3CdD7tId7k8GtlwwOppYgS6ZiKSpD3ts76e02VIUaLFRJfun+cn
	rMj1yULg2F9Kadl/esf5+YyPt/vHWFP7/ATjV5IbCaiIxQgu7cMXuhfI/5s5OulocZsiOnEodsC
	LZ6vET71jqEpo42vOQznVKYdg98E1GnqfINiuTSus7mPvarAfbHolu3HeYNaIGDgSwz54Gk4q2t
	0C8nU4B/OSzbP/+5GLLz1Tv+g4+ftoW1wfEG/zb5MDqndLDYn93nkCz7MPMQ+9dZrVGhlCV5Aut
	kmhuiCccm+VtLv+tEtbU5N3pZr5W
X-Received: by 2002:a05:7022:4a1:b0:138:42:96eb with SMTP id a92af1059eb24-138422cb8e2mr382496c88.17.1781140992031;
        Wed, 10 Jun 2026 18:23:12 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13842f81b4bsm290810c88.1.2026.06.10.18.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 18:23:11 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-mm@kvack.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: fix CONFIG_STACK_GROWSUP typo in tools/testing/vma/include/dup.h
Date: Wed, 10 Jun 2026 18:22:44 -0700
Message-ID: <20260611012258.432043-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2b6a3f061f11 ("mm: declare VMA flags by bit") significantly
refactored the header file include/linux/mm.h.  In that step, it introduced
a typo in an ifdef, referring to a non-existing config option
STACK_GROWS_UP, whereas the actual config option is called STACK_GROWSUP.

Commit 40a4af52e047 ("mm: fix CONFIG_STACK_GROWSUP typo in mm.h") fixed
this typo in the mm.h header file, but did not update the copy of the
code in tools/testing/vma/include/dup.h. Update this copy as well.

Commit message adapted from the above-referenced fix to mm.h.

Fixes: 2b6a3f061f11 ("mm: declare VMA flags by bit")
Cc: stable@vger.kernel.org # 7.0+
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 tools/testing/vma/include/dup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 9e0dfd3a85b0..adbc3179085d 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -243,7 +243,7 @@ enum {
 #define VM_NOHUGEPAGE	INIT_VM_FLAG(NOHUGEPAGE)
 #define VM_MERGEABLE	INIT_VM_FLAG(MERGEABLE)
 #define VM_STACK	INIT_VM_FLAG(STACK)
-#ifdef CONFIG_STACK_GROWS_UP
+#ifdef CONFIG_STACK_GROWSUP
 #define VM_STACK_EARLY	INIT_VM_FLAG(STACK_EARLY)
 #else
 #define VM_STACK_EARLY	VM_NONE
-- 
2.43.0

