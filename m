Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792970594;
	b=i0aBHiXW8MQQgJtEPyft9gB+UA3BiUj01uKmmIVy4L9CYmL9fCVi7jr4D8nEi1vxSiRD
	 kAtdpe+/Hkqpz1nI6X0z4GqZjDwUZ49QC0RAwbZGYieJnWA8RKTSp0JC40xvW6nHryOp9
	 4NC+252JdxYTyRq96biw8oUfXZzRUqJ4eWrPZ0kGasju2OhzHtbNxH6arvI8c2f8OEoUy
	 DVpCgKJyfRdr54z1LAUZ/i4KqRg2SpDmLGFMUCtVtC0bId8AU341qrwadfQYZwIf6ofK6
	 RSvoSdIk90oRs4rpw87y8TUZB5Flz+wbF+YE182ai4FExX51fudefIB7TUTcmlJFJbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792970594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rbxeXuBz0HfqP0KO9f4xM0kuKsTU2zW3nybw3gTAZ8k=;
	b=dwMTM2dBzrab23+Ka8Xii5cOJdtrUEwZlop67c4Wa6ae1oYRo72KJxruTvkrf3CsDEyg
	 KkvPTW8MF+kHgNECbdLogGhivTUWMrtv1BcTJO7iC09SkV8ayVP8ipiBD9txMo2oIsBOY
	 7ku5+UQWF4qC2OfwDSPoibnf5PXf1RBB44eGOhnJtmV7/tfC3d2a+Rc59SZT8R9wgSHE8
	 OiGAT4AvgELrvUWAFDgEJLO6UWgBT/i48u2lrS1cpxYPsWe1ylicLF6SKEf6jRIY2rqzw
	 Ele1YWlzTDvdRJ2cZ5NjZrbSKEmdYOn921DlgJZ5c1LidwOwSwbzglvkZZ/zsQG76/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wis4iWFU;
	arc=none smtp.remote-ip=74.125.82.195
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CDB606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 23:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31CDB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wis4iWFU
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-35829219da8so4374214eec.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792970593; x=1793575393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rbxeXuBz0HfqP0KO9f4xM0kuKsTU2zW3nybw3gTAZ8k=;
        b=Wis4iWFUKqony/2nLAbnNxcXFaNVTFQODKiBbbtoENDWsu32+aupxpQjJD9UUG+NuR
         Oghoo9542qR6F65e17KWCS2HHrQSzM4OXo7iQBna3zw90l0IxaZXHG8W5H/3kBaOzo6O
         DUhGgX+di58mLwtx/Gzk71vykUIRgLzuOft1b+MqLFfDJV5GZ/9xflpbFaa1n37kh+q+
         fl8gdjfea50eIgCwd288k80V7W4qLnrzXUjYtDikkS3vgzwoqnmB+/msDR0jVXxVc4Kc
         5fhzOFxvwlHZR9aYDYYUibvLs/XoP9f+BxRfr896ek65JJiIi1fHrHd9UxclX6ZoSCH7
         FqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792970593; x=1793575393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbxeXuBz0HfqP0KO9f4xM0kuKsTU2zW3nybw3gTAZ8k=;
        b=IEyQMttLwOPzohaGr2dZtilmN0QoK8TtmZHChyZl/6Mo0PWDoUhfQ0v2sTBVpQjdGf
         uO7a06CmswltrSZaWatZU9mA4JPxDCn53bF1loXqZcGqBx/J4ZE8zmdHdK+GHnUexysv
         v8Mb8HGLszY5ChMy2m0g/jTvogSS8WGQEKt0KJF0Bjm/lxuLCQPavr7+iApPiuQ/lbg9
         M91cfNQUBkhxbYPMAGVgs7GbPxvo3HNnxlS0QFlrk0avZ4glfoIxEIrktJ1bIvg+maU/
         jhhE88hf+ENzDk0zPC14jbAfOi5Nh+4TDJ8q2X9uuNAg65nzKCDbRvCJbA0mKtp0DzMX
         xvYw==
