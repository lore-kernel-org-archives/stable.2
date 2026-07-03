Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BF131618B
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103412; cv=none; b=jJPHS3z1fNWgsu3EYlMTIayZWnoA2bYkC+25P6PbfUzLhBYqh4PGouAfaJGda4X4FlxOtO32NleK69HwZSvvhugiYebW/XesJO2s/eThoKWSr3/Kyhvr3/d4HPe4/MgCB4Rwmh2TCNcfmZ0F0DLW5uHflBW/Zhmxpw6qzK0R2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103412; c=relaxed/simple;
	bh=jdF+XTMEqrXEdG2ItJUioWzkUtmEMcM84xIGPhaTnHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iZwYwXkMZcVuPXqh5VNCfy2dIcJkCgMAijdvryyHYHaFCih2iHuRyy1kUjlvzZlo1+gOGK7VKXOjTjVTeDOvszO/4Dgp7t6PnMyDXFM1XI40UeeewhfJ8yjOQoK2AZlof1UCX518vWUaZIy/k6EIH/WJo9gO1DcKbKtWrzYIXzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2O5BDUg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2O5BDUg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b8d99342so192515e9.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783103409; x=1783708209; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i/rUzSk53/USCRHP1Jq261zOjDhZqaIDYMeO3RcojEY=;
        b=l2O5BDUgKcXmUcgtq2UMjI/ZusdQPRf6jOlN4tma+Pj3/vYsCF9utR4vOlEytL8FF1
         IKSIRPKqT+Xs2uV5TQuURtwjRoyqidemjxI91xaJt8l9H9x7D9SMOeBRmKGoS9yRIIWj
         dbsl5g36tpywNmMW8oSZKRkzV+X1iKiBLY462+0b2ZUpFHwB928J1aE2yulXnJc0+EXJ
         B9QA/Wf47ZL1T5gJFE9L9opKKVFGGTMXan/XU1BAn7S3XrrNTB/sPlRVjfG2QgHHq20G
         alAcl588gdDIbCTjqbm9ZxHw/IvsQ143UFWPcTmon5Iag8Xx8SPIrJCuL4Z0ZzZHhEVc
         ZS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783103409; x=1783708209;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=i/rUzSk53/USCRHP1Jq261zOjDhZqaIDYMeO3RcojEY=;
        b=fB229+g1mi40T29RjshtCiiElzt4nGsWiekMrDxnlciUq7b4LZCT/ZuhWdsrTKizsx
         TjSlaY/WrwgxBZ5YnL8Byv3rcYHeToL133i8CFrKVzj09eIDbjDe77PKsAtx31FlPMt1
         +phFsbjsmeE2nRaStk9rqmkjqYNQYbblMiUV6DK1jqIRqc6uCJAXApJ7gVknNSYVfob1
         HE8N9NWMxx//nwLnaYIfNj2eSvbcEm7fiRjG/BZgkdHjNTzgd+llNViUktKaTACdWB9n
         FqcdCvK69xm3d+0hsv/snNyccD67kSMpS/B80w1K28GoVHSenNKYh9GgkinETe9EJkU+
         38Aw==
X-Forwarded-Encrypted: i=1; AFNElJ/zS1U6oTZ5EKIsYO5sdl/nd3jW0W0UYhZSRzBoIuZB7t5ds9TfJu3ON98sk8G16d1DlzqKSfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfDIrM6eqpO/N5PuKOUIKk9ZISnFBZ+bh3pfI1B69R1uBMnznG
	7DhIcvATStvKD7GU81V7uCIbmPHsn1KoHet4TU38TdrmGzAU2v9xsOmDdtRGsfIijg==
