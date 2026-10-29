Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310971;
	b=lzCU6MBYk3tRlhXI22fi4V8PWzhyGxmiSVg8kxsdPQOhfmSJpWWXKoSop+2Hju/NFtEP
	 PCrQ6pDQMYqQYFzpUY9L8qLU7i5uq6dqZzkAaC91lg5oRbiOC9ZU4bdwPh9UtCFShQYPm
	 awbmVGs85NrpGnEzTurq1Yqli+eovPnH9oCkCJPV5VsNl6RL6KH5V89wwsk3d/jam3x+a
	 AnkQ+5OJY32+p/wp0HC1cJxOntvfNWAmkFau40odeu85et2jZs6eN2tnbILQ6rTKUDiFe
	 R5uU70EPVa1BAJaoslvIonwiFZz64edAg7iA/nvqs2Nkv5asbkdQ1vd+eZg3VWHc0Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310971;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=d9XEeTWk87x2ImskMZFYpbUHdMyJkVEwO7nVEscXoGQ=;
	b=zNSjhYzNTwcRWRC1kjDRSVEQXNpYDa+x5TbOzhFQwqyTS/y99YVjVvGadop3Qjtm16kM
	 uIQ6I5edFPAcrY0RGBIbgXsKVHD0VxHYp1dKBK/+s0PIMBbxaEl2gdRfsgUBNb9Pf7nBz
	 RohYAluetJxG1rmSV/pA6YzATLh8dnB9PmgpUSem44vyf/sat0mXga77bJQCKtLnzo9U6
	 TOg8c4AlFhxIAOsIexvyLoRc2CBK2+u92bY3/8p3MW0AzFiPUa/3kagAh3TMA1kbteC6b
	 PYMK6ZynBEVvFqrRx0pQZMzfvzDW6ErZhvuxZmNS36kE963a3r6kHiEAAB5YpM7V8dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="TR/w9B0y";
	arc=none smtp.remote-ip=209.85.219.100
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6F606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBA6F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TR/w9B0y
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-91791ec1b83so731406d6.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793310970; x=1793915770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d9XEeTWk87x2ImskMZFYpbUHdMyJkVEwO7nVEscXoGQ=;
        b=PJ9gcgQtibk4VqaXxEJHhjCBxQ7IkOlICAO5VeMclzySoV/i0z8b2E1bRFgNrRVFTv
         yDkVHgE+P8GJyiee4SRlKof9CDysxefBiBM8B03Ptrn7mWlybn6tmMrWMcB0pywfgYRJ
         zjx4pZkWmnoVk6KrT4iSyaGnLvliX+q0gaC94RPmgy0RXxiDcd+r+mM8x2Q4nsavt/Wa
         uJnl9/NiWwBCMi1GaQUQXW5CRr5O7UQeI5/3S9kjutCnXE+/wluuflrSU8o5qphWKm8N
         UQyfmFE2vq7wDq6m6tZSDNTtUEB5Jg8+dQtZEvqTyL98/P7ii+PFCgJZkm3F+jhNAB5e
         jUfA==
X-Forwarded-Encrypted: i=1; AKwUvBwS/OI7XqmDadcoPTM7Mxkm3j3u68MkI04jYG6YXv8KEzPRT3/xhisjlzcD1Iyn3FFkQDT5WME=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ33KgfPWNv8iKUFd0Y2zkzHTtgvGlmqXEhvdlgdLPjvOI23r3A
	a7cd1Tot9QQKAQKhmH+p7aarCFKZlLWVzSJNWg2pZvGLEJFbVcrPcfTe/mu/QjFYYGWoMBcICIl
	lx8LHhCKgoOCU2FqgY3NPiTC/UV9OzTZS7maTTii6DV4M3g8WQbmbIzx4efSwH01Tu5nbtHqjnP
	o/UWxKPseIhU0e99RkCzr8X1SZkLwoAlesc6jOe7tkdmVhOrgSdqJlx1XQ4Wthkfe15NHRPkbo8
	dtJPAEy
