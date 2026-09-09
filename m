Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE69560AD6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980276; cv=none; b=Gk/ABJkAWRv4H/5w71BJPikUvndRxvfKF0ijUARz01eHCIsNIPYGjK66KdjE/6+zqNe9EfMZvsizK/nyWivIER0+pryNt579NnTxQeVrXYiylOpwlR1OE+KCxQ6lYl1X1Wg5mr4JpO3823K6LlyRtpPqYI75mIKuq73cQkFi4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980276; c=relaxed/simple;
	bh=9RHtv1ax3eKT49oRE0jiQGuumjc5IdPnqXnj+u0QUIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=has2qysAoy7gwtpsE9PkB22N9hP0mcYVSUBFijJ8A6v967u/1RpAw4SB7ulo6+4hqp5rhKD3ABE3t1PWtToMx9CL4zqTQsNVNww/XMeUSC90VyNlvIW5N/3vhhmodTocl3eop7B43gBW48QxKmEF8V5GLU9WXf9n7kLfYyMVNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3gTuZAZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3gTuZAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFB71F00893;
	Wed,  9 Sep 2026 18:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980275;
	bh=Ioj81DK08Z444rtbPlNG6c1Q6gyb7tmkyUa/bH8wmc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W3gTuZAZ+8gSsoxQDnBCxFa8DLLMyL33w4Zd7AZONU4baEg0TuX5afNsSeohInech
	 gSlBkal//HnT/fuz4DP4iFVU2mSgXX0yaQovMNHmAunl/9diyQf70crBs71lbtI85q
	 8lewjXYsuKgTESyI2bUvu8wDmWe9FD1nUy6c0kRU+1ywWrbWkCzH6hDaaE9wiKL8Ol
	 SSa4woxLLilWIpxZHxP7X2fAqEc6yhn89/YJIPIpooJp+35NvHAWMukT+t5qAnuVcp
	 OFEeMawAwOuGjk84MtNFWS3eiHlRA9fOl086oTZW+owpCDA8WVcIYLfA/z3ryW6uKq
	 HyYLQRaOjf+uA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: hda/ext: preserve PPLCCTL bits when clearing reset
Date: Wed,  9 Sep 2026 14:57:52 -0400
Message-ID: <20260909185752.3499534-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090344-passenger-submersed-9dfe@gregkh>
References: <2026090344-passenger-submersed-9dfe@gregkh>
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
index 70f3ad71aaf0d..4681d25a38448 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -182,8 +182,8 @@ void snd_hdac_ext_link_stream_reset(struct hdac_ext_stream *hext_stream)
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

