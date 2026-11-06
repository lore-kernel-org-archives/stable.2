Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989195;
	b=oR1XJ6FoXStpVdLeieWVFm7r0raNd3IP23DEq48IdiaSWAjPVb2f2gSyHOkrC+K3bPeT
	 VqT4eKgc9V+onw6LsarqPVUrqhPfsSFRn5teAokQY3UFvUI2c/VKKn3BNTDa27ykSEu/N
	 EZEPsPMoa14xWGVfZ5tY9mpt37he1/a/km5yHVxkuTIiFjfxzBVW7YsslWLOyDntG+8rV
	 6H3X0Whns5ex3KvPn5j1BucaycMnPgHzi22NFbYzjB/kxLyE3smc/Dpmn1dMNywGRpBwj
	 4kC51FSGCB9DP2l5tNY8k3a1fG5uncB3dJ1Kv8ZwlZzDA0CQJ+dzCNObEa5+lul+eAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ePH+hik62Fy6F4AAmE1n6DWeBVlZXhgjc9v7cFTm+1I=;
	b=Rpy12c7ceh5K3Bgd5emeDB+uyqQSFlWf9wbT2CbcGkaMRWaLQwaxnY+hcLMb9osC8xF5
	 YZ8qK5LTZ6yczatYQA7bl8uJ6Lx8l3zbYv7d8ths5Xw0CMaVWfPt7sUyWywBrHMVHasos
	 aDw3XD9N/fhPPcX42a1NRUm8e+P27LXISxOczusXHF+H8DWfShLAnXUHb/p6sv7auf+EP
	 RCQM0IAKNTfA4D1sNJ8YkY+dbqdpoAUiCsdH4Wxcm6TXLPaiYM7D5GG0B2XmSLa7+Jn7N
	 JmlzEldPpRelN4NKPjn+suZyUQ+05m3M/JisFf7uaUmCpC9tdBN3FHAW6uBCPKmGSsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7lR27Rb;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C90B606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C90B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7lR27Rb
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1526291eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989194; x=1794593994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ePH+hik62Fy6F4AAmE1n6DWeBVlZXhgjc9v7cFTm+1I=;
        b=X7lR27RbrxzayAIqAKtxrfjf53P0bbpYAmfW+QVcAshLVcuM4RBj69px8H/k8CSjsm
         Hi41EFcJE3XccnMUwcmsv/Qq5V/R2F1dc3X2FynpaQXVSAHmwOitYgskIterANLTBb1G
         cZq2+ewPwPG3aZmQstNuutoWF2nCQfBUUYAK2aVBYT7eNrsjOdpm3EHebbwkOShfxHBn
         VA2W3Xx5NYz8untfcuBIhr7eM5pkbpaeaXOxljElRXWT17TfMmLtbfUW1dW5H99cKb3J
         yfwGvemvWV1RDWr6Jli0dtYrVq6PyzIk8i96SzMf3hZOPp58V3Vdxck7Y6ZCaOA3Lrmv
         ulBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989194; x=1794593994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ePH+hik62Fy6F4AAmE1n6DWeBVlZXhgjc9v7cFTm+1I=;
        b=mscI/E2yk7RXOuNn0UctGDjnKvDOXkTQqEbZyMHc58K5UMYQurlQwQGi8A/WRXNe27
         gcdcgpTbmfIhhW9t1j7dN0uQKyNVT0gyu1k8goUnyCbX3+ho9Yg/kuvUNigiHOrwa/sn
         5ohdOYr6a2Bw329vD6ppQSF3MWPdgRne61Cp8aGL7Mwdgrrfn5JAcI3JQjU1GIwMa8cE
         buVxNylJYCdWQcr45V7n0bUNJzH97stdtsfprurfVq1gvyjQu2YTo3pwWT8kjvXX3e0a
         mLOheyZ2WOF4UMqDaeACLUd/RT/6TrK7E47SVg/6rRxCDuKlW0xWTKwNp6NqEzxSvLDA
         MAJQ==
X-Forwarded-Encrypted: i=1; AL+hErEyh4mWQHZKeUt9gx4QFgCoaBTzo6Vt97QjLl1ttwPaR7V+xLImMvZv7N5EicBm4GpsAiSy2NE=@vger.kernel.org
X-Gm-Message-State: APuU4Z93rsncVzHHGkxkbOYlaT8sh2vAxvzAwM7zINkn1kM+73HPy7tk
	5GqM9JIFRsEViBovicOaWPJesOCNqR54ZMkhE2ZXOp/j7l6sZkhVDyJmv7awsv6ePuI=
