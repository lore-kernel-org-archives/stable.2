Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793437706;
	b=P1Rw4S8wwWyuah2rPQsglxxy0eePfTFjht4o1CEd9t8LM4E5IBUfzVZZKZG7DZxuiLP0
	 HbLZHokZWWY/lpsvKR1x2ozm8qjg3XBGxzk7srClwJ0ZmJgm8hENR9mTF14U83sx+I4jj
	 bRYAEGvfLQYytudxeh9e0uP01XcFRQwLqdJ9dw2uRWpq08vzvR7Yq1cLHpLkfL67tbnAC
	 5stjFD+rxCjYRLsJKvg9IQIKxIShW8WlUKuxg/FqqKqz0YXpMwhNxry/N6OVluuK59ugH
	 LNNkc1jmhK3tiXsxV7VT+TubuxV676Kwdm1zy79Gd4Fm8ySKk9FLDzyO7B85mYyQuAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793437706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aG7uUgIWZ0oyfHEXG9QJCx6yU4GdFnWFe7KXXLifVuA=;
	b=4ZtkumlRvmoGnyluzT4KnRX9ORDU39YGxc3CAESGy8SBntVTVnvJPncmFvbTf18Hprqh
	 6YlbWjHUKJAVRUcCFSW6waJ1Gub36nbcJDu8CW45Il2esJTtjmawPIL1m3ZQ0nikwyds8
	 peZAfRpvdm97D35vGN2Fq/2lAT8GPrBXDb5QcMa9VflnWtJPYrINIGkKAppDyyJei/Xl2
	 jYheNXKg/3s0VPitzLVwJ/o7zsO2yxAljrSgGqymFhLSh6/P1WoJ2uqBwTY88PnKqAtB+
	 0AHwB9Ygwzz1zBW90JrM905kkcSIJY3wfX6w5zFRiNR5usBdzmilxYSPGGUt68COr1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vg5vE9eJ;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0BC606A323
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 09:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F0BC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vg5vE9eJ
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso552471a12.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 02:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793437705; x=1794042505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aG7uUgIWZ0oyfHEXG9QJCx6yU4GdFnWFe7KXXLifVuA=;
        b=vg5vE9eJNhVaTMln33GkMcgicuA4inDLsHF5BvImPmEHkyD6jFVW5B3uGrkO1lKCOy
         fkE6Nl86pPiNat/cAwxbPK1mAY0nRI4jH2D+C/ETCc7ZqybzifUFaJf7bM8F7fucQSDT
         /Yrz3uDAK6z7FDHPhaCqOZj+UZG7PK/ptf8XtNQy3EdeOpJxdxJIJ3dQ3IOA9oT1+YrJ
         ErxmzQ1Dcs77K7uuzGdg0ZdLnHS57s600+N9TKEQONeIeW0jSa1cy+6fFFHYwzNsJEMi
         BrU6nsY2nYG9ONNeQyVPhZDcLeNdk+vYJKbagwk0ThAnSaYNVCM3ZFqcKP8ltuqZfB+3
         ++gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793437705; x=1794042505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aG7uUgIWZ0oyfHEXG9QJCx6yU4GdFnWFe7KXXLifVuA=;
        b=jMnDnIYC5K4XeNKgV63+S2ktUIApYdo/oFyk4qAKTf80Ga2+YHhAfU0vT7djbovevo
         GRYpziyqTzmL4aF41EnZfu7pnCAor1hKpLJWa+uSX+lXiiK5gsK84bI5dol+K3yXDanj
         nJTIIQICSkzlsSyRXehVVfq82oxv09QdG1NGOJ5q5lnUWev/HgsyzoPZeYNho1Y+3WHw
         l9U5KUJBrB7AXg3yAzgug1qkO28ZnFqBqf8Is9outsSyYA3UUP67uM/JeTs2h5PeXV/P
         Cy7Lw1RyAS1io614oljK3h6t18pfrJa+CFIv6V5HuYrzzKi8192yPbGd65C8tRLMwoSl
         Ni2Q==
