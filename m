Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015849;
	b=MaVVL21Uj0P7hsI+IZfv+kt/V91rdixEfAxX8zSnqFoOr+xh6jot5FhDoSNCHElQkui+
	 m9kthY3pDM0Oct3G3CMirU5FFdO5AQoqR7dCGD0VLKKFrgLYpdGSpbFaHmBMr6K3LFw89
	 xf5L+gD8H0IWQmdB11flpHInedw61GxzR0gPv0t50MFvClUjWnyWN5uBGhOj3wa5CJtFE
	 ky5vDq09aVzSLRh1iw5fHYxZBPCbIzKuw2SjOB6RjNEzginhXwKMnM9gmrP4OMvnHtfWi
	 6UapCDUsWU92+yU7Ywj2Kc547DpK5vmGd/sRfTGXdZMCBadR6B7pocUGoK4Y8jx/ElA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SziJhar8ezshKnKHhp+CUMmzVZySSfbjzN+eVLHeQo0=;
	b=PSHCXM1bdiI4liy3RbtOU2qTbE1zZMy5sjHEX0JciSqZ6KgwhI3QaEqPLAKIQ0ucsXNv
	 kW21xxh/k2H3qzsSDkQThgJu/snLrP86FFL9tRlTi26f0cFgk1R9f8WBYpy94yUNr45l0
	 dFA1An7CsvtPx1l8sS36l9Bolzw0l9rLxBWWVBVli/k2w2cuA2KAXzfSPteYPtTqKPDTS
	 e+KA/njyQYAGOj716yIaVr6jVOg5VPRn52Dt2snMZ8psNzYgyVygoJS+JplRxD1/zxi7E
	 Jt0u+R3grmVGVBH/blHctfNoVMu8sjLAjxiuBLszjCiGLp83VBa8gsjNLrEhReSfE2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=coRyIDaM;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F8B606A33E
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6F8B606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=coRyIDaM
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-380b40319bdso1755030eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795015848; x=1795620648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SziJhar8ezshKnKHhp+CUMmzVZySSfbjzN+eVLHeQo0=;
        b=coRyIDaMOQEFVbLhQ1on5tKKR/VGPQUOYduGk91znhHifaYLMi5eQlgPpyvE9XbfO8
         /7bXVF3SjPkBWyEfqc8A+DyDvf3MT5zpceYvRherOdYjb3kZYJjzjWRJq2Whdb2BjG2C
         eG2mGvKd/C06IrnNGyPey/8P+aQujQRZ0r4MYliul53hr6fB2dg7OEER1WD/1xe+Nqr/
         gBMCaP7xjg/bwRt6vVARSjNSkkxk4qeMdrvgGSXAX28/B5UbzkEXwmBc6VsCM5xbzs8N
         dHQqXz7D2u6MyKUtY0VJoD5TTWGwEcO8v426PFMsn1sRQ2oHdALcTQzcr5ddvt4CQ//9
         qZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015848; x=1795620648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SziJhar8ezshKnKHhp+CUMmzVZySSfbjzN+eVLHeQo0=;
        b=J0LAGH5wVAmOIYFfWIU7v4DXkGcr6dAQwXG1DwEq7PUTvYno1hWPzmSvrb8v+bsIlf
         xyL2kGCC3zZ4z86qhT4N9C1Z8Pds7H36/YFbWB5FNKxaVlFi8foMlNBtoDkmdxCj0f0h
         +Y0CEOOhiABbrFpigmo9B0HZTK1bgWO7+kqaEjCeob67xy3dP9IQn2MMc9gib5BD/ion
         pvGxcjREJwwOGZfMh6BHnhnYmPAXoeNYTDA0xumrsGAqjz8OLyQYAzdJzSkg3VZUrH4Q
         +hYZo+1+RQJ2mduwf5huupgFxP+A1h0E0z8taAKZ1I1dOinkelzqiL9mOdglSohLUns6
         HY4w==
X-Forwarded-Encrypted: i=1; AL+hErG35p3cDiyQhrtfqh87450VvetbgeX+OdCz0WvpyVOCADbyyVdgD/Fxslbi1Fi5RwUBBhfWDHk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WBGK9wtjTuxWv3jRod6qjRN19ZkOzfhKdbGA4zOgypuZKSfxo
	5zq/QPUgWed+OXkC94k9sqORuF5KifaXIuNvGL13VcyQSNFKBUqgMdAb
