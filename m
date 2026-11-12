Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449137;
	b=0+xHNgM27ok+lzca6YNb4FLOGUcER5ewpUg8NqPYTR5W0T7kNceROtzgnbx3YxOnts79
	 ZvdblNBffhJdZlE4Jc3efKVe1TfgyB+rtWwJv20cONTHhozHBSdVxoCAU5CyLFVAcVDJK
	 KIzsseyio4Te0lFIU/kK9dI/hDpChEC6jp8Lhts1lbRChC6vtZl7kCrSxulH8KT7PmKcI
	 WA3rw/T/txv3UZY5N1K4NNYmqnRLCDrhDuHwszQdScQSa1s82upzxzC3cqZrUtzWDFxbX
	 b2aK6U6detxKCyaDT1LEA38vmKWOCvLBTLVAPR2TZBouA/8rHQH3nSQ4M0GOyw13BiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449137;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yrqB38Oa/kDXfZ1nxceXjDFydweNLCdCxeyBbYgH//4=;
	b=Nn7DDQFKeLmp+RmMxv0E6OBp3epy2j3+yXIZ2CRnebV6s1fAaZhaC7qbnEUeSYCn3aW1
	 g3Bko7lnWQ9tOXvqRphSF4w7YeOqpIIt6Yk5vAoHQRTZtD2KimD1vyj20fte1CV7eEijc
	 kXTyXRcHvR0vaB65DZvkUV9gD9h5QN6Br2ia/zAunvRf0LIRGWTpPxMA8fLmw1NxSH4Bh
	 2GnJb3ElPmYqLfWbozczoAnENZ4KtbthjoVxbidpUpYqS2Eadgqb9X+2lRSCUFutl1IDo
	 +DHp6LCaWbzZFYNRbk7Vmo65kzobktx6KEo6YEtFKuknEFRIKU0pdLbkpZv7PDt0WVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejAy72Qm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4CB606A89D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejAy72Qm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86CA1F00A05;
	Thu, 12 Nov 2026 02:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449137;
	bh=yrqB38Oa/kDXfZ1nxceXjDFydweNLCdCxeyBbYgH//4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ejAy72QmRdKkAbq0XlFgp5WGyCZM0zFVz39TDiXFi44/B99XTFZORVwmVB1J1QVIA
	 Iw1MhQPgCu40goooTiR61lSRVHcgigE0G8gYvoC0nGfLiVjEx2ehiZIT6PQKoS8iew
	 NrNziGR5Nerk52Di7NyawSnZjb9QZblVLWJlLzOOqky9SFsMQ2nVzfVOmKdErg+cFV
	 PuvEmaw6q5Br+ouqGcCgS6N4sUngs0RrHBqoH7VdfJsDLoPqoAVEZMyl8IQ3ptYYvz
	 +5FWGwdaLILobl91GbUD65gXEZ/SmVKLdHtaEsQ/CDnhyBsbBt8qTk9Bk+nRNyy2/6
	 8wkDWvXiH+tsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ciro Pedrini <ciro.pedrini@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support
Date: Wed, 11 Nov 2026 21:05:35 -0500
Message-ID: <20261112020518.1253644-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050436-failed-7.3-d35a1ea827a2@kernel.org>
References: <20261107050436-failed-7.3-d35a1ea827a2@kernel.org>
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
[ sashal: Adjusted board-list context to account for the missing neighboring 8A18 entry. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 436e1ad9c1b46..5582feea3c365 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -208,7 +208,7 @@ static const char * const omen_thermal_profile_boards[] = {
 	"886B", "886C", "88C8", "88CB", "88D1", "88D2", "88F4", "88F5", "88F6",
 	"88F7", "88FD", "88FE", "88FF",
 	"8900", "8901", "8902", "8912", "8917", "8918", "8949", "894A", "89EB",
-	"8A15", "8A42", "8A43",
+	"8A15", "8A17", "8A42", "8A43",
 	"8BAD",
 	"8C58",
 	"8E41",
@@ -228,7 +228,7 @@ static const char * const omen_thermal_profile_force_v0_boards[] = {
  * "balanced" when reaching zero.
  */
 static const char * const omen_timed_thermal_profile_boards[] = {
-	"8A15", "8A42",
+	"8A15", "8A17", "8A42",
 	"8BAD",
 };
 
-- 
2.53.0

