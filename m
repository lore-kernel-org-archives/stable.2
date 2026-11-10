Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272570;
	b=T90cvA4jp0IJ7+CGppyga9WzqzneFatiTXLTAshnNYGuSw+WDsxYUuP53OFq/pSKL1BO
	 P/KMlRHpPxIGndbbmHgZT0jxwkCNRfA18BFuMzpuuY5nm3KlNjmmf4Rt1WgkUStoAm8PH
	 OkRBACWgvLDTu49EGjC8GIYHV1UpwOTJkRaP2dpFrpgHRPU30iU9JpvJMDibpPF3+bom2
	 IAj/65bkE2HYWYx9uqtSsYNkDpiuHz4vGfP3s89jBm0bKO98R5ZehxsTRL6bxa89vgQ9s
	 6bGQ90pQ5VdegqtE+5kdjzsKNB9jXLEVhjLPZxxveYoiqXVBtt20XHHEDOcLLIKSFrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272570;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GkzSXapzC1YuPL8wLJbtBGcaSAW0/Hr0JwP75UpPWpI=;
	b=0g+ax0DLQXh31REHQuj+wp2GuWMpwWPjgzQ2zA8IuueAAMxhzoqhurIsT5AIzJtL/shj
	 hF0HH70NJbMlIqUzEyXL2/QnerESPRMQJd3FGkvSA+tQjdpULIbl81k76FrvhXD1KbTQx
	 KBF9iWe9Y5Bn1o46knaLbADyQcl/tMZdWqKKLqPfdCHUoxIbIQWZljSRUmf46HZ7LqU9J
	 OftLHl4SIU1Xy4HTY6wmRTFP48fTXpsa0VtbEsMUiBh2VbTzh4m5MU6H1/xwMI0dGAGYF
	 QnaNe+Cvg9a6MWjsJv3vi23B0zoUuuEK9Ox6Raz280SYF/9X9/rbeZhMyjMyWxhq6rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7QmxCXA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C700606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7QmxCXA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6851F0089F;
	Tue, 10 Nov 2026 01:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272570;
	bh=GkzSXapzC1YuPL8wLJbtBGcaSAW0/Hr0JwP75UpPWpI=;
	h=From:To:Cc:Subject:Date;
	b=a7QmxCXAnTuhkdGDk7SQ4Aiq99UKggoJ+aKOBmcu90tPEQRM4B8n5v+SltSXDQmcn
	 l0kz6FMXbkxk2ye8LV905DqSq6XZ84P6j+7Y52o+w0mOcUnbAzfq3QPtmP7J+AiRJd
	 v7B1tIgqKmwy1sY6hDC2TySr43nTzuBDgRfG6CbferjdmOUF3vsYP07/5Fxs5fe7P7
	 AlW0PYSoWPx6cB/S4CxC0lLJ/lq6oOmzU/QFNEVe3a8SCZ6AHI1wvcDlBFjWJfqPtG
	 Txv03eD1o6ZcfiWnRkroKaQKEqLLCPY4Q+xHOVBT7zaH8gZrocBWkOoy12sWDYMVvU
	 FSiCGj5q0bWSA==
From: Sasha Levin <sashal@kernel.org>
To: vidya.srinivas@intel.com,
	charlton.lin@intel.com,
	uma.shankar@intel.com,
	joonas.lahtinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/display: Disable pipe joiner on WCL" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:02:48 -0500
Message-ID: <20261109200248-failed-6.18-b42b656db138@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b42b656db1384255044754cd2163d370d766b776
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200248-failed-6.18-b42b656db138@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b42b656db1384255044754cd2163d370d766b776 Mon Sep 17 00:00:00 2001
From: Vidya Srinivas <vidya.srinivas@intel.com>
Date: Wed, 28 Oct 2026 12:34:04 +0530
Subject: [PATCH] drm/i915/display: Disable pipe joiner on WCL

Pipe joining is not supported in the WCL display configuration.
Report no joiner support on WCL so that modes which would require
joining are rejected, matching the 4k 60Hz maximum resolution
documented for the platform.

v2: Rebase onto latest upstream
v3: Fix up the commit message
v4: Split the scaler and joiner changes into separate patches (Jani)

Bspec: 74286
Fixes: f8e1c3e07db1 ("drm/i915/xe3lpd: Add support for display version 30.02")
Cc: stable@vger.kernel.org
Suggested-by: Charlton Lin <charlton.lin@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
Signed-off-by: Uma Shankar <uma.shankar@intel.com>
Link: https://patch.msgid.link/20261028070404.1913843-3-vidya.srinivas@intel.com
(cherry picked from commit 917676a55a690319a01b45d3956eaf94ba564df8)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index d8c0d9381471d..47741957935ae 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -477,9 +477,9 @@ bool intel_dp_has_joiner(struct intel_dp *intel_dp)
 	    !connector->panel.vbt.edp.pipe_joiner_enable)
 		return false;
 
-	return DISPLAY_VER(display) >= 12 ||
+	return ((DISPLAY_VER(display) >= 12 && DISPLAY_VERx100(display) != 3002) ||
 		(DISPLAY_VER(display) == 11 &&
-		 encoder->port != PORT_A);
+		 encoder->port != PORT_A));
 }
 
 static int dg2_max_source_rate(struct intel_dp *intel_dp)
-- 
2.53.0




