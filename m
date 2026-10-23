Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792794709;
	b=fy4wVrs11gVdEW5Ox/IBCEIU6xDu9SrmeB2DYVJSFVviypm44UHkJoy8c6QSM9xloE9a
	 lbooD9tqORPkOEyNfmjsrzaXH6ZtGnzG7lC+H9EFqMIwVhGKk8e37tFWBg0uMLj0MDglz
	 lj199ne7yI8l82SHLY8ATFe980zBIf4AZMMKL2Gz8RDaaqYesgWQPp7LoFgqNwlbJIvi6
	 TFJREzQdWhDQeHiOCW+2E3O6MWx5+2G503eAFuOhLh/Apa6ua7bl7iqONx0W2/yRqMHYz
	 PW8txiUsow95aWqXhxeYRkPLPshdvDYy5Euvy9m88uZAAmWRimIZgW1xYKlfmtrBZKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794709;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ts2JArpXv12Ag0wLiAcW+EK0WDMQDNM4qEPFyO7KPi0=;
	b=N7WzPcUFVZa/tp18hxgJ+10O0nharTKXxlzIqZbvSkABiHcvIKvMf58muCBKcbZv2C9X
	 G6Fskt2VIuND/Iv4BRWBRRYe7NWOqR+XokR15E/90jTg5eOmJ0EgWZswlIKj+zJlOK9gy
	 Stw5eiHIMXhy0vGrS31gUK4j+hOnkOMbBmPNVAoYpuQM5j2a0eVza0GkkoD6zo4xcq3vi
	 C5/EDdBmMjED9Agjbj1zH4zjtRpuM1enKcCZfq7FeF7cAjsYLe9vudFBEAlIUs9mNLUMZ
	 /5STdomlrKPLmTsyOk/iYNCUEML+IW7BVChGjiSnYlak039/eiAcME0fziU1muvvDeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A/3fCnU0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89950606A31B;
	Fri, 23 Oct 2026 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A/3fCnU0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792794708;
	b=X5ydOumK0GMI9dRpk2l8h2AZsm7L8/EWwRzkquawxgyBDgxokvLVmGfSf8BMxWQlrszp
	 S5LERrp7b4dRqeobAqvh39zxqFBrbBWsMKDLqxCdl8/In+D1dahybtOHXX3VgH+OWiGI0
	 owVnSSO3g/lEpFz5EAFpaWpKVmrzsPOJmR7oeiCaQUQ7LBIj4J4XqumuPjnGKyJl1ynsC
	 GvXIYzZ/wuKy/6ODtKXCNyJEQXhiUBhUleHFgkuKuvfJJNqloXIWv1oenNEnz8QuRGQb2
	 vktDwkXdpN8CRl81F3eGL102fh+mhwi9FVhFzAdz2jljeZ/sgloSNPCUtmfMjK98bFw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792794708;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ts2JArpXv12Ag0wLiAcW+EK0WDMQDNM4qEPFyO7KPi0=;
	b=ufvYCGLhj5Tpa/WAKcr76y1sE3IOfXhKRDnHavQY6kpFoGs68G1OCucEYhY8aLmZo7oY
	 4l1kaoKv23zSRdDLX+SRSZ2PJqbMkeN4nTId4HT0W7+PJgrLZO+X7H5+h0m8soUc/TC1X
	 H/SXlrzUGOHrekZfeojerTcTik+WYaQeMBJaIvGZbGaPAJeOhRA3/P6ucVKGmVrLHpiI6
	 lY1ZbLhIksGpg7CWMlQFKxmWuhRt/jIVtdO9FZ9QfjnL1/QM8M/humaDzJXG2nQ7TtFr1
	 LeHFNd3u5W8mA5Tpe+WgVrKyYCy+RaZHE6WnDYaTFNB/tjCvr994pRsw19YThzheKnA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 82EB91F031E0;
	Fri, 23 Oct 2026 22:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792794708;
	bh=Ts2JArpXv12Ag0wLiAcW+EK0WDMQDNM4qEPFyO7KPi0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=A/3fCnU0KVVNCZ+iQiu39XSlvuuDHjBdDrhE9hLqwuRk2E5IV78TXtF3cErFLXTqd
	 EmLH2jYTY3q++PlvwruIIxTB02YdqdjHeX//z6O8Shcqszp+pW+ArBAylLqTzl71zz
	 S/NS+yUihemxCaQMDO513uaCjQCxX93CdlvFR2AWdt+ZDnzXy97ZdIMI1Olos9fFy4
	 qZVaFuF3DvxkAJAuhBUTUUNW5EsG32w/Xy/77VKaXDuqrcX5NKu5hnzyLBdWiUYcI/
	 P+i6qgvtuMj9rCT3MwReQg84OisqBU3/AogrkpZzFKBdeKQWiyuJkz39VemZ8a2s/T
	 NZAs6Lzar4Dmg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E247944637;
	Fri, 23 Oct 2026 22:31:46 +0000 (UTC)
