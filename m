Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2863750D7
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785586049; cv=none; b=fEttbLEbO0tboEZpfz62bJFv5UD18AmRwNSui0iVFt5t3bQkGEhKbKHS5bROAUdHLRn5YA5UO7x9Ge95DEMgP7QXoSa2IoZL8b6Ue2PmiHtk+5BWlV9r+TPO4U/D76MHOYkX0sP6NW9uORq4X87lSnjo07UlBkl7qdpe0lEzRI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785586049; c=relaxed/simple;
	bh=z5PbWyWrQNHdmn6cgd6U/YdSz0hyeT/UgePkgueyQ/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9WjVEuW5xJD7zIKI5PDAfUkFjEmJjiLeJt/DmRbPwNKWEkaTjLwhpMOp9zwjAbtz0RJIflPoNDlPV+0xdu+RH300AEK59g+h4cHHLls9jBQcyIbJgcMK948E8odohOpbLgz8478gzsCR/ZGq/5f8Sjmy4CatQs2zsytro5kwxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv8/vSlt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv8/vSlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F101F00ACA;
	Sat,  1 Aug 2026 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785586047;
	bh=HLlW/J7PFb2d7/fqFdwSRrP5FJh63cyHQwDjGSARZzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jv8/vSltFHqezw8poi4YW6+H2VCsZf2rrCWD/aE3BpOAmx41EF93V9OWRb6r7M4kE
	 50XyDQ5CxO7s5tT/toAdqJwHzLP9JJSVctze32uyfThlRRzYOANJgbBbE4nP+mt1zC
	 huXZ9+v4AqunEU4lvzlAgO1CT9d1ntYZvcN9XsR7ZCqUamaqid1jr3KCtd2ljpumlX
	 SXbeKZ6GBAnlKuKeIKIahJXpf9AmrbyNgDomZi9YF1wTVhu2zx+TWdCiolPyIPwMof
	 NZwce3bE3y8Hz0jNufYlNUxwK8sNYTHP7piloSdmRLc7zMjfbjfblmnLcvXpIQbvJ0
	 ALd/rBeP3apJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] drm/xe/rtp: Drop rule matching cases from rtp_to_sr_cases and rtp_cases
Date: Sat,  1 Aug 2026 08:07:21 -0400
Message-ID: <20260801120724.2790990-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801120724.2790990-1-sashal@kernel.org>
References: <2026072935-vicinity-override-18e2@gregkh>
 <20260801120724.2790990-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gustavo Sousa <gustavo.sousa@intel.com>

[ Upstream commit ff7746336b2325087aa7958d40f327bcc50185f8 ]

The kunit test cases for the RTP framework are currently separated into
three groups:

(1) rtp_rules_cases:
    Those to verify rule matching logic.

(2) rtp_to_sr_cases:
    Those to verify generation of save/restore tables from RTP tables.

(3) rtp_cases
    Those to verify processing of RTP tables without save/restore action
    associated, which are used for OOB workarounds.

Today we have some cases in (2) and (3) that are actually meant to
verify rule matching logic.  Now that we have (1), let's cleanup (2)
and (3) so that they become focused on their main objectives.

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patch.msgid.link/20260522-rtp-rule-parser-v3-2-0c51039899f4@intel.com
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
Stable-dep-of: 4fe2844b0f0c ("drm/xe/rtp: Generalize whitelist_apply_to_hwe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/tests/xe_rtp_test.c | 122 ++-----------------------
 1 file changed, 6 insertions(+), 116 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_rtp_test.c b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
index 28b21815e5ab..e0972d42f96c 100644
--- a/drivers/gpu/drm/xe/tests/xe_rtp_test.c
+++ b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
@@ -122,80 +122,6 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			{}
 		},
 	},
