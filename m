Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047302;
	b=lgnrQXsoNzjIqYDsoDr+YgHVWI9TYZHZXpTv/p5b5YmWDhrgrmA1enPb9OBGxyPVRXDH
	 pv9lBYll3sCccw/d+JjMRYgPORHeTYTYrX2khbGZ6WQtgzwA9sw5Xivf7z+OlE0dS7CmQ
	 x/XflAFQpAgDFaT6v9aEfzpwu6AZ1795KEJJO/3uWMCKjWm67tmmBAe3KL2EJHRey9gbu
	 0SN7OcJCCCB3aniaJ4Q8AP5XjJ08+9k4oRzY0ZkKcfHQxZk07mOI5PWTMS2ZEgYdfNp3M
	 zB25vvXpLk5FhokLkif0WEoJQUl1YDr2oeAilpeAOqjJPBOp1hQzN/aRXb9AMvMipcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047302;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A0F3kbErj+5HYroaFeb6HHvh0Te9gAbNwDtnJLFHifY=;
	b=ajELXCBKhGEQrJ5JQtHtgsNTBdQAPFtEVYOdPhvXaIxweZ7T/ib807gWlUFqgVHiVAvA
	 1HyKV1kRKYK3xhsWbkuAqNi+xL3crYD79gaj09PH6EMiXX2VDJcBhauuuPXnEo7Syo3bE
	 VobqQoKxDxK70ASZU78TmzVTsllIEdMkIC+9k81bGPqoPqL/LUJpIK0Cv3Uyh64zmWGp6
	 aCbeTObtIvWa2sEWN7CGbdhco1miHYqnJhCmpbz3rHr+t/kHudLbu9DX8i+fTmN7FshNJ
	 Hra8WfqFcK/P3GYisLQj+rBjXr9SxfLOemXiW+zIZXDYzyKlRNo3meUG26oN42Sc0Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEzKy7Y1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189F606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEzKy7Y1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F171F0089F;
	Sat,  7 Nov 2026 10:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047302;
	bh=A0F3kbErj+5HYroaFeb6HHvh0Te9gAbNwDtnJLFHifY=;
	h=From:To:Cc:Subject:Date;
	b=UEzKy7Y1sIZ/9RhTnWNXnUsipsJiiJdjIu5BPJrRS74ZMq/ZyEMMorvWZCQlWAcfd
	 wg7+PRfHKsOPvv1KOoE4efuPXZm0eXQdEVqKy+/WDNA/DXKX9hsw5a6dr9cG3UjFun
	 w8GcdsbrEALcRLeid2JCGVojLB8/w7HYbuOf1eCI8bW3nKVDLTRpJO8aJx1Cfa6yX5
	 Qeewuk0NCfODPL+vFY2W4HPjm+TOTrhBX+yqXIn2lzzyiFEzG+l8ll54M3DAuGIU60
	 LDUZ+d0tPE0GSXS17yCKgbpxjQU23+ah9Gaa8w4LsYlKMFC2xAbgrwZ5E2KHkvxfSo
	 PVgo1+pVK1sYQ==
From: Sasha Levin <sashal@kernel.org>
To: sean@mess.org,
	martin.blumenstingl@googlemail.com,
	neil.armstrong@linaro.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: meson-ir-tx: Ensure rc_free_device() is called on unbind" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:20 -0500
Message-ID: <20261107052820-failed-6.6-32999b8a9d5c@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 32999b8a9d5c4f497c9739e70ac4ee390cd650a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052820-failed-6.6-32999b8a9d5c@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 32999b8a9d5c4f497c9739e70ac4ee390cd650a7 Mon Sep 17 00:00:00 2001
From: Sean Young <sean@mess.org>
Date: Mon, 6 Jul 2026 19:24:59 +0100
Subject: [PATCH] media: meson-ir-tx: Ensure rc_free_device() is called on
 unbind

Make rc_dev devm managed.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Cc: stable@vger.kernel.org
Reviewed-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/rc/meson-ir-tx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index 6beb9e97453dd..e8e3c1a303279 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -346,7 +346,7 @@ static int meson_irtx_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "irq request failed\n");
 
-	rc = rc_allocate_device(RC_DRIVER_IR_RAW_TX);
+	rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW_TX);
 	if (!rc)
 		return -ENOMEM;
 
@@ -359,10 +359,8 @@ static int meson_irtx_probe(struct platform_device *pdev)
 	rc->s_tx_duty_cycle = meson_irtx_set_duty_cycle;
 
 	ret = devm_rc_register_device(dev, rc);
-	if (ret < 0) {
-		rc_free_device(rc);
+	if (ret < 0)
 		return dev_err_probe(dev, ret, "rc_dev registration failed\n");
-	}
 
 	return 0;
 }
-- 
2.53.0




