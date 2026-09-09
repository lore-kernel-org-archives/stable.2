Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976357ED91
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963066; cv=none; b=TaghD+1lCTf91AbH/yMLDcnw2T5yMYoNmnaw9zMr9jxMdBuL1PPOaXbg9sLP96siV+4rL8dJN8RMsxij3AjiiB2Sylk2xXPEr1PRsc8hkqx6McOSPYI+mbeVOO1Kx5lfkJLx5XhXSLwYmIRvLuV6i4r3SMsPMyf7/aLy48Bsn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963066; c=relaxed/simple;
	bh=Jl2CbzTVs0oG8QbjtDsyjoHuf8hGqsUZGabAgTuH3So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKpiJ4DZQCR7RHnJgXzcQGjnwx2zuldR3hFWd9Q2u7grVVMzPS2q7pjpSHyzSVWaTmF0Vrn5DbFqIEY5C0Vxma5oT53cZ+1kef+9TyFRGUVSkicW8pFY/8fpuSZNHF2+EIj2XCQApLgtGfr6AcvZcQdayB0uDs1yOzb9UcIEhrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cc8BusAw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc8BusAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4E71F00A3D;
	Wed,  9 Sep 2026 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963065;
	bh=8n66xC8F8XO+RQ0mkrNq588KUOQqQ6w9R1DrapavYQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cc8BusAw/yRI5YRqU9j4nENYYO/17bxOMjPXPYG124TNqoiODX+1lQ3KXYJpt1Kw2
	 /x8xK4IcvxjUdOubLgtsB885dKTCekeR+JIh1b4I9f34aum03/QFRBMuisQGz2GVb7
	 siq3bxOe1wrQMQsY1KiG1+gKakVBFUbqkt/AinjapI5aZmgVrsRKUEItpEfHpbllzQ
	 gark5zbrSnkG8jG9hwangmvro7apLDlCgwNwpnQk5SR/NOPS6cslLtpeT5WfCD0+B3
	 UxJtMZ3s0Z1S/GEv0egBaer6kGekwdZwYEqiRfx0DTe2A6pJRop2FvandywpaMeqsv
	 pfbqxTT4v60mQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/7] platform/x86/intel/tpmi: Move TPMI ID definition
Date: Wed,  9 Sep 2026 10:10:56 -0400
Message-ID: <20260909141102.2383363-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090334-lumber-underfoot-3bf9@gregkh>
References: <2026090334-lumber-underfoot-3bf9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 046d7be6210e7f870e53eb38fd410237e9d1d88f ]

Move TPMI ID definitions to common include file. In this way other
feature drivers don't have to redefine.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20231204221740.3645130-4-srinivas.pandruvada@linux.intel.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 3de2776e9d70 ("platform/x86: ISST: Add a NULL check for sst_inst[]")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/tpmi.c | 13 -------------
 include/linux/intel_tpmi.h        | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 4c42c28bdd3d4..021e56f52ac12 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -143,19 +143,6 @@ struct tpmi_info_header {
 	u64 lock:1;
 } __packed;
 
-/*
- * List of supported TMPI IDs.
- * Some TMPI IDs are not used by Linux, so the numbers are not consecutive.
- */
-enum intel_tpmi_id {
-	TPMI_ID_RAPL = 0, /* Running Average Power Limit */
-	TPMI_ID_PEM = 1, /* Power and Perf excursion Monitor */
-	TPMI_ID_UNCORE = 2, /* Uncore Frequency Scaling */
-	TPMI_ID_SST = 5, /* Speed Select Technology */
-	TPMI_CONTROL_ID = 0x80, /* Special ID for getting feature status */
-	TPMI_INFO_ID = 0x81, /* Special ID for PCI BDF and Package ID information */
-};
-
 /*
  * The size from hardware is in u32 units. This size is from a trusted hardware,
  * but better to verify for pre silicon platforms. Set size to 0, when invalid.
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index ee07393445f9f..fdcebb8c30e98 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -12,6 +12,19 @@
 #define TPMI_MINOR_VERSION(val)	FIELD_GET(GENMASK(4, 0), val)
 #define TPMI_MAJOR_VERSION(val)	FIELD_GET(GENMASK(7, 5), val)
 
+/*
+ * List of supported TMPI IDs.
+ * Some TMPI IDs are not used by Linux, so the numbers are not consecutive.
+ */
+enum intel_tpmi_id {
+	TPMI_ID_RAPL = 0,	/* Running Average Power Limit */
+	TPMI_ID_PEM = 1,	/* Power and Perf excursion Monitor */
+	TPMI_ID_UNCORE = 2,	/* Uncore Frequency Scaling */
+	TPMI_ID_SST = 5,	/* Speed Select Technology */
+	TPMI_CONTROL_ID = 0x80,	/* Special ID for getting feature status */
+	TPMI_INFO_ID = 0x81,	/* Special ID for PCI BDF and Package ID information */
+};
+
 /**
  * struct intel_tpmi_plat_info - Platform information for a TPMI device instance
  * @package_id:	CPU Package id
-- 
2.53.0

