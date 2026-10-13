Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022128.outbound.protection.outlook.com [52.101.48.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CEA3F928E;
	Tue, 13 Oct 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903022; cv=fail; b=TEcu/cAgGm+CMSmDb7ktITVKaNiqk7Hf1vQhBcUy2VVXEYNYvAn06p0ahee3pQEBGMZ1HyFCBZsyboMlGc53EcgAGOZEhVq6mVeJPZSY2fz7uK28w7PLxJU9h1ti2GOUKWWQFFdtMPP6qhMx5mWlZcNm6uUvbUhrINVb5TEyY+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903022; c=relaxed/simple;
	bh=p0/0++l+wLdlsd7XFMQ7YykhCc15hAS9nBeMXp9n/ls=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AqK5jliyPmj9T5sI/xZSvknRPIMmikAdonhoDWY9qweHtLpsz1AzBiNg/85Elj1Ppu99PYiZJdAe0+IszBMRHOJO1MppeHL4/avsO7kQrAft4lk+X//jMFchbhtc8JFqHQxp5v4WqK/+s4t6USrf+p+5gXNt0JLQeivl7WjnM9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelburch.net; spf=pass smtp.mailfrom=trailworks.io; dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b=hmL+YL56; arc=fail smtp.client-ip=52.101.48.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelburch.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailworks.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b="hmL+YL56"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfUTUg5kde3kyb873yvorxlogNIg/6caj8hLYXLn9IzCW+c3HwfyvXjkK5fzzt7HNxHeFF+j4ljUkMN9cDmU5C7xgQE/oom6Lirl9LSZsKp7AQOV87MSqJ4lRGO1uizFSdwCDwqgGc2ufU/cfK5BP4jIwxZN1c/YIiOixxgpsQadOTdkvEd3NPRev9lOHR986BFbcjcom+7pv2NQHWMi0h177U4wOMQKfzkY/ZZF6qnCdvo9beeo/iYf0OppRmn26Zwydg6ME2ysbPeicvLjCCeKkPJVqfx8pOS9PJkBDwnml6aUnZq7lbHCB5jFX5LnVVjwuD3g4e3rqqVx9j2eKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3YOJaupWOy9RmQ2FV/swSECxvVIYPpBKr20Al3VxlQ=;
 b=hYQiQbgkW6ieUbUOOJMj5V/WWcAOm/pCHspShCpbguyp3cR1fzNOTAfvtHCaudxaHocV52jN4GCCjgYfoHzbsPPX4j5LtwupxjIZ6wroc7fcaXq6F4E5rGAYLQEYJkHXjJIj0FnNRuflqQ1YB7XQXjQ7wJH5pvNB//5ASF3KePYvNM5X66nE1phpHKm4T7gfm5Y7huc2EwTvTgtivbj5jCDp/+775SMTbI+RmADD40eXCEdpl+CgCCAGbp+JAsxA4vAg248IqCfedUjVR2eluKziP3hdQyHG0swsoizfE8J6N8o38+ZTweczpw+eujhOKFVuh8czBqLqs72xo3MMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trailworks.io; dmarc=pass action=none
 header.from=michaelburch.net; dkim=pass header.d=michaelburch.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelburch.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3YOJaupWOy9RmQ2FV/swSECxvVIYPpBKr20Al3VxlQ=;
 b=hmL+YL56nIPq2N9K9AnEoCaUi1Tm1BG6es2oWo64YQFI5uWzMSHn4ow63mEljTm71Wbx/EmU/YSBRxwXyXh/Qy9M+U3/NOU7nhbVOkamJrXj8NSmzphZTV+tmAXytrPtDNJE1fZWGW7fhzPzWC8lF1oObxW00lfG9cSQqiAHa3iikK3tksQUc9q47d9O6B927w2rs+Vf6UfQP6194CHnWw9P/dxxxqWC3ZcE1hYeafoB2saWLifOx9l5eKi3cjeSraNvS451FumaM0P2l2BoNt139wclpC2MwMBLcAefb68qwXAnbDTDrhw93wZrgoSUkPy1nsgwpWVhDXvH8Em07Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=michaelburch.net;
Received: from PH7PR01MB8123.prod.exchangelabs.com (2603:10b6:510:2a4::19) by
 DS9PR01MB994429.prod.exchangelabs.com (2603:10b6:8:35d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 13 Oct 2026 14:50:16 +0000
Received: from PH7PR01MB8123.prod.exchangelabs.com
 ([fe80::da98:a31d:73b6:7930]) by PH7PR01MB8123.prod.exchangelabs.com
 ([fe80::da98:a31d:73b6:7930%5]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 14:50:16 +0000
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
Subject: [PATCH] drm/msm/dpu: count the pending frame before kicking it off
Date: Tue, 13 Oct 2026 09:50:05 -0500
Message-ID: <20261013145007.13111-1-me@michaelburch.net>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:806:23::16) To PH7PR01MB8123.prod.exchangelabs.com
 (2603:10b6:510:2a4::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8123:EE_|DS9PR01MB994429:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a950bbc-5b6d-4074-bda5-08df29394b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ksKdorAxvHfo9EplrAQ0eQhUn9yh0IR1nBrXzyD1f0W1fMWgEwuWDCk61eMUO8irxifdOOV6Joe2Gs155cM0fBupcXESECMEDkKBCBLPgjvYCEc3xHoFVAPdr29WEbCoMbD7VKLEIoGFoL7EXzIckkyKdX62wEawDzF3VtlAppfcQzlNR8QWZQVh90nyiMHcY02iAbyLYRfVAqKMTt2kovmjp+qm/pE3tOxcx45nN4/CwqWFrKAMXvgenq8ct9txHISSnA22uPMJnSLPGqWFKqvnq8lqhToKPt8I0dIZKKILOhrm16U72DVps2IaNl33Ol4D/JrWmnELxV7bn8htg0hPGMool3Zpu50b+r5WzFhOwlHS9IWpE+4T47FqAji3O5K1J1pkmPdJmV0aP7dew5+GUGUH7XR457EGGQYwWk2NjIfAiWyBT7h6XDJmcGJ7UteX4GNvy69Lr2vEquYVzuvkD5oDiAho4MDAga0yPu2Zaz2KVT2TDAMht13uNmSkCGqg6VCTadKfN0/LZgInbSuVwd3hlFtVWH4mP44Z3VUk8EynKGmkOmhuUA2eIJF+nQ6C1/Cm3YkUhbJFg1yAJrvyj6kOAgkIxXS8fm/H1XOqpjzbaEcLcgK67trO3kq9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8123.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(18002099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EUB4ktc8/rfatJsU3wCFipURhHLkxjo/9iAxv/20ypWERkMZOh+kcSBGK1pu?=
 =?us-ascii?Q?j+zTFJb8dbeLZE6gi9tQQ1JiNXa6nSeWH0VGzDNiqObB56TXzUt8QIdc3TBa?=
 =?us-ascii?Q?66BossKeivSbf++NUlmgqt7uwCrmFGx4fTlFReutx4PB1FSB7gkzHuZWfEM3?=
 =?us-ascii?Q?W3OJTQTms3S0cHiuF0k/BCOHNKXX2KzcJHGbvE3xzcsQBWjFcqT2ajmaEiEz?=
 =?us-ascii?Q?LMA5dFKlSxbxSGNvjs93gGGyYveF7oihQJ+0Ab/eVUylRMmlOA94pnTLghD1?=
 =?us-ascii?Q?E2l7dGCgs8och9yoszVHhBlECu4Y+44LmSzFOoogOtxz/H7eGZivS+N8XeUT?=
 =?us-ascii?Q?GUf0xRLu/oLhe77xNl6cb5kC/ZMcznfWlLoLOUBbTFRWa0gCUxnt/J2NZD1D?=
 =?us-ascii?Q?pwZRsKEumPqHka47iSfvHF6UCghac+Q5+DrRTDqrZKkeHutw0eVVoUTcybEX?=
 =?us-ascii?Q?T1d4mDCrmRiMfodsWObuU17HFKCnSYcSc60vOJfelj4WrSNbhANJLXbJYYld?=
 =?us-ascii?Q?UhHIHRk+/EBmEpyxKxd1hRh5Gnm4JXEbUdsENsnIFTHz2jnXO2JEi0rfGgnE?=
 =?us-ascii?Q?QDANTejgUV5+LjKC6+GLdLuW/7NhzIyX0S6tHx2lKuRoWkvgp6GXwfURw4yx?=
 =?us-ascii?Q?gsmMkitSNRDI5tBQ0FIGibmGNWw9NJdoA0zM2hoj+flGX1U4xgUoJEtdc6qQ?=
 =?us-ascii?Q?pFKu5mdR4SjVVpKRhx/z+lxy9aU5agiAhGDuUKBfXtF3nRkRJBexBO69STAz?=
 =?us-ascii?Q?2oQY50BzsjNQkJcewhu2pVRsHhE7eiEm5nrKSV5Yx3atNw8pfUfgL5f/vDP9?=
 =?us-ascii?Q?VlP6vE9DiaJMDVBnyAnO1/wIIRMhA4pBF2SClyqKZtqYfwjUOB33p72BxeBo?=
 =?us-ascii?Q?IEvvyiP3dK7dWwu6pgzQqdH0A6HrSAr9YS4a3GwVNRIznFMoxp0lxhuBfOSP?=
 =?us-ascii?Q?oAWQU8tNq+XURAzwrcwyUIK4ksbJ3ZYP3TwcPoqWiEEKFeks2n09x6qyDAtQ?=
 =?us-ascii?Q?CkK0+asILZJzd/5D9WcExqSjv8z7wBAYsT6AQyieyYWePovYXMiyIssQz7b6?=
 =?us-ascii?Q?V+gzgAHDU9fUFCZphRbDrFEgy20A9bPei7Xzl1RfLbn6gMV1m4ZhqoDw3nRX?=
 =?us-ascii?Q?5cBrJF/85i0C8GpFprXOWBRsbSy01047APE5gfnskINpGiy8UJ55nzVtjEO0?=
 =?us-ascii?Q?TrQBgN3smskpwVMl7S0HcANCm3+OLsv1zj20hF6kzUwW6exys8jX27mxrZTU?=
 =?us-ascii?Q?MG3RtFz2fjY/b+xKddOpBbsB54FrtiXOHL5JCJNkUuo3jZF4v9fJ9/sh45T2?=
 =?us-ascii?Q?vsxBH0vdD1Vuz+veUse5nImfUZgfvpO2WOXZzOyJWI0Rm/gbQWgZ6PH0ZkdK?=
 =?us-ascii?Q?B660gpI8VgJTeeLMn4MWgqiZCzqEccbw6bpfv6FiyYQYz+aX9cD/obRjInCg?=
 =?us-ascii?Q?fg2Ht+EIJPLijZ/2Z324KFlAiDX4CkoTlIJ/foqcM7blxM6RTzfJRwoyvV4F?=
 =?us-ascii?Q?/A9XgvnrgqSQLkPq54nUlGX5rgFbYlckkKH8F6b8Mz/DKnpnyDokvRnsD8Zr?=
 =?us-ascii?Q?Bi4dU7G9joJyNS1zImcmApC3fihRnsVUD7f2RJdw2P/+Nx9RsTfvZZLRy5y3?=
 =?us-ascii?Q?bX0tGecry85eaDDZXTqaBXmLesvsTxNdhZi0nKavoMGPkqW8Ve9aG+5TCKRC?=
 =?us-ascii?Q?5ClYxn14fNW62fS26BZ3K8bB8TwOWb76B/8YNrwwArhniarUq9JxqzTvEPmO?=
 =?us-ascii?Q?IybBFWTBrg=3D=3D?=
X-OriginatorOrg: michaelburch.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a950bbc-5b6d-4074-bda5-08df29394b34
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8123.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:50:16.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8256b244-08e6-4df2-b146-877069d9ce10
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVrA6oxlQfzRrVyA8EoOEZFRq4pmc4EZiU0lRm2ddA0YrYmJ37eeWOLeJrUX3QBfoceLTAwzWVSy9wAGWere3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS9PR01MB994429

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
CWB") the increment came before the kickoff. Move it back there, and
undo it if the clone-mode kickoff fails before touching the hardware.

Fixes: ad06972d5365 ("drm/msm/dpu: Reorder encoder kickoff for CWB")
Cc: stable@vger.kernel.org
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Michael Burch <me@michaelburch.net>
---
Tested on a Dell XPS 13 9345 (X1E80100, 120 Hz eDP, video mode) with
v7.3-rc6 based kernels. With this patch the count no longer leaks in
normal use: a 120 s trace 50 minutes after boot showed 22 commits, 22
frame_event_done and 22 encoder idle transitions; about 2 hours after
boot there were 27,479 vblanks against 16,693 commits over 6,040 s,
where a leaked count gives about 725,000. Not tested: clone mode or
writeback, which this machine does not have.

Jun Nie's "drm/msm/dpu: delete timeout timer when encoder is not busy"
[1] hits the same window: the frame-done interrupt arriving before
dpu_crtc_commit_kickoff() gets past dpu_encoder_kickoff().

[1] https://lore.kernel.org/r/20260903143004.1026181-1-jun.nie@linaro.org

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 42d0a529b4d5..c8bd9c305a59 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1105,9 +1105,19 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
 		}
 	}
 
+	/* The frame-done event may be handled before the kickoff below returns. */
+	if (atomic_inc_return(&dpu_crtc->frame_pending) == 1) {
+		/* acquire bandwidth and other resources */
+		DRM_DEBUG_ATOMIC("crtc%d first commit\n", crtc->base.id);
+	} else {
+		DRM_DEBUG_ATOMIC("crtc%d commit\n", crtc->base.id);
+	}
+
 	if (drm_crtc_in_clone_mode(crtc->state)) {
-		if (dpu_crtc_kickoff_clone_mode(crtc))
+		if (dpu_crtc_kickoff_clone_mode(crtc)) {
+			atomic_dec(&dpu_crtc->frame_pending);
 			goto end;
+		}
 	} else {
 		/*
 		 * Encoder will flush/start now, unless it has a tx pending.
@@ -1126,12 +1136,6 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
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

