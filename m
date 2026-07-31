Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E014E2F2;
	Fri, 31 Jul 2026 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785469039; cv=none; b=GO9QgAJ9HxwE3q85Wy6GDnUQ5hiEAlPuhii/CgBuuObnmPS/2jCG1OvwD1AmGAfwp82DX/Ov8QGqiLhgPBrAs+5HejOGOTgshDNKp2O872ybTfvIpvlsvCpku6xz5p8q5pQRWB24F6ewZlNvprCY3lZQZJpm1TFR+Ub5k72m+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785469039; c=relaxed/simple;
	bh=J6juHnD/5tRvq4AJV+146fCjaSj2hxHjmTELoKHlnC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZiA9uUEFUySkU9PCeNmnOoZ/GLVjQnIHuve1HjDTX26m6uNeTdhRy7kH29T+4n2COS63eqXJ6Qgu/A0KxqGyFEG2vSCFfQWOYT+8uBlXI2ksUCu4jVG0rnXYOyVlRpwd8/pHtENAPVNRR6kL8V24spNa3uLsa+buZt278tDzuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=g+Ui4C3d; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="g+Ui4C3d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785468977;
	bh=9/IRHr6qGsS5/hUj0jPTWFgKfSMT/u3zTUXwqZo6odU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=g+Ui4C3dy5vu1oiwEqJBn9UV3OLVu+WgKvrie0w+WMXKR9AtSoMmyvWcFfYW/+48i
	 ABjGQ4If6dQz42PvopbuUvhW11yuOUSPD2eAC0zI7vbEnDas6G5cAfvfE7RopQcBzW
	 ZwC306bdm+OlmI9CVgDJJxjtNev9WFzug8HLhlg8=
X-QQ-mid: zesmtpgz8t1785468958td66ef0b8
X-QQ-Originating-IP: ilWlh+Gbwf0WHS8qazdCirqhVuuiDUyQNjjYBUbRaq8=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 11:35:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2958451320767375806
EX-QQ-RecipientCnt: 11
From: raoxu <raoxu@uniontech.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	shenghao-ding@ti.com,
	baojun.xu@ti.com,
	dakr@kernel.org,
	u.kleine-koenig@baylibre.com,
	cassiogabrielcontato@gmail.com,
	raoxu@uniontech.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/tas2781: fix ACPI reference handling
Date: Fri, 31 Jul 2026 11:35:54 +0800
Message-ID: <97EA8F29DA0D9AF7+20260731033554.949564-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N7iI3zU3U7HlIVXW04SCG2i4tKwHnQDQ+Gn8lFusglNcbRHTBXSjb4Yi
	W1idwOA815B46ufxwNdCAroPxsv5iO90yF6qqqyM1e2fPtJA+6QIdKMGm8TVCdSUm31Z/4u
	BxSFTHZRZZDWAiX3kSpzS2v4w5ARd1Z6l0/lfH/ljaMrv328b6yXrCOi6QL+ngLDfcYk9JB
	0+nNdVPKNBKZZi+qrX0bd1jzrlO95UYwmidkB5fQEn+ZHKhmv6Asgmu4wczw4U486D/W05/
	A8VPeBeDqIaSxQbR6eSP7m8NWpc3uslDAN7GaN9V6lE/kVldhNipC1MdTi8s6zrlutrngt5
	t60fXFl+v662ilG7kh/av4lgskA6zvaBf8/m0bs6ycj/l+5lfUZco77CTycsHx12CB0KcP4
	UxFSZPHeaONAVGOPQssZhaeofsqfeKvFyL8VjBKaG61mSzjUTL8fw2ceoKfKEmDROaJOZ3Z
	xYjebmRCCX1ljy4juvWkScHL2PKx3CKkl8o5CrCbFcczr7qgsHjcw+VcZ3Buzv1UehJC40n
	EQKLVCo0hZbHsooUmf8SRytVVUotvW61Pgr9glPO0ojVnEksc9M8uK1/y0IXbTVGANK/qNJ
	A23/YkZp/CdC7MUqFL/j67CibzimBRZmXB9SeC9zKFx214KlUj11km80vbNuh7K5JjvjfAx
	UXPAXNA2l9rJqH9pnlxaPPouMMsOU7hM53zu3bVmprpeJCpG9GIWHxGCISn8YI4NBKgB71a
	dX8vnuzVTsDvyY9hCVtgLxq8qhAf/48QIV4zxQYPtmpK7Z0Cl2/cIlmwsNQoOdDjYrSkgjs
	PGYTuY33Acxi7hFIFAuEScZUMBkzRuF9ZtWG8+jEWOBFwdoafzTVvc+CmkAojFhMxu21c/Y
	Ki0/TyHT1hkH1cZSV2aRDDNhadPIkYgA0RIHsHN7eckWpEkQo4WRymIIiFR9uUrcsvp3Ukx
	UDK+/midxfG76kYGNi0vFy6rCOI1+1+ZOS0QrasnArFQvP6wXHIAkKXdHICisO3an82cssz
	ff/rweaknkqEX+gVjfEw0OR2eVd54=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

tas2781_read_acpi() gets a reference to the matching ACPI device and then
looks up its first physical device node. After taking a reference to the
physical device, it immediately drops the ACPI device reference.

However, every later failure jumps to an error path that drops the ACPI
device reference a second time. This unbalances the reference count and
may prematurely release the ACPI device.

In addition, acpi_get_first_physical_node() may return NULL. Without a
check, the driver passes the NULL physical device to the property helper
calls and may dereference it.

Return -ENODEV when no physical device is associated with the ACPI node,
and remove the duplicate acpi_dev_put() from the common error path.

Fixes: bb5f86ea50ff ("ALSA: hda/tas2781: Add tas2781 hda SPI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
index 4899ea372798..271c56a79c32 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
@@ -343,6 +343,8 @@ static int tas2781_read_acpi(struct tas2781_hda *tas_hda,
 	strscpy(p->dev_name, hid, sizeof(p->dev_name));
 	physdev = get_device(acpi_get_first_physical_node(adev));
 	acpi_dev_put(adev);
+	if (!physdev)
+		return -ENODEV;

 	property = "ti,dev-index";
 	ret = device_property_count_u32(physdev, property);
@@ -385,7 +387,6 @@ static int tas2781_read_acpi(struct tas2781_hda *tas_hda,
 err:
 	dev_err(p->dev, "read acpi error, ret: %d\n", ret);
 	put_device(physdev);
-	acpi_dev_put(adev);

 	return ret;
 }
--
2.50.1

