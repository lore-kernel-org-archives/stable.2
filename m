Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208792;
	b=u/Zqer5JEixiyqj0E+KeZmBLWtNgiN7JIuBuYWuhILlEpXb9/dARAsptt10fT71uYLk9
	 3Pnu4U0TyVLaHwuBw7iMVAy0eMbUmhnXJhtP8xzKB4KmXk0OBUao4nIWCE+h9dEuE+3bl
	 lmtNBzj2cJXuVH1VFRUghb8wH895zYOOdN8Jut/akGe7MoBLKO7u7j+sm1WKJEXyfn1Tp
	 VHCL0MoXUp6T8dhoyFKUw40BGBjgUMo//JGNmPVeTZ3ZICq8KlxObW7VEQlbyUpsTjj8b
	 flUVfdPpOCTGIpNqyietwlElHJ4oULFGz5PZuyhM4UsldAA6ita+Rz+0d0kAbNDLzKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3LS5gvBAydA0Ig1FL/11e5L9aa77Zg2FmflSrEEofQc=;
	b=mU11LeMHL9cfsZFAAgB3rZ1+Ka27LtmBCH4SfIDfWfXvoHoZQhIycaNF6JehEvsgEKo/
	 LqXw8JH4668DA/+D8ZtdO0hcwi3mpCQvVwH3+0TU/joRDLY1A5yo8u8r3AkS4k8Qp6GFC
	 J5y8DeVF0Ub+qEnIlDunulBuW2X0SNoKIBV0+Bi+4m5lr81ewIvyr3b5amqJAB3L16ic/
	 cYR3hvx8JXTQjUZCnG8B0pBU9OCsqfHoP7JEy3tyi1MKtocz0ZmiqNYB0MvC5b26kpqNl
	 cx5Cki6K5OlDEydVwHy4PPOjHvuHLkrS4eXwqTCHxyF48eFQh1W3Zt4Kp8A00Gns59Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yfmtltvj;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D565B606A6AD
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D565B606A6AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yfmtltvj
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9213f004a14so8627336d6.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208790; x=1795813590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3LS5gvBAydA0Ig1FL/11e5L9aa77Zg2FmflSrEEofQc=;
        b=YfmtltvjYin2V0r/X5r77eN74n1Qf5MVudBB9cLA7bRTyHQ1S6vpmEM62BGlRaXwtS
         xifBTkIhBJ76sN4Wer8ZTPZuKxVOMd8ClMyJBExXj0d7bRpEUZoIKPGY+PScsLrh9aku
         Nem1DVqLtR5LnicdQjbVLavtKu/oBXt1c/QJiE48IytIXDYjlw83oQzZjKDM2T9z97/8
         aqGwbkAq7vl6/1Rj9f4yoWxJ26fS7118ia/YDw5eL3vYO53181M4Y4Pphero1q/qqrRa
         yIbiL6dj7Cm3hefZ/5DuoSh8MnQXcl+0mvFbPxccv9y4LBbLK9dRU4ndJV5SmSDpCS9M
         hDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208790; x=1795813590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LS5gvBAydA0Ig1FL/11e5L9aa77Zg2FmflSrEEofQc=;
        b=0pH0E8yj8q8+0h6P1J2WuspIp/oj8/BJPl9T8Y5DPEquKUwkOIfeoOGEUK/Ku32s1P
         rf3sryg/s4q8xvfcVMndbErguJacqDp45al29AmD9q2apeLEFfXmm3IpBdrLodVBgAUa
         YgtYFYrzHROey4+NOdej6iQBWQHQFXa5YWTWyilUaHvXkHYZKLgRdzFPURqbfS8OouYz
         ZFJfNYWn150Y5U553hh8hRumkaykoDuUpVT0WK51AkAyHKXjFSRNtw0GivZ/RpwsDUkW
         nwB8Dgr8eXa2OKVr8PB0AYP80KArLwgcnKnctp+jQAryKuwvZnlCyqi1O7rhhwlJ48FG
         TTtQ==
X-Forwarded-Encrypted: i=1; AL+hErHShsuw5gW13r7OlgQtIi+RVFdB0v46Fvyphc80REVaP2IkUOSWP3Fi4cB0q1ZSVKGRlKMmfTs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xsx5B2dSL9Jh/qcEprVwKBy0Bg+vmOFWBKNfml27SqE+Fb6xq
	a3o77ajPBdlyQL0kFtAs/U/rZQ2cft/htpKG8XiHXtUCS3IXCTYNi9n5
