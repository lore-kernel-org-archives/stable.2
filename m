Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55A38398F
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789225731; cv=none; b=eKt69p0z+GuvU71pvnqGSUgsSrnLRZOi8VQaGXfQulBmwiMKHkhMve9yiZprW6cIqlWPTL/17mIaDvU9nN4CLl3kC8eoQlTojogqLyIGInkdKBwfM4XSgZHrV9mrBavj1UA4qtecrKcJCnbEqzgYUU9FdILoeT4blzoov89YGqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789225731; c=relaxed/simple;
	bh=yoQClEnBg/HaRB7By+AA7I9DhNDOG8dDilQXCEEvVfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBDZ5hHiBamkjox/BK7TTOA0qQKWjdakpKbgSVU5kiYXgl7u8eASHOqqoWt8ZOD3Dk4BBXjWiduKd9V7BZ3ohTHzKTNNtCW8r+vGoBd3ZzXpBAjW/gyHjcYn1AmvPkHp94Q/xb7oQL20Jbottcx4EzbeXZpGJIHVgLv1Ayc+Xzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMnNt1Fa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMnNt1Fa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465EB1F0089A;
	Sat, 12 Sep 2026 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789225729;
	bh=Q7SMvfaPDSfJV5z9109dYi0SrYipLecXNH7mhYegT5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dMnNt1FayQY+j9V2MTVlHVtpWto0eVyL5StDTwRt4wxmrAK7JWGq0sDp+k4KfRc0a
	 Xge3c1fO0YBhe6i4Yy7ZGy2/Zq9gCtYJ7W+OxBy3THlcSbUxzCDK8FQUjXDTxPXJL+
	 6OpkIaQALuqJHHkazIoEtZgRD5EWoiHOrS8tQ78sofJ5eersOaq/Ug0v2UVJGxSY3s
	 aPb58a1jRWPXzLy43II3ne0M2PRktxhyeFBrek1gjbhenaYO+YOVbSjl6ENQFh27mD
	 F+NMOjN05p9VaMUU9rnsD2RvglpfS1Sk+xADVgP9giYVTaNj64zRpH5lBDB6a2/6A4
	 Us5sJfN1IupPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kavan Smith <kavansmith82@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value
Date: Sat, 12 Sep 2026 11:08:46 -0400
Message-ID: <20260912150846.3054393-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912150846.3054393-1-sashal@kernel.org>
References: <2026090910-activist-busily-77c5@gregkh>
 <20260912150846.3054393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kavan Smith <kavansmith82@gmail.com>

[ Upstream commit 6cd33b6f4155efc20485929fd0b56bb704641db9 ]

MSM8916 runtime DSI commands still go through
msm_dsi_host_xfer_prepare(), which re-applies the link clock rate before
enabling the link clocks. That is fine in principle, but on DSI 6G the
requested byte clock rate often does not exactly match the DSI PHY PLL's
realizable rate. For example, the driver can request 56250000 Hz while the
PLL actually runs at 56246337 Hz.

Because the requested and actual rates differ slightly, every later
link_clk_set_rate() call is treated as a real clock change and re-locks
the PLL. On a video-mode panel without an internal timing generator, such
as samsung,s6d7aa0 / lsl080al03 on MSM8916, that live-clock glitch makes
the panel lose pixel lock and visibly corrupts scanout on each runtime DCS
command, including backlight writes.

Fix this by rounding the computed 6G byte clock rate up front, before it is
stored in msm_host->byte_clk_rate and reused by later transfers. Once the
host carries the PLL-achievable rate instead of the idealized one,
repeated link_clk_set_rate() calls become no-ops in the common clock
framework and no longer re-lock the PLL.

This keeps the normal transfer callback sequencing intact, preserves the
OPP vote path in link_clk_set_rate(), and matches the fix direction
suggested in the original 2018 discussion.

Reported-by: Daniel Mack <daniel@zonque.org>
Closes: https://lore.kernel.org/all/1a682c5b-7fc9-3aaa-120b-64b239a355a3@zonque.org/
Fixes: 6b16f05aa39f ("drm/msm/dsi: Split clk rate setting and enable")
Cc: stable@vger.kernel.org
Signed-off-by: Kavan Smith <kavansmith82@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/738234/
Link: https://lore.kernel.org/r/20260707013240.681012-1-kavansmith82@gmail.com
[DB: dropped extra chunk from the patch]
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 8066a02abe8d1..4b0998f13d67a 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -723,12 +723,24 @@ static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 
 int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 {
+	long rounded_byte_clk_rate;
+
 	if (!msm_host->mode) {
 		pr_err("%s: mode not set\n", __func__);
 		return -EINVAL;
 	}
 
 	dsi_calc_pclk(msm_host, is_bonded_dsi);
+
+	rounded_byte_clk_rate = clk_round_rate(msm_host->byte_clk,
+					       msm_host->byte_clk_rate);
+	if (rounded_byte_clk_rate < 0) {
+		pr_err("%s: failed to round byte clock rate, %ld\n",
+		       __func__, rounded_byte_clk_rate);
+		return rounded_byte_clk_rate;
+	}
+
+	msm_host->byte_clk_rate = rounded_byte_clk_rate;
 	msm_host->esc_clk_rate = clk_get_rate(msm_host->esc_clk);
 	return 0;
 }
-- 
2.53.0

