Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978380;
	b=H1hM5EowgYYJTe1WY1An45PpEmJy5aAQl8kkTwEloQ9S+j8jnO5qaMxiZ0+MphaSbAzx
	 xiLtHXKfm2X/I9XzJBn8JIqMb9q2T2cpNcckV/Fyl0aOHW39YgEIsV9+5Zl7EsJhi7e9v
	 D8DxSZYTEsmgFF2/CcBkk8ND3TbZ3Md2RKlERzt+7ylrxcxk3s9VL3BhVxuqpPkuz7VOj
	 n9kmWtXvpw9XHd9b66DSfY0goPsGMZkAJa7UYrpDGHn2vYJC0yOXqEr5R4MLRkLqvrpbN
	 aS/8Re+MwLMitvRolNluNs4cBK71nItnSIvQRCKkPWJM/5TKBTKm4chtlw90Ocjcw4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978380;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HNB7FMaf9+d1tYs284izMdYn/bRHJGgOJdCh0UXGTZU=;
	b=nC9oll3KCWKTlv6fkFzRpsPk+qwGHiBx+alRoc+710pqkB7vcjKx3dJ6U1zDZp5mGmqk
	 wnoaGP7hN4ZXxnOaNkEhhVgkWBaobSoXhUD5Ii7ZAy9dKZ9qkitajf2LQ+CXLYTqjMoSB
	 utiH4D5NvmJxoCgFcpytAYcMhf2GLTqPUTE30mhwCUOkKcpCzNcFojZxLiSSsSDkEzYEq
	 8LW+PXS0kaM4FyuwRc247kxdNHWPXxMWbT1YFA9bK2QBulJTeg52ZkvM5B6IGR1llHrLo
	 ImJIM4L8afRgVT7FpWqiV3yBhXWz/nL/2vgDOjHmqHlyEKstw9YXLlCAkCWF4QeKZ/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLNZaggm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DE6606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLNZaggm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4482E1F008A3;
	Fri,  6 Nov 2026 15:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978379;
	bh=HNB7FMaf9+d1tYs284izMdYn/bRHJGgOJdCh0UXGTZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OLNZaggmCdOEkEzVPZYM05skSlyS/ZloGO8pGuNs66ZKVhljY5kqD1KODlKAU3Piw
	 cqWdPAwwovv5YdsSxgqv0Bpf11c2cS6vwMYzZv7SuXCX06pXEhNUtJjDECMcFHP3kJ
	 TBNLBdrrtQAZ+BiMfXM+UXYnTMXo0ZYjmdY4goaqtsCs06AeEU9xomRZac3mWbsK1D
	 MblJo9Nib/ykHp8VvBgVNIHqRH9EE+SDyJS1Sy+KpjHgwu81jZHRvvjOFL9lvdQZvE
	 vH0VAzjyHdAU2Trt4s2Kyg3xTxSAXl3fsM9R+23LtkZL5d2DGpa9hSHN5hukKYZWpM
	 FfUkiQ7jwY2FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] HID: prodikeys: validate fixed-format MIDI reports
Date: Fri,  6 Nov 2026 10:19:36 -0500
Message-ID: <20261106151923.436494-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106151923.436494-1-sashal@kernel.org>
References: <2026110446-amnesty-outsmart-92b6@gregkh>
 <20261106151923.436494-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiale Yao <yaojiale02@163.com>

[ Upstream commit 0ff37294c41bd925258893310398bc2b45fcd4a7 ]

The HID core invokes raw_event callbacks before validating the report
length.  Prodikeys reports 0x01 and 0x04 are passed to handlers that always
read bytes one through three, regardless of the supplied size.  A truncated
report can therefore cause an out-of-bounds read.

Require four bytes for the two fixed-format reports.  Keep report 0x03 on
its existing variable-length path, which derives the number of note pairs
from size and only accesses complete pairs.

Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw_event length validation to hid-asus.

Fixes: 3a370ca1dcf8 ("HID: Prodikeys PC-MIDI HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-prodikeys.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index b53b0c02675a4..f2b9142e95021 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -774,8 +774,13 @@ static int pk_raw_event(struct hid_device *hdev, struct hid_report *report,
 		if (report->id == data[0])
 			switch (report->id) {
 			case 0x01: /* midi keys (qwerty)*/
-			case 0x03: /* midi keyboard (musical)*/
 			case 0x04: /* extra/midi keys (qwerty)*/
+				if (size < 4)
+					break;
+				ret = pcmidi_handle_report(pm, report->id,
+							   data, size);
+				break;
+			case 0x03: /* midi keyboard (musical)*/
 				ret = pcmidi_handle_report(pm,
 						report->id, data, size);
 				break;
-- 
2.53.0

