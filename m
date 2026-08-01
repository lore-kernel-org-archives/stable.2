Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3439B975
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785553419; cv=none; b=Kin2Kq9GJUQcoc1OCznFIDS6WrEY/Bw8mQvX1FvbEhAIDmsRQJhlRdkk80HOwOxNlaiv2tm/1tKJ0R7zpyM0KrovV9m0xernLZh/MI4TpRCRylU04ONPwR+7iNn1fOLO1ux8sNiRGu1s6iFfRwAEjrPeshWJsXqSfXx5hBkYmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785553419; c=relaxed/simple;
	bh=KAwsaBtICuxVLE9FhEgEKCCZyjdlQ1PMZ5OxmtlnpuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqEIXVLhN9kWpYe9KutCxVVJQmh3wIDV8Xex0mJhA3smnNjBesLynN3JBDEd1I/5nZt+kbrsoo6f85jKRfvdQksQxvSCuQt1kIR74wkFXaAfnpeKqtnDivTOV1cMQFb2PNszqtNSPURPD5XAaIoEByDneY0Ynd750F2+8zgODv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgQVJdcp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgQVJdcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A791F00AC4;
	Sat,  1 Aug 2026 03:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785553417;
	bh=3q4INWf7ZQPo4fg3N3MOku+wUpJJZNQejz2uhuguR5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EgQVJdcpFnn93AHt4UKAzzNhw/B/09KhoRfmINS+G9P1Q/Vgxrr9iPCYuwdtONusR
	 8JHuVnWQcltFSeWkHHJRHNJDwpnF1ym5qjyPuD4Xg709/gu5Vp3WDU7yvhjFU0+d46
	 VgcmCyF/zTuyGAG5eNGym89smG2MeWw8omrc7a96wJ/audS9OmfBoBVpf//kzLHJH3
	 54ygZBN0ie9JEnjv8VUIuy8MBrSJKGzIQjoyiGxDXEGJjh1lNHmptcQL7tyMNsoprY
	 nhecHEQUsEGeg8Bimyc95asMJzzCfWYcn8uuyXZUcSs9Z0XH9HQejeh8N+7ZceJO5K
	 06xfshT+wgDSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/6] drm/xe/rtp: Drop rule matching cases from rtp_to_sr_cases and rtp_cases
Date: Fri, 31 Jul 2026 23:03:28 -0400
Message-ID: <20260801030332.859236-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801030332.859236-1-sashal@kernel.org>
References: <2026072913-snap-snuff-32d6@gregkh>
 <20260801030332.859236-1-sashal@kernel.org>
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
Stable-dep-of: 31e243756162 ("drm/xe/rtp: Maintain OA whitelists separately")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/tests/xe_rtp_test.c | 122 ++-----------------------
 1 file changed, 6 insertions(+), 116 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_rtp_test.c b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
index 8d4bd18a3161..61b75ca0db66 100644
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

