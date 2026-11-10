Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332503;
	b=fHAiOlvimrD/Zs0KfabLZrDP4HCksiMQa7aRAIr9wtst0kWKClaqsL9gERBlV2xuevMQ
	 8p2fm4zt7BWsc8ROzjCy60mxAMqj7dISiajzOyZy8bmME/agh/eavy6OUhrq+WH39Pf4X
	 2epY3oiFFxNuGBND7ZHfpZY+5KPkfTNiaie8UVXVOnN5FhiiwUwiHZ1x6DulksRqCaw3d
	 grf7gP5nHTLxbJ1vaAk6vr3JRbB4Oo+LmVu8O0hcnPLMv7Alacv6vYZVhNO9KDjnAJ8Qv
	 VuSGlUrTzKoeivmjfeE9AfRGVV95KrjwBohv2U0QcHoBb1jT28oXKGxxJOSo2N9Ui4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332503;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bRWZmxjr0zazk5wBl0q7PdPxRGbQQw7zxmMbuZxcjU0=;
	b=SBzamLvTHEyktYAdIaJWTzgSb8b5Tqwbv4cPtpwZXDU9VS8ZUkugqDPH2MKffesd7EI5
	 W1esSPAA3eDLInwZlsyX4fZD6/SEHdYspIPC3Wb5ymqPpWv2K3syJoW3m61SdsNSSSP+9
	 R/MkSepZT+jZlaRqGbQzM+wo4YMIwVfFC5aFJO4SsDTVH77R5oNP/ApYIh7srrttTuIIM
	 cF7LpbPFGCydXHF/zdPwaBO/sxiZtkNO+COA8c31r4qxsgKQdZsLsR7fd8bJnVU2peZgB
	 3wZZI1SNS87ZWCtWVaJVsBfLImMm5hmfl5Te/+EvS0mP7B6bpDjqNY9HqhAqQQWkvOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j6kVLy/E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404FA606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6kVLy/E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3101F0089F;
	Tue, 10 Nov 2026 17:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332502;
	bh=bRWZmxjr0zazk5wBl0q7PdPxRGbQQw7zxmMbuZxcjU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j6kVLy/EocCvtUIg0Ej/Yqyuux78BOq/LrGX8Zp9Aq5vxPgVuB+ZLeNH/AoQjfAHK
	 Kl2iKvZ7rktDo5fFMHThMfAn/QRcXC2+T84i9wz3lxh3a/7yyyDjCG1G2bdEzUdA14
	 EzKu0rCm42ZV/+RG9f2Z6H01lay0hRfVMVOeUV+yAkwfWzoDGljvd/F/7W8mIpgK4V
	 I2/bTTcThse6hqHD59cqYQkct/HnLBqejyFgjOSmIIJfSlQCMS+bhzD22Jf8x8kDuD
	 wj/7omWQdHdyAHNCH+A3nNnOTlZHNUiRwxurR869yj0vGfFFBRR5zL3F1S/7MP+86W
	 WebIOEPg63cQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fbdev: nvidia: Release write-combining handle on probe failure
Date: Tue, 10 Nov 2026 12:41:40 -0500
Message-ID: <20261110174053.2990206-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053415-failed-6.6-8710af6a3520@kernel.org>
References: <20261107053415-failed-6.6-8710af6a3520@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 8710af6a35201a6d01b5af8f7e4bad29cc40467f ]

Failures in nvidia_set_fbinfo() or register_framebuffer() leave the handle
from arch_phys_wc_add() allocated. Release it in the shared error path,
as nvidiafb_remove() already does on normal removal.

The missing cleanup was already present in the initial Git import,
when the driver used mtrr_add() directly.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
[ sashal: Retained explicit iounmap() cleanup because the managed-mapping conversion is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index 674baba74cf06..bc0abc3c04bbd 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1417,6 +1417,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
+	arch_phys_wc_del(par->wc_cookie);
 	iounmap(info->screen_base);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
-- 
2.53.0

