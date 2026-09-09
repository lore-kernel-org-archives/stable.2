Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE33B895D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981459; cv=none; b=BBVhugvpPc1SjXCQCEpzzLquClg6onWS7/fJVESp4zzoBHDKiNt9ngnzxXEFrsERN6MOxcES1kGET3uhf5ZO3zpNSjpnUp2wzkygaPqiYa6QGRVc7Mw3jsuxkc+VgGZDdezHmhM2fwx/1y1bSml3lQbFqPinIFQfARhbWxCVTR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981459; c=relaxed/simple;
	bh=lWtZW9B64jITIrIEBwKcj02m/YKU3hTT28o3FXTJ248=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlFjyucrtMIfmW+oqIJ2vb0VnQmO3l4PHiBKAShCAlwQcIs44t7b2PTIMteos+lt2FFuky+3+GFuNPFJGgozbVtJW1ymjsvMCe2LceSvfPlHXssWtWP+Ek7zaAZ94j8XurEX3q99T3ZRimlkJTR9fF3dGEsJTqndbu8GApLHYW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SabstMEA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SabstMEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A268A1F00898;
	Wed,  9 Sep 2026 19:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788981457;
	bh=z73KKqtNdsm0CxB/s5N9+4ogA9mU4Zg9yzX8B604+GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SabstMEAgUtvn99R1gUKmiZEqHnJV8nfkKKjcCLJ4gLozlpQqpRwHL9oDJ1Z9sOiR
	 ohgkuez7mtn5RgmZFIUQJRrtpJAZ+7aXujbveSeOElS9pvKDDQqyQKnG3mAsevFpA5
	 +3LLKfk7VqLx1PTg3fcMrr3RL6RiNPEncUvJ81Y25xJVvnG0Q2qgmwlmLd5m1/ofqW
	 GATAWcXYYIpGgXPja3Dp3W1Ne7ZvnIDfxIlbxwzWU4mTH6mJBF0PFPgiRvju6Dg6Ut
	 HgWGl/wRIzgd9YGbIdvlhbfe5DaU72MNCwa4qwpRBzI/qLwVTZ3S2lkPSTD4pvhIU3
	 N3yPUYFHoKQpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] ALSA: hda/ext: preserve PPLCCTL bits when clearing reset
Date: Wed,  9 Sep 2026 15:17:32 -0400
Message-ID: <20260909191732.3557673-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909191732.3557673-1-sashal@kernel.org>
References: <2026090345-hangnail-getup-f661@gregkh>
 <20260909191732.3557673-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Rao <raoxu@uniontech.com>

[ Upstream commit 36aa66de481d29edd63cbad9b5c4dc18c340fdf6 ]

snd_hdac_ext_stream_reset() polls PPLCCTL for STRST by masking the
register value with AZX_PPLCCTL_STRST:

	val = readl(...) & AZX_PPLCCTL_STRST;

The same masked value is then used when clearing STRST. Since val
contains no bits other than STRST, clearing STRST from it always
produces zero. The subsequent writel() therefore writes zero to the
entire PPLCCTL register instead of clearing only the reset bit.

PPLCCTL contains other stream control fields, including the stream tag
in AZX_PPLCCTL_STRM_MASK. Those fields must not be modified as a side
effect of clearing stream reset.

Use snd_hdac_updatel() to clear STRST, matching the existing set-reset
path and preserving all unrelated PPLCCTL bits.

Fixes: df203a4e46f4 ("ALSA: hdac_ext: add extended stream capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Link: https://patch.msgid.link/43BB7930B0F07C09+20260813065524.1955696-1-raoxu@uniontech.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/ext/hdac_ext_stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index d2b5724b463ff..ae9228d52da0e 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -183,8 +183,8 @@ void snd_hdac_ext_link_stream_reset(struct hdac_ext_stream *hext_stream)
 			break;
 		udelay(3);
 	} while (--timeout);
-	val &= ~AZX_PPLCCTL_STRST;
-	writel(val, hext_stream->pplc_addr + AZX_REG_PPLCCTL);
+	snd_hdac_updatel(hext_stream->pplc_addr, AZX_REG_PPLCCTL,
+			 AZX_PPLCCTL_STRST, 0);
 	udelay(3);
 
 	timeout = 50;
-- 
2.53.0

