Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009078;
	b=sfVC1VyD6CockCy4wLPx2xmrN+IgqjJIu2QqMp60vXoyQoNqxmGZhfMd42iyb9kdlLaV
	 bLFy0FzvocGoBDjGKu++4UHwmR7HROTxionZKvItWbDa9nnT0Bxrt0xUhLKsWQBTh02tN
	 B389zL+jT9DcLwAmXgHr+IFI8YRGA2tXlA2PF2dHCAyDYfQJDo/Zx4aXefTZH/kD2jLBq
	 7dCibxJ8ce6vgcECRJU4o1ryCRB8xu0NA9u5QSsueHmyEoGz3lcy8lvFCfHPSa8MSmkSX
	 M6l3wSJmYqtrhJCf2ZfDrNZqyUdLDAfVhsaMIuP/9A4XGoAOxIKc1okCW0k6iqUqXvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rDp7+2O7MU6X785H/wA9kb/1vBQL6oD+1K7g8ImgNt4=;
	b=ANMm+awvoKUQGX1R90fQFNIeCnKwJVHxNB7F3w5XTlH7she6Eav0l9V4u+PSHLgxdKem
	 3jaiV8itC7oYgHlwr47Q+bXPO36dR+Z5ZC2+uIhNyQgEFhlGO1WGY1evuouU6mzG7zY4f
	 4ntTuKW6VZz2wQHaBNR+abTQkVW7MobfWWeGg+6LDM+8zyV+qYCTJzK1YUN78k24dEe0C
	 HltuI20qhYRmhRpjyacLAPZ7q+nzM0RL2JZ9nxX5iG0bh5f/WrXN836iab5TslTZlk0mB
	 VlH0MfFe3rldV//o85V0q7Zdxnf2v5WJByjwK1y+AMxeTyy/opSxaz4whxgxzcKvBAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="UI/H7fym";
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB43606A327
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCB43606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UI/H7fym
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab41538192so2033691a91.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793009077; x=1793613877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rDp7+2O7MU6X785H/wA9kb/1vBQL6oD+1K7g8ImgNt4=;
        b=UI/H7fymCCV5R8hXtpI07lGH3/oPJ2lwNaDRFtBfJ2Z98WNqgB7BIhhNR5neQc+sBC
         3iXk3PsFzag2MjYDv0EDhjpGZzt3CyIa1WiUO+EpXrjVAgEltLNFy5lE71bluKr8Hbq+
         4xbrzmUYbRrihK6YHm6FZUTZLrCDfh49FpFjYlpA42yU8QmoUrHEDCfMu2qwaPuJ66sv
         qXKUcSu4j9N7ZTUZK7xMA7IPIesrntAfupirllGS5Krn3vDBELoAzBValbjdnSBotsYF
         Dl7WY9NeVBWjP0eP7ROQJYqD4jfFXAEyey686yMiA/LXm4elu3hwqyuz7+U8v6L8ESMJ
         +cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009077; x=1793613877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rDp7+2O7MU6X785H/wA9kb/1vBQL6oD+1K7g8ImgNt4=;
        b=qNnbk2wQpt4BF+gcP0LhnHsiCZGFP73t8cMsZw7yZjPVcf6nYer6r7b8qiF+jNwrZa
         GkVrnLgijz1llUY9A7qkdo6jXepSi6prTFHU7u9FjsdhhAA1QJ1klarEPibEenxa8Gpv
         fxV2E7O7XEu9BYkUo7DbIGIea3VearHpj7XbEtu3BB+CR+IXpG+NsX5WdITQ2u0ZV/Q3
         HNMtWfyRTyfYYEwIuDR6wLbW3y9MngytcnLdld93NsXFmXnlOEZ9FV6i+Y4vTC4jIdQp
         LrCqmeSkTbbABwUHbwr+tRwdKQ1/Olj9VW8rYdMZw9KllXVCkGBw9JzWqpFY8bsnVoBV
         yBGw==
X-Forwarded-Encrypted: i=1; AKwUvBwBNzRWClIu6GJXbaNfCnWEtNmoAy6TlrCgszneByTfhEjmRxR85D1B9PhomS9TWOCZBYuTcoM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAvJ/mRMWiTwCRfAH6ZPDegdMTaKKsUdH/G8okPg/GlVfu/abO
	DqFWZhzL49wQcrVSN2c7+bgg8tdghmH3U0Rz1t4DMyHWH6MGXhNd/97V
