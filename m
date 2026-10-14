Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0517E3BA237
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975406; cv=none; b=SwFJoAB/OXbFi6hUXIvmG28u51kb10cfOWSFFsC/jRizQ6/dJXf1Vh4qYS29dTdu6uX8Lc0wrvhlPGGr8oQ/fgRWAWQQAU+NqiPy5AHFpeOk3ZT1d2SocPIfzYzJs3LVJ6DlTm3TIBOYfWCDhLGRWJ9Jf+QYKrEbhp0O8hva4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975406; c=relaxed/simple;
	bh=Y4eZrrndS2C2UGm8W6Nw931MICNnIUtHZLsSlWIh+PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfeP+Tz6A15olOvJ7q4ZxywcOX7lPepieT18LBvaL+UIKxiR7AmgY7W3HMlIGTMEyX2HUYhHKedcKACgrFJ9oxmGO5/0d4obt0tDhWRXozLEzMvWueoWiZA0HToczMwvygeu5LOeFqpmR1zppBxkwAI9cF/9UK4pelOPqw+iCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTMGHceW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTMGHceW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so33124075e9.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 03:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975403; x=1792580203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y2xZR8hA7sxhS1GPiOCm7v6GvoHFfeF4FaagxZ1l5xE=;
        b=mTMGHceWJ9D4xtoEnTzJcMC5O4wNIWKQ0ZOk3dUuL0JJqprZrC01VYuBmNrD6fRUm1
         O+BDLCnnL4Qz9rSrde2SkdPtE/gEXiPE0vAFkr7BJVkOiHNgQXQNEJN8FKhDVc8Vo3U1
         2n0FZmO92hYaXQSTAUA7PUCy6nSrYlNbdY+BVL+Ccf/NQeCEs6nt0WHfZpqO6/YJnSgN
         FQNCFqM2LfuXhR1S4BDe4SHytlz/zac4F9gWkhvSQLuUJzkrugxlkG0HdI0pLHkr/wAw
         JKFrkVGFVnnaljr5Mk0+PtYTGHU5c6LjdSXX0OFhw+W98I7mL+oLCR4eQ+xQdlnJRqKu
         YAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975403; x=1792580203;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y2xZR8hA7sxhS1GPiOCm7v6GvoHFfeF4FaagxZ1l5xE=;
        b=O9yQe5GaB71HgM10lpXGopIck7jU8EbmC4+AStVT8dGOAx9Cg+r5tKHxg1j6xkl+Ut
         kTfP+sYDhShvay47e43aihFQ1yABgPi9ozBqxvBlQIZAOEE0VlCfYlX/VScwaA14upFF
         QCR3xsN3R8UJQZlWMdEJTEJ/mvBUSTKLWGSCoSeuJq2NAl7DoNOlEIz43SFIADzxvAlP
         S8OCtp9U1qMlxiPBmM+wyVGVtGOhSVQDB9pOuqC5Ba6XkvEIjkXXHiutPXzPmVEfdvOQ
         110xlIVovuEPlPP92n5fB7F84K0hj/pU4xYmwIVl1erasW3VRqv4adeK9hEbDSVCZJbj
         0eLg==
X-Forwarded-Encrypted: i=1; AKwUvByR8oFa9Is16LUAYG/J3X2llojoEEaeK7FAlzER2E4LFi/BSZeR4vdhGTYYqUREeFCoWZVEjWM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHIHFb8eFu0cr67h4k2bIXZGKTTyPE3b2d+EmU/rH+N3XYLHFM
	EYKSdzHEbFAW6jnxZNhSpb++wp1J/PnzG/9PH0+IA1xu8pQGHmT9hDNz
