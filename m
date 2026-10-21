Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594331;
	b=pFiGmDeFRxsRIRUAR5Az4Gy7KbcH8TNX1tcY4V9ww+35MhT3//8fqMCr41VD/dFDydTD
	 IQcFX+OSS8BWpNqgdQIIgf7GG5cxsLFLDZaOKgPasOGfCu0AStRExhx8eiwqu4bSm1a5X
	 Gf5UwDib1JZ2ba0YXSx/ZmQRSjoA9w0gObJX/EhkrE0sdZ2FhWy0KOul38FzEaAXyW4Kh
	 jb7SaAOMI6VhSwWoPfDgB+0iJfInAE/HRkBLIRCrXgocpDjzVXM+OSf0ju4lZLK9ZqDAu
	 vo8IEAF8D0DxqWi/dcBoJyIxJl0Wkan/F+5HXaG5qX78Tm6gt7ewMdpSVYE3LMP1zrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594331;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lTiQDX1a/4HBIkdSvV2epnajcK/pPdpp6bw/0QhWLiw=;
	b=ILf6+VE/vxtl9WvriYVjoVdLBlmWD0NRFWcQCCVCac8MH2czXT78q4aPMh8bbbtwAts+
	 aEIh2bJlhTbRUGN5UIJ3j9aR7xVe36b96HPvpfn8ERfO1HwYFLX3HTpwJNFHMgMzYpc0f
	 acCkSMJpowZrXvwn7o7CoW3+CVFDfV6iohqi811bpJLNMmHPuW//Dm7BOIkg+RIwlOfCj
	 LmUY6WVe1UtVvqpZFOwhcW7MWONDwkqiwHJe7YwmZX7F7MLoOzOVW8iwY+RvllME0fR9D
	 awECKyCP5BD8WI7CLZOiL0zGhgbd4jPauWjXhUxRaotehBfYgXk0sgli1ON3UqT+NMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Blypjeh9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F45606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Blypjeh9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1DF1F000C1;
	Wed, 21 Oct 2026 14:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594330;
	bh=lTiQDX1a/4HBIkdSvV2epnajcK/pPdpp6bw/0QhWLiw=;
	h=Subject:To:Cc:From:Date;
	b=Blypjeh9S5ido61UNTEnY7xaAOBmvbQLsI/wI80qYHY98bAGQsG+aGn5QzUJ6LlJL
	 5KRFYr18cUlF4Xa0F/fdLSLcTN4WK0RWBXq7cYgf/LQAn2p/v/cPQOSRsRkTaJGAmv
	 hPOkf16sCnjokTm+2BwT+NyH06foJa/DhJ101NMM=
Subject: FAILED: patch "[PATCH] drm/i915/dmc: Harden DMC firmware payload parsing" failed to apply to 5.10-stable tree
To: dibin.moolakadan.subrahmanian@intel.com,ankit.k.nautiyal@intel.com,joonas.lahtinen@linux.intel.com,mitulkumar.ajitkumar.golani@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:47:12 +0200
Message-ID: <2026102112-observant-ungreased-d48c@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8bb1858db453cd4250e3b633f5d2d09206024ca6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102112-observant-ungreased-d48c@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8bb1858db453cd4250e3b633f5d2d09206024ca6 Mon Sep 17 00:00:00 2001
From: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>
Date: Tue, 22 Sep 2026 19:05:37 +0530
Subject: [PATCH] drm/i915/dmc: Harden DMC firmware payload parsing

Validate the conversion of the DMC firmware size from dwords to bytes
using check_mul_overflow() before calculating the firmware payload size.

Reject zero-length payloads and zero MMIO counts in the DMC firmware
header so malformed firmware is caught early. Also set dmc_fw_size only
after the payload allocation succeeds.

Fixes: eb805623d8b1 ("drm/i915/skl: Add support to load SKL CSR firmware.")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:Sonnet-5
Signed-off-by: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>
Reviewed-by: Mitul Golani<mitulkumar.ajitkumar.golani@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patch.msgid.link/20260922133535.3180973-5-dibin.moolakadan.subrahmanian@intel.com
(cherry picked from commit efde6601a1f1daedfe3dcc2816c934ddb44e3eef)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index a191eee240d9..725481012578 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -1120,7 +1120,7 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 	}
 
 	/* Cache the dmc header info. */
-	if (mmio_count > mmio_count_max) {
+	if (!mmio_count || mmio_count > mmio_count_max) {
 		drm_err(display->drm, "DMC firmware has wrong mmio count %u\n", mmio_count);
 		return 0;
 	}
@@ -1166,13 +1166,21 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 			    disable_dmc_evt(display, dmc_id, dmc_info->mmioaddr[i],
 					    dmc_info->mmiodata[i]) ? " (disabling)" : "");
 	}
-	dmc_info->mmio_count = mmio_count;
-	dmc_info->start_mmioaddr = start_mmioaddr;
 
 	rem_size -= header_len_bytes;
 
 	/* fw_size is in dwords, so multiplied by 4 to convert into bytes. */
-	payload_size = dmc_header->fw_size * 4;
+	if (check_mul_overflow(dmc_header->fw_size, 4u, &payload_size)) {
+		drm_err(display->drm, "DMC fw_size too large (%u dwords)\n",
+			dmc_header->fw_size);
+		return 0;
+	}
+
+	if (!payload_size) {
+		drm_err(display->drm, "DMC firmware has empty payload\n");
+		return 0;
+	}
+
 	if (rem_size < payload_size)
 		goto error_truncated;
 
@@ -1180,12 +1188,15 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 		drm_err(display->drm, "DMC FW too big (%u bytes)\n", payload_size);
 		return 0;
 	}
-	dmc_info->dmc_fw_size = dmc_header->fw_size;
 
 	dmc_info->payload = kmalloc(payload_size, GFP_KERNEL);
 	if (!dmc_info->payload)
 		return 0;
 
+	dmc_info->mmio_count = mmio_count;
+	dmc_info->start_mmioaddr = start_mmioaddr;
+	dmc_info->dmc_fw_size = dmc_header->fw_size;
+
 	payload = (u8 *)(dmc_header) + header_len_bytes;
 	memcpy(dmc_info->payload, payload, payload_size);
 

