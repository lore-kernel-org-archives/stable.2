Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509713;
	b=iXCEziNdcNwNLjo0h2EveYAZDmo/lFAk+Es6teH+rapBaKOcm+hpkeH/g0vGoWscQQVt
	 suKltS6RcilkMk4xAm9l/JPfvHB/wm7UaZly9t1j9MNrZZ95oLlecJzNxQ8vs50aI7f4d
	 h0HN0EkW6y8oeZJ7x6KvY9wTrq+x48UWsnoSsHW2oDEexfhBa6625c/CCmt9zpZxnet/U
	 +2rpnf+frOsqTMIbhz9DdjnNBUrQ3SMPysZdDzB78IyfG2Ces2jVNj6j4MJQI2/KbjQlZ
	 kCCIobI9Q4DCBiAjDQ8wx+Icjvh0WUxPLo1GAcukE5p1b7EKH+rFYsPKN6VQCPZtYSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dw9tl48yoYuBnTJQlsrtHR1Sj3M6jDxOml0OHKzmMmQ=;
	b=TctDq+ZkpSoOxcZK93CwVnZATa/pp3oatL1U79rOPP3tQxQjZtheQoSYeiMmHkeXiVZW
	 DqPPbS2S9vJQhmPQrpOV4Lnz2nlXEZ6rSWT15kLtAZXi0r3lBXaZtgwwLGCgI5Ofh0Yzq
	 C7hBHIRdCX4+gRHTJH7j8BxYVnAho7yltkTinH/PgzumhoVyjS/5QEC6nxnDm5qXYxBMc
	 QN012Mxqg6RYfHltlCBV8wbpaRecK+tpL66QHPcvBnWgGwTM2Tq628DFZzUoHnwA2HpHP
	 OkrtSETf+GcIPixhMiPG676QxbHu7nAoKxDsNefH8Iop61Rdc8ncoSEaUdCaff385TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xR2IHuM7;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D14606A32A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08D14606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xR2IHuM7
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso40942535e9.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795509711; x=1796114511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dw9tl48yoYuBnTJQlsrtHR1Sj3M6jDxOml0OHKzmMmQ=;
        b=xR2IHuM7Dci9zVepmivAR8zmfh+9xthP2PH/PYcNQIFb4THFbkM1dE51kyoVu5a4Wq
         qpMpjIc02ZMaqUsBniDjp9Wsr2Bpt3muRX6Gkx8Yi8E9wQO9T1/0s6E77SFlTRKKHxKl
         BISgpg0TUS7UHSkwydZuSrvIkEhDBAX+yXrGHRLUSqo8gMWWg0TqI+u0GPSnySOlIRwa
         7WZMLE9lY7O0DXXP3OXO/svK3SCAc6GJ2LcBGjEm0BRjgtH/7n4OQ++NMM9p54Rn7ntl
         hmTwCpFLUD2AN5Pcn5Nale6CckiorHWysgQx7b8KlpQ+zqO6vXTceiwyutY6usTdaiHd
         Y6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795509711; x=1796114511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dw9tl48yoYuBnTJQlsrtHR1Sj3M6jDxOml0OHKzmMmQ=;
        b=nmRN7uU+v21Kcl83nurOVgYmB7q3bkgKTr5V6ad+LwTcqL6VfmFMMC+k17y9jhz08A
         bUPi17y1sHmmUrTc0ZPmgqNy1cJmyRDXZC2OiG6BdL9i5rfharcf7zIAVcJpRHrLNLki
         LlHTmAXokRBj5CDFJ1m4ryrakiPNdxyRFRI3yqIRmUWhYbfRZJOJ9Y35nVhchBoIJeA8
         8thmzW3WbDqT9+XL16oIIXxGcnH0FlmxNKNBbnRk0me4iP7AZ2SI4uqmjr85CgE6Xu0D
         8AtjerEcXBh+0QpCsaChCCh9ZBCOZC9Vv/TLBRNpeN0XyYjmW9XvQlFCWL2+y6OiyzaV
         8nGw==
X-Forwarded-Encrypted: i=1; AL+hErHgVasNAIHypfey78rYkEUvOAoM/sO2ARN/IrtfkC+uPACrgo2LOV/rKP97liVZRrxfyTNd+rc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZLmqK/akkwfsHmkWwfxra6GJ/erVwYzwYaZ7v8lIMSSp2O7EU
	W1hduujZFer5Af2BuRzVBpdQXWMaAiULSp18YhGjw1kIHCMemU6onEA8
