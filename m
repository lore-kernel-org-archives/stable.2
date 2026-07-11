Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2DF2B9BA
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 02:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783737822; cv=pass; b=jJIUfGwyrKsD0h0GNXT1608z7BOT8NSs8yWGfct5p8Gbulcm+4B1oULfVcAQXan674ihb6txkg985H5cp1ThFfK1vjif0Ra1kjctTjJTLDJoIUPztQ8gkJ0ycQm3rGfyOgLKJCqe+6dnRa46UDuQQYngH0TLg8RgSeUYGLSwOFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783737822; c=relaxed/simple;
	bh=cm0y3nfEv5KYZMQ9lE3vuSEaIaX/bYl6zqZ1nzt+X/o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OezsMIzwufoYIiDE9fLQ5RaaWlwsQeolxZ+hMJT0rw1Mj1vUcE4VrGM4aeV6Ko82AGKQGKJSNmoTnberzyKR+hW8CUPM8CWJkid/cLo5GxrKnL8aVzysMcHLTv5nwtE4ZULB2SoA3KGHyvWrrwKgYn+7iWOCwjd5U5LTiDSHxto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4uL/GEA; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4uL/GEA"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-966d70b9e1cso458400241.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 19:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783737818; cv=none;
        d=google.com; s=arc-20260327;
        b=J5FFuuGaWlDFPTyl/rgOZpvrjUQfFQo65JaTMTgeTO7n9Ew/tf9ZSvjC1Eyjcv2llo
         aRd6wPL07+GkUlqbxdjN7+KQnEgyfiVtCkYm5b1FOMfXXeRfe2I0mPjgELjBt4H/hnUk
         zK5v6vADCk1K7cSdxicznUlD+GvK4St/K1QVKjEaJbVQ+Gy/CO81d73qX1F8L6GCAzFF
         hOdUarcuLKzhX3YAbvGzVqAbQkv9s6fsCqMJUNk+/bk3H8fEo5hM/RaTIYiMaFLMcc7o
         G1DY4FT4bcQjk26ZH7fsztU/0xdZU1WWpBUizFPUimEGfU+FBcmDAiFt8G50w2dAg5rq
         bhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WZiBVoIHxmqoz1H+3Q12ZE9AXVZ5TYhLyqj1A3OwnYM=;
        fh=8zreOB3Jf/AiKFQ+xJlT2oUA/sg6P5Yk3kPxrt6Eiac=;
        b=idwaYA+GwcfrlrvOtyinaO2j1yTIDD4OyoKRa5vRm4wXEeK/r7PvRucsJ14Zcuux9p
         GWrMnpqHCtqZ27evGmUKk+zSyaTHYu0nn6FD9yPvNq2z2FSn6OWwZ3Gsib0mk73UQHnM
         NnbTYoR1PAVz6QpF1sNlhYDOA78ttYdouuddMs2AfTfPFRJ+R8qpX1BtMUAJTMY92vUJ
         P0pAzkXeH9ghOswxPogo77vTUw6GcGdk08kz3SJyDqqLVLJnnGoAJ/pVMMS3dY3yRY8f
         /sCO3PODX51y5EMKAST+KDAIIp16dxh4cH4kY0mDt6qNiyzAVvokAktII5X7IG/GKprq
         3YFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783737818; x=1784342618; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WZiBVoIHxmqoz1H+3Q12ZE9AXVZ5TYhLyqj1A3OwnYM=;
        b=p4uL/GEAJis80JMop3JN7/BtxocA27vCqhFhxXkAUoWPyZD45boNZlVLOo3mHEFCZG
         3Q7rVUvy6s9mc3Xkib9/x9AgAQlOGgfug0NSLdo2duD+/902pVbSjlh/oq6wPCp5IAcH
         ffzrSM8LI9PP3cRo4z4cq9uK1M0UyNmvDQ8YnvqJoIzo3+bXS4JRapP4OlcAuI98VOVs
         UW7DlQxJxCKuhBj5482riobsRkXsVs23/iDgfIWir9FH3L+pPFi5pX6PLcgXVzaAJcNx
         1gA9cwXtsw7To9Q6WvBOfl1nioNg7tghR7eH2GtI2GWzdZ7ap9oV8Lwim91Z2ynSzM3B
         SEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783737818; x=1784342618;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WZiBVoIHxmqoz1H+3Q12ZE9AXVZ5TYhLyqj1A3OwnYM=;
        b=U90A/RQXDmV5m7lX1J46GDm/OUHg072epUR72dKqY6jfMAdf1PFvaCRP40vJYtblFe
         8dGef98dB6W1ZWl5sNiQSa3tel27oVosgL8KbZF6k3O2hDB2w/pHz4tuJyti+4eHNVSk
         tj0tKMftFvMUXaED8qDpPQnBZPiQFget2f6Jr0qSRA2wUUd9ZXMquFOs3clgjdpf4oU4
         qFdY0uAty/sPPEVO6DdZ1kYXS+edz2L+oua9D05InkwG3bP7/zS32cDnwSp8M0Ya6a3Q
         BykBcowlo53uirGmp2dQNGuwOkXOf6lK8YOBE7XizBJ8+dtleo10qsE3pFni9HbCD088
         +QTQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfueLOnCe+rnEpWz5p0vy3z5E1U3lAb5CIRIgKXLg87gRQDseVDiKIUTOLkPoRtsx6jSnDiBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXXsnKSzaaLpTzowvuHDIszWQXrDgKgJZlRGhPDHELGTozdLu
	mpxFRnh7dntmIRddir9fmBD8YgCRMYQCxeM7NpQmOlVDh/eYE0/ztF4d2iEL8f//jDDXrPXs5Y0
	i0fTgxbCIRykjnjxhD+4HB3X1CEpiKWQ=
