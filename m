Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331581;
	b=ALXyJK+Payfmbvnvt9ceseP2QmO+3RM3oHPRHx6q0JT0ViGFby2JfDOkQLa7ziSPEjI9
	 H+Kiw7NOeVwAEhRbThYFFd2HmVKlB08U9gR6vJi377ZfUr3VJ2ltL0SoQwaeZNF8wE6kt
	 3KTDIkG9ojuYAP+cruYkmpvrawRNn0TKFAZMn4dix/4y2VXIHShNVVMkCvabPko3Ly64Z
	 uy/v8oFmc1kKIBI6EvqiEkjTFp12GJLpAeHLkeqERLAdzHB0qKPBamS9PXxpdE4tnMXW/
	 ZeajDr3CwwTsc8P6z3vMcmRTkv6M0R6xWmi+gUsQnfmF602vOXRMUaZZTSm/H1/FGiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331581;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3VfARO/VAt4qzpOrjxOp61rRd34J1Ttt+i/7ZcWStYU=;
	b=avVKy0mg6nkl5OGxf4OalMLGt/XLEzl69F04RwJwkuEiEQBLOHcBsIxhsL1Pc+YX/fuh
	 Hkf8Z44T6zFhBD/r4XFt5D2zPTpg1ffOd8HTTxtt16TbR4bu9Xta2OiuEeAy9/yDsNQ+n
	 DlrMcyfukTh0/tiODSlHsWesK2xUPfgZwUADP5CvZGwqRN3HDwoGHu5EvJFHxul42q6zp
	 TuP1RW9IQSAGBJZYzjS9MZX1BK0U65L8iZOy4euyCEjiWkP9P6D+fxMAsPW3s8JUU4MrH
	 fUagl8TeFanooIt+A5KNpDM8wnAuWKjY5GnUmHFSoOM8Ppp5Ak+HVJaTbT9WDy0+Xag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eS4K0/ky";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB7606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eS4K0/ky
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295C21F008A1;
	Tue, 10 Nov 2026 17:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331580;
	bh=3VfARO/VAt4qzpOrjxOp61rRd34J1Ttt+i/7ZcWStYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eS4K0/kyThFjjGcngFDkhP6EFTDqZS2Dd+2LK60RYIe4t0hkxSDbCP+G9bolYGF1k
	 qMV1Cr9AKB3L2jxx/VsxrdVF/B3Az68qz0QLSvH6gwDNcv7UCBUE1WA/11nPiopIQN
	 jWS/RIoBRTBdAnuLi0AW6uAiu4U+wzHiELk/iS9sH3qB+CPGzaPrrobROWYJIfwVqs
	 HMUDj7QdWk+TvO+vyZldKB42bnqndUBoXlc2+7ZbtI3Fa7jOthU0wvpafKdIUvi8te
	 QwLS8BL8VQNxwLVnztDnChTjxCwuqmLcsvNZrxJ6kVGPKmdDq8Ja1/5RItlOn7plgZ
	 +HZZQgmoMx4IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] fbdev: nvidia: Release write-combining handle on probe failure
Date: Tue, 10 Nov 2026 12:26:17 -0500
Message-ID: <20261110172609.2854755-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110172609.2854755-1-sashal@kernel.org>
References: <20261107051049-failed-6.18-8710af6a3520@kernel.org>
 <20261110172609.2854755-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index f917d569bdbd5..aebb81f9ac585 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1420,6 +1420,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
+	arch_phys_wc_del(par->wc_cookie);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
-- 
2.53.0

