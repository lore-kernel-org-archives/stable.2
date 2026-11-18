Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015837;
	b=pOoPDL+UPcT0s0Rz3YcsHB/zmu9OXEioU3fZspSJvJTQWlkngzP4re5B1YHtf2zQWUEN
	 VMEc7T2tU2lQyxDiO4f8yY8TCoqWALcJ6+3EIF262ugmaCWgQJJcWvYnInHbwUUHucRLb
	 IjVkiBniCVTkTz8VTwcW3OK+GmhOT61ZHH0xaZMsASNSPOkVnHJcBaGItIgu4Q8FgkWK0
	 +9pd05/VuYgualPW20ntmT3iflUKr+Y9DNCQe6K0xOd0gceptulUKPN+WGPY5vwnGMMxg
	 68xvbfaU5IJ5iCIAJPhu/2ZznrrgzCj0YGBmOzfS5d5ZoaexSsZKJEUf7N2f+tuh16A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l0Wbxu7fm6/y8ipzcr+Pib3IjmOX46dTwli0BjlLQ+A=;
	b=y8YVJQxF15stW1Y6foH0v1bcZmmx4XpREhbCNSbpEBZuPYorTmHoU2uIh5Jaglah6+av
	 tUqlJjCyKflxKjwfJBhOi+dA/+INp3tue0/sR2E8qR35BAE1tVaG2QYUZjuB3mvpRHq+z
	 MqeanGiaBl9gml+gLv2SeBCYxbe8T6s4LDj2pjnXb2iFVzvVG44V2OKe9J4/HtTDW6/mb
	 Od0Wg3Ob8akjGhyMGD+FXtB2ZZzT8TEfLwanIokbGlTqwXmfDeW3ElB9hvDomqiI5wEvc
	 A7hYhDiGSB5tGPojqi4+NzXdzq1eqBZqEnwbo55M8kC83wdloqM/sYWTYzILgQW2Xgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNjudTQf;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7EA606A33D
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A7EA606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNjudTQf
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-381f65e4e4bso1849099eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795015836; x=1795620636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0Wbxu7fm6/y8ipzcr+Pib3IjmOX46dTwli0BjlLQ+A=;
        b=nNjudTQfUtItgoHK8wzcYX+IGFRMeXj+D0aA6Rd/YI+IqEGKHlmiwm0DTzxYD6tNIX
         y2UKX/gNMusuX4F3gWYEjtlN+8ppU+9qfpj41cvSgo+uE6MahlY3OMt5dm8/y7FSWxX3
         U6uURVKB4m7HyQAMo42tMpFsLlL5AZVaf936R3u+u1YnmTDmBtbORevicnDXJl1mpD3X
         qHDB4F04WBInTWkXwgwgnlQQR3dcIFIBMjVjqbKWs1chILOjZH91nWO3/5uePD3HNchS
         MHClzeINEWtGDd+pn56VlF6MXsYBD5VxNOG/Nah9zM/VCsYdbhL1xySD7oPug46gf3vb
         IWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015836; x=1795620636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l0Wbxu7fm6/y8ipzcr+Pib3IjmOX46dTwli0BjlLQ+A=;
        b=xj/m61iHmmJ1Di6We46IZEx15WpbAk3zLwkNddeJ6/yDmV4bcjweEI82gAekeGYd8C
         z6s/zD5kgmkkL1NDkTVLcWxWyx79xMx3toq9F83zHjCU0ti/UIEhaIccYb9roXfiHy1R
         8rH6raJBUiw8MI87N8bSRPWAZC9GqE9HUreQqM3OTU83OIDvDtsCf8U7PTRyMKyAcNlg
         joAQxpeKSFWGv1i/iGQjMllL6nv01dRnnHOodsfuRdkw6NOTCi99OlpeWNqPw1oMjLHI
         qbhvvJs0X3l/Wz+BKjkDMCEpAGX87teF/iPdKy6zytQh03pBmX+Uu3ktv/mSFWpfnb5r
         Z1fw==
X-Forwarded-Encrypted: i=1; AL+hErFP2Qy2xshLy9RcHifpVG9tZ5DImuhKMeZpsgwkWhzy8mvWA6DzPMQulf6/7fnjVV+NZjG/q9E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JwaNfWfME1TNMsGSZfiIfLf4+Jae9lCYFelZqshcVW3LvLRiu
	JkquZBCqcojPZemqkCCVWl6FsU7ZUD8WYDm6YdTjaWDtPnVEOPxEmHww
