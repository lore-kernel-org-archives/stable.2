Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454537;
	b=Fz0iG932w6XqPYYBSW3r75ZqkvnbvZd0xM1g26ySqFUueL3TAg770ICzD6UEeG5dAO7e
	 B/bxrkNTw2GUT1ZybL6bTkyUesWdX9TINtauc4a9whONKyuw7NoZP87toTZtPDas0TARH
	 ezpLUKe0bujC60km0EyJ7Xkc9YqsbN5OJIB8GVvKCqjuduz19dZhKbShr3nCjdaLsd/AZ
	 LbDh2l0fqIzQCalVwVBzFm/BX5ILEr+F+yl8KfRQmRC8+EVmlL+df/K2tszwwvpwJKqEw
	 LusOSbcqdxjuUluVdTtKozfbQLkUsb/rYX9DluU+XwXTNezTORcOTCBxwQ4Mpl11Xyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454537;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mh5Ls7OvyoLZxYGKv/3EfAzY7K+9ITf/EjWVOJ3pC/g=;
	b=qy8arh7lQpVWTnKJKSn3jsOXi1bajemWc+gTdJHJyX2X91tOzztAZ9AJwOFFg9ixkt+9
	 MlmYq5Se9wBbPRLirLnoelxXttpulYYoms0BUZ6iFLS+kAn0+YUYYtaxN7SPt0oNNZk+T
	 Zxemr0sYLyqLG5Fal9PengZpkWpE+IUWvpJ8Ztdhl6KS1FpdQBXt+H1/yXgUQd2an2QiY
	 m14BCxHVWP/lK/LQfzin0d7mWgH66F66eFEQ74onm5pa+jSPjpKLktu6inaxkK6i9SS34
	 7QrmGC4idNc4GxvfSts91TUwrpjUVJptJKB9uilaeP0ihc7jXuNunXjbTz20vLxMsNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIX2k0aM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05DB606A31A;
	Mon, 23 Nov 2026 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIX2k0aM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79651F000CA;
	Mon, 23 Nov 2026 17:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454537;
	bh=mh5Ls7OvyoLZxYGKv/3EfAzY7K+9ITf/EjWVOJ3pC/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AIX2k0aMy0JYFMKuti0O+6TGo+gWuAgBMe+yVfbSQZjq7FBmnTFkkXZCQtgislJi/
	 uI0OdR6SWV2Q+NkIIjGa211uwVLYvtlyHJrGvRvcG74uaCx7cZIiiOhpSeUYNgpg5L
	 zbqKQfxuVgsaTksUvIXh0uAvuxOkrOLtbqBjetgyhy3ag5uYpNjBiKE9VVjrhqOn28
	 dukBoA3CAYNvXP6ePxzCkh51lAM56rgg0XBi8ePVsx4Y2b2Enrd31Q9q34IfUs5Loa
	 1ggaJvMenX+Bnqx0AIkMac5+rSlQ4DD6Xesv78eEY4+5mSRG7SNh6prCSvww6T6J2c
	 Wt5GVXfdtyfDw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	HyeongJun An <sammiee5311@gmail.com>,
	Ohad Ben-Cohen <ohad@wizery.com>,
	Brian Swetland <swetland@google.com>,
	Mark Grosen <mgrosen@ti.com>,
	Guzman Lugo <fernando.lugo@ti.com>,
	Suman Anna <s-anna@ti.com>,
	Robert Tivy <rtivy@ti.com>,
	De Leon <x0095078@ti.com>,
	=?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>,
	Clement Leger <cleger@kalray.eu>,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/10] remoteproc: elf_loader: Fix overflow in rproc_elf_load_segments()
Date: Mon, 23 Nov 2026 17:20:48 +0000
Message-ID: <20261123172140.3547896-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261123172140.3547896-1-lee@kernel.org>
References: <20261123172140.3547896-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For 64-bit ELF firmware images, rproc_elf_load_segments() reads 64-bit
p_offset and p_filesz fields and checks offset + filesz > fw->size.  A
malformed segment header where offset + filesz wraps around 64 bits
bypasses this truncation check, causing the subsequent segment copy
from elf_data + offset to read out of bounds outside the firmware
buffer.

Replace the addition with an overflow-safe subtraction check and log
offset and filesz individually when rejecting a truncated image.

Fixes: f31e339f1b9b ("remoteproc: Add elf64 support in elf loader")
Closes: https://sashiko.dev/#/bug/linux-754a0c40-c150-42df-9c0d-bbb2c3846fa7
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index da3cddbe7d4c..6b9de0627768 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -213,9 +213,9 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 			break;
 		}
 
-		if (offset + filesz > fw->size) {
-			dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
-				offset + filesz, fw->size);
+		if (offset > fw->size || filesz > fw->size - offset) {
+			dev_err(dev, "truncated fw: offset 0x%llx filesz 0x%llx avail 0x%zx\n",
+				offset, filesz, fw->size);
 			ret = -EINVAL;
 			break;
 		}
-- 
2.56.1.750.gf70dc682cf-goog

