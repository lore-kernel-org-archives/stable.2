Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E0314B96;
	Thu, 30 Jul 2026 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395816; cv=none; b=mMnK9kSRiivCeittg82gv68QL1+PkvvbGJwT7cih9rsFvVp5ytMyal/o0aHYRYd7ISA82pKj+nOsCX/pSQhgwZ9J0LpOMKMP7qrBLFtx/nNmpBsIfDpG0w14Q+8DDhiL4WTkawThBZt2qo+PS4e6sZSx2SSzH0WKRQvpf1b2B6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395816; c=relaxed/simple;
	bh=ODvNPDXPbqRGOwKsCxS/eQyhK7MR13UIl50VhTrjNVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=svJWuLkPiicCLAkaQSr+xmypYjlschekXSJ479E6SX41veaiPHC34rrRcXfmxV2pilJwQjz/3alzOxhd3ghZsOf5o35lCcNLYkhofkysP59OUungLaAIsGhdY8OvQutOPJWjNJislHt1p/WtG9ZQgQQ5QGdOSf5nCE0WzHknqtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klw9tZhC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klw9tZhC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785395814; x=1816931814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ODvNPDXPbqRGOwKsCxS/eQyhK7MR13UIl50VhTrjNVE=;
  b=klw9tZhCpd6Zegc4ONugtnXi3B/uqHwOIgEr6nsbNZyebrrmC71giwSu
   OoPsYgQheRtuZtiw9P9k/1vUaxae+qg+rMG4+B3kc9fyU9vtBV2aI4HJz
   6Su16Cr33ILbEtSPEcanoBOiOzekljwMNHmg3KzPBe8PmDUc+B+Ws4TgU
   orivWnAkLGqWyIXR5AjytZWkFg5oOaI0Vj4fFqrz87Jrg9dmtoSRVr/Y8
   jgPLk6IPNIZYvQnrnOXDBt9/i0Q6Xdt1kgSXNinKYPBK91dxDUF+Ad80P
   7DwPOC1HKovwPqi39ZLYKNpq7gJWsJfi7+oC8ot1k8OTs7xqe/Gn4njji
   A==;
X-CSE-ConnectionGUID: eolsHneETrGxOiRXHG3gAA==
X-CSE-MsgGUID: 69iI6DxnQUqnEQtreA0WwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="88546918"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="88546918"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 00:16:49 -0700
X-CSE-ConnectionGUID: Y2ONOE0NRvW8ihzQKpqeBg==
X-CSE-MsgGUID: wzf+6X9TSCW2ql+imd9lfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="259643993"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.79])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 00:16:48 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: SOF: topology: Use acpi mach from the machine driver
Date: Thu, 30 Jul 2026 10:17:24 +0300
Message-ID: <20260730071724.22296-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bard Liao <yung-chuan.liao@linux.intel.com>

The parameters may be changed by the sof_sdw machine driver is the
SOC_SDW_PCH_DMIC quirk is set. Use the mach_params from the machine
driver to ensure the sof_sdw_get_tplg_files() function select the right
function topologies.

Fixes: 2fbeff33381c ("ASoC: Intel: add sof_sdw_get_tplg_files ops")
Cc: stable@vger.kernel.org
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/common/sof-function-topology-lib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sof-function-topology-lib.c b/sound/soc/intel/common/sof-function-topology-lib.c
index 2f2c902ef90c..b6e5a40b78cc 100644
--- a/sound/soc/intel/common/sof-function-topology-lib.c
+++ b/sound/soc/intel/common/sof-function-topology-lib.c
@@ -31,7 +31,12 @@ enum tplg_device_id {
 int sof_sdw_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_mach *mach,
 			   const char *prefix, const char ***tplg_files, bool best_effort)
 {
-	struct snd_soc_acpi_mach_params mach_params = mach->mach_params;
+	struct snd_soc_acpi_mach *card_mach = dev_get_platdata(card->dev);
+	/*
+	 * Use the acpi mach from the machine driver because the machine driver
+	 * may change the dmic_num based on the machine driver quirk.
+	 */
+	struct snd_soc_acpi_mach_params mach_params = card_mach->mach_params;
 	struct snd_soc_dai_link *dai_link;
 	const struct firmware *fw;
 	char platform[SOF_INTEL_PLATFORM_NAME_MAX];
-- 
2.55.0