X-Gm-Gg: AYBFou2i5mZUH3DW+mNeUga9fVJD/2Eh++JxckzCrN8k+W3ZVXcgbfaRbWz7yaqb5qZ
	oP+jUaPcMoYTP5jSqgSvz7XEKTMqSOwC0uFKSC1C5ma0AIodAq6RXqV6lyDnz5dg+NN5S5lODRL
	dstCslfvCPxlwgyJc9sMySZG0jZhTipTgka7wCcQJYKv7XLrutpkLUi2k/u4dtSZiR2AvSi6gGT
	L8d91FHg1jpiTLQVrwRVZUFTIbULYOXZvB/pbnUnJAxlbQvdrhqR7rIWc75Jsj4P92Kj4aiE28V
	ewXEg9tdtRLlDqwCQ+r3RZ7U11JTsPAUkRW4w7wu1/VY5PLcsVPwzGv1fck2hSXFn+p2zS/09Sf
	PMtcanMIGni0omTGkNoQzyRAVA5BcWmveAbqUFiLknTnvvLs26eyMJyHONgvHx95zN7+v6D8JJK
	9o1WaRSvWU2PkWartOowuOKhXsxvv5csFGJ2+DGp/9gRL0mjLfRr6Mrx69vTk73kktALI5dJyid
	re/UWkjEviRhioeX0Z+m9pI4rh0pIK89WA6F+v2KG/X6DNAwEfx2DW21J/8UYj/Dlt83voCQhnR
	bVMvPVzZeYi/gcaR+Em684x6AEqKrBgPo+mzHTGzH/10Eey9yD+PqbydtDjtnzWU6g/PcqQc6Fq
	YLJMie9hWpe+pc/+lJMlo7rBHoySY8ldvUY9kxNN1NgQdfUshBLkQvpg6B6GOAhkrtEijbuejlt
	uCRl6cMs3cxRUIqDv+2sCd/7fp5ODWMw0v+NQRhhcmJ8LnNov3XA==
X-Received: by 2002:a05:693c:2a0b:b0:36d:d7ec:5e3d with SMTP id 5a478bee46e88-36f772f8940mr4302147eec.21.1793989194075;
        Fri, 06 Nov 2026 10:19:54 -0800 (PST)
Received: from zbook-HP-ZBook-Firefly-14-inch-G8-Mobile-Workstation-PC.. ([49.207.55.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm8241901eec.26.2026.11.06.10.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:19:53 -0800 (PST)
From: Payal Lenka <payalm.lenka@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	chenchangcheng@kylinos.cn,
	Payal Lenka <payalm.lenka@gmail.com>,
	syzbot+f8fb5598924c7e645553@syzkaller.appspotmail.com
Subject: [PATCH] HID: corsair: cancel the LED work again after unregistering the LED
Date: Fri,  6 Nov 2026 23:49:44 +0530
Message-ID: <20261106181944.2535082-1-payalm.lenka@gmail.com>
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

Commit eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering
LED to fix use-after-free") cancels the LED work before calling
led_classdev_unregister(). But unless LED_RETAIN_AT_SHUTDOWN is set,
led_classdev_unregister() turns the LED off, and k90_brightness_set()
then queues the work again. The k90_led holding that work is freed right
after, with the work still queued. The removed flag does not help, as
the worker would read it from the freed memory.

This is caught by debugobjects when a device is disconnected:

  ODEBUG: free active (active state 0) object: 0000000097898442
    object type: work_struct hint: k90_record_led_work+0x0/0x1e0
  WARNING: lib/debugobjects.c:629 at debug_print_object+0x189/0x2a0

Cancel the work a second time after unregistering the LED, in both
k90_cleanup_backlight() and k90_cleanup_macro_functions(). The first
cancel stays, as it keeps a running worker from using led->cdev.dev while
the LED is unregistered.

The root cause analysis and this patch were prepared with the help of the
Claude Opus 5.5 coding assistant.

Fixes: eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering LED to fix use-after-free")
Reported-by: syzbot+f8fb5598924c7e645553@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f8fb5598924c7e645553
Cc: stable@vger.kernel.org
Signed-off-by: Payal Lenka <payalm.lenka@gmail.com>
---
Tested in QEMU (x86_64, KASAN, DEBUG_OBJECTS_WORK and DEBUG_OBJECTS_FREE)
with a C reproducer from the syzbot report, 120 seconds per run:

  no fix:                     warnings for both work items
  this patch:                 no warnings over 124 disconnects
  only the backlight cancel:  warnings for k90_record_led_work
  only the record LED cancel: warnings for k90_backlight_work

The reproducer does not exercise the race fixed by eb51c9f8cb4f, so that
is not tested here; the first cancel is kept for it. Not tested on real
K90 hardware.

 drivers/hid/hid-corsair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 278c6efb5..7e5ff3d52 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -526,6 +526,8 @@ static void k90_cleanup_backlight(struct hid_device *dev)
 		drvdata->backlight->removed = true;
 		cancel_work_sync(&drvdata->backlight->work);
 		led_classdev_unregister(&drvdata->backlight->cdev);
+		/* Unregistering turns the LED off, which queues the work again */
+		cancel_work_sync(&drvdata->backlight->work);
 		kfree(drvdata->backlight->cdev.name);
 		kfree(drvdata->backlight);
 	}
@@ -542,6 +544,8 @@ static void k90_cleanup_macro_functions(struct hid_device *dev)
 		k90->record_led.removed = true;
 		cancel_work_sync(&k90->record_led.work);
 		led_classdev_unregister(&k90->record_led.cdev);
+		/* Unregistering turns the LED off, which queues the work again */
+		cancel_work_sync(&k90->record_led.work);
 		kfree(k90->record_led.cdev.name);
 
 		kfree(k90);
-- 
2.43.0

