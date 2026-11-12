Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451851;
	b=NMJczwfAgUdaOr+MwWFZUR69DzM7YJS6WJIx/oKwhHWbHxnINpmgPmJDtihdkgcKJ+u7
	 cTZxQMSrc118kh53kHFuGhE+u2+HMkVZghuuqAo9TRd+yiibHo5IQG72hOujqfqUv9YTy
	 ys2zcfSrDsxB+7RQiHZ0U3GjcYkG5lgkV5lqPam18AbezdI9y1Y/VYCh9hFz7gkfB4Nfy
	 803O/lglTm1CwTzAnbJIiCAtZO3XG95EvUcL7U+gDL0yF6kcAi2cs0sMZGsNbjlCtlbA5
	 jmpLSxiyDWOUUSwqzF1ATH1T9c5hin24NRyUgvuLAfrNiQaSbaJXLGJuPj8wf5kRXlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451851;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DKDMwb4wIfu6h3CGQfYktRVI3o2yEH0uoRDjlv8RlIM=;
	b=08TChVIrjWip+JF0R3PgQFSHAE7wQHxjVc3P1uXc2838VHRpmbyREAD3QiVFQVwqKzsj
	 gHgLAjotnrCuDjWrRxdreKZrCwaqbO8I4Fy/NlhXFQJ0HJUMVdfYWGGhg3DIWmr3AnkU8
	 c5mfqNcie/UUFtr3FafZKh88StW6C1ggUSwWynbEfH5U131ieZUoGQfPC/yWSE7fuqWVC
	 wlxZpwZ82yJrj6dOnhVav8SBHkFbT4jJcfg/6bTiy+qUm/K426M7vyyakOBplrH+1Ct6j
	 WlU+clWR21ikoqM/fDhQIsNx2dI4BSF6hOi/e1g3C/lxJiR6Dx99RJcT/PrDdN91omw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2ll2QR1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A750606A324
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2ll2QR1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CD31F00A06;
	Thu, 12 Nov 2026 02:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451851;
	bh=DKDMwb4wIfu6h3CGQfYktRVI3o2yEH0uoRDjlv8RlIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e2ll2QR1qIe4K2aXiCYQkStA2zKV+fezlLVfxUKyO7R4oweL+fv3/ayVbNBtLImfH
	 xOQI+9xRJqM3gE1y8JzYhhsfNElOREeFfB8eAzAwAFf9vX1LImxWW2PmE6j5BsFbS4
	 eUKu3K/UC15lG2t1msPDU2kG0cO2eyNyC1pZFj0LhyEs/1OhNtTe3tFGiENBN+bAgX
	 ha/o7pCNOUAijZO31qTNkyQvSDw+JukOJISpFStj3COBWuuzli8h0X51ie+fpRbA6E
	 D5hYs1AgHZffo1jvMVF40qHuIUf/6jD5m/2DIb6bLHpWURHeIwtF4mQ34zOueqV0Ci
	 ZPC0v03PvoxgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ciro Pedrini <ciro.pedrini@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support
Date: Wed, 11 Nov 2026 21:50:48 -0500
Message-ID: <20261112025039.1402391-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112025039.1402391-1-sashal@kernel.org>
References: <20261107053407-failed-6.6-d35a1ea827a2@kernel.org>
 <20261112025039.1402391-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ciro Pedrini <ciro.pedrini@gmail.com>

[ Upstream commit d35a1ea827a2efaea7fb059ffafefae7c13b9556 ]

The HP OMEN 17-ck1xxx (board 8A17) isn't in omen_thermal_profile_boards,
so hp-wmi uses the generic thermal profile query. The firmware only
stores that value and never acts on it, so the EC stays in its default
mode and the CPU is held at 45 W whatever profile is selected.

The board uses the OMEN interface (mode byte at EC 0x95, thermal policy
v1) and also needs the timed profile quirk: without it, the EC drops
back to the default mode about two minutes after each profile change.

Add 8A17 to omen_thermal_profile_boards and
omen_timed_thermal_profile_boards.

With this, all three profiles work and sustained package power under
load goes from 45 W to 56-79 W.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ciro Pedrini <ciro.pedrini@gmail.com>
Link: https://patch.msgid.link/20260925205226.883724-1-ciro.pedrini@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index beb96d3851fb3..6ce00d9df6d7d 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -62,7 +62,7 @@ static const char * const omen_thermal_profile_boards[] = {
 	"886B", "886C", "88C8", "88CB", "88D1", "88D2", "88F4", "88F5", "88F6",
 	"88F7", "88FD", "88FE", "88FF",
 	"8900", "8901", "8902", "8912", "8917", "8918", "8949", "894A", "89EB",
-	"8A15", "8A18", "8A42", "8A43",
+	"8A15", "8A17", "8A18", "8A42", "8A43",
 	"8BAD",
 };
 
@@ -80,7 +80,7 @@ static const char * const omen_thermal_profile_force_v0_boards[] = {
  * "balanced" when reaching zero.
  */
 static const char * const omen_timed_thermal_profile_boards[] = {
-	"8A15", "8A42",
+	"8A15", "8A17", "8A42",
 	"8BAD",
 };
 
-- 
2.53.0

