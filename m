Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793147839;
	b=LyIxWCeFbBG9WIEiZLtomUuch5qChCcHAByrlX2+FHxwyNf9H8i13jjkBEL0HYY8y252
	 Se3erfiWEuqvHuocBx/cmoEcXg0BMj5cuG41K8b1hG92jaGqmn3qE3SF6Imkks1ut/5iV
	 GRXF/CMgRYC0B2kZAYAlZjWIh97Etjxt94fW+T0G03zhvVgHPm4LmF9lTOZ5uiIjbkQBN
	 uZQBwIQRtE+X2pC3NDAMuecckyyC92RPjDKJdBGRgDDmGL9+3FxKguWv7okdv/Ty6niz9
	 X9bi5V8fx/ktRN66PImO6OREIV/7MiFLUa9FTcvuFHnN5vZH8c7ivaxFDkT34ue4p9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793147839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SqYvixOaSSJQbje2En+O9XHXdXx9PhvsbeVvjhj94Ss=;
	b=jgqrwqisA+JINU/vf7is6e8rXvHs96xerDQfo0XAg07SyzpX+Fm7JUHSkTASlzRyFjoY
	 1dXjr87hHSIAn3mFwiYZm942AJCVyQS/GW8wgLJa8pzeV7Um3dcnnBuFrK1ipAPdq65BI
	 u6HnD4BCtPeTVtf0JxWK+z3SSofRuXUmymGrOaQrzFqx6ykXkzyuUqWPqxq7cNpdRRkIU
	 ZLgWPrSdAydp/kvahx1z5a61jls/JJ8a/e4uY/l6aOZ/uBBEArXeQsVHzDXK6pecnYQ9O
	 q24NPMRlFKm5itydmhpJs/znZu6IODVbiUscs21znrtS1mP2VW/xQCey4aaaiEWYLcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=XqGSRFCW;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D324A606A32C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 00:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D324A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=XqGSRFCW
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso4063295e9.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 17:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793147836; x=1793752636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqYvixOaSSJQbje2En+O9XHXdXx9PhvsbeVvjhj94Ss=;
        b=XqGSRFCWBECA4t134CNMPUEh6JdnMwR/r4aoxTsdni/ipcinmlCn3WQqkCwLtzEoFa
         P3pOHXVO0tQZ6nJst6Frk1Um7+vFPinom49jvksShnL2tEKtQys7PiSFjKC1mZg+G1FG
         F1KaI9rtqP+2S0dQShMANYGlyVWNtrwwjtlGvI6bCjjx4rjJFQiDVfOorCBunFZHo0eo
         Qjcv0dZFfpXlhx1en+nok1ISUiaDLe1VimpHGKaVEERSs9E2CVkgsZcFjXQdLt+Go9KY
         WIqydPmwRthBlNWaucBLRWLl/SC6JI66tqBqrkwEleCO+68X9hik4BHbwhhK+sc1WtFg
         S1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793147836; x=1793752636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SqYvixOaSSJQbje2En+O9XHXdXx9PhvsbeVvjhj94Ss=;
        b=mwJEBTLOzsewGQrEaDwp2NkXe5l+5NVgWC9hkj+IYqW/Rt4XDhmODV37OWT/q7N1Eh
         n18/mbbAaziX//htjXaGZtPZ+F2HTsViV3TlJGqQNgOxLY4E9mLHBOg3e9pjk9+PH9oK
         7/6GDYf34RtEG4CEuzxG8vDkJD6cgcd4SXtLq+UFE5zCvGNlHg7GGpbAbfGSeuJWhA+I
         2TwagR2Is091VYmTaTY+QMDwIP/vPsiDDrgFGpETFfEGNXZW5yaGY0WdGV/HDn92v+79
         kftZG6ZQ6XEt7aHZEQ5B5UE5lic4Rxz+aHV6Rd/9J9zibvq3V5TkJ8vAof042ZWOhIT7
         euMA==
X-Forwarded-Encrypted: i=1; AKwUvBxCFBdEDTofafxzrO/Oo+KOSzsRHQ0+J/Gag51AoVNc8D89UyHuh+8+LpdD5V1Hh2hkw8lMVsI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwSWT4pBd1swIdwDT7rR7Z9C5lokK4ZK/Zu0sBawCAKy+o9Pxg
	2nUMtPFFQaTtIx+eJqqhzN5oaBXAKln8TJ87rc5Suv0csjhgWGmEwyPHoTBm8P0EpHs=
