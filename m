Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978834;
	b=OxoCFOIcaIx6D0uICSZCrQTvcuo51SztGqAb+PTGJxdIiZMzSRpUmEQW54ykEzEhI/Sv
	 DqwKxjY4+G4M0mDwC+WBbqIyhSjRSymPKpYyGKXLVBevmIx7P6GJUZUlgdF2QFPDZyY3J
	 Xlcr20BnqwGJ/yMl9ve1jPO5zc5/nO5WIM76vzEjMxTZWgAfbupM4UX6kRpdsh7qSa8lq
	 E4LJGyjgMMBdCdu40R0NUC0bghhQdk9Hjkcxg2q9LaRL/COI7HrrYccDuKCBHisguPkk4
	 BTNbfLk4piEyOFf4sRgtJQdzYzPn5fbuL7HLq5Ae050e10PQw2TtEhLOo4ING+//EyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978834;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HNB7FMaf9+d1tYs284izMdYn/bRHJGgOJdCh0UXGTZU=;
	b=4jkYIAsi0MfiIA9biCMAgoPZo4MBZpHT6q0GNay7j07EPlSSIS9eXTqrDz+VoCb4LH5D
	 kWT9s4t33rLmWdRBy7ZeBdjKOYAE/kcLuvyKIGf5MHvmMqSGtdELaJN44Do5/OGBQGj+y
	 FlRWWc083v17wAf75WW7rAex+qH76uLUS1YNHs5J4QG1xikRBB8BH199ILNE5a/0DGz5r
	 gQfYDlzviX7ISwGGdNfRUCb3ivTRoIufTdPppij3KGRT6cJ10yBF2d12cW9s9DFsQ3Hgp
	 DjN2d77Gz+ssPgyNut4uSjIjFVoUsXMfxSKuQfF09+Q94RXYwoe6XefXEHFPiUwJhiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvxvzPml;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E1606A332
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvxvzPml
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FDD1F008A2;
	Fri,  6 Nov 2026 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978834;
	bh=HNB7FMaf9+d1tYs284izMdYn/bRHJGgOJdCh0UXGTZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CvxvzPmlJl7rR5NvSmUDhPvoMl74cdBV2oX/8SfChgEuDzqd5qFRMrApe3vzaHP3W
	 /Eil/UR96u+o0GRoBZ35teFbTzKWIoQxBD4+QjtyMOFg4R1ashxeo7fdouY3mnUV3I
	 n9d7HRYq0fDjPNtwXfdZyUPQTzWzVbBvDgvZey2cQpxFIVj2SjATQPM4GMDEyyD3Qq
	 QYxmaGjlhMWsYE8I2JpArbEbOHmbO5WdixizzUAG7FUpbwc+b13+bAKY+KgFHVP7OV
	 mnCKeVAvlTENvFrEYUn8ANTdzKHauxN2yunkBgpTpZunkZSwiCfRR01Z9PBUGRZZGi
	 6VkPLGvLswElg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] HID: prodikeys: validate fixed-format MIDI reports
Date: Fri,  6 Nov 2026 10:27:11 -0500
Message-ID: <20261106152704.450832-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106152704.450832-1-sashal@kernel.org>
References: <2026110448-anime-deduct-1f8b@gregkh>
 <20261106152704.450832-1-sashal@kernel.org>
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

