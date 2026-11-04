Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793785379;
	b=KnNFU8sGCMpMEaPjfttt5Qtba3aHNm8v0RWba1iS9OvtcXLiws6+5wFPlnNdU3a68fHS
	 Ofi41TCiLv0DzYPyKMb8iLsbnXgRiv+snnYV3SVjcOoZkAZvsMeK9aTt3DfFOVIlXsPUK
	 hVRLWVLrujFlnP/iNK+MQTy8dviB+dse4sck/+1f32UcSjaE6WYT4CSksGmqnvtJBahzZ
	 SKfX2QKlXnODTFSK3SV73qKrKuaDD85c1EpLX3G+JgJi/k/2D6jiWxR2UL7pC7vBX+Pms
	 e1OxZ4JW4emeI82VJpLEjxCNoETjH0K/HRu8tXz4Q2b4xiaMq3Pbo51ojYcDyBttF6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785379;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Grixy0cTS0vlLMwQkhkeijFfOSG9PrTaZP+CZ7u6Ojs=;
	b=bFKcpA7OcXHfCoFpYsNZmqV6nYjF2LIHgZUnS+3djZENumCvkjifSmlYndqJ5Y0gDdRM
	 +CMlIDU3GKGaWHsjak1RqwSDLNV7hDYaoCH/pI7IqDM3QWrqf4NfHlnd/Q38AXFylg3YA
	 SAQq/o2562NW1eaCqPXtT5FERU8GrfjVnqrgsfzXx5rzg9bWoXvXBfPZbcYkWbGNtXZbi
	 1O/o8JJKT7SBsviKcfiY1p3nEAOA2stffpKpdCQG/s6ngdpMCgovRpxbcqMK7utpOgnqo
	 fPJmvIqIrCh0MnbuQW1VkXwXu6Jt2wtJdEtQqNRo84l4Fh8jZ/WvliriDrRnbAxiwfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6X2DAUL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8502D606A33D;
	Wed,  4 Nov 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6X2DAUL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793785379;
	b=Km6GG3Oc5M2aswEfdxmOBXiRa7mS/wAEPlEI2W1ciAe0/d1LaYMrj2qmDpfrklEneVYl
	 xS7bEVY9eeN9O/0sVjSheGBnwICY8Z3bbfJBFoWLCdd8Xtt2yUSQbQmnjX1yex6i1LHfL
	 4OA/2U/VppjyUobqp56P6NteOhkQ5xMMnsu08gWT3Fy/yuMtlxOGuu7lgjzYenOMjEeWJ
	 29cD1YzsoVWJ4GEjinQSMuYZuONDW9MsmwrmL0WWkYDn1rYyeHVBxlOWduAoArppNQv+z
	 Z9QfbaOyqXtDVENzwYv3WKd00Y3EMUDf5E9YDwotfYKsSKea24DeHmNGDblDj4T/jKA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785379;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Grixy0cTS0vlLMwQkhkeijFfOSG9PrTaZP+CZ7u6Ojs=;
	b=SMshQU6o86cP6kH41qFUL4CbkEuTwirWYgStxxyd7H1EZoQng8kHMQrDm/URkEcHELGk
	 VIE5ZxxALGMjWZ1NscDcBOExJ4Ru4iheFrZgc2a82AXN4PtqyagBtbZzf9snOtxcIULgU
	 yk1cp8Pu/bGHu/OmWeClkXdRMJlWmFrQTIez/nuUNnXQeo77zrfyzThXImr1Sfk5mfnMB
	 Q9WhyF/3Y28g9hZW/+i3vBgbbV1LTNs7GUWQOIMY0hAGGjyDkOFkVnfnoLURgGHxG8e3e
	 iPt9VmHH52YaVpcQ3rLfAoiHdEWIpm30A4X1rXhUPldktYEe3ibQL67JQ1cVf6gDuZw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 794881F00A15;
	Wed,  4 Nov 2026 09:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785379;
	bh=Grixy0cTS0vlLMwQkhkeijFfOSG9PrTaZP+CZ7u6Ojs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=W6X2DAULTi/eEJJYK/a6KsOUlSYFsgw4VYiNG6zUjjNk/0BQOxjaMK3KuXENQZBbM
	 TzUpo9nqUX8brQcvhygkhxbgXtd+pTMen93k5MLtTg49sYNHfaRNs1EyfmepG3ZIfu
	 Rsjbd+bz6xGh+IH3bK3ping5DfA6xTM67FFfIWrc+EJS8/yasL0HVKwYwqjOUMy4rJ
	 keue7qQXM/nwJ5g7XSlhRR6Ds2Uzl8rTR41RmK5R84NXRYpaqEIcf/auaZ7t5NT5kL
	 ZmWfWNNvg2bbVJHMjzbl5xof5d5LXEHUu/OVfClSMoLq/KiQt1mDcQYpmYvCcUTNnU
	 XHxEdmqET8WSw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DC60B46D74;
	Wed,  4 Nov 2026 09:42:56 +0000 (UTC)