X-Gm-Gg: AfdE7cn7RtLZh2MYc2gW8wljP0svt3R2BXg3tdFiwFSgSJZalE4pIVW2VhKbPFmK6EO
	7I4Fd4UBbInIknDZu5DwchrAcX4kNQ/AxYNdAlu90xiZUr7iel5iv+Gpa1Tr98DEzasa//Mggdi
	oLPpdwwMU8H20q+Bh4VUuD4C4Alj7/5IgsBiNNS/PIrqfz5sL6K5H3lTIPvrSC+2qUEqhGnu8aO
	Ao0Fkw5lCrU2KjikG5CuQxoQYHHTBDM5prk+2mHo0aJRiXSgt4wFb9MiBFX5ye0xaHYnLbyX/Dn
	dRsgxpnEbSjwzL2ab7v1doI5PLHWUPub4HMJ0oL4hm4lfnpUShmPFH569KojLqv4n5oGRYJbrq6
	ryeGNAqOCM5OMlr8q8lPRVqrVko3wlC8dvCRRmf4u4FUp/GV9ZGipPsPTn8f6fxYURjm5pnxdi8
	fPpxo/kGxPgmbTwXMTs7oM+b95yzuxMfKKX1SJTCj9InaoZ7Ayo50IDUdVhrHfuP6w30IOfvM=
X-Received: by 2002:a05:600d:8499:10b0:493:b24e:5c48 with SMTP id 5b1f17b1804b1-493d1057702mr190545e9.11.1783103408374;
        Fri, 03 Jul 2026 11:30:08 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccd9d620sm72590245e9.1.2026.07.03.11.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 11:30:07 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jul 2026 20:30:02 +0200
Subject: [PATCH] HID: core: fix number/pointer type confusion on long items
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-hid-core-data-typeconfusion-v1-1-3c63c0d77ab1@google.com>
X-B4-Tracking: v=1; b=H4sIAKn/R2oC/yXMwQ7CIBCE4Vdp9uwm2EaMvorxgMtg1wM0QI2m6
 buX6ty+w/wLFWRFoWu3UMZbi6bYcDx0JKOLT7D6ZupNb83ZDDyqZ0kZ7F11XL8TJMUw7z++nMR
 a40IbqBWmjKCfX/12/7vMjxek7kla1w31Aei1fwAAAA==
X-Change-ID: 20260703-hid-core-data-typeconfusion-95c660affffe
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783103404; l=2252;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=jdF+XTMEqrXEdG2ItJUioWzkUtmEMcM84xIGPhaTnHw=;
 b=OXUC3Gp3ZPVD4A6+OXcCEMLUJm9RKFPXkHp2MXgSFOAi+65mC6JjgEDX/ROS8HIo2KCAoCOgN
 PD0DTsVikCYDQkJq4i5Gabfj9kxZF9Q5p1WjSUVNl7eQfiFxxMcLakv
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

When fetch_item() is called by hid_scan_report() on an item with
HID_ITEM_TAG_LONG, it stores a pointer to the item data in
item->data.longdata instead of storing a value directly in
item->data.{u8/u16/u32}.

When item_udata() or item_sdata() encounters such an item, it incorrectly
assumes that the item is in short format, and therefore returns the lower
part of a kernel pointer reinterpreted as a number.

When a HID device is connected whose descriptor contains a
HID_GLOBAL_ITEM_TAG_REPORT_SIZE encoded in long format with size=4, this
causes the lower half of a kernel pointer to be printed into dmesg as a
number, like this:

    hid (null): invalid report_size 107953555

To fix it, let item_udata() and item_sdata() verify that the item is in
short format.

Note that this bug only affects hid_scan_report(), while the main parsing
pass hid_parse_collections() will always bail out when encountering a long
item.

Sidenote: There are currently no users of data.longdata; maybe we should
just remove any parsing of long-format descriptors as a follow-up.

Fixes: 3dc8fc083dbf ("HID: Use hid_parser for pre-scanning the report descriptors")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/hid/hid-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 41a79e43c82b..d6676505e122 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -379,6 +379,9 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
 
 static u32 item_udata(struct hid_item *item)
 {
+	if (item->format != HID_ITEM_FORMAT_SHORT)
+		return 0;
+
 	switch (item->size) {
 	case 1: return item->data.u8;
 	case 2: return item->data.u16;
@@ -389,6 +392,9 @@ static u32 item_udata(struct hid_item *item)
 
 static s32 item_sdata(struct hid_item *item)
 {
+	if (item->format != HID_ITEM_FORMAT_SHORT)
+		return 0;
+
 	switch (item->size) {
 	case 1: return item->data.s8;
 	case 2: return item->data.s16;

---
base-commit: 51512e22efe813d8223de27f6fd02a8a48ea2323
change-id: 20260703-hid-core-data-typeconfusion-95c660affffe

Best regards,
--  
Jann Horn <jannh@google.com>

