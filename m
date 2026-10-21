Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594311;
	b=qOFW5WNdEyciqd6l1Dhdjx7Rjw7M2C8IyiQt2CNPKSlNjfjJZBVl3gj5DlD1hlRZ6Rc+
	 y+fApORrEamESOvpbAgKNLCMcZaaDKCmRCIDQN0/7IBthVI9Q0zn+bMba62XUKHg4emkB
	 iqbGEJJKeaS7swnZd2ONVGUvyR1oIwtiJvqSGyrRJ+w3n6SykTvza8CCToybmlxG+vqUN
	 iJPYqZ0zsKJ6YzFUR2gEQf5H82Ia9Hda/RfRKzQf9msWVRW0qxOtCFFRwR7dBrGUt9bRu
	 9Nlb9Pa06OuQHKNA+kIrlXzgY0N+hreqeL/Aql7vQ04Il2gB+Wp8H1N1ko1ALJJfZgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594311;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=J7+hIguXMisF3RenzMeFRVFLYxvNDZxVMIL1zRSuxkE=;
	b=B46YjK3ykOsAE+WsEUWDdN3N6/FS67HHsZz8BRIe5n8c5swLF3cPZoob2Q08CAfFP+YG
	 icxjYlEkdIoA2RlipN/N0lJPA3jlKa6lVkh9c0h1fTcYiaT6ekVgvgr18I4bUU5TtTjI/
	 pOLMhajhUDGOlXdZxNqFjKSRA7lFsNFWhMWN4B+4R4H0ZRc+QIIBPouk+ZEv57gaGtI0F
	 +GLBAn3ZZQPKFeulL1TYHEI2G4d22OVthxV/PI7W62HP/+FamAEtd65+qC5tHDnbHNYT9
	 qETv54yLelO97QN9oF6dYN8ZUWZIkneLVKC2Xi+t8Tssw+O3oPLRZOMdMut3FYr6Ikw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NE7yzUn2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA5606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NE7yzUn2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112321F000C5;
	Wed, 21 Oct 2026 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594310;
	bh=J7+hIguXMisF3RenzMeFRVFLYxvNDZxVMIL1zRSuxkE=;
	h=Subject:To:Cc:From:Date;
	b=NE7yzUn2PkvjEFs7aXwId13z0UApZaM1wB6yqf/Ke6VHdYYSC5KOvthUBif9k31gP
	 C3O+dhbjqE+Jpiv8au0F1BAcaQ6CypYEakrKDZ8KMjndMmvAW8dB7LO8j/V7sd0yUJ
	 AwQ8GhCAQ0pC+olmYI5BtDJUNgdvnwgZ3bPTClP8=
Subject: FAILED: patch "[PATCH] drm/i915/dmc: Add sanity check for DMC load address" failed to apply to 5.15-stable tree
To: dibin.moolakadan.subrahmanian@intel.com,ankit.k.nautiyal@intel.com,joonas.lahtinen@linux.intel.com,mitulkumar.ajitkumar.golani@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:47:03 +0200
Message-ID: <2026102102-cosponsor-entrench-2d30@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7dedc5bb11f95e96fe80757c924d8d9aa7327759
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102102-cosponsor-entrench-2d30@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7dedc5bb11f95e96fe80757c924d8d9aa7327759 Mon Sep 17 00:00:00 2001
From: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>
Date: Tue, 22 Sep 2026 19:05:38 +0530
Subject: [PATCH] drm/i915/dmc: Add sanity check for DMC load address

For DMC firmware header version 3, the firmware load address is stored
in dmc_info->start_mmioaddr and later used by dmc_load_program().

Unlike the MMIO address table, the firmware load address is not
validated. Add a sanity check to ensure it is within the valid range.

BSpec: 69671, 68378
Fixes: 3d5928a168a9 ("drm/i915/xelpd: Pipe A DMC plugging")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:Sonnet-5
Signed-off-by: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>
Reviewed-by: Mitul Golani<mitulkumar.ajitkumar.golani@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patch.msgid.link/20260922133535.3180973-6-dibin.moolakadan.subrahmanian@intel.com
(cherry picked from commit 5e47ee5c76ca9becde8df4ad5202845b7ffcbc4c)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index 725481012578..6611765fd62c 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -1023,6 +1023,55 @@ static void dmc_set_fw_offset(struct intel_dmc *dmc,
 	}
 }
 