From: Babis Danias via B4 Relay <devnull+b.danias.tutamail.com@kernel.org>
Date: Wed, 04 Nov 2026 11:42:47 +0200
Subject: [PATCH 1/3] media: i2c: ov8856: Don't power off a suspended sensor
 in remove()
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
Message-Id: <20261104-ov8856-pm-fixes-v1-1-1958b730ce66@tutamail.com>
References: <20261104-ov8856-pm-fixes-v1-0-1958b730ce66@tutamail.com>
In-Reply-To: <20261104-ov8856-pm-fixes-v1-0-1958b730ce66@tutamail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Serin Yeh <serin.yeh@intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Robert Foss <rfoss@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Babis Danias <b.danias@tutamail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793785376; l=2491;
 i=b.danias@tutamail.com; s=20261103; h=from:subject:message-id;
 bh=L0hpfrqG49Zm1CXdfuZ2hjqTYWvnPHNuq5J1KgmEnBA=;
 b=whLpfC3mk7QF56y/tO7n53TWmypmoddnNr//nUy7Vk5xStgGCQKpq2iywsz20FCe+5nGDbu6b
 77a8xYa2RBnCJPK36i9i8SWexnpI6fc40W+Q8obPu8DlrBA0b10/cp7
X-Developer-Key: i=b.danias@tutamail.com; a=ed25519;
 pk=6DWeigdk0D3JwBjwvmxo9RW8cG8S1Eku42cb9PP+ghk=
X-Endpoint-Received: by B4 Relay for b.danias@tutamail.com/20261103 with
 auth_id=1406
X-Original-From: Babis Danias <b.danias@tutamail.com>
Reply-To: b.danias@tutamail.com
Content-Transfer-Encoding: 7bit

From: Babis Danias <b.danias@tutamail.com>

ov8856_remove() calls ov8856_power_off() unconditionally. The sensor is
normally runtime-suspended by then, so its regulators and clock get
disabled a second time. On every unbind, the regulator core refuses the
extra disable with an "unbalanced disables" warning, and the clock
framework warns that the clock is already disabled and unprepared.

For the clock this is more than a warning: the clock framework keeps
one enable count per clock, shared by all its consumers. Where sensors
share a clock, such as the TPS68470 clock that int3472 hands to every
sensor behind it, the extra disable can stop the clock under another
sensor that is streaming.

This has been the case on devicetree systems since the power handling
was added. Since commit 609a71568664 ("media: i2c: ov8856 : remove ACPI
node bypass mechanism"), it happens on ACPI systems too. Seen on a Dell
Latitude 7320 Detachable (rear OV8856 behind a TPS68470) when unbinding
the driver:

  [  220.072107] unbalanced disables for CORE
  [  220.072109] WARNING: drivers/regulator/core.c:3262 at _regulator_disable+0xc3/0x150, CPU#2: tee/8667
  [  220.072825] tps68470-clk already disabled
  [  220.072828] WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0x82/0x140, CPU#2: tee/8667
  [  220.073620] tps68470-clk already unprepared
  [  220.073623] WARNING: drivers/clk/clk.c:1047 at clk_core_unprepare+0x1cf/0x200, CPU#2: tee/8667

Power the sensor off only if it isn't runtime-suspended, then mark it
suspended, as other sensor drivers such as ov5675 do.

The problem was found, and this patch written, with the help of an AI
coding assistant (Claude Opus 5.5). See the cover letter for details.

Fixes: 0c2c7a1e0d69 ("media: ov8856: Add devicetree support")
Cc: stable@vger.kernel.org
Signed-off-by: Babis Danias <b.danias@tutamail.com>
---
 drivers/media/i2c/ov8856.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 42c4b9c4e..988ce0310 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -2367,7 +2367,9 @@ static void ov8856_remove(struct i2c_client *client)
 	pm_runtime_disable(ov8856->dev);
 	mutex_destroy(&ov8856->mutex);
 
-	ov8856_power_off(ov8856->dev);
+	if (!pm_runtime_status_suspended(ov8856->dev))
+		ov8856_power_off(ov8856->dev);
+	pm_runtime_set_suspended(ov8856->dev);
 }
 
 static int ov8856_probe(struct i2c_client *client)

-- 
2.56.0


