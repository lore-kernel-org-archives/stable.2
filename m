Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795334867;
	b=4sGT1ErwjDO5TVk/F1GQvJTwpzqQl6wU/zGNOcO4ze7O/fG3DgMy18cWcHLdpg3Vr8Ga
	 mKrHK+Zo0ZZEpVLSXtmxaaJOSbg3cFO7GkVakLbvEKUEOz99ZsxgLRoVz18LVIS8150Hh
	 bsZadKxVXWzdqNoOG5PXx4YfMK3jnO/YF1wS/EZjDx8dQuPsDVMIIcQX4lquDPlwv5FnX
	 Ytycc3Ik0GyMtIoczAbHBQY55bD5WjHPmneY5iNoej0cm2HF6xMN9GH93gFxCOSsYaWnj
	 LMQ9Q/nQV4zPcbV2qu6ccqp86SK8xI/XJ7CIQzU3y4YvhqvkUMJsgegzGULvUyFEkww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795334867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/mkvkDb3xo2wy8tT3sFzQBOkkMEtSGCgH+EfHq4vbWQ=;
	b=QaaylJghATsEej8ipfAh2tRr+JRu53CWUkyVEZsh5yigCRT+5LO/A8nQpCxSr9I87QOk
	 enTqOHDGcQ/w1sYKF+wYsNnK15f0F794z6jkglDuVjbOzTtJs/o0auFFR+HETKInbO0ci
	 uMYt24OXf5Hsah44wuMupenqmjT1unLOPp5llNOWc/G17QmC0FeuTh7AsxV4BZYsSAzG+
	 DHZsCqu2KnW+EHu376MQX3YNCq2kl2Xtak9elKgb4Za8MQIAj61nKK6qe3OHr1tV+Ljcc
	 OoiIbPfx+/9ofFCWopnKNF5wcA1W+jKEuRz1eQUwjwyZ/v08wo0nyTdv1J+y7XT/83g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0qfcIlUD;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E3606A330
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 08:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C62E3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0qfcIlUD
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4ad6219f7d8so1509447f8f.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 00:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795334865; x=1795939665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/mkvkDb3xo2wy8tT3sFzQBOkkMEtSGCgH+EfHq4vbWQ=;
        b=0qfcIlUDQGq5L2wppOOw9G3oPE5JToOHIqSTxQnbYpOuCMV/ptEYcKsRkYEhl7KROg
         FTANui5eP9C8vt2oM9pRJFG7CxLBHXfhCS/O/ZazP7STzb6Pqrh0A1gRDi50ygUbYXvP
         m25WpY/MQXkAaZRK4U4V8ywZ05m2qALh6zEw4zahm8wsdTnXoVBPzVdHPnVmC2zT+Le4
         ocxsmMz4Pk4Nty2xsN6vGlrAbuiba2vP1zTOpj5+DuLqU8Zi20al5ZRaUPECkfhrxC/f
         71B6axce74PiqpX84RajUJzIIJzx0hDzCkJLi8AufQTddYxN2EGW+FU9E7g385gqmuJB
         ZZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795334865; x=1795939665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/mkvkDb3xo2wy8tT3sFzQBOkkMEtSGCgH+EfHq4vbWQ=;
        b=cQcysD817HuTmRhgNskSJOgfDQBmmYPZRVVKj5AaAaSaBIGGo6ymwdhtFc3F1NMg1h
         eCLNgJP81ga4e1gXFisKYFuSSxP/N3o7KMm/2Hgi6gfMrksWPRodTx4x/RlDvBbFu6rM
         8tr3xnkuvL8RbxF9lLn8ktGIzVJTBuZ2OzS8vvHTCw5EtPB3CHVKIug81H7Bpjt/eIqM
         jEyo7AATKFweJdjyBwn49O48gJgUk60phSGAN926GJMfLIQvvovd/lMBZh5HMACfw3FO
         +nJ/xQRJCRZVUYEN3SMoP6VmbKRj0nwfHQ1/o1PuF9eEMMh6cp7vS81Ey4y8m8BjcEjx
         KS7g==
