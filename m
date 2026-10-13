Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020079.outbound.protection.outlook.com [52.101.85.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96452188F;
	Tue, 13 Oct 2026 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912438; cv=fail; b=uRH5Mkff6PuN/DbREIntHL9WPDfw1wj9qpg9+svi47dLVeuN1kTvH1YAifqckGTrI371Ua0AWzPW9sr24m+/bkgFkwpTgxiglV2gPG51hGcN44mXi/1S3T6cC9E8WRB0+tObeiaQwCRd2tC6lLfnmnSrmHs1NuoUPpKxXywqmK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912438; c=relaxed/simple;
	bh=1y0wd/W2NfOrs4mq+cAeapL9MI1x96KgluCE0yvtSX8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FEHJqSowu5zHEL4GbxiiJ+OYXu3SVFErLIPEFZY8RKyFs9pqNmZXzLDRByrJ4ajakRnKjVU/HB5dVlogLP5o4cf9xIiGl0/HBmO/pya0bJJM73Xsmr6IElS0Zca3bsEWm+bp6i5MNXjKFWbAXzK1A0L7Gt6sDcwWcxFWhwJcG0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelburch.net; spf=pass smtp.mailfrom=trailworks.io; dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b=QgUGtn8B; arc=fail smtp.client-ip=52.101.85.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelburch.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailworks.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b="QgUGtn8B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLt7Bgkb0TDE1eiMnWG+0QtYclsuJzdExaGAUtcNesJoH3+W0zm9LALyrjswcf/xGOhRPFabRWXV1DoEFdVBng+dDAz/7E7W21rhoewmtvQjwvf+ph+BaqaqLBGeYQMTtRocYhrAywyxCovYw+OTV4kIU6q0WyzFQCyAx7ZLQvoTzYcqXVwGY7bqPUpm3Crwz/xKXthHG1+Q+lO3NHTlXfvYcqsxOFZ/5SuAJeQ/bUMe9rkx2BUfbxFYUM1H686roZbhmcHpnKVEgwUM8A3MxanaLMgi9K0TjH5J7pKQlKJ/XxuHLh96N8ugiFPduoY+DkgcsWZ+kKZvEe859Hdh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkTTui8T8SGNl+d3MzYwuSVL27k9uo5EoHDSsunN0QM=;
 b=bPs01kH+spwDfiBatlbNljcMakpmYe8fZc+/NfXPo//xK+hPWJ8N9NLCtNeD2oXTymdM6nv+nI0cUtm/EP18jbyyS/niyh+jEIWD1CxDVcbHF0A5xmxZ28xGFs307feMgFY3LOGF4Im9oNsqSPK9eG5jGwm/ay4ETQt3y5C/1n6emgtT+97BGK3oIJPihrw3jBSjDngH91sybkeFNj5FEcHlkjnOFB0NFcL+WtupUS3QTDoQbXbrqoIAzGpFykalkxwD1X2pqIHiMk1Mave4HtpC5tDp30z2DAAs97eWp/Ad0jWMMB6RkPtgPi/x/QIRJBJQxrE/a/jFwnv2jQUD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trailworks.io; dmarc=pass action=none
 header.from=michaelburch.net; dkim=pass header.d=michaelburch.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelburch.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkTTui8T8SGNl+d3MzYwuSVL27k9uo5EoHDSsunN0QM=;
 b=QgUGtn8B9/qVgWd8MGlI5Ofk4SZj74y8HKM57h9sXQmALQZ46CZ1RduhOgqEJO9+nWL2sTHlsVr6FT+afjo6IfuVMr744gBx+qtNt2Ye/yBQoxMOjKzqNwaHjj9WszE9u2xCjGU62KsEIf34ek1cJTlMQHwUo7ljvC87epC5Lqvbs9zTL2iIrxvPs9XuxS9MvkZkHXygkPJp1kDSRGDuG44RcOidQKHcL6xAOZ0UavIPWIge3Ag6hpkUaUBxVgrLsY1MzshGI1JDMqxsjnrLPQW2TVO2Ybd+5pwnFItzoEcQgccCaT+nW/I1uR1kB09K+V7egUZs7AgMjVawvxaR1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=michaelburch.net;
Received: from SA1PR01MB8112.prod.exchangelabs.com (2603:10b6:806:325::5) by
 FT1PR01MB450553.prod.exchangelabs.com (2603:10b6:170:b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 13 Oct 2026 17:27:11 +0000
Received: from SA1PR01MB8112.prod.exchangelabs.com
 ([fe80::1e71:8f1d:29d1:8217]) by SA1PR01MB8112.prod.exchangelabs.com
 ([fe80::1e71:8f1d:29d1:8217%6]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 17:27:11 +0000
From: Michael Burch <me@michaelburch.net>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jun Nie <jun.nie@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/msm/dpu: count the pending frame before kicking it off
Date: Tue, 13 Oct 2026 12:27:00 -0500
Message-ID: <20261013172703.12273-1-me@michaelburch.net>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::14) To SA1PR01MB8112.prod.exchangelabs.com
 (2603:10b6:806:325::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8112:EE_|FT1PR01MB450553:EE_
X-MS-Office365-Filtering-Correlation-Id: 5581f8c1-226b-4b5c-d898-08df294f372d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|5023799004|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KDajDJiShHYiMnufOiZ+LH27HHQ1KtZUdiD3QvSGXqh1mbHZm5+yI+gFa8quswBEWOqEjbvh25oN1jmbH1UnBcL6OUvPzEdz3P+UxETKdxyeQwI+qnvVWE5wUWdstCv69PbbfRRfv0IucmlnTrFOnwHwuRdLFNZKf1e4oMooarpvtepFaTXLzK0zUsl0nwG9zbGEw/UiT7+h4EFtMBUx8HJ2n5hRSOuDgWg8Kj01erSuVvqIrXIerQCyBmYtqzKyH7fqGwBLAYMdEyKAQYwZjHAvcDwFP5Xk7GnudVBKYrdbkAJ4raKj0FNO4UvwFJvyWJ8pmimsYojxqTgZ0bWgxCXOSUJzdAfEQYHYDR6lhE2T4ubi3kTaqhdjhe9JwyYzrKvpq9Q4vtAaGNWnh2BXx9As7ii0L93lGGDiKsfMH1UmuDaxV3WVF1YE1KLGqIvqf9pch/ZsRpQFakqdDMETcHHsauYE3ugi4A8g2MAHMWnDMu+Mob+DJyr5065kplAd7PSjN6ygYpq0iZqAjill1VkUgLVFpunfjdlw72IdD/p7z8X3yoP8aQIMnzoLvfnT5DdisozhxQkAVM+RiIWHRcuK8ZSCUqy+TlfGVAdsqOx/RI7uXUBISxPpAlNrhw+1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8112.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(5023799004)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KblvjW8dzmDApxGaafTta2TM80D/zeWjRSQTKm50012pvJQujOOouygBaF8P?=
 =?us-ascii?Q?8B3ub0vRNJEexRCBYX+ElkA13jGq5n8hdT1WiGznN3rjb4E2ctMZjYet5BQ4?=
 =?us-ascii?Q?M+xqhSkSviL0mktedWAC0y4aUXH1rAudDVGOmP/BYpG1IlJooeYJQcOO8Rkf?=
 =?us-ascii?Q?g7xIxC7KNjT9mG3dLjW8JO1EGatE8vIpvBr0KvKMmRdorBmW94NzsG9SKK+1?=
 =?us-ascii?Q?975YnqTICaT1i9b3CwvAfWXOGQyVZ8a5h3489x3Xbw3FV9zl/4h8EAO0lXs/?=
 =?us-ascii?Q?RdZ5IpAhBTYhN09BdAuaUaO/1nlyKHFFk4YaJqDAcDAV0M8ZIhb/XI+NiD9q?=
 =?us-ascii?Q?BCsuiLN8JCwPumvJ6P3mkdJyPEpmIWiccop6ytHqOFVy1o2gN1aHJ06KKKzl?=
 =?us-ascii?Q?rKDs1MaJy8Y5rI9ktEq8cRdi/6jibPOOPc68bVft0LvvEQfaqiwCWQXR7Czs?=
 =?us-ascii?Q?ZctTOD/GDcm6GsIHwizWxK5r39+6+2l3N57EDw1sDu+2debSGqNJQMTczkYr?=
 =?us-ascii?Q?flFVsanFDdefGqCnrDjiqWr8u2QnjuyUiAftpuEicJZzCHp2rY3Vi+mMJ+dN?=
 =?us-ascii?Q?TYAO7T96ijwziH66I+34z10DPICNbsRivv8IngkWQPOjpwozaoSnClrJC9gH?=
 =?us-ascii?Q?1FGf9ZbiIdVKv1F9IsDYR26dmmuhRrOeqxLPKVMzLmLowx8HbBmZEaWeAdtw?=
 =?us-ascii?Q?70/qiMwpodaUsIZ9afnmkqNKxG5oyCDR4JAfTmURZdp70g1XXYg0sUm8ZIz7?=
 =?us-ascii?Q?vQBvUmWnqUaowwKGtHhpplfVBBaH6dRHON7IYGB8911re8umevrEcEJ3M0u8?=
 =?us-ascii?Q?u35AIQ9Mfg5EZlRRD/kZHpcWkdzffV6VaOAKMoCTtzLMLnwsdH0wLNBfemXy?=
 =?us-ascii?Q?wgdoCBcrLk9M2k0Aa5lvXkrFdKEPkrW1z3rhuhViitFUAwYkGLnYjMZJmte2?=
 =?us-ascii?Q?anQ1qtOsrqO9BCudgK7C2sRN6ezRU0yo+8Kyr/PWlpaBgL3gSTcUwBsjU9es?=
 =?us-ascii?Q?Pky51AJZb1Q7OyQxDWUqVFA0IB39BRaRsVtBUI59jZPDctVvM+bU6JVnwp66?=
 =?us-ascii?Q?+F1yMhJ6a0dCSb3ALc2olKvXoH+7AC/c1T9NqupVjl2jXqwwYcUGp3ojerlB?=
 =?us-ascii?Q?aY4ETlNePaLVCnZFpUhAEIoSuyr1KJOb+b42FqR2dv/ATER0zFEedoIsDhLh?=
 =?us-ascii?Q?zxQigi4AcsGlmZNKmQK5t2DT+CLdbFWfsmzfmmSLzLdEzudYW0xbYV0n6Y1G?=
 =?us-ascii?Q?O8zff4KF3APimy1CzhSW83SQYIBehlgo1oY2huI335oN/Znh8q/MyL1Qia/d?=
 =?us-ascii?Q?qBAx6VfYjt0dypPgPPNLD0OaljljdrK0mRyLGRRUntOxo+7V5kZ8I90/1DOc?=
 =?us-ascii?Q?/BQQBgRT1XLi5/es9e/pC1uP1u5aC+mgDlq6JEKiHtBxRDsBprUG2nlCng6H?=
 =?us-ascii?Q?tQqx2Vlrw3rQBCzFzo/FNtUFFBsF5PTpTCYgMKXLOjpAuM1bHE0WIln7Q6Hd?=
 =?us-ascii?Q?0bX5kCHv9yIFB4Nx7iT6OAiqBCoAIr0iFe9g1eRTrc30u8r19TEdTfxvxs7T?=
 =?us-ascii?Q?0MtuDP2eppOOK1N+13TuOjaOIWeC56XlgimlKtt/rcQslSZhr+gBxMrxE99y?=
 =?us-ascii?Q?X+GAvQ7BpH2CpDOkmCDgcmSOqPlMRysUOF7SfuadPIlqz6XbnrmTq1O+EsO3?=
 =?us-ascii?Q?VkGZAA52Ixgq+4jimEwJH9z61xTt3chBz/TdFlpVusFT7je6CLYvAyzKxVmk?=
 =?us-ascii?Q?RTtnKYCXGQ=3D=3D?=
X-OriginatorOrg: michaelburch.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5581f8c1-226b-4b5c-d898-08df294f372d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8112.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 17:27:11.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8256b244-08e6-4df2-b146-877069d9ce10
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBbZOp1navMXkHpRX/UKYu0qzj67dmaZyQmeEvRKGbb0Cu3NBqsBZgGQDfNf3KG+eLRESrYHMgCQO16NtucTNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR01MB450553

dpu_crtc_commit_kickoff() increments frame_pending only after
dpu_encoder_kickoff() has sent the frame to the hardware. If the frame
completes before the increment, dpu_crtc_frame_event_work() sees
frame_pending == 0 and ignores the frame-done event. The increment that
follows is never matched, so the count stays one too high until
dpu_crtc_disable() resets it.

With frame_pending stuck at 1 or more:

- dpu_encoder_resource_control(FRAME_DONE) sees a pending count above 1
  on every frame and never queues delayed_off_work. A video-mode encoder
  therefore never reaches ENTER_IDLE and keeps its vsync interrupt
  registered for as long as the display is on.
- dpu_crtc_frame_event_work() never sees the count drop to zero, so
  dpu_core_perf_crtc_release_bw() is never called.

On an X1E80100 laptop with a 120 Hz eDP panel this left the vsync
interrupt firing 120 times a second on an idle desktop: 14,407 vblank
callbacks against 21 commits in 120 s, with no vblank events requested
by userspace. Every frame-done took the frame_event_more_pending path
(591 of 591 in one trace) and the encoder never entered idle. After a
suspend cycle reset the count, the same desktop showed 3 commits, 3
frame_event_done, 3 encoder idle transitions and 25 MDSS interrupts in
60 s.

Until commit ad06972d5365 ("drm/msm/dpu: Reorder encoder kickoff for
CWB") the increment came before the kickoff. Move it back: count the
frame in each kickoff path just before its encoders are kicked off. A
clone-mode commit that fails its encoder lookup is then never counted.

Fixes: ad06972d5365 ("drm/msm/dpu: Reorder encoder kickoff for CWB")
Cc: stable@vger.kernel.org
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Michael Burch <me@michaelburch.net>
---
Changes in v2:
- Count the frame inside each kickoff path, after the clone-mode encoder
  lookup, so the clone-mode error path has nothing to undo. v1 counted
  first and undid it with atomic_dec() on that path; if a frame-done
  dropped the count to 1 in between, that atomic_dec() took it to 0
  without calling dpu_core_perf_crtc_release_bw() (Sashiko review).
- Link to v1: https://lore.kernel.org/r/20261013145007.13111-1-me@michaelburch.net

Tested on a Dell XPS 13 9345 (X1E80100, 120 Hz eDP, video mode). v1 on
v7.3-rc6 based kernels: the count no longer leaks in normal use. A 120 s
trace 50 minutes after boot showed 22 commits, 22 frame_event_done and
22 encoder idle transitions. About 2 hours after boot there were 27,479
vblanks against 16,693 commits over 6,040 s, where a leaked count gives
about 725,000. v2 on a v7.3-rc7 based kernel: a 60 s trace under load
showed 5,648 commits, 5,649 frame_event_done and no
frame_event_more_pending. Not tested: clone mode or writeback, which
this machine does not have.

Jun Nie's "drm/msm/dpu: delete timeout timer when encoder is not busy"
[1] hits the same window: the frame-done interrupt arriving before
dpu_crtc_commit_kickoff() gets past dpu_encoder_kickoff().

[1] https://lore.kernel.org/r/20260903143004.1026181-1-jun.nie@linaro.org

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 42d0a529b4d5..81282a8a5d9d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1037,6 +1037,19 @@ static int _dpu_crtc_wait_for_frame_done(struct drm_crtc *crtc)
 	return rc;
 }
 
+/* Must precede the kickoff: the frame-done can be handled before it returns. */
+static void dpu_crtc_count_pending_frame(struct drm_crtc *crtc)
+{
+	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
+
+	if (atomic_inc_return(&dpu_crtc->frame_pending) == 1) {
+		/* acquire bandwidth and other resources */
+		DRM_DEBUG_ATOMIC("crtc%d first commit\n", crtc->base.id);
+	} else {
+		DRM_DEBUG_ATOMIC("crtc%d commit\n", crtc->base.id);
+	}
+}
+
 static int dpu_crtc_kickoff_clone_mode(struct drm_crtc *crtc)
 {
 	struct drm_encoder *encoder;
@@ -1062,6 +1075,8 @@ static int dpu_crtc_kickoff_clone_mode(struct drm_crtc *crtc)
 
 	dpu_vbif_clear_errors(dpu_kms);
 
+	dpu_crtc_count_pending_frame(crtc);
+
 	/*
 	 * Kickoff real time encoder last as it's the encoder that
 	 * will do the flush
@@ -1119,6 +1134,8 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
 
 		dpu_vbif_clear_errors(dpu_kms);
 
+		dpu_crtc_count_pending_frame(crtc);
+
 		drm_for_each_encoder_mask(encoder, crtc->dev,
 				crtc->state->encoder_mask) {
 			dpu_encoder_kickoff(encoder);
@@ -1126,12 +1143,6 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
 		}
 	}
 
-	if (atomic_inc_return(&dpu_crtc->frame_pending) == 1) {
-		/* acquire bandwidth and other resources */
-		DRM_DEBUG_ATOMIC("crtc%d first commit\n", crtc->base.id);
-	} else
-		DRM_DEBUG_ATOMIC("crtc%d commit\n", crtc->base.id);
-
 	dpu_crtc->play_count++;
 
 	reinit_completion(&dpu_crtc->frame_done_comp);

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.56.0