X-Gm-Gg: AYBFou1QYQM/0oni90Lc6kSKpD7cwwdwtYVlnSQOxmrz/YcLXTK7o0MuRUjpyU1sGUH
	HT6GPgslZ9z7xjGhHcORlkpCP6uu1OMn36NkomJg5uwYZvd4FfRobAVqmSUJRF9iD/GxHGygsQf
	cHliBhIunOEp2/OiZ2sGxIIGo20f6Rbf0zunF6k2KANkpI8KDz8KCcw0x1NZsJDtOLt8EgTMGbH
	dEs7Fiv9FE3HlP9YpmV3oo27A0cl99ehiJNX4X/g1PKwwA73jNHwqNo5xzgMmOMLOky217WSq4l
	t4f5YjHnAhm9s2pf6xMi5c8bXD+HJGfZ0BuIT9Y2YQewm680lx/GSz/NQZFA/zHLnJz3beIC5Me
	r9ErSH8sZqWdhxoUPysFpvck+eRxyk/J3s/6woeQQB7dmASCs91g1CB22HF8qYRdabLjatctXci
	6wvmt7Tiv+4pKDQyrW4VnQbuysF++Dr58xHEyYBf11EA5H7qMVzo9+RlyIUbkSaseUTT1B8fk8L
	CFuXhrdtdTbcLK9tFgESu9dmZQ8ovsp3AaPOAF4qPDmpDOSiRlhHCmEAwLX29NJU+MhAqNVAQ3g
	lDA6ubvgRlRfogHwDIlE0enmD827eGGWf5RC5GOrR9VCXUN/w9vfOSFhpn/gNOzauqG0c/Kim1U
	cP/jL0CEAUxC/996IyeZZgrG1Wd6M
X-Received: by 2002:a17:90b:2d86:b0:3ad:ce18:50ad with SMTP id 98e67ed59e1d1-3adead57bfbmr5784240a91.22.1793009077115;
        Mon, 26 Oct 2026 03:04:37 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebac408asm7912647a91.0.2026.10.26.03.04.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 03:04:36 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] rpmsg: char: take ept_lock in the SET_INCOMING_FLOWCONTROL ioctl
Date: Mon, 26 Oct 2026 20:03:06 +1000
Message-ID: <20261026100306.68019-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
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

rpmsg_eptdev_ioctl() handles RPMSG_SET_INCOMING_FLOWCONTROL by calling
rpmsg_set_flow_control(eptdev->ept, ...) without holding eptdev->ept_lock
and without checking eptdev->ept for NULL. rpmsg_set_flow_control()
dereferences ept->ops, so this is the only eptdev->ept user that does not
honour the ept_lock discipline.

eptdev->ept is torn down under ept_lock: rpmsg_chrdev_eptdev_destroy()
(reached via RPMSG_DESTROY_EPT_IOCTL on a second fd, or when the rpmsg
device is removed) and rpmsg_eptdev_release() both do

	mutex_lock(&eptdev->ept_lock);
	rpmsg_destroy_ept(eptdev->ept);
	eptdev->ept = NULL;
	mutex_unlock(&eptdev->ept_lock);

and rpmsg_destroy_ept() drops the endpoint's last reference and frees it.
A SET_INCOMING_FLOWCONTROL ioctl running concurrently can therefore read
eptdev->ept just as it is freed and dereference ept->ops -> use-after-free
(or a NULL dereference once ept has been cleared).

The other eptdev->ept users get this right: rpmsg_eptdev_write_iter() and
rpmsg_eptdev_poll() take ept_lock and re-check eptdev->ept before use. Do
the same in the ioctl. Lock only this case: RPMSG_DESTROY_EPT_IOCTL calls
rpmsg_chrdev_eptdev_destroy(), which takes ept_lock itself, so the switch
as a whole must not hold it.

Fixes: 5550201c0fe2 ("rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/rpmsg/rpmsg_char.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 550fda2..49c0784 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -343,7 +343,15 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 			break;
 		}
 		set = !!arg;
-		ret = rpmsg_set_flow_control(eptdev->ept, set, eptdev->chinfo.dst);
+		ret = mutex_lock_interruptible(&eptdev->ept_lock);
+		if (ret)
+			break;
+		if (eptdev->ept)
+			ret = rpmsg_set_flow_control(eptdev->ept, set,
+						     eptdev->chinfo.dst);
+		else
+			ret = -EPIPE;
+		mutex_unlock(&eptdev->ept_lock);
 		break;
 	case RPMSG_DESTROY_EPT_IOCTL:
 		/* Don't allow to destroy a default endpoint. */
-- 
2.43.0