X-Gm-Gg: AZFdTZfqHtN5HusWAlXiC2D07MiQO/xHcWfVJS8yvEoFkB5+GLQHuOHK3h4TbpgUCus
	a3DhXnh1csgyui6keiJ4Fz2n3Uwwp9cUT8UWBY84O4bVDIr3IzyjihxpRSGUg98LdibP0EBH6xm
	f9FeEtoN02GgKBW1toXjyT3vN9ii7L2WVEXJKyzXVJ5GEKYEZZzT0KUuQukUp3uYut1aIOhgU4t
	uvl0/i5dRDsc0ErDMJTN2Ewf1tQAEXNUz7Dl9S5H9O0pJaHF4o49jOT2BZHrQlxinhO9SHN+68n
	ix6h8+V48vharAA5rSlBjywgZ9YzIxN7r1E1KwjInu/RjtMIA9C+1Eme+Wvg3ydA9XIENfORkv+
	cLrmvckj94BiY/9BZCSO/95xM7cu3JxAl9lz5cBTbQTmr/SKm/QA3VFOSS/94rmJNfD3+sNObOp
	JXmGEfNaEq4Yhwulijg9BHHX8XIFcaR7dWeJwbQek0fgPUVsTCFu4IMBDWtl2UbCO7VOccugKS9
	A5C5+jPwZTtneCkStvKBXmJdgltC1bXsSw8urjCAEBH6Hphy2u6pA6ScnCp/t7vaxAohJf30AaG
	tuSOsj6w0fQ5DVlsV7ndK62BPpcYxOnBHWsk1eP7ycjYepfzFnnFtpldrwk=
X-Received: by 2002:a05:7300:d210:b0:36d:4135:cd7 with SMTP id 5a478bee46e88-3828083e094mr2685513eec.18.1795015834724;
        Wed, 18 Nov 2026 07:30:34 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:2c16:ada8:2d24:d03])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a630517asm8922616eec.8.2026.11.18.07.30.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 07:30:34 -0800 (PST)
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
Subject: [PATCH ath-current 2/3] wifi: ath11k: free the regulatory state when the device is freed
Date: Wed, 18 Nov 2026 23:29:41 +0800
Message-ID: <20261118152942.62838-3-enderaoelyther@gmail.com>
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

The regulatory state of struct ath11k_base, the reg_info_store array
with the rules it holds and the default_regd[] and new_regd[] domains,
lives as long as the device, but ath11k_reg_free() runs from
ath11k_core_soc_destroy(), which only ath11k_core_deinit() calls. The
teardown paths that follow a failed start skip ath11k_core_deinit():
ath11k_pci_remove() when ATH11K_FLAG_QMI_FAIL is set, and
ath11k_ahb_remove() and ath11k_ahb_shutdown() when
ATH11K_FLAG_REGISTERED is clear. They reach ath11k_core_free(), which
frees ab, and whatever regulatory state the failed start allocated
leaks.

Free the regulatory state in ath11k_core_free(), which every teardown
path reaches, right before ab itself.

AI assistance was used.

Fixes: 61a57e51e46e ("ath11k: fix rmmod failure if qmi sequence fails")
Cc: stable@vger.kernel.org # needs adjustments for <= 5.15
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Found by code review. Tested in QEMU with KASAN, using a test module
that frees a synthetic device through ath11k_core_free() after a
SERVICE_READY_EXT event allocated the store, then reads the store to
see whether it was freed: without this change the read succeeds, so the
store leaks; with the series applied KASAN reports the read as a
use-after-free of the store that ath11k_reg_free() freed from
ath11k_core_free().

No new W=1, sparse or smatch warnings.

 drivers/net/wireless/ath/ath11k/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 766ae27306f4..90124a826088 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2021,7 +2021,6 @@ static void ath11k_core_soc_destroy(struct ath11k_base *ab)
 {
 	ath11k_debugfs_soc_destroy(ab);
 	ath11k_dp_free(ab);
-	ath11k_reg_free(ab);
 	ath11k_qmi_deinit_service(ab);
 }
 
@@ -2734,6 +2733,7 @@ void ath11k_core_free(struct ath11k_base *ab)
 {
 	destroy_workqueue(ab->workqueue_aux);
 	destroy_workqueue(ab->workqueue);
+	ath11k_reg_free(ab);
 
 	kfree(ab);
 }
-- 
2.56.1

