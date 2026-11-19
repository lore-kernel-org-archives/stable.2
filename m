Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117791;
	b=jl6ADOdQO5LTDqzfmc0rF3hW/XbHzJVRQv17MEl7w4WisFskHre/XclWSKIDf+8Nn5+j
	 bJLSMYlZNZDWb9BiQlSoSj8kV0VtiC4Cjb6b6JMOYfqHCPwh68BWEtfeDLzZvdmHscSb/
	 b5tlVL0E3R4s9A6ITlHW7260BtIJyp1sT/VKRuvh7B6c9JQjla6KZ6HjOw2LTHvqTSYyh
	 ++Tc5dZb4p6mDBqX39BAmK6TOE+bbZPKR8Bb7B6M0mCmFCCcAYZO0gbFiy5borUF5jnY5
	 l5PGfvmhovL+AiXNvl5k2DZgmN9lYMFoeLWUU3ZClHhPP8lCr0LHtgi3bZYiT3n//Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117791;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Mt0OZH7DK0jpPILxOpJd8SFj/UQdh0ixbhSO8Lem3dI=;
	b=qnpu8fY1JQkkaTpoz/HoyqBUznX83PGInHtf9SamQHMrCU6/mEoKiHQR1J0U82P4ceq8
	 KzMSIFSxgObrW8fRFWFoMlRZCB1U3PeWq1ilw9tGE8gctBwBd52q++0M/AhUOYa8uvrcx
	 SJZE7Ev9+FNJSOEWYkNSdpeSWhwAmQwfJm2rrqLe7C+VAeIWDT30R8vazwvu7tog084pY
	 d5Vfah7GFTemd6sWXkvlkSUM7y3wQ0kMKuieiQ6/FzwneG3h16HGFj9l1EUyMkSJD6aj8
	 A7FIgFBo51BWr+6vTeOAJ3p6asA/32kldNuLtw3ZF/y5a/3zEjsKcJ2VmsBdVhUPNPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XL+oSOub;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ABC606A333;
	Thu, 19 Nov 2026 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XL+oSOub
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56EC1F000C5;
	Thu, 19 Nov 2026 19:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117791;
	bh=Mt0OZH7DK0jpPILxOpJd8SFj/UQdh0ixbhSO8Lem3dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XL+oSOubvp7BVBwOu4I6g16r/mEwZuOIbdLcuDy6w+x+b6Zza7GZ6/6CiG9JE/DIu
	 cRBMx7zHL9Vdo3XH24K+Dv3k3H2/CBWpzIrbdhC3T6c/hQSS8EQAl7xYvjo/BgUMkL
	 zB1Btemh4X/1P+v0jsoQpJ77nYdOyvPv630EmohjeEgNbdfiru3CG/z8yv/pUPsetC
	 v08rxszI1ZxuK2U2pnEf/ZT3GuQm01YH4zjXWrjuaBd+dG95c86OGFWWPQZBiiuLSw
	 /B+9m0NcB70vvcdUtpt7Xc5he0c2vV69uPSJgvqoJBg15m3CEZLjrFSSB9YAuzw5wo
	 3pD3K3+vYMfeQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Kai Svahn <kai.svahn@nokia.com>,
	syed khasim <x0khasim@ti.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 1/2] mfd: twl-core: Clear twl_priv pointer on teardown and probe failure
Date: Thu, 19 Nov 2026 19:49:29 +0000
Message-ID: <20261119194939.2436337-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119194939.2436337-1-lee@kernel.org>
References: <20261119194939.2436337-1-lee@kernel.org>
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

twl_probe() allocates the file-scope twl_priv state with devm_kzalloc()
and checks for a non-NULL twl_priv at entry to reject multiple device
instances.  However, twl_remove() and the early error paths in
twl_probe() never reset twl_priv to NULL, a failure when adding MFD
child devices bypasses twl_remove() by jumping to out instead of fail,
and twl_remove() tears down the IRQ domain and dummy I2C clients before
child devices are unregistered.  After devres frees the underlying
memory on probe failure or unbind, twl_priv remains a dangling pointer,
causing subsequent exported API calls to dereference freed memory and
blocking future probe attempts with -EBUSY.

Unregister DT-populated and MFD child devices at the start of
twl_remove(), ensure mfd_add_devices() failures unwind via fail, and
reset twl_priv to NULL in twl_remove() and on probe error exit.

Fixes: 80a97ccd33be ("mfd: twl-core: Collect global variables behind one private structure (global)")
Closes: https://sashiko.dev/#/bug/linux-73e82f84-94de-4d08-82a4-f22d42a1dedf
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v2 => v3: Rebased onto for-mfd-next (the free: label is now out:)

 drivers/mfd/twl-core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 55a7f579595c..7784e000b995 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -691,6 +691,11 @@ static void twl_remove(struct i2c_client *client)
 {
 	unsigned i, num_slaves;
 
+	of_platform_depopulate(&client->dev);
+
+	if (twl_class_is_6030())
+		mfd_remove_devices(&client->dev);
+
 	if (pm_power_off == twl6030_power_off)
 		pm_power_off = NULL;
 
@@ -708,6 +713,7 @@ static void twl_remove(struct i2c_client *client)
 		twl->client = NULL;
 	}
 	twl_priv->ready = false;
+	twl_priv = NULL;
 }
 
 
@@ -883,10 +889,10 @@ twl_probe(struct i2c_client *client)
 			num_cells = ARRAY_SIZE(twl6030_cells);
 		}
 
-		status = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
-					      cells, num_cells, NULL, 0, NULL);
+		status = mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
+					 cells, num_cells, NULL, 0, NULL);
 		if (status < 0)
-			goto out;
+			goto fail;
 
 		if (of_device_is_system_power_controller(node)) {
 			if (!pm_power_off)
@@ -903,6 +909,9 @@ twl_probe(struct i2c_client *client)
 	if (status < 0)
 		twl_remove(client);
 out:
+	if (status < 0)
+		twl_priv = NULL;
+
 	return status;
 }
 
-- 
2.56.1.750.gf70dc682cf-goog

