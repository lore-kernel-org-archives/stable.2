Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490EE4D486C
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731798; cv=none; b=bLlIafZpS4jLay54i3oQmvpgwULuwcK0MJzQygunNk9vV4heG+NXvB2xiRMlft6j1k8qNOZubhKv876R+bGnOgjetSIfGZK8mkCGN+dcEAlbKwQ/ErdWCrO5pd3un3dk9hh7Jv4LEhlZnIgu6hvSoCyrOwmJ5PNgGRH4wfGf6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731798; c=relaxed/simple;
	bh=YPCbPoNI3G9onv6LNr9Q7xmUQkFxJiPZUTMXLRk5Fuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G1Mew9tUgSMW1r+0s+SxuQQ3KGsdxmncCMOfYcwpM6uUa0UeueeHNVqXAtEXXXgiBj8GpJW60alZXfRTgUry6V3pyovL9d446X/rsezGbQijfTXi48vSD3OpSq8Y1TpPm8VwgcTa4XpgNPax+mYV84ztwmitcWQIxVhhfZ0/F8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcPgz3en; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcPgz3en"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so551682a91.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 04:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731795; x=1790336595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=erDD/o7ItCDetIXe4X0kGs36t1bSEm4QSr1YQGtDTmY=;
        b=hcPgz3enKsdNyRZDTBxR1fMf0kByHJM/dg4IeqOjS6jSwLgsNqIsG8STeMDcX/GR/X
         eczR9k0xquf2Yfg18KY5dhUldKpb2sY3SxyqHLVqzSDktQgUQJgxBhbXrupDrp4AACmI
         3aYOLI2YMhIz1X68CsFBhFDLourDKhmr4al5PLflJ9PK0ty7SC5VpNYYxfl6UjykvnrU
         yjnlZICImKkJrXZfUT38GyBhz78+rYNRU86eUW3TwhkQWiV/iEijHQ8/xcem69sbQCmH
         57d6PvpDHmHvRzMxoEZ/Qq1tR/M/G1a0TGwnFqCEkOrtq0E5IYyDyrpbRAShASh5JQvV
         xTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731795; x=1790336595;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=erDD/o7ItCDetIXe4X0kGs36t1bSEm4QSr1YQGtDTmY=;
        b=YZChS5E4xbTEhX9OjAupF9oF06Q0X4/wcGKt6PihiuvdMKjYiJ99XUkHV54Lm/5m9g
         A81JuYA7A+M4WHIojNGbPTnpzjReC6G3GH0CKAxdtsf8EKNOkNHrUO0d65PHXVb9Ylzg
         3kM5+AKx7cj4+khikAMQdEkd4yduPZLoiy6T8iN5DS1pwkqjXrgBCXYQjlx1iUCf08SD
         dFw4apn4oDjhteHTB/a8K8JW0+uCAJZMKjYls/2TVOFK5gnXMi5t/9ZIujBkPc9oSuSi
         IjgLc3Yf/dkXu8jVavS7MNCiCREumEo0lxZSEAkcTkyT9FVsgRVWVkx1Hmr0aecSSNTF
         fSvQ==
X-Forwarded-Encrypted: i=1; AKwUvByKS9hFQULScq2oXghkynpXGM21jpj/NLSH4YzVSgNYV2zaFqvny6vRWDKfjlsQWSJuDlieVYo=@vger.kernel.org
X-Gm-Message-State: AFuF++mf5QEOh4o/Msx+5Z3yppEO6FMeQlF2rT24EsIuTqGL+NN95alb
	+BixWEMflwwKeEY3i1hFNOY046u4xsKlAwpRWFjLfIF4oFGMVuE85z1P70UiFR7f/DfODA==
X-Gm-Gg: AYBFou2Re3kypUaf5jkNMxr07GaleOFnQG4zPHU96p5xv+FbSEz35gXiDnXPEauX6W2
	cwghvw0i8hF1sU7kP+uJAAXnHHztwLEVbSEo4tHvdCyeAt4jIe9PnKoFxk4yIOg8gcZ2bafkrly
	3N3Lo9FTSR6MEgVnVDFxvQRNkq/7MZ6zrWV2cNdn0w2PTm7AWfy7dOpLLrdgcF5dFwdcKyFp/f9
	0xho4io6i8WAodnG/w0FBWYuCRap6EGkjOe/7ylUSCzoiBFu+ZG3G8ZQsxPKnUUub3RxdVnC8Rf
	nXaT7DyHcBRsBybFCfxGgwHMPxYZx6OSv838ZS4uVVKZA+VWaKGrONvtlYLduHFbl53EYfN4ITH
	/6WPdH4wCK3i7AghpmYG8yIoJHGAFX1RW91l5GA4F8fcr8LaItHpntGBdo53q6zTJZZxewHMIYc
	XvlPSwr6VwbpTbvv7vitZ88hkl1tlBoJHcPeqZ8ob6N2uUza2CFyV1iSzO6j+c+s4tmapx3THNQ
	i1wxSFpOJxTd7vYtMeOaQ==
X-Received: by 2002:a17:90b:1c84:b0:39e:4c97:ce09 with SMTP id 98e67ed59e1d1-39e4c97cf02mr4613634a91.42.1789731795473;
        Fri, 18 Sep 2026 04:43:15 -0700 (PDT)
Received: from 73ebd4c7787b ([183.194.144.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c286d98e7sm4603983eec.9.2026.09.18.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:43:14 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Carey <carvsdriver@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH 0/1] USB: cdc-acm: skip URB restart in port_shutdown if disconnected
Date: Fri, 18 Sep 2026 19:43:08 +0800
Message-ID: <20260918114309.3659635-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg and USB maintainers,

This patch fixes a use-after-free race in drivers/usb/class/cdc-acm.c
introduced by commit f58752ebcb35 ("USB: cdc-acm: Add quirks for Yoga
Book 9 14IAH10 INGENIC touchscreen").

Problem:

When a CDC-ACM device is unplugged, acm_disconnect() sets
acm->disconnected = true and then calls tty_port_tty_vhangup(), which
eventually triggers acm_port_shutdown() from the tty-port layer.

acm_disconnect() has already called acm_poison_urbs() at this point
and is about to proceed to usb_free_urb() and usb_free_coherent()
for all control and read URBs.

However, acm_port_shutdown() unconditionally calls acm_unpoison_urbs()
and — when the ALWAYS_POLL_CTRL quirk is set — immediately re-submits
the ctrlurb and read URBs via usb_submit_urb() and
acm_submit_read_urbs().

If acm_disconnect() then frees those URBs and their DMA buffers while
they are still in flight, acm_ctrl_irq() or acm_read_bulk_callback()
will fire and access freed DMA memory, causing a kernel use-after-free.

Fix:

Add an early return in acm_port_shutdown() after the delayed-anchor
drain loop when acm->disconnected is set.  This keeps the URBs
poisoned and prevents any resubmission during the disconnect path.

The fix is a 2-line guard, no locking changes or functional impact on
the normal (non-disconnect) tty-close path.

Yuchao Zhang (1):
  USB: cdc-acm: skip URB restart in port_shutdown if disconnected

 drivers/usb/class/cdc-acm.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.53.0

