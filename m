Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330870;
	b=JaqeV92XWYWuO6PDaEDW3O8L5edttoBa2SOqNXfiCsXCCFmN/DLdixivKufc+ts0SBtM
	 Iml1rOAkahjpzzLrF28Y2VVYwVtSpfwTlMcyMJzeeIXt2w5krbhzwqHkuYaEoFHo59VBJ
	 aivffymf93xBeobQlDvbIi/EBRMdWWXpmN+Engw8aTGkHoJg2SZ3zhqdJdcEnw6mKr3KM
	 oPVMbXWek7OdUXy4FYOkFcvOiRn9+0nCTM3zd+Yx18jx+Mx3XCtQLRnBFYZD2LsSYAqUF
	 0XBTapgkUnnCrMlC4Ly7u2oABMe2T8bH3nkXTHeZ02yDVIDBsWHYqt/mYPdNiD7wzjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330870;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DmJLPbmPgVdctrixntEeI8sHoaTUEIR5Q9306ybYuoU=;
	b=xYV+Dr+lJjEQB49ryrmQ4spHq1f7cq55y+q7sXHN2DNfAPSPG72UufKSdpIaxxT2wWrk
	 aTYL/jeAabV3LaQIg2SkDDccVPaa/GGrDUZDETJ7kIT8g3G4tBq+30nMbcMddi/RzsOE0
	 5jB7QMi6HwLWU5eygKq/wDGLdKFAwpBk+k+fKk+dl2OFwLsaRVuXY1qcmtll8lJIkVt1U
	 vA3pQXDav5WfWYgpakk17BqRjbxepm7VylGB0MWzd3gcwkpZso54q8RYRQgyzbkVYZvz8
	 6OZHbLGiVqdaKUHHbif9ZXLHgt0jXShaHAMJx3ywQ/Cu/EL5BUKYKFXKJtqPQDihzQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGCN+PRz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFEB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGCN+PRz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62C61F0089F;
	Tue, 10 Nov 2026 17:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330870;
	bh=DmJLPbmPgVdctrixntEeI8sHoaTUEIR5Q9306ybYuoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JGCN+PRzM5q7mtrHt7xXlrKSWx5GS26sCM6bGVBAWDUAwLtjbCzHc/lFwdSD3ipGR
	 nuc9Q8yR8lpZ0t2e04nEjydoARSquXAA7fW+AHhrTCYBa0xRrqG2FsVuEY28RlN51r
	 17yhTfVBiuieydI5WqAd5aTjyNYB6xteDkscRGskLm4oI15kjLoJLrZm3ZTsYAhsap
	 JlTuywmv/tRkBJIdtyzjn43tntQO0RK5R2YoqSiE6aZnvTEmZGB+6D2IAngcJKDDVU
	 Ijs2C67Dwykh/T8N9tmCRXWBZ3kbiMJFtsfCMT8Lmt+gf0ophQ9vkLXnbPKvif346t
	 pacipFFiKOt1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fbdev: smscufx: check for fb_deferred_io_init() error
Date: Tue, 10 Nov 2026 12:14:28 -0500
Message-ID: <20261110171409.2486673-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062205-failed-5.10-8ea6c6e77ccf@kernel.org>
References: <20261107062205-failed-5.10-8ea6c6e77ccf@kernel.org>
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

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 8ea6c6e77ccf887f3e68c64f4c261071a345da1e ]

fb_deferred_io_init() allocates deferred I/O state, populating
info->fbdefio_state, or leaving it NULL if an error occurs.

Currently ufx_ops_open() ignores its return value.

Therefore if an error arises in fb_deferred_io_init() (for instance, due to
an allocation failure) info->fbdefio_state is left NULL.

fb_open() will then dereference a NULL pointer (calling
fb_deferred_io_open()) as soon as ufx_ops_open() returns.

Additionally, if the allocation of info->fbdefio itself fails,
ufx_ops_open() sets info->fbdefio to NULL and invokes
fb_deferred_io_init() regardless, hitting BUG_ON(!fbdefio).

Fix this by only invoking fb_deferred_io_init() if the allocation
succeeded, and checking for the error.

The driver already supports operating without deferred I/O, so in either
case fall back to that by setting info->fbdefio to NULL.

The ignored return value was introduced in commit 56c134f7f1b5 ("fbdev:
Track deferred-I/O pages in pageref struct").

However, the BUG_ON() issue originates from the earlier
commit 3c8a63e22a08 ("Add support for SMSC UFX6000/7000 USB display
adapters"), so target that for the fix.

Fixes: 3c8a63e22a08 ("Add support for SMSC UFX6000/7000 USB display adapters")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Helge Deller <deller@gmx.de>
[ sashal: Omitted the fb_deferred_io_init() return-value check because the function returns void. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/smscufx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 08a4ce3dfb1d8..6d9121570f343 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1096,10 +1096,10 @@ static int ufx_ops_open(struct fb_info *info, int user)
 		if (fbdefio) {
 			fbdefio->delay = UFX_DEFIO_WRITE_DELAY;
 			fbdefio->deferred_io = ufx_dpy_deferred_io;
-		}
 
-		info->fbdefio = fbdefio;
-		fb_deferred_io_init(info);
+			info->fbdefio = fbdefio;
+			fb_deferred_io_init(info);
+		}
 	}
 
 	pr_debug("open /dev/fb%d user=%d fb_info=%p count=%d",
-- 
2.53.0

