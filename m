Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795418828;
	b=BW72pcfGJnWukQjH0LwJXHCr1mv6rJ/AywBSyTkJz0EcpZMfm4K7N5645WTd8R38ERKI
	 v/lkl3TMDF8H8xzJd+45rcLm2AZATH+xC2yCkm+Fp1TGk2upmAdH6+bYNlDAH9vVBnvLO
	 +q+6QU8kvdBZ84SfeQYaEPx6zKTqqwgbjETVc1CCKYWC4JXROi8BocPDfF/CJKm1zJE/o
	 wPXUCLqK+QGvNYOwXobxW1jzW8+wcHxNlnNZWo9TEDEiHyzaoHhvIPnZ1SdD7hf+fYy72
	 Nu1N/2iDPkL3qSdgYJgwxjWSnrTMch0Ka/87UCPKS6bxlVtgQRPDspOCH9ozztGupfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418828;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=U6wzabnLt/RWDyXyIjQiK5gCOoeM22ljx/BRBNPG0BU=;
	b=VN4fY9FbqvoZOKPWB2jP2vnliyxd4aH7R0J3CsWNWAH/vTE6PGUo2tLBTNq8YRSwFjl7
	 Ag6F3ACO0CGgq8VEbcQNXzXGdmkBUqkjohyVM5KFY67po3NdlH64vlZ9JbmD9DQbyHDl0
	 bcaMWbeIquJn6OKEGqcbnN/IljXrF44p2vd9aA0N+fCciaJDUgyB63VkYMwNObPdZTocz
	 x1nrQntAz252cr9N+KIlnOg/28m3gyWpL093UGbYvBw+AhCsR4hKgN0PtSveou/DPRtxa
	 e8LaS67Wo1l4Czqdt5SsAxVwDEmN60dzuzE7HYoXiCyMPUdEAWJPtawg5aESjYUiR3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mccxhhj4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C6D606A31A;
	Mon, 23 Nov 2026 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mccxhhj4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795418827;
	b=zuLSfWD3PmDDZJeiouEWrIIN/pNYWkxAj+NWYwllEo97X5wjrZf7AEdPo9cPH01rB6Eu
	 MImRyLKUcSZbSMI8t7WSn9Y49N0bC+Td2tFyZ6DfSr52RtwEvg3yKoJIceOYsRuqe7Sql
	 Jn5nG2yuA7L32m5gSZjJKqgM3L5siwvdi+cGmRLdRxAT3OYnfyVgq8RqUXiOyoUjLKdKi
	 K5J/YrZh1/DKewovWsSd4TdV/JlgynifEKHwS4sU9J+02NniKWj0hoPQL4pp2c0WiJ8gA
	 qx1oDTWsVDFEqubl2ZQSRvBM9evO47gqfN6TnH4BBXKqIl/RCuZ5z12kKVOl24lnCFg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795418827;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=U6wzabnLt/RWDyXyIjQiK5gCOoeM22ljx/BRBNPG0BU=;
	b=Ybrgxc/n95J49gRhmL0f39qOATiB1HosXNn7/0tkW2TX8Ix0+gSnGKkulOxMuBD0U3Dy
	 30r2DLDEO7tqKJGXcMfea2Iw1sLcoyqj36U2Hy20FzFD3VcNVhphkEPJofTtPGacUccHl
	 zGFw9iynCsIK9D8irKdbgshu2lZgLdeVsNtTpYqCyyKjoRPmXtgP8Qj8YAp3U/Jm8vuOk
	 U20r/b6EOypcg2WyuxQY+NQVdqdydYACChupBwsqsIMZunTLDFagRldLV3/PxVEzjqcwb
	 C/TjPYVt2qBW8ypU29mdT++TiGAyd66AA/2ewLPrwVIL5daoxazONSpnXfPVNth3Tvg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 578EC1F000C4;
	Mon, 23 Nov 2026 07:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795418827;
	bh=U6wzabnLt/RWDyXyIjQiK5gCOoeM22ljx/BRBNPG0BU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Mccxhhj4llERRyqRFaSx+9ezzKC78+yO+LdmfuvA3qUSctlffBBwFGdTCIFB/jtVl
	 m8xrCSSBo9yqFChto97u32yd7fEIMjwY2aY5umqqYhJn69qHO9LH+VIm74zIwT4rBR
	 1KTX3M4nqyc0O3J3OPWzjPvC/KWvWCIU3uB3KypHxiriQj0EF96FQPUbzb1dDDu87p
	 9waNDZXMMdLIv09L8jraK4+5cheHWWOR1zISiSlwqZ8pYAgTWlKtq4mS7cVBdnIEof
	 qXAeJFLaMt3LcAlbqcspuCoL1JF7PW/Yda4Uij/N1vSttkPqvcBna1bS0B4DwjzM2H
	 02jwrUTU+0Emg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AF4CB4C3A1;
	Mon, 23 Nov 2026 07:27:03 +0000 (UTC)
