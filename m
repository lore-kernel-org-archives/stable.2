Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B843B6DE
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768754; cv=none; b=r6a0Rr8i1/aiscjQNxEWFa5DzdxLuFPQszaBv2crPLnhS/VFVZl+ebSi0BpQwWlKHv7g7lub63doHD+xoRSOeriCGCPEmUetLDs3acPIFrOZclhu0D6wcdmOZvQV1KTmw41leurYSa0KjLF3bZnKCConG62Z/McS8F5ev+v/md0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768754; c=relaxed/simple;
	bh=3DpXbIfal60znQihoTzW2Tp3q9D9M0PZ3qy0geTQM0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltdsM/uxuaBr3J/4vKso97jAZ6GRJii4XflOpWkdsb2x0ahwyGViEyfAptzEnSeOjlU+emDdL1cJmaA8SX1ImnSA2s+GdkCQuL/WMOASFEdK7IQm3MpS1pwW4q+SJuiC7Nr72sZTd3f0tRRPDHeqh0QrMETchk1GdeKGHnZU0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnQZUClD; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnQZUClD"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso2322374a12.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788768751; x=1789373551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=971x3L1jLFO50aCCes3jvxmvwdkEiKwHi793ZZpvAwA=;
        b=DnQZUClDG+STAKi2HTSLrDEXSMtoZjFRetEAcCyXgKgIgAJQP0J/xE0re155nXd9XV
         7CFpmyqtOBHHtSIB+zCTPxzrgqPLQV+4ziGrlje+73VfQarvb1m2KJMeaeEx4+KSrJJs
         o0yhQOR0tiW8gVef+uCwa0VrdzZHAnzQgChMbF9cAc/sDQlKpg0K4e/qZrpqFn8hG/5A
         2rf6RI0szykyjTw0iWW1S6WOvKbszG1OmXQERezXuf5dFlFt/SHv/pZLvOyp7jdOpPuh
         BraBWPqceHYoOqQDhuZZ3p1J6a2e/HAjCFhOW+zR679uVZxBTxNq24d/1357kOUBua83
         a53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788768751; x=1789373551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=971x3L1jLFO50aCCes3jvxmvwdkEiKwHi793ZZpvAwA=;
        b=WnhV6xtV94o5YnN/vYYahFGqZj9YafOedBz0dQz1wB9Brati5ZoVCGcFkVX4ohE6v2
         Fuku36TKX9LxNIgWlipK6z0Psncvd24G7bYJbDB7Krly1nv+BMwWlrrUYioTQ45qS200
         Im+fEMBXlFp7xybq54F08WPLFyXScc5BTgOFEvqFtSPxOsnRcvhnf1faNhtWR64G1Zg4
         l52dxFww6cRpWWx+tb+rpYzBtsYighlmL08WKrw5JT4tnDF4DxgMMGm89H7icH13cZw4
         /ZYjkQ2viESWD4rxwtmBUjg/Kd23cvxOgC65iGhx0pRmeqhGpKwgAMdQkoOy0wwfKumN
         19Cw==
X-Forwarded-Encrypted: i=1; AKwUvBwLF3lYfbYqrzY1IB71NeOcOJENRGOvFBEi0Bjtsd81z4njzri/G/gADiEKcrfjknrsZ2t9qu0=@vger.kernel.org
X-Gm-Message-State: AFuF++kfT5HI7sSKfHPUcoS57S5pfShWJEvDkLYszO1VyIUwH6KxDnet
	ugY58u8Qv66Hz2Bs3K38oJ9MzhMGQ89MV9rq8brt7eBNuKSu9YSjygPd
X-Gm-Gg: AYBFou2xyCrRdd78jg5SZDCVcf7rTUXjpiRX6InB8/GomvKSRfgYnyI4qYS2GVjHbZg
	ax5WlWJpaWt64X1IH+XYL1OIYTpUaUyMrsSyVJcj/aUGqAmIavGNN5MMPtbwwy1FvBetelvR0C2
	np2axEHoIco90tEPe8nSwCQ4xIlNreCYdOBFSaVU44/g4u4iidgYArKVu6sG+t7HAVG9VWGnjcy
	ljYR6tJqVkddB9CP3PXW4aPaHiH6SumM7PC1T5eGCdTnleJoIp7XTdQL7A5QylWYX9eWzNfBAiz
	xDL81++NXWHmGjPVJTFYWrMnLiwUTEKDGG045JkYADm9QTH7XgS1WmrPRFMjE1WACMARYdbV2Wa
	RKFO4H02+UOT1lXK5/zQ7GfCX0ZCtzD9YvA6rSM4R0Ns1B/NDAa06z1J6PF+SINbKDG1zBEWkFO
	AOpPC7X1wn7DN4FJ3YTxxouzTdFqcx87/ed0jcgNc3Klp9FMclwksIRIz3q6bZh7mQ/FQvH6ddo
	bFRIfFeMuKq1rP5EAJJ51h4hjyc7QrFDVxs5PaL8LcRZuzOz+dOlayHQWrgkILwLMLgfIfowb0/
	ygJcaEE=
X-Received: by 2002:a05:6a20:e607:b0:3d3:adbf:777f with SMTP id adf61e73a8af0-3da3a16a54cmr35721717637.20.1788768750876;
        Mon, 07 Sep 2026 01:12:30 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc45a6abb12sm3535544a12.16.2026.09.07.01.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:12:30 -0700 (PDT)
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
Subject: Re: [PATCH 1/2] media: uvcvideo: Fix NULL deref on events for uninitialized controls
Date: Mon,  7 Sep 2026 16:12:22 +0800
Message-ID: <20260907081222.2541314-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANiDSCtypCfEoZbRvdT7EoJdd2G8yOVcvxBoS5LcE60UjFQx2g@mail.gmail.com>
References: <CANiDSCtypCfEoZbRvdT7EoJdd2G8yOVcvxBoS5LcE60UjFQx2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 7 Sept 2026 at 09:00:35, Ricardo Ribalda <ribalda@chromium.org> wrote:
> 
> Could you provide more info on how you reproduced the error?

The device I used is a Facedancer UVC gadget in a QEMU VM running
v6.12.105 + KASAN. It has:

  - a Video Control interface with an Extension Unit: id 3, one control
    declared in bmControls, GUID not matching any known mapping,
  - a status interrupt IN endpoint.

The crash is fully device-driven; from the host side the only
thing needed is a process that keeps the video device open -- any
camera application will do (no ioctl, and no privileges beyond normal
camera access: the opener can be any active desktop user).

Userspace never sends UVCIOC_CTRL_MAP / UVCIOC_CTRL_QUERY for that GUID,
so the XU control stays exactly as uvc_ctrl_init_chain() kzalloc'ed it
(XUs are initialized lazily by uvc_ctrl_init_ctrl(), which skips them).
Something then opens /dev/videoN, which arms the status URB, and the
device sends this 16-byte control change event:

  bStatusType  = 1 (control)
  bOriginator  = 3 (the XU)
  bEvent       = 0
  bSelector    = 0
  bAttribute   = 0 (VALUE_CHANGE)
  bValue[11]

The worker dies before it can resubmit the status URB, so one open()
gives one oops and the endpoint goes quiet; closing and reopening the
node repeats it. The oops does not depend on KASAN -- it is a plain NULL
walk on any kernel.

> nit: I would not add the comment.

Sure! Will remove the comments in a V2 patch, which I will submit later
along with the [2/2] patch request since it's a duplicate of yours.

Regards,
Wei Jie
