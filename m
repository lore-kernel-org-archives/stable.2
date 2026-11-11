Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407931;
	b=K3DadDgy+i/jkpgWK4FdWBAGve9uC6Rr34RDp3tTcdo4PU4jenakXknRCp3UL3YujTwO
	 0NerFLQXBX0I+HfOoPc6EvlM0Wu2tKhxP08P+KMzeqsogKfNlFpznuMh2JfpbeMsL8Wj+
	 ae5em4uPfbGOFzAA3/FVXCVBDhC5SEMRmzKH9cvzUQykA2PbeFgbdYK0V0mFJULcyg1We
	 lfabU7brIAttxoBINwrZsqqULmcpiOjfgGFiBYv9aOzfYgWjJIgfSkCxAxNQtz9Y8Q9q4
	 xA0jgnV4N9k7Om+61Vt/F1NUFrzyhO6a1RRXGLMmoNUtlVfYXGx2SZEU7xIiPEqpZfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407931;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rYa6Vj482aOsAT1swBjVHBxJ66Ekod+nCxHVhlJVP6o=;
	b=ItxKRJOf2bp8JJ8zqjxQZWOZ35eTrEahJreqVXcWyZtpguUT8xVeWZDCgLCHxeaw9s9w
	 HjKtt/9pbp7Iy8sUs5gQ0c5MSP+FDE7bA858BS+X5EbX+dDZyJI6+yoPGNx7VOS+PAfov
	 Ec9HJ3ZpzVE5FotagEoKF4A50D7NavPJPQ0HQZ51uoXE7+PuaLW84HsJxhB2gld/F5QwL
	 onQvXZpOPkbuRm9lhmyc7uDEt3MF6on+mqR1XbcwUbygp9MzriV6N/F7pGNYHIZlmmSqc
	 DwyEeGY3NlIYjxl1N95FfRYyoIVPsNatpysvuwwN/d2evba6QbvbUy9nQR8EAXXSGTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBGjlNHt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BFA606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBGjlNHt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908701F00A05;
	Wed, 11 Nov 2026 14:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407931;
	bh=rYa6Vj482aOsAT1swBjVHBxJ66Ekod+nCxHVhlJVP6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oBGjlNHtijskBTBq2sraVdZwvWLaFnVZhIKwiJk6wvwbXfrPUdjlq8AcYqPlxpZzv
	 stbj2WftmNHQd/nxGGC3KlCJ2E7GfoDFP/oFAAEBtcwRN4Q95pPSDp4iTjcWtpH/+a
	 idllULOiDWUJn+Zud9OAy0/H3W9cN0JdA0wgUHLdKKkMyxkUk7f/hYEPJ0ajlONsmb
	 73oLH5cnZowE9Hs0pdj/IzWkLQyVZ0z38Fvjmgw2iMtGqvPudj50xVViLUfbrYMqg0
	 c+n2YpG86I0NUnunnjvaJi0y94Uf+wcGG/lvyjeC42wPK4ItQtN6he3r5bxNuDFgCA
	 CuawLGQUFeECg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fbdev: udlfb: check for fb_deferred_io_init() error
Date: Wed, 11 Nov 2026 09:38:49 -0500
Message-ID: <20261111143826.2357715-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062159-failed-5.10-eae055f33e41@kernel.org>
References: <20261107062159-failed-5.10-eae055f33e41@kernel.org>
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

[ Upstream commit eae055f33e41e1d3e1a7e905bdcb1e9f196ed31d ]

fb_deferred_io_init() allocates deferred I/O state, populating
info->fbdefio_state, or leaving it NULL if an error occurs.

Currently dlfb_ops_open() ignores its return value.

Therefore if an error arises in fb_deferred_io_init() (for instance, due to
an allocation failure) info->fbdefio_state is left NULL.

fb_open() will then dereference a NULL pointer (calling
fb_deferred_io_open()) as soon as dlfb_ops_open() returns.

Additionally, if the allocation of info->fbdefio itself fails,
dlfb_ops_open() sets info->fbdefio to NULL and invokes
fb_deferred_io_init() regardless, hitting BUG_ON(!fbdefio).

Fix this by only invoking fb_deferred_io_init() if the allocation
succeeded, and checking for the error.

The driver already supports operating without deferred I/O, so in either
case fall back to that by setting info->fbdefio to NULL.

The ignored return value was introduced in commit 56c134f7f1b5 ("fbdev:
Track deferred-I/O pages in pageref struct").

However, the BUG_ON() issue originates from the earlier
commit 5bea1fbf9423 ("staging: udlfb: fix incorrect fb_defio
implementation for multiple framebuffers"), so target that for the fix.

Fixes: 5bea1fbf9423 ("staging: udlfb: fix incorrect fb_defio implementation for multiple framebuffers")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Helge Deller <deller@gmx.de>
[ sashal: Omitted fb_deferred_io_init() error handling because the older API returns void and cannot fail. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/udlfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 23097d190e0b1..d3e7c8f6ae7eb 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1006,10 +1006,10 @@ static int dlfb_ops_open(struct fb_info *info, int user)
 		if (fbdefio) {
 			fbdefio->delay = DL_DEFIO_WRITE_DELAY;
 			fbdefio->deferred_io = dlfb_dpy_deferred_io;
-		}
 
-		info->fbdefio = fbdefio;
-		fb_deferred_io_init(info);
+			info->fbdefio = fbdefio;
+			fb_deferred_io_init(info);
+		}
 	}
 
 	dev_dbg(info->dev, "open, user=%d fb_info=%p count=%d\n",
-- 
2.53.0

