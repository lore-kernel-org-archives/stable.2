Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F7424D5A;
	Tue, 13 Oct 2026 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882780; cv=none; b=qxhejH3rCSIsi+/8gaAwIFrHRQNYTq3/KEUB8WNLQ8SEocLePw5SpUScpPGEqnEuE8ti1gJPAhhUSWJP82wgwqGKVTFUE/Y6oIS8M1lqjnjRqQLlrJce+NAMVTOsB/5IpvGT9W58uLDByGsZQM4s0TPNBLHDEif87i5xXbeB1Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882780; c=relaxed/simple;
	bh=+vCS3Q+fjRW8qWmShDxhg0LhDIcfguurTkdRnFySAco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTe0YYP6ZPEVRMUUAAif0PgSwvN5BpV42RTNJ9ud2CbPGSt+Yst/UCUh8BTmngcDXffhKzxq6EUqQGpxvpWbSGXD3Mm81yanYDRL9ymDEqgY5tMj232gc/THKMo/jneo5b2izZJ+Ul8WXXgG3k56lgLC5S6+/1GPHiGip26CkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INih//QG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INih//QG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE1E1F000FF;
	Tue, 13 Oct 2026 09:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882778;
	bh=SXwFL2pkU61EETwpuH54Z1heEq5vp/7fcD8teFbp10s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=INih//QGUFGhTextuxMpkXhM8MzMOVHB58rqvSBWgfW3EYKBPgD5KQdoh3lv4295n
	 rdRYCFy1lgsDTbDQwLT4dPrZRG0Sumf7AoqXvt7ttUwy5GUtNiJFrItl2Pw88fNjZO
	 990rvTylXdiZZ1/DKcrZsdcNWPJNlayHJxeC2awitj/iPO+zaklI+MgsydB52UX8FK
	 okzmYJbBHkwRqW9p3EOt2gW1npDYW1rvQkXsBfoPo+/vZhThMR+39FgepohmMpBO9G
	 wQI4Wcxq0YujG/9lNaTbCUJ5oFyhCYIjfwfEm64kBkN4rDazKAHrydj2HdmoO31Mdp
	 q7OzoGbPEVxng==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Vicki Pfau <vi@endrift.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v5.15-v5.10 4/6] HID: steam: Rearrange teardown sequence
Date: Tue, 13 Oct 2026 09:12:11 +0000
Message-ID: <20261013091215.529531-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013091215.529531-1-lee@kernel.org>
References: <20261013091215.529531-1-lee@kernel.org>
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
index a856276b6c2c..628e4ef72b81 100644
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