X-Forwarded-Encrypted: i=1; AKwUvBz4kysmzeRDHHxX3R0PQkMDYVkJj07HHbDEU41K0CcJC7y36QNrLMIChIVu7yMS6qaaZGrc0vU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSOtGQuofCocSk0xx5LZfeOa2sEr2vbZRDXcZw5M2B/Q1yWo69
	HVlz24lwW5N4R70XcivKD8HssSGf8WadqsRp2a/LytNb7dd3sbndI7WD
X-Gm-Gg: AYBFou1UCquL5vs/zh0hlGgy41bITcIbKOW4P1lPvO68uBayX0FU7LYMPZ3NLd/O182
	0pdQkYfA8vdclX0Sp9aZqYjr3sKzdz+y4GwK/3PyC3/gk3oqejsdRDu974lph/+iQ6v7YavT0BT
	6DXgkj/tA09Os15paKCWLe8v7Pyh7+QM19reRF3kNBnvfjnM0S2ZqPzPSpFVpVYLpzp1RdP84F0
	cBG5/Hb2TqnLuWpw2gYWSa0rqUqgg9vW1+dLKbOtUDqNUW2ijecArX1y/PSTg+fzz8tAC9ZlxT2
	FNWQsQ82gGnAYTWsLiMotR62rTnp4Vig1mf71n/6XG55+1rR37wntEh8mir3BAraVkY+5j0zi6Q
	Uu5j6BLhY4dV2UU4u4zjoAcznIu31pIwN8vbKmokQqohOGAittFfgrxvm5vVu3qZOJ9KGHGCfM/
	ehxZoUEgupMiW8uBXQK1cSHg4Icg2N0mbnv77IAUpoX2Q/cZyj6KSdmNIZS6Z5DCBwaDFJXfEfb
	O9PyqveujO5f6QIRSSRPwggq009rK0NKgJahRsiXCos/v9TlGcKAW723Dvd9NJwOTxAoMJHyzAg
	QkzVLn48hDcfwAX7xfAFa0H+Wv7eaLWCjhzpZleeBFDtabZaBi2zTPzWGqun9M/IdrfAh7eroI9
	+u4Vg4Cs1XPXt9obtqcBR5LmqMjC3liPKB4S3o+rH1BcDSmPWfZkgpsdYYnfATDDRXGYDLwjPh3
	irXYLjBw+Y3zbqQYf/mVY8QWCeHg==
X-Received: by 2002:a17:90b:3d8e:b0:3a8:86b7:ad95 with SMTP id 98e67ed59e1d1-3ae897c5e7emr4019087a91.60.1793437704316;
        Sat, 31 Oct 2026 02:08:24 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.191])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09610f48sm1614184a12.2.2026.10.31.02.08.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 02:08:23 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] rpmsg: char: take ept_lock in the SET_INCOMING_FLOWCONTROL ioctl
Date: Sat, 31 Oct 2026 19:06:50 +1000
Message-ID: <20261031090650.23701-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026100306.68019-1-yuz08559@gmail.com>
References: <20261026100306.68019-1-yuz08559@gmail.com>
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

Fixes: 5550201c0fe2 ("rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
v2:
 - Drop the paragraph about the other ept_lock users from the commit
   message (Mathieu).
 - Bail out early when the endpoint is already gone instead of an
   if/else around the call (Mathieu).
v1: https://lore.kernel.org/all/20261026100306.68019-1-yuz08559@gmail.com/
---
 drivers/rpmsg/rpmsg_char.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 550fda2..d8868fa 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -343,7 +343,20 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 			break;
 		}
 		set = !!arg;
-		ret = rpmsg_set_flow_control(eptdev->ept, set, eptdev->chinfo.dst);
+
+		ret = mutex_lock_interruptible(&eptdev->ept_lock);
+		if (ret)
+			break;
+
+		if (!eptdev->ept) {
+			mutex_unlock(&eptdev->ept_lock);
+			ret = -EPIPE;
+			break;
+		}
+
+		ret = rpmsg_set_flow_control(eptdev->ept, set,
+					     eptdev->chinfo.dst);
+		mutex_unlock(&eptdev->ept_lock);
 		break;
 	case RPMSG_DESTROY_EPT_IOCTL:
 		/* Don't allow to destroy a default endpoint. */
-- 
2.43.0

