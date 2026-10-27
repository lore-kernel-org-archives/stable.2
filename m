Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128841;
	b=o+An6amN98hGnixy5EcHHnHPAI28/IY06D9lkUIKJ8C7l6Q8BEZ89GW0TjSQIa1ugZjo
	 jwFlfbmQMld8cJ4UA30WimTdUcrp1BJWI0LVewJGRBOXwH07ynVb71iw1YwIIrhbgbW+q
	 lLz7IWL4JjPzai7cwiujpTMjJTOLNt5gw3VXgabIi+sqKlSh8lNyPM+DM0sq/gfcSuAGd
	 K+c1WWyS6NaF7pnjdDVikCf/yxCMh+7d51dd1RjwXGLBgwhvHOD0+2o8i7sMlbm3cHdFs
	 762I9nszKWL4vYJkXS0U1Q0Duuy+wGtknF9SDXD3NF6agW9bhi2wAssMV2ltF6PrwHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hk9/0T79qmJBx1+aBaKaGLqZJw/M/AXieWp8XrsTCTg=;
	b=FoyybgIf4N9xHpga8Bx1/GAN0VEZSZnDr+/6o348veMChDgkZxUrJhbCpr2pzq5V3+12
	 jtZnTHfPvLFrZMQY1OYflOAJmE82rAjcUfCoyaUtycjyPVrAcVqRNepOcnfrlQAeqYyUw
	 AcU/yT3NziWAyUKxiOQrrH8o/mOPJTxDynGWaSBwEN9XS1XOKt5wWxwzLfTeotID/ElBd
	 lmlPn2Sx/CpnOdnvlne7oPtVnJyFsvzdW2Si94JzLGAIUApZhgld2GzcKtthk4CmUeA6g
	 u/hDzEILzJJUqOZPZgyPdcJ35NsJx6UKFJf7FVKRsIzHyK9a4yScTvxOTUtGb1b7Hzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QQkLR1g/";
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B43606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 19:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6B43606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QQkLR1g/
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-368c26de2e0so35343eec.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793128840; x=1793733640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hk9/0T79qmJBx1+aBaKaGLqZJw/M/AXieWp8XrsTCTg=;
        b=QQkLR1g/+aSDG22UmIZXQnpCRa4u2Totc+OsjxD24KKdE44CNN5+V/iXKGbMy34KE0
         9J/mdrs7iGN6Cblm4VspbDP498gyj0tj6d9hyieE0H8p4MbZE+EHmO6GiTSdTWP9Ujw6
         xw96k0X6QJCDIXUvebMzlWbB7Jb91SoAcZd73u4N89bUACIqoSnmxiihSVjpw2GbKCln
         noZFuc7jG6N7ev7Ayl68F9AuR36yDmAYpDcqJ1RZf3/VNORZWW/bKDsqLmgjqtIcCBZn
         Wwt9m6d/4ACkqxnabKNpCc1rZC4TIZ5SxWFLlim33XkZBEGr2fnPTVUEVuUKDAFmP58j
         oyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793128840; x=1793733640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hk9/0T79qmJBx1+aBaKaGLqZJw/M/AXieWp8XrsTCTg=;
        b=aSoGgO+tZFYSSaOXq1uvtlCMSCY8reXyK9kI+hbnQAxIaHsk6C6igifm79Vtk/w0KE
         /+MfjJybSiIrtf7Vxk7FZ0rJg+JMeJtOfz0UgSpydJfGXh1HzBqP+EWzl3Pg8oxtEon+
         UV1Z7hNiXRxos6oTVwPb6+4DIqFJBRJOHnMw+ZBSros8wbbnMUbXxlfPsKc6ustcWxJV
         O0y1YTG3lDIYF/ZzxIVn37zsc3pevvI9wiXEr+SNhLWm+b6VcUBWuLFZrr5QVwqVie5F
         OAIYwHsGdsqny+YhW+5bjspsEVXBL6glz/u/xpW1UWkVVuay+ON4EL1fNypaUOdCxrxO
         w0nQ==
