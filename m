Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045757;
	b=PeaqccG7nowOXeiVEXW6kkam+F1VsoBrpFI6oOPsiC9zHtVNLtVVNQeLgTGRaq7DuR/4
	 8UibkUYM6ioD/MeXTqETphtzxy3vocu3naZSg3Nq5PUeZjnuBFkhP8H+2AxOVDc6J3EOb
	 8sG/C+z9Jug2fxot1+XxlpC4r37Db7GvJoPqTfVjHgAGHQh6LdopG8V7SZMjG4gbqdvXn
	 RvFE8iU3XtiRpo65SgCpwlMB6cArAWgNi3ajO20ip1I15r5oP8lA3UayBP6/mG1rYTLi2
	 Nc+krtc+UHbb8LitXsuXkPrmt8GKBtueSRaPxh1h89vALbyovf46svMHWlHKO+qudpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045757;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GyBqAaguIQ+FE0MDEAjOmWxWyxdL8hkUPQ1Cb1MIjHY=;
	b=p13m3Wti5TPlIjdS2lcX7x+clgFt2IgpvwGliQsIGAYp4Goz3icTYWIX4FAbJJ2jFiEU
	 DcdS9suFoKzYz5JPiXm52qT8v3+wWOIwckindA/e08hPIp8rTLw3lMKdnUjAAyJXTvWfx
	 HfvwyaL4zKNoJfX37XcUj/HJ6xIT6EoNTRHRA2Iwc7/HJ4va2KeIksE5uJCYZNaO//JRh
	 4W5pp6jFmTZt00J3qazW72P1BEBUFKYIxXabcX7AtlKfuLGqmvtCX2jnr3GXUUj0GcWYO
	 G9oZCjk1wnEiba8dMIi5KTlw3J2DnVMGvvrPJH+Wj+/n4P0QttPZjWiif7SDU5kSigw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b2lV/aYk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7092C606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2lV/aYk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6581F0089F;
	Sat,  7 Nov 2026 10:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045757;
	bh=GyBqAaguIQ+FE0MDEAjOmWxWyxdL8hkUPQ1Cb1MIjHY=;
	h=From:To:Cc:Subject:Date;
	b=b2lV/aYklgYu73BZ8dlN4p/bOQrX4m++DXJNjxCHH0ORy8iUF4pHcQchRA01Hql3m
	 sXMvCf7lk9EKsTw/b58ad9VJTIsEfLWaud5MvsXip+3MF1IUWpov+c7ymW498lPUB5
	 28BJs5w4eVSAxG5vwIg9mv2WmSQWH8q5pK4XO3g1PDcGDcCzHot8wX9LA3SwP8K2Lj
	 SIQ7eNFU4T38gsbpOBhCwUMzIuQPvwi/k4N0Nce7C4S2lsNsCUbaUrsiIyOwGsU47h
	 uh2vnjl3pQ4DSASEUvZBT3PIho3HQSSyUqiSOAP4tcjZMmiuudHBqUV2o11xzZe8uT
	 fC6JHfiZ2HlGA==
From: Sasha Levin <sashal@kernel.org>
To: ville.syrjala@linux.intel.com,
	suraj.kandpal@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/cdclk: Avoid spurious cdclk sanitization on PTL+" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:35 -0500
Message-ID: <20261107050235-failed-7.3-1786d2688781@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 1786d26887817a779641d3a093c66ac91382113b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050235-failed-7.3-1786d2688781@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1786d26887817a779641d3a093c66ac91382113b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Fri, 17 Jul 2026 18:51:06 +0300
Subject: [PATCH] drm/i915/cdclk: Avoid spurious cdclk sanitization on PTL+
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Apparently PTL+ no longer has the cd2x pipe select field in
CDCLK_CTL. Take that into account during CDCLK sanitization.

This currently triggers a spurious CDCLK sanitization during
driver load on PTL+ which will causes a visible glitch on all
active displays.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8550
Fixes: 3f9de66f8acb ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/20260717155107.17801-1-ville.syrjala@linux.intel.com
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_cdclk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
index a53d887271778..9e5e15b0c4d12 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -2381,8 +2381,10 @@ static void bxt_sanitize_cdclk(struct intel_display *display)
 	 * dividers both syncing to an active pipe, or asynchronously
 	 * (PIPE_NONE).
 	 */
-	cdctl &= ~bxt_cdclk_cd2x_pipe_mask(display);
-	cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	if (DISPLAY_VER(display) < 30) {
+		cdctl &= ~bxt_cdclk_cd2x_pipe_mask(display);
+		cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	}
 
 	if (cdctl != expected) {
 		if (DISPLAY_VER(display) < 20) {
-- 
2.53.0




