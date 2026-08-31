Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344863368BF
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176743; cv=none; b=RiPVupTpTp0DyLhQ+Kyj1w7CkXnQwb0irSzByzq3iQRkYIausDp1CYBXptb+vq6hbPrVU9ISJql+6jLMq5wqnqorWJpHY4N5RzRos468dOu+I/+IdbJh34UMbknd9pG8M9/PHeH9CwgmSkLjWfMV2ayMbPih3dIEapLC+EgLy8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176743; c=relaxed/simple;
	bh=BEeQAQ40I0LV0aGncVgyaQlkRdikCzo4unT8jnz0Nbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9hklooPZtRvMgJeJuCyXsGQpItIuLzKmppsNw63GaaigZSbK33RgWvXWA8uZUmYzL8icpyfpWk9LwwZu1Ti0BQajUiSQuHIVVy/CXjB/rRu4q9Ke1Uza4KtOYLJhuZRZDWN04QZn/VB9nNa00EbxFv9i0eNzbs7UJGMiDBfN8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K9Vl2qw2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K9Vl2qw2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d5335cf904so31651175ad.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 04:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788176741; x=1788781541; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GIGBSwlzLQ3JNiD8igYqt5VspQFX9U8fXgxj4FZ+S/0=;
        b=K9Vl2qw2aTOSN3FVyf9BuTBo+zuZImLZJAb83gzT4uS35gzC/9a/VG9ZaKJgHhmHho
         T1A1SbolXQN6g8aoP77yaQa7stTkGPlrBuRpMv134h8AfBfgzjigjY4dZe/A/WPWkI++
         MGKmF8Dxi+SfPV3ej4wEaQBlTqle5+lhZw3+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788176741; x=1788781541;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GIGBSwlzLQ3JNiD8igYqt5VspQFX9U8fXgxj4FZ+S/0=;
        b=O1GkAWwPDFB52BMZ41ZlXE5PQdjTd195Y6Zmho291Xoo9B6uJaNQJfsdEBzybQ+qw+
         U3H+Lgo0bqJAXXQi9tRf44/bhaO4XynBTzaE2NU3YTsHxOVwz5wSH7EACZ8cmZ+VKKNL
         +8Bk2q0gm7tPm+84hsm3Jwt9PsqKTPPH7DpFBhmHku9ccAnoo8gyiyCfg9wrVMYRFDui
         7gaOrCfO2mYEzaEjiakuMhDNt0wUAhHfvif+ulVHMx/wFlt7k+7u2coZbxiEYr+zgk2m
         7/sqL1a7+dlqiSXURC/w5nOQbsYf/DZOBlGw1yFV6+DKfdIZNm0hgPl6thmL2WamClVh
         BeOA==
X-Forwarded-Encrypted: i=1; AKwUvBwIMSQaoo3Mre0uzpL7OiT7RFWb9HojD5UtOrRJFdMwpQqmZRbZ4rSdNDp1zjRjsTXIkMgK1cY=@vger.kernel.org
X-Gm-Message-State: AFuF++l0Jz/M3lm4v2ntQaRVIpW3riOPjvOc9G/4LtgO3mRpYy0s7LFi
	lQL5yteNAmpp8FbIqoDQWlaV99t3SGmphBrg68sCjEi+SCVnS04K956tUb6zcjen2V4i17qdgik
	GRmQewTfE
X-Gm-Gg: AYBFou0/T8GMe0kTMngs18Yt5IEjQNt+NFCNyyCOUFzHeIPh7TdmtLvV4ThwnUumVAp
	GGN6dualKrqUUl7ir2dTaoaTurwb1fdVmqkmTQTgt1W23jHstNxmY0PJZqjvGRR3Ytwmcti3RN9
	tIjl46DhWklEoiIV2cUhs6UPYVJUSaLQs9LviDp2ZPTgi5He7Chysg23IGkKwV1GISKW6LZB+s2
	WGmVEAaz1Ulh07BWiT7E2tIX9UflklXWtqIEGvJcKLUtsTOIT7dYBY12NlakSbQaoA1JJzP1QI+
	6NqPQ2BSmFDSpTlSxVIydXzT6KfK59/eADjjjkMYhc6oxDH9CJMMfUh+ebCZQoVuQsHJdXUrnlq
	N8cFkn1WJPW3OQkbN59DKDREI35s9y4DoO78GI4rJOl43JkPczfhd/YG9z3731096SZj2dA9qWz
	VK6jlOsig/0x7PHoMadwdcZf1VE44QRGE/o2dNmCqwrTbWxAovMqjDfXLHC4cdvnE8Yo5mpmPGN
	boGrxOx0E4SrwkK4S10LDECWe8S1Q==
