Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460403CC303
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 06:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786861443; cv=none; b=KPw805VcUMqOGZ43cXz2cJD6mwEytyDTnhzbSR14Qg1hMI9iysmVqafNgSika2vjXQFnEaypMPeWND4X1A2RmkxnilDkvE06vj6ncVuvqwc5LTf1QebMHR1IEyIW3OYELdRtOHGsP21PJ/ZJaUD3nOTZhu6vWd1yymCM8JoVlMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786861443; c=relaxed/simple;
	bh=yCedp38KO1SGtEbv3uVQkIhrhiBQ4FIND64CiZtzIVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoZT2YnpE4fVvR4tdQ3CKpg/LnZVAeVuKmFc4zEkWvJ8hGLVk6bzbR/xXa2JF6Ko4G9BSJgvnbA6cZcR6Hf3KujlpMGVbv24XALDA7rG6SbLNKhAlDojNSmCPWsNjHEIK10Lzf6axzdlhoCjqf37SX/xkoI57mng596N/nM4Yc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsWINrou; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsWINrou"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ced3386430so24730945ad.1
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 23:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786861441; x=1787466241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2+VXnP47ytTguI11i1PKxSzDAJacSIz5jyC8KDUI+I4=;
        b=CsWINrouf0cARotaGNnIBagJyN5BC5pa+nPQsNjgZ2Tm14F25chAzvlgQhKmk6lMqY
         D/4StQboKZLPDzbu8+GiwV34zWyFMOtyI9Ya58WR1/upTllBcwq/y6ZHlgydefa+4UAq
         NGFwR7LkcusrGTnSI/jlJz5yoHc2zGJrslCJlkWxcZjj1PlO/C2h12zOCCURFLKgANag
         9i76wpdcvyPAEVoQz6q7th4aMbzMs/bh4oRkC8EtJ13t2YuQoBH1eLOZD3eJtpi9d9QU
         HZxh39EsTO0PQG1E9/qu4Y05jCq7WgyrLiaSRMLYmRce22M54sAmpOVb+vgXI8/GJ/WR
         6aDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786861441; x=1787466241;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+VXnP47ytTguI11i1PKxSzDAJacSIz5jyC8KDUI+I4=;
        b=aUH7g1vdBrmTpsB+VFcqLPbbmWFzGh0gqUzzPJNAoCCpUVLKgp/Pc+R5ur3OIwGbvV
         fVS5iqlzqWLAQQf4KTRvXhXZg84KvKEPST15DlFWzYaXHa+y1eAAv73QkXIl99lw97As
         PM0gWQbqEyU04n0xFcLeZ+RUVgRnNHp1LWu+zneJhWrtmZJkrFQEx3yNSfwmQzyu3gMA
         fXNHycpLFkBU7ap7O7GCDofZyQC6qKjHaTz+zGEqrUe+jeNTsq1cyuc3Ftcwh+oPcoBn
         3ACa5YqhUjTRHz5UyCQAqf5WSdPK2Ofk1ehfmT0uBD2DjX3+jmx39FiLmps4SMAuyFM6
         0SBA==
X-Forwarded-Encrypted: i=1; AHgh+Rph8Ai6465q9q9rgXzQ8W8KwutmH2SqnmqOslfsjUEe8Zs9wRSBbLPbeO2SJ82GsEbgbnHjVV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2xzSY0ERPROyzB2DNJSmMXHVsOD4WDSezyJbVQ+2PClmg7+8
	63fKV/F9q5xa+npLfC6m9doGubz6yyNPtLjSfCW0OqTHvdKPfPcfmwIi
