Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D28B368957
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785586052; cv=none; b=nfX20Wzard2Vvx+HFYjF3buxVpswQYJ+rpjCRJUF6zy6QTvUQSAxKo/nR9oWfADy0twU1Ml/NQnQwlLyIJ++qFc76FBOJw67cCTKDNFwBSXniaUv/59N28SwFvmKUK6GeVJauU3P4sQJ4hYA/mB3Uo81Hp/pMKTSTzxK1FOp1ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785586052; c=relaxed/simple;
	bh=ljFHEB+Rg0VYmJdSlVYBV343MDalIHgaWH8QwbTa0Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eO19nV89AWChI66xfoIBbsxbpQ3HmXokTK+071rLo2VZXcn6w9yoOE+xycheB9cYJtr8i5mudBOvJklg3RElBvojoKo+6hFVV6Wxv9MB1W/I64KK2bGfUASeflwQNrq56vmJlycmRCgGaDoRSZyRmtfdD/ymrSKHOTNK50eyozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaHyXTIr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaHyXTIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97F61F00ACA;
	Sat,  1 Aug 2026 12:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785586051;
	bh=NoqWupkuDXYKgFXZS/YklMtqvArvQMNElFXNR9hss4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kaHyXTIr7LgCzVt3Y9fExpqTxez0PpZsz+wkm79qrYWin3yP8HcfSuwhXwSpWeHDN
	 Ycy2E9pMNr4I9ZCvUqD6lC2RbAYe4r1/CgbOnGbZy93v1wQRolwCxfScGn/JDxAkYJ
	 MLzOBjMIIBZVtMbv4mfJxc2UELM+IcdfEMaR2uZ0rD8rbeglpBHe5eyA7udIUic4OH
	 gqhpCMC+csTHy6sk4dAn06gSPJiavWjWt39MbevUC1cHt7PhT1vGUbJACF9XfGkHuG
	 luVlHinDNx6OIfFWVwaU+Kl0HOlH5GOnvr/SJapeRy7mbx+iq/z8oVyT8wXrfLLmZG
	 5wNVwOJgJK9nQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] drm/xe/rtp: Drop rule matching cases from rtp_to_sr_cases and rtp_cases
Date: Sat,  1 Aug 2026 08:07:27 -0400
Message-ID: <20260801120729.2791117-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072914-overstep-liable-afcd@gregkh>
References: <2026072914-overstep-liable-afcd@gregkh>
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
index 36a3b5420fef..c4727fc3ce57 100644
--- a/drivers/gpu/drm/xe/tests/xe_rtp_test.c
+++ b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
@@ -99,80 +99,6 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
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
@@ -400,33 +326,15 @@ static const struct rtp_test_case rtp_cases[] = {
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
@@ -434,33 +342,15 @@ static const struct rtp_test_case rtp_cases[] = {
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

