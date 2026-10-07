Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00953CBE96
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372211; cv=none; b=BbDtuU7htvofP+gMMJ3ukR1/jCvJbDFpUPwJXW5DFAvmUfK52LsVF7qN61YY6Hu/WgKBZgFpPZvfKh31z+UVrnRACeNEiaN0LHcPv5lWVTrk2jRqZqKZ6iRjdUHpmves3OuUS2YaHgArHC6XnSLmeLwRrDAH/IS/JRycnPdVmFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372211; c=relaxed/simple;
	bh=2hwsUZK4ODMcka/Ebr9sKxEUtV9w7OkXEuWQZ+N18YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N436kjgOWC0jbVifLubUbkXsokz8Frtf05QXs5RV1+reCF3dt/02wT7RsGMNPEdQ1eshoScLu6dTanQSV2Nla1XOJKERS6D7xKFGh8tul6rBINiKoWPAQQowN1mB2lJIpgKNx5hH1PJjQAD+HjTfFnooVRMsEQ/fCxctG1Oo/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9G0JFMD; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9G0JFMD"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-31490970b97so2854129eec.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791372192; x=1791976992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ecet2Ly9TeUCYQ0Ys/6vyvxrbNg36mAKtReMuHqWCLU=;
        b=o9G0JFMDoktnW//TtCy7CyHRjmHKEikXiV0zKO62Hl+m0IPcGn1ksVw7YhUgA+s2TS
         R7vRKoZEV2TmLg0PyOdduzDTKj4n5C2VaNuQQ3qnV46vW7SicT2RLJAQVZ7SySLWp8Mt
         aKM6Sm+jPBoyBPg8r2gpx8CnU8hb4dbtvyF4v4OxEyTd2LS+oI6h1tbEojPqJJMU0pmK
         QhmQSNN1Ro2Q1VZlkmFgY//tPPB/bDsw9WiM8lyOnn5EbWpGDAw3bHVR1IlibsDAe6Kp
         lRXFRKnBqCXgRs/NH+dTguRCtdh5YALuMYYrXm7ujZX18VdodEht9TbaRr1iFIhtjdoq
         UgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791372192; x=1791976992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ecet2Ly9TeUCYQ0Ys/6vyvxrbNg36mAKtReMuHqWCLU=;
        b=Rmumm54nrc4UHaLILk3UTqAbdb3uGCUf/EwRomRrroFll5vAGFnfLTrYKPbkrBjsFc
         mzB4Gj1312wIP5UyqmHvZxB7iagGQluQR5AlB265O0JNXhplGFkngG/LHLF8ozNy0Hrt
         Mfe+zkuqCZwx+9mZrFqHOO5o9souxFDvPb+TB5ahRvgq+SI/hbCoYcyNJQRW+7GwrcBa
         iUnNREkxcpv7D2z4cF7QTrjiIS0tJgXD1r7Fqy18VgDUVmdorsd+VKhfl3QSzn8kSPOA
         3VaOphzRwpgblpPYbehT+DGFReoEqkpOMgTr/G2/FL7MLTVhJNg8c6aggaosialrpTus
         mbPQ==
X-Forwarded-Encrypted: i=1; AKwUvByFnj26wy/9Z31gbB9Utl9pQL5UvlFdbaFRcSPD73cQW5fPJ4Ufs3F9sBqSVddxv/0zOdoZFdc=@vger.kernel.org
X-Gm-Message-State: AFuF++kmXTyYianW48HoGnU3bRjrR4r5djPr5w28Gvdq3e3QPegR629C
	1MkzqHoMPjSZXRDUXmLf+YvVK67gNBejFtO1mO+aGyd1RnwMDBdHNlXg