+/*
+ * Check if the load address is within the valid range for the given DMC ID.
+ */
+static bool dmc_load_addr_sanity_check(struct intel_dmc *dmc,
+				       u32 start_addr, u32 payload_size,
+				       int header_ver, enum intel_dmc_id dmc_id)
+{
+	u32 start_range, end_range, end_addr;
+
+	if (header_ver != 3)
+		return true;
+
+	switch (dmc_id) {
+	case DMC_FW_MAIN:
+		start_range = DMC_MAIN_PROGRAM_BASE_START;
+		end_range = DMC_MAIN_PROGRAM_BASE_END;
+		break;
+	case DMC_FW_PIPEA:
+		start_range = DMC_PIPEA_PROGRAM_BASE_START;
+		end_range = DMC_PIPEA_PROGRAM_BASE_END;
+		break;
+	case DMC_FW_PIPEB:
+		start_range = DMC_PIPEB_PROGRAM_BASE_START;
+		end_range = DMC_PIPEB_PROGRAM_BASE_END;
+		break;
+	case DMC_FW_PIPEC:
+		start_range = DMC_PIPEC_PROGRAM_BASE_START;
+		end_range = DMC_PIPEC_PROGRAM_BASE_END;
+		break;
+	case DMC_FW_PIPED:
+		start_range = DMC_PIPED_PROGRAM_BASE_START;
+		end_range = DMC_PIPED_PROGRAM_BASE_END;
+		break;
+	default:
+		MISSING_CASE(dmc_id);
+		return false;
+	}
+
+	if (payload_size == 0)
+		end_addr = start_addr;
+	else if (check_add_overflow(start_addr, payload_size - 1, &end_addr))
+		return false;
+
+	if (start_addr < start_range || end_addr > end_range)
+		return false;
+
+	return true;
+}
+
 static bool dmc_mmio_addr_sanity_check(struct intel_dmc *dmc,
 				       const u32 *mmioaddr, u32 mmio_count,
 				       int header_ver, enum intel_dmc_id dmc_id)
@@ -1189,6 +1238,12 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 		return 0;
 	}
 
+	if (!dmc_load_addr_sanity_check(dmc, start_mmioaddr, payload_size,
+					dmc_header->header_ver, dmc_id)) {
+		drm_err(display->drm, "DMC %d: firmware has wrong load address\n", dmc_id);
+		return 0;
+	}
+
 	dmc_info->payload = kmalloc(payload_size, GFP_KERNEL);
 	if (!dmc_info->payload)
 		return 0;
diff --git a/drivers/gpu/drm/i915/display/intel_dmc_regs.h b/drivers/gpu/drm/i915/display/intel_dmc_regs.h
index 6b7978fb8986..324320afad58 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_dmc_regs.h
@@ -521,6 +521,18 @@ enum pipedmc_event_id {
 #define TGL_PIPE_MMIO_END(dmc_id)	_PICK_EVEN(((dmc_id) - 1), _TGL_PIPEA_MMIO_END,\
 					      _TGL_PIPEB_MMIO_END)
 
+/* For DMC header version v3*/
+#define DMC_MAIN_PROGRAM_BASE_START	0x80000
+#define DMC_MAIN_PROGRAM_BASE_END	0x86fff
+#define DMC_PIPEA_PROGRAM_BASE_START	0x90000
+#define DMC_PIPEA_PROGRAM_BASE_END	0x96fff
+#define DMC_PIPEB_PROGRAM_BASE_START	0x98000
+#define DMC_PIPEB_PROGRAM_BASE_END	0x9efff
+#define DMC_PIPEC_PROGRAM_BASE_START	0x52000
+#define DMC_PIPEC_PROGRAM_BASE_END	0x53fff
+#define DMC_PIPED_PROGRAM_BASE_START	0x59000
+#define DMC_PIPED_PROGRAM_BASE_END	0x5afff
+
 #define SKL_DMC_DC3_DC5_COUNT	_MMIO(0x80030)
 #define SKL_DMC_DC5_DC6_COUNT	_MMIO(0x8002C)
 #define BXT_DMC_DC3_DC5_COUNT	_MMIO(0x80038)