X-Gm-Gg: AYBFou2o/G7NigyX4fQ3fWRG6kyPWibTyrD41zdM7JEZEADVRLK/LxeOzeEK1hDwBMw
	tcomlbTnWAgCdSQdQhCaD+/p/upvj2FKwl55dOC34K2DPTcwpLYW4c2SQPceIwsiFsvuPZ+M043
	flZUncBdTqQ2NESF0fKWTRDaH+ErYv3NnDw7stLWzT+v9OIw0mKJ/QpFrCPK7uDIG9xFgpTcZUU
	6MqYorEtQwkttIz5CrczpUt1fojiicTYVSuLoIfFuPGDTAPfjonZzgY+0DHLWnBVn/o+dXR6KzM
	ND5WQe/ZtO/P+Js53WTHjeGvkNCHRzD0YZplDjgB9dUy59u3yCCpvkDRpLoZVMvxr7Y5E8T3V3N
	V/Cks/7NZJ6oKzzYiMLStoZfI8E6cOmyJIXsIfi5+Dd0xxrAkKvZMk5xLOUYwpoe8ZywuHQuG5s
	r1h0hV//WO+0p88IOSGG4duUt/zP7hEGIxUx0gGVXSCBscr+3KWzcq46Vpz4ONX6MrnxTVENZh9
	2ZRxSK3dsa7qMPeERbtZbFfVd+Q/KAH4gl+pEgXk3IcJGxCDV0cljY+E+/iW4iAQbO9PX4lW/El
	dBk+7UEh/n/n+QmDkZrpy41CARse+QK1Hm0TUAZdKqi+yyayloPnC3BT/sqLms+yjM5g8QX20YS
	FASYcyS5Qlgai7WWsRJJyqnYHW9avTlq7r2JtWaecVTpotzdi4SYwvze4ifW4hVauGIYRKcEETy
	Enei+a
X-Received: by 2002:a05:600c:46cf:b0:4a1:7e1f:21bc with SMTP id 5b1f17b1804b1-4a18e4d6636mr318973045e9.29.1791975403143;
        Wed, 14 Oct 2026 03:56:43 -0700 (PDT)
Received: from localhost.localdomain ([37.167.102.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f249692sm434061555e9.3.2026.10.14.03.56.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 03:56:42 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: linux-usb@vger.kernel.org
Cc: oneukum@suse.com,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: uas: validate status URB length before parsing the IU
Date: Wed, 14 Oct 2026 12:55:26 +0200
Message-ID: <20261014105526.16392-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013221937.41490-1-olivier.kaloudoff@gmail.com>
References: <20261013221937.41490-1-olivier.kaloudoff@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

uas_stat_cmplt() dereferences iu->tag without verifying that the
status URB actually carried a full IU header.  The transfer buffer is
a freshly-zeroed sense_iu, so a status URB that completes
successfully but with a short or empty actual_length — observed in
the wild during link-level upsets (Thunderbolt-chain xhci blips) and
on a wedging bridge — reads back as iu_id=0/tag=0 and produces the
misleading

  stat urb: no pending cmd for uas-tag 0

log spam seen e.g. on an ASMT135x enclosure and a Samsung T7, right
before the affected commands time out into the error handler.

Beyond the noise, a short packet that happens to carry a
plausible-looking header could be matched to an inflight command and
drive the state machine off garbage.  Bail out on anything shorter
than a full struct iu.

Cc: stable@vger.kernel.org
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
v2: use dev_err_ratelimited() so a device emitting a stream of
    short status URBs cannot spam the kernel log (per Greg KH).

    Tested: patched uas module reloaded on a live system carrying an
    ASMT135x enclosure (behind an Alpine Ridge TB dock) and a Samsung
    PSSD T7 (AMD onboard xhci, HS link); verified clean re-probe,
    mount, and sustained I/O, plus 16 forced disconnect/re-enumerate
    cycles under write load with no regressions and no spurious
    short-transfer reports.

 drivers/usb/storage/uas.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 265162981269..d1725ef8f954 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -315,6 +315,13 @@ static void uas_stat_cmplt(struct urb *urb)
 		goto bail;
 	}
 
+	if (urb->actual_length < sizeof(struct iu)) {
+		dev_err_ratelimited(&urb->dev->dev,
+			"stat urb: short transfer (%u bytes)\n",
+			urb->actual_length);
+		goto bail;
+	}
+
 	idx = be16_to_cpup(&iu->tag) - 1;
 
 	spin_lock_irqsave(&devinfo->lock, flags);
-- 
2.47.3

