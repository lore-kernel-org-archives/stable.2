Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793514223;
	b=SQpFHCdfbfeQF797FglyjVLCEvJhZ0IWLB9WDE8xzDjPrapnokCBAGZAy+CRCrt2U2Kf
	 08/3N/cT3yp28VJ5CbbNdnu87BjJUaqA6nWOAWhon1e/nIgWwhIBh2MM4OhUh6Vsijq5F
	 NMNKmDOWmLr735BD9J1tH3sprsDGXHxqWSY7Wgc1U/kDyHBNSznz3+Y1EMPLQArW4Yv+c
	 lDDF30L2L3xcbaqE/sne9lfUUAYurFvH6RvONsGR9Mo054NgQhm8lxPzI01/WidXpLzmD
	 CBaksTtrQIndRNYxTzPiJV3qyIpUexYW3cQAODre5uS0dkRpqVZMZB7WpfdnvnBKMWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793514223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V3iVcUnWr9KVu5ckBKFl1JMHxwLvLh7qZfi7p+79FtM=;
	b=gE27ybCbdpoUOAPGy8o3+0W7WBa88DucahiPmnAAR84yo4ytSzDp7Kgi9p1Du/rfbtSn
	 Xg8P/1Z/W3ReV3ttqFX2+rjpfoMrkeJXIKGrGgjBe19X0nLGTTGpM9Gw9JQZSWSGDTm0/
	 mds8XHp9sVLkSUAo17tOO7NcTppnrBgcDeEbZzDWKw0Ah1VvQxQZFyEgb049kkpJxrFOd
	 IHiekKTzqXb4QPRxY+t0Z0Pe+LFUc5EBEAyzWO6v7eYGkmNXn5UTfCwI6y+2fyWAF1GYE
	 UwSPQfp4Zh/xRZeBlV4jHxnBcCxdmlwg/U2So0XzIhVFp9nVa0bY5f3G4/UWKhnKiZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="J/a3fqOS";
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB18606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 06:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB18606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J/a3fqOS
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a064fac8cbso1349400b3a.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 23:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793514222; x=1794119022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V3iVcUnWr9KVu5ckBKFl1JMHxwLvLh7qZfi7p+79FtM=;
        b=J/a3fqOSUlU27X0iUhIvxL6HMOzpQpOemLZ7bZZX3WllfYRs5Sdkz1t74ROJMTzMw7
         tKDOR3s2xLJ3OcNj9iooWxJm5vE6V6SAYZJbP/zkaXsd7piaOO6Py6gZgg4sxt4dudsl
         Jo0bdB9Cg6jLjDqkfbQs0RR4IxopYnj7VEbVLf9x2h3azDT41Dcaf882qdargx0vItIu
         xN0Gey/+65JJ2UJe5M6tYGvb0/8LrCIyGbDcHM8d0nPiP9f/j5seVKoXiKrLDoMBnO+d
         E8LGyExj6OmqobfZ+xOyuMQ41AWPfb3HIYbgmZKYGsZh3wVQJyo34rxdyxOwddc97N4p
         ZwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793514222; x=1794119022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V3iVcUnWr9KVu5ckBKFl1JMHxwLvLh7qZfi7p+79FtM=;
        b=LfeFU17SovX0l6YFR7dWTnSt+yBPNZqvjgF5O7/R3BJjX2nixPYM56dvmouKIMcwl+
         pCp3NyaNWB331Y/bT1CZj1So37oCy8NIN1UfNAP+or/KEO5k0KSpwYKoXDzcVJNFC4WP
         x6XXqxesCXRGJhA2FO7Mag5I85fohtENPAOb5lDNhEufSOWPYE9gcHDq3np7xZtkFniV
         S9USvrNz92FZVbK5afEKg7tK6h43GCaX0LfrqqGJb0pzcDTz1r1eLaTFVSGETl28+f+0
         GnyRC4TaTj1iu47MDG/JXNJ+fXBwLDYPBBODTkb1RSsCQd7FNrp+e4w0NfC0+EYuLi0F
         AESg==
