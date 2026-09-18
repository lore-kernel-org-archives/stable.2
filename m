Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749E486B9B
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742177; cv=none; b=VdYIolzjK7GsggkTRISV9IR2lKqJu5p4fRoicPlutgdI9Uc+iTHTSoY0GtSj9Pzef0CzHflWEOFvSLeGS94fmvEGhZU7lwgkG5GGRubran0UL/lkofJny2OhVpozpuGK2ucOq1uF0XGn5ZNeHZFn3RzBFS/jjEoESsyefv2JobM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742177; c=relaxed/simple;
	bh=oHK7jTtToiFcxA/9CIKnKR3YjDf4Xd/qP/4WmuFBlso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MK5eS8SVvA7Oq8ilR4tmc/4urK17Q6pGUiHXIe8UKJN2Kq7lctoOEZoiNz7by+ZU08sVzcdRX6OHrbgPmT09ISJAz0vQM39juAmwsXNCX5jH8injJZ2h3GXjkULgPS56aEpig44daUKOSp8dCePbNJpu9c4StsGvZ4wMn0M6e/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6GZOzx+; arc=none smtp.client-ip=74.125.230.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6GZOzx+"
Received: by mail-lr2-f7.google.com with SMTP id 38308e7fff4ca-3a5abfab93bso5181441fa.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789742174; x=1790346974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=80thoqF6oWnfHU18nXpOy6DAO7B/ZBVuVLAIvy3f1Nk=;
        b=q6GZOzx+hzy2iRbWqUtd613E/F1RSqTkZy6oNpOtQiM22AldCxh7HS9KPHKzTq1dRn
         UPzCjtFO08wT2CY5eorcv/MRk7YDYX8yOi0qrltD/rGX31xNJacSz9UpTAraXANOUfBY
         zG+xBKDt4H/ok9tA3pJJHHPEkHGvLuuZcMlPgkEclOUph9KLFyRIXLaB75OxKiGPkVRM
         8FcNxB1I5WAt8C/vnCnrP2geeNujKK2WMoRIIkPOouSDvf4zIenD3BB49KIv9WREDHOn
         7fTSe7rZSeyhnq+Scx/a/NcFr8coe9JvsoXD9HOtOD976pxEL+zCo5F9xXPaNIS1BYX8
         G29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742174; x=1790346974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=80thoqF6oWnfHU18nXpOy6DAO7B/ZBVuVLAIvy3f1Nk=;
        b=dDX1nFihtf+TIZcs/dboYPrsiXvuudZdqKctWQHCgT/XLe6y7Xw96FKCQBi7hqBZnN
         YuFb7zPkjCNsjaoJAj1yYYn2omkCyrSproN0J2UJGNy4HAiGVVvPHxf2un5bJgW64PPa
         5z13THE419VYWW9uPzWKx1EM+0SyKQzEYmm2tvLR9L7jYF5If1Xz24aSIh4etaO5qRmP
         EUB5Jx6q1QmRWo/IHi8Ho9qkdVBev95LvoyHfIgBj9pR9gln5nnULjcsSi0AgjYhRkpe
         l1l1RJojynInSp6Wt/LvHKH7pv6LbZlNsFmMNC0o/NKOSNwE/QOuhX1eWokAzUovSbiN
         tkvw==
X-Gm-Message-State: AFuF++k6jnt0PraED2dykHWa03BL+WqixNQKJ1B+6WE9sdFMmCGJAB9k
	8BubSQbC0ikxmxPDoqxM/fOiPUJn9m3Ld5ZVzCcc7ZVm4d3sKpKUNI/AWt6iP9WcsWs=
X-Gm-Gg: AYBFou14lWMYQqxZhoIZ/6qfoXaN4uib7oliKcFJEvdIEfQ9gWMys3zfrdgXWJdzD22
	VDPQvc/vvLL+IvOgA2yoCaptSzFBY78cqTYN0vRVvDiDyK8bHc0XxMkL0tvlxQn2GF+jIkthac6
	o/eHpz9SDhl/GzXE/lYXmhSm7UgWg30y57FNAVIcaRWaI/gx93X200Pi/zmuo584m36IPy4ND+1
	yDXWHMwlgeOntAEvp3n80UwmEqpqfU4oqurCa8fbQmJbaxon6aXS4HOjoPwG01R0WTnjGF07zyt
	JhJE8/pIR9xhnN71X1FYtE5SAhs2qdIwj5VSXqO7Eu0WnLXLHFWAjUut8SXFhJEYuf4v+tWicBe
	YgjpxxvooG0DcaV+YJipcg+jJVRBC0pbaQdA3vj5iU03rZ16aVOh+FjRE4JqoV18Mhvwq0WyGq9
	Nb4NumAUQVFNFqZWBvFgViUCsOoNsR2wOMJhTG2MsON6akqTtv3x+Fi9PEO5SZXKWp7pTbCjf6F
	0xgoA==
X-Received: by 2002:a05:651c:150b:b0:3a3:749e:319b with SMTP id 38308e7fff4ca-3a5fbf55489mr5837501fa.15.1789742173556;
        Fri, 18 Sep 2026 07:36:13 -0700 (PDT)
Received: from linux ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5fd80eb8csm4784691fa.21.2026.09.18.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:36:13 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	Eugene Krasnikov <k.eugene.e@gmail.com>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Tristan Madani <tristan@talencesecurity.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15] wifi: wcn36xx: fix heap overflow from oversized firmware HAL response
Date: Fri, 18 Sep 2026 17:35:31 +0300
Message-ID: <20260918143539.97842-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

commit 88a240d86d3d64521f9194abe185ac71cc74d0bd upstream.

The firmware response dispatcher copies all synchronous HAL responses
into the 4096-byte hal_buf without validating the response length. A
response exceeding WCN36XX_HAL_BUF_SIZE causes a heap buffer overflow
with firmware-controlled content.

Add a bounds check on the response length.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Link: https://patch.msgid.link/20260421135018.352774-2-tristmd@gmail.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-74341

 drivers/net/wireless/ath/wcn36xx/smd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index a778e3e0599e..6ab91ff8338c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -3174,6 +3174,10 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_GTK_OFFLOAD_GETINFO_RSP:
 	case WCN36XX_HAL_HOST_RESUME_RSP:
 	case WCN36XX_HAL_UPDATE_CHANNEL_LIST_RSP:
+		if (len > WCN36XX_HAL_BUF_SIZE) {
+			wcn36xx_warn("HAL response too large: %d\n", len);
+			break;
+		}
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
-- 
2.53.0

