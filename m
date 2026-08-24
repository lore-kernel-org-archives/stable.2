Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D773AF643
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560025; cv=none; b=oUbpqLKWt2HNAVETk/UDzgSL3SPgG0bT7uY1fR313IGLYgxc5uMk41bTCl/E89NQwZEQSS10WLRwEjBJbWWHeeH58bLi7vrVWKY/m2sNZDfV4JmBzfPDtGRIOxAiPvB3i4TfL931I2KQrVUjZrdnrjSJ+NeUVGdgqMeUSgx99Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560025; c=relaxed/simple;
	bh=b2dLsDV6tovfS12A2h3XWlDcuFM60nmNNktagNvfK6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7l0UXzq/dvP9yhpT6n9I4S+pWH4/f5yTEqvRy6fMoPueVKBmmDMnxl3TizOp+Tefvmuw63bJupa2OhO0rzosgSx6oOWyrYPDBBEmbZQZPwGTvN3yEU9jkkZo/k2hr80ULpub1G9eu60LClplTMPV4EjNZAQpxzbXwT0oWwltQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbkLa+nD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbkLa+nD"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so2053179a91.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 01:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787560023; x=1788164823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v4P4xEM9InT1ACkFaSbk9oo50Oi4Re2PcJ8ZK5DAW0k=;
        b=NbkLa+nD7jhGc3SU6p6HcxoMaeOegN/mK4yVUykzSQT7CdphMwwQzjFmM099TGD9w+
         tbvpXsNzTYqNHDEZDZ7Np/nqO0V8bz+7BiozBDWRKJ7z4UwW/BYXf5MaheYQVq+rzaUi
         5WsW9ArwvKnWe6yPVc9LDquK00M7jjPLoBdE6cv7cIcOz5d3vs1w9OkW0tadEju6S+15
         lvvftesqsFpcnlbk59bKDIIDA+kPncTyWyzBcV1FNAwbm6QfXwdoEZmK1laODk8QT1YG
         mi8Zh7CP/3S2lhfHtYhUtm0DI10VbDm50ptATG4ILh5wnQ9FwaIA26FhP2ruMoEFg1+s
         QBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787560023; x=1788164823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v4P4xEM9InT1ACkFaSbk9oo50Oi4Re2PcJ8ZK5DAW0k=;
        b=OEvrsZbv8pKSzB4nIfCrFj7xfdyQhLU6Ra7v9ZIUouRFmFXahV4kJgxCl4Nk7dMFyt
         0No77F5DdqB8TzNEEJddJVuycfOLuHjUSFUxo+e54gra22tXbrTC1xy28BcKanpvRZ26
         Ti6YaTZfGVr6cAusHy8yu5djmlqAYQPgy4D5abBiM3z3/KpwsJNMeELT0TVomGWVH0AC
         0N/CDE5seTgIb/h9MMKd3+RognoHiJupPhY43TnyvxibM7c9EFqBC6+Jm4GHemQCr70g
         uSMeGmQ6ssstvUhXRQKgNv41vb/b/7tetgbyKkWBiG8gUysraZIBXGvzbQkoZVpqbgwj
         DeyA==
X-Forwarded-Encrypted: i=1; AHgh+RoW6hhoJFCoE5hCeT1/SzwG20g3YBKoaIqFGW4lJ1AZwE6XkR5PkWe7ReSiv17dwoWzhYMuI54=@vger.kernel.org
X-Gm-Message-State: AFuF++nLPp9W932ZUqtq9P4ktGC8EGJegjptiiX1QVwTOy4yROUH00le
	AJebkIQA2Dfp6xoLhZ0aB3yytei98hNzq2WEYHqDeNhxKq6BSqdWcrCY
X-Gm-Gg: AR+sD10sQZSqjfFTI2o/ZF3ZTCJ0ilzHmkZEU5q2oc14iwqfVizCXesC7hqIjymXIIV
	h/PyFvhcAFDX7dxbe5BvGKf13L51736VRwJsA6eWFM2uz8Tjq2m26kQauJwChFHt0z2FF+jn9SY
	HF+7C2X6Oq/KE5IwVInAVRL9eugUMlJZPN/MH8Ll5yLAmE6Var60oy1UCL/jNUd9zV3L07/qlXh
	UicEm6KBMY2F65jihttKX07MOWxU2MzEV9/OzDuQ43k/d2/M8hHN3u4xFhpk6AEAbMwwkX5GjyQ
	Os/Uoc5/Y4+7Oa19liw89iJCtMbLKpsqey5bYN60HAHnzGz9dQfSMFMXn/J12AVrG/3n3dEWInr
	jXXl7Cx5WoeIfZJht+OXl8HuZATkKh0ZcWClJnXvFmDLAeoNSmPi0WICzSiN5r11h+UVPjldZ3H
	/qzL+tWRrQV9KFSs/WTzCuOpWK4kmEobYP7zlD4LnlDvQ8xXg6roOZGq6rBTbXA5dCvbob1sRNZ
	kuRSedG51/FrIwZqMBwYcu0GxpII5nzow1mVu5VQQ80+CjPnoGGZYag6E8nABy8mL03zfkiCaOs
	P9ZFpFFcPP86X7Argmz1Bhw8Byw9NlFAV+E57YJazXMPnSo3bshk2zfs9ZfBn+nt/ufBltGDJ0I
	QDzX2HBV+O5Z5luVeXSVO8sBuAzf1T4hElDAmBNPLTJjK6nE=
X-Received: by 2002:a17:90b:3d8a:b0:395:4de9:b30 with SMTP id 98e67ed59e1d1-395c353e28dmr45053163a91.5.1787560023127;
        Mon, 24 Aug 2026 01:27:03 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0dd3sm25994595eec.7.2026.08.24.01.26.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 01:27:02 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>
Cc: Neal Gompa <neal@gompa.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] soc: apple: rtkit: reject syslog indices outside the entry count
Date: Mon, 24 Aug 2026 14:11:39 +0545
Message-ID: <930eb129c35cdffb877b8fd16662a3250a0e2ecf.1787559303.git.acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1787559303.git.acharyalaxman8848@gmail.com>
References: <cover.1787559303.git.acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syslog_n_entries is a count, so valid indices range from zero through
syslog_n_entries - 1. The current check also accepts syslog_n_entries
itself.

Reject that index before deriving the shared-buffer offset. The shared
copy bounds check remains the final protection against inconsistent
firmware-provided layouts.

Fixes: 9bd1d9a0d8bb ("soc: apple: Add RTKit IPC library")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/soc/apple/rtkit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index 2e62f9b3c948..da766df5a6d7 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -481,7 +481,7 @@ static void apple_rtkit_syslog_rx_log(struct apple_rtkit *rtk, u64 msg)
 			"RTKit: received syslog message but no syslog_buffer.buffer or syslog_buffer.iomem\n");
 		goto done;
 	}
-	if (idx > rtk->syslog_n_entries) {
+	if (idx >= rtk->syslog_n_entries) {
 		dev_warn(rtk->dev, "RTKit: syslog index %d out of range\n",
 			 idx);
 		goto done;
-- 
2.51.2

