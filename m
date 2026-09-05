Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2CB34DCE0
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788594416; cv=none; b=UWdEeKVmkEx0h6NO1G2PSfZzD1rmt2JSVeUc/0/f6/O5T6fJGuTPfmm/b+gEEA3kW0mQY9Qw7FsULiJPeXkT8pvxGxOv9mv38edzACl9zFic+xPhmQatjrqlzerPXFyCdzyidHxTJBzKaTl+nREh+RESLoczcNbZxA6jp7oQ4eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788594416; c=relaxed/simple;
	bh=xff8GUk+CZ0GDybRtzZe3eSDdPuy4kMPI4af0+AeHfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLkcLV6NEPlUIdu366rO4v24ZMFizegp3JX6VDu5VxxWyWKzy5j1ubfj4v/4Zjmb4Q9wMd5+Afr4exELe2FPQz2iv0tBBVeW682uTRZB6BB317+swc4+MJpoxxm6Pey4VM8mgZkFJi2DpPWuBfnR/Ocnp44qjceDVOo810tqwoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmImc+Xc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmImc+Xc"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4859245e493so191986f8f.1
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 00:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788594414; x=1789199214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xff8GUk+CZ0GDybRtzZe3eSDdPuy4kMPI4af0+AeHfQ=;
        b=GmImc+XcF7BGv6Pcjjyl9VJUW7eWCbNNY+sd9+aOCT/4bLdCoK80DhAWdG4H+h9EQS
         u+xpT6XUeudBYmHrti/lOWfTT77itipkUTYPZXUuPIuh9T3IukOmodRYljb+y9LI/VC9
         xYhlw7A3J+MsuBwWSlr/NI2acrCjGQVw2eiHruIxem91JKkriNe7PRoJOvQyPRVDsYDH
         8msaldOmvLMqqFVVtUSm5CGTYbnJSthgAn/Cvki2d3Fx6bxGNz7Y8GQJTEey/fTVMqR0
         WEOvzdhJwoE8BEnZgmp72pbjsbNMffl7f+8O87HYEkuPxBuRmb27CHUb7vajtzyznJ2o
         qNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788594414; x=1789199214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xff8GUk+CZ0GDybRtzZe3eSDdPuy4kMPI4af0+AeHfQ=;
        b=X7QxIyeb4WKKGWWV9PxFWQKp1bmm8Ms8fguNYyY8ku41SpBGr7AYWpSUhGjLIcC/BD
         kqa5YXQnTYNGx9MoIC+ORSrbI1xFJubsDVKyMNutXjurePV9CgI0odZrZt+sXI5DM74V
         dPz9zcLZg79LKtiIOJduJ52FV7Kw4bz3YmeebtiMbbUPRKg5sJQoEA3FJMnfairTuGpQ
         /LB06882yOGIrtv7Qr5P7axyk3caTItztOQtRCY/5qu8zZAHS4z1D26N7UV4cGrJKNAG
         fRgLVvpBp3wCxLpkVhNUjeSVo13rzHm3g/3R7A8zFn8kWoR1fCXw3KHqTz2EeC0UUZqS
         ++BQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWioJZ2pn3bszUyeWZh2RCaMnnzXK1RUL2WRaBK1ID2ksUCv4NxspNMEk2BXiO+JFNe58r9pE=@vger.kernel.org
X-Gm-Message-State: AFuF++kiPkg75H/a0crSzCximHrVVlEW+GEvjuF3WNH/zheaqgwyyUwk
	QEm6lMasHT04vg2iTEosRWx4FAUCAhnOraCfE1p3x2EhDTM5L1ARhTA=
X-Gm-Gg: AYBFou3weTaWWXdiNbTi/0+6HT7DPcyAeuUl0ZdnEaGN1r3+o98q4ZsIOQ3M38akfau
	0c7qg3JLlTJuIVIR0/5bM2D5gNnky+StK/iA1E6Ziaa7i3PuQKUvly+gMV5Wlgv+24Ou7Eyw4Di
	3ejZi+11wfLaJw/FyNyPC4Q0bLbk7IEpdDR90aCKSjMlwU3au9HPIwY1S/JAxcjJSEu5/4hlqVj
	nTBTZ5FNOVA9sfW2dHS7kg/xtzo95UTZfCtw0bmWNiY9vzrqmf3a9JKekj9FnGudb9K4Mgt5m66
	ro/B2cYTkkePjXZd5MTu0ykhgTKwJJYB7a+IyguU0ss57JYukH3/6Lzl7g3CrBq5CVJ8gKeO+kt
	t5BrFQ5bR0vjyipCR304HLlAtLMe8TKdfhYsjFaJ4lF60qRPeoVGj5IQ0mHbuz8FGBxsLRwuynI
	xiMqeaT6CSqLzWEERKmTPtmmbTAJZtRkRRaDHRUgB46xBy2l1IKLuyoI0Or1zQhoSkepA2vl0xO
	ZU3UAoKiTgA3HcPtaWdr4ew3OvJ30PWGYIKLQxPFEpzsLvAuYQfI+8OoMWe8eZZdy2cpqavL/0M
	paBw
X-Received: by 2002:a05:6000:491d:b0:484:3785:210e with SMTP id ffacd0b85a97d-485872d4f0fmr12136802f8f.25.1788594413532;
        Sat, 05 Sep 2026 00:46:53 -0700 (PDT)
Received: from nn ([2001:1ab8:1003:0:5454:f357:ba89:4e22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858bcefd59sm8629206f8f.19.2026.09.05.00.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 00:46:53 -0700 (PDT)
Sender: N B <gen.benner@gmail.com>
From: =?UTF-8?q?Nerijus=20Bend=C5=BEi=C5=ABnas?= <nerijus.bendziunas@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-wireless@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath9k_htc: fix the byte count of a full RMW buffer flush
Date: Sat,  5 Sep 2026 10:46:49 +0300
Message-ID: <20260905074649.341820-1-nerijus.bendziunas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904180849.775404-1-nerijus.bendziunas@gmail.com>
References: <20260904180849.775404-1-nerijus.bendziunas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please do not apply this patch, and do not send it to stable.

The message is wrong: ar9271_hw_pa_cal() does fill the buffer, with
exactly 15 entries, on every AR9271 reset.

With the size fixed the command is 8 (HTC) + 4 (WMI) + 180 = 192
bytes, three full 64-byte USB packets. The firmware ends a command
only on a short packet, so this one never ends. The next command is
glued to it and the device is dead until power-cycled. An AR9271 hangs
this way on the first interface open.

A v3 follows in a new thread: the size fix plus a cap of 14 entries,
so the buffer can never produce a 192-byte command.

Nerijus