-	{
-		.name = "match-or",
-		.expected_reg = REGULAR_REG1,
-		.expected_set_bits = REG_BIT(0) | REG_BIT(1) | REG_BIT(2),
-		.expected_clr_bits = REG_BIT(0) | REG_BIT(1) | REG_BIT(2),
-		.expected_active = BIT(0) | BIT(1) | BIT(2),
-		.expected_count_sr_entries = 1,
-		.entries = (const struct xe_rtp_entry_sr[]) {
-			{ XE_RTP_NAME("first"),
-			  XE_RTP_RULES(FUNC(match_yes), OR, FUNC(match_no)),
-			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
-			},
-			{ XE_RTP_NAME("middle"),
-			  XE_RTP_RULES(FUNC(match_no), FUNC(match_no), OR,
-				       FUNC(match_yes), OR,
-				       FUNC(match_no)),
-			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(1)))
-			},
-			{ XE_RTP_NAME("last"),
-			  XE_RTP_RULES(FUNC(match_no), OR, FUNC(match_yes)),
-			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(2)))
-			},
-			{ XE_RTP_NAME("no-match"),
-			  XE_RTP_RULES(FUNC(match_no), OR, FUNC(match_no)),
-			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(3)))
-			},
-			{}
-		},
-	},
-	{
-		.name = "match-or-xfail",
-		.expected_reg = REGULAR_REG1,
-		.expected_count_sr_entries = 0,
-		.entries = (const struct xe_rtp_entry_sr[]) {
-			{ XE_RTP_NAME("leading-or"),
-			  XE_RTP_RULES(OR, FUNC(match_yes)),
-			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
-			},
-			{ XE_RTP_NAME("trailing-or"),
-			  /*
-			   * First condition is match_no, otherwise the failure
-			   * wouldn't really trigger as RTP stops processing as
-			   * soon as it has a matching set of rules
-			   */
-			  XE_RTP_RULES(FUNC(match_no), OR),
-			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(1)))
-			},
-			{ XE_RTP_NAME("no-or-or-yes"),
-			  XE_RTP_RULES(FUNC(match_no), OR, OR, FUNC(match_yes)),
-			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(2)))
-			},
-			{}
-		},
-	},
-	{
-		.name = "no-match-no-add-multiple-rules",
-		.expected_reg = REGULAR_REG1,
-		.expected_set_bits = REG_BIT(0),
-		.expected_clr_bits = REG_BIT(0),
-		.expected_active = BIT(0),
-		.expected_count_sr_entries = 1,
-		/* Don't coalesce second entry due to one of the rules */
-		.entries = (const struct xe_rtp_entry_sr[]) {
-			{ XE_RTP_NAME("basic-1"),
-			  XE_RTP_RULES(FUNC(match_yes)),
-			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
-			},
-			{ XE_RTP_NAME("basic-2"),
-			  XE_RTP_RULES(FUNC(match_yes), FUNC(match_no)),
-			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(1)))
-			},
-			{}
-		},
-	},
 	{
 		.name = "two-regs-two-entries",
 		.expected_reg = REGULAR_REG1,
@@ -455,33 +381,15 @@ static const struct rtp_test_case rtp_cases[] = {
 		},
 	},
 	{
-		.name = "inactive-1st_or_active-inactive",
+		.name = "inactive-active-inactive",
 		.expected_active = BIT(1),
 		.entries = (const struct xe_rtp_entry[]) {
 			{ XE_RTP_NAME("r1"),
 			  XE_RTP_RULES(FUNC(match_no)),
 			},
-			{ XE_RTP_NAME("r2_or_conditions"),
-			  XE_RTP_RULES(FUNC(match_yes), OR,
-				       FUNC(match_no), OR,
-				       FUNC(match_no)) },
-			{ XE_RTP_NAME("r3"),
-			  XE_RTP_RULES(FUNC(match_no)),
-			},
-			{}
-		},
-	},
-	{
-		.name = "inactive-2nd_or_active-inactive",
-		.expected_active = BIT(1),
-		.entries = (const struct xe_rtp_entry[]) {
-			{ XE_RTP_NAME("r1"),
-			  XE_RTP_RULES(FUNC(match_no)),
+			{ XE_RTP_NAME("r2"),
+			  XE_RTP_RULES(FUNC(match_yes)),
 			},
-			{ XE_RTP_NAME("r2_or_conditions"),
-			  XE_RTP_RULES(FUNC(match_no), OR,
-				       FUNC(match_yes), OR,
-				       FUNC(match_no)) },
 			{ XE_RTP_NAME("r3"),
 			  XE_RTP_RULES(FUNC(match_no)),
 			},
@@ -489,33 +397,15 @@ static const struct rtp_test_case rtp_cases[] = {
 		},
 	},
 	{
-		.name = "inactive-last_or_active-inactive",
-		.expected_active = BIT(1),
+		.name = "inactive-inactive-inactive",
+		.expected_active = 0,
 		.entries = (const struct xe_rtp_entry[]) {
 			{ XE_RTP_NAME("r1"),
 			  XE_RTP_RULES(FUNC(match_no)),
 			},
-			{ XE_RTP_NAME("r2_or_conditions"),
-			  XE_RTP_RULES(FUNC(match_no), OR,
-				       FUNC(match_no), OR,
-				       FUNC(match_yes)) },
-			{ XE_RTP_NAME("r3"),
-			  XE_RTP_RULES(FUNC(match_no)),
-			},
-			{}
-		},
-	},
-	{
-		.name = "inactive-no_or_active-inactive",
-		.expected_active = 0,
-		.entries = (const struct xe_rtp_entry[]) {
-			{ XE_RTP_NAME("r1"),
+			{ XE_RTP_NAME("r2"),
 			  XE_RTP_RULES(FUNC(match_no)),
 			},
-			{ XE_RTP_NAME("r2_or_conditions"),
-			  XE_RTP_RULES(FUNC(match_no), OR,
-				       FUNC(match_no), OR,
-				       FUNC(match_no)) },
 			{ XE_RTP_NAME("r3"),
 			  XE_RTP_RULES(FUNC(match_no)),
 			},
-- 
2.53.0