X-Gm-Gg: AR+sD124sjqRxKM/KdM5KEhk8dD5vQWf1erl52ClmyX4FVooNMlSga9awe41pPSZ6W8
	aWGBvzcu3iIen+qTTGS0PNax1jMCRLFBi9pWYTBXTvQLp6THMtQs7MAQVgRemhX39jOUcbF3tEN
	IqU+oohLalKhYlJkXvqeqAXIrmNyWbt3bCzxnMkhfJPlJC79F1Fbc2dd0dG+tvODk89S33bp7fW
	7FQGYulQHYGa+anU/2boD8hEDKlok9kJBgK+1Tz3aj0S98fC4MXSigxVMKNC8GGnM8hMiivCut5
	brjXG0PtdIX/ElMcUYlVMZZ9e9o63UtueXROPK6SAp6Kw1erP6+qny8aaSZ5mC6sLbGcfulPJsw
	QuYi72PUKJYuvj+12R8+a7DhIW2agcWAKxPzctVBqaWns2fKfCePoLOmHpnQY5jm5QNTQDAhQbQ
	8bTobgUN21Z+A4xu6Mxc3pD9O6D65gCwzS5B9F1TBeVNnS4irWNGNDnmMZ7U7Ch/iOCABPh2qjY
	6QpPKQGmCp7uE4T3F1KLApE+rB/vHIUzQ==
X-Received: by 2002:a17:90b:5450:b0:38e:655c:6516 with SMTP id 98e67ed59e1d1-3933b4f3238mr18629232a91.0.1786861441487;
        Sat, 15 Aug 2026 23:24:01 -0700 (PDT)
Received: from allen-xiaomibookpro14.lan ([2600:1900:4030:ad65:0:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e14346sm686330a91.4.2026.08.15.23.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 23:24:00 -0700 (PDT)
From: =?UTF-8?q?Chang=20Jiong=28=E5=B8=B8=E7=82=AF=29?= <xspeed1989@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Chang=20Jiong=28=E5=B8=B8=E7=82=AF=29?= <xspeed1989@gmail.com>,
	stable@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	intel-xe@lists.freedesktop.org (open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/i915/cdclk: Don't force cd2x pipe select on Xe3 in bxt_sanitize_cdclk()
Date: Sun, 16 Aug 2026 14:23:44 +0800
Message-ID: <20260816062344.796615-1-xspeed1989@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_6CC00E822A788776C8F6E2D6B24C5FE4A909@qq.com>
References: <tencent_6CC00E822A788776C8F6E2D6B24C5FE4A909@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL
without a full PLL re-enable") bxt_sanitize_cdclk() normalizes the
CD2X pipe select field of the CDCLK_CTL readback to PIPE_NONE before
comparing against the expected value.

However bxt_cdclk_ctl() does not include the CD2X pipe select field
at all on DISPLAY_VER() >= 30, so on Xe3 (PTL) the normalized
readback (pipe field forced to the PIPE_NONE encoding, 0b111) can
never match the expected value (pipe field 0). The comparison now
fails on every boot and we always take the full CDCLK PLL
disable+re-enable path with the BIOS framebuffer actively scanning
out - exactly what this code was trying to avoid. On a Panther Lake
laptop (Arc B390, 8086:b080, eDP 3120x2080@120) this causes
"CPU pipe A FIFO underrun" during probe and persistent full-screen
scanout corruption for the first KMS client (the SDDM greeter);
the corruption lasts until the next full modeset.

Only normalize the CD2X pipe select field on platforms where
bxt_cdclk_ctl() actually programs it, mirroring its DISPLAY_VER()
check.

Fixes: 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable")
Cc: stable@vger.kernel.org
Signed-off-by: Chang Jiong(常炯) <xspeed1989@gmail.com>
---
v2: No code changes. Resent with From matching Signed-off-by
    (v1 was sent from 304750714@qq.com, which is not on the
    Intel CI allowlist).

 drivers/gpu/drm/i915/display/intel_cdclk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
index 7bc9b956554b..0438f5ac78c0 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -2366,8 +2366,10 @@ static void bxt_sanitize_cdclk(struct intel_display *display)
 	 * dividers both syncing to an active pipe, or asynchronously
 	 * (PIPE_NONE).
 	 */
-	cdctl &= ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
-	cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	if (DISPLAY_VER(display) < 30) {
+		cdctl &= ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+		cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	}
 
 	if (cdctl != expected) {
 		if (DISPLAY_VER(display) < 20) {
-- 
2.55.0

