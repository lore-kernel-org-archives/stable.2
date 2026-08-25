Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4063DFC82
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787692745; cv=none; b=NnMgm/3Uv+Ls0x3ihOu9OYYE1Gz7pEHZ5H7vj8zPaEY449Rcpn8iPfIGqlwaeSQzZhU0L/yGW9O4x3GN8E7z8sbZNcuMIzMq0tu0gSDC93uNYsZE0MJGNU086Kibw6hsCqgB6sIT4tKE1a1E32LYPPgA9z94/IDP3U8v8vfTHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787692745; c=relaxed/simple;
	bh=NL2+fDEK/NqXxgl+V4NxG0uAgKVgcbSteisQtxYRH2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzY59mMeZNeQ85OCiHzTJDY7/mk4ktaW6PWryTfyxhUY4JgMJhFJ6F/Y9vRea0fnoLGv5PTU9add1hPZ05kNTlkdTwWLl1G5Mmfn9/XP+qr9yWOSrGWpyX72X6CR76SegQnL/xfu/UGHAH50/jg5txfrhAbSKyvL+MsiJePcg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQE6KEQ9; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQE6KEQ9"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7377dde7bc6so998221137.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787692740; x=1788297540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaEPfXUewgQRHDDWoDuU8VavJ7ak/kOFZR7Xytm9nQQ=;
        b=cQE6KEQ9NmjtR7MUoWzWSAaCoHLj84cuDl75Qne0f59Hw9DqkO7l19J09/HF9uE+WW
         Ceb9V1Ov3wh5NWb54zEHqwvkoK7zOPQ1hWQnRcYT+PxttkIq2Jsn3VZbo27yFWKnXj0c
         QlK59oqcw+qegbVUlJg1wCNbGUVP7QpZCCcYhduIgQOAPIuHdMYZpDBlazLr48VDjdyj
         sKtXxgjXspj/m3INRrapA5lNgZ9gNmyhMGFkmxee1ZTqOop6YyHjjwBfEwG8gO/Y5un3
         0Mpi4yH1nGxYvRyJ3kI/27lUss7vwHM1QTCHbgN9yilqKVHH4g6e1O1ISZEvMRWLLKAX
         3i7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787692740; x=1788297540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KaEPfXUewgQRHDDWoDuU8VavJ7ak/kOFZR7Xytm9nQQ=;
        b=ZeU0HwtXyr6NW5mg2zXwmb5fpt6bhXpOIfEMv8xRPYFBfViDIR3+6XCRrjXyGhpu+f
         +LBCyborZu/UzXdKPolzOj3RR2voioj1Mk5rsqMWQ4TwmjIEK8Q0NcbuqKwsoVEggdGm
         qcR4UMEQ6tTCqkv5762QvS+87HTUIf5FHECIFsJ+zJaEXRRWU2WS+p3cDtf0u1h1grPT
         4fZeclDyjWKXRWfZn4OmaIZB6+J9RorwzyATyLs4jcrA53X1xpMOUp/lE0u0CpKF+hDC
         +D5ZhKGW5pHfG184SwmqnKfGwcoHePerBK78Z5ag3/wg+ziGgEIMKhJsNwHa4v6EgKcC
         84kw==
X-Forwarded-Encrypted: i=1; AHgh+Rpf6Z+mgWEX3GK/AsmiBtcWVZiMNvK//tFGVtVPbjstwvKngJnfXVmsYp7WWCE11H8a53oqt7g=@vger.kernel.org
X-Gm-Message-State: AFuF++kaT34U8aHB54cnNPts8g9Lqc/SR4Fea51rCzFsVKHqInw/0z7y
	8K6YbMPKPIEQhHApngxNrbI8idTrbZzmFyNOXNit0Px6akgGFhCQ1GmfVpqA0LdSsmE=