X-Gm-Gg: AZFdTZc7xujpTwoobWMxCMuHq9BHMHONzsDe8nreb7cQIdqRoJbbiOcQ8HzvxUdUIAj
	ApyNywfa2jzkpHPjol8wuSDZCeXTOIkG9mSHRMH5VQxGnjb9VWjZOp3q6dWB8D5fnmj+qcwvadZ
	mAZFS0tDdU5I1/9ytSASII3PvVh1gSAhKPYcY5EJjhaCHE1kocONxvQDNIqp5872FD6Yoh7N51S
	8ddzjNvRWUSecAiW/U6CujOwTNWLdMKz7WMTzd+JuTbFJC33PycfOz+EpRHbXfAuVNfQmaK78NL
	zr2flpBpsL7TGmbzHjmW7GZKz7uA4mSJ0whwBZz55Mm8Zwy0Cp6nOIZYMQyptuYHgOHnOTsWBLG
	BOoA0AAMbZUCk2QJ02Qu3+06luBqi9bnmt8UTAQ2L8qAbv4sAcywZfPU9kybyLSxp7UF4Rca0Mx
	4uiqC+z6SjX5bofS33+EQ0Vi0SZk3elrPM+iuuMuNV/hDfIKAocNMTj0/K3mvsJqWwjlGqapzJH
	A9A2lR34DI1Mw7hasan0Gx/4AAkm/5hm6NfKjPmlezxP2khIIeCaR1d/R0/bBoXpTujGT/TLVgM
	ZkcrHBzvdHuXg2zqqRyr9o1YS064rON7DlcB2uVyHOhaPWrEA8Fi63FMt5Q=
X-Received: by 2002:a05:6214:84d3:b0:91f:1e1b:7b3a with SMTP id 6a1803df08f44-92134b0c780mr49391576d6.57.1795208789683;
        Fri, 20 Nov 2026 13:06:29 -0800 (PST)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134bf848dsm35509986d6.44.2026.11.20.13.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 13:06:29 -0800 (PST)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: gadget: f_fs: fix use-after-free in ffs_func_unbind
Date: Fri, 20 Nov 2026 16:06:16 -0500
Message-ID: <20261120210616.2293426-1-shuangpeng.kernel@gmail.com>
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

ffs_func_unbind() calls functionfs_unbind(), which drops the reference
to ffs taken in functionfs_bind(). It then keeps using ffs: it takes
ffs->eps_lock to free the endpoint requests.

The superblock holds a separate reference, dropped when FunctionFS is
unmounted. If the gadget is unbound (for example by writing an empty
string to the configfs UDC attribute) while FunctionFS is being
unmounted, ffs_fs_kill_sb() can see FFS_FL_BOUND already cleared, skip
unregister_gadget_item(), and drop its reference. Whichever put comes
last frees ffs, and if that happens before ffs_func_unbind() is done,
the eps_lock access is a use-after-free. KASAN reports it as a
slab-use-after-free in _raw_spin_lock_irqsave() called from
ffs_func_unbind().

Before commit a3058a5d82e2 ("usb: gadget: f_fs: remove redundant
ffs_data_get()"), bind took two references and unbind dropped only one,
so ffs was never freed and the late access was harmless.

Do the endpoint cleanup first and call functionfs_unbind() last, so ffs
is not touched after the reference is dropped.

Fixes: a3058a5d82e2 ("usb: gadget: f_fs: remove redundant ffs_data_get()")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
v2: Don't take an extra reference. Instead, move functionfs_unbind() to
    the end of ffs_func_unbind(), so ffs is not used after the binding
    reference is dropped. (Greg)
v1: https://lore.kernel.org/all/20260815013818.39466-1-shuangpeng.kernel@gmail.com/

 drivers/usb/gadget/function/f_fs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index c64a268e98a4..fe4564d68b18 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -4212,8 +4212,6 @@ static void ffs_func_unbind(struct usb_configuration *c,
 	drain_workqueue(ffs->io_completion_wq);
 
 	ffs_event_add(ffs, FUNCTIONFS_UNBIND);
-	if (!--opts->refcnt)
-		functionfs_unbind(ffs);
 
 	/* cleanup after autoconfig */
 	spin_lock_irqsave(&func->ffs->eps_lock, flags);
@@ -4236,6 +4234,12 @@ static void ffs_func_unbind(struct usb_configuration *c,
 	func->function.ssp_descriptors = NULL;
 	func->interfaces_nums = NULL;
 
+	/*
+	 * This may drop the last reference to ffs, so it must be the
+	 * last thing that touches ffs.
+	 */
+	if (!--opts->refcnt)
+		functionfs_unbind(ffs);
 }
 
 static struct usb_function *ffs_alloc(struct usb_function_instance *fi)
-- 
2.43.0

