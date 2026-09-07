Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B14078E3
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764761; cv=none; b=QmSR5oH51gI1OItfwGr9nlP9XB56Et6e2lhTeI2M+z51MrHhzuPMBZNRJkdBz7S5EUsYkqNQql24dbQ6rFJX21zZxHbHZGg7LMMDL9H+a4IN76Y7a+bTO8dbw5/LfJ5U6jf3zylGTGONDdKqjP+Skt6UvVmwToydXzZFzR2fEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764761; c=relaxed/simple;
	bh=CmBZsYFgrPsEOcd0hIuvuutmtT9Mq0n4oHdhqCx6j0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEKewyeEZUz33NzmePdeHxCs+T1osLeOKvK0pKTlqZyW82rcP46vpMvCaHyvMQEyvXKT3FCgBV9Bq4diW413abznNiq0IHg3P/7whTO8SboPdKMIYCbs6xAV46FCP/Me+WdDUkx5uOyqdyfi/uM/+aJ1NryZn4GFpTCdjqRX5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR95CXgI; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR95CXgI"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so2063975a12.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 00:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788764759; x=1789369559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CmBZsYFgrPsEOcd0hIuvuutmtT9Mq0n4oHdhqCx6j0Q=;
        b=KR95CXgIQ4gPfpq7z3hbleFQsM0ARAl53Td4VVU35v42uR7SsWmDA0rTsyDPhEF6Wf
         dO7PPosgEdcffwlR/Po2Y/ix2/EtDpzXVKK+JccoUT3J0zaWalknXlmWN4Vf3/9VRrcc
         7Qp7VhcP/Yl9a9uD7PBY13TD/Oti+EirAoDUQVlZqaiDTjAjmcuhwOTkpRmnbWORLmiE
         V2tSbeWJ46XFAGbisvcKCAOJ8zqPmlkm1tcFQa2zeqs/v3Lz7r/ghjZ8baCmoaU9+2Ds
         CBXKYaJlFfgtMCGDNDAvAyMQNUJRqAPu79Y+He7noZm14oVDXhretqGtJUqoSP6DE/3L
         JYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788764759; x=1789369559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CmBZsYFgrPsEOcd0hIuvuutmtT9Mq0n4oHdhqCx6j0Q=;
        b=TDeGCCxUqoyk0AMNNAJJaVA243mc9dgYzvhL1eSaVYmuowDl5rjlOXmLXosRVRmFE0
         AfssTRXnNwzZWPZRaIZtC+LNAgqLVCGNAo4c+szWUw/4cr2ZWWKhtAahXSSKnHcg2hoo
         HBYwuT5/DRPdjX2x8vs5eFj5YlXa1glN4WfGi5l74s+XGoBt1k91WpBfnhpUmdFsuing
         8k/GfohL4KFkvUdPTezDntJ5FfgfEgaRalRnrktJqZwFSxOH0bqt3Odq57BBvWCIvHUz
         r+8PFWoY8mrkfP7KnhHcgqzTWq5cnvnNyFNSB+IosDnjvQvCtOlP5fuaQ+k59umYWE0t
         6Zmw==
X-Forwarded-Encrypted: i=1; AKwUvBx0EsSse6dJtwBZlHsxQD4WdWic7n0sGu2oQ8l+dr3Ppy7kafSd7JmIgo6uNP0OVRPZiQlU+pk=@vger.kernel.org
X-Gm-Message-State: AFuF++m5Yo/dK71v6gwQrbG2e59AM5dce0a7ntYN2Z4Uy75FRuazuZNw
	Rf/GiK/a9ao6ECbaXH9NTAQntGLLYYgtIqw3QUR+BxbVJ/27At/0DsiKGVUunIjc
X-Gm-Gg: AYBFou21E6J39SmI/CFJXYHpA5WCU+i5V7Grf+cXkZvdTLYdlICE0JPaCXfK8CvZgXH
	p0aPgK0Ssu3yFmI0Zkfq/ZqPb9P0Fm8CAHZj/kBetyCjOon0GOGaiTeQDsztBW2GEVm2FWyvRLP
	mPopxIfLylSHHZXkzSxx7K0zvZxo39SkwZlb+uaC/FcVvlj0FLhLYx5L9Ech3fEdcWEnLPYeDDV
	9F+3ZFRDfOHSTvWF8N5Vc8+JtYro3tQ1gZZtUQ5dfA0H4jwyH2/KJeL8rhy+vfKAO8QnPByzBbg
	WzbM5t/pdSRizBPAcdIwX1m/kdjmSeBm2C3AUZ3C3PXfQ51v7I6Nu39jIf66r5GNjso2du7/JF3
	8Pobe81NvUucjM1Vpj3SPZ3owafhsySwuVFHa/poX0hiOeFyrD08QCBNMPKMNbohrpK1yyi/PNG
	UiKd4Pgnxw+/D0IKwaDnWB4PFO1cpsitWZHmeBoARBa+CfHS1cGqAbg3xjYueCUwrIM+y4d80Ws
	n7Pv/pP5A2OItpw2VB6a3jErZ92YdAG0YLwH4iQqEmZOIm1VcwRzwpIA0PwEEHDY58KIwT9
X-Received: by 2002:a17:90b:1b05:b0:398:9bd1:3210 with SMTP id 98e67ed59e1d1-39b262a89d4mr29356397a91.17.1788764758817;
        Mon, 07 Sep 2026 00:05:58 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b4b72f62esm12128847a91.5.2026.09.07.00.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:05:57 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: ribalda@chromium.org
Cc: 98lawweijie@gmail.com,
	guennadi.liakhovetski@linux.intel.com,
	hansg@kernel.org,
	laurent.pinchart@ideasonboard.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] media: uvcvideo: Fix out-of-bounds read in uvc_ctrl_status_event()
Date: Mon,  7 Sep 2026 15:05:48 +0800
Message-ID: <20260907070548.2528198-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANiDSCvMZzb3ObT3401_iYeE3g+n6kYxTpZVJoDrx4N2_=jrHg@mail.gmail.com>
References: <CANiDSCvMZzb3ObT3401_iYeE3g+n6kYxTpZVJoDrx4N2_=jrHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 7 Sep 2026 08:51:45 Ricardo Ribalda <ribalda@chromium.org> wrote:

>
> Hi Wei
>
>
> I belive this is already handled here:
>
> https://lore.kernel.org/linux-media/20260813-uvc-status-11-v1-1-2cf43e9590b0@chromium.org/

You are right. I missed it out and the patches are logically the same.
Please ignore my patch request for this.

Regards,
Wei Jie
