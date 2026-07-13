Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD2C26F2B0
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978378; cv=none; b=IvNmznoLYezju1GxtlgexU5xxAp2pi9dhuVZRoZAj9tFBUhsUDFPz0/35LBpbTOoQoPBTLbKa7PzVcEa7pSvl2+0UUdxI+EyWlhxjsfqXFyfnsjb20Y2S2p/hM1p1QjAQo42ggz7/rCfcHc7LcbmcqOEAyAhjOlT3EX11BZ9m1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978378; c=relaxed/simple;
	bh=KPNRNFZEJ2UjwZa0agq4MDAlQLgIYnxwb+Izb8tPesk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pALvwMoY+WHq36P7qod3TQeIjWSHmEdNujMXboMyKeNLKGpY/2oKwApcVZRTedSFPLYfPInj77ZGbXvWW6NipY/TdRUHIjjCp6tNZdAYi+LWTQfEvp81VLvdx+CWB4lKgnvyfEqrp0V+Dz3S0RJhH8sh7NOidBxY888E3+RPlk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=eJdfJXem; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="eJdfJXem"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b77b150aso2689805e9.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783978375; x=1784583175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6rdaRIl05xXqbdOzxCjD1XxZpsLBKNtHk20piNYF/bM=;
        b=eJdfJXemqur2+0Qxv/hz86ypC/5EG3h/kqqYdFbL78/YQyiq65aglMOSDx/GWIV+z9
         GtNnROs5lLDY7ILbVCB47eedcrvVVYlQhinW+D42JULJiITszOIe3XYhOAVASaHN2YOg
         b35PQNXloY4ik8KMSqwS4jgw6HEZdoIdStw9WaOzPcFPC1yRop7A6MEcjPYp0F3IFw1S
         X6kZMI/cLjNA2hQQOKVmVw5Mq7FiJijGvZpm8+PVhfEWjtZNIlCBE6/XnGgF9gamoE2j
         m0vOImNdSyc75gjCUPD+E/2Vw7kmAiiJ7P/80dUGFlwnRBvyq7cHgDTAzQEFcS62QihA
         inlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783978375; x=1784583175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6rdaRIl05xXqbdOzxCjD1XxZpsLBKNtHk20piNYF/bM=;
        b=TFRuoyCyJffLohhz8gKFwSHuZtQvKJlYWhk8EL/LLD1dGK9w6nrZaev+3Z57OYtvMV
         7/TWnVP11817RjWcU36HMDLzRpSajqfJSNbRaG3BpSfS+NUPK+nHyCXtbnDUBp52Sq9a
         X+2U3jYQnTrSKjHkEPAfo/fUSKz1pMNCMbnIeVQbyOdx+iGXC0UWB4bmsOscnChkVKsD
         8l7F7ermUvQbNyX4Uo8CSx52W1IjlNPzbbglhVM1tuyf3DXLV6GeCvoLJ/u8w55z/d8n
         j1pwPgFXL/edxipFbBmigrRM1N6olB+mR148dQ1hQLLv6vF311XRPshUDHgjVvr5zf+l
         nzbg==
X-Forwarded-Encrypted: i=1; AHgh+RoljLgxMrPp7AIYwe+H2BQh9KsEbDFf7kh+JbljhNL9fOZmOzNeg41kp/Gg2r3UuSe17lrzeiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGdWF/Vz2O/hwcRlUkz99EiSN2k/Q8DFLLhRS9OJixC5aWeAXA
	0h+6/7KqHGGcWgmxSPOK5qQc8OiA5yDz1crjs01a9GN+gWtKZbrdRmngC5hVz8KIHv/9
X-Gm-Gg: AfdE7cmg268GREnflvPR3vZbDUVZMFf4PX0+H0eno9vUvetNxxE1CrMoIYnDMvVFv7N
	qrbeNJoYp7ns6RtU/ZXh0KpjlT9cLyD/wLg+y0WU2oHhFtaBwgJQagUD27/1cZJk9a1eqHSmujv
	1GMvcmTcFgz+qPdF23Se0eoxsRIx5/RPF+XWJ1/KJw9c3YFYNrKeRDuK7z7LfP94tUWSKlrRYr6
	3gBhSnptWvl7FcgwYefOEoWF3wqyl1kn5Lvo/2Htl5bGvuHPAdzF4V3vB2NtUwZY8qzFSJtiLN1
	wknFVN9hVMrthCAfGk8IWnxrySy6KvOMKv73mk+dmpLGpXvcBObxg1oJyyRhcodC3q6JvQFxsVu
	uVRzA/tQpDQjVi+pcUVRqR1+4u/zUwXfgQ+dCxaz8uImLEuC3GOaahOTtsYFXNR8Juus1yDwhJg
	vsq2rUslEnagDQeSQ71Hu8WYzIooUujA2QotQlzL+ulXkA/nhZ4G9kcPla59krT0B9d0G9HyXC8
	Zt5eVF6pPvRWDnujg430XdONwkGTAAxmxw=
X-Received: by 2002:a05:600c:3acf:b0:493:f176:dc69 with SMTP id 5b1f17b1804b1-493f884f5f2mr104527375e9.37.1783978375216;
        Mon, 13 Jul 2026 14:32:55 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508724786sm25938115e9.3.2026.07.13.14.32.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 14:32:54 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath6kl: clamp assoc request/response lengths before subtracting IE offsets
Date: Mon, 13 Jul 2026 23:32:51 +0200
Message-ID: <20260713213251.21161-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ath6kl_cfg80211_connect_event() subtracts fixed IE offsets from
assoc_req_len (-= 4) and assoc_resp_len (-= 6), both u8, with no lower
bound. The aggregate check recently added to ath6kl_wmi_connect_event_rx()
bounds the declared lengths from above (their sum must fit the received
event), but an assoc request/response shorter than its fixed offset still
underflows here: the u8 wraps to ~250, and cfg80211_connect_result() /
cfg80211_roamed() then treat that wrapped value as the IE length and copy
that many bytes out of the small assoc_info buffer to user space via
nl80211, disclosing adjacent slab memory.

Clamp both lengths to their offsets before subtracting.

Found by 0sec (https://0sec.ai) using automated source analysis; the
missing lower bound is evident from source. Compile-tested.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index cc0f2c45fc3a..62f663c0daa2 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -754,6 +754,11 @@ void ath6kl_cfg80211_connect_event(struct ath6kl_vif *vif, u16 channel,
 	u8 *assoc_resp_ie = assoc_info + beacon_ie_len + assoc_req_len +
 	    assoc_resp_ie_offset;
 
+	if (assoc_req_len < assoc_req_ie_offset)
+		assoc_req_len = assoc_req_ie_offset;
+	if (assoc_resp_len < assoc_resp_ie_offset)
+		assoc_resp_len = assoc_resp_ie_offset;
+
 	assoc_req_len -= assoc_req_ie_offset;
 	assoc_resp_len -= assoc_resp_ie_offset;
 
-- 
2.43.0

