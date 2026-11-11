Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370421;
	b=m54iffpbIEta0fvLn7Ry3EzIvSHnQXdsrVyKE33XTEOz4X3kQphl7vMQiqUby4jCwEuG
	 O3qsyf9Buytt7Gy9J5Wk4G+rMrVWI0iE7w1K7VP2MdF/fI+inpeYuA+eBPbkmoewQuSJf
	 ax5uPDwlSh0NztlmRFkHwZHgzYNHoca/XRtUNQmntlbMRumc5UW+PKm7uy6VOabZVmbDJ
	 NWUHkf91SvJF6HiBydk4LaQBu5kxnTjYsRWSQV/LB3Km18Tc0t/bDN/XmYtqp94nEuXrR
	 7Se+sH1hRVYZHAXAco0I6MefjFmKCPN28cDMbuWucZ39qalOY+WuRQksVW4OiOevN0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x5bZnh6bAhcn3jpXzNGe/bb7ddKlNdrbj7SMkPOVv88=;
	b=kDfoBoOKOyx/VVdeVVe8lMFCQ6QnFYpsziEa3/5deUweckd5acBh/u2zuqn8WzENzEsi
	 PCvrQzG8Q0G20Ck6ZX93B1jOcpl0Sg0f3T81+C8mh8SueLKG7vR3lbseOLMaAKoUgcpEg
	 lz4016xc5LqKni3OCHsDxo6GiHoP4Wg5GNgkaM4i8mHf7gpc6yC8oSeHNFzl7Ya7eV+Vp
	 k1jvaJcdHGqvAPzuDuMviuu5ymu5HWhi0c25sBhCUTRWiJwkUeA0m+uTgBMgCqsPR/hv4
	 wl+Ud6wghxzDiLQTbHUIyFQ19iLyOXeIgIJ9zwhcLh/zDgVG0rWPEqutii+2U61xS9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgRPjafg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB12606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgRPjafg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF431F00A00;
	Wed, 11 Nov 2026 04:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370421;
	bh=x5bZnh6bAhcn3jpXzNGe/bb7ddKlNdrbj7SMkPOVv88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WgRPjafgfrENQoAwa9lHuS6SWY26bUD3Gh7guNwG8PT4wFOPmsZuDfLKE9oGSv8p+
	 qq1LWtjfZq97ua8vNd9+WZ6M5G28fqI4AquwAlrPSst7y0sCez9lRNaJV5obeH59qL
	 JY3heP8eS0P19LYaIvYEq9gJjUqZfLniUamhh9DPRW7ZHE2JtqdMwwE+099hL/xWpO
	 /z/6hbUElDeCf87Ob/2uK3hNmJJuwBWH+2JNGKZCclbjEq1kmHfhVMapNkDCu668Yt
	 YIxsMZ/BT4g0Er3gkrD2hDjYB4jiaIeHnwr9mHRMG25Yg9gH9T81o1DwxmHo5kxFSe
	 mMOjRzmTaadkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robert Foss <robert.foss@linaro.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] media: camss: vfe: Decrease priority of of VFE HW version to 'dbg'
Date: Tue, 10 Nov 2026 23:13:34 -0500
Message-ID: <20261111041132.1029567-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111041132.1029567-1-sashal@kernel.org>
References: <20261107060052-failed-5.15-e5d4b0e69a40@kernel.org>
 <20261111041132.1029567-1-sashal@kernel.org>
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

From: Robert Foss <robert.foss@linaro.org>

[ Upstream commit 2fa698e3da84edc6b7a2d670f8bd5035891a744e ]

The HW Version can in no case represent an error, so change the print
priority to 'dbg'.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: e5d4b0e69a40 ("media: qcom: camss: vfe: Fix VFE reset while another line is streaming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss-vfe-170.c | 2 +-
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c | 2 +-
 drivers/media/platform/qcom/camss/camss-vfe-4-8.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 44223c08b87af..9a1f2a6bf3fa7 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -184,7 +184,7 @@ static void vfe_hw_version_read(struct vfe_device *vfe, struct device *dev)
 	u32 rev = (hw_version >> 16) & 0xFFF;
 	u32 step = hw_version & 0xFFFF;
 
-	dev_err(dev, "VFE HW Version = %u.%u.%u\n", gen, rev, step);
+	dev_dbg(dev, "VFE HW Version = %u.%u.%u\n", gen, rev, step);
 }
 
 static inline void vfe_reg_clr(struct vfe_device *vfe, u32 reg, u32 clr_bits)
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
index a596352177583..13f0fa6a7d60c 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -258,7 +258,7 @@ static void vfe_hw_version_read(struct vfe_device *vfe, struct device *dev)
 {
 	u32 hw_version = readl_relaxed(vfe->base + VFE_0_HW_VERSION);
 
-	dev_err(dev, "VFE HW Version = 0x%08x\n", hw_version);
+	dev_dbg(dev, "VFE HW Version = 0x%08x\n", hw_version);
 }
 
 static u16 vfe_get_ub_size(u8 vfe_id)
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
index 998429dbb65cd..03f92a6737b0f 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
@@ -251,7 +251,7 @@ static void vfe_hw_version_read(struct vfe_device *vfe, struct device *dev)
 {
 	u32 hw_version = readl_relaxed(vfe->base + VFE_0_HW_VERSION);
 
-	dev_err(dev, "VFE HW Version = 0x%08x\n", hw_version);
+	dev_dbg(dev, "VFE HW Version = 0x%08x\n", hw_version);
 }
 
 static inline void vfe_reg_clr(struct vfe_device *vfe, u32 reg, u32 clr_bits)
-- 
2.53.0

