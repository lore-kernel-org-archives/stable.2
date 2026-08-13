Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C43203B6
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620429; cv=none; b=sTZK2GTXHhTdHVKHK0W3Fhgv9W6zhPRV31q9Eu5bzBLkPqpA4hm9NEISXtRnBlOFzpses/dK0YjmRDN9XyQvIp4jaVOMYSsDtAN0ikxO5u9VS6f8gzqeWlJ5x/2aKz1vt+L3frzF9jewC7f+Q8/S0PHjUb6B2c9UR4QcqSjzHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620429; c=relaxed/simple;
	bh=r6aBqdp3HpjOWbnS+sckw8OYNQsgx+RxrUg2FsIouh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyQAOk5EeP/qnzwRolGf3sEEieSkTfeVIY6plLvED5W3OUaHoK9e0d6JQiRRzVc0wkFNLkBb1fU/NEpX1v76eD9hwqe8gXh8tug0zsG5kzFuH2dQ0zY26YlEclSB6A+4mQNiI2/IxIoYc3m0Q0VfgZAqDCfNnoU0mR8iGrQ/gz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cC8Ocd4/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC8Ocd4/"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84a2dcede83so2814407b3a.3
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786620423; x=1787225223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NRGBrMNvLSobAjKhMm1lIf6g/DD55p77HOff+VMHwOw=;
        b=cC8Ocd4/dNZ7AroPoLOtsGjwkCMB3P3bLLbk/irItEDUEEgD3eNyTkNLJT0YFJIZd/
         PWSda7pCsnFmGg+6y9B/rPfYc+2GiOBgyVc7RIfAU9Yv3b7Rxi0Z/mAXZrFuN94nw02j
         rflnNZdbxcxuF4IB0pSPaK+ajUblIe3swm6sX4ym1+3oW30gLghl9aP9/TSeIo0n4IzZ
         FwKYJHjZq6sF490tE+N/wsJP/ikSzmBPK9qnub2bNDBzhFLusr/IbUjV/7Jp+T35P4vv
         F5ntvpuq0CAyXHnulSZl+ylHeaonn3UI6HUZgducrKX/HYGfsEt8dYRDtnf+sPoCebBY
         pPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786620423; x=1787225223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NRGBrMNvLSobAjKhMm1lIf6g/DD55p77HOff+VMHwOw=;
        b=HxrqPap+L6oGtrPSsoKHmaI0KEUzLNJXqHphqeMMvCBjax6Yq4wgp4sD5cLQaQw57N
         AUGfuJznB8L8Eaf3xdd0q1su9IUWEalei9hn6B05E1ca5ea66ww0DBTieCZ8n/9B4gBP
         mL1OF9aJ2st/juTAVRw3Ao/Dd+Keo8xcD/NWKEhhOjd/Jl3HV4xEFQhaqLoYlrx4hrSk
         FM2eS2xMUHXLovlKwtGaprV5GvhXMziSlxArXSdFF4AD87sUtKG9hx7Z1JOkY1bfOEo3
         csZ9QOolP3PmeikyRvp+CXkCFTzGG+6KK5bUFoIpxN7xRzLcNJI2/VZLf9psfex4Wxf1
         GxFw==
X-Forwarded-Encrypted: i=1; AHgh+RohCHs1szxKzWTvK4UgxCiuWG2k6i4SK7AQKxYIGW32OBkuQ6pIbPuE7+uJJCxY8Ale7vvw0aM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3dVl2CYyU5m3bZLbi3oyQGM6V6h589Fk2GGADciihD5Fq0NGY
	0aH231TvJ1/WWKws2jcyifBxQqVPWi2DlQeVLO2vBmz6KklDMbCoZyON
X-Gm-Gg: AR+sD13X3mQHYkXKUI15ND3gvzEDenW5mEzdmqLzvU2arWtMGeG+cHSfc+SkdFJoeAe
	5vgpAVHrmy9pxLsk/LWFRQJkgXlL4XTgjubW7DSaOBRNRKQgbd3xNIz/XL0eAcVW7PZe+7pv2vC
	FckFYL1MTiPGxaY82kazaksqNAYbcVieMQp4NeTA6sL56prSF9QfZOTcuLUmc8saGcdEngjEh6q
	5+8aO54pgwJDpjJFg0xioCBrAVWhJBHjErZj489VTGMUogSx+O/uNjbdulWXDFlmuk37A9X7e+v
	q/NbvvfEkPjBPyOVBB6WUMjaYaa/YqJwrOoDMwZbdM9RKsnYwzDaayon+EiRYEwxHIFAGiC0A7k
	BeVpDraFZ8OihPheJUZoCEyVB33NVJX766k7tM9T1V0TaHq2PWTKgmryZM3FB0Y3iWhv0N592zx
	nv2cHC0CoZ0CAq5LaGd9S5vFPXRSav0PhKk2KJZWGOCr+HbXTxrk8atHxLDAXvgfHfSfkKpOnbC
	sOxQFLyqUrcRnzGi4jGYMzQ
X-Received: by 2002:a05:6a00:2999:b0:848:788a:e7f9 with SMTP id d2e1a72fcca58-84fc6dc62cbmr5033736b3a.18.1786620422989;
        Thu, 13 Aug 2026 04:27:02 -0700 (PDT)
Received: from localhost ([64.176.39.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbef6a59d80sm894282a12.11.2026.08.13.04.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:27:02 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	David Weber <weber.aulendorf@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/amd/display: Skip connector updates without a stream
Date: Thu, 13 Aug 2026 13:26:33 +0200
Message-ID: <20260813112634.11455-2-weber.aulendorf@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813112634.11455-1-weber.aulendorf@gmail.com>
References: <20260813112634.11455-1-weber.aulendorf@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Atomic DPMS can leave a connector assigned to an enabled but inactive
CRTC after the driver has removed its DC stream. A later atomic commit
can then change HDR_OUTPUT_METADATA or Broadcast RGB while leaving the
CRTC mode, routing and active state unchanged.

That property-only commit does not require a modeset, so it reaches the
connector stream-update path with a NULL stream. An HDR metadata change
passes the update bailout and reaches dc_stream_get_status(NULL), while
a Broadcast RGB change dereferences the stream earlier when comparing
its output color space.

Skip stream updates until a stream exists. The connector state remains
stored, and an enabling modeset applies it to the newly created stream.

The crash was reproduced on a Phoenix1 system with DCN 3.1.4 and Linux
7.2-rc5 using a one-shot AI-generated DRM atomic reproducer:

https://pastebin.com/KxT1BcSs

The reproducer first sets HDR_OUTPUT_METADATA on an active CRTC, then
sets CRTC ACTIVE=0 to remove the DC stream while keeping the connector
routed to the CRTC, and finally changes HDR_OUTPUT_METADATA from one
non-NULL blob to another. The last commit does not require a modeset and
reached dc_stream_get_status(NULL) from amdgpu_dm_atomic_commit_tail().
The same sequence completed without crashing with this fix applied.

Fixes: b232d4ed92ea ("drm/amd/display: Only force modesets when toggling HDR")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: David Weber <weber.aulendorf@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1820547b1dde..13101a6be437 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11519,6 +11519,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+		/* DPMS-off leaves the connector routed to a streamless CRTC. */
+		if (!dm_new_crtc_state->stream)
+			continue;
 
 		scaling_changed = is_scaling_state_different(dm_new_con_state,
 							     dm_old_con_state);
-- 
2.54.0

