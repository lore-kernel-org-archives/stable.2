Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687394;
	b=b3R4+XeLy4jwW8ILoMNqHgVnNsZMa4HVGxWUwKBS+UO9guJI3a2PilYuP+VlQV1yC8j+
	 lKS7dJTrRj+hKhcZDzP+DA/CVG5oj27qKGbifOJuKMOS5qqZJp3HvVf582KeA9J1ybGQ3
	 kgA2qKkb5czoe1MBx2RJDKU+qadXJvU5Rz3kSNqHflOjqjpmchM5py4y7zRUEGNPuRhOh
	 wMUvnMDukIhf1eyrRrNatCsi1ktOqKPfL/qLRXMEMY0TF12cJKkIfDLDDqFlcwJiClKYf
	 za7r98Kqh0mLH8hb4SuHdCtGr3hx1fEcP4+oVIWJzFTL3dqH+d2Ik0BU0HporIcag8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DlqRd2OswQ5wu8VHrHpo6vh4mLXNYer0je1L96tdIPw=;
	b=n+R6vRnkb9MzbEeZLipyklaI4LqeyttxWWFkP6G/pErsf/Rvwe6qRPdzo4iORUaCBtBk
	 b1n5dsdHlzfII/+gZUenNxtN9JVeWcrVP3tlaCAaN5PNYf/GpXNis1gf/FOER2Jbmu5ji
	 B0iXSyK4r1AaxDWtxc9LqYHwZmRCy5oVuHqc0DAG3KIW/DHDZnNwcz6UsblXCbbQCzcoF
	 et7JE0biv/j+JX2D2p3b23A0l0BHwX9QNKSJKWcuzs30fJ8K3A6vNy9z0UMMQ5AW7qXQN
	 j0NH5Doj3wX88cPiKkuJhovU0s6+H9+RH05C3QK79LsuolvC67DSPYPkgrrx9gyFNMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MEHsoiJW;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B04C606A32D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 06:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B04C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MEHsoiJW
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-18cdcfc05ffso4589735c88.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 22:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793687393; x=1794292193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DlqRd2OswQ5wu8VHrHpo6vh4mLXNYer0je1L96tdIPw=;
        b=MEHsoiJWEDS4Dzk7Wc4SeXmO11lW2V5Oqxt9ezfJSA4skiQn0KSvw9CV2yszdHV+kK
         CEiOJUO9cEQLam35aocWAO2w6vSg5l0yqzTQkmDgV2FwGm5y2K1fqEzQRionHPy/O3C5
         IiVMpPMg5T6T3SWpBIptICorHqZUyVxUBF1H8fzgb78dcsqoJCBvjhau6OmR5TGD++WB
         tOme0+MhKqr32PV4HqHjGjCD8taM2M6nid3NJ3fz4lwKCV6xFvvhIXP6TqFB53orTJH+
         iEHLzLEbbbVYTsPCNnGO3WYEF5WoGmJ4ZUPXmM7DfBQeHxwInwkOnCcjB37AmRNNP7yB
         Elew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793687393; x=1794292193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DlqRd2OswQ5wu8VHrHpo6vh4mLXNYer0je1L96tdIPw=;
        b=Rr9bOu9Iakq1AfQZr46FAR6jJrs1PnjSgn/UCcsnmexNezXR0ZSO0Bg+IW9JSGNGxD
         ZhexP6xIJf6W8yTLOYzMcraXyS7Y4tDmTDOU1/LWhUZJiR2JWMjQaQ9j760X9AOroRrZ
         dE5trXI1zDjHRaMP94Pw7/zzrr9y1ryk0pDwtcnDFgCSWvStTuEMJhOR+vN3zWcBXQJc
         RPmfTdJpiL9rDRRkyTp0AKSGoK/5OkXeZa7B4wgt6naIPKXKUAYm7whHksRpSnp6nkw3
         0CAkFejJAZM9UHzQ4rfkrSQK7Jvcotc+Ulz/pKRDjca01yv8+PXeQ7Uuf9jQtgfiy7cA
         ZAvg==
X-Forwarded-Encrypted: i=1; AKwUvBzDwhP4JaAkdGQsD/3eF8v6oboYFxkZouQfPmuVK9kJTWzaU39dHc6HwPXxiHCGaodcJxBY4Ko=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TGR4JxeJxN3ATwahlY1a5S0MSc1hSR6QJAE67HmhIz4Vj4zy0
	DftAnr/WNNjWoWZf7Ovfytapl8/8l1JmkTPIl+Ckty6q+CLOKOYbgYOqx3r2l9QT
