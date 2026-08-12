Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA946AA79
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545982; cv=none; b=beuJfFs98Lzta7jxdLfdI9qgPRZr84NitTrQOe8CQoD7MVkP9WGP/wf1sqMtHWxtjJGmjF6dzLoJX+1o1sY1P3Cno7eZMZtupYkROTJQ5DbYkXna5ib1Be0ET1b9e6jgEJAPvAe48fii4NCcOxRjidFm6VAerdCe5P/BTBluWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545982; c=relaxed/simple;
	bh=TyH4rF7rmZte069DH1ktjK1Aj6CoIIOo3Lk0ZK3ltmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHQ0GsMGmFzMOWVZfTgLiZnZcYf794GzmZanMQ1azUhl1zX9gV5pLJs9aNyWCjsfVeiGNHyMWQQCcoeEeaCe1BQgJbnmx3uQeyDBhzMjc6+zLs9mOf9pyxgDn7cIJUajezCm/d1N1cI2nAAJMzBvYD8BBuVJXf2kA1rKpID8nUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arPamfa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arPamfa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0211F000E9;
	Wed, 12 Aug 2026 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786545980;
	bh=AVsn8zNKhIw/2Gc898AOt1gQvBiFZrLxL3gLbTWcOYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=arPamfa8QVhV6q6szokmWkffpkwn1tmEF/xKX6S8ARqT8sRXT3rU7UBl2+ptSYUkl
	 JhfMpnGE5Lurh5CjCUQhFMDYhscFp/BrQtV0R4CJ+Snwo6wf2ReXLAvG/KpoOqYQ3D
	 shJztESEF0igwCDkFYzfpsS4TFFt5UkoUUy1HUro53Yh77+OrJ/8hpPJWZRUKP3rFJ
	 I2XAxHyOUJ6USVjKNTFwl+FODCQSeZRMR0SOtLNCa7P/lBp5nzsBR0VeNwmIwR1aP3
	 8ZFrixUhzMSk+hwVXthGRAmx2KiWNHicwu7L0TbiyX1RZxfxiz840FtppuFMr0RBsk
	 U9vx69QDjQYPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] jiffies: Define secs_to_jiffies()
Date: Wed, 12 Aug 2026 10:46:17 -0400
Message-ID: <20260812144618.2226698-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080526-docile-reply-8f04@gregkh>
References: <2026080526-docile-reply-8f04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Easwar Hariharan <eahariha@linux.microsoft.com>

[ Upstream commit b35108a51cf7bab58d7eace1267d7965978bcdb8 ]

secs_to_jiffies() is defined in hci_event.c and cannot be reused by
other call sites. Hoist it into the core code to allow conversion of the
~1150 usages of msecs_to_jiffies() that either:

 - use a multiplier value of 1000 or equivalently MSEC_PER_SEC, or
 - have timeouts that are denominated in seconds (i.e. end in 000)

It's implemented as a macro to allow usage in static initializers.

This will also allow conversion of yet more sites that use (sec * HZ)
directly, and improve their readability.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Link: https://lore.kernel.org/all/20241030-open-coded-timeouts-v3-1-9ba123facf88@linux.microsoft.com
Stable-dep-of: c2816d613f38 ("ice: wait for reset completion in ice_resume()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/jiffies.h   | 13 +++++++++++++
 net/bluetooth/hci_event.c |  2 --
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 3778e26f7b14c..5bc2aa7eb5a15 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -371,6 +371,19 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
 	}
 }
 
+/**
+ * secs_to_jiffies: - convert seconds to jiffies
+ * @_secs: time in seconds
+ *
+ * Conversion is done by simple multiplication with HZ
+ *
+ * secs_to_jiffies() is defined as a macro rather than a static inline
+ * function so it can be used in static initializers.
+ *
+ * Return: jiffies value
+ */
+#define secs_to_jiffies(_secs) ((_secs) * HZ)
+
 extern unsigned long __usecs_to_jiffies(const unsigned int u);
 #if !(USEC_PER_SEC % HZ)
 static inline unsigned long _usecs_to_jiffies(const unsigned int u)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7ce4ae5a6ba12..c92d780a77a61 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -42,8 +42,6 @@
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
 
-#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * 1000)
-
 /* Handle HCI Event packets */
 
 static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
-- 
2.53.0

