Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561008;
	b=xGuHxzt62jKg0aT65X/NJW9yVw2oP6TSJEitO1spJGzzV7zGvcOTgZJw53DAoxBhZgTM
	 Vv3ISMkjUjuD8vjxGyBL+19KUFv/x+LEdHT28eCsBoAn++me1RzFJP8Kcl9/GTWg+mTG5
	 QdUz2n0CqRvWWaycClogT3tkfOr5TtXt/ujr1AjrIpp1j3p3z3CDdF3zZ4afTfPH2RgZM
	 Yq9o04LgNhy0rQwOSqO7+2AO8aPB+UIiGbKYu6cEHtry0GStpdd2/kYNe4Xb5Z3EMyZBb
	 K+QS+XoyGLTZOBLEebQ8s18KE2flxI7ur1l8cfuIa2UY9u97STLL5xrA0TQq3Edu8CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UrOZrRzHvLOK5Hid6oKGFwpfZe9jQsY3maaMc8x+WXg=;
	b=QOAPUb+MEeZnPQSqcR+pAPuqa/pNGM9ROehkV5arcbchqXERpuoGYUjFkKuwc2dsXAjM
	 fsVxZqlcjP0wyVNuSC/PpskwHQFfzcK5ILUTFYmUQr+gIC0kJLrB0hKxHSersw0rXq8L2
	 FOBZ7nUeEaB6Gp2lhK76q6xzpfRocnj5Y97e0CVFXfKK7gs6XzDQxc9kAjloeq/M4+9kw
	 jeu2QXjaTRkD6ihc6GP7P5ohi7RksVT3dAiqWmBE63LEgP/nNMY1JTC2ZuVSDq2XXpNTF
	 mgm1owRYesY1UuiMH0jWMNUKIGrB4FxTSntfNb9A+DUzyQDjW23Aa+9kFyUjeui86KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CvvVd5IM;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1F606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56A1F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CvvVd5IM
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so757017b3a.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794561007; x=1795165807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrOZrRzHvLOK5Hid6oKGFwpfZe9jQsY3maaMc8x+WXg=;
        b=CvvVd5IMmJgjDFlxzQm7zo+4gw4L7PofAIwU8YgxKR3ldOL7V7PpwQPKDW0F+DdW+7
         xxzGRpJ4iwh4cIC7gg+gXgsqzNu7p4K5HHeWRXR9jV2142i0Ih/zLlyz91irWK+eR2Hr
         hWRXADEl6tlgEGnXQjOmHF0k58UwG3fn2ZHRyYloYsQq/Xhs5XlRw6uGT0r+e86mp89A
         H2exGebiAt1PZCzn0+zxb68j6qXouYBQYQ3nhvY4owwr2+RtVGQvFq5DyuG2wrp3GVuB
         RZUq2Gbd3Vgo5eARD/YWyNrdydqrAjSUBNQOQjTL+XXG0CyHbT3OSVZ4k1Qw0ZyqeXWX
         4DKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794561007; x=1795165807;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UrOZrRzHvLOK5Hid6oKGFwpfZe9jQsY3maaMc8x+WXg=;
        b=HTCXOf/VtkTKpVOqqMs1CMhSsqayJcR9b9A64dUU8Eau4sWW/5u7KmG9U1lBflDf8a
         yrkqT4/yVr+Xfx9aOpGjDsc8WlA1Jl6STxCh0PhLyHRZtLZpohxuLUzQYayiZQfuo4yL
         BE7PSLm9abyXqRRivlO2/8LPCgdpkIHivvIcYArS5Fv21zmO9TWct8CY3WuZuqkO02cB
         JmNLSEekwVUOoEzSYiIPWdxHGPzbpWqHPjwZ+413bzdAMD31AoTWys149YvtXLvqchRV
         A++Qlan2IQHenVl00raFXwQI6OWOI13iH8WGrRjtMnx3RC5egHq6NL5jaYl5pDsQDbPZ
         ZgqA==