X-Gm-Gg: AR+sD12x+nvdkHdb/O7zanjHoYa1Q2gutBu2Z9y9eWRRTH/+5xxJHjXX98ZEQ5Y18Gj
	KbTZXF39T7s0LffhKsWkXUgzNLEejGbjoYzWKX0A24S3OVsdNzB0iGM5euW3a9mbfmmbHR/amxf
	Iyb58zOqfNuwgzgJ0EHYxULxkQoioOqQu3KG4cpd6P+allYQaxYQd3mgQ82ORG0G2Tm1ifWr5e7
	Vo+q9+3E1uCdnspaEmn7g30/+khSA7tmTjPQ/2LDIk/KjtHDRsmv2vTVEcm8CylDkSEhFK3h0j5
	sfIXdhEl+Q7/XrNvbrIJHvZVqbP8YXoEusM9e4PiiAUKx6V43LddCXoph8cX3gaTlD4usSVVW1J
	g7PzyVGLtX7hu/J8REN8gQKQ12MuC9c2L0rbLQjK9CqTaFMQkOPh373m+AFgrAVYesWIa8SI/e2
	fi8qMJcNpqTKdP86NGXe65z17U60bPI/S532h5IKshsqkYKOPTn1UAKv2+
X-Received: by 2002:a05:6102:2921:b0:778:3894:b2e2 with SMTP id ada2fe7eead31-782bea7ce5emr469515137.6.1787692739953;
        Tue, 25 Aug 2026 14:18:59 -0700 (PDT)
Received: from t14 ([189.39.221.242])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78307cb51b9sm47611137.7.2026.08.25.14.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:18:59 -0700 (PDT)
From: Mauricio Bellon <mauriciobellon@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Wayne Lin <Wayne.Lin@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mauricio Bellon <mbellon@lenovo.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	christian.koenig@amd.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/display: enable sink DSC before source DSC
Date: Tue, 25 Aug 2026 18:18:19 -0300
Message-ID: <20260825211819.100210-3-mauriciobellon@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825211819.100210-1-mauriciobellon@gmail.com>
References: <20260825211819.100210-1-mauriciobellon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mauricio Bellon <mbellon@lenovo.com>

Direct DisplayPort high-refresh modes using DSC and two-way ODM can
commit without visible output during a 4K120-to-4K144 transition. A
working 4K144 stream can also return black after long-pulse hotplug
reconstruction.

The DPMS-on path currently enables source DSC before link enablement but
does not enable sink DSC until after the source stream is enabled. This
leaves the sink and source compression state ordered differently while
the stream is brought up.

Enable sink DSC immediately before source DSC in the pre-enable phase,
and remove the later redundant sink-enable operation near PPS packet
programming. This establishes the order as sink DSC, source DSC, stream
enablement, and PPS before the compressed stream becomes visible.

Cc: stable@vger.kernel.org
Signed-off-by: Mauricio Bellon <mbellon@lenovo.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 48b086d15..412ce52b3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2635,8 +2635,10 @@ static enum dc_status link_set_dpms_on_pre_enable_link(
 	 */
 	if (stream->timing.flags.DSC) {
 		if (dc_is_dp_signal(stream->signal) ||
-			dc_is_virtual_signal(stream->signal))
+			dc_is_virtual_signal(stream->signal)) {
+			dp_set_dsc_on_rx(pipe_ctx, true);
 			link_set_dsc_enable(pipe_ctx, true);
+		}
 	}
 
 	if (link->replay_settings.config.replay_supported && !dc_is_embedded_signal(link->connector_signal))
@@ -2729,7 +2731,6 @@ static enum dc_status link_set_dpms_on_post_enable_link(
 	if (stream->timing.flags.DSC) {
 		if (dc_is_dp_signal(stream->signal) ||
 				dc_is_virtual_signal(stream->signal)) {
-			dp_set_dsc_on_rx(pipe_ctx, true);
 			link_set_dsc_pps_packet(pipe_ctx, true, true);
 		}
 	}
-- 
2.53.0

