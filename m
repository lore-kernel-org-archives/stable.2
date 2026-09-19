Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089A231C91
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789797857; cv=none; b=h84eOzckQlpL0GiEaSCSPwDPO2FrSoZ9KnmTtlOP+xqD+DYmJvXuIDSfAzlDUnh8NSWnt0HYLs8AMOrO/RDZzDNGHVdqdk4+5FT6z8/+wc1jeRfcvqVaFUQ8ApDSkZKue5gnEksTWKuhSyeUzMPtZx++yLXJ8nlO42M3/2NYwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789797857; c=relaxed/simple;
	bh=2abGaog2uqm3CvTy296rYjCgN0jQjGmwjbL3PyoEbNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eifVNcGyUUOvYZ1k+PtgNqJ7R0JA18V6BsNezAVSQX4SlysVbxG/8JlaoAtC7I1W0KZMykBrigkGJm18zZ66kiuBdSaX3uvPJJHSLYSgOEv/u34EEbkXyUR4ljkwCr9Tv7lbSXtJf+7CpGU4xuw5nNxRj5tMld5U0Qatk+LXt3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTFy+bsF; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTFy+bsF"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso799541f8f.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 23:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789797854; x=1790402654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7s4lYPPXaaFtdkMffgNQedRCzhSo5j6VQxz7Xg5Segg=;
        b=CTFy+bsFkFQFWgrUlXjKRAqQK7Z29bioSZduLEMLlTdeEnx2qDpHylcATWRh8kGTRG
         nl92ARU7XicyWJexcwU8gfIPWNzeqRNYoh0iS1wbjz02cKX0FGhhNIB/uK5DXm7q6uSz
         hiMHU3iI/I1/+r8vwHYaM7fij6JaAZVYPxjzh4tAXH1c2AKZk8nYpqzJ9HpNDgvMg1BB
         DsgU7/jtSl1vJAmS+CGGrDA8y3wefwr/sBDv0xH+/Fx2WRca+/KNb0ML28mr9yvieucO
         OA99DP+itGJC97hP5HOHfNDJFHCEh3QKHP0lhHhjS3s+lybcTmbNEz1d+vJsv6rv0haN
         b29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789797854; x=1790402654;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7s4lYPPXaaFtdkMffgNQedRCzhSo5j6VQxz7Xg5Segg=;
        b=miIxjeGMGA3LK/LSFIwFPptdKfvOhQHVuz1CCM7i1FC7z8SV3f4TjbX3ieads/TPrq
         T6H831A4qfvTSE0bpoOuHYuPgnoSuNDce38tLsEHXyHQywY8LnMjGCzORt9zOO7fPdvj
         MKFVYbJuuzmKle/ZiyiL+Dwr9sNc0hxb7I23mcSwnA93v8z25Pq9j2u7bVuIyaX5Qyul
         uQBhAgVw6Hx8TT7dMc8W1Ns+PrnSc+NuPbnLV02HLGBy0tL3usTeA/2iqE/YpvLnqGBy
         l0VHgslfJ3o5oNrLN105CjTLozYoBs2DDSz5TouG2VCvRePQmHYm7YnlMykQKIGJqEB2
         Cp2w==
X-Forwarded-Encrypted: i=1; AKwUvByLB5yDuS4Eacs2zd786s7ri+icCdnWetywnIZo3vs8m0fJ5JtbyO/kp1LYzeodXWSJMvdxlI4=@vger.kernel.org
X-Gm-Message-State: AFuF++m82gdT2KP2VDtR5r4/p6yR60rwMuISkqtWcc5cV6bfrW8HFk14
	JPz5N97hk6MgT4tNiOMRezEIhxOxU5MeeemYxY3LJzq0wyAT1gLllR24
