Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315182;
	b=GaF11UWR1msNfkainZhBgD5LtirNu86d1VWDoFEe/AewLJBQ/Mw4wuyBvzzVe+BId5Mg
	 bQSrVwOLtQ2WrklRLtrQ76V1lcAHCu9/AR/yidAZiBQDuKL+QJ/cyyMabDyy2XTfMPzFF
	 0K0ElbJ7KrBC9GN0Jfu8iwcGR4+icIrarsERQriBamsIhIFDDwiEeHwA58yRWn/9NR2bV
	 Bks7Z8UF/pSVgNMmDPf1YXbzw/wEHRHCEcFbBiCAk8RYsTvL++soIy5O+WXM3N9mS9eIr
	 +0aIMwf5QPfWd9oRVTUK7qErq7wYCbvxXf4QhuuP6OKoT9f5MxZyEvC0ylTMOzpSXZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315182;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I6OS/PsXXmtaHei0iazsVJcn43LqqmSBqpXuApul4j4=;
	b=Gh3t07el/3W5wdsPASUi5j6/Z8a8cGrSd8klUE1WhRlvQXYUi+oH3yk93eO9dM57AhHV
	 3eCclFv5Y3Q+kepGcQPQgXdOsz0GMMx0kIgDeDjprhne9fMfomykfESNWU8adv9zCw+H6
	 ZdEHQHtR9CHE1fNkS2+jDTZGU+bzj21ncjmjUuQ95dJRpyfhBAd/RAgkRtMW1u5e7blcV
	 Nee/xXN1J7GhlAOw0vV07ScJXsYXJ2FnhzQpq7iAIFC7CTbhEG6GKfv0OCoIrTL+15mUt
	 iYVAaFsRqmID0paD1I5r+eR2Tj8QPnO5YfmK4VGrmiy05/nSHoRjjpS5Xz5wqKBmfMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VG++cJtx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369C606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VG++cJtx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C83E1F008A2;
	Tue, 10 Nov 2026 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315182;
	bh=I6OS/PsXXmtaHei0iazsVJcn43LqqmSBqpXuApul4j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VG++cJtxQ4digtJCVFiXz+jQeb+O3w8K0xK0EagP/uzEqvgIR13co3YHAYFc2GsPt
	 R9qJuUwOH7RbtMdKousKhGvIJyn+TALBv9IkKRPKocvMYomkep/tmtkl3rPqhXUmsj
	 dwXfzbOozM2Rlio4mRjHh67XPI9Tz+IfWkJoMEZgj4yHR7cZAuzxX4chj7xxpHsEnX
	 hcdMih1l+cnokOZy/r4KDiFf5KjK3tiEVg/+fD+IrIhPm/O+0//P8KzLjh1o4baxax
	 MkJ9ddmOvWfAht1y1LTIvsK6BAjvjPbvXIx6J/Z9DZM6zLXI4s3BfBVJXvA2KWNXXi
	 s6/M44zS4QnrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] media: i2c: og01a1b: power off sensor on remove
Date: Tue, 10 Nov 2026 07:52:59 -0500
Message-ID: <20261110125223.1528685-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110125223.1528685-1-sashal@kernel.org>
References: <20261107051703-failed-6.12-a26c5ac46191@kernel.org>
 <20261110125223.1528685-1-sashal@kernel.org>
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

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit a26c5ac46191ae34b3413f7a45d6241f63e15d42 ]

og01a1b_probe() powers the sensor on explicitly before identifying and
initializing it. After a successful probe, runtime PM is enabled and
pm_runtime_idle() is used to allow the runtime suspend callback to
power the sensor off.

The probe error path explicitly calls og01a1b_power_off(), but the
normal remove path only disables runtime PM. pm_runtime_disable() does
not guarantee that an active device is runtime suspended, so the
sensor can remain powered when the driver is removed. This also leaves
the xvclk enable performed by og01a1b_power_on() unbalanced.

After disabling runtime PM, check whether the device is already
suspended. If it is still active, power the sensor off explicitly and
update the runtime PM state accordingly. Avoid powering it off again
when runtime suspend has already done so.

This issue was found by manual code inspection.

Fixes: a95ffde28783 ("media: i2c: og01a1b: Add support of xvclk supply clock in power management")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/og01a1b.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/i2c/og01a1b.c b/drivers/media/i2c/og01a1b.c
index 95ead31dda278..cc8ff6ffd29ac 100644
--- a/drivers/media/i2c/og01a1b.c
+++ b/drivers/media/i2c/og01a1b.c
@@ -1042,6 +1042,11 @@ static void og01a1b_remove(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 	pm_runtime_disable(og01a1b->dev);
+
+	if (!pm_runtime_status_suspended(og01a1b->dev)) {
+		og01a1b_power_off(og01a1b->dev);
+		pm_runtime_set_suspended(og01a1b->dev);
+	}
 }
 
 static int og01a1b_probe(struct i2c_client *client)
-- 
2.53.0

