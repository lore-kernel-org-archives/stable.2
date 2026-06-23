Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F8A379EF9;
	Tue, 23 Jun 2026 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241225; cv=none; b=sUVAEXeXYuMRvfoiniWpWI05wmU/v8zPi4pX1EIt+5gtAgv72ymDec7As4LzKuysNfIvZPgtHqzzQtrY5XXkKB0c4NF886wRddHKaIGyJLlxfdQ6wPr/4iV23+7q9AgbzAu5o6wi9s/Xi03so+VYul4yJT411Xk+sxV5QqELkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241225; c=relaxed/simple;
	bh=qkVI+66ySHh/VJLWSUWHDLTMXjoCO6M9JklQK9GigjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BiCf3rGN7mQewJvtskJVRDqDkiNCySJRvFsIT4f4Vm16PscLrMiBc5FmZv4XIZdDK+naU4wtZFZ2vno51LcQCx2V7edW5ji6aTnTVh6lJCcCV1QLQtY6xrOLQJPpJfCycCeCFeBzg8l2sMsQ1j5CJLHU+WmGVRXnJeP7AG/f7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qhUdLBWG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qhUdLBWG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kTkgj1A7A3/RTp56IyQ1+o+NjRV/M3GC/dB4SlQ09nQ=; b=qhUdLBWGhZO7Hgb8mLOP44Ab/p
	8FWrRnC0Znoet/kS6BwnGbCg2VST8OYieHuabxV7+FiBNvuBblRZHBKVKY7MeyvO0sVUX5AlzsEOx
	dOjUHMGQEH2M6TyHF2vjtesfOQS1WJnH4f2xys9Ddb6h/pqQhfYUZCaiDr4WTqJYBrXHIvbQUSQZE
	Dllm4O+qmUEUA9wQ6+Plo3Cqu1vwB6ARdR7lHBvl7BPsCQI+Bccyhm3yLx5XKpqhEVefOUDYYDwDl
	7UqWM7W5vMa/7YuF6FZts4o/gS2XaygpE0fQdZjJgF0O/tzzrvIB313mggqPQvapYqkM0yU20KFU7
	0jsG5ckA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc6MB-00000006mPv-3sfg;
	Tue, 23 Jun 2026 19:00:23 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH] driver core: add missing kernel-doc for union members
Date: Tue, 23 Jun 2026 12:00:22 -0700
Message-ID: <20260623190023.407781-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The use of __SYSFS_FUNCTION_ALTERNATIVE() adds an anonymous union (or
struct if CONFIG_CFI=y).*

Describe the additional struct/union members to avoid docs build
warnings.

Warning: include/linux/device.h:117 struct member 'show_const' not described in 'device_attribute'
Warning: include/linux/device.h:117 struct member 'store_const' not described in 'device_attribute'

*: kernel-doc ignores CONFIG_ symbols in source files; it is using the
first definition of __SYSFS_FUNCTION_ALTERNATIVE(), which is struct
instead of union.

Fixes: 434506b86a6c ("driver core: Allow the constification of device attributes")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Thomas Weißschuh <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org

 include/linux/device.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20260619.orig/include/linux/device.h
+++ linux-next-20260619/include/linux/device.h
@@ -99,7 +99,9 @@ struct device_type {
  * struct device_attribute - Interface for exporting device attributes.
  * @attr: sysfs attribute definition.
  * @show: Show handler.
+ * @show_const: Show handler (read-only).
  * @store: Store handler.
+ * @store_const: Store handler (read-only).
  */
 struct device_attribute {
 	struct attribute	attr;
