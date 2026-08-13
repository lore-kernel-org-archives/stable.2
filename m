Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30A361969;
	Thu, 13 Aug 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608512; cv=none; b=KLbsRVRz2fpMM10TBzPe5x6gashDwCm503nPJUgzSr2z/bRwlX9q9eStISmvjpRBRR1Zyh1TtTVecpmrI15m60r+S0rKOkxnKizS3Lz7YPs8BP4+jF09nP+L3IlEkdk3P9Uu8FHc+zbvCOv7AWCZv5j8nJsCKQ+j+7S9/+6ezRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608512; c=relaxed/simple;
	bh=mOjN1h7Hvv5Aq1B3Rx7ce8Xot0YMxaw6JMizvfcm3mM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HeP2KnUODd8ucjU2GOJGyapoMlnF2wDr1572CIaBgpZAhXYTBA+3AvsHyL/jFeBJ+jJYqcMQfEsVj62+sVLnDyV6oulyf/WvGbIucQ7h9u+sRQVkOSUsgrrG/OjCIgBfyP03apxX0w+zcMFMRfQ4Ucuxtm9VBfcUqAsnEy5Lu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1zjcoee; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1zjcoee"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C2C6C19425;
	Thu, 13 Aug 2026 08:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786608511;
	bh=mOjN1h7Hvv5Aq1B3Rx7ce8Xot0YMxaw6JMizvfcm3mM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=s1zjcoeeJ5MQGuufduczXBSHPYJuC8BWjPZcnXT1d4I0WmwTILmZlP31fWiFfbTRb
	 JwPZ1IOG8PIkXCf59KtLgcqJJyo11SvNRyh8/7T+gcPTd2EB0E8X1Gj5yj2jx3ynNl
	 BIcbeop3iPZiAd3Ekel3CfMIpOAyo/ChGKAfd9rHP0u0Va6RAFA4fBsHNYwdoDgPPT
	 Y9cO2utzBh+XS7y++ZVSUYeB9JsIzVFpUXrrffghwKkrOEVN4zuVazCVUWgmF3aR1E
	 28ssP8l8pucnY3FrFS6a0FKM7SLyjn/cF6lwkpXgh344R8TJeDeeI8xx/0k5PTuyHG
	 p9qm+J0Lgw8uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58316C5AC67;
	Thu, 13 Aug 2026 08:08:31 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Thu, 13 Aug 2026 16:08:24 +0800
Subject: [PATCH v2] coresight: configfs: print the address parameter with
 %pK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-coresight-fixes-v2-1-096163d321db@outlook.com>
X-B4-Tracking: v=1; b=H4sIAHd7fWoC/3WNzQ6CMBCEX4Xs2Zr+ICIn38NwwLKFjcqatjYa0
 ne3cvf4zeSbWSGgJwzQVSt4TBSIlwJ6V4Gdh2VCQWNh0FI3slVaWPYYaJqjcPTGIE6Dk6MzRrW
 NhmI9PW5FkS594ZlCZP/ZDpL6pf+3khJKHIy7uhqPRtfqzK94Z77tLT+gzzl/ATQ7vXqwAAAA
X-Change-ID: 20260812-coresight-fixes-9af0df331862
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Linu Cherian <lcherian@marvell.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2893;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=39Yh9YwtTx5GJcnsVzhUE55SB3APLptbyhbni9ITWJ4=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrNrquvKfBks9Puc9LWxw27Ntz6+kixvPsWznlHhSW
 ZK9/LaN65KOUhYGMS4GWTFFluMFl75Z+G7R3eKzJRlmDisTyBAGLk4BmIjsIUaGn/vuTet8s/lc
 7uIQVaWI1P4FN1KPzDt4fNuUhOiIj1wmngz//WdvuysQ3Zdx/2dqVJ6t5lzBLTFNZ04kia/ZFH3
 /Se4NZgAwQ1AC
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

The preloaded 'gen_etrig' ETMv4 feature declares its only parameter as
{ .name = "address", .value = (u64)panic }, so on a relocatable kernel
the stored value is the post-KASLR runtime address of panic().

cscfg_param_value_show() prints that value verbatim with "0x%llx", and
CONFIGFS_ATTR() gives the attribute mode 0644 while every enclosing
directory is 0755. Once configfs is mounted, any local user reading
cs-syscfg/features/gen_etrig/params/address/value can recover the kernel
text base; neither kptr_restrict nor a capability check applies on that
path, and the plain u64 print bypasses the pointer-formatting
protections. The parameter exists even without trace hardware, since
cscfg_init() calls cscfg_preload() unconditionally and
coresight-cfg-pstop.o is linked into the core coresight module.

Print a parameter named "address" with "%pK" instead, letting
kptr_restrict decide what an unprivileged reader gets. Parameters holding
plain numbers, such as the strobing 'window' and 'period' counts, keep
the "0x%llx" format.

Fixes: 4b7e62627a38 ("coresight: config: Add preloaded configuration")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Suggested-by: Leo Yan <leo.yan@arm.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Changes in v2:
- Print a parameter named "address" with "%pK" in cscfg_param_value_show()
  instead of giving it a 0600 'value' attribute (Leo Yan).
- Link to v1: https://lore.kernel.org/r/20260812-coresight-fixes-v1-1-53fbf4e73241@outlook.com
---
 drivers/hwtracing/coresight/coresight-syscfg-configfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index 2b40e556be87..e084ed0b106b 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -281,7 +281,14 @@ static ssize_t cscfg_param_value_show(struct config_item *item, char *page)
 {
 	struct cscfg_fs_param *param_item = container_of(to_config_group(item),
 							 struct cscfg_fs_param, group);
-	u64 value = param_item->feat_desc->params_desc[param_item->param_idx].value;
+	struct cscfg_parameter_desc *param_desc =
+		&param_item->feat_desc->params_desc[param_item->param_idx];
+	u64 value = param_desc->value;
+
+	/* The kernel address should print with the "%pK" specifier */
+	if (!strcmp(param_desc->name, "address"))
+		return scnprintf(page, PAGE_SIZE, "0x%pK\n",
+				 (void *)(unsigned long)value);
 
 	return scnprintf(page, PAGE_SIZE, "0x%llx\n", value);
 }

---
base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
change-id: 20260812-coresight-fixes-9af0df331862

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


