Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE97A37C900
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317437; cv=none; b=iBGBUCHKZcB1epODk2frt5q2vWgsPUAne6pjcWXM0ARp4rMLrK9e0gHBKgneNZcnMdJ76OnbEB1lPXcHRAvEe4GSy4s9v2IUJKjsZt9rDs+MUNCJh86B4eiWeyTd3yjuj/yrLBM92clzSn6xH3kfrt3YpilqafarvYqC2A8dcL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317437; c=relaxed/simple;
	bh=+lYGb4+b0w8GwYp/G3TBEJqntPg7krben7s3Uub1FF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NubZst5726pZu9RZlKGFdgLyGrxoyDeTG8WivCGPcMhxYcW0eCF5XJxJR1tpETzfRskkJObvzKtBbNp0ZSvLizvUIVD1w8klyIuRRWMIaUidKqYh6WXXPT2zg54upC1cL/wrQ/tTdwQCALU7hFtOLNKOxyo3hrTXp1Vuu73ktYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeBY90QM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeBY90QM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD3A1F00899;
	Mon,  1 Jun 2026 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780317436;
	bh=+FRhqR9v4KLDe+3m+Be/TtbDq0LmDlvDNNY2gzlEQTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XeBY90QMcYZ1RmjPrbVKMnC2gM/ECZlu4IcwoGtyH8QdjbTqTA5sj6rtWVTZDrQ1g
	 g9vL+aFplkcXvHi8hHmsJ4vZ/1M4wd+UO0liyZ8jbtk1BJZeJ0iEeshHy/6yoqoGtJ
	 zVkCLZTPYiH/+0E8LEDeyWJikLgoZOxRiQS8v0/hxvyPzTCGf+Hp6LsoFErcjyf+fW
	 JPYJCmiMztmv+g+RGsU0tye5I1FS7stFSxSoUAhEa6K2LO5SDKI9yQceyO9ysxEEJ8
	 hZ8tOon3lNWfH5trmmIpD4cEMpfnh2JRj4LYmp76yUQYJSd+NkOXrE60H/AnDlBpIv
	 JQSZwN+dYo0rA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/2] hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read with pmbus_lock
Date: Mon,  1 Jun 2026 08:37:13 -0400
Message-ID: <20260601123713.718815-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601123713.718815-1-sashal@kernel.org>
References: <2026052822-saloon-auction-5094@gregkh>
 <20260601123713.718815-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

[ Upstream commit 4e4af55aaca7f6d7673d5f9889ad0529db86a048 ]

adm1266_state_read() backs the sequencer_state debugfs entry and
issues an i2c_smbus_read_word_data(client, ADM1266_READ_STATE)
against the device without taking pmbus_lock.  pmbus_core holds
pmbus_lock around its own multi-transaction sequences (notably the
"set PAGE, then read paged register" pattern used by hwmon
attributes), so an unlocked debugfs reader can land between a PAGE
write and the subsequent paged read in another thread.  READ_STATE
itself is not paged, so it cannot corrupt PAGE in flight, but the
same defensive serialisation that applies to the GPIO accessors
applies here: any direct device access from outside pmbus_core
should be ordered with respect to pmbus_core's own.

Take pmbus_lock at the top of adm1266_state_read() via the
scope-based guard().

Fixes: ed1ff457e187 ("hwmon: (pmbus/adm1266) add debugfs for states")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-8-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/adm1266.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index d90f8f80be8e0..84e01acb0796d 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -322,6 +322,7 @@ static int adm1266_state_read(struct seq_file *s, void *pdata)
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	guard(pmbus_lock)(client);
 	ret = i2c_smbus_read_word_data(client, ADM1266_READ_STATE);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

