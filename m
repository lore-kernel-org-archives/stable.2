Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA6F2727EB
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514380; cv=none; b=Nz9Jp46ZeZK7RqhGkqdr1BJty0GAFhdWXKimKp90TJUZ4roqB+xnoEQUlOg5BC7ikRAO4tfoLhouWQhh1zC0zwxDwftJBuWkjQ9vccHvpPmXmEQVmQpptx9Qe8bx8AvPJpOJNz1hgIuNNxNUId0U7Rsgk+EQl5iqZdRcxbGk5Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514380; c=relaxed/simple;
	bh=UoIdpyHy+FBCSpwrRixXpH3sB2tAgVqfiwcQVGT1/yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVvZvUpHcIkp8fZVVseA6ZbsyVYHGNcVkpvHRUz3T2Njyb7BG5Qy0ajqrMCWR/Pwjr0Rg/BE9LWL5FOoFLxZuRCsM4fei7CWw+iKhBsZslAGsuvhfbBp+7vZ4yRw3E6hwbGoCaYgdNmQC518zLvXAlj1FPQRCUUwK5bcPXPe7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rFmR9N6n; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFmR9N6n"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so598310a91.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 12:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780514379; x=1781119179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a7oEWiqRPlrqKYQz3Vgcs1hdfF2O6Qp9+772afOP9uI=;
        b=rFmR9N6nZhaeHx/IhiirkHJktI0N3pnNpeGl0uiRD1IDS+CCf1ICdrVyqa3ylnIt+S
         117zd12/5WLj9u0Ta2h2qLHDu6Ngdxg5cfX6axs9UsrS8qY9ZoVm/S1JUW85YIJDGxH9
         WoVEOnGBpiyKqd4lcNM934y1kVHhQjZny7LbdcTayYRrK35jJTdhN8p2xsugFHQYxluL
         HHsOxS1M4EqHP4fOI3EYZop8mw40E6QaTWPMmM5cG0ipCVue5WeJ2qaOBlfx2CW5COab
         0WIfEi+HXymTi9L0bfuTz4aprt5JV9T7PPPImAPgAhEb6yqS0k7UkNBRghEY/g23FsHa
         zhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780514379; x=1781119179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7oEWiqRPlrqKYQz3Vgcs1hdfF2O6Qp9+772afOP9uI=;
        b=B9zSsEfWl7RKhiHCCFGZbJ0aJgTnYXztk80K/HNN6BSwYRFABrFPw6W4k/R/VyK3k9
         ThHUNqpCv5B9gf7UBNO+NdJIkE2iTC7nPFnATBT/JHJNpcCkAIqd+v+rZs77Z9a+8H8N
         75kOV55iDhZSO9OSCT4q1oNKd4VpCQCsPTccbZhBlrxGPexTv0nRCkC60KW2AZU2vP3m
         VS5YcGCrgFVLXh/sM5qT0Iq7QjrFysDfosnLpqGdmfrv2vyVuK6V41Xsdzm/6Q0m4ij/
         QRkouiPU61N6VURUJiAN3brCCQkkYL4bsFM5QQsgY2jy+xHKa+NgNC9MqqeeoMvCDBlS
         GBXQ==
X-Gm-Message-State: AOJu0YzugtWqM6AYJfVc7fUsGwA5ZVZ1LVpWMXUSllyIDQX1rrYQtXUz
	6z0fVGXPFIRp5C4RhXECkGKGVoclOCkWA5ONe0YWDHvRJMufqAbkyUJP
X-Gm-Gg: Acq92OH1OxsDNbn/dw7pHnehrwkIg6JeC2lq0To6jHA171I7j/0PgdnCsZCVkGvXFwC
	5ukgSxmIKkYRE+BZrK5KZPIfqB8D+zpz79tEepnmzWiyu5RQ7tRk9yWU0xz8POBJoYfNl91f3hp
	GlRhuM4wfJBvevn+sQH2kKt/MYfyMx8JHGuG8zurpSA3tJ0z8YWveiUZR6QDhKGqGarPOK4Ti1n
	q1RVQ+y6kdL+dq+CupRX67m4qxP2/Cdg2SxXV+pJaWJ9/bAUNeW7YAGPdclzlaKCjjWa5ZRruoR
	BpIzyP/nJmAnAdjQFC6rfazm09A6ywpEzMsD8uBnnYlkiKxSust0+5sjfJqNw4sJuUVRiYSpDa1
	KKQLwF7HhnyxaDd36sQAeDrZl7etL9nIZEg3UrpjaFKajxWcfcFUKK+XvzEmu6AWI6NEASIA3es
	CBg/GUVtkoO+r2CVfyq/NaIc0uOJEW8YtVZw==
X-Received: by 2002:a17:90b:520d:b0:36d:86a5:5b8 with SMTP id 98e67ed59e1d1-36f782b84a5mr424573a91.11.1780514378939;
        Wed, 03 Jun 2026 12:19:38 -0700 (PDT)
Received: from Tacenda ([2401:4900:cbde:d362:a420:48d0:ac47:151d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e6e3e51casm2006055a91.1.2026.06.03.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:19:38 -0700 (PDT)
From: Dakkshesh <beakthoven@gmail.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dakkshesh <beakthoven@gmail.com>
Subject: [PATCH] scripts/sorttable: guard long_size under MCOUNT_SORT_ENABLED
Date: Thu,  4 Jun 2026 00:47:08 +0530
Message-ID: <20260603191708.27241-1-beakthoven@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang's -Wunused-but-set-global (a sub-warning of
-Wunused-but-set-variable, enabled via -Wall), points out an
unused static global variable in scripts/sorttable.c:

scripts/sorttable.c:452:12: error: variable 'long_size' set but not
  used [-Werror,-Wunused-but-set-variable]

long_size is only read inside MCOUNT_SORT_ENABLED blocks. In upstream,
it is implicitly resolved by commit b055f4c431e3 ("sorttable: Move ELF
parsing into scripts/elf-parse.[ch]") which refactors the file entirely.

Cc: stable@vger.kernel.org
Signed-off-by: Dakkshesh <beakthoven@gmail.com>
---
 scripts/sorttable.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index deed676bf..674b24a97 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -449,7 +449,9 @@ static inline void *get_index(void *start, int entsize, int index)
 }
 
 static int extable_ent_size;
+#ifdef MCOUNT_SORT_ENABLED
 static int long_size;
+#endif
 
 #define ERRSTR_MAXSZ	256
 
@@ -1311,7 +1313,9 @@ static int do_file(char const *const fname, void *addr)
 		};
 
 		e = efuncs;
+#ifdef MCOUNT_SORT_ENABLED
 		long_size		= 4;
+#endif
 		extable_ent_size	= 8;
 
 		if (r2(&ehdr->e32.e_ehsize) != sizeof(Elf32_Ehdr) ||
@@ -1348,7 +1352,9 @@ static int do_file(char const *const fname, void *addr)
 		};
 
 		e = efuncs;
+#ifdef MCOUNT_SORT_ENABLED
 		long_size		= 8;
+#endif
 		extable_ent_size	= 16;
 
 		if (r2(&ehdr->e64.e_ehsize) != sizeof(Elf64_Ehdr) ||
-- 
2.54.0