X-Gm-Gg: AYBFou0nFghgwxeghFKvSttcfpYvI/B8TCtb+kpTH6ogYUVjdXylVsPWwe5cQBQZeJO
	ZkXK1h0PKDUTUWl/1/OCn0NjUj4WIdy4tblwF1xjdJs+53+VR516vJY8xk5O7xkOrJXYJL0pEVP
	aYQEFWAqIhsps2LZIpT3AkzPiqjT9kTIpUjbJkibsQGvkVsltDf4QgraQRXk8q4GusgMTVVtwW9
	9kY0rRPPUVm+4EUoMEWyPUeuM2+rxZdOkEb6whquOa5GvRFkaPSS4Fz1FGV7kteBvgevzzdcGjZ
	SGYxMMbjaGuBDKVoQJqxc7PfzhmfZvx39j7JqOP02jYK9A9KeNQv4aR+rIYJitFQDVtTi5ji9rZ
	h4JCoqpBGPxWf6wgzqefsradENMyAEqo7FD04+QwHh8REy6mfTfcb8O9GzBXkZIkBc+CFEc43le
	0uPamxB3jvTGwCFK+LX8OIgb9025n8BAax
X-Received: by 2002:a05:620a:6406:b0:93f:2f37:2e5f with SMTP id af79cd13be357-944216e4af9mr89679385a.30.1793310969662;
        Thu, 29 Oct 2026 14:56:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9442127c05fsm6997985a.14.2026.10.29.14.56.09
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:56:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c5aef2a74so552802eec.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793310968; x=1793915768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d9XEeTWk87x2ImskMZFYpbUHdMyJkVEwO7nVEscXoGQ=;
        b=TR/w9B0yCit+0KFeyvAb5RfPQLPmCfVLKwG42Z5V/ccZJN+v+b3OX8bKZg5FVDozKG
         xllLl1JfMtazYMJGeN4qAyAlrPc4UoJOXP2A7FX+ZwsBoMB6q+eWER9YAQgxLPUE51O8
         AAFxaE3Tb1uyesddBDuCez1kZHVR2BTboNXVY=
X-Forwarded-Encrypted: i=1; AKwUvBzeoA6eiBpJAz6c95uXrvIPmcg73JIeucRPAnFgz085sESyUD84RvFl6f+57d02Yt3whf9ADGk=@vger.kernel.org
X-Received: by 2002:a05:7022:1117:b0:195:49ee:94c7 with SMTP id a92af1059eb24-1ac5a0b579emr441357c88.8.1793310967983;
        Thu, 29 Oct 2026 14:56:07 -0700 (PDT)
X-Received: by 2002:a05:7022:1117:b0:195:49ee:94c7 with SMTP id a92af1059eb24-1ac5a0b579emr441301c88.8.1793310966865;
        Thu, 29 Oct 2026 14:56:06 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm1297719c88.23.2026.10.29.14.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:56:06 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: log missing primary planes only once
Date: Thu, 29 Oct 2026 17:55:40 -0400
Message-ID: <20261029215540.3008997-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Stop filling kernel logs due to something that's not even a bug. Some
igt tests, e.g. kms_flip trigger this message ~17000 times which makes
all the other diagnostics almost impossible to find.

Just inform the user about this condition once and let it through
afterward.

Fixes: a60ccade88f9 ("drm/vmwgfx: Fix crtc's atomic check conditional")
Cc: stable@vger.kernel.org
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 85228eb9c3e6..da2d3b62f75f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -155,9 +155,8 @@ int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
 	 * some actual rendering so give a clue as why it's blank.
 	 */
 	if (new_state->enable && !has_primary)
-		drm_dbg_driver(&vmw->drm,
-			       "CRTC without a primary plane will be blank.\n");
-
+		drm_info_once(&vmw->drm,
+			      "CRTC without a primary plane will be blank.\n");
 
 	if (new_state->connector_mask != connector_mask &&
 	    new_state->connector_mask != 0) {
-- 
2.53.0

