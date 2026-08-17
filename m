Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAF144AB6C
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982982; cv=none; b=tt/UVF3Znr6Buj2AgSW0sm7MlD+4lQKUYYOZ/c5u6qEpDy/GPThTtw8RouAN3U4bTDryhQW2RcgtL1oPvxHFbzdLmZ2xYpzJ9g6+ODWTeAvc/zlu8TPa1E1YKh6nihqd0vA2flJcI2UyxtGofGBmjPm/CspxIT6QhRFZErBqV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982982; c=relaxed/simple;
	bh=3ioQTCR6NPmKcAUQa+YGkAxDVioWSRJMHck+2juAYqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxithGiVP9JrKixGDnjNZWx0EQDGlAbmzpI2jkSDyX2ou7zuCUkIvEYKtkKtu+VNRPG7RWJDZ1W0z0MgOr7q71aheVAFA2GMdZPDe7Bwa0y/EWYmmC8eCtn9U7A4Fv6gqFQHgmPeSGZTh7g1z4GLZGdeeum5GxI5jU/TRkANcQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1Cs/tck; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1Cs/tck"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8485b358552so786042b3a.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786982978; x=1787587778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WC5+Xv8TC0JCUAachW4xnIwZrYhT5/dH1idLAYXXfSU=;
        b=b1Cs/tckyThGTz57h0yhpG5rYibcPz649vkLjnKqEY5xmCicrGBtI5GueaiL0CHqDn
         GqlDPPC0QWAJmXOqGlWkBH37HTt0PvcqO6OyUYVlE/z+4mJ+0KofNft0vanxOF0RyyDP
         jqOrFed8NDGBUye6f7Ph73KcSwkQtAnN/ieXKaaXQC2/Un9eYkdY9TSjCOF38aCvDZbe
         ZmneUQf9YVQ3AI97Sm4LTdINC9aWiFgRytxms2fh1TxkQj1HWn6z2OthC9p9ehJTj5eF
         kLBsTrXc78dYYeB5WYmAp/fUWrEv7GHXlyFwQDaEzS3C+6Ku1BSgAwnm0bJnAG2gzsm4
         7pnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786982978; x=1787587778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WC5+Xv8TC0JCUAachW4xnIwZrYhT5/dH1idLAYXXfSU=;
        b=Us/Rd9pqf7xItrht6ZHpOSqFLb2eF0fW50c5PLntv/fm2MQsZUFLLruD+fz7IXF2Ag
         8mLJMxmZ9W6JmRM4miJjIJcKtQ4/Rz5X2DZc4bpN440jHZ5VZAXaUQvKCTYs3JejQ0Oh
         0XqIJv/FGkuR8k29P16bENjJg2R2UjZAtJADqP2xOhNjl+mTbpMNwObVuSffAMXRBrxI
         hCZ9rdnVsDDWvBPWVWdxuUOPwAImkpFkSbBhad8FKOF6h31ZstRu1y1921RosBNuDl+K
         bHaHT5OV5CNxZW2IOiSfgX01aN0nkDPz5LhXbYK2V1adPGTMhs3zi4FN8GHwpSKpyPtN
         rwLQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro2SPwkwntu6sUZ3OtMPsrCjMkOeGQVxQ67RDNyFB7RshFqMptCpnl63rmTNRhi74iv0bnuP60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMalqX8V+4Y7+rpvFKysv49B0kzJOfo80rnUEEM5KmlTja77Tn
	QzkM6aEaGz9QOJlFeVJ2HpOmusGbbsy9VFKU9+l9TpIoNeYm3wjWAno/
X-Gm-Gg: AR+sD106rSxT8piYskCgdi2MNjHSGZfkhRmu//VZE9eIgTaSLmMgMugIK1I+46jxyc5
	or1SFdLPpAGq3nnU3Mfhh+PZNr3n5CA6lF6cAoucXU/Zwl6qw+wWGm9AKH0X+p/QNcz/jwSXdXf
	Wm6KpvHbRrHtl+wyMFITAUrc93ewPgPJxf+hyA3WUA7d/kzpdrn7ueVtDepdFToApcrbfvHy7Bz
	ImrdS2AOsrHIQTQPD3qn5ajqBR4lBsWz7iWxbe/HxTTUHd3uB3FkYVlNdOYTDU356p1MpBzwqJE
	GGhCTgKFA+A3lbW3DBLT0m5p4SI6WEHuVAnOwiF0cYtvDyfY3oTuKlSLgiXex8f7sN89CC3jTNA
	laWtkHOdNcqTzJoL2HhSZ0oWJYU3TOFIw98WD30d0baw2/Klz9WvFusM38Iuj6x5xax0NoNAOl6
	9CTiww/L+Aa/UbW0JkC8vgT0tCg7RXw3h0iZ/WQ9C58xWufZpk8zHbddgPV9mp3voGh86tVgWJ/
	SiC
X-Received: by 2002:a05:6a00:4186:b0:847:82db:9046 with SMTP id d2e1a72fcca58-851b885b6f0mr1776047b3a.26.1786982977545;
        Mon, 17 Aug 2026 09:09:37 -0700 (PDT)
Received: from Default ([2409:40f4:103f:ca54:3a70:ebd6:25c9:29fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b4074d41sm818063b3a.27.2026.08.17.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:09:36 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: jeffinphilip14@gmail.com
Cc: christophe.jaillet@wanadoo.fr,
	felipe.balbi@linux.intel.com,
	gregkh@linuxfoundation.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	stern@rowland.harvard.edu,
	syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com
Subject: [PATCH] usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()
Date: Mon, 17 Aug 2026 21:39:16 +0530
Message-ID: <20260817160916.28523-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817160319.28251-1-jeffinphilip14@gmail.com>
References: <20260817160319.28251-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Aug 2026 21:33:19 +0530, Jeffin Philip wrote:
>Kconfig currently sets the limit from 2 to 256 with default as 2. However,
>we use that only at build time. So, if we enter during runtime via configfs,
>we set page content to 0\0 and get the null pointer dereference. So we will
>need to add the check for num < 2 in fsg_opts_num_buffers_store() and return
>EINVAL? Upper bound is 256 which is below what kstrtou8() can return anyway.

Correction on the last sentence: Upper bound is 256 which is _above_ what 
kstrtou8() can return anyway.
