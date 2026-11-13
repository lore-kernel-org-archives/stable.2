Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794559327;
	b=Ck/rffDUKWRvwwQoXDwl5qjc4bqdTufTMy8pLSxGu9e0i8h8Cly+XiKmG/ACeoiZ7Lym
	 uuFS6vMNXeFEBdZbLhRWaGSaqdhtusCgoZpZkCITlE25ZrND8iR3XNfea0QaO7FkTgAgp
	 Nq9A5MvOdPraBgwTkNyBTZnG3R3CsaMbdMafSf5Mn85cG8PZY/RHtVOhlsOTajgFEn15R
	 AvyffoobmNAE2UODsonzHLxDg6cm93ZppFUIXtrlBFncLkHVxyNJAmDbXf+IhweJXu3on
	 FYutG0zMPMnbMilwKzqUFI09WqIdp+1ZKwtKio00FUGdNA8oMrulHEm/woTXpvcQaLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559327;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=3L+zxWNfGQ3ohdk9s8cAjHw2DOnWTnCAudFmGfLCLoY=;
	b=QiEXVUI99k2Ggai28AucK12qhK5JYOhjEoFNnVz12Lk1VrN6uewu28hvhOcKtu4ycV4f
	 BQfIGCImVK+6P/9HyuVFxCyEWwjZ0fLz8i6SDqjgIXI1r8sc5G76AhdbEtWhzaML8BY5x
	 ZeoVkGQ73OUwsgdnyZkEZ+i8f8tk0q0bun7QfrqAngaFGFxDGcwnMzKr6rzp5u1jX0Ac+
	 /hP4wbhqhVs+t3Fqddl/HSdWp+dNlNsppv61Tpw4wSovjZ0qR1u/U6laQJdZEQ6JLtL1o
	 igwG3ukI3PKd+4comkva328WYOps0Vfxe+xS4ljQfpRDtGH9MMLSDfxJ0CH+WG8O0Gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niV7EMUU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8580606A327;
	Fri, 13 Nov 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niV7EMUU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794559326;
	b=i6Kx9sDoU0LC3Y8npzh9GTYbaPTLR9sYZj+P1oy8ljcVHmKpeg15wGO5OEgEDB0L6vk1
	 FNvQdL3sEchSYfgN0tWR6kCq6ILeSKOxIZ8Fv0ZfGUvRTxnIDeecrvrMuNwhlojoOXUvc
	 ce90a6U22JWoJbWCfGKyFveZmhLiMaX4D4VFLp20VMlKdrt135oRtTTbMamYMgA65V8T/
	 hN+Kc9aOYF0jXGELKY2abq6iDF+1Ow/ODq8kdRaz5MnMvIZFfsv/Lbb6Rn7DHr4Y5IUk0
	 kKX8Q+IOtvUWSfXP9HZKSaPRs1OyUMbs9At4T2wg5yMXdcPJ5CR6lGvG8SatIg/tZfQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794559326;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=3L+zxWNfGQ3ohdk9s8cAjHw2DOnWTnCAudFmGfLCLoY=;
	b=bmA7UMx13HIqNkEgRB2WsjXf3kWU3Bz2LYHizdafaRI1+rl0MxwPJvv7Wv46XgHCthz2
	 MuhBt8P6edXH71e97N+qHCHyK1TVAQpc+GERb5OA5Vhpvp54UiPK0Joxv5+J2wBRz01AE
	 qemy/xWC7AQ9a7Hzh6TfJzRJriReKhz4BLjt0AaVCbLeQhPuZatr2cvu6ahe8OLuyJfwe
	 tbXHXdCoPIbvw7VWXyT3xOhDAq5x1PnyKV9hYFT9ioYewcmWP0qZxlF4qXiNtnYmUTEq1
	 MHipZPF3hHbqcnfqxG/jmRyz4pZbPKSl8FKVoL0bKYSBfhgUzL7oX49C8DU0+MPEfTg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 15AB11F000C4;
	Fri, 13 Nov 2026 08:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794559326;
	bh=3L+zxWNfGQ3ohdk9s8cAjHw2DOnWTnCAudFmGfLCLoY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=niV7EMUUwD9rnkdZShoxVFOU5gOifKnzPezcP9pZl7DtSS8E3QXURbvbz9sxB8T0M
	 0XWZcQtTbaRiN7wJ9in9uBHQ1w4dHnh66XT8ob4SjhRajBXjNXD9kqfqch7f23BSWR
	 XrpXKWt5ZMTB3mAIWB8G/ASr+yEDqR7lEBA8XkO+RTvOVtsjryRVtJoCndkde8t4HO
	 r4RdcMr28Rt4ylNkBJo6nJOvau9AUOo3u6Ue0h2Op5gg5fzsOMgTO0dtVCx03Rgsrp
	 eFuQax5agcp4mX0I4JNa4T65J1ZTai/WcQI8TzYjXApURYslIUvaxmUlD+LzFpgWGx
	 UTs4bjX5WKV8w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9CC94476B2;
	Fri, 13 Nov 2026 08:42:05 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v3 0/3] pmdomain: rockchip: fix the probe error and
 deferral paths