From: Max Bretschneider via B4 Relay <devnull+max.bretschneider.leica-geosystems.com@kernel.org>
Date: Sat, 24 Oct 2026 00:28:51 +0200
Subject: [PATCH v2 1/4] media: i2c: ov08d10: fix NULL pointer dereference
 in ov08d10_get_hwcfg()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261024-ov08d10-get-selection-v2-1-f8c49972ca18@leica-geosystems.com>
References: <20261024-ov08d10-get-selection-v2-0-f8c49972ca18@leica-geosystems.com>
In-Reply-To: <20261024-ov08d10-get-selection-v2-0-f8c49972ca18@leica-geosystems.com>
To: Jimmy Su <jimmy.su@intel.com>, Matthias Fend <matthias.fend@emfend.at>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Max Bretschneider <max.bretschneider@leica-geosystems.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792794706; l=1799;
 i=max.bretschneider@leica-geosystems.com; s=20260501;
 h=from:subject:message-id;
 bh=eLsu5tl24BX1oODaXRTSuCWikGC+/dtd311jxFs+7AE=;
 b=hIO6AMJ8wkZArMvQX4UdhsS4mGWC7tFTaNKFIJofJApLN7LIonU+0mTVcVqJhgr1UK+Q/hQ1o
 u2eYkdGBrGpDi/ultjbXix/+rkLTEsPUvZ1xNvM/EtGXluyg0KN70GC
X-Developer-Key: i=max.bretschneider@leica-geosystems.com; a=ed25519;
 pk=jf4ba33jrWlsOdGemi2InMtJAngoJVZU8Moetp0ixik=
X-Endpoint-Received: by B4 Relay for
 max.bretschneider@leica-geosystems.com/20260501 with auth_id=1161
X-Original-From: Max Bretschneider <max.bretschneider@leica-geosystems.com>
Reply-To: max.bretschneider@leica-geosystems.com
Content-Transfer-Encoding: 7bit

From: Max Bretschneider <max.bretschneider@leica-geosystems.com>

ov08d10_get_hwcfg() logs the number of data lanes using
ov08d10->cur_mode->data_lanes, but cur_mode is only assigned later in
probe(). At the point of the dev_dbg() call it is still NULL, as the
driver data is allocated with devm_kzalloc(). ov08d10->priv_lane, which
cur_mode is set to point into, is only assigned on the following line, so
the value is not reachable here by any route.

The arguments of dev_dbg() are only evaluated when the call site is
enabled, so this dereferences NULL as soon as debugging is turned on for
the driver:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
  pc : ov08d10_get_hwcfg+0x1b0/0x228 [ov08d10]
  Call trace:
   ov08d10_get_hwcfg+0x1b0/0x228 [ov08d10] (P)
   ov08d10_probe+0xdc/0x658 [ov08d10]
   i2c_device_probe+0x194/0x388

Print the number of data lanes parsed from the endpoint instead, which is
the value the message refers to and which has just been validated.

Fixes: 7be91e02ed57 ("media: i2c: Add ov08d10 camera sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Max Bretschneider <max.bretschneider@leica-geosystems.com>
---
 drivers/media/i2c/ov08d10.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov08d10.c b/drivers/media/i2c/ov08d10.c
index 0710d2243cc0..4dc68ff89eda 100644
--- a/drivers/media/i2c/ov08d10.c
+++ b/drivers/media/i2c/ov08d10.c
@@ -1432,7 +1432,8 @@ static int ov08d10_get_hwcfg(struct ov08d10 *ov08d10)
 		goto check_hwcfg_error;
 	}
 
-	dev_dbg(dev, "Using %u data lanes\n", ov08d10->cur_mode->data_lanes);
+	dev_dbg(dev, "Using %u data lanes\n",
+		bus_cfg.bus.mipi_csi2.num_data_lanes);
 
 	ov08d10->priv_lane = &lane_cfg_2;
 	ov08d10->modes_size = ov08d10_modes_num(ov08d10);

-- 
2.43.0


