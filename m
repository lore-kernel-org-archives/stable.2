Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C63B43CE7E;
	Tue, 13 Oct 2026 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882777; cv=none; b=Kthe9xstj5S2xnxGrT6gByY/2ZF8U2mjtDl2zHmLCEJxND33tVfnTrJeFD4KlWE/ivYqdQ7XZRHaQ29xVj/vs4WgJ8pBKdlHi4iOGlAIj+Nsxx+Wq9yzE+BHYUoBQfV4gIwKhE73uh39To8utUCrVuNxcUvB0z49wkNu4T/7SSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882777; c=relaxed/simple;
	bh=93+54J0fS1Gig5FG+BqlW6gDlVcMxBz1w5YfO6VVYH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjwejYGXUxfAHiQDwI+bwPTQ+02/dI1peWkqBemBmfEIlvfm9OXmoffMgeanL6EA3uG4G1cbVOK4BaQjIGeh/bbM1rLG6HaLnU9muZMgZ9htTWAIh3gZU7DDvqNlYI5sE5J8iY2hhEWA02CdULN26CTpJ+9K9nukOsaZkzwzaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8RS/syB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8RS/syB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3991F0089A;
	Tue, 13 Oct 2026 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882776;
	bh=mJrIFcBOR9zmuwyiwd7b7pP4ekyQxA8Fzqg1Di6HErU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V8RS/syBmbXWl7xoev+yiDyYmj50kKHB3QiR3m1/NN0alarvlbtmty0XVWcBbsGAF
	 cgzX+2aK7RycyTp58ct5HoCqJT4ehIwttvFXtnDfY0KZ2pQJhZ4MMxmqdtlqfY6Z2u
	 XoQgfbU952Vv5ptyB5PCJ6N6D62ECzSa1paa4XbOLAy3SNDfaO7OXhSjWg93geB79F
	 ehxlD9ULQUVnSc87AHA9IpiDG+sAEaqlNDZpKoFAQh+OwgeXKvV24r6+TMDaKVw3ly
	 b4zPvWVuI+cmxjalgrq82PAX1/2gOyzLvuo0vLY9/yWA3Fe+WPIp6W6qJShu1l/U3x
	 7v7iXYD5g7/bA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Vicki Pfau <vi@endrift.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v6.1 4/6] HID: steam: Rearrange teardown sequence
Date: Tue, 13 Oct 2026 09:12:00 +0000
Message-ID: <20261013091204.529049-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013091204.529049-1-lee@kernel.org>
References: <20261013091204.529049-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vicki Pfau <vi@endrift.com>

[ Upstream commit ddce9641ce924ed91ec8304577e463823a29ffaf ]

This fixes a narrow window during the teardown sequence where callbacks
could still be scheduled during cleanup that would then have a dangling
pointer to the now-freed steam struct.

This also puts work canceling for rumble and mode switch in
steam_unregister, as that shouldn't persist while the client hdev is open.

Signed-off-by: Vicki Pfau <vi@endrift.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[Lee: Omit rumble_work, coalesce_rumble_work and mode_switch
      cancellation as e133dc99fc07 and 1d4549fd1115 are not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-steam.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index e8f28c59a303..0e5fba060c91 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -829,15 +829,16 @@ static void steam_remove(struct hid_device *hdev)
 		return;
 	}
 
+	hid_hw_close(hdev);
 	hid_destroy_device(steam->client_hdev);
+	steam->client_hdev = NULL;
 	steam->client_opened = 0;
 	cancel_work_sync(&steam->work_connect);
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver disconnected");
 	}
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
 	steam_unregister(steam);
+	hid_hw_stop(hdev);
 }
 
 static void steam_do_connect_event(struct steam_device *steam, bool connected)
-- 
2.56.0.385.gd3acb90ef8-goog

