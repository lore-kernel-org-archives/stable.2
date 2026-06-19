Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7331F938
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832737; cv=none; b=P2KlIARTuoz9cvlEKLXtvg8yiVAiuSJ29/Ag6ngMGl/g4v/meJQSTJstkRZPH/7bBzz+goWq0Vozwvx2d0dE2YWeWQ/UVXFtl14siH1EjvQrueaYESg/7hn+GFWAJwyJfpuVou4vlIuzCK5LDi7zJow+WIcan/coZtkeSbXCkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832737; c=relaxed/simple;
	bh=ZOBjPR5wT4rMhM30c/8jHxiVlE1wPBUkLSgw9fG/Zyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oesg4FasgkxboIui7gtyxP/UyuYPTWsZyCjjlD1cWmK0mcyBzJhlFYVy5eS7TjK9ATCINnEHQu6g/gPwb+r0zHhrypq4Kupuhb2IC+x+HSf0nos9D+NC9j1p6qMpdncxfGTPqV9uZrlOBuvAQo3Z0maSBl79Y6dJdQPCFhT6qSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=eXFCRXrN; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=fSPL2SI4; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="eXFCRXrN";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="fSPL2SI4"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=eXFCRXrNiJ7KTDusefbwy+k9nu3mDfdgkGwdO2dC4+uWHLhAvILzUyUZxrmh6BArnpLyOYfQpLASZtGN8pFafVCWU+iFZBzD3pMb0AJ/NfLcOWgzDxXhkffKdL78s5VN11xpFfcQrWYHQ0AW2gEFZTLRYmugyA5GsEbBb4WgyevqtaO1TrnaP+RmkcjWxVyr8BGeg8bDUYL4l8t13JzXePAce0/89+YOTQKFLDx/qkQE9iUglSWfk6VOGCqVAqYNS//Ucru+xZbpVTNqAW5GTZBT5kLBa61kyfHcly61t2R29RmlZxTyQWOYzJ6GzbW1JYv2Hle5ZEh0+aw00xD+sA==; s=purelymail1; d=rcpassos.me; v=1; bh=ZOBjPR5wT4rMhM30c/8jHxiVlE1wPBUkLSgw9fG/Zyw=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=fSPL2SI4VaoexEh7Wl0WolSFR7LN21jaXSkuZKFwiDAAmGNbyDTeWbVe8SifhbY1qNkmLsF7pXVds7pzyakeUP2lZuhdvFIhd/cCdsgiKSaRiVmMjH9G/yx2H6KGRdfrZIEhPCVYkSxU1dPG0M844tJ0KGKEklpqO5enjA+DA7qWKeNzjjAN2pqdT7l0Cu5yGb4YNqOhTaXXdNUzPPITSoGifODTaRIDK7xpwILxb68iGyLbcylrvY9fw0d1tg3iozp+DEMAkE9GqNeatqnEyhX5oMOO7eZFCaQLf+hb+wqpRv+OoI1HU14GjG3OfhUUnXK99xbrmB9Xnkdrmk7K0Q==; s=purelymail1; d=purelymail.com; v=1; bh=ZOBjPR5wT4rMhM30c/8jHxiVlE1wPBUkLSgw9fG/Zyw=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: stable@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 879635646;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 19 Jun 2026 01:32:05 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Rafael Passos <rafael@rcpassos.me>,
	Lucas Zampieri <lcasmz54@gmail.com>
Subject: [PATCH 7.1] HID: Input: Add battery list cleanup with devm action
Date: Thu, 18 Jun 2026 22:32:07 -0300
Message-ID: <20260619013207.1968584-1-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

commit 426e5846eba75feaf1c9c6c119cb153610192da1 upstream.

The batteries list (hdev->batteries) is not cleaned up during
hidinput_disconnect(), but struct hid_battery entries are allocated
with devm_kzalloc.
When a driver is unbound (e.g. during devicereprobe), devm frees those
entries while their list_head nodesremain dangling in hdev->batteries,
which persists across rebinds.

Link: https://lore.kernel.org/all/20260602011949.2825852-1-rafael@rcpassos.=
me/
Fixes: 4a58ae85c3f9 ("HID: input: Add support for multiple batteries per de=
vice")
Signed-off-by: Rafael Passos <rafael@rcpassos.me>
Acked-by: Lucas Zampieri <lcasmz54@gmail.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---

Hi,
This patch missed the 7.1 rc7 window.
Booting fails without it on some devices with batteries.
I hope it makes it to 7.1.1 :)
This isn't needed for earlier trees.

Thanks,
Rafael Passos

 drivers/hid/hid-input.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d73cfa2e73d3..c7b8c4ff7a33 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -519,6 +519,13 @@ static struct hid_battery *hidinput_find_battery(struc=
t hid_device *dev,
 =09return NULL;
 }
=20
+static void hidinput_cleanup_battery(void *res)
+{
+=09struct hid_battery *bat =3D res;
+
+=09list_del(&bat->list);
+}
+
 static int hidinput_setup_battery(struct hid_device *dev, unsigned report_=
type,
 =09=09=09=09  struct hid_field *field, bool is_percentage)
 {
@@ -610,6 +617,12 @@ static int hidinput_setup_battery(struct hid_device *d=
ev, unsigned report_type,
=20
 =09power_supply_powers(bat->ps, &dev->dev);
 =09list_add_tail(&bat->list, &dev->batteries);
+
+=09error =3D devm_add_action_or_reset(&dev->dev,
+=09=09=09=09=09 hidinput_cleanup_battery, bat);
+=09if (error)
+=09=09return error;
+
 =09return 0;
=20
 err_free_name:
--=20
2.53.0