X-Gm-Gg: AfdE7cmcPByiZqqLQNRcZnqdupik9g60nAMoIjAnxFbnM7WyP3DnpoIi9I4/nw5ws5X
	/fTbYSolIMrNyFK478KRtmvQgKlfYSBNhO9VyG1E5D8jnImyKQB/3QN8D41w5nttEbhIXL/FDXY
	i2juefLqLSXoPwnBp/zfmLKf28CsfE8pizd3rNCGliKTbN4oByjtoo9z5rlgko4tJi7HyxpPAwm
	LuEjMT5swkQVtqWX6Zim5MMyxvtmCB83qTR9USBCvb7P1YZWOtqXtv92mKp42gwTGCatFy/MChp
	9GenWy8pKjU1DtHjm6NzfAfZ73hh22xHT6+vaNHZx/ft5GWvoOGJfX73HNcI5WzvpwNi3W5HCfp
	f9O+oU+DQbAYL
X-Received: by 2002:a67:f7d1:0:b0:744:d1a6:b11d with SMTP id
 ada2fe7eead31-74533b84339mr908051137.3.1783737818123; Fri, 10 Jul 2026
 19:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Date: Sat, 11 Jul 2026 08:28:27 +0545
X-Gm-Features: AUfX_mxDeHe86_YdwArqEXxpUTiTOxiWdaz-UlADypKSrt-vRHpBc2kW_hLs9sY
Message-ID: <CAMyXUJkncpA3Q-BStPsbXfViNbxzJ6ZrQCt0RoGxtVXV-R_DOg@mail.gmail.com>
Subject: [PATCH v2] iio: proximity: hx9023s: validate firmware size
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
Content-Type: text/plain; charset="UTF-8"

hx9023s_send_cfg() copies the firmware into a counted flexible array and
then reads fixed offsets from the copied data before walking register/value
pairs starting at FW_DATA_OFFSET. A truncated firmware image can therefore
make the driver read past the copied buffer during probe-time configuration
loading.

Reject firmware images that cannot contain the fixed header, reject images
too large for the u16 fw_size field, and validate that the advertised
register count fits in the remaining payload.

Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file
parsing functionality")
Cc: stable@vger.kernel.org
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

---
v2:
- Explain the U16_MAX limit in a code comment.
- Keep the existing kzalloc() expression unchanged.

---
 drivers/iio/proximity/hx9023s.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index a6ff7cbe9e65..685053b84b34 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -18,6 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
+#include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -1031,6 +1032,10 @@ static int hx9023s_bin_load(struct hx9023s_data
*data, struct hx9023s_bin *bin)

 static int hx9023s_send_cfg(const struct firmware *fw, struct
hx9023s_data *data)
 {
+ /* fw_size is u16 in struct hx9023s_bin, so reject truncation. */
+ if (fw->size < FW_DATA_OFFSET || fw->size > U16_MAX)
+ return -EINVAL;
+
  struct hx9023s_bin *bin __free(kfree) =
  kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
  if (!bin)
@@ -1041,7 +1046,8 @@ static int hx9023s_send_cfg(const struct
firmware *fw, struct hx9023s_data *data
  bin->fw_ver = bin->data[FW_VER_OFFSET];
  bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);

- release_firmware(fw);
+ if (bin->reg_count > (bin->fw_size - FW_DATA_OFFSET) / 2)
+ return -EINVAL;

  return hx9023s_bin_load(data, bin);
 }
@@ -1058,6 +1064,7 @@ static void hx9023s_cfg_update(const struct
firmware *fw, void *context)
  }

  ret = hx9023s_send_cfg(fw, data);
+ release_firmware(fw);
  if (ret) {
  dev_warn(dev, "Firmware update failed: %d\n", ret);
  goto no_fw;