X-Forwarded-Encrypted: i=1; AKwUvBzsVjBygYj1w/1b9dmrmrahw1Jm6f6+v5akhwMs7hTSCdsmqDjcdTUzKKVmDRjpm2yrwOC3LFs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZlAXJZr1EQC1BlGzzYOt7GyU5v7KREFpwDdLBLqZxj5YZ7cqm
	/OTmrE2eK4EAr6HEEklw3uYmTB2OqzlNx3JdzuPueDoSVUAhAEKOs8ry
X-Gm-Gg: AYBFou0RldG8lGOWRTXVREYwDsZLDhBwMP08X/C7SX8E1YjgmlJlqXHFC9g+yLFd99V
	x4uUSydjVPdVCoeIkzBG55/Z3CnxkEIrBoHw9afroGcSMLUpQM7D3RsiL4dNGo8VODJ5O0+ZF+9
	JHLtICaTxFoge22uhMu5MKtR6ozIoUE8eQow3kncZtkoF1IuKiUA8iTut4/KeTl1++MAb1KzMpv
	UaTCMBJ7Jh1UA5P1YQls11ZTACF4dODozlkK4m948dwR5PgfiIpawouV4Nk0p6XWGG+lu/oq6E8
	LfLOHbJ13VabUSx/OQYXUFS53L0N+idjB/Rya/H15TUOs5CnOBEJQLPcpdpJytfx8LxdhsyyT03
	S1a6YheOlttuxl1gGhOpyP4uUudc2hRXtSTOekYVZFADBOTWXl63vglyF0d9I6S0wIJjSVrLyKn
	JC/fRgBR1L4I381tkXHXHWD250RQLYrosXX2oEyXGSbdq3SRVyq5kHLSDQJsO1u2/tPaiWb9sN7
	giVnF4fVGIYZw+LDDt7uaxpVyy+kp8kSRCHe4jzITCJGoo8wC3xFvUhe8Zr063sEm2c1gpSoT5z
	8Q9B8oM=
X-Received: by 2002:a05:701a:c919:b0:187:5a5f:3b27 with SMTP id a92af1059eb24-19935be804amr6867724c88.17.1792970593173;
        Sun, 25 Oct 2026 16:23:13 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2eefbsm20118741c88.7.2026.10.25.16.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 16:23:12 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] inotify: do not coalesce events with different rename cookies
Date: Sun, 25 Oct 2026 23:22:51 +0000
Message-ID: <20261025232251.58252-1-dennylin0707@gmail.com>
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

inotify compares the mask, watch descriptor and name when coalescing
adjacent unread events, but ignores their rename cookies. Distinct
renames can therefore lose an event even with IN_ALL_EVENTS.

For example, prepare two files in an unwatched staging directory and
rename each onto the same pathname in a watched destination directory
before reading the events. Only the first IN_MOVED_TO event is retained,
although the two renames have different cookies. Similarly, coalescing
distinct IN_MOVED_FROM events can discard the cookie needed to match a
subsequent IN_MOVED_TO event.

The original inotify implementation compared cookies before coalescing.
The fsnotify conversion lost this comparison. Compare sync_cookie as well
to preserve distinct rename events, while retaining coalescing for
ordinary events with zero cookies.

Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/notify/inotify/inotify_fsnotify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 7c326ec2e8a8..6456d9c0e408 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -40,6 +40,7 @@ static bool event_compare(struct fsnotify_event *old_fsn,
 		return false;
 	if ((old->mask == new->mask) &&
 	    (old->wd == new->wd) &&
+	    (old->sync_cookie == new->sync_cookie) &&
 	    (old->name_len == new->name_len) &&
 	    (!old->name_len || !strcmp(old->name, new->name)))
 		return true;
-- 
2.43.0

