Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF67308F32;
	Thu, 23 Jul 2026 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835703; cv=none; b=ipY9MjDWP9lF8vQTrMnnMjc9okTtWO9zso6fZq6IUj2HZJjDr73cnx/NKXipktM6D2nzsZbSWMu5i4rJ0Mq7W1XFYesRyXLz/Hhb+1RK0nv/Gnw7hT2knLw6ZSooQqRvurCW2XJkwAlSkQ/swSJUuqPShc2j4pJce5hCyZNpQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835703; c=relaxed/simple;
	bh=0Mc0Jyr4kRDKrEa7wg+/iQc8UfCNnm1H0tZPb34SeA4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iZE171txItPAfTmMfcToPHg49Xg+cRqtqLx9mX0ifI+WTlCfBOmkMUS1QE1OsnnBKRCotoKpfJZluBAit9W33+0yqFstJJs8trENzlA+mnO9gGoabSaStCr/lwP+wbIiTFVzYgFyNNVFvwEG5kMCxVP8zDZxTSIu2ILZOhiwDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWFrC2NR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWFrC2NR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668651F000E9;
	Thu, 23 Jul 2026 19:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784835694;
	bh=erTKFW7H9+CoRoRVOrZp+ST96EFwosY/MdQIR3lDgkQ=;
	h=From:Subject:Date:To:Cc;
	b=bWFrC2NRQlMff/OsgKdNISoXn/VOAJbwNDYXcHBcrHiByQQQOw1U9D2mGs6mKNsuT
	 zD7YGSt+k6cBLhPV5irhju5HIo6wFv2zUnhP7eUBdpF3jQXPuxTsPKmfANPXkOvKyJ
	 NEQxn9rN+5M9VC53efcna255KTHrhVSjtavEcp1YpAru63TeSMR4ZLTXzgi6xvNdj4
	 U0YsKu4Ev2TWKjMYfmcQOCAytExN2gvS7hGa9oQ5gpzmORsQdxk0AH6sQQ3nWTjdNG
	 7HLExS4PAlkV6+F5qQnBxtReFkrwzHsOmXnjeMBmHZfW8B7qjsDMKMP/Tu8m2aeRLk
	 SzM3DRjX3Je+A==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v2 0/2] lib/ucs2_string.c: fix out-of-bounds read in
 ucs2_strnlen()
Date: Thu, 23 Jul 2026 21:40:30 +0200
Message-Id: <20260723-fix-ucs2_strnlen-v2-0-9ea94e32a358@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NUQrCMBBEr1L220iyNBX88h5SJGk2bbCksmmDU
 nJ3Yw/g5xtm3uyQiAMluDY7MOWQwhIr4KmBYTJxJBFcZUCJnbwgCh/eYhsSPtLKcaYoVKu9dq1
 VvrNQZy+m2jmU977yFNK68Od4yOqX/pFlJaSwRlvjCG2t3Z7EkebzwiP0pZQv43GbCLEAAAA=
X-Change-ID: 20260722-fix-ucs2_strnlen-145f5d4b1f6b
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>, 
 stable@vger.kernel.org, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=0Mc0Jyr4kRDKrEa7wg+/iQc8UfCNnm1H0tZPb34SeA4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFlJeRkSrCrLHP0fFZ3OkNq7Oyn75CYhcY9FCyv2Zh991
 dF9Zd+MjoksDGJcDJZiiizLyjm5FToKvcMO/bWEmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 gQwdIwYuTgGY6mVnGBkaBZPWKvCdlmBLOX2j3Oz+4qsXO9r3RtU9m1MZdn+7Ykwiw/9Y8dur+Zg
 13/A+S90iv2rjqwN8H/Yd2ZW0a/Jfu20P9LoZAQ==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

This series fixes an off-by-one out-of-bounds read in ucs2_strnlen().

The first patch is the real fix, the second patch comes as a bonus and
fixes the code indentation.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v2:

  - Toggle the patch order. ucs2_strnlen() is now before the
    tabulation fix to make it easier to backport.

  - Add Cc: stable on the ucs2_strnlen().

Link to v1: https://lore.kernel.org/r/20260722-fix-ucs2_strnlen-v1-0-ba5bade2b026@kernel.org

---
Vincent Mailhol (2):
      lib/ucs2_string.c: fix out-of-bounds read in ucs2_strnlen()
      lib/ucs2_string.c: fix indentation

 lib/ucs2_string.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)
---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260722-fix-ucs2_strnlen-145f5d4b1f6b

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>

