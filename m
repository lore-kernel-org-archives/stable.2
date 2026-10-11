Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9E422535;
	Sun, 11 Oct 2026 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715188; cv=none; b=e657hhxZ+goYYVoen/+0c+QNhJageQjCnhfE5stI944kmS/KQdEZywsCxdZiBhp968rt1vuNjbnMnxdhc1xLPyUs5ndFt1R3hC002kgqszHRpmscvKe+kqxBnlHl6WX3MVH/PTTp18w5p4kypWpXXQj7dpgK2+2dKf51hnTVt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715188; c=relaxed/simple;
	bh=CB1hRUy05pINQd6rfDoOjyIae4KTRVlyBHfjoEIUMIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYJzVrhSHhAcy/MZlt1PrThMwDfjYoLMwUCwmFjqbmDmiW1pENu68sct4z0Rr4dWIdSIWP5EN1pEPsBnEuftTMs8BhmPVCx6c7IpwR9+gyeD9Q6+ggd+1c2Oasv/HCve12MDcX9TSloHALT9Omeo9bBvO90EK3RQFgbSRTdRYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTOEPj9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTOEPj9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B6D1F0089E;
	Sun, 11 Oct 2026 10:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715181;
	bh=/N2sioizD+tpIgxWQbkSEdlSfQSVfCBMVIP7tgJPbr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KTOEPj9IwtkGVwtJHARfbXjnFCKKvLs5AJcuIbIhS+g+6tZvinfJQ/F+hnJAQb/Ak
	 Q/Mwu5ZE5N1WGNpAGVAmpNe8pVSyCYwUFF9HgXuolCDextbJBeVhetX61okOVItos8
	 DE/zZeaAwxMN93ZfQb0H+tHFdF2KJt130oN5T7rt9V7Q76Z9FEssWjmZtVsZ6zdfUT
	 WhWc79iUJfCYeJj90EhRYjIPniwbInlcNwkKF1raL7GfZqpoPo84qXyu+7aupHYUI4
	 c7yYo2PLWof97IoBUHqPSIl6iHv4VwopD+EUvKvbY35EOkk8zbxh4BXAP2/q4hlXeV
	 CPcrBceu5QIfA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	David Rheinsberg <david@readahead.eu>,
	Sasha Levin <sashal@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ai Chao <aichao@kylinos.cn>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Kenny Levinsen <kl@kl.wtf>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
	Carlos Llamas <cmllamas@google.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v6.6-v6.1 2/2] HID: uhid: convert to hid_safe_input_report()
Date: Sun, 11 Oct 2026 10:38:57 +0000
Message-ID: <20261011103900.2201441-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261011103900.2201441-1-lee@kernel.org>
References: <20261011103900.2201441-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Llamas <cmllamas@google.com>

[ Upstream commit 63a694c51bf120a37550890b8e7736b4888985e9 ]

Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
bogus memset()"), added a check in hid_report_raw_event() to reject
reports if the received data size is smaller than expected. This was
intended to prevent OOB errors by no longer allowing zeroing-out of
shorter reports due to the lack of buffer size information.

However, this leads to regressions in hid_report_raw_event(), where
shorter than expected reports are rejected, even though their buffers
are sufficiently large to be zero-padded.

To solve this issue, Benjamin introduced a safer alternative in commit
206342541fc8 ("HID: core: introduce hid_safe_input_report()"), which
forwards the buffer size and allows hid_report_raw_event() to safely
zero-pad the data.

Convert uhid to use hid_safe_input_report() and pass UHID_DATA_MAX as
the buffer size. This prevents the reported regressions [1], allowing
hid core to zero-pad the shorter reports safely as expected.

Cc: stable@vger.kernel.org
Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
Closes: https://lore.kernel.org/all/ahsh0UtTX6e0ZeHa@google.com/ [1]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Lee Jones <lee@kernel.org>
Closes: https://lore.kernel.org/all/ahsh0UtTX6e0ZeHa@google.com/
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/uhid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 4588d2cd4ea4..9027bb23f247 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -596,8 +596,8 @@ static int uhid_dev_input(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data,
-			 min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
@@ -607,8 +607,8 @@ static int uhid_dev_input2(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data,
-			 min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
-- 
2.56.0.385.gd3acb90ef8-goog

