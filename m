Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795652179;
	b=GrcQYw2VmyE7oZUTdjKXb09XpxcAkloRkbdy62NCx5v1dC9vA3sc1w0PgTgdEFY6Gbcu
	 1miKl+CEzu4SenZIT0FlTwND8WUpFXCCESfN6Sn2aFnMCjjEl8YFE1O98IihMWyiE8nBT
	 RybTFtTIty8kJU5/rxxp4L/zha9c11oycCJ4CDDyCiVIm2fEZCx1o+QElWDcgjneyEKnG
	 Dt/9zvSTN/Dl47olW7M8UwonF1pe3/OULVBYS/kIyOES4Rev9PbojNZU3TsdnQkn3dwMl
	 RduDbmtPqMQHeQ5LZH/o4+X+l0LQklfjamC3W2JE2qHoGBQu3U/TjipaRZXIgWQaL3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795652179;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zNmJAkA6y9juDpGQpY7+mrGr13D6iYwVy8Jvx8ehUd0=;
	b=XHXel32/fzqyfXA8kMD5lw1szg3pLEhIyi31iW4AbFwOBiFmUQuk1obFgTt3xBRJrKpS
	 JhkmIvL2pwDVWmk8S/9BFuLLq/vRQ2MkX7y42x/yHZdcwudcx7r+8mkWCulT3uc/nFYkQ
	 9tbFk8vNlYnRuz3C6wfZyQUTo5zC92o7iPRGwMAlpZIKSIsEKk7CwcrwBUNzlIvm3F6GK
	 M0ma3LvniHeb4dvXgbNMwb68VoakkjXAzwr3Lv2IOpGyzbEZ9lnZ4CVazwAU+CVtLak5x
	 cIRmyEYS26whpRAyfIneOZvhUqQmvIl72WLGQCoEA78BToEKJAoZSMMa4PZvamP3+gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owVAGp9V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C38606A31E;
	Thu, 26 Nov 2026 00:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owVAGp9V
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795652179;
	b=VrUIeZ9CxcxAi7DM6vfG4NDeE5HmArA9/vSvG/MS+zUbF0jPKAHFcu8LTNofgULj6dav
	 DKUKcYn8OBYoMCEsgoj9OOzmopCPRGtohZT8sIjxl5x50H8EtCdR10Ni95yCMKzMVVAuw
	 QUXtWvMi8xDKo+BkFGPiQ20q35/cVs9fTJHSGTQmSZZyEbngdPSDTo2YueHWqOO9O5QYz
	 U7/4Qd31oFXMcHILScp27ti39/W4I2dGsi3MofkxWFdJ9ix11JmMLZwO/B8ddVj+ze07t
	 UtEzTHlwdDyplU9CT8ue3hUs1M3MqDAAgNBNSGsBO+XS1kavrP9yLASdn1SqKBkH1yQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795652179;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zNmJAkA6y9juDpGQpY7+mrGr13D6iYwVy8Jvx8ehUd0=;
	b=ao6pvecwaAKmOoepMiOe9Rp5bYBvFagWXZMbebi1Qpzi/a7r7JhoJUOhFZr3Wkel/O15
	 mO8w0GqxCsCjuowHg7ncjAUGusCI+AyPPlT0a0H8tj85pqyovhd8ftFbLwsONy9MLcQz6
	 83fZMzqfSh7JFQr8frSWMlsDWQ43o4ZPI8zYp1gVDdnMi64cuEwVxHnArSzNYm/LVO4Ed
	 nBY8H/EXiVUWuYWAlSNYB9u+YoV9+eIlelhud8jSZI4zENZOSGcSRnIpW9Jh1lsHzYT3m
	 z/60yHowQgBophmx/Smll0pAVQ7tl0IMQzplewukGT9n+sSn+spH3LcYIPRc2m3KKNA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4A4701F000C6;
	Thu, 26 Nov 2026 00:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795652179;
	bh=zNmJAkA6y9juDpGQpY7+mrGr13D6iYwVy8Jvx8ehUd0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=owVAGp9VL8YsabmKuhZSToT4WI4zJXF3xRrZyxoZMzC81nPIg714hZfhscuouST1n
	 hJcdGaIH5gQKMJFvFvJO2//FSZabCdk7Xb+glVr5Oox+wvdiCa219qDuqOg8VXz/1m
	 jy7JWjwuIClQvJtzyBMsdvmkC6AhqxXn1DKYY0y1NJr+V69mfZZaOwDPcw3Feaof2+
	 Z9FoGs93iuicV1R0RUHaQoD8pTEThF0Ucdo4fhxu8KJunCASFzpCL2FCQQ5xB9ywns
	 arQKOvP7Lw4xU6k4RFiW0fA1mZildG+10onz7YcdmrEOThMoIwZaMj5eV3nJwB1pwB
	 XqizMW0koBm8w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BCF884D0EC;
	Thu, 26 Nov 2026 00:16:15 +0000 (UTC)
