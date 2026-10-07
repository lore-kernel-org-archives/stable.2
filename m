Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467103B27F4
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378818; cv=none; b=UCGMElyoe77gTtgKmeLn8A6/O26O+V9qGYtvAmRilhyVyC/sO18ry3O0VFmp8blRKVjsfHK8VWuUC+I53mGzwzylyMgxwtCu3y9YDJ68FcYbpUJXChCL+HaZx8Gh/3u9LZu//EKA/Ep0DPXPtac7a6E28usfe/SXagqPBBRIqPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378818; c=relaxed/simple;
	bh=Bc2EPc2J1vWRkGDES2rWosgTe2iOIoNiE121XtYVIIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vp9k/8wHlEzdf8d7GGHcyKG+7zycqXSwcr9JNYuxBtRdyyNa1Shntl9M9+2bR97hOcvV/G9Fq4z78R02pMveVZgl6gL6aDA/I5ZvjKzhO+U1H2XMaUMLZzY0T7Eu2pdRF8hgnXgJviNFvtyyG2jbXTmjTvRYC+M8I/H/RH4O7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9IajAsC; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9IajAsC"
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-5bccc73eea4so1547741e87.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791378806; x=1791983606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YHXWb/yE7fhA7aF15l/F01Ze1XYkmrkzVKkvR/gzDUc=;
        b=T9IajAsCYClT1SiT+HRskpsj4fOyfewGLuQUhA+T+Gck3L0/7B2g37wbI5y3TjMId7
         eihsIf/qhuKLceH9/HKf9ngHisSstUtWAQ2hnlBQRHMHriZ8GkNzIWeBh/VBYooogmPW
         WgqCZZUjoaUS6ispefpjAAFPvmd16Rz+aKR/jV+8rT4b4rRZU76m7opLDRSFtrybMUUc
         w4v3bdYTapKL3JHHj1Up0TB/SmMn/NPy43ZZsSLnYErN1kEbslyzn2FaIhO1yG/sQyVd
         wzKZ1KV0xCT6XPCFmxhzJ6l42unCcdtSHrh4RSriYUSKt0I6anqRMGinWX6Z6tJJIt70
         ebyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791378806; x=1791983606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YHXWb/yE7fhA7aF15l/F01Ze1XYkmrkzVKkvR/gzDUc=;
        b=F6nxohmXaR0QbIFlx5oOCKyUBxW6QWQ+FB8041JZv5lTE6wf274ist+Q9Titi+lhuQ
         0crfg9LP6Z/srkZ5EEi0kkStt0w91VDXo5GKnAX4CJ/J2oRRj3N+1qrfhsdilX6leFd9
         SVp8RclVKlAYPyso0xO2vH5GFIEW/LsbK4n6Wv1sWy9aiRGQFHu4CrNs9Wn3PCT7jlz7
         2jYiAmVvP/ukft1ZBZ3dPJ3iupv9L4haCABxTLfqi+71q4WQI1b/u0FKbrCjEwDHXnXa
         z2KrxhOWWSS2WXCSwhTGKEuBXamQaTLyoNnZjyDBW1OrUgtVtAyuAcvF//AkXSQSrbnB
         TGkQ==
X-Gm-Message-State: AFq9FYJCpcPmpYD0ss/p64xWygzlwxagebo0P4WOxt2y7Uu5ioUYU0r1
	kCnn8vTHNKO/4AjAjkjfevqRxjXxTr2TH6knu/DzbXUFnA/x74EJO4ESD+BTmvYr
X-Gm-Gg: AYBFou3AOn+EOqb02idpWL4uJzq4neL+JdEVQTSoQVgjN/ORbUalBLnhS08AQw8pRAg
	z39nF0PJsvzCkviNm22UL3UUpbgi7J7xO4gAA8CEUduApthsdNWQIjBfAdPheAHqnChxqfscSlX
	DQUJiWhuTfr3ujRVDUFa7BnfBGqj/EMtpgliRLW2tnWSRjF3ZQccZKE9/S5Z5WnKPd0a3i8zUTN
	+ABb0YcVihbNLTchyPORJciUxfh1zHc3A+ZtZqJdxlxg7j30oC9pVuY/rfqU+lfgayzzi6dbN6R
	Z+7u05ZUPa5MGoD7po4nkiaqgt8qrHAIHcov8+pKg48gK1UKjWY/SRFUR8zrFiDv4BHCd6J4kYp
	bLv4wrVAAo6VmPOtviBzvhTvo5uke7tkkJXL8K1ezWQNtvQ8WvggOlOwQbe8QWDItX7b3J8a+AA
	+UGnPraWn+9O1Y0eIvoC2pxmF8zotcnE8wGoBv1hgcu8F2EEIe50jdbX53uQp9ugKJW8uiLnBqs
	Gx3KD1r1K9l8rog
X-Received: by 2002:a05:651c:1547:b0:3a7:7cb7:6fc1 with SMTP id 38308e7fff4ca-3a99432d1c2mr14198961fa.18.1791378805693;
        Wed, 07 Oct 2026 06:13:25 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9a1d32eb1sm6158821fa.8.2026.10.07.06.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:13:25 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 5.10/5.15] drm/amd/display: Fix out-of-bounds read in dp_get_eq_aux_rd_interval()
Date: Wed,  7 Oct 2026 16:13:12 +0300
Message-ID: <20261007131314.120362-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harry Wentland <harry.wentland@amd.com>

commit e8b4d37eba05141ee01794fc6b7f2da808cee83b upstream.

[Why & How]
The aux_rd_interval array in struct dc_lttpr_caps is declared with
MAX_REPEATER_CNT - 1 (7) elements, indexed 0..6. However, the offset
parameter passed to dp_get_eq_aux_rd_interval() can be as large as
MAX_REPEATER_CNT (8) when a sink reports 8 LTTPR repeaters via DPCD.
This leads to an out-of-bounds read of aux_rd_interval[7] when offset
is 8.

Fix this by growing aux_rd_interval to MAX_REPEATER_CNT elements to
accommodate the full range of valid repeater counts defined by the DP
spec.

Assisted-by: GitHub Copilot:Claude claude-4-opus
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a55a458a8df37a65ffda5cf721d554a8f74f6b04)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-53330

 drivers/gpu/drm/amd/display/dc/dc_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index c8c2ba7e7b05..6cce8dd64bff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -433,7 +433,7 @@ struct dc_lttpr_caps {
 	uint8_t max_link_rate;
 	uint8_t phy_repeater_cnt;
 	uint8_t max_ext_timeout;
-	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
+	uint8_t aux_rd_interval[MAX_REPEATER_CNT];
 };
 
 struct dc_dongle_caps {
-- 
2.53.0

