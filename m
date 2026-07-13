Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084C346E54
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783918004; cv=pass; b=GPDCpB2mww6+aInwDmsium9wNEfdHcWSJiZjW15m0jLN/qUYzFokaLoHo7u31lqQc/JhP1o7W8UK/0eQkarxIXYKp6EOTVNuOEbDHsI/icRz9b/C+iiCA9WOlnmOny3QM/VhuIu+LJGNinEbc+ogTONFZvp+0n2JaOsM6u6iWM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783918004; c=relaxed/simple;
	bh=fvnrMic/Wc1PqTxLDwgJWHRDgytppByxvectU/n/IUw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=P0qsP32SVOmUWvN5Z3qnR4pR7qcEyhrKzqKryaN0PqoDV/fOFEPRffVlhYdM6AwAUCfbPiwpuXcLDMyncwJ65m22iCx+3XpsAQbu8C5MTYM0DiLgALYnoNnfWzjNJn8847ezO5Q7Kr+XepmgzHUbqm9hlJ5UDZmCUdlNZTxLk8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKWawFVM; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKWawFVM"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-73750ce4b2bso1053100137.1
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 21:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783918002; cv=none;
        d=google.com; s=arc-20260327;
        b=MAM7Pd5AOBizF+gjQCsj5uqYfoNIJOrxyaTcG4ayOdv5dsX7l21zYdinvKLoCOYuNR
         JZdBRvhYoj5QvSAtkvB1uKBsnwOnK+huSBBACPKNT0MaOKMegALjtI6ijeDuutTEYaXC
         QnlzsxeIz/CeBQF6BnmpN5Ua14b/r4xVNr7jRROOsk92Gj4Clj5knCZbGgKFl03387+y
         lHADWIzvWOynhs0QholOlBpFGtSX3SXrLMKUMOnNqFS1hc1i3i+PQ5F8XJMvFWqxnLda
         C4lAXzfE0MZTSO9fy2NxAlMqmGXtxnITQPZbJKgiVnFxW+gyh+7qPgO8UvADq25v6XbF
         jIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tIvuNpwtX62wjAACnY5xLsw8rSHDkSGnso4sTTSlICc=;
        fh=svvXg+mj0SJcQHOehJ7QhGIOJBvJog/skynSreYWEMU=;
        b=HVD/AJqU3KtMDDqA9suIqhq1JWjyTKpmrWOLukn1qHdW97w38kHDaYHH+WSMURN3Nz
         19p5MPWyIfzqyVdozRDxx9CjeqYSUXCIBdfOmk5yZqAut2jC6TGts+COtqjaGucTOZu0
         msGDd5/8uKjnAv2TtPDAYa+GEB9TZNIaNexuMlqzZUr/RdsWDTC7ERSMhIYpArTPmVoB
         wMo3Hv7ICSCUF2heVmECB6RCe+NMUM4Ht8zF+onBOFs1RnzE1tY+MMPe3CFppjakp5li
         N+aWQ7j6b/cG0I/Pga9FkaLGPBsFaZ7Usvb18c1//3AjVg/UtOmc9YlLNXXn+S9lLEXz
         ZtMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783918002; x=1784522802; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tIvuNpwtX62wjAACnY5xLsw8rSHDkSGnso4sTTSlICc=;
        b=VKWawFVM5BIeOP3qLxypfVpetO2xJCBjiyZOScJ3m9zueCZYvL/HzWQC4khGdhLrS3
         yFgY33Jx57nSaWF+0HHM5Ek9iVXbw95lyKPPpqRWzG+uejQBC8oRuPdPXo1ydet+rTci
         JxicKhagF8E11EOFeT+7FB43gJy2YwiNpuu7kjpL21hBC4kU6PRixnwofRNqe08+4RfO
         m7t2VzK/Btn5bWDlKB7B5wlMx/gLPwKrS5LboH0zUCLvaJOS1ZU9IXH5cgAjllyue0nG
         jb8O1QkEiyTF4mmSpAHjzSMKwYyY6QlA8Oh2atcv9q/WUeOnKKcaFNgvwncFDanWw3eJ
         Wmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783918002; x=1784522802;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tIvuNpwtX62wjAACnY5xLsw8rSHDkSGnso4sTTSlICc=;
        b=b1HBZdxrkzqIm4O3uvEgIoCEr3cEJNmLDvfKZbHw+rtT6A8riNLRyGFjHCY1lAEVqo
         2ZfBIdieY/4Kj7yK4VXeUqk4nA4YXC6/oq09XHz0WJ7m2HPgFqN/SlqGFH9U2JCUnmYw
         DgAoP56//kjoK4z65XVE32/LCjwGqn1bSc0FBmVN32//zGM2AUB3xlaxM13/9B/Cq4Wm
         Kmd9bHh0MCIjIZrlZ2zGBGnzJpRKFFQcZ+Lmof519iASf5xhZ2jW4o0uczgXA8/X9H2b
         cPQn0uZvJQxV2rAfZm1dEN29xwEt0LKauPgE1HWJiMI884v8IdyvATWtwsmK0l8gT+d7
         z6/A==
X-Forwarded-Encrypted: i=1; AHgh+RpNvxyt2zq1G1W7/RupufFPiTzSPujGrcBlGtB9cqwNvGSubWzudVJbaRCTmNbm5Lbzid0ek/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMqPYvsGTD0P4bx0jgV4b0C61np6bh9LARG/fqDsbjTEoZhUO4
	RpsAD5Kqc5DcWDf+qdRLGCZDfkLUGKc2FZL6WRV1FbKQG22Xx2ZaZ9aiH4weamERHIlU94OQqSy
	ViTt63aiUU/MPFAEgm51yBI4tE+DNC3Y=
X-Gm-Gg: AfdE7ckDvVtbbPKwZCrzDu9H/HS2y+wb5nasrMq4LjBcFz61FwIdYiP/XwiJ+2RIgI9
	1cWDxWjVuxbUPvE7ejcUNNSPehOzUb74LlfuYaOJiFuHSB8ZB6nRI4tcoqegyNJg/zwkBna/ZL1
	kkuAZY/7jH0IyMcR09iXhaGPKqtpxzaxgF6cEJBZaN8Oq0g8tk+ygIx1ZHj1m35Djz3youRDGXx
	ZpWSPNYL7BX0CVX2gZoJvZAjslNWWm1g2Y8lmboW+Q8g+lA381p+tRlRV9fc6BBR1m2vt+FfXM+
	+sVYRbxWE0xcHsjCE3evktcxAY6FJlnQUbl0mQjSpgo5A8aPlab0ds5ZyLS0rWqY7K9WfIKq4tZ
	ZQ+lc9x+apIs=
X-Received: by 2002:a05:6102:3ca3:b0:737:80f0:7887 with SMTP id
 ada2fe7eead31-74533bbbd15mr4116564137.8.1783918001726; Sun, 12 Jul 2026
 21:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Date: Mon, 13 Jul 2026 10:31:30 +0545
X-Gm-Features: AUfX_mwwEselmh9IRE3VEYEs8ZRe2pmlXbwSM1DlLxUaasQrg06o4Yn065i_PUU
Message-ID: <CAMyXUJnsV1GD0VmK_n25hqr_=A5Z=u_gCXV=oACgKuP3dSgwnQ@mail.gmail.com>
Subject: [PATCH v3] iio: proximity: hx9023s: validate firmware size
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
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
v3:
- Resend once in plain-text format after the duplicate v2 messages.
- Keep each commit trailer on one complete line.
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
-- 
2.51.2