From: Daniel Svendsen via B4 Relay <devnull+das.emlogic.no@kernel.org>
Date: Thu, 26 Nov 2026 01:15:35 +0100
Subject: [PATCH] eeprom: at24: wait for write cycle before releasing
 runtime PM
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
Message-Id: <20261126-at24-write-cycle-v1-1-ec9c38617130@emlogic.no>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMywrCMBBG4Vcps3YgGaRSX0Vc1MkfO6VUSVIvl
 L67UZff4pyVMpIh07FZKeFh2W5zhd81pEM/X8EWqkmctN5Ly32RPT+TFbC+dQIfFCEG52IXhWp
 2T4j2+i1P57/zchmh5fuhbfsATyB/BHQAAAA=
X-Change-ID: 20261126-at24-write-cycle-7cedfd00f9f2
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>
Cc: Bibby Hsieh <bibby.hsieh@mediatek.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Daniel Svendsen <das@emlogic.no>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795652175; l=2263;
 i=das@emlogic.no; s=20261125; h=from:subject:message-id;
 bh=jcPKGomz5djCGzdGpnaBBVY00UgyabG9Lq9DL7YvIlg=;
 b=E0uKLD3Ha7ZC/+CmF60IMx8YtdMMTlBT+Z0LdwwmzzUaMLHHRKShaDzMFiZH2ZMzteyt+Mnt7
 tvOEjBbvdT8A+yQ/gbUwxly6jwSCdkNSFrBYosuU79fgK4RlWNenY5u
X-Developer-Key: i=das@emlogic.no; a=ed25519;
 pk=NOuNK5ezs2CmhXHDzJ0VumKw5T6c3m0ayEJIk/HKbyA=
X-Endpoint-Received: by B4 Relay for das@emlogic.no/20261125 with
 auth_id=1644
X-Original-From: Daniel Svendsen <das@emlogic.no>
Reply-To: das@emlogic.no
Content-Transfer-Encoding: 7bit

From: Daniel Svendsen <das@emlogic.no>

at24_regmap_write() returns as soon as the chip has ACKed the
transfer, but the EEPROM only programs the data afterwards, during its
internal write cycle (typically up to 5 ms). For all but the last
chunk, the following write is NACKed and retried until that cycle has
finished. After the last chunk nothing waits, and at24_write() drops
its runtime PM reference right away. When vcc is controlled through
runtime PM and has no other users, at24_suspend() disables the
regulator in the middle of the write cycle and the last chunk is lost,
while the write is reported as successful.

This was seen on a board where the EEPROM supply is a switchable
regulator used only by at24: 32-byte writes with a 16-byte page size
programmed just the first 16 bytes.

Wait for the write cycle to finish before releasing runtime PM by
doing a one-byte read of the last written address. at24_regmap_read()
retries while the chip NACKs, up to write_timeout.

Fixes: cd5676db0574 ("misc: eeprom: at24: support pm_runtime control")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Svendsen <das@emlogic.no>
---
 drivers/nvmem/at24.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/at24.c b/drivers/nvmem/at24.c
index b9db13cc3e33..03cd83e5caff 100644
--- a/drivers/nvmem/at24.c
+++ b/drivers/nvmem/at24.c
@@ -482,6 +482,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	struct at24_data *at24;
 	struct device *dev;
 	char *buf = val;
+	char dummy;
 	int ret;
 
 	at24 = priv;
@@ -514,11 +515,17 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 		count -= ret;
 	}
 
+	/*
+	 * Wait for the last chunk's internal write cycle to finish before
+	 * dropping the runtime PM reference, which may switch off vcc.
+	 */
+	ret = at24_regmap_read(at24, &dummy, off - 1, 1);
+
 	mutex_unlock(&at24->lock);
 
 	pm_runtime_put(dev);
 
-	return 0;
+	return ret < 0 ? ret : 0;
 }
 
 static int at24_make_dummy_client(struct at24_data *at24, unsigned int index,

---
base-commit: ebb7a8dc1e74c705daffe11c2faf38ec2628f838
change-id: 20261126-at24-write-cycle-7cedfd00f9f2

Best regards,
--  
Daniel Svendsen <das@emlogic.no>