X-Forwarded-Encrypted: i=1; AL+hErFcBXcZ20bL6TKpGR6yBLi6Dco39f7ZVjJFgZTzVPLnoa45mx3hPqr8NPOp/jycICbNfbiThz8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mRPICQOxgQ7UzPG7uhllzig4KErMReJ/5mBRDV++7wiHo46mJ
	uPuD304Ouy+7Xx11iEL6sMCZ3uZOHOvD2TSBGeY+lJOYo1BuRt+wmUca
X-Gm-Gg: AZFdTZdzBHqT+LR/MlVnV3fHoPrpQ0uNOqUdWfwZbqHZCDIEjUH1LStuWukfRopsGhN
	CKmQc2F8MYMV79B3KapTKvRUCpg9FlDSbmr8jcHM8pAoGC+VvJcGHR1ZpIM9esFetkhQ34+5qWD
	0tI0xPxwfTZvOadXla027USHRS0ixanA8yXKWNu31x/h9jzOpwXCHsFJKt3CvDQFKtnGdvY8luX
	vt60RPn05RlahEJio13LdbEJcjW3OgG3iIIa+xGAvu0MmFEACbxSWojXtZj3l0445czDOr2Kt/s
	vE+WOJJJle4d0lGIE0bymFyx35ZJCtN/J+Ko0JJYg8ZXVrnoaqBeX+EdVoy7hJWcd0c3rCXgqnh
	3oPyNRfMQzT316OKoRKcKe93f9gx3xxU6Zvw0pAIThT38G2SudL3yrLav2c66Gs9FXWHih1zZ7i
	cg2ELS9RZuxsY2IZhocGQahsiFrCDJfcXtdsJ8NxCkmSDx8IAF8DXCueezoDeK/uir8gOcy1EOj
	wFbgMA24Ok6mjXrhHjJp4u2S71jxrENypQnglQ0RRIYlWzChjopzonZsrwXmwGQmlhqnVqFpt1A
	kcjvOZniI6AR81U0cCGTel3xzKlNrXVY5d2V6Gv4KF3pjvCFywddk7huTaZ2zS/IYrzAQLloBIv
	c5Q==
X-Received: by 2002:a5d:498e:0:b0:492:3982:a80c with SMTP id ffacd0b85a97d-4abb70d7094mr12139269f8f.29.1795334865036;
        Sun, 22 Nov 2026 00:07:45 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([103.125.177.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad644140b5sm11929664f8f.17.2026.11.22.00.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 00:07:44 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shichao Lai <shichaorai@gmail.com>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	syzbot+dc208a8cf8d37cf3e5ac@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: Re: [PATCH] usb-storage: alauda: track media_initialized per port
Date: Sun, 22 Nov 2026 13:05:51 +0500
Message-ID: <20261122080550.2181-2-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5d2e1310-88db-427e-ace0-c2a0590560b1@rowland.harvard.edu>
References: <5d2e1310-88db-427e-ace0-c2a0590560b1@rowland.harvard.edu>
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

On Sat, Nov 21, 2026 at 03:54:57PM -0500, Alan Stern wrote:
> Has this patch been tested?

Yes, tested in QEMU (x86_64, v7.4-rc3 with KASAN, UBSAN, dummy_hcd,
raw_gadget, and usb-storage alauda enabled). I do not have physical
Alauda hardware, so testing was done via dummy_hcd + raw_gadget:

- Before the patch: running the syzbot C reproducer reproduced the
  UBSAN division-overflow / divide error in alauda_read_data()
  (drivers/usb/storage/alauda.c:986) on LUN 1.

- After the patch: the syzbot reproducer passes with no UBSAN, KASAN,
  or divide errors. I also verified additional raw_gadget scenarios:
  * READ_CAPACITY and READ_10 on both LUN 0 and LUN 1
  * Media removal (status 0x80) followed by re-insertion without the
    0x08 media-change bit and READ_10
  * Media change with a failing alauda_init_media() (unrecognized media
    signature) followed by READ_10 and WRITE_10
  * Recovery back to a valid media signature with TEST_UNIT_READY,
    READ_CAPACITY, and READ_10

Regards,
Arbab