X-Gm-Gg: AYBFou2+rXQPqrbrndtgCs1TsLlLEHUQadHrkdvMvJHuw7bKYZWTNRWPvaREJrJPRi/
	4J52kQyIFK4OOM+fJhGyl/SqVIiPW609vlY4yJTV0d9AAMrgmW/aJNePkvg9LG4hTrmADVe6O1F
	niCFi4I5d9bH/Bdz50AFlSKMdu025UGyFUO9G3QFPMKmI884gWqQmguMNfUC57DmCVA2EzQI3fQ
	hq7IAcUlXPN+T2u+o5pX/kcBY89jqsodwxsd+E9QqWswrRpl4S5mXL3oi6Sws9zpcHmihK82v8D
	91PgQDjNs0hMaHV7OdnDNA5kbO1RXr6fwhgfjBqbbXP4/qxMJTuiiQxCl0H6Yb+0U7PjG/JU4Rn
	vMlEoA9Ydtl2ixFRhPh62QpfLutq7JM4sCWA1vmO1PS71Ck9Xfs2C06Da5n28lq7sdnkfcsjz0k
	HyLgbRQS1m/nq6wGkbCAMHTbmjCeiPYo+ScR1sqjZKYLlRR+5Ewacy+yG3QQlSMuhwNmX0p+gOi
	fD1QVUkhD7WsDGpxK4/i9UDXsHwenGksYaarr4SIbT37hLbzD1T
X-Received: by 2002:a05:600c:8709:b0:49d:870:7a69 with SMTP id 5b1f17b1804b1-49fc573514bmr117200795e9.12.1789797854220;
        Fri, 18 Sep 2026 23:04:14 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc56aab7csm81576745e9.1.2026.09.18.23.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 23:04:13 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] platform/x86: hp-bioscfg: fix OOB read in hp_get_integer_from_buffer() on unaligned input
Date: Sat, 19 Sep 2026 11:04:04 +0500
Message-ID: <20260919060404.85742-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hp_get_integer_from_buffer() aligns the read pointer before dereferencing
it:

  int *ptr = PTR_ALIGN((int *)*buffer, sizeof(int));

When *buffer is not 4-byte aligned, PTR_ALIGN() advances ptr forward by
1-3 bytes to reach the next aligned address. The bounds check that
follows does not account for that advance:

  if (*buffer_size < sizeof(int))
          return -EINVAL;

This only confirms 4 bytes remain from the original *buffer, not from
the aligned ptr. If *buffer is unaligned and *buffer_size is between 4
and (pad + 3) bytes, *(ptr++) reads up to 3 bytes past the end of the
buffer.

*buffer_size is also under-decremented on every call, aligned or not:

  *buffer_size -= sizeof(int);

*buffer is advanced to the aligned, post-read position, but
*buffer_size only accounts for the 4 bytes of the integer itself, not
the alignment padding skipped to reach it. Each unaligned read leaves
*buffer_size overstating the true remaining space by the pad amount,
an error that compounds across repeated calls against the same buffer
(hp_get_common_data_from_buffer() calls this in a sequence), making
later bounds checks against *buffer_size progressively less reliable.

Compute the padding explicitly, check for it, and account for it when
advancing *buffer_size, so the pointer and the remaining-length count
stay consistent with each other.

Also switch ptr from "int *" to "u32 *", matching the type of the
output parameter it's really standing in for, and size everything off
sizeof(*ptr)/sizeof(*integer) instead of the bare "int" type name.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v2:
  - Use sizeof(*ptr)/sizeof(*integer) instead of bare sizeof(int), and
    change ptr from "int *" to "u32 *" to match *integer's type, per
    Ilpo Järvinen's review.

Link: https://lore.kernel.org/r/20260824225610.18471-2-meatuni001@gmail.com [v1]
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 309634c..f59957e 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -38,15 +38,19 @@ struct kobj_attribute common_display_langcode =
 
 int hp_get_integer_from_buffer(u8 **buffer, u32 *buffer_size, u32 *integer)
 {
-	int *ptr = PTR_ALIGN((int *)*buffer, sizeof(int));
+	u32 *ptr = PTR_ALIGN((u32 *)*buffer, sizeof(*ptr));
+	u32 pad = (u8 *)ptr - *buffer;
 
-	/* Ensure there is enough space remaining to read the integer */
-	if (*buffer_size < sizeof(int))
+	/*
+	 * Ensure there is enough space remaining to read the integer,
+	 * including any padding PTR_ALIGN() introduced to reach it.
+	 */
+	if (*buffer_size < pad + sizeof(*ptr))
 		return -EINVAL;
 
 	*integer = *(ptr++);
 	*buffer = (u8 *)ptr;
-	*buffer_size -= sizeof(int);
+	*buffer_size -= pad + sizeof(*integer);
 
 	return 0;
 }
-- 
2.43.0

