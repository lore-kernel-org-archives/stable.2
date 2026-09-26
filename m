Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85CB757EA
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431763; cv=none; b=ZZ4HWK4v8KpUpv/BQdNaQuc+xTTclS1fr1GWmLCOeXwT0mLWdatWY4holCe+rVDeyJURdVpkK0D66sImAq+IF/xpqfKRyC7DHoyPOa/dRudwDdz+sYvszX5K0TC+R7FQDXsuhYby/+kvyqhYUKx3LIwP6QEvLPWbz4/Y+ojcMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431763; c=relaxed/simple;
	bh=etrwk1jj7vbSnyTTqgF9FfjwDx8vHLxlRGzyAJzKVjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQZ/fBheReuW3y1XMkQ/oTbX5G/Vta5RTjvDhvSDqw4HQxZ8DcwtsTWUrxoq7pgNj8ceQEeqItKSiAoJSp+ZNVI33QVpBano0zMENKUDMSUvJsjXEzsemAKSHQGcwez/hoXvymQHWFroS+1yqNf37XAbh5X5+smcTYQMjD9pTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbCMqEhv; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbCMqEhv"
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5cd63c192b9so425550e0c.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790431758; x=1791036558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vc1otBls11wsX+j5VdMpDkxyMmYSz8SI4nun8FL9hPM=;
        b=WbCMqEhvzZQY8Xc70PP9vd1IBfiUyaUw96bVukEg8jEieRLApcNyvICyMiE+mUf3DQ
         ndQ4mukeVLA+l0OBl9yJYU8c/sZ+2iwntzFmc3KcK9rhGvPssTz21JuBVZT+dInZ1xha
         5Kj2RkijRgzRzIOBxpNVJ/48T/S/DIvEGbTXYGgIMA+fG2DAz8X3rUv1Mnn8eoR+5RGp
         q8A9qqBFYNhEMq0aYtDniGWMffiJlsH4MTgBM2TCdI+iqGPIfsD2R0W6lZRNL1Ql+5vd
         DEuhTgNx06wH7ImeZ7RByMvxLX6KUVR6e05Pfc4b7jCWsIkju/vLOko2ZCJAtOLs2b4K
         Mt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790431758; x=1791036558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vc1otBls11wsX+j5VdMpDkxyMmYSz8SI4nun8FL9hPM=;
        b=v5mw5swYpjSggeKnJqfFsxHroJa1CYqOSamVDHul/SPKIXEadzRD/I8YlFFN4rsFf6
         YfO4ksRZCjD+vCGm7Tw746gq4gaqD2G6W1z1c2No6IlwaBVFwXvXlef5lzK+88Qqoicd
         3a/Mu9H2i8BjGRpDeAxW26r71wlEGf/P8Jskf6Cu/BCpkbwakZ/K5a/pzYaeP7q2Ln2Y
         mX/ZwLxqeTexSwXti8JAYMNDMHL+YHQb9PXH1kdymsKJ0xgOza4pl6ncpieBETclIYdl
         cVIUeT420FaS4UYDD5OM+fBty9m9kc96SA8BAcFlGCkP3LrzmXkMwNn0Ssa+8ivMrkYL
         4Trw==
X-Forwarded-Encrypted: i=1; AKwUvBzIRrNPY/UkVlSW3NjlmQmCksWTumVskRXUdiGpNGlf070kJUlT4XTNDfiwCbjbglV4nRenQmw=@vger.kernel.org
X-Gm-Message-State: AFuF++nONCpz/sfL0/dcfy2j4KCBX2KQS+EfQ1FFUF4tT7X7TgpEjzAu
	T1hzd/O+MA4ptPAou+/XcQTMaGcafA1IAcZJmKrqfMiQtJkXCVBTox0i
X-Gm-Gg: AYBFou13F/lf29jlStudEdfiy/nYFoS60lFXlkJN/8KrcEHgDA7Sf2qouNFzAeN2/1l
	zU1ZoFQ46Dk34ACv1/iObwUxr/hGXWrh6QxIvgKQuUkZfI/yJE7EZehXDw20E4L2l5VmAWEuHro
	dTSnztV9ReYGTmnaVE4Sr1z86QrDC8Ve/prQJfY5IZuO3CzQuYFXRDDTBy8byGpFFODXX59lXdu
	r8h3sGccdzfyunrCu8IARx3qfqTHKHj1apFH3kaOeP88OgRRcmEO9XRc/yvuX3pRQqKO1Y26AKg
	eUvq9vHNh7d8y8qYLKsxTkeKZS32ukrjAK3Mja9Ywbzw6083sKZ+cRDmuzFJCb1mCF8eLfDVbzG
	UsoDUnkOlZwZS+Kf2s7Q8ooVslgBB60xGbEJGWlBMR8bwHb1lmChtHV6Cc3D1bIZbSu8ylLyVrn
	PhB/4H2rHD40v+UWhTVCWQQLyfIuhQW6DTs6EGlNO6x//VTG8DSgkqD/qsbHV+9HE=
X-Received: by 2002:a05:6102:504d:b0:7a6:85d6:8ae0 with SMTP id ada2fe7eead31-7b1c4a2eae5mr1332435137.1.1790431757711;
        Sat, 26 Sep 2026 07:09:17 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b159055sm2319867137.3.2026.09.26.07.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:09:17 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v3 0/2] debugfs: fix UAF and double-free in debugfs_str read/write
Date: Sat, 26 Sep 2026 11:09:03 -0300
Message-ID: <20260926140903.1077151-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026092647-ebony-unlatch-d3d0@gregkh>
References: <2026092647-ebony-unlatch-d3d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3: regenerate patches with git format-patch against current mainline
    (v2 Failed to apply due to an incorrect manual edit.).
    No code changes from v2.

v2: split into two patches, add Assisted-by tag, include KASAN splat.
    https://lore.kernel.org/driver-core/

v1: https://lore.kernel.org/driver-core/20260925175831.3701812-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  debugfs: fix use-after-free in debugfs_read_file_str()
  debugfs: serialize concurrent writers in debugfs_write_file_str()

 fs/debugfs/file.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

--
2.43.0

