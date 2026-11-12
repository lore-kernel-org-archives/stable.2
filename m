Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504918;
	b=hHlI6lSoXgO9kmhRO4ONDxrYQl28hJnvJwd/GNzabxSLnQiVCXzOAHFR69iS0V6PVyeN
	 6IV5wQzgsbeirGD9OxQTxFOvOU5jXeBiB1gAM3mSdQbSnPOA1thp/ktboKrFbMJe17q7e
	 pAbrtxpU9U9Yr42tGy/QHL/6b4HPia3uaDEr804jGKA+5pd7MnCuyCBc6e3JEoEfd9XG+
	 UPmJDmhJW/uAEK7hCeCAd7eYtv0rBoS5KWjn0L1m2xC9xesIx9WfbgI7/ybFH9mE134on
	 v9em80AgErrk2knrcqFyUtOTq5AJCX2H1ZrRTpGqE8sQu8M8tfJpEGtk/WksEr6xSCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504918;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ma+uMnAhYBbLBU28/E88OEuhYN6ixczw6Fbs6IO+2z0=;
	b=z/Jfmq31V8oqNQ/Hf2iV3yp2X+7lLyaV4/b+MOQVxVj/clKlslCs5apK9jSsJcIcF85A
	 vcs70UdLwlpCAd03aJNLfBsMYGjP5+dkxH9P76+MtsU1RVC5N8imnXbp33H1QcD7ht2Lm
	 JXC+GVIyUqi+BBv68VH7CTKNWWrm7Bq7Bz6ZHM1X77RUU1IIx/l993/yg1RekhTvlcZXl
	 Fdp4XVFe6dAJ+ob38jafTXUj5umuPqKgkFHbPO3Lzq1xnub8GSU/JbX2uoYnyVrjWPBQ+
	 TgTfn2j1jZmQrr2UvqLrk629hQqp46FgV80cyP9V6lWjiv6QwAaZaUBTSaTcOzWuguA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2Xo0J7h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFBF606A33F
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2Xo0J7h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C601F000C4;
	Thu, 12 Nov 2026 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504917;
	bh=Ma+uMnAhYBbLBU28/E88OEuhYN6ixczw6Fbs6IO+2z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k2Xo0J7hbx4Gr/Q774AjQWRKJmUSn/wfKXYK6gollzQaEyWtnyzbAbCXzJvUV553x
	 eTpB8i8/DpVYYH4ZBj1lo0+CZkLeGGhbpUr/1UHBJjVZIiF8uIlJ59a9RsXFtoFVjg
	 RuyIrBjBheo40hwZv7zgbZzs9mgl8nuoUzKiq5u/YLMPZiB8WbToXwINqjk61z9nc8
	 Mq5cDZHJcE9skP3137sdwHCNL+o6U1Ip1G0p1IoQsB3plzJ6ByoLCKizNzSWyu5LgE
	 QorlvaIaQZb20/8cPdWUOOMJc1VGe/nHco//epIywJ1TcyyCZyH9ahudP21iKMUTXE
	 UcLaR/aR9ex0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] hwmon: (coretemp) Read TjMax only when refreshing the temperature
Date: Thu, 12 Nov 2026 12:35:15 -0500
Message-ID: <20261112173506.3075837-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200125-failed-7.3-9a6aa085c94c@kernel.org>
References: <20261109200125-failed-7.3-9a6aa085c94c@kernel.org>
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

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

[ Upstream commit 5407d2b7d5279b7100621d92f2181184c8f00d62 ]

show_temp() reads TjMax before checking whether the cached temperature is
still fresh, but consumes it only when recomputing that temperature. On a
cache hit the value is discarded.

Discarding it is not free. On CPUs that report TjMax in
MSR_IA32_TEMPERATURE_TARGET, get_tjmax() returns the value it just read
without storing it in tdata->tjmax, so every call reads the MSR again.
That is a cross-CPU call whenever the CPU owning the sensor is not the
current one, and it is made while holding tdata->update_lock.

Read TjMax where it is used. The value cannot go stale in the meantime:
bits 23:16 of MSR_IA32_TEMPERATURE_TARGET are read-only, and the register
is package-scoped, so every CPU of the package reads the same value.

The temperature reported to userspace does not change.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Link: https://patch.msgid.link/20260924-coretemp-temp-fault-v1-2-1884f0ff97d5@linux.intel.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: 9a6aa085c94c ("hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 2d7487b2f80a1..7fced0e2abeba 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -406,9 +406,9 @@ static ssize_t show_temp(struct device *dev,
 
 	mutex_lock(&tdata->update_lock);
 
-	tjmax = get_tjmax(tdata, dev);
 	/* Check whether the time interval has elapsed */
 	if (time_after(jiffies, tdata->last_updated + HZ)) {
+		tjmax = get_tjmax(tdata, dev);
 		rdmsrq_on_cpu(tdata->cpu, tdata->status_reg, &val.q);
 		/*
 		 * Bit 31 indicates whether the reading is valid. Some CPUs
-- 
2.53.0