X-Forwarded-Encrypted: i=1; AKwUvBwP8+29kFlIqJ6dfj33xRlepQuuDx2XK7eWbbvp5ZecmGEk4XtPcgJsgd6A19+KJqWMnOg6fJM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLC7AaKP9FfT/zX4LEPmiN2j8iN+z7VjciIeNfjo+LQVaS+oXM
	/De1Ji/HG86klDtxLNyXxIgM+uCHj/JSs1+2RnuXb3h5AKvrTaRH8Igs
X-Gm-Gg: AYBFou1Nsfo5c5XASU5ikaWB8AnSXc6hHfGdEtSUn4Dyq6tvW73Fv1Bp2RPkBmWpv96
	16bedAtSvtfiH8d0AWiN1tQ8d0NxNw4P89uLlR5e2WJ9AiZxtE7T24kqwNb4gelKdnuF43Ftqyy
	YurtqrR+LsZTxgDkCEsiegNL/7W9aF99pJ/JY3ZCJR+xZ8Zxl46+LWRgwD/cCWAxOyNMfwej2wu
	3/7ErP67dKh+rgNj6N9B1z4fcs23PJi7oy40YuO2R+ffVC2J+pwvrvKwbpJHSq/tVN2Nq1F7GDM
	/fGjXajqH15wu0tam3XD0uvFmsMBAm3aFZoctlBlmMma/lD6APhAlatHYB/cFbqz8z8CO3c8D4N
	OdOBfMHJL2jDQ64ldsEn1YaowSpL9wYa2PEQQ8Nod5eeF00eXa8G6rDOO5ACwbtht2E1ChDvmbY
	hnZUOui5AANmKY3pkvmVs7EQ5qgXhY42rtmsb4lmqKoytbAckP7IkZOQLtzWfUOTH5vRc8IZiKk
	D5oGEfTxgvXJIsFqYoAeXbXRU0xgzxHYzegLpbyNkbUtZFAInYCn3j+rH0uBen3h4iUvBTAJLZ+
	pf9jCNg=
X-Received: by 2002:a05:7301:2411:b0:369:fdae:c9fd with SMTP id 5a478bee46e88-36a201132b1mr506995eec.13.1793128839731;
        Tue, 27 Oct 2026 12:20:39 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7e73sm35948746eec.20.2026.10.27.12.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:20:39 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v2] inotify: do not coalesce rename events
Date: Tue, 27 Oct 2026 19:20:27 +0000
Message-ID: <20261027192027.8617-1-dennylin0707@gmail.com>
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
IN_MOVED_FROM events can therefore be coalesced, losing the cookie needed
to match a later IN_MOVED_TO event.

For example, watch two directories with IN_MOVE. Move an entry from the
first directory into an unwatched directory, recreate it under the same
name, then move it from the first directory into the second watched
directory before reading the events. The second IN_MOVED_FROM is merged
with the first, while the IN_MOVED_TO retains the second rename's cookie.
Userspace can no longer pair the second rename's events.

The original inotify implementation compared cookies before coalescing.
The fsnotify conversion lost this comparison. Do not coalesce
IN_MOVED_FROM or IN_MOVED_TO events, which carry the identity of their
respective renames. Leave coalescing of other event types unchanged.

Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
Cc: stable@vger.kernel.org
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/notify/inotify/inotify_fsnotify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 7c326ec2e8a8..6e3af6452dcc 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -36,7 +36,7 @@ static bool event_compare(struct fsnotify_event *old_fsn,
 
 	old = INOTIFY_E(old_fsn);
 	new = INOTIFY_E(new_fsn);
-	if (old->mask & FS_IN_IGNORED)
+	if (old->mask & (FS_IN_IGNORED | FS_MOVE))
 		return false;
 	if ((old->mask == new->mask) &&
 	    (old->wd == new->wd) &&
-- 
2.43.0

