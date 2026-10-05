Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D89481FCF
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205319; cv=none; b=jCXPPyHmaDzwEaqDFDZkfAvV67CSqTb+NT/hHWqt/1weJGRi3qIsdpzjt+ErxdvNIT4BGzFfL3oawL4cEYmbFuaRsC1Crhz3o/JFS5FTxBz5ktO1AjCfuyYKEKmClHDYB7f0CpsLZeHh5/UXe3t+jZ15QPy43p5TlpqIYmQWMAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205319; c=relaxed/simple;
	bh=VvilBy3XcUhF0XYjdlJZyZ52j6ao/IKk5T8hVx2QVuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rW9cFwSGnTr2qj+4oOBLarY3Pj3awuy+mSCjAAFXHw+7rvpic+nvRUc9TF178k/j964gOSPbpOtqspRm4kZZTPHT790WJk5oXWFuMdrCRjW9+1yuJK6ADfdjjiBp8aWpu2SZeIY+Dlq76qcXEA51PCa8wU3gAuRSVCZ2PMnAePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ynua4U+A; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ynua4U+A"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e7361175bso1166665e9.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 06:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791205316; x=1791810116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rl1OZheCBCPMjKUjI2TjxKZoMfCFhn7MxZPI1BYjjA4=;
        b=Ynua4U+AmGdC6hXpt7xNuA5XnAgKcStwIYOn4G4HmkcoQ/hgkM703XYybQJUZ+LcJ5
         QRtHk7WEYzQtCvZc51eSJ3Ni018cwRhkuYlCfFy6ZztzfMkWVGSmwdC6SiPL0M/013q/
         X0nGQzZYBd2yh5sBL+fhbgOPUlLkz2njnCBGyStCBDqiEM/wJhPCdb6sq54FbWiudQiR
         v8rrJ3J9D8dy9hrLxrgCPmPPP6Jla4fex4aSR47vpvopTYj61ET4fhZvnD6QDIBiN1rP
         pyFMF3KUihFgcwZ8qdqIM7SdQiidbb4pwaQCWp29ucPlofUtoxeCYKo36aSwf07IggHg
         bhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791205316; x=1791810116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rl1OZheCBCPMjKUjI2TjxKZoMfCFhn7MxZPI1BYjjA4=;
        b=cNsBuwCRmb7m2CuH1tbyOsXs6zlBx9bEaiy/WlS5SxYhwbmfKwj+nMNd9MbuT8GxJg
         8B8nFWm+2pEq8VqjVYb591kPQUKsIkwnVGZAKiN6OSvVkIK+ZUld8j1fW73EdRGZZ+tA
         /NF/9mDyQLbgGNwchH8LiDLjXY8xwmHKUrdBJM9QSVZ5wLuu9+X65Op6yd0rOftWOYw2
         bg0uqIM63hQh6L8mvrYtosXwStUB6NTCDKrJdrMmh4nFo0YSEU0AIsnn+t1NLO3JxCLg
         9jnWZy0SqN8Czvo7gwK3APiLWuPDm4l55aXEzUhJhnfKu0HgKTr+de3L8WXY3zF2TUPQ
         /DFw==
X-Gm-Message-State: AFuF++n93pJ9C5a7Kl333+LDaIP5zveHIq7yqV0AfWwR/5EhlabS6KOl
	PNzAkJOoRM3Wlyo9CxuUb9vJS9jZqBMgO8Q51wuNPa8wg4T/IQPcXMos4/cLPbz0
X-Gm-Gg: AYBFou0Cki9EbYkSPldWBIR9RjDv9M33XU4ePOgYTfUDVdOVQvRkR+ijEWL/7qilhj5
	Ygb+bSfwnUrH8LAW+DVeAjUGlUUsQ5AMt6ptrBrOj9ghbJqAUpIJVqWcbe6cR9/fTVMyfYlsq7N
	uyIJd7CiVlmipZUff7P/xgHY4d53HuuoebdlqLhuv7LqZ+/UrlYnhZwU8cmj8MZL8v1CKgQJZH/
	LmHF/c+F7YadAMh6yO8bX80DyJXrdhjMxNlNmZCq6Ozl1vOlkfqBqYH0VpKoebXBetetp7FZefX
	OiOMe4M5UZKIVGCDgHhpJ0ASfXVZYFrLOuN0op3dQH/aaXHc/qPgmxx9eqGoC/YFpwqwa/ThUcf
	eYknt+qwTBnGIJzoxQmQBFW82Pzeb9JZGeozK9M03KjrIVsb0RGRtLrgoiwxzm0n97ZKEqyWN+C
	YM6nQo4BZ/at2oTCrZ/rGwTUJxzoOHPQ/X2rgwHOMIxO9ob38bt56Q/oRPbZuYPHIY0zRVeP98M
	rUjez2ZiuEk77r7
X-Received: by 2002:a05:600c:870f:b0:49f:fc4f:9efb with SMTP id 5b1f17b1804b1-4a02753fd01mr186622465e9.7.1791205316083;
        Mon, 05 Oct 2026 06:01:56 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03950375dsm137485215e9.1.2026.10.05.06.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:01:55 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10] staging: vchiq_arm: Avoid NULL ptr deref in vchiq_dump_platform_instances
Date: Mon,  5 Oct 2026 16:01:41 +0300
Message-ID: <20261005130143.138638-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Wahren <stefan.wahren@i2se.com>

commit aa899e686d442c63d50f4d369cc02dbbf0941cb0 upstream.

vchiq_get_state() can return a NULL pointer. So handle this cases and
avoid a NULL pointer derefence in vchiq_dump_platform_instances.

Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Link: https://lore.kernel.org/r/1642968143-19281-17-git-send-email-stefan.wahren@i2se.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2022-49106

 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 178cf90fb3e5..adde80b56073 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2063,6 +2063,9 @@ int vchiq_dump_platform_instances(void *dump_context)
 	int len;
 	int i;
 
+	if (!state)
+		return -ENOTCONN;
+
 	/* There is no list of instances, so instead scan all services,
 		marking those that have been dumped. */
 
-- 
2.53.0