X-Received: by 2002:a17:902:ce8d:b0:2d8:d4cc:be63 with SMTP id d9443c01a7336-2d93fa2fc9bmr37179985ad.16.1788176741529;
        Mon, 31 Aug 2026 04:45:41 -0700 (PDT)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com. [209.85.215.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759869e3fsm33804865ad.44.2026.08.31.04.45.40
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 04:45:41 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so3641831a12.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 04:45:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz3Hm0YvubdDOxRC/7WQuIm5nCPjTXx+C9ACNTk3oz6CkZfBmYo1+tHvbokM7i/iyFgG4hGtyM=@vger.kernel.org
X-Received: by 2002:a17:90a:d887:b0:392:b509:b1a5 with SMTP id
 98e67ed59e1d1-39907e0f87bmr182688a91.14.1788176739296; Mon, 31 Aug 2026
 04:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822112256.12346-1-jeffinphilip14@gmail.com> <20260827035155.10725-1-jeffinphilip14@gmail.com>
In-Reply-To: <20260827035155.10725-1-jeffinphilip14@gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 31 Aug 2026 13:45:24 +0200
X-Gmail-Original-Message-ID: <CANiDSCvPSF85ztR7XOvOmhRN_i52etjS36+jXmUAE1ci04mXgQ@mail.gmail.com>
X-Gm-Features: AcwNN1WLAz6VN8qw8vpP77AnvuGLGadWRBZtJh28ci9mCBTda2OW0XvkaTo8pN0
Message-ID: <CANiDSCvPSF85ztR7XOvOmhRN_i52etjS36+jXmUAE1ci04mXgQ@mail.gmail.com>
Subject: Re: [PATCH] media: dvbdev: fix uaf in dvb_remove_device()
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: hverkuil+cisco@kernel.org, kees@kernel.org, linma@zju.edu.cn, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@kernel.org, 
	sakari.ailus@linux.intel.com, stable@vger.kernel.org, 
	syzbot+37578f730d38898f4b74@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Aug 2026 at 05:52, Jeffin Philip <jeffinphilip14@gmail.com> wrote:
>
> On Sat, 22 Aug 2026 16:52:56 +0530, Jeffin Philip wrote:
> >In dvb_remove_device(), dvb_media_device_free(), device_destroy()
> >and list_del() all dereference dvbdev regardless of its refcount.
> >Thus, if refcount for dvbdev is 1, it can be freed and we
> >operate on freed memory causing a UAF. Fix this by moving
> >dvb_device_put() at the end of dvb_remove_device() so dvbdev
> >members can be safely freed and assigned NULL when dvbdev is alive.
> >

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

> >Reported-by: syzbot+37578f730d38898f4b74@syzkaller.appspotmail.com
> >Closes: https://syzkaller.appspot.com/bug?extid=37578f730d38898f4b74
> >Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
> >---
> > drivers/media/dvb-core/dvbdev.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
> >index d753d329502a..9aa4b8fd7379 100644
> >--- a/drivers/media/dvb-core/dvbdev.c
> >+++ b/drivers/media/dvb-core/dvbdev.c
> >@@ -598,7 +598,6 @@ void dvb_remove_device(struct dvb_device *dvbdev)
> >
> >       down_write(&minor_rwsem);
> >       dvb_minors[dvbdev->minor] = NULL;
> >-      dvb_device_put(dvbdev);
> >       up_write(&minor_rwsem);
> >
> >       dvb_media_device_free(dvbdev);
> >@@ -606,6 +605,8 @@ void dvb_remove_device(struct dvb_device *dvbdev)
> >       device_destroy(dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
> >
> >       list_del(&dvbdev->list_head);
> >+
> >+      dvb_device_put(dvbdev);
> > }
> > EXPORT_SYMBOL(dvb_remove_device);
> >
> >--
>
> Friendly ping, let me know if you want me to fix anything.
>
> Thanks,
> Jeffin.



-- 
Ricardo Ribalda
