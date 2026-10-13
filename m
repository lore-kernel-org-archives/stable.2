Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D865221CD
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912495; cv=none; b=S3rTG4yS8DjegdVp08p6RjF7AkQRggzspmmWGUoXytjFSbBnf/dGJ8K1OaD1FW9wuXo4K6CBa9Nz/yJwU78gx/4nE1ltPGFtxdW8hiUlPGJFQpD1UclxzaROdJNmFuGZU6reiKKhc0wIoJ1gqoU/xbLDSxHset5xFIKnjsOSSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912495; c=relaxed/simple;
	bh=5e/+ZH2xbeuqLo8Nu0AJc/uivNoZ4fkqFnMJ+s58+NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3btbtCW/zzorQJPYEutpeah05tXsg8ADR2WqcBP2lhMvJtWYVbrBzW4Ul2O9CJB+yo1y6e+ram8lKC+OYOVXovREA6HE6W1oOuXno5KsgUsgFCQYV0g9Wt3cgsuNZFkIGl0xs7J36HuK6EOPMDeVQVXaBLExLoKhWOZ0DYRNgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grg2iCQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grg2iCQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BEB1F00893;
	Tue, 13 Oct 2026 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912493;
	bh=8IHyKgytEIIzVesWxMUASLw5+dSCO/RZyjLDSUSShcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Grg2iCQKez1Y9V1OXVUsApcbXk4Fq5vCj5p/wkWFYy4WyNs/GBMneR0QcSwM+tNn/
	 ebBsXY409o9zC1eSG7q+VrNGQxbplwmPuCR3CICsqwvsQkYfL8Gh6wgzkMkUlK1JS0
	 lAUoc+Mi03hO7Q+vLpsoNoo/yUJMRwtrS/H0ZzTJLl+NsGLIU0G/OftIY1YtzD88Oy
	 N6h9/tbI48xwiYVdqyM6D5TAgjZX1u3DlUWH36AFMFmTD0njhx8ArgAPpAqfBDRURZ
	 ZihHZ4vFkGeQcIFIEGLVV3ZSPhf+4qf3lL9s8HhE3kAKSuxueQc4JtEeHnUuKzPaOP
	 /yB91qF+cfDgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/xe/i2c: cancel the client work on remove
Date: Tue, 13 Oct 2026 13:28:12 -0400
Message-ID: <20261013172744.427371-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101217-clumsily-geology-fe31@gregkh>
References: <2026101217-clumsily-geology-fe31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 611857adc9e7b0ee1239a0baf38498922ca5a12e ]

xe_i2c_notifier() stores the DesignWare adapter in i2c->adapter and
schedules i2c->work when the adapter is registered under the xe I2C
platform device, and xe_i2c_client_work() then instantiates the AMC
client device on that adapter.

xe_i2c_remove() tears down the AMC, unregisters the client devices,
the bus notifier and the adapter platform device, but it never drains
i2c->work. A work item that is still queued or running when the
adapter is unregistered dereferences i2c->adapter in
i2c_new_client_device() after platform_device_unregister() has
released the adapter. The work item is also embedded in the
devm-allocated struct xe_i2c, so a work item still queued after the
drm device devm unwind frees that allocation runs its callback on
freed memory.

The bus notifier is the only thing that schedules this work, and it is
unregistered after the client devices. An instance that is still queued
when the teardown runs can therefore write
i2c->client[XE_I2C_CLIENT_AMC] while the loop is unregistering and
clearing the same array, and an AMC client it instantiates late is only
cleaned up by the adapter's own child sweep in i2c_del_adapter().

Move bus_unregister_notifier() in front of the client teardown loop
and cancel the work right after it, so no new instance can be
scheduled and a queued instance is drained before the client array is
touched. A running instance still finds a live adapter, since the
adapter is unregistered later.

Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
Link: https://lore.kernel.org/intel-xe/20260912085932.101598-1-fanwu01@zju.edu.cn/
Cc: stable@vger.kernel.org
Assisted-by: LLM, in-house static analysis tool
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260928013030.612592-1-fanwu01@zju.edu.cn
Link: https://patch.msgid.link/20261006000413.318561-2-rodrigo.vivi@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit a23f27d5ec11c3f418c5e5531eea34ccda2b5b20)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
[ sashal: Adjusted xe_i2c_remove() context for the older teardown implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 25c7eb725ce26..43311886dbf81 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -330,10 +330,13 @@ static void xe_i2c_remove(void *data)
 	struct xe_i2c *i2c = data;
 	unsigned int i;
 
+	/* Stop the notifier from arming the client work before teardown. */
+	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
+	cancel_work_sync(&i2c->work);
+
 	for (i = 0; i < XE_I2C_MAX_CLIENTS; i++)
 		i2c_unregister_device(i2c->client[i]);
 
-	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
 	xe_i2c_unregister_adapter(i2c);
 	xe_i2c_remove_irq(i2c);
 }
-- 
2.53.0

