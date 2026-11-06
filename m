Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977829;
	b=bgDfSTJ0L2G6yRFoV1aJpCCRdOiw3+JwBwCReQw8T8lEQeZoXCxHHyu4SUygSURUXCXQ
	 qCeg3w8l3RMsUW+SlorfSb8EJiSzRS+RNpAxkrFh65RsZ3ZjPpGLcduPsGYpRtcwd74sU
	 EVk2293KxFZ1eB+VWflKx+I183BCJ9bcryeYUi63inC05mYUt/CXbJQAetgTIxgr0I8Qy
	 Ej9FX/E8+Uj8IZmbInTQq3OPk/6ibIZmjXRE+qTcAA3NmUUMl2EYlecXWY9ymHUB7bg9r
	 kxvsNe1nFvIABGjGwDEeXTs1V5WYyeHWI7yeF2bKaBD0YLous3zPi8hKay7maiAXvMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HNB7FMaf9+d1tYs284izMdYn/bRHJGgOJdCh0UXGTZU=;
	b=yx9289LmBwbgTFKh+tCLsZMuVTkOC5XepAjdCSd2FN86BmdXlsOoLO41o4zRvB71Ptvi
	 6mx8EjmRayuztJpUmjF/5WJS0YPd/QI/7KNugVY/RiDi1qCucdZ7O+gltZp61eQzQBvjw
	 Ee8Ws4x9UmEVANcxHF99w1n6L/zJ97+u8S+ktQcM0O5ZmBjeU2p9HxPO+cD0ZHOGQ1Lp8
	 YCa5mdh1LH9DbovAZCSNoTGHAZjwXMNZmdzr/mdd8324W6LdrCVhvE1oBi/csSkR31M1d
	 j+JtdSkehyHIAxctlo1gaKhtg/0EjrE/HRGkVs17qglRAjBnCV1F7ERaFzNjq0ruZmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R7/0yRJh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8190606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7/0yRJh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3451F008A1;
	Fri,  6 Nov 2026 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977828;
	bh=HNB7FMaf9+d1tYs284izMdYn/bRHJGgOJdCh0UXGTZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R7/0yRJhZnLLHNa+W5fsFRip9O12mR7wnNvMKDbfa/rtR9bD8bi4HecwUg0IvIE8H
	 oXA+O12e4aa61aPhWKKc2ZwFMS4/vjqisqi+oH7uL/ALoXiH0jTa37YVAy5GW4fsdY
	 wsPQJV7PVv5NeU+euYspIMTbnCrolpZdF049BBbKdOSOgmuBveRboluii1oYO/6ykw
	 Gnl/mgr+pdtzbeWDwagUILmGF1Y9WecM0aCzFyks1Gb8CEMo5mGf4e7c6t6s3yEoMg
	 p0SbP83rouYo+nWCaK/fcL+98A/6BKL1G8+7IQ5szLHhPYC1k2RB26WC7jllyDARJW
	 bgvUmXiqYsEgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] HID: prodikeys: validate fixed-format MIDI reports
Date: Fri,  6 Nov 2026 10:10:25 -0500
Message-ID: <20261106151016.409233-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106151016.409233-1-sashal@kernel.org>
References: <2026110444-unlisted-unaired-f627@gregkh>
 <20261106151016.409233-1-sashal@kernel.org>
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

