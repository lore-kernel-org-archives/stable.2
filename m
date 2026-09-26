Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B58282F01
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430495; cv=none; b=FhWD5D5JGVP9YJnaLKToTJ4UpE1H1mUyveL6LvqIupH91wMo714Px1vqkVxBstXUw21SSZhDt7ehtFKNohCaXoOmX0CphqSSWa8mFztei0TYiuoIOT78Ay/vq2d6qemyz1cSqOlZvU9xWFqP3PuQkyv8ou8hB/5FXHDXZvJ6KlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430495; c=relaxed/simple;
	bh=1xYbUdXV7FvMye4KYEHySxDka/b394+z600N3+jHXQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWjk636l5qDqldE1DTQ7GZUYa8umXZ2+eQ4BLGDHXRAsW7RmRa1mQr6CVkeXN2yClUnYYYw4DcCk9i09wvbx1mfXmmI8PzV/+s7W5JOBkUYQmgZxS9warXXpSVa9fqeforsfqbsF7i2RuG7wkmJbLNfjgCJw3WKwxzOgjBZZN8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFuS0aPO; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFuS0aPO"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so1473289c88.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790430493; x=1791035293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/CjzGFPtBoeNrX1CeVRPuIgYs0oHZqoIr7E47CqmV3c=;
        b=WFuS0aPO/WgGOzLSMb0+RzJhKToYvCw1mcuE5O4raBGfbQKEhDx56NlZvGnLohhYBk
         wV8YaUEwqnaPCHEuTYSC4R7Y5MtKu15KtKRYpki9jh4OLj6cYTEG7ZvQ2ilCbFyt3FJY
         GVzWw7ijlgrkY6Bv/ozD6FO4lfzi81SgfdapXp4qnAqsdLOq0NLxIVq6/IUHn3mE2X62
         qq/5uNaYJlj6LUNtM1gu1VX+ytBAwJupQvO/W5CUvh58o5iwFs5x0aG4ZV/UdTKFi7CK
         /xPq4Rb/mCBi7ujgosPWT29OdKymTzrUTgxezTS8TQI+5Weo/4Yo5eAvUuIC0VElmcnx
         /kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790430493; x=1791035293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/CjzGFPtBoeNrX1CeVRPuIgYs0oHZqoIr7E47CqmV3c=;
        b=WdX5hcC5loAO0sks8K3wwpGhcGYtPQzswhfRQ6VgsDYkqe9QJgdwcdSLZbvpuyMvcr
         phTXX7rLrCacYjniF3tSl8CWPI1L1Kzp2sHO10SeFgTqNFWZjOR/gLMdA+s7QMFNn97o
         VpsR1kKuNv0yQ/daHejO1cL6v+v/4agZ81750PywU5pYJsAm9bBu/Tvyzevcr/kgN6Wn
         LV+O09wR0pmgi2Z3c6VRgECJRxiPiU59XTLfuJ1ItXC6ni+DbymWwbfw8Idmb4+gHSEc
         9/Ej4F9eU8+P3shiqL9sIUOkZ3Xre+pVoEDiKG2HZ5WU/rccuckaotQBXqsROa5k94Hs
         celg==
X-Forwarded-Encrypted: i=1; AKwUvBzF2l3oUsVeNIW+EozbAx/poFcLEasRf2ovtvSLTUrM5G7SJe84vJ6sT0yBEo0ROkz/IACb8p0=@vger.kernel.org
X-Gm-Message-State: AFuF++lBbaqoQSCc2YQJlGOqnz4xyOxAcLwgRrH0DM8bIZYKmDa/uQey
	R32ROlqPS0YDsTwqbstqF63I9R/Hq0MCP1rv/m6ST/5/6L02/6mPwcP1
