Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0783CE48E
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586767; cv=none; b=oMxCTzU5/VQzS4+tfYk+Xt+paTWwmdQlXuFnsDOttl1pxMTwjimdZgILofswlLE80SVJ1M6dVkMBq6u4kdYq5hwdUCH8b8bmu5KMhd4qGoSwaUHAY6FNdh9wi9aLjL70tWGvcIV8eh6Nc6uoljUmBJzznMSbfH+qiM5c5TYyObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586767; c=relaxed/simple;
	bh=nKpdkPNMpYldRLUe77m/lDp4IURNFikimWQ7kkqhQ9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9Cp55tRQUy26OpvPoyMq8m10/zFaU4ibo6diTB9xYRdjqB6OY0kLUEMMC8QUjFpUPtF1h2+M4sxAq0EequRq+l8EXyeZgmAIMzgZO1fQwLLCd6qoRpS8SbEt5dwQh8hRTDiB3wdjdshSxrn4eH4/LmjJAVt+ajGh/obS0iQ0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzLJmUTw; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzLJmUTw"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3074adb8fcaso6931789eec.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781586766; x=1782191566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EW/pB55oGsaV6NXZltwH7jBTOBtry9BVGiJEbLm/9U=;
        b=SzLJmUTwQaDahrF58k6TkPiNXICaNwn7As9pyanZl6Fno7cNlLVvcA8t2KWKCIRkLE
         bXGGK+YicRz6np43XMxnoFavIGLuNhefYTzAyBea4AfYit+fpN7fOeUf4Pc6aj1be4sj
         KQ8rK3uv8Bdgma/OBPgbyPNfjd0Dm51UJeho2cn5F7bdvntQHxtGZNlPtAmmDuH7R0Vt
         ovm0UZoMZtSB0qI5pKMxgn4QXZWjv0zQloCGNdToSrcdGgx6BVI7AiMV3CcRMX0ek77a
         SpwKImWulTf53YnVxwPM9CjyqHHvextkj9VdSxuy8XFj6axFvdL+uI1HAP+kVtz81IC6
         xN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586766; x=1782191566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EW/pB55oGsaV6NXZltwH7jBTOBtry9BVGiJEbLm/9U=;
        b=Gre3Gg8ej3siDIzaecGZ/ULAtS16y2viuq4jJZ5X84iSbqJwI2N+mt8k9vwylbc2Yr
         39wEgEEkG2cbjwt/8NZAPi9ydcYYEL+6Td7y+2g1jInL5edQyKGGv0hjpSJaIzrm9Sm/
         6WhExpa9T/D3HAXSyrYQq5Cz/CPUwrdPbU4k9BEIHRzaRH0HaHQPnhKW/Bd5PNoksVV+
         tVdNL06oxgUDN8KTIodgcCJlxmR715Jv5TL/jiAVY8ZstrkKfrriWE9I4y5ZRLt1buv6
         PbL5ii/auKGoEKJek9O03EsH0YiN5EwF7rITZ7rfwc7boikiE6LMn/AM2D0/2gTIeOnP
         M2Xg==
X-Forwarded-Encrypted: i=1; AFNElJ8xeXEn0ECW35VzfJJ5OknbbVplSZAm9PCCk0QyR73ODsHo3GWfd3YbcIGjjrFzEH8P18OvYRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAlBgkMWNLoI0d2DsGQYEQX18HVIwmE0+qjdCIvoQU5SvMVNwW
	ArlbZMcNziaktafh4VO+jqjdfXNg8dQG9uB+1VMy8t1NkAJ2kVy2Hb5T
X-Gm-Gg: Acq92OEOhbE7E/WbhsqLtT2MJ1PIjXnLciOqKjLF8WV4NsCQ1e229NyWdK2p4X1VS5E
	s/2keArx4anmGLXQTpGU+q1y6yAmCU99dndVvPUKAk4Rf5ujuSAc235O8FXibuyr9osjmIbDsFg
	hD9PXgj5Lv5+9vYgRwmncpM7NtJgffB4bkevr8QdNppOlmlSGzijNul7wrE5DyHgp6xUVB1f6SS
	Cht1r9ns4c3AruJgULqEIYsSA7edXrT8argyZUKtn1+bDdT2g4lOf7lzMKjber6t/KRpahY/90p
	DnwMU2hmFTLkFvy2ISnxb6gmfkxosYHYGD1hVe4kwOYPSSjqzgrMpJubIcY4zSxh9emrfmpuEuN
	FrzFsKA+vn6PDUisUwSUQCWSFautG/U7RAl3ZjD4tY5nAq3raSXM9vo8Rig/dypLI1cfrKRjSHq
	0Bh0vpehXVxn0TJtKb8LJZ0aSz0Md+QvEub+0N9W1A10CwBHlfPA7Zs3wYUVu9Qw32zEWvvtWtu
	gFVWAzuRSF8THo=
X-Received: by 2002:a05:7300:fb8e:b0:2ff:c84d:44d2 with SMTP id 5a478bee46e88-3081ffaf9acmr10481839eec.12.1781586765835;
        Mon, 15 Jun 2026 22:12:45 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43b80sm16726052eec.21.2026.06.15.22.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:12:40 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans Verkuil <hverkuil@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/4] Input: sur40 - fix V4L error path cleanup
Date: Mon, 15 Jun 2026 22:12:30 -0700
Message-ID: <20260616051235.1549517-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
References: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sur40_probe(), if video_register_device() fails, the error path jumps to
err_unreg_video. This incorrectly attempts to unregister a video device
that was never successfully registered, and fails to free the V4L2 control
handler (v4l2_ctrl_handler_free) that was initialized immediately prior.

Fix this by introducing an err_free_ctrl label to properly free the V4L2
control handler and bypass video_unregister_device() when video device
registration fails.

Reported-by: sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/sur40.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 8639ec3ad703..e9089b0c3e2f 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -787,7 +787,7 @@ static int sur40_probe(struct usb_interface *interface,
 	if (error) {
 		dev_err(&interface->dev,
 			"Unable to register video subdevice.");
-		goto err_unreg_video;
+		goto err_free_ctrl;
 	}
 
 	/* register the polled input device */
@@ -806,6 +806,8 @@ static int sur40_probe(struct usb_interface *interface,
 
 err_unreg_video:
 	video_unregister_device(&sur40->vdev);
+err_free_ctrl:
+	v4l2_ctrl_handler_free(&sur40->hdl);
 err_unreg_v4l2:
 	v4l2_device_unregister(&sur40->v4l2);
 err_free_buffer:
-- 
2.54.0.1136.gdb2ca164c4-goog

