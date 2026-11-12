Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450706;
	b=25gBmAzvRXIjHiTVnkhgZBQh09letQPBnH6IKRAwDViSNLWTvY7BNXeeJrKre+Bluv6A
	 3OvwovOaLxno+UUzaliOKx5uxWT2kqnk/dOZs9N+Xuz2f6fIpFjHWedUCG9eHVX9w4vZI
	 fIVYgBU86Fk7GKbZjbtWAV02HAURY6qhLv52B1acP5TSIXf2/AU0YSX7VHzkI13nE8xWT
	 unljZ+mqGVm+ovbNGl9m/exF0xeHOkPrcUUY5fBTGnD9W66zx59v33WXgd+yTpARMcRN0
	 uPxMl+xrF+hodRJP3A1IBMX66QbMbOsdUUsuoYv4h1YqUd/2ZXO84V6RvpY8G9+c8WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450706;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gMhbTe7d0+CUwBGxWyS0q0maY/Ana1VK2WRJlRG+NP0=;
	b=2xRIr6wK4KLwVXlrj/DPannyJzUpLF45MXRzdKxcXFR2utak3U6P6WJg43E06gxJqme2
	 ZK7FFISfIraCEe9tad4J5u8xrXlQDvjMPVe+mqqiHt7QwxFLF3zcInAhxpd4wIwNrtWU4
	 OBnh5iGRud+eqMhSCYDFKENAtU/jhHelRdkn7JkxlEWARGoItoF9LaxuLYLIn9sBd0voA
	 cZ78k6YfvsfQwxWYaURjCyTtw/GmEoXbUzkzOPt9fYITCKMYDFjGQQ9mx4w8l9yAxXYvW
	 N+EH8sPpL4Uw8nMj6itIfUmAIY67m06AYY+8nfASH50e8D1CqOrEAQKw+q5yWsgmkCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rog/7ZJK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320D606A33F
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rog/7ZJK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717221F00A0D;
	Thu, 12 Nov 2026 02:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450705;
	bh=gMhbTe7d0+CUwBGxWyS0q0maY/Ana1VK2WRJlRG+NP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rog/7ZJKvYMQOSZVXS2+99lCk22f/QW3sW1zmub1o78VyVMG8u/xM93OBGA5O4urW
	 WipXgX/uAUBrWSb+eCtdFC37vt5VGZ3YLxF1/q1D2yYYVSuMafHanc/Xd0evfI6iDA
	 9OoR6/t775ynN7HJ1qNJGbSnXHYtury7OmESdqx2m4ORkQ11LpOeTYX3VMK6Q+lpC8
	 ShlImAY1At4wSrbgLflJuqLICEn6dVJ3ExzIC+ndC55WKzbH1l06Q3mLRvxBgdQn6L
	 xrk+8Vj+3pvjopTbScMfjs/m3dSzlhTLPKTuZgN9hvKGjZ8q9LEK30SeyqMbuq1E/2
	 YcekzeT9eOaSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ciro Pedrini <ciro.pedrini@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support
Date: Wed, 11 Nov 2026 21:31:43 -0500
Message-ID: <20261112023128.1376145-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112023128.1376145-1-sashal@kernel.org>
References: <20261107052143-failed-6.12-d35a1ea827a2@kernel.org>
 <20261112023128.1376145-1-sashal@kernel.org>
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
[ sashal: Adjusted context to match the shorter omen_thermal_profile_boards array. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index d189da2205609..e20f1ba937c09 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -67,7 +67,7 @@ static const char * const omen_thermal_profile_boards[] = {
 	"886B", "886C", "88C8", "88CB", "88D1", "88D2", "88F4", "88F5", "88F6",
 	"88F7", "88FD", "88FE", "88FF",
 	"8900", "8901", "8902", "8912", "8917", "8918", "8949", "894A", "89EB",
-	"8A15", "8A42",
+	"8A15", "8A17", "8A42",
 	"8BAD",
 };
 
@@ -85,7 +85,7 @@ static const char * const omen_thermal_profile_force_v0_boards[] = {
  * "balanced" when reaching zero.
  */
 static const char * const omen_timed_thermal_profile_boards[] = {
-	"8A15", "8A42",
+	"8A15", "8A17", "8A42",
 	"8BAD",
 };
 
-- 
2.53.0

