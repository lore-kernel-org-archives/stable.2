Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048457;
	b=PgNrEZ+bu93te/GaEnsB616YiRNbk7WB9f9z35DgFhBhHIystQj8k2Hb4j5kiOdQejVA
	 1O/mBbsA7ljNtJdNU3lB33aT9U0B7jataGEFgyaSYuE0YkBz8pdeu9+fgrrebCeB5yZDD
	 +oJih2o9EfTmfpH6OJpgsR9t4QijhElmWIgiLEl7SrID2k1J2/9Fos91RgNw1A4LzDne4
	 UX4KHJC+YwtZIxeIypFoE7UKaUR2suibN4JC4lxLEAS8YQJ8iisH5Zvle2uSwuDutky09
	 SYFU7qqG1OV5bv0cYLbh+Pliv9YOIY/N6BUIiT2fXl146nEKAThVj2XEDXuJB4OUCnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048457;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7x497PJt6xbT/uXpMZVCrt4Rel0Ml87v5iqoN3y0he8=;
	b=foqYjs7hNoJ9Z343KCY+R9JgPSZaOkAVeo7jw3+juY0QqCpu1MQAe+RtdOYcx2Ysbf7f
	 nkV6hUM28FAvSZrBtiWsS1AoOyVLyCPawKO1Uz84QkBomdCfuDjpSuYTxoN07mR8lkRrZ
	 ITPyIGt8V8kDajNcA2w4cAxaMV4oqOiyu/uZWqPhm1zslvx5OBYlTPuvC6LPK83G+B1Qx
	 ix/SxVu9VodZisa3vVxrfgCPX3QK+pwSC61JRsk/4Th7QW1giKWEXFm71spEiCleT9OBr
	 wt8xCafsnLIyxFWtSRbf7V/rzPG4cumOkCqFwExMPVQ4ePn7D1YO+hSvBWMenRBlX3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFd9qaMN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66942606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFd9qaMN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837391F008A1;
	Sat,  7 Nov 2026 10:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048456;
	bh=7x497PJt6xbT/uXpMZVCrt4Rel0Ml87v5iqoN3y0he8=;
	h=From:To:Cc:Subject:Date;
	b=UFd9qaMNmTSlxD3D50Xx8T5RSyj9MgM96AEh7cg4oL5t3slZvKnL6KKarnJhVsH6m
	 euAHnJsJk4ScyXUgOwc+OGDMe1mzWW5NBUfsGygDNME8R6BiIfyfWyavSpjmhCYJUb
	 mk+Swg8yF+vPr9SGZliKdERLJYBySZlBrOn6innxzv1NU/n5kxysdMoMnj+bcr5BKf
	 uqb75LXXMuu3mqWCVJh3ef7Z6md428xttbtr36lr0Yctd3oUWDq8tDF8AoC7TTGGBL
	 PBmKt/TBGSkYIQFZOGI/plPctvGr7ITu1cm1rBQMw15nZnixDvKIc/yyo364S5CPBK
	 YuF9qIvjxHDkw==
From: Sasha Levin <sashal@kernel.org>
To: ciro.pedrini@gmail.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:35 -0500
Message-ID: <20261107054735-failed-6.1-d35a1ea827a2@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d35a1ea827a2efaea7fb059ffafefae7c13b9556
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054735-failed-6.1-d35a1ea827a2@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d35a1ea827a2efaea7fb059ffafefae7c13b9556 Mon Sep 17 00:00:00 2001
From: Ciro Pedrini <ciro.pedrini@gmail.com>
Date: Fri, 25 Sep 2026 17:52:26 -0300
Subject: [PATCH] platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile
 support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 64d0ea8de32e6..a2afa86f2fe49 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -207,7 +207,7 @@ static const char * const omen_thermal_profile_boards[] = {
 	"886B", "886C", "88C8", "88CB", "88D1", "88D2", "88F4", "88F5", "88F6",
 	"88F7", "88FD", "88FE", "88FF",
 	"8900", "8901", "8902", "8912", "8917", "8918", "8949", "894A", "89EB",
-	"8A15", "8A18", "8A42", "8A43",
+	"8A15", "8A17", "8A18", "8A42", "8A43",
 	"8BAD",
 	"8C58",
 	"8E41",
@@ -227,7 +227,7 @@ static const char * const omen_thermal_profile_force_v0_boards[] = {
  * "balanced" when reaching zero.
  */
 static const char * const omen_timed_thermal_profile_boards[] = {
-	"8A15", "8A42",
+	"8A15", "8A17", "8A42",
 	"8BAD",
 };
 
-- 
2.53.0




