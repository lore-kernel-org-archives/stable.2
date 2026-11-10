Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273642;
	b=rlESESraXxEBFOb/o8Vi8w3KLaQnhHCIeEb/mtvEW1uombBmkbjXHBVixPdlb5NHGzav
	 gklbUmJh1KeOBMwua+BkFaWJ+mUcEjnozEQk62MAxamcR5+kTVwh3E6Na4vc1Ts5PSWeD
	 vLyiei/aSFjA7pWuJ3AHkwY/+pbfdB5ClFk/pCg+oDiR905kDK+Tcf5d0Lius9pmXeuph
	 4gg1URLr05TQg3xfAiWVpeZQ3OtWy8J1JtFwZDVv2hBP5NLAT4RBDX0WM8SFq4PLMve4S
	 dpaZoopkT+rjUxGvGhs2iMiRCapudvsu7sG3QGhjVGOvCh8/gzLHJlUPMS1X+OiLY8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273642;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Sz1iLDRDBC1cGcXWwTUC7jlfI/+ylfexyAWkOmjSZ9s=;
	b=Gaq4keXFFXIqb8cFlYQ46IxX9h5fnVSnd6IwpZM+iWq+LwUA8wwqjEFL8T9gmprGLQVa
	 o29fxAA0pBc2Q5HwYQPt/EeVo8LtZt0htpHIIN8u6MIeB1FLmcfVQ+JI10ZCbahrFEpLz
	 x90Ov9e6VDsXfX74OHsrf34q2V5gy0Hh0IFVQPoGa9LEZZt1p0P4h9LIKw5Ux3Hs2i4S6
	 qKbgH9zkXMSmaewa+3/BA6POmQp36yg+968LAJac78LkbmvxNOWzJpgWtWRYgobCgMTaP
	 Y3O+SyEVgQ0nPd+sOT8FD0YyCqb/ZWbrUKENHxHp4zGhaWmfNpZh2gAYhLfz+bX4JxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwcCdYq5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A5606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwcCdYq5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BEA1F0089F;
	Tue, 10 Nov 2026 01:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273642;
	bh=Sz1iLDRDBC1cGcXWwTUC7jlfI/+ylfexyAWkOmjSZ9s=;
	h=From:To:Cc:Subject:Date;
	b=BwcCdYq5RAPEeD5vfHIgn3VQW77QJnXWcjErsPhktdL5hjKWXaWp/VVHRT1pIH3TV
	 xi3XKpHUB/VF3b+Ui3ETL7I9O27u78vJX6AGQGxFpknziAZwislN34L5nYwefcbYBd
	 fV+K8yvxBqnzRBuyNWvMJB6OvOVtNr0Or2oxkeFeKPcvbQXCJPONr9yHzNeCtjdjS/
	 DZv9IpkREXbcZ2OYDoaZIjBZPB0W4la10LUK9zW5YIvI0m/pC8f9gHPT+ziukyRDiD
	 oKKh3iCGYQ7LWjNh2RvXoUQnKlHpsGVnSQucHSUjePcpoDFcR3o7JSAizamT0HH3nt
	 txx0pI18KoraQ==
From: Sasha Levin <sashal@kernel.org>
To: lucas.tanure@neat.no,
	mcanal@igalia.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/vc4: hdmi: enable scrambling before the TMDS clock starts" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:40 -0500
Message-ID: <20261109202040-failed-5.15-81383bd290a1@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 81383bd290a18f06ccf9b0bfb29e1a3ef73d9357
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202040-failed-5.15-81383bd290a1@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 81383bd290a18f06ccf9b0bfb29e1a3ef73d9357 Mon Sep 17 00:00:00 2001
From: Lucas Tanure <lucas.tanure@neat.no>
Date: Mon, 26 Oct 2026 16:40:28 +0000
Subject: [PATCH] drm/vc4: hdmi: enable scrambling before the TMDS clock starts
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

HDMI 2.0 requires a source to suspend the TMDS clock, write the
TMDS_Bit_Clock_Ratio bit in the sink's SCDC registers, wait at least
1 ms and only then resume the clock. vc4 does the opposite: the PHY
starts at the new rate first, and the SCDC bits are written tens of
milliseconds later, at the very end of the enable sequence, together
with the source side scrambler. On disable the bits are cleared while
the clock is still running.

Some sinks sample the bit only when the clock appears. One HDMI 2.0
sink we tested then sets up its receiver for a 1/10 clock and never
recovers: a Raspberry Pi 5 at 3840x2160@60 shows no picture, while
1080p60 and 4K30 work and other sources work at 4K60 on the same sink.
Writing the bit by hand before enabling the output makes the same mode
lock every time.

Enable scrambling, on the sink and in the controller, before the PHY is
started, and disable it only after the PHY has been stopped. The SCDC
helper already waits the required time after writing the ratio bit.

Cc: stable@vger.kernel.org
Fixes: c85695a2016e ("drm/vc4: hdmi: Enable the scrambler")
Link: https://github.com/raspberrypi/linux/issues/7693
Assisted-by: LLM
Signed-off-by: Lucas Tanure <lucas.tanure@neat.no>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Link: https://patch.msgid.link/20261026164028.78792-4-lucas.tanure@neat.no
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index f58f645ec3c50..f2043f907dc52 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -917,8 +917,6 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
 		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 	}
 
-	vc4_hdmi_disable_scrambling(encoder);
-
 	drm_dev_exit(idx);
 
 out:
@@ -946,6 +944,8 @@ static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder,
 	if (vc4_hdmi->variant->phy_disable)
 		vc4_hdmi->variant->phy_disable(vc4_hdmi);
 
+	vc4_hdmi_disable_scrambling(encoder);
+
 	clk_disable_unprepare(vc4_hdmi->pixel_bvb_clock);
 	clk_disable_unprepare(vc4_hdmi->pixel_clock);
 
@@ -1553,6 +1553,8 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
 		goto err_disable_pixel_clock;
 	}
 
+	vc4_hdmi_enable_scrambling(encoder);
+
 	if (vc4_hdmi->variant->phy_init)
 		vc4_hdmi->variant->phy_init(vc4_hdmi, conn_state);
 
@@ -1687,7 +1689,6 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 	}
 
 	vc4_hdmi_recenter_fifo(vc4_hdmi);
-	vc4_hdmi_enable_scrambling(encoder);
 
 	drm_dev_exit(idx);
 
-- 
2.53.0




