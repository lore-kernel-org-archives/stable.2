Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450169;
	b=lNYNhu9+7NsH6v8DmGjhJV5ODfTjrfx+0N3g8RQfZJbDYO4HN7lWwzVHgKyWylG9bl+0
	 m4PJp129w/ESvVi5+ZQYcrBX1pv4nYfeVUC5SqR1BSZNW0rcJp/6aForHOpNYLk6OJ7kY
	 hFotBQ/SzcGbObL+d8jbviDCfVSDjTYJBGDIiqcd3eYMcmVOg436GYQBkdNgY1KnJbwQO
	 CBSK8XV6+Hfhc20DXOs8IBtocRK+Z+J9yQUl8K4ZIeVVZhvV7VP0EVdtJNKX+8BaKABfn
	 2s/ff+ECBJwidi48ZFeke+RxuVev/UsitZSvGlKp4iZYTBIG+9Wp3Bamq0GMwIEBWtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450169;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=k0TRyN8w3rMOasxJ2mHoyFAjW+OBbhj6Bd/SG5eNaf8=;
	b=hYHmoJ8BfdMLEp8ClU9Iw7IGFnTsNdTgvfn1aqYyMKRSMiJ1FlhMks3+Ppbu4zXjD3mQ
	 hTCCmOswP7MTEEwvByY/39Qe6B4kQXL4B2cZ6RzvtHh1b6DyaM6U4Y68DGWmOhUve5/e+
	 4VwIByOiOrNTSi2NeQknb7aIBDiez36M9NmVhHrIv8Y/xLQz5wtKx2fj142dhi7Pr2tZy
	 ARP7RzCfidanFK2Tuw1YE1Yoty4KTS+CyBRn2guU1hRBhFODwVfU/wcOWGgm4LKHMnq/f
	 94OjkS7XMMBbxNYGJMiGX04YU8njMyjiCgRcomhYprZa335CxKu8QNsbcvnaxK/1J1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7P9HnYm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA7606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7P9HnYm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234AB1F00A06;
	Thu, 12 Nov 2026 02:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450169;
	bh=k0TRyN8w3rMOasxJ2mHoyFAjW+OBbhj6Bd/SG5eNaf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H7P9HnYmnpcY9yEtar0YNcsPMRHbz2PRKBH7P+SuW0f3fbSrE5qpKioWuwd5FZRn0
	 WwdiyZmpjjeAJohOynzkuecpglbaHra8xOjuLXLL24KDLh32a5FHUXFR0l98y3uuAV
	 CPDhURGOZZ1RXAMJ6Fr9V0oAnzP0oVFx8UKRE+N6IrsgIufKxANUs3vAAHQeSBEYE4
	 A0CGmz6GK5lYU/lbFkDZIhhkm1fU5lQKPtsuUrODquUQ+vntZZCtrro0ffpL1g2E0i
	 wyednLmoC30tbOcxDcThs+d8auAZYxj30u0R+8u8MgEq8/bH+aywpe24MyBN4a3NXn
	 x/CSVY8RX9hRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ciro Pedrini <ciro.pedrini@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support
Date: Wed, 11 Nov 2026 21:22:45 -0500
Message-ID: <20261112022111.1333490-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112022111.1333490-1-sashal@kernel.org>
References: <20261107051047-failed-6.18-d35a1ea827a2@kernel.org>
 <20261112022111.1333490-1-sashal@kernel.org>
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
[ sashal: adjusted board-list context to account for missing 8A18 and 8A43 entries ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 9a9ff35c3b954..71b246378d39f 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -131,7 +131,7 @@ static const char * const omen_thermal_profile_boards[] = {
 	"886B", "886C", "88C8", "88CB", "88D1", "88D2", "88F4", "88F5", "88F6",
 	"88F7", "88FD", "88FE", "88FF",
 	"8900", "8901", "8902", "8912", "8917", "8918", "8949", "894A", "89EB",
-	"8A15", "8A42",
+	"8A15", "8A17", "8A42",
 	"8BAD",
 };
 
@@ -149,7 +149,7 @@ static const char * const omen_thermal_profile_force_v0_boards[] = {
  * "balanced" when reaching zero.
  */
 static const char * const omen_timed_thermal_profile_boards[] = {
-	"8A15", "8A42",
+	"8A15", "8A17", "8A42",
 	"8BAD",
 };
 
-- 
2.53.0

