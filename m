Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7A3DEFFE
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080317; cv=none; b=MeaDlXK6o3+5c8W4b4qFzTrDC08pmwdz+mM7IvCvsXjCHyRWfr++SjKQtts0wF6/tffXIriAs/w/rwK4STyHF2Du/p0suw6RIxoFR9isZ5U5UU5eKpe/hj7ARbECSRJo6eqzkclAu7V0+hIiYqQJbXSGn0zrI/Aux7+MGndOI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080317; c=relaxed/simple;
	bh=prE0cxZeAxUrFNCwuGQT3qOCxUJi84Egaqgt5CsozWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkTcb/0Jfp5kFxBNp6C5B1XLgvjx8xYG3yGVb3GEJNaiOr7kx2PVMUlv7Yg1KEgXCrZm2G8gfkPJFED7l8Kz2ihJv9nzxJVuL8sNGEJxLOh7xcorRObKt8sDGlBnq3mN7gTA+6LHzO6K4uPbFGg7Z1AhB9sudzISWCGcb2+1B3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYgjWFln; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYgjWFln"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a3819e8be8so243091a12.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787080314; x=1787685114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CXD7tc6oMBFEmd9i6wgkKuOD03Mu31Lz4UBhvt5Ho/Q=;
        b=fYgjWFlnQeLQuMHfOq7WtkXNwV3pEcfK9oUDZDgqwkiXpUM4uJl/fI32jGYMw+gO2X
         14Tr4HVN/9zeBEB2eEJ+JYx3Crf0MJ7kI/vyEMwAmJb3yXv36pL6O/yRO9/YNMPKH5lm
         CzonU0d+HYAK2srMK48GTqYIVkiNAQUJHE0+qAc6j9cOp+mmZjG7i+PXD1WymsZZSyKJ
         opTmOrUxr5nlSZA6lmcCDZZq/7OSX3ipzJ5RyGi0THrIDl9IE6n81vW0PwGS2+kvoiXQ
         jHXK60TgLS0Ycigs6jDu62WiqkTNGQ+JEclEis3eL8GwFzil4457KTUweuhdmK/KaEyM
         zO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787080314; x=1787685114;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXD7tc6oMBFEmd9i6wgkKuOD03Mu31Lz4UBhvt5Ho/Q=;
        b=ZRpfBcQYA/OUKzxviwdPeYXkA8N2Met7gHleuZUHej0ctNhrT4Z3ZFIVLs0Tez/6pG
         XxE4oIh6B3+6UIK/p6jqOQntnkj12ah6uzm062yYPOmayGpCuTO8OQ/iiYVpIpGEwHur
         ZsPCulTcKynn2liGTtAyy/68nlIIWfnHOtpQqW7aKyhr7q9J+y912oOBiwXFLAQrzzeO
         EyDyEiyHsuStvhiZ7X4glRpZXuAo5TtfySQek+UOmlIm1qdV5UTw85YeDq4IdRXPGcv2
         eTvneIxzesfHmVeSgUv8N+TNM0LIgZCsxdhxDlB6rn8MjOqub+uWV4MrQxO3GJnmg74w
         bjwg==
X-Forwarded-Encrypted: i=1; AHgh+RrCyrRL1GN2AfbDGCnmuLgApjBu7A+9GnsN9HdX+VDJXvG3A/L5YjsskFfocgMkh3FRiZqvKww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGBViJ2w4BsCAZQ01mgxA+qEBFQrsRmY6zdDjGEOVMQsIeO64
	FmO0L1NXwSnsQOog9rOxWnG+g25mwq6qOfAIpSsa+z7vjbUszS6z4cYe
X-Gm-Gg: AR+sD10qvLcjJ0D77aSZH29MeZ8jZ3gJM58/OXvEr89DE94wjY5X8kK6fX96w2cO03Y
	Pj04sS+FGqlDEaQMwTFBm6Rq+jJWYqlqaDGlLAWcvi5yYAKAZqtLGuWElWUJwOubGXY4LrY+lHf
	sdxyrxVr5z5WnmXtMfO1YhIjPFmWoRSrSf1SoszL34J/SexCBZiv4oL4igimGsgTbtL2BF+1udC
	fmFCT6sAnn0ah3/5bk/0WhW6zwNXmYHJXLts1d/h7M4rWP5NoY2mTFdvxdgdFwX3i5P8rCuVigq
	l/QGXPcQYFD+t8Ejk4VluBR311Ai09LC1RrH+ZtW+9o7VDF5gmlc1c1hqkE8AEXBGxmFRIhrtCn
	82r9yDQaTclp2HgK3fv+mYtCqN0x3TomAM/9a4vSSrxGpwEZbMbcpPdjqbydqPAZDEoeKPWyflv
	ZAlLkSwGNg6mLUF+47Zv8BVBTZXJagbuJQNGo7OLLNKMkunv9SZRWmuMs7uFprnlxw8HtCAKswp
	skLv4bPUDrZKuTaxTJM7g==
X-Received: by 2002:a05:6402:24cd:b0:6a0:9ce5:3f5c with SMTP id 4fb4d7f45d1cf-6a3e3c986f2mr4530938a12.7.1787080314075;
        Tue, 18 Aug 2026 12:11:54 -0700 (PDT)
Received: from fedora ([2a00:7c80:0:3b5::11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8531694sm2291552a12.11.2026.08.18.12.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:11:53 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3 2/2] platform/x86: hp-bioscfg: remove dead bounds check in audit_log_entries_show
Date: Wed, 19 Aug 2026 00:11:08 +0500
Message-ID: <20260818191120.38556-3-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818191120.38556-1-meatuni001@gmail.com>
References: <20260818191120.38556-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

audit_log_entries_show() checks "count * LOG_ENTRY_SIZE > PAGE_SIZE"
prior to entering the loop. Because "count" is already bounded to fit
within PAGE_SIZE, the inner loop check "(LOG_ENTRY_SIZE * i) > PAGE_SIZE"
can never be reached and is dead code.

Remove the redundant inner bounds check and eliminate the unnecessary
"else" block after "break" to clean up the loop control flow.

Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v3:
  - Remove the dead inner loop check completely instead of adjusting
    the boundary arithmetic, as noted by Ilpo Järvinen.
  - Remove the redundant else block after break.

Changes in v2:
  - None for this patch; resubmitted as part of the v2 series.

Link: https://lore.kernel.org/r/20260803143037.93105-1-meatuni001@gmail.com [v1]
Link: https://lore.kernel.org/r/20260812111829.172273-1-meatuni001@gmail.com [v2]
---
 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
index b57e42f29282..3b20757a3e74 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
@@ -93,15 +93,12 @@ static ssize_t audit_log_entries_show(struct kobject *kobj,
 					   HPWMI_SURESTART,
 					   audit_log_buffer, 1, 128);
 
-		if (ret < 0 || (LOG_ENTRY_SIZE * i) > PAGE_SIZE) {
-			/*
-			 * Encountered a failure while reading
-			 * individual logs. Only a partial list of
-			 * audit log will be returned.
-			 */
+		/*
+		 * Encountered a failure while reading individual logs.
+		 * Only a partial list of audit log will be returned.
+		 */
+		if (ret < 0)
 			break;
-		} else {
-			memcpy(buf, audit_log_buffer, LOG_ENTRY_SIZE);
-			buf += LOG_ENTRY_SIZE;
-		}
+
+		memcpy(buf, audit_log_buffer, LOG_ENTRY_SIZE);
+		buf += LOG_ENTRY_SIZE;
 	}
 
 	return i * LOG_ENTRY_SIZE;
-- 
2.43.0