X-Gm-Gg: AYBFou3bfu8e8POuj4k8oYdMaPHLdUYawWwvFfZCTzIpQW96jj+8M83vfqZ/gHqqxZR
	Wk/6EmWtdbSrmLFOKnucJN6BUIQfGx3HoWK2L44i/8xw+CeZF5jShJYCNgvGtHSokJLvCO9zQEP
	Zq+0HcLPCIkWc6/dnhfjCTvyku1JmctDqRlGt9n2ZSJxzb9g1ikB4QGFLjspTbqOcgLOnjYs1l+
	G0efh2IQq01oLn4OuZOPhnJ6d2/RYcoaQzqNi44k0N2lID4vzbPjlX7Fc6PynTOBSjIM4FaEVTX
	xXvhNH1GiwxeUf5seBydnWnoyxu9Qe89dODslwfO12RUaD1VYeGPrW+5iqLRqgSbJDoHC21Tkri
	fv0spic5Iy8givURev3JaXgl0m1W+b08CAfED5K3rlKKzAJoNth1FYJnrH9yGr7KpONCbyv0ep9
	hCo23kC/RxiowjGCxpRSKlq26gYrj1SKWRJqaXdf0sCN5z9YREg/JnMbDkdi3EhmU=
X-Received: by 2002:a05:701b:220a:b0:13d:a49:8016 with SMTP id a92af1059eb24-146cfcd815fmr4165897c88.22.1790430492565;
        Sat, 26 Sep 2026 06:48:12 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acd3d8eesm12124325c88.8.2026.09.26.06.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 06:48:12 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	"sashiko . dev" <sashiko-bot@kernel.org>
Subject: [PATCH v2 1/2] debugfs: fix use-after-free in debugfs_read_file_str()
Date: Sat, 26 Sep 2026 10:47:38 -0300
Message-ID: <20260926134738.1063158-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026092647-ebony-unlatch-d3d0@gregkh>
References: <2026092647-ebony-unlatch-d3d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debugfs_write_file_str() publishes a new string pointer via
rcu_assign_pointer(), waits for a grace period with synchronize_rcu(),
then frees the old string.

debugfs_read_file_str() dereferences file->private_data without holding
an RCU read-side critical section: it loads the pointer, calls strlen()
on it, and then copies the string.  If a concurrent writer completes
synchronize_rcu() and kfree()s the old string between the load and the
use, the reader accesses freed memory.

Fix by wrapping the pointer dereference and copy inside
rcu_read_lock()/rcu_read_unlock(), using rcu_dereference() to annotate
the load.  Switch to kmemdup() with GFP_ATOMIC so the allocation stays
within the RCU critical section.

Tested on QEMU/KVM (7.3.0-rc4 + KASAN).  While KASAN did not
independently confirm this particular race window (it is a very narrow
reader-side window), the companion double-free in the write path
confirms that the RCU synchronization in this file is incomplete (see
patch 2/2).

Cc: stable@vger.kernel.org
Assisted-by: sashiko.dev <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 fs/debugfs/file.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1b3ace467777..a4b7a5cb5e01 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1019,30 +1019,24 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 {
 	struct dentry *dentry = F_DENTRY(file);
-	char *str, *copy = NULL;
-	int copy_len, len;
+	char *str, *copy;
+	int len;
 	ssize_t ret;

 	ret = debugfs_file_get(dentry);
 	if (unlikely(ret))
 		return ret;

-	str = *(char **)file->private_data;
+	rcu_read_lock();
+	str = rcu_dereference(*(char __rcu **)file->private_data);
 	len = strlen(str) + 1;
-	copy = kmalloc(len, GFP_KERNEL);
-	if (!copy) {
-		debugfs_file_put(dentry);
-		return -ENOMEM;
-	}
-
-	copy_len = strscpy(copy, str, len);
-	debugfs_file_put(dentry);
-	if (copy_len < 0) {
-		kfree(copy);
-		return copy_len;
-	}
+	copy = kmemdup(str, len, GFP_ATOMIC);
+	rcu_read_unlock();

-	copy[copy_len] = '\n';
+	debugfs_file_put(dentry);
+	if (!copy)
+		return -ENOMEM;

+	copy[len - 1] = '\n';
 	ret = simple_read_from_buffer(user_buf, count, ppos, copy, len);
 	kfree(copy);
-
 	return ret;
 }
--
2.43.0
