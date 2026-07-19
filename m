Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F72F8E9E
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784499050; cv=none; b=bx+xSAtsKSObi4/2p/exbofo8taHbdLV1NgyeTJBa3fYXhw7fsU+9mSQDEVBrtK5FubbVhRKfglaZYkQ/ijIFDkXEBRrYg5yGHrdSGx2FY3jT5NNa8jf6iAPFkFNZvrhuM+wHCBHuUuEeT1STBdtIvsMHN/R0a00IiMmix0A1e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784499050; c=relaxed/simple;
	bh=xep+DbUTODAyiI61W5CCxIKqMCWLvMAtORFdzKJXX9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHPAAj5eUNjDxllcoyKh6tCPb1AO/c2M6VRH9DjKQiwWx/ELOiNC+bCId89ynf1/reOdogex0B3yMrif1kocRU7e6XRf6LzfXE/Zi9zMWmqEYwSyyIKsRVw+rwRv+vdLbQIzZGH2WznY5eQF5JaiBth00Zlr/d2zUn8U9PhzztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qruG3Nyg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qruG3Nyg"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-495437bb891so23672345e9.1
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784499047; x=1785103847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T7BUDbPgvu4uYiB0I4Tcu6S0zkTXWIU92UBF/zE/Z4w=;
        b=qruG3NygUeT3MwGKkZWDoY67KUpNkZjbNfUG/HakYPVTGOE0StN/UW1O0LSYcg/6a9
         8ZfS+lrz27UleaNUTfbV7XHyb7E8DQjAhjJ0w3FUtGdCWJBCoZOTIP8HpL5hD4Fuea6S
         TPMbLHmKBHwgde4pPMHgEmB/6ciCjpCf11vvf/f366DOAUqak70MJXMICVFFaKT5nLwh
         RiUgShY4q3N7rkGfOKVzw2mSUkuSrMnOM+lIeUgN3tvnHvZfmzSWrsqdI5RpXJURyFeC
         wB0gZopIStURMsgFrYmzHAtiYXS+qn+ELJiNsbH6ymAzUy4AiNPv16nNZML95yUFjDH6
         K0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784499047; x=1785103847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T7BUDbPgvu4uYiB0I4Tcu6S0zkTXWIU92UBF/zE/Z4w=;
        b=ecbhx6o5RZh2H7A+0iyTISL7feU0zLSVAQsPW8/nWZ6lnxMVIDXc2eBvKYCMmgPFWK
         NDTHOCOoZchJfXEXo05pF904SkpU89uQjhWLFsPMeo8x37EXItPkuNKRlXK0n3bku71K
         ZcVHOFtKTMSPATN3Loweua1/v2bYh7I7BMg/zqyfwhyl58s0zxfOfzCxJ5VaXbc2uu52
         im0hg4XIgupY2eR0q7u6u8PY1SBDxMshOtVTr1ZmAefoSet36v3/0j0+hpLUJwlEvxbn
         reUA+QpRepwc9Dn9gdp9Yx1q1sp67swXXmwB7KYxd3dZBBcLKyoUuph447cdrIFEMVYj
         DYuw==
X-Forwarded-Encrypted: i=1; AHgh+RojyYMGXT1XJpp+IAufYZ9P7FxEiqggNxWGCSq5UhFXebP8jCzo1W5S5sn6OxC12+aiZ3y2yTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7fpwPJl9b5x0PKiW7YkD4Ic6N4y36t8eaT4Dcv5+XmTYvJV0J
	ZxJcdoBYcSYSF80MQ0xum4UvhvWakiuPsYlQkZs7wAMuBNC1cPszl5GL