Date: Fri, 13 Nov 2026 08:42:04 +0000
Message-Id: <20261113-pmdomain-rockchip-v3-0-b7039ca30b87@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32PyU7EMBBEfyXyGSOv7SQn/gNx8NYTA1lwMhFoN
 P9OZ+YyB8SlpZKqX1Vd2JprySvrmwureS9rmScS+qlhcfDTKfOSSDMlFEgpBV/GNI++TLzO8SM
 OZeHadM6r7DChZfS31Izl+8Z8fbvr9Rzec9wO0OEYyrrN9ecWusvD9x9/l1xwCB16yMH7Fl5OZ
 Ph8jvPIDv6uHgnqL4Iigo2pM8orndA9Eq73ijV/nWn9du/NFr/Fgbb3TVQoos0BwEqKd8YggDY
 qBbqt9QCtxeDkMSz4NXOijmXrG2eczb4NtgUJQesojMfQOYgokEipSwk0Bqpw/QVhMQgXiAEAA
 A==
X-Change-ID: 20261110-pmdomain-rockchip-3497a2e7fdf5
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yao Zi <me@ziyao.cc>, Igor Pecovnik <igor@armbian.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794559325; l=2265;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=k1mLNrWfIj7RN8Bh3VsWtx7wapkXv0tU4C3AAvkt4b0=;
 b=Mi0cR6vTMB643sMCpH7Z5f77UEcQyS32zt8DJ8ItoWOMCFw+PtT9juZ6YpgxIR2PZkr0XOrLe
 ZW3cw1yl2tyBacelDOkpFGjTreD09rBGEAKPATbJqP1ns6LkCCxxjAA
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

Fixes for a Rockchip power domain controller probe that fails or defers,
for example on a domain clock that is not available yet. They apply on
top of 1/2 of Yao Zi's series [1], which has to go in first; patch 2
replaces 2/2 of [1]. On the pmdomain next branch, 1/2 of [1] conflicts
with "cycle an optional power-domain reset on power-on" in one line.

Tested with v1 on an Orange Pi 5 (RK3588S), v7.3 based kernel, with a
test device tree that makes the PD_FEC clock appear late: no freed
domain left on gpd_list, no -517 errors, and the controller binds later
with all 26 domains. The v2/v3 changes are build-tested only.

[1] https://lore.kernel.org/r/20261105001257.1368266-1-me@ziyao.cc

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Changes in v3:
- Split 2/2 into the fix (2/3: deferral, pm_qos error code, callers'
  messages) and a clean-up of the other messages without Fixes tags
  (3/3) (Yao Zi)
- Shorter commit messages and comments (Heiko Stuebner)
- No code change from v2 apart from the comments in 1/3
- Link to v2: https://patch.msgid.link/20261112-pmdomain-rockchip-v2-0-5cd942a23df7@gmail.com

Changes in v2:
- Dropped "pmdomain: rockchip: put only the clocks that were got on
  error" for 1/2 of [1], which fixes the same bug
- 2/2: drop the callers' messages and use dev_err_probe() where the
  errors happen (Sebastian Reichel)
- 2/2: a pm_qos syscon error keeps its own code
- Link to v1: https://patch.msgid.link/20261110-pmdomain-rockchip-v1-0-6b9fa6ebaa86@gmail.com

---
Arun Iyengar (3):
      pmdomain: rockchip: remove subdomain links before the domains on error
      pmdomain: rockchip: don't report probe deferral as an error
      pmdomain: rockchip: use dev_err_probe() for the other probe errors

 drivers/pmdomain/rockchip/pm-domains.c | 131 +++++++++++++++++++--------------
 1 file changed, 76 insertions(+), 55 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261110-pmdomain-rockchip-3497a2e7fdf5
prerequisite-patch-id: c2f0c5eb6651baa744f66342db63485a6685fb71

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