X-Gm-Gg: AZFdTZdgS3lfr8BFlqR7Nyv4bbXRRq7zdIIcYp5APGqE42NaLLXl+langyyYEBXsgMV
	uzc2rBRIXqwVrUzkxdgZm52aqJFo5jbqp8tmh9+3MAkUvVBM3JObC8dJsP/tGwN0/PsRLwB0/m2
	2UYi7dEplWlMxKib7dkeBpJwklUL0SRgn4QclV8C+B0LmuTnz9JX0pMZ7gY5S1N9COynW6MPSTV
	zIXGGQUwDyPXZes5sIGHGpKTCMkme3cztJcpA9UrCzM2UPEj043SFQYecpoX/izxIt7nL7bZqqe
	V9NuQEXicofoqHa9QcOIJLoIOaIZ5rVpXuZSD8DVvDP8SYeG0awFa9mjGcv0znGaqAaGsaNyut3
	W+ldXPn1JH3ISoojuJyjiHqzr6jGJcZP3vljYO97xHrqre8m9W7S56BHZRcKiSUxlby1/Ool1Ky
	b6qWY2EaeHoayinGOhf1Tcyc0RqLWTDDQhMkpOIdCPwqxQDSY47F/LOIQX0xobYH62E3meuf61G
	H9TwT1Qps7X0uX2J/IIADw9STaQMARoU2kwI36WvavhA3G9iObaP87hW2ObeFXQkINSBUaXomr3
	KkZvRAIQRtlmgQTG2yWQbaD+H6IpRV4q2GQ+0sVAPb1lUaQkj3UBd+EQglU=
X-Received: by 2002:a05:693c:69c7:b0:369:faa2:1fb2 with SMTP id 5a478bee46e88-3827f98a2d4mr2357647eec.8.1795015847374;
        Wed, 18 Nov 2026 07:30:47 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:2c16:ada8:2d24:d03])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a630517asm8922616eec.8.2026.11.18.07.30.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 07:30:46 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Wen Gong <quic_wgong@quicinc.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Anilkumar Kolli <quic_akolli@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH ath-current 3/3] wifi: ath11k: keep the regulatory info store on a SERVICE_READY_EXT error
Date: Wed, 18 Nov 2026 23:29:42 +0800
Message-ID: <20261118152942.62838-4-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118152942.62838-1-enderaoelyther@gmail.com>
References: <20261118152942.62838-1-enderaoelyther@gmail.com>
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

ab->reg_info_store lives as long as the device. The first
SERVICE_READY_EXT event allocates it, every later firmware start reuses
it, the regulatory events keep the rules of each radio in it, and
ath11k_reg_free() frees it together with those rules when the device is
freed.

Commit 64828f091c7d ("wifi: ath11k: fix reg_info_store leak in
ath11k_service_ready_ext_event()") frees the store and clears the
pointer on the SERVICE_READY_EXT error path. When the event fails after
a firmware restart, that leaks the rules the store holds and leaves the
store NULL while the radios stay registered with mac80211:
ath11k_reg_handle_chan_list() then writes through the NULL pointer, and
the 6 GHz paths of ath11k_mac_op_add_interface(),
ath11k_mac_parse_tx_pwr_env() and ath11k_mac_op_sta_state() read
through it. The leak that commit addressed, a store allocated by a
first start that later fails, no longer needs it: ath11k_core_free()
frees the regulatory state on every teardown path.

Do not free the store on the error path.

AI assistance was used.

Fixes: 64828f091c7d ("wifi: ath11k: fix reg_info_store leak in ath11k_service_ready_ext_event()")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Found by code review. Tested in QEMU with KASAN, using a test module
that runs a SERVICE_READY_EXT and a regulatory event on a synthetic
device and then restarts it with a failing SERVICE_READY_EXT: without
this change the store pointer is cleared; with the series applied the
store keeps the country code and the rule count of the first start.

No new W=1, sparse or smatch warnings.

 drivers/net/wireless/ath/ath11k/wmi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 08fd6795ed9e..bbca275a8289 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5136,15 +5136,6 @@ static int ath11k_service_ready_ext_event(struct ath11k_base *ab,
 
 err:
 	kfree(svc_rdy_ext.mac_phy_caps);
-
-	/*
-	 * During TLV iteration the WMI_TAG_SOC_HAL_REG_CAPABILITIES
-	 * handler may have allocated ab->reg_info_store, so free it
-	 * on error to avoid a memory leak
-	 */
-	kfree(ab->reg_info_store);
-	ab->reg_info_store = NULL;
-
 	ath11k_wmi_free_dbring_caps(ab);
 	return ret;
 }
-- 
2.56.1

