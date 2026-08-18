Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD085336884
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041933; cv=none; b=t9Z5TvUuVoOCLDA8qU4l2zvfAW+FPyWVuik950N+HVBfQfnXwHKyD2uYxubqVaQQEUMcjxVQzEiongKCrVgbzn1mfP+/8+i4QctRiXu06ieE5AyRGTacGQ4J4qJUrEDatmgUv+CfHyc5U3WJdvQKr2IJZq5AcZGFo5ZmSo4/8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041933; c=relaxed/simple;
	bh=I2norSdTmLGJ/BWeCNZKtsiEtdjE2ZSG9EdEOc+y864=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0S3K9OGao2Q66BtHWPJ2UBsw7C/NXkXulPXzbrP1Ic1BUC1XZsQwLPncm9CUuOi4kGa0GKvASJksxqcCWYb3cuxbBVBprLEEQiu+lHWd9aVEMBZVBNFaTajUzDtiNJrtKtzToihzDnQ02ju2fYRjev9fP7seDZJrg/0EqmVUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5h85rJ6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5h85rJ6"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso22241735e9.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 01:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787041930; x=1787646730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QG/UVFd2ACFMYaMnp0CQ6c77bR9FNNHaHabNi47aSho=;
        b=f5h85rJ6l0ZIRucfpk51Gf41TC8wgXbvEw4nSd1500AmjpAObUmxZOdPcAroEVuhWo
         eHTXbR9mDFewi/ik16oXZUiBPukUU+lTB4LmWy+i0i+Na0D+323P0HkvYEIWEgupu/lI
         mZZE6jcy50PTWxkxn49s3zgWgcjJC4oMbfZ9srUpV1lBb//ZM0u1tWvdJ742J0RGYMC6
         xL65XRYGtTR9C1bqiTC3GOAkMqUG/bULviAbPILC3mJvuth5WcMCxkFEenWFpFwedKPf
         h5R6DOqOryifLitz91zLEyLW+LdPnfZkA33mKgIv/6hZjx38yiPsxB877AhVOY3wC0zP
         XMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787041930; x=1787646730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QG/UVFd2ACFMYaMnp0CQ6c77bR9FNNHaHabNi47aSho=;
        b=Yh35ANq9hdmu4soTdTwILHlcwx66fxGDH7aTd75uDVsPoh4FzgrPezpuQ/LorxZteX
         WLyaFAHKduRyJotzAdEatvf2m7kXSHMmM9MYwgDzANbOEZ3otiyULEDrRKWTv9U84Gx7
         9eCWJV4H/UqJY0e8qb4jynUPKXzCpFKNUJe0GDknr+W4eRRzBnYXdO5G2CohF9BbgNuc
         QJmBr65QI4Ol4D/sh6MfnkEPnNyuqDh7lHxBTRK2qOWjzzUcajROSxjBeVz8A05rYbey
         cpbqTjHvGx19ZuUfkCxSUtxRmkRuK7SRGlnzi3AO6xzYyA4w11qukO3YJgoXFCk7r95w
         wEXA==
X-Forwarded-Encrypted: i=1; AHgh+RpjTbj1iYVXrHoPjc8ZQHSw/kGjxTlRFxLUPTxSJPRQc2Wq5DORcE8OZwwNNc1wdO5P3oESoEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyysRncDaB8hFBdnMSB9v8ZecQFhUjxAs7UyL1KYsOd/vYTwrca
	uK50aHYOfcpgP0vH89GmzFf1LZXp+mnCZCTSIBbfdGFzgR2INRJ7wrVf
X-Gm-Gg: AR+sD12PdN8j3Maq01LaJmy/gA1HAp+Tkr3gmGZ6r1L7j+BoLJY3Mg4NoqPyfuMxobq
	/5z4wU/6PxMHouUU2ND5hN2mA1t875xi4BbQ6DOuzckRQGJr52Uw0ihzu70pDHEVH5FqI/IUiQO
	Rgry64UXM1oIMalqtQqrNDBRX9uAoxH0kMtILfRjJT00DmnfpFUgrnIwV4K4G8Vu730kxPI3upR
	klNUEjXI31owvyvOxhvXQY8CTid3cMKvMqothHgVnTw2hOrA2zjNQdPfzLh6tgjgsm+nqRThlrE
	P2MaZk/GrhWDxO6pIVV3/RBru8pWMLXMXFS2/V1KlwRsmp0T7PPGKkHDygZ7DBWC4D/W2ioDpNY
	kgbqPxrK75N4pnpqIMRgDTEG8XzPYYxb6HpGEWNG7zPjqLkVNrxuw8CNnWDKMgEUBYkvSibCYZn
	+UX5i2HGQFp+C1Ehk3QanH/Wt/jUU7IEYSKbXass4FN/huY12UOxlC5bpvaQ838ivYqLD/q4ApO
	QQ7Txpzn9EaCw==
X-Received: by 2002:a05:600c:5397:b0:493:bb6b:5bb5 with SMTP id 5b1f17b1804b1-499879857d0mr519017545e9.13.1787041919339;
        Tue, 18 Aug 2026 01:31:59 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996109652sm289304505e9.4.2026.08.18.01.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:31:58 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Fabio Piparo <holofermes@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/ssd130x: Set the address window in ssd132x_clear_screen()
Date: Tue, 18 Aug 2026 11:31:40 +0300
Message-ID: <20260818083143.37939-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817152500.703770-1-holofermes@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Fabio,

> ssd132x_clear_screen() sends its zeroes without setting the column and
> row ranges first, so they land in whatever window the last
> ssd132x_update_rect() left programmed.

Good catch, I noticed the same asymmetry. But as Sashiko pointed out and
you confirmed, ssd132x_clear_screen() is not reachable today, so there is
no user-visible bug being fixed here. I don't think this should go to
stable, and I would drop both the Cc: stable and the Fixes: tag in a v2.

There is a second reason the clear cannot work in its current form. The
driver does not override .atomic_commit_tail, so
drm_atomic_helper_commit_tail() runs
drm_atomic_helper_commit_modeset_disables() before
drm_atomic_helper_commit_planes(). By the time the plane's atomic_disable
runs, ssd130x_encoder_atomic_disable() has already sent DISPLAY_OFF and
called ssd130x_power_off(). So even with the !plane_state->crtc guard
fixed, the clear would be writing pixels into a controller that is
already powered down.

None of this makes the patch wrong - I do believe in making functions do
what they are supposed to do. It does mean this is a cleanup rather than
a fix, though, and that it cannot be verified on hardware until the
disable path itself is sorted out.

> +	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, 0, columns - 1);
> +	if (ret < 0)
> +		return;
> +
> +	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, 0, height - 1);
> +	if (ret < 0)
> +		return;

This duplicates the window setup that ssd132x_update_rect() already does.
I would rather see those two commands factored out into a small helper
(e.g. ssd132x_set_window()) and called from both places.

Note that ssd132x_update_rect() cannot just be called from
ssd132x_clear_screen() the way ssd133x_update_rect() could be from
ssd133x_clear_screen(): it takes the R8 shadow buffer and packs pairs of
pixels into data_array, and clear_screen() only has the data_array from
the CRTC state. In the SSD135x series I have in flight,
ssd135x_clear_screen() does call ssd135x_update_rect() with a full-screen
rect, but only because no pixel conversion is involved there.

-- 
Thanks,
Amit
