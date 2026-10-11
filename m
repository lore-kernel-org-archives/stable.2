Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF636436BEA;
	Sun, 11 Oct 2026 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715182; cv=none; b=fQTLZiLZObvJU9OpZmLODyTMgtHtyrW23uDDaLhxJrSFMbrJGgkpfjgx0E5oC3RNo7vbjYPtCTfDI6eoJvmMaxcw6xbT65M6592w+kjl3EdCWo4e2VVwUYjPCUtx10IdsNRW0qlu8nAaEb1MWrcXOV2M5ftSy4zIT9soyufM6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715182; c=relaxed/simple;
	bh=f+fO8KJ7TDUEKMbMGREflI8Y0DWAtv8R7zZSSnfVri0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuWUtAQyjqJzfTfM7xc5rK4HkfPMaa3wWppiNuhK38E5BlJ7J6tcNsspNmxQLKJU2dh/VaKFnXLi/QIiLGqmHT9BxLSplmCvMiT6bS24wPl7VGoCghIGg1TPb81h4V6Y5L9QDeHMukIagPWF9cAjl/ZcIByuU/yoKn6TZbcTdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI9zk6XA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI9zk6XA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8A71F0089D;
	Sun, 11 Oct 2026 10:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715180;
	bh=dyXnID3f4VcuH03MfT6XwwSsjbbIaIhr9umT9SbCXRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kI9zk6XAZ9IWew7SruWuCKhijD52Vx5fty6jekodL3v206krFpqk4mq8WaTcppX4h
	 NCNtvsguETWRWxXwbGAI3yATGFee+mCGy/5KiecoYxUQ40PU5Ow/RXZL+yCmujPlyw
	 S2FZB/fbiDv5cCdrwX/5mci63xiJ4krlxnZ6CclP7zPSvhwneoj8mQjigvrAxwBE8g
	 SVrItPY9yjToWytvU0SbYv5qq7r5M2x+R56FC50NnbU1DSBoJcPGOPy/5HqKIxbozI
	 jyB0avlXWY1kAoJ3fxclJ1ea3yH5TN58rK6V9AY9jg1ZrGoznZ10qmegW93Bdmlwxs
	 5sdwHADDGvJLw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	David Rheinsberg <david.rheinsberg@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	Ai Chao <aichao@kylinos.cn>,
	Hans de Goede <hdegoede@redhat.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
	Carlos Llamas <cmllamas@google.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v5.15-v5.10 2/2] HID: uhid: convert to hid_safe_input_report()
Date: Sun, 11 Oct 2026 10:39:10 +0000
Message-ID: <20261011103912.2201634-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261011103912.2201634-1-lee@kernel.org>
References: <20261011103912.2201634-1-lee@kernel.org>
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
index 09da654d2b05..9121eed46685 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -597,8 +597,8 @@ static int uhid_dev_input(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data,
-			 min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
@@ -608,8 +608,8 @@ static int uhid_dev_input2(struct uhid_device *uhid, struct uhid_event *ev)
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