X-Gm-Gg: AYBFou3vRsLo5ibiKXst1IaMmRpgtBqDGjim0A859K8IyoDGDD0VwlRQdt0tgIVlSYz
	l2HhA12/3mC555AS/4tszpwAOHkKsgF8HdCVtIr9kedTeO6RqvDcZXCOZFE1PQrxpbneukozbHx
	jbbonmnrEWrcBLdEz1mAJ63caM1B51Kh9nIXPCDyN3tg7VJ40j/rGXoiGv68WKUJRSRsc9eetI6
	OyvUM4kIVMJq1qMpNkIWeoCNGvrS/zbNTMRPwrMVce67xs+hM5SEbcgXJ9uJUQRYh/SUDtA0SVz
	nuFtMS/AYc7AxwC55T/bhD4SNQBzNJL2+JQknbszdui+4IAOuoJ7/Lg80hDfm4LxKAFMcWHAjcT
	jBFTA+mh3PZdo0VVismnW1MCJDlmwuOYKXm3Gh8XDYqh7fM1DpjFYO1x/zG2QsF0+ufytxQpOg9
	HwWgfeqp7kGlg92oWM4LWoEJvTHOXAs5O0mrsrHWvnhAGvT31J2bOl3Pl5KgVhAF/8fQ0btEMC7
	2Abc5tslvSzfhcStXuhERxOvdyq5hjekughFmclNSlHzI32FVb3U9UNEPthwgIhB1H9MVAVdKet
	Eadjd6V3F7N0Y2g7Nk4eV8GRs7TweZe1z3jTPa278ER5e0UTb0WU6OosGQ01bY9lAQp5zZCPwkY
	/ezFW9H5RBFo=
X-Received: by 2002:a05:600c:1387:b0:4a4:4d57:8487 with SMTP id 5b1f17b1804b1-4a96667b9f7mr12466015e9.5.1793147836309;
        Tue, 27 Oct 2026 17:37:16 -0700 (PDT)
Received: from irdv-jinli.dev.purestorage.com ([208.88.158.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a976010d2csm8395245e9.2.2026.10.27.17.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:37:15 -0700 (PDT)
From: Jingyi Li <jinli@purestorage.com>
To: vkoul@kernel.org,
	vinicius.gomes@intel.com
Cc: dave.jiang@intel.com,
	xueshuai@linux.alibaba.com,
	fenghuay@nvidia.com,
	Frank.Li@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jingyi Li <jinli@purestorage.com>
Subject: [PATCH 1/2] dmaengine: idxd: fix double free in idxd_free()
Date: Wed, 28 Oct 2026 00:37:06 +0000
Message-ID: <20261028003708.834341-2-jinli@purestorage.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028003708.834341-1-jinli@purestorage.com>
References: <20261028003708.834341-1-jinli@purestorage.com>
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

idxd_free() calls put_device() on the conf device, which drops the last
reference and runs idxd_conf_device_release(). The release callback
already frees idxd->opcap_bmap, the IDA id and idxd itself, so the
subsequent bitmap_free(), ida_free() and kfree() in idxd_free() operate
on freed memory.

idxd_free() is called from the error path of idxd_pci_probe_alloc()
when idxd_probe() fails, for example when the device reports HALTED
after reset. We hit this in a kdump crash kernel, where the DSA device
fails to reset: the double free corrupts the slab and the crash kernel
dies before the dump is saved. With slub_debug=FZPU it shows up as
general protection faults on 0x6b6b6b6b6b6b6b6b.

Let the release callback do all the freeing.

Fixes: 90022b3a6981 ("dmaengine: idxd: fix memory leak in error handling path of idxd_pci_probe")
Cc: stable@vger.kernel.org
Signed-off-by: Jingyi Li <jinli@purestorage.com>
---
 drivers/dma/idxd/init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 4b827a329756..1577d22b299c 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -581,9 +581,6 @@ static void idxd_free(struct idxd_device *idxd)
 		return;
 
 	put_device(idxd_confdev(idxd));
-	bitmap_free(idxd->opcap_bmap);
-	ida_free(&idxd_ida, idxd->id);
-	kfree(idxd);
 }
 
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
-- 
2.43.0