X-Gm-Gg: AYBFou39efTconyVwpLT6BANY4w9HdDxfZe75gmnXGC+2SDnrPsG3jGC8B0ilSHA2/6
	eyKlHmJY6qHWRyUFMDcUvrTzeXrbj2FDiBsV4zfI7/23ITIN3pi/k+P9Pswo36XojIFWiMd7tx5
	Z9R2U89hGWD3troiC80K2pr+n7NCswJ41Gwp1ygwDYl2TrIIIlAu5lEUOc5QHd/XkbL7+GYJaC6
	Wke10/3jSiqsQetYLFKPfDKeq8PizegBcfSZVgmq4Oh6GvEuh3T8foBdQrGFU0ftQWzbjpSDsNf
	RPUE+j9/31p254FxAZLhLeGd8nVEtKaLqetr1T5piSZxghf3ZKM/zlVAT02ymv8BvIqqvGCKAY6
	Ys68bD736aUbJo3iQ9lc0scVW9DSTVA05evyFpM7pjaCLpe/TgDXCEyTn3M185YVGD6o9vTr7f3
	VUrqFGuZlpk41P1O4PvZs38ELU61vG1gLHZzO5N23Ui8wOvQFn7mo4Z2sPYiUzmn0PAxDMs9z5e
	25gBQbs9LP9FGbP0i8j0hAtD3XfvJDEKspx9XQaHHIQNq1vveOc5NeY4VGCvdyMybzEJqbQ3Gyb
	MLZs3UZPaxs+HO0Bke5PiT9MLxWjg8d0AERGbDY=
X-Received: by 2002:a05:7022:b0c6:b0:143:72b1:9004 with SMTP id a92af1059eb24-1ac5ecb37e9mr17812583c88.45.1793687392515;
        Mon, 02 Nov 2026 22:29:52 -0800 (PST)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4a04esm39366350c88.15.2026.11.02.22.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:29:52 -0800 (PST)
From: Priyanka Mani <priyankamani2100@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neill Kapron <nkapron@google.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Priyanka Mani <priyankamani2100@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: uvc: fix dwFrameInterval array leak on frame removal
Date: Tue,  3 Nov 2026 06:29:25 +0000
Message-ID: <7f7db2bcb2c5d248cf72a270bd18afc71cf01559.1793687064.git.priyankamani2100@gmail.com>
X-Mailer: git-send-email 2.43.0
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

uvcg_frame_dw_frame_interval_store() allocates the frame interval array
and stores it in uvcg_frame::dw_frame_interval. The array is only freed
when it is replaced by a later write to the dwFrameInterval attribute.

Frame items use the generic uvcg_config_item_release(), which frees the
frame itself but not the interval array, so the array is leaked every
time a frame directory is removed after dwFrameInterval was written.
This happens on every normal teardown of a configfs UVC gadget, and
kmemleak reports it as:

  unreferenced object 0xffff8881027f5040 (size 8):
    comm "uvc-frame-inter", pid 281, jiffies 4294827366
    hex dump (first 8 bytes):
      15 16 05 00 00 00 00 00                          ........
    backtrace (crc 60980708):
      __kmalloc_noprof+0x4ca/0x7a0
      uvcg_frame_dw_frame_interval_store+0x299/0x440 [usb_f_uvc]
      configfs_write_iter+0x2ac/0x490
      vfs_write+0x60f/0x1100
      ksys_write+0xf9/0x1d0
      do_syscall_64+0xfa/0x5e0

Give frames their own release callback that frees the interval array
together with the frame.

The leak was found with kmemleak while exercising configfs gadget
functions in a VM.

Fixes: 46919a23ee87 ("usb: gadget: uvc: configfs support in uvc function")
Cc: stable@vger.kernel.org
Signed-off-by: Priyanka Mani <priyankamani2100@gmail.com>
---
 drivers/usb/gadget/function/uvc_configfs.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 70a1415ea401..48105b36dbfa 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -2142,14 +2142,26 @@ static struct configfs_attribute *uvcg_frame_attrs2[] = {
 	NULL,
 };
 
+static void uvcg_frame_release(struct config_item *item)
+{
+	struct uvcg_frame *frm = to_uvcg_frame(item);
+
+	kfree(frm->dw_frame_interval);
+	kfree(frm);
+}
+
+static const struct configfs_item_operations uvcg_frame_item_ops = {
+	.release	= uvcg_frame_release,
+};
+
 static const struct config_item_type uvcg_frame_type1 = {
-	.ct_item_ops	= &uvcg_config_item_ops,
+	.ct_item_ops	= &uvcg_frame_item_ops,
 	.ct_attrs	= uvcg_frame_attrs1,
 	.ct_owner	= THIS_MODULE,
 };
 
 static const struct config_item_type uvcg_frame_type2 = {
-	.ct_item_ops    = &uvcg_config_item_ops,
+	.ct_item_ops    = &uvcg_frame_item_ops,
 	.ct_attrs       = uvcg_frame_attrs2,
 	.ct_owner       = THIS_MODULE,
 };
-- 
2.43.0