X-Gm-Gg: AZFdTZcmkjmppu6g0snNqOUkHSShruNUrBVznwsHFBT2QvjPhgBwq+FAI61VCX6+fFT
	2OBL2Lkg4w7p+wjf971DucLAbg7xbqO1PTaFo5PS4OacMzrkdNZvfUlsLDv9Urx8Jaw042N7ews
	hiU3Es2OGAq9TW9V+jvAaD01B4vr3svl3pHZ5d67EfG/9KPgNZADafeIuW0SCoKbbSp3IMWkayU
	L1xaDQi69A93sEzuQE7Evr+mueT/Wjm/lWE6tvDF3aTSsxw9M7tCjWFDWxf8itlFHnFGcbXAngv
	4gxqBOXIV9aYsDPBRsuxV7rhhOTZdsyaVxCIwGdIi68LP3o4Exf7Rq47vTwbtpusQryVVWD6+XL
	HuQyrZAfyos6WG+9uYzy0y1gL1/c5fEvzaihtky0adh8PsudZVlcKVeXGxx4h33YUCzWD/XtcxN
	0q0qkaRM8JmZJnWlwvPcDfXIVr4v0ylJO898Pr72718RRf0eFwDggCOZLOorkRVyeb4oIOGcwJd
	if4Eu7/9HxmoZfBbLHTFq448ZpQ7Z11wHyvBz1RJ0ysyXQZ/HnuTRbThNxeqE/OxgFpqfhfLoJ3
	HW9mQBu2C2xUPeVGpCsG303RENgY53Cg6fMBpwbUeGWaIwc5Ho/Jna6ryA==
X-Received: by 2002:a05:600c:820e:b0:4b4:262b:88a2 with SMTP id 5b1f17b1804b1-4bb887c9f5cmr280231455e9.1.1795509711073;
        Tue, 24 Nov 2026 00:41:51 -0800 (PST)
Received: from adriano ([148.69.80.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8533579csm369951895e9.2.2026.11.24.00.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 00:41:50 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	syzbot+7bf725ed337e37307001@syzkaller.appspotmail.com,
	Adriano Cordova <adrianox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] usb: gadget: inode: fix use-after-free of struct ep_data
Date: Tue, 24 Nov 2026 05:41:44 -0300
Message-ID: <20261124084144.3208824-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
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

gadgetfs_unbind() -> destroy_ep_files() frees each struct ep_data via
put_ep(), but the inode still points at that ep_data through ->i_private
with no reference of its own.  A concurrent openat() on an endpoint file
can therefore reach ep_open() and dereference the freed ep_data (the
mutex fast path), even while the inode outlives it.

Give the inode its own reference: take get_ep() when the endpoint inode
is created and drop it again from a new gadgetfs_evict_inode(), so an
ep_data can never be freed while any inode still points at it.  This is
also safe against dcache pruning, since the inode reference keeps the
count >= 1 until the endpoint is removed from dev->epfiles.

The inode now holds ep_data for its whole lifetime, so an open() racing
with an unbind never dereferences freed ep_data.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+7bf725ed337e37307001@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=7bf725ed337e37307001
Tested-by: syzbot+7bf725ed337e37307001@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes in v3:
- Add a Fixes: tag.
- Add Cc: stable.
- v1: https://lore.kernel.org/all/20260904163827.216389-1-adrianox@gmail.com/

 drivers/usb/gadget/legacy/inode.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index cc059a6ee262..20453214e35e 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1748,6 +1748,8 @@ static int activate_ep_files (struct dev_data *dev)
 		if (!data->req)
 			goto enomem1;
 
+		/* The inode keeps this ep_data alive via ->i_private. */
+		get_ep(data);
 		err = gadgetfs_create_file (dev->sb, data->name,
 				data, &ep_io_operations);
 		if (err)
@@ -2138,9 +2140,20 @@ static int gadgetfs_create_file (struct super_block *sb, char const *name,
 	return 0;
 }
 
+static void gadgetfs_evict_inode(struct inode *inode)
+{
+	/* EP inodes hold the reference on their ep_data via ->i_private. */
+	if (inode->i_fop == &ep_io_operations)
+		put_ep(inode->i_private);
+
+	truncate_inode_pages_final(&inode->i_data);
+	clear_inode(inode);
+}
+
 static const struct super_operations gadget_fs_operations = {
 	.statfs =	simple_statfs,
 	.drop_inode =	inode_just_drop,
+	.evict_inode =	gadgetfs_evict_inode,
 };
 
 static int
-- 
2.51.0

