Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106F3E1204
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282386; cv=none; b=LsZw2JaRmGuIuDvEZqEiLHARLuM/9HfOvCf1qKBlPa6eJFm24V0O/AGGGSlXXTaqr08dgFd9bitnr0e7A7tzduduUjtEUQ8Zhg9NGMBuoxTTLHVks/kbHq6ma+MxZADi1JRzxNViuEgHTGsn2U7gx2GAmawB0ceQNHYsVvL3wI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282386; c=relaxed/simple;
	bh=di+Mh/b86F3wXONTaaZklyskM2AArrNMhkc2iR3mHMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UW1JnaQr911PVA22DekQiKQmxDzhzCfXcKzPOzW+2QcEZd/J1M7fFu9TxtO9CzMaugohFo65KBHUvXb7jvxhPi8wwn7KtPKOwt8pCNULWbfRAJISWIWQwatMWUq2fhdGlFJH82KIaOqTIrjccXgUKT+yvZFVTkfbVUIrCzzgtUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdYE27S1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdYE27S1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e2fd2603b0so4467065ad.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282385; x=1791887185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WFX4SVdMUoUy+5Ur1rRMmdJPeBVm5LQQKBJ/uWUKeSE=;
        b=PdYE27S1Y175KtP7DLHrGR6io16VktyajjNMZ5haEzs6rG2SnkMlBCoM6MgUAa2kGJ
         xSIfCoaE8giifeAroDecsrlIAmof+SQQ0WmfR4NkJhhy2Gc4DmQV7M59UQktbvofw+/5
         OT85Pi0zDuQ6k3gr6aTsDrGBRlgBvWaydtRekvG6ifRIBywcQjhbZExR2bK+tmJSpVNL
         1Umu/j8qYFw8MJHsjKhQSjQt6UD2pQXltUwCkAZyGQevC/v5h3b61+v3/Wlc74t3Fknb
         XCRY7mG4SiPmZfuKubW6u81ZTzsIYuOBkxcQrLyok7oHdCUsS7W2pJa5CgALKv2IsQh0
         qRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282385; x=1791887185;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFX4SVdMUoUy+5Ur1rRMmdJPeBVm5LQQKBJ/uWUKeSE=;
        b=1aPO3sBSoNVo8vei0P/ebYw3+D/is/iP5DXNCgJVEvi+ZSWt483scndmJG9awelKNE
         WLC4+9vksaLs8iRfsyHSdHFhaDPOxT7Uc/09farGTlxxBzAZM8UF8HDIjb6rVz2eqBeE
         SbwTC6q3hb3J0b8BmcPW8wfzh+8rarmqmj7RW9RQgtj+TS753TliK22zmuA9edevdeTE
         lK2OoN2Mzt3HyQxPiRAnxGnBi7DTR6iQysakDx/WxKnUSdflaMBW75wNtDiHQOo3oL5P
         dbPH04uW7rGZ12zqUsGzfRUVJFk1ywLsl135ECyuF2R+5Ivbc7NhiHwb8E5UrT40T5qL
         ct+w==
X-Gm-Message-State: AFq9FYIqr2vONGOWLcFT9oMsrlfi7cRDLl5JWSwgVyAHT/kY23OG+Tlr
	AoRKQTnD8zSTe2r7tBiUFyhsVKPdfkFQztBAzh8ykqUDaWXfipSIE3pWlPVJVVaD71U=
X-Gm-Gg: AYBFou0l5C46wT8MrzP3PJO3fUn5GyxscKYw9Xuo/kpOakbOhTE/Zjw5AMFfy6c8qw0
	KmrsZAxeIXBknMAhy7hronUDywcWf7fpdtLZYRZo7s02Fttaj9H6zPbW1qA97tclYSmvqQqnrCq
	CHFAzYT09JPHh/HvkVote3/IgUzK0aioCae0m8q1TgfNPFkywlFNezVDZnYSLz8qsmgh+aLSnV0
	xAaW6lLD0m57dsqaXT9BBVmLfHahNRLCJMUsVnIN9Za0CPoy6SmHkbjnI/iRfthWpj19EdchWit
	reOVnkAZoXtS1obc5bgEOpq6hdf7AbS97mfpTG4eQd26ws+obdNvGKgZoMhs01qlUV+JvhvCYLw
	B4XYThQRK70i9jvjKGxRlaiDtQKpVHVx0o0sAPbSfm+JGibQ196CFg1UAzYjtC+GiD/Pshwungz
	U1XAGtT6D5E9URYkQkS1ka/pBDRkFl5NPOYHONeGHR6UOplZNTdOptBALZOkrT0owj93V0bV4kY
	Vi61ixD0tRBOauWGjkDg5QfCBEQtOOzkn0g3JbMGjAvfllJiNG2WG2Rs4ZhA36U2LSxYgnWFfir
	cKDXW41G
X-Received: by 2002:a17:903:3d05:b0:2e4:b218:f689 with SMTP id d9443c01a7336-2e5dcdba966mr7448435ad.53.1791282384685;
        Tue, 06 Oct 2026 03:26:24 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5ecbed5sm19532515ad.47.2026.10.06.03.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:26:24 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	joshua.crofts1@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH 5.15.y] iio: buffer: serialize buffer teardown with mode claims
Date: Tue,  6 Oct 2026 19:25:14 +0900
Message-ID: <20261006102525.172949-1-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026100642-decathlon-jittery-ce0d@gregkh>
References: <2026100642-decathlon-jittery-ce0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 84bb0fc46ccf6a545b8fdf57cda83770186ed8dd upstream.

Buffer-mode claims hold mlock to guarantee that the device remains in
buffer mode until the claim is released. Normal buffer updates take
info_exist_lock followed by mlock in iio_update_buffers().

However, iio_device_unregister() disables and deactivates all buffers
without taking mlock. This can invalidate buffer state, including
active_scan_mask, while a buffer-mode claim is held.

Take mlock in iio_disable_all_buffers() so that unregister honors the
mode-claim lifetime guarantee. The info_exist_lock -> mlock ordering
matches iio_update_buffers().

Fixes: 0a8565425afd ("iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

[ Backport by Jinseob Kim to 5.15.y: mlock is still in struct iio_dev,
  so use indio_dev->mlock instead of iio_dev_opaque->mlock. ]

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index c81dbd2f0972..30d20e3ef051 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1187,6 +1187,8 @@ EXPORT_SYMBOL_GPL(iio_update_buffers);
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev)
 {
+	guard(mutex)(&indio_dev->mlock);
+
 	iio_disable_buffers(indio_dev);
 	iio_buffer_deactivate_all(indio_dev);
 }
