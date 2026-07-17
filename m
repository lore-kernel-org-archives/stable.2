Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51403D9680;
	Fri, 17 Jul 2026 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271811; cv=none; b=WCsn3k23CeFmQJQ15LxwT1z34aTHzYEePknWZQooO9bLFuwXfsuDbPGT3nB4LCk6ahAKONmMrMffsTih9wTleYconQ/UwnWNo5Uxab54MxPQFe8iKiVJlVHcC+Oll0BUeAw7ne8qVWLRguHbzRS7hJz1/qLk9KkhwyBglWZrNFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271811; c=relaxed/simple;
	bh=NSSUxwzhrRLl3VF5ls8OlgOT8CTVjHMmbbRYoGURK7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GsyKNcaYG4owHHSTgfQFJ73xnxifGNgkn8fuPIy1LhO2VjrHrakYA7zMctAkeNV+LtcwznxfOcRt7xFNZOULEdbk4yaidhvWeHie3+88OiP2emwHaq2TTKbDNqXv37L6QqAU6sTRsHiaf5b34LkpdpkRe4kC62uVUZNL57HPk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kL5u+YGZ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kL5u+YGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KL
	/edl9gcb3Wz3X1+gE3BYShTOewWw5tQb8iVKTTITg=; b=kL5u+YGZ9HmK0smIe5
	aBCdiLM0F8u180NMS9+sc+0iZN5MzDlzaL6gMmyZLyuHjogXKncrhOajZR8CLv5J
	WDB50vSVtJsuIyRqdjKzYmysjxq0m+kP5RVgSUCBPjeUTBv8iI0q8aVf5tgDr+Uw
	1Rnv2zb8qLyXrHNS8VqHVMVto=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA3tYmk01lq70RfKQ--.38418S6;
	Fri, 17 Jul 2026 15:03:12 +0800 (CST)
From: wangdich9700@163.com
To: tiwai@suse.de,
	wangdich9700@163.com,
	broonie@kernel.org
Cc: wangdicheng@kylinos.cn,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/4] ASoC: tlv320aic32x4: Use div64_ul for division by unsigned long
Date: Fri, 17 Jul 2026 15:02:52 +0800
Message-Id: <20260717070252.525545-5-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260717070252.525545-1-wangdich9700@163.com>
References: <20260717070252.525545-1-wangdich9700@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3tYmk01lq70RfKQ--.38418S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF18urW7ArWUXr4fAFWkZwb_yoW8JFW3pr
	nxCrZ5GFWrW3W5Crn2v3W7XFn7uayUCa1xWF1Yk34UXrnxAFn8XFyIqF18ZFZFya4ruw4a
	9ryav34UGry5Kw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziY0PDUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbCvxASYWpZ07BJYQAA3k

From: wangdicheng <wangdicheng@kylinos.cn>

Fix a compiler warning about do_div() truncating an unsigned long divisor:

sound/soc/codecs/tlv320aic32x4-clk.c:169:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead.

do_div() truncates the divisor to 32 bits, but parent_rate is unsigned
long which is 64-bit on 64-bit platforms. Use div64_ul() to correctly
handle the unsigned long divisor across all architectures.

Fixes: 514b044cba66 ("ASoC: tlv320aic32x4: Model PLL in CCF")
Cc: <stable@vger.kernel.org>
Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index 5c0a76a4a106..9359492051ad 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -166,7 +166,7 @@ static int clk_aic32x4_pll_calc_muldiv(struct clk_aic32x4_pll_muldiv *settings,
 	 * math in the kernel.
 	 */
 	multiplier = (u64) rate * settings->p * 10000;
-	do_div(multiplier, parent_rate);
+	multiplier = div64_ul(multiplier, parent_rate);
 
 	/*
 	 * J can't be over 64, so R can scale this.
-- 
2.25.1

