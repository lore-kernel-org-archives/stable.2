Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453161;
	b=W/Iooy/QAIc1BPQhGGqjEpvf0HpyB08RDDD+OtZ9MtWc82mlfdu0/b4TlsBYvg3NSzc/
	 vtnOTo5iY57KHBBMVNYCsS23JN08OU28kisjzLFUpAas3FPJOrCY+cqydfuYDb9XIzL92
	 nASzgA4thlqJ6hm2+yuUTx5ySKIAt2w/YR4udCBVX9+F+wdoN1HSXA6/fvxp3KH3cXJKD
	 b5kw1E5CVJlPGjb/t2kww+kXrH8/ByoIlo3T/IenX+702cYyNsCmqiYMj+L+7A9/585uL
	 s1NB6sKNNJHqlu2pcZPOYf91n36CrKr8/Mnt00uMr0crVlyvMc8eci1qRjG3NVjA/eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453161;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JP9HX/aEv5bIF2lncKmrRpmRWlOimWzxzqMmdrfy6yE=;
	b=0Zl9xS4YDKnFgR+B7iYYQCrtydwcpjAWLTOEawggCCyIYkViwv2kCnZBwSUY6KN3bdq6
	 WZsV1eawXPpyIjceR9bMKmgjVCFghoEt6Z9wr925HzxdeOf/BBB1pNv3tqt4vFPQ/n2p0
	 zw8JTwt165tJNUSEVFdW5GLAd/kCoKlIkX0VydaTF0IyTYm/ggUin8JnkQSyudB88te+r
	 Hb5TVdDekxSCpcl8ig81gCWIbdVTepgZ1ZcDuKJDRMubrrKlzn0bjLMOYXXDhyUnbwEZl
	 10fMYZzVkkfh9LEjepZTcmOhR858a1O+mJRbq5ZQwZS3hSvsAdDeB9CD1PVR2/KQimA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXfio+5j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3533B606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXfio+5j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907171F00A06;
	Thu, 12 Nov 2026 03:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453161;
	bh=JP9HX/aEv5bIF2lncKmrRpmRWlOimWzxzqMmdrfy6yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VXfio+5jQxY7SqZpDtoxHU2kflvdgF3zMIA6f0jfxYJTnp1Fq+OSNQ3aSKLP2y7LN
	 YoxYHmxlP0lu1HjPG2bXF3mgDFN8KTdB70rVUYrTp2TC6+CNBUiNSqBsr+y2XIUVnk
	 v6WvNUvncmhiO23vmOr9CwwGwmk8jW69KrXKJV9vYXgNxrnZPbE9c44gpPvh41YUZ+
	 wc930aHj6jiUau3zHIPUe0fW3Q+WMPlx3N1hLTDL+sQ0GspNEgwaXu26fGD4UnlFFC
	 20zACMBFQWGLG5jZJUIKUNcGJa84S+mtG1IPGqFj6uTMfa3TrxoSaunB4Xp2hq+IQF
	 yrEHmMg+LxqlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ciro Pedrini <ciro.pedrini@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support
Date: Wed, 11 Nov 2026 22:12:36 -0500
Message-ID: <20261112031152.1461468-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112031152.1461468-1-sashal@kernel.org>
References: <20261107054735-failed-6.1-d35a1ea827a2@kernel.org>
 <20261112031152.1461468-1-sashal@kernel.org>
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
index 8829f8a435f0e..764613cb55fc7 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -62,7 +62,7 @@ static const char * const omen_thermal_profile_boards[] = {
 	"886B", "886C", "88C8", "88CB", "88D1", "88D2", "88F4", "88F5", "88F6",
 	"88F7", "88FD", "88FE", "88FF",
 	"8900", "8901", "8902", "8912", "8917", "8918", "8949", "894A", "89EB",
-	"8A15", "8A18", "8A42", "8A43",
+	"8A15", "8A17", "8A18", "8A42", "8A43",
 	"8BAD",
 	"8C58",
 	"8E41",
@@ -82,7 +82,7 @@ static const char * const omen_thermal_profile_force_v0_boards[] = {
  * "balanced" when reaching zero.
  */
 static const char * const omen_timed_thermal_profile_boards[] = {
-	"8A15", "8A42",
+	"8A15", "8A17", "8A42",
 	"8BAD",
 };
 
-- 
2.53.0