X-Gm-Message-State: APuU4Z+MgfKriPs+ZW1QxR+dbtQMuO9qNcfIC1/BzjpkaPIhYhTZRMlZ
	w657WR1tZ3cMdPBfokZXCFbO0S8ju2CeBuLrRKzd6Qz7/dnzomNuDa5hL+nSKg==
X-Gm-Gg: AYBFou3It0gQGA4xH6HErbLeKckjnQILxdF2WBYInby5TlQ/HK7J3WmarQtBKZsDDWW
	6E8xwRExek+adftrODFpwxxgKPPEBICLs0cLVVPRI1xwGaCKP3Dx9a0iQIwFwsvsbGFaZ3G996r
	UAAoG9W7jL49hNgRHfjJFmnYwUxH1Qe+dYtRoTMSMOY8wf8MZr6srymmwDNI8wYI9xCmJ1xs7vo
	9qlSVuvWmiQl41m8EKN0DCGSGimLuJkm51UR+1Cn6IWbvV10CPUMzi4yBqqm7B8swsr+i8VBrcb
	a73f+Fa+bsEe9520LMIPbEXrQttqYs8V+oeFELFTZeXcwRJpuRABviP9ROxH/V02RveBbFTKtlP
	uvJYVAZdou9wpgHQs045th05BRL3sg2GFVOQsnTGRdj6DXOoqsZzgqzQWDRDrW4+yZlepC9pEw0
	2oQe2thlD7rl0T+XPILQrjpmd5feN4NlL1nXU+/HTOi6XDh0ge1Jdm1qqe239Fp9yyF++0M0FpH
	lKwYhPHmprGbiHaYoxJ26mcbQnC0XyLKs6fqkOpIfdBoA5bweWes3+PBNy+sf1S75Y4CD8y4NSj
	KLKNeIHtwgV6lu80Ww5YMr3wwHw4ZxbGJDT9dFKdqHpw
X-Received: by 2002:a05:6a00:188e:b0:89f:d449:753c with SMTP id d2e1a72fcca58-8beb5fa81e5mr1982511b3a.10.1794561007317;
        Fri, 13 Nov 2026 01:10:07 -0800 (PST)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2346e73sm817601b3a.40.2026.11.13.01.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:10:06 -0800 (PST)
From: Vernon Yang <vernon2gm@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: akpm@linux-foundation.org,
	shuah@kernel.org,
	liwang@redhat.com,
	jackmanb@google.com,
	linux-kernel@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH 6.12.y] selftests/mm: include kselftest.h in vm_util.h
Date: Fri, 13 Nov 2026 17:10:00 +0800
Message-ID: <20261113091000.382250-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

commit d8a866c766ebe34b4371d42f4a3edca200f5e645 upstream.

The 6.12.y backport of commit fdc3bc349794 ("ksm_tests: skip hugepage
test when Transparent Hugepages are disabled"), added a KSFT_SKIP return
to khugepaged.c, but the prerequisite include from upstream commit
d8a866c766eb ("selftests/mm: add commentary about 9pfs bugs") was not
backported.

As a result, the selftests/mm build fails:

  khugepaged.c:1195:24: error: ‘KSFT_SKIP’ undeclared (first use in this function)

Add the missing include, only the vm_util.h hunk of commit d8a866c766eb
("selftests/mm: add commentary about 9pfs bugs") is needed here.

The remaining hunks depend on commit 32b42970e861 ("selftests/mm: skip
gup_longterm tests on weird filesystems") and commit 571a4b62ed63
("selftests/mm: skip map_populate on weird filesystems"), which are not
present in this tree, so we don't need to backport the remaining hunks.

Fixes: 6cd1e92981f8 ("ksm_tests: skip hugepage test when Transparent Hugepages are disabled")
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 tools/testing/selftests/mm/vm_util.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 823d07d84ad0..b3d1d17a09e4 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -5,6 +5,7 @@
 #include <err.h>
 #include <strings.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
+#include "../kselftest.h"
 
 #define BIT_ULL(nr)                   (1ULL << (nr))
 #define PM_SOFT_DIRTY                 BIT_ULL(55)

base-commit: d3417611a3b40b7f04a29e558cebac2bf69889d7
-- 
2.56.0

