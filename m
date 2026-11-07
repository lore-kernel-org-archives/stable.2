Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045817;
	b=zWpiZi9mIY3DFe6i8M4IHzqJ0MFW1TmBT8NslFuA5LZSAS10HQX/qeWWiaJ4mpLpaNrC
	 PHL+7GgSg0vIHDercX966J/NlAozLLWaCAdLCp5JrDC9KuhEU6YZpJvpWiSUegCwBqkpW
	 4l38Q400ahjKiYZjPRH/q8XvgUHKzPSTtrEvLljQXnu+VGNFeAes4TYs0vyJHF1pRs4I5
	 wxXxw7E+EcbucMVX99+hXJ2bI49OBj83RyFYczWDy9vgl2YSkOvQOikqI/A9O6yTY9G2L
	 Z2lYV7e/qM3qiblpmR0y0xnTlUosHWO800ZDz9KHBdyQfSZOO4PceTZ3rTguFfUiv4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045817;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Nc1wwyQz7NSeQte3wZvpjHGD4iBnEKrskM+bCUYqkyM=;
	b=XW1i36GvmV9QmjiHnYMYRYffd/fTcH/xO9bK9WmDX8EzQ46xhYAcqx0Y/4+sFR1dQKNg
	 6t7kVg5OUrFEuG0M7GygNS3LZ0ZPFIjmvFD+uZgHqKM2XoOy48QhWyZN+f6xTdy/bD4id
	 YVqHa5wdAc1XmkBCgSlUeMmw5zKC/nQZrxj+AAs/SP4BWbmUA4Kxc4bRS+nBiK14+3G19
	 8ayKQ/d4c8Dcth/oubxiBmown8SbomWkS7sleQgyKTvRpvGdtdZx8TQvyyTqwG89NQKig
	 T+qIY6mr47c4svsLd4qo3fMG7JOMSH9xBgr3yTyBG8F2mCosbGYuVbSCjIG3OavkGxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wq31eErr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE0A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wq31eErr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F591F0089F;
	Sat,  7 Nov 2026 10:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045816;
	bh=Nc1wwyQz7NSeQte3wZvpjHGD4iBnEKrskM+bCUYqkyM=;
	h=From:To:Cc:Subject:Date;
	b=Wq31eErritnN7h8uJg+RKzzslcSRuhGEWhTGXbNSpBwPjp/2e1hV653dNDyxIM1+V
	 ua4V8F32QA0YXWa2YolSf1I0NymoI0ff+q1o8gWVQ1GWo5Woq2s9BCASpm4vQJe1vz
	 8dB3x3pIS0wH0Lz+WQS8DLGAKAvNEfrR0GvKQD8tXf78ZYKBb2I5VhNYiRNp/2pRDs
	 Sxr0JNOlvsppWCT5uyl1hP51EHh9Gm63cCkn6z7PB8nCyfyKsUDblzd69oUVpAz6x7
	 ngwWrdOcpyr2k7NWBgWfB+LAJrXFpIwWrpmaKXQywy+UBVcCKE/EcUTpeW6lAcDQkW
	 4nfrjkqlgoEsg==
From: Sasha Levin <sashal@kernel.org>
To: mitulkumar.ajitkumar.golani@intel.com,
	ankit.k.nautiyal@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/vrr: Disable DC balance by default" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:35 -0500
Message-ID: <20261107050335-failed-7.3-d1ef78f0581e@kernel.org>
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
git cherry-pick -x d1ef78f0581e856c4238c751e9ae2884ce58c275
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050335-failed-7.3-d1ef78f0581e@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d1ef78f0581e856c4238c751e9ae2884ce58c275 Mon Sep 17 00:00:00 2001
From: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
Date: Thu, 17 Sep 2026 13:13:22 +0530
Subject: [PATCH] drm/i915/vrr: Disable DC balance by default

Disable VRR DC balance by default due to timing issues observed on some
panel/TCON combinations.

Keep the module parameter to enable DC balance during debugging and to
isolate DC balance effects from underlying VRR/display timing issues.

--v2:
- Make enable_dc_balance a bool and keep it disabled by default; fix the
  parameter type/value mismatch and correct the description (Chaitanya
  Kumar Borah, Jani Nikula)
- Explain in the commit message why the feature is gated and why a
  module parameter is used (Jani Nikula)

--v3:
- Commit message update (Jani Nikula)

Fixes: 555819270707 ("drm/i915/vrr: Enable DC Balance")
Cc: <stable@vger.kernel.org> # v7.0+
Signed-off-by: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patch.msgid.link/20260917074322.2606738-1-mitulkumar.ajitkumar.golani@intel.com
---
 drivers/gpu/drm/i915/display/intel_display_params.c | 4 ++++
 drivers/gpu/drm/i915/display/intel_display_params.h | 1 +
 drivers/gpu/drm/i915/display/intel_vrr.c            | 4 +++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_params.c b/drivers/gpu/drm/i915/display/intel_display_params.c
index 2aed110c5b090..ca0ef466bb103 100644
--- a/drivers/gpu/drm/i915/display/intel_display_params.c
+++ b/drivers/gpu/drm/i915/display/intel_display_params.c
@@ -120,6 +120,10 @@ intel_display_param_named_unsafe(enable_psr, int, 0400,
 	"(0=disabled, 1=enable up to PSR1, 2=enable up to PSR2) "
 	"Default: -1 (use per-chip default)");
 
+intel_display_param_named_unsafe(enable_dc_balance, bool, 0400,
+	"Enable VRR DC balance (0=disabled, 1=enabled). "
+	"Default: 0 (disabled)");
+
 intel_display_param_named_unsafe(enable_panel_replay, int, 0400,
 	"Enable Panel Replay (0=disabled, 1=enabled). Default: -1 (use per-chip default)");
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_params.h b/drivers/gpu/drm/i915/display/intel_display_params.h
index ba01aeaf89440..5c5a1a1358c32 100644
--- a/drivers/gpu/drm/i915/display/intel_display_params.h
+++ b/drivers/gpu/drm/i915/display/intel_display_params.h
@@ -46,6 +46,7 @@ struct drm_printer;
 	param(bool, enable_dp_mst, true, 0600) \
 	param(int, enable_fbc, -1, 0600) \
 	param(int, enable_psr, -1, 0600) \
+	param(bool, enable_dc_balance, false, 0600) \
 	param(int, enable_panel_replay, -1, 0600) \
 	param(bool, psr_safest_params, false, 0400) \
 	param(bool, enable_psr2_sel_fetch, true, 0400) \
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index a516ba34e0d02..d43a06907d18a 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -441,10 +441,12 @@ static bool intel_vrr_dc_balance_possible(const struct intel_crtc_state *crtc_st
 static void
 intel_vrr_dc_balance_compute_config(struct intel_crtc_state *crtc_state)
 {
+	struct intel_display *display = to_intel_display(crtc_state);
 	int guardband_usec, adjustment_usec;
 	struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
 
-	if (!intel_vrr_dc_balance_possible(crtc_state) || !crtc_state->vrr.enable)
+	if (!intel_vrr_dc_balance_possible(crtc_state) ||
+	    !crtc_state->vrr.enable || !display->params.enable_dc_balance)
 		return;
 
 	crtc_state->vrr.dc_balance.vmax = crtc_state->vrr.vmax;
-- 
2.53.0