X-Gm-Gg: AYBFou0SE22BnSKiNyk64LWAeMy+2CoY/tpnRqc6aGVWMeG8tKp6QqjsEmSL/YnNozm
	eVJ1L6fGeG5vAT3i+VVJEZyWUjXpwdLEb5J7Xr898Wf8BLYopkMDZWhGXUNvBVc8Rb+THnNSQ8J
	rqetsVNSTfO8dAsIRC+573DfCaVlobQ2+IsTvpKDSnyoS4TQlsn1flyAQSyWExi5i4jsK8clYm8
	NVxjH1sS4pqKezi3Voh2mSpa/H9irPjXQr9fIz6/fHpUo9LcQa7rMPLkGxmnWWiqIO5+aq5nhS7
	LYB0J3YlXnI8imepDm3DT027IDHFmE521sXxQoxZoaP0PUxY62hAGmttjEitCU52qpx+sGqd1Bd
	h4HyAGdFiRT538t4BFlDopeSlQBo6bju71/GlMxZ/zjUhpBXqKDoII8kdMZ05O9gNnXoBOvXO9F
	UoDfgVkacv+Qu1Lk2Ev+AlB9efmH+P227tjxSN2XWLcaxXUV+zTRvNQFnZ5E3QXI3ep97phVKuZ
	z6M4FFpBSPId4rEIF6Ylg==
X-Received: by 2002:a05:701b:2616:b0:13e:6efa:78f7 with SMTP id a92af1059eb24-162044bfdf4mr1689134c88.15.1791372191642;
        Wed, 07 Oct 2026 04:23:11 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.133.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16352800ed6sm3234698c88.9.2026.10.07.04.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 04:23:10 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	syzbot+d627b1495de0e851be32@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] media: siano: initialise the urb work once, not on every completion
Date: Wed,  7 Oct 2026 16:52:57 +0530
Message-ID: <20261007112257.1888-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261006124545.1778-1-yogeshgaur.83@gmail.com/>
References: <20261006124545.1778-1-yogeshgaur.83@gmail.com/>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smsusb_onresponse() re-runs INIT_WORK() on surb->wq every time an URB
completes, right before scheduling it.  INIT_WORK() resets work->data,
which is where the workqueue keeps the work's state, including the
"being cancelled" mark that cancel_work_sync() sets while it waits.

smsusb_stop_streaming() kills the URB and then cancels the work.  If
do_submit_urb() is running at that point it can resubmit the URB, and
if that URB completes during the cancel, smsusb_onresponse()
re-initialises the work, wiping the cancel mark, and queues it again.
__flush_work() then finds a queued work where it expects an idle one:

  smsusb:smsusb_init_device: smscore_start_device(...) failed
  data & WORK_STRUCT_PWQ
  WARNING: kernel/workqueue.c:4425 at __flush_work+0xc8f/0xd70 kernel/workqueue.c:4425
   __cancel_work_sync+0xbf/0x110 kernel/workqueue.c:4568
   smsusb_stop_streaming drivers/media/usb/siano/smsusb.c:183 [inline]
   smsusb_term_device+0xdd/0x3d0 drivers/media/usb/siano/smsusb.c:345
   smsusb_init_device drivers/media/usb/siano/smsusb.c:497 [inline]
   smsusb_probe+0x1aba/0x2280 drivers/media/usb/siano/smsusb.c:575

Initialise each work item once, next to the URB it resubmits, and only
schedule it from the completion handler.  smsusb_stop_streaming() keeps
its wq.func check, which still skips the URBs that were never set up
when smsusb_init_device() fails early.

Fixes: ebad8e731c1c ("media: usb: siano: Fix use after free bugs caused by do_submit_urb")
Reported-by: syzbot+d627b1495de0e851be32@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d627b1495de0e851be32
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
Built with W=1 only; not runtime-tested.

v2: Added Closes by
v1: https://lore.kernel.org/all/20261006124545.1778-1-yogeshgaur.83@gmail.com/

 drivers/media/usb/siano/smsusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index 0fdc2e0950b7..210c323c8232 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -143,7 +143,6 @@ static void smsusb_onresponse(struct urb *urb)
 
 
 exit_and_resubmit:
-	INIT_WORK(&surb->wq, do_submit_urb);
 	schedule_work(&surb->wq);
 }
 
@@ -468,6 +467,7 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	/* initialize urbs */
 	for (i = 0; i < MAX_URBS; i++) {
 		dev->surbs[i].dev = dev;
+		INIT_WORK(&dev->surbs[i].wq, do_submit_urb);
 		dev->surbs[i].urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!dev->surbs[i].urb)
 			goto err_unregister_device;
-- 
2.55.0.windows.5

