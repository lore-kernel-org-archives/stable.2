Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305D3EE1F8
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791087032; cv=none; b=kAXDxpur0Thuru1T7aKTWCp9NXbX7jxwGF/5GR4DCOtOqNbr9pMtzV0Dnt3/qWLl2oyzhCU6b4o/+2cxLGMe12l58M50NUoCdZQ6xh0dfVHWkLZTb/lCDPs9YYd3vr0H3jXM/ntVZth85tqrf02hi+hgXmGGh0YdeRUOeeKnCjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791087032; c=relaxed/simple;
	bh=NjL6Dz3ATof4xFu51ZKZGgvreurCkfkXi5SOJyRAhac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aHqlFb6O/HkGcvHxc8cHgCmBZ0ii/M0sKl2XzZgmu4qJTiIINmL8XwCufBtla5x6580zUMZc9TzgLXMak0TOJw14/12bnLJMKMyly4KEYJD+p+kROE3Ofw0uaDFNnL9jaE1MPlPoIaAH6emplDefpzDNDNkpDKmFZiWi+S7UxEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zte3/aaS; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zte3/aaS"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-530fa1d2b31so8660501cf.2
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 21:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791087023; x=1791691823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gZl0h+Rgpt7vIrQ3DFHi4uK4eDGZkHcBR93y6eKzCg=;
        b=Zte3/aaSR226cz1HRUtJRct3y3diWGSE0F329TBA9VuqUQTQzkH34DPK2BIKOh+GYA
         6f6Lzy4h/QZzvvL14L1K+BSetoNcJqdHF0rPoUXyVgb3QP/T4GFWD7cTvDCSmjyFQkPB
         k1URsnaIvVAkZXqJgp7hydAOP9po774oY+EudvjakLPiCpj7MERbkyi9APbGQn5Km0Ng
         hEit4OoUYySjzDD45WwRgExIcTRyP6r1KN1hrvoOdNe7MSqksTighBAIdb2qY1I30/Qu
         g5w2QQNOoXBbcy1ReqYYXbejRrtMMfWqzmxd17a4sVsGaoMAWcERdepCGzC4QRiaN3/V
         u5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791087023; x=1791691823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1gZl0h+Rgpt7vIrQ3DFHi4uK4eDGZkHcBR93y6eKzCg=;
        b=WSyGvdxhHvbVg+cdt6JKuX8qkUpxc1zXKp2f2XMQyCTDy0DOHtsyqs6IOFcZMNuYcZ
         2Cp/njAe3oOpRL+bqai4+dFjilEMoeZsxVgRExXEa/zX6O1CCBpe4oPsDQ+w70AGMA8q
         4TPj/hZTH8ShQPxKw9YdNdgxjUe7mbTiRj+SBM1KjiXMnQ5O1cF2cpA/jnj0nyIpzGn4
         lbYuLr+wcAacYXnyM/ov5jiLJtj8kI45suXqxTdyZFo05/+jTZMPn4skuFgieaV9Dtan
         7j9VBRWQ8zDAmGtGK135SW+Wc/1YIWiY7FpE/TqC5f25b290mIfV2u6CR/4ZKkh4iuQv
         fSuQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4OpiRUHaDoleDw2AOf+qd2isPpdd0iiWmUUysl9a/Uh5r2BqPc0N0O/RWnmSwPkGj5zLIeB4=@vger.kernel.org
X-Gm-Message-State: AFuF++nk3bgLNbXscC16NZA5QrhwXN3O1khr37kqCjm+o3NOsgmmiXW2
	DmpzV2aLbGoXg2cLo11uM5FsWMWll6aXX6dqQhtQdEFUeAz9sl8KqF8=
X-Gm-Gg: AYBFou0X5CIWPE1Wdy85cKEyjLc9UQkxLdyvyMWph7LFbIz9ge5hXCI47rfZSB5VLLI
	R31V7K7WtxwB5RkhtISP4YXWMdpwhOGb5ZZF6K7/bWumkBZQKdGN/HarkFcC1LWdDPYpvz9hM3/
	Bc+DxyajMRSubbyRb7DGEwPY/sLeEvmT7z3d/wmRC9Cll4C/7AYm8X6S+7Xupi6YAZJK5YvCfNp
	HgXWSxTLDG6oKHXzXyjdxmqVeYpwTd6gxQH+zARnrip7ssWx3NXK4W2W4a4M+Q0aG0vsy8U18C9
	pMtCLvLN/NadJjZk+PwvzEU8QUUSc0+q/n9MKNmFB3a2SXw0CsVHTRE9bGbut8UCWwraN5TMwdh
	AyhVrRcySsUWpyUsQlQcVBX1t4Av+6qBf3c4Sf0k6Zwgrx+OznOO8sbbMfQbCQMCOFK/Pw6ORbB
	3FRdvRQ/JphoExqBuLob4DpT7L5e8VYPPGqngLS8efcoym1DSRyY0uueMossYfLpU0Qn7bcjfhO
	8VftIgQ0QvQAcjIKUiNOu1L9muXmdfNJsJhD2lpI3HXxSh7fk+qON/O3VehuPd+xXV9QyyUz2qg
	VOsfVvq1diOvN77gcmvdTWZCJlV/
X-Received: by 2002:a05:622a:3c6:b0:530:b2e4:4e28 with SMTP id d75a77b69052e-5351203787amr67100211cf.53.1791087023409;
        Sat, 03 Oct 2026 21:10:23 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b19424sm57968806d6.15.2026.10.03.21.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 21:10:22 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] power: supply: sbs-battery: disable polling before supply teardown
Date: Sun,  4 Oct 2026 00:10:19 -0400
Message-ID: <20261004041019.1123723-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The managed poll-work cancellation is registered before the power
supply, so cleanup unregisters the supply before draining polling.
A pending or running poller can then call power_supply_changed() on
the released supply.

Commit 8d59cf3887fb ("power: supply: sbs-battery: Fix use-after-free in
power_supply_changed()") moved the IRQ request after supply registration,
but did not change the poll-work cancellation order.

Add a later managed action that disables and drains polling before
supply teardown. Its retained disabled state prevents external-power
callbacks from rearming the poll work after it has been drained.
Keep the original autocancel to initialize work before supply callbacks
can run and to cover failed supply registration.

The teardown ordering issue was found by static analysis.

Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using managed work init")
Cc: stable@vger.kernel.org # 6.10+
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 501c8e069755..6714313bb3a3 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -1068,6 +1068,13 @@ static void sbs_alert(struct i2c_client *client, enum i2c_alert_protocol prot,
 	sbs_supply_changed(i2c_get_clientdata(client));
 }
 
+static void sbs_disable_work(void *data)
+{
+	struct sbs_info *chip = data;
+
+	disable_delayed_work_sync(&chip->work);
+}
+
 static void sbs_external_power_changed(struct power_supply *psy)
 {
 	struct sbs_info *chip = power_supply_get_drvdata(psy);
@@ -1208,6 +1215,10 @@ static int sbs_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(chip->power_supply),
 				     "Failed to register power supply\n");
 
+	rc = devm_add_action_or_reset(&client->dev, sbs_disable_work, chip);
+	if (rc)
+		return rc;
+
 	if (!chip->gpio_detect)
 		goto out;
 