X-Gm-Gg: AfdE7ckpfs+HTM942UqzpSkp5SEkRvltXwppSF9843eS+XW1xPEMwbRu5BhYbqNfdtU
	9NjsJoVmG5TMzdFnPY9MDWH4jJsBu+4Cmirj+TfNpD2Ij956u7aDZfGE3PnV5qfZPKn/g6wtvO/
	H0jaAE57cx+wdXw5Bd/ZQNcvmixuvISBV1eLoCsqGQqycRMhYa29vj12fYaxieLloAGBBQ9n9jK
	xyhGX82t/xJwFdzb22bT91KeO7HgjBMu9oAkX7p1xyIv2r7BeFrTS1n0ueB/jlVp1ryED6A6eCg
	CJX7ndJHvhHErCGSBb44pBdw5NXSRTHlaHrh5pA8gW2d3LMP7HDcBXXAs3oPcVf1Fs9+zYG7Kmi
	Hmji/n4FzUMgGC1qcVYiMAk118WBSo3kf8xe50yIH6SME3Y9JhD2QmgnXNPVR2fXe1+HIX32X4k
	GNXkUTbgwGEG9jVaA4pWQyQFwhyK+X7JBws85wI8MDcw+tJXfDaFoW3VWSxLtho/PMtMN8wfnN6
	qSzgOBmiqLZiUa8dWS6stTDgqjV/tYhAxgLxqUa/jNt93iBLC/sqp/V5hfUxY7+1vNkLvauRphR
	P8+QqJ3RmyVrTReXvRQFkPj5
X-Received: by 2002:a05:600d:8443:20b0:493:ecf5:89fd with SMTP id 5b1f17b1804b1-4954a341a2bmr91369185e9.17.1784499046380;
        Sun, 19 Jul 2026 15:10:46 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955370d78csm114492445e9.12.2026.07.19.15.10.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 15:10:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] tty: don't oops in tty_unregister_device() when no cdev is registered
Date: Mon, 20 Jul 2026 00:10:13 +0200
Message-Id: <20260719221014.44354-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719221014.44354-1-kmehltretter@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial_core_add_one_port() keeps a uart_port when tty device registration
fails so setserial can still use it. It marks the port UPF_DEAD and
returns success. Removing the port later reaches tty_unregister_device(),
which unconditionally passes driver->cdevs[index] to cdev_del().

The slot does not always contain a live cdev. A serdev registration error
other than -ENODEV returns before tty_register_device_attr(), leaving the
slot NULL. If cdev_add() fails, tty_cdev_add() drops the cdev reference
but leaves the slot pointing at freed memory. The later cdev_del() is
therefore a NULL dereference or use-after-free.

The NULL path was reproduced with failslab during UART bind on qemu's
mcimx6ul-evk and raspi1ap boards:

  Unhandled fault: page domain fault (0x01b) at 0x00000038
  PC is at cdev_del+0x14/0x34

Clear the slot after cdev_add() fails and only call cdev_del() when it is
non-NULL. This makes a non-NULL slot mean that a live cdev is registered.

Fixes: c1a752ba2d6b ("tty: don't leak cdev in tty_cdev_add()")
Fixes: 8cde11b2baa1 ("tty/serdev: add serdev registration interface")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/tty_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6b283fd03ff8..4889076b975f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3167,8 +3167,10 @@ static int tty_cdev_add(struct tty_driver *driver, dev_t dev,
 	driver->cdevs[index]->ops = &tty_fops;
 	driver->cdevs[index]->owner = driver->owner;
 	err = cdev_add(driver->cdevs[index], dev, count);
-	if (err)
+	if (err) {
 		kobject_put(&driver->cdevs[index]->kobj);
+		driver->cdevs[index] = NULL;
+	}
 	return err;
 }
 
@@ -3305,7 +3307,7 @@ EXPORT_SYMBOL_GPL(tty_register_device_attr);
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
 	device_destroy(&tty_class, MKDEV(driver->major, driver->minor_start) + index);
-	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
+	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC) && driver->cdevs[index]) {
 		cdev_del(driver->cdevs[index]);
 		driver->cdevs[index] = NULL;
 	}
-- 
2.53.0
