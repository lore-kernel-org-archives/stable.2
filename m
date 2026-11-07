Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046905;
	b=j4BtneddlWOy8EyYjtE8nBfN4Glidd+9tTxNbMjH5+wQR8EeNuBTFw5AFd9y3ESCTpEE
	 RBNTZqw1Q7fM2bromzuGu1BrnTSKOKHo9NBaJ3J4FFzWdb2hmTqRMhdkphWsw8kN16BI4
	 nmXmqVoQgkgO+ZjtdD04Ie7Myi3jvUuM5kcxff67fvtTyPWmTPPl6ri5jfeGvRE6IRRQv
	 5NeWnSyvdF2QKi/VYh9cZBAOeGZrPx3S/Bq51FBYEXEI8rTgNkFXAW9ka28i4ldBS6pgj
	 PuC80cQ6yy8aVHmjyf8Lo2139tUuzoHleAIyJLzmn4cIQZ+d8pxhf4dfo82HA1hcGJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046905;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=j7BSGbLjQKwqfrBa2qHZJMU4JXe6s+7ZwRkekV28gfM=;
	b=W7Yr7YzTenrAGPktSvkZn/bicUBsefdF98SyiBZwUaAnQTc1v4AZd5M8WXY8rwW3wA0Y
	 UY1fcTB11kdC8/ve3L7o1l+Lt0QUBa3wUWgy16Q4gcEEeAhFAouX0D9wenuOUY6Pk3cku
	 lCMbBmRhfH7zdcZrD6NNlw2x0ipkDXXqJNaQ4WKR+37kJ9vg0LNiiYRBDs1ilHLvnS11O
	 u7YEu9+XcEOZZgTTGFw5BlcaDGJB88fcOoEEpKn903Omq0VxV4OjZXsv9lcB9QT4nJwtX
	 ah5pGUxEMBBqr6TXnrDPG1cJ5KiuNRkpH/DoN8okn/f8QU01dEzfLmx5nJr4xyVBejw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuFEUeYu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC1606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuFEUeYu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE051F0089F;
	Sat,  7 Nov 2026 10:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046904;
	bh=j7BSGbLjQKwqfrBa2qHZJMU4JXe6s+7ZwRkekV28gfM=;
	h=From:To:Cc:Subject:Date;
	b=ZuFEUeYufp/sVvyO/52bQK89ue7HkHXMib4kPyQHTjtgzL04j18rEbWo5J9PKgbq5
	 j4KvPJmDMLPFIXxOoxJ2bhZfFntVoRnOSnQF+CWed9Xb/JujQIhGExHitTibNiipQ7
	 FwvEKsqWmHdrWfRfGnr0X5PSZ4cI63FEFZLy3Y0tv7PZ/6xMYTjL/EO2b9jASHXGhT
	 HHXQ0JWoYJ0dEiq31173ntD/NkPU080SyVIHLXB9ZMBfkgSNuF0L0T0uhJDnL48QdP
	 GNzvdLQex9T5lBsRz5ugXRu2QbEe+hy1GTtuKWB52Bgwc6Df2ZGEB6WiJbgUojmOVU
	 rBrNGcfJdehow==
From: Sasha Levin <sashal@kernel.org>
To: ciro.pedrini@gmail.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:43 -0500
Message-ID: <20261107052143-failed-6.12-d35a1ea827a2@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d35a1ea827a2efaea7fb059ffafefae7c13b9556
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052143-failed-6.12-d35a1ea827a2@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