X-Forwarded-Encrypted: i=1; AKwUvBwV9Is13Yj0NmCifzIWx1boBUuPdEFauvMOd+DJ4GV3eMP/sFsLgnQy27KQYI6l1P73Rq5+qrs=@vger.kernel.org
X-Gm-Message-State: AFq9FYInb5IYyvbylsy+JYHSjvNCNwEmDR7nHVCXUCfUPQg+y2lr9DGJ
	DRkgxfN1QB4a5xBLZJFwbnvGfTsx+TaCMOvdxLxeRolrsLL5jY8nWmbn
X-Gm-Gg: AYBFou1Twlc3qSMYzOzEqVbttvuYD5TOueSAT6yDziH8TlU1aoSBB1yo+ocN4TBNPxX
	AM9iWUXvZZ0GDr1rfFRel16pX5KqdDXn5q5sE5u0K328lDsqTgdYwVp/GlSFjmu4rviBGGU3fAO
	5El78MY4nJpVop9YtvpHj+Ll+WzEMq3Yhgn2mP1IwN10Vm62V+gguNyCCV4I/XgXfaSaSW8z81G
	dgbuw081ZyuDkElQxZkh2UM9ORdiB7/4Ef21zyLR8PJFjjTbw2SkgGzYCaxQi5EZTN7Cm2vfNSC
	HbeVJQxBJKfYlfNpU/F8Qv6drBcmAQpWbpXTybBjhEGe/BGEFt0R22H16HteHUcqfJgTcM5wrdR
	TQTsXaCh34XUZNrMOlTE1wm8bak08HimZ7CXQFhZtCekHbNTQaDaIeVRT98Wh3DoU2v6yVQwhXP
	Rt1I025HZyH5bNj5lygRAEVKxGwowfwpi8BntxLu8o9QKOL5lx0egMrs6QJe7emE6nuOnmvUc4R
	nYTlShk8PoXD2yi9Yg2+MWuIQWlhC46HC7Ffrh/jg/2uHu10R6XjR8DOQonzHWQ/jk/xqA68O53
	pMb0g8t+0rdqeugnUI5NjAs6wVA5qDdOCniVzZVKdT+u0pFH8KTrGkCo33sjJE1ZqJ4efMHIzwG
	qjC4L49BFi6nXRznEL/UWki2A+vf8fHZ8vwIgStj4zsHj7kVSiFyC3DZZM4RrbB6r7AtbkS4XbX
	qE4APKBf5grU4PSjqW2IR7
X-Received: by 2002:a05:6a00:21cf:b0:882:905d:aa05 with SMTP id d2e1a72fcca58-8a9bfde689amr5497443b3a.50.1793514222525;
        Sat, 31 Oct 2026 23:23:42 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aadac9c505sm1026348b3a.53.2026.10.31.23.23.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 23:23:41 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] stm class: drop the source link after the source device is gone
Date: Sun,  1 Nov 2026 16:23:17 +1000
Message-ID: <20261101062317.16608-1-yuz08559@gmail.com>
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

stm_source_unregister_device() drops the link of the source and only
then unregisters its device. The stm_source_link sysfs attribute is
still reachable in between, so a concurrent write to it re-links the
source: it ends up on the stm device's link list with src->link set and
the source's link() callback armed, after which device_unregister()
frees it and the source module is unloaded. The next unlink walk in
stm_unregister_device() then touches the freed source, the stm device
keeps a reference that is never dropped, and a source like
stm_heartbeat has its hrtimer fire in freed module memory.

Delete the device first, which drains the sysfs attribute, then drop
the link and release the device.

Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/hwtracing/stm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 5fbea4e..64a9eb1 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -1287,9 +1287,9 @@ void stm_source_unregister_device(struct stm_source_data *data)
 {
 	struct stm_source_device *src = data->src;
 
+	device_del(&src->dev);
 	stm_source_link_drop(src);
-
-	device_unregister(&src->dev);
+	put_device(&src->dev);
 }
 EXPORT_SYMBOL_GPL(stm_source_unregister_device);
 
-- 
2.43.0

