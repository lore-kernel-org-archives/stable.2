Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951500;
	b=Dj5CQ5RxHGdB10q7q3EyTZlEV842dyIbc3uqebLBnGfHgNRx3GCfu9Ywf/S3boWmnMHQ
	 POyGDA+3j8JaAs52darK/XXEutqnd35Lpq9lMMFsaZLg4XwbymXE2RKf97++QT7MDhP42
	 uzQ0DoMSivf3VDvMM3PwY5w+RkW+JkzBkle4yIOCnkdeXesSTamN/qD14V2qAzREqY3eA
	 n9IDrQ8rpCKsgL46dVVghzrgdCPCacECvlp1ruWEegV0ekiofm3r6dBcVxjL6GeF8jVVz
	 RZgkB+k8rcP5jp0AmoScmH+vLuSegk0NzgrI9ekqErzk65Z5bnxHeIxX2zak1vKZ+fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951500;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BxfnrvZCaIXbpGJqIJIbJ0IIadnlSyqid91Q14S6WvY=;
	b=c6wjHqGatcADTeKjVfRUnIwJ0Zule53KbMZ7swbAWjYsoV/RRBseikzQsz+XuhC7vLXk
	 axplDoB2RglMyBSgLqOcHIAKzOkpamfKR8TLvvixUD/EuOiwMlIOads3LdXrf+B7CofP+
	 tExcmF9RvWE/CSU8TqAKStJp1WOKmqS/cT7aOLUI5KTRqeNMvPPQ3MIc2ItuRnFkbotxv
	 FX9/57b0YJtoIH4KfYJiIXi2mbX2dlKRG/nqaELNcvLCZM4qWr5Q4etFjQ98EwV7ldBgY
	 K4KkEUo8eO8sLnxARBjprXN/RLDsqYsigGzmMAAsuXlHUw8vT3+iKKDpPONNpkhlXhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="b1Xx/h/R";
	arc=none smtp.remote-ip=115.124.28.217
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E817606A330;
	Fri,  6 Nov 2026 07:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E817606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=b1Xx/h/R
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793951490; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BxfnrvZCaIXbpGJqIJIbJ0IIadnlSyqid91Q14S6WvY=;
	b=b1Xx/h/Rd1fbig3KKltcO1N4alNxKwQfp5usj7YbAC8BSjCdEgxyd92Glni69LKkT8Gu78CpFW8TAz85nVKK+USVXx59dd8vVVFluxL+jbsTcu4Btj/+B1hQ2pz+LVgFs9lAPgHJuMVmum3Gu/8s4qisUZZ6iCwv/VUQzB3rMe4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08866221|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00219219-0.00171057-0.996097;FP=11930222591969111232|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jyElgNY_1793951489;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jyElgNY_1793951489 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 15:51:30 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>,
	fangxy@xiaopeng.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: goodix - reject a bak_ref length that cannot hold the checksum
Date: Fri,  6 Nov 2026 15:51:29 +0800
Message-ID: <20261106075129.3106093-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

driver_num and sensor_num are taken from the touchscreen config.  A
config with driver_num 1 and sensor_num 0 yields a bak_ref length of
0, for which devm_kzalloc() returns ZERO_SIZE_PTR.  That pointer
passes the !ts->bak_ref check and the subsequent
ts->bak_ref[ts->bak_ref_len - 1] = 1 writes before the allocation.

Reject a length that leaves no room for the trailing checksum before
allocating, and skip saving a bak_ref that was never allocated.
Without the second check a rejected length leaves bak_ref NULL while
bak_ref_len still holds the bogus value, and goodix_save_bak_ref()
then writes through the same index on suspend.

Fixes: 09182ed20c04 ("Input: goodix - add support for controllers without flash")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/input/touchscreen/goodix_fwupload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/goodix_fwupload.c b/drivers/input/touchscreen/goodix_fwupload.c
index 5ae9a109ba0d..888da7538c06 100644
--- a/drivers/input/touchscreen/goodix_fwupload.c
+++ b/drivers/input/touchscreen/goodix_fwupload.c
@@ -281,6 +281,8 @@ static int goodix_prepare_bak_ref(struct goodix_ts_data *ts)
 		driver_num, sensor_num, have_key);
 
 	ts->bak_ref_len = (driver_num * (sensor_num - 2) + 2) * 2;
+	if (ts->bak_ref_len < 2)
+		return -EINVAL;
 
 	ts->bak_ref = devm_kzalloc(&ts->client->dev,
 				   ts->bak_ref_len, GFP_KERNEL);
@@ -409,7 +411,7 @@ void goodix_save_bak_ref(struct goodix_ts_data *ts)
 	int error;
 	u8 val;
 
-	if (!ts->firmware_name)
+	if (!ts->firmware_name || !ts->bak_ref)
 		return;
 
 	error = goodix_i2c_read(ts->client, GOODIX_REG_STATUS, &val, 1);
-- 
2.50.1