From: Markus Haberlander via B4 Relay <devnull+markus.haberlander.rosenberger.com@kernel.org>
Date: Mon, 23 Nov 2026 08:27:01 +0100
Subject: [PATCH] hwmon: (cgbc-hwmon) Add module alias
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
Message-Id: <20261123-cgbc-hwmon-alias-v1-1-3054681f984a@rosenberger.com>
X-B4-Tracking: v=1; b=H4sIAMTqA2sC/yXMTQqDMBBA4avIrB0waSviVcRFMhl1pI2S6R+Id
 2+sy2/x3gbKSVihLTZI/BaVJWaYsgCaXBwZJWSDrWxtjL0gjZ5w+jyWiO4uTrEeODSer+RvFnK
 2Jh7k+192/Wl9+ZnpeXxg338lcVuKdAAAAA==
X-Change-ID: 20261123-cgbc-hwmon-alias-6fed8be4cb52
To: Thomas Richard <thomas.richard@bootlin.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, stable@vger.kernel.org, 
 Markus Haberlander <markus.haberlander@rosenberger.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795418823; l=1376;
 i=markus.haberlander@rosenberger.com; s=20261123;
 h=from:subject:message-id;
 bh=I1G2jkZQpMOQFY8S2qM+BAuBa5MQsimUYIi/nZNT3CA=;
 b=OPb4kGeErThGeH31e2Fvv0Y1ezpEFO3smdYlSDWT5OvuRRONVNquQBPgXYmnV3OBpGIJ2PD+p
 DFaxfT6oeeOBHFOkoVSsQR8d9mxOURiycJfjK6EZDumLkBGfkH+m5KH
X-Developer-Key: i=markus.haberlander@rosenberger.com; a=ed25519;
 pk=baNIWlZCf58g17gE2FS6ir0ymNwyBXguoQENSJkXdeQ=
X-Endpoint-Received: by B4 Relay for
 markus.haberlander@rosenberger.com/20261123 with auth_id=1612
X-Original-From: Markus Haberlander <markus.haberlander@rosenberger.com>
Reply-To: markus.haberlander@rosenberger.com
Content-Transfer-Encoding: 7bit

From: Markus Haberlander <markus.haberlander@rosenberger.com>

The board controller's core driver adds the hwmon cell as platform
device "cgbc-hwmon", but the driver declares no matching module alias.
Built as a module, it is therefore not loaded automatically, unlike the
GPIO, I2C and backlight drivers, and the sensors stay missing until it
is loaded by hand.

Tested on a conga-PA7: with the alias, the driver loads at boot.

The patch and this changelog were drafted with the help of Claude
Opus 5.5 and reviewed and tested by me.

Fixes: 08ebc9def79f ("hwmon: Add Congatec Board Controller monitoring driver")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Haberlander <markus.haberlander@rosenberger.com>
---
 drivers/hwmon/cgbc-hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/cgbc-hwmon.c b/drivers/hwmon/cgbc-hwmon.c
index ba21ed8f0..d1f20db4b 100644
--- a/drivers/hwmon/cgbc-hwmon.c
+++ b/drivers/hwmon/cgbc-hwmon.c
@@ -336,3 +336,4 @@ module_platform_driver(cgbc_hwmon_driver);
 MODULE_AUTHOR("Thomas Richard <thomas.richard@bootlin.com>");
 MODULE_DESCRIPTION("Congatec Board Controller Hardware Monitoring Driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:cgbc-hwmon");

---
base-commit: 7940d60c4b165cd7c265bf17f86b8299b7f204b1
change-id: 20261123-cgbc-hwmon-alias-6fed8be4cb52

Best regards,
--  
Markus Haberlander <markus.haberlander@rosenberger.com>


