Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0837364934;
	Tue, 29 Sep 2026 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672921; cv=none; b=gMmJu/gAQgttAYSpyfqLlj/nyJnWzjK3gKIqMRHuoERtVE6qWws8Iw2yZE+e1Hpi4Y9EsxCSgAQaQBTGvM+WIXyDS0ZZbXPFVe9IVx55LWQA4JtjGxsaJEvUJmOaZktxw8C7jM1spx4+79CR0iAjyUQzKIPE25jyBKFjC0HHHxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672921; c=relaxed/simple;
	bh=1g83vwHJltCchie8t3rXHaZdg7X0y5e0q9lsCigSAn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9TVTWBEDPbO4hcG5n7Joyej15lS0/9BklQI/mg0MEzOIFv2AjKWiNs1JaVD57xjYQISKcmfs0jDaWfHMOjmPe1EWRibyMLDDD2axX3/VW9TVr2sfgcZGevW+2NS/fxNeezcyHccQLhCVhBH+CRo5ymKYZqhJL7wdUswR5VeowM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcmNacoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcmNacoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ED61F000FF;
	Tue, 29 Sep 2026 09:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790672907;
	bh=CrPP4KJ8clJ2xAMmvhPYeN3J++n4GNG3VWolDtFI/Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IcmNacoCqlhuGB+Hi2KBFFYWkvH6v+FVm+tR7rSmMlZ+rlgnziM77UHxpbvvFV+vG
	 NK5uMoEx8OqCASmyLibYgF5cVe0WmRciNaqvzouLkmsKHw0lrt5ZQDSIl+73JawesO
	 7+liM7VexvLd1V/YDoDxUv9Yv65ODi7112nXkqOXE2rai2184pQQ4rjps/z4GVTnQS
	 kGO0l42iJorjqHMfKymTLbWKdvpIAPu8mE7Y0jr22r58oNRQVa1Pw15TH1gN6yoP9R
	 Ob5BAa2peFL7tYj+2wHZy1CwfGDw3jw87ydaSafBQ4t6VagTfyc61p94vMZRWZe9Ai
	 z9N9vWFFMBuOw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wentao Guan <guanwentao@uniontech.com>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [STABLE v5.15.y v2 2/9] file: add fput() cleanup helper
Date: Tue, 29 Sep 2026 09:07:09 +0000
Message-ID: <20260929090724.1461557-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260929090724.1461557-1-lee@kernel.org>
References: <20260929090724.1461557-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 257b1c2c78c25643526609dee0c15f1544eb3252 ]

Add a simple helper to put a file reference.

Link: https://lore.kernel.org/r/20240719-work-mount-namespace-v1-4-834113cab0d2@kernel.org
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit ac275934626a85285cca43405e876566daa10533)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/linux/file.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/file.h b/include/linux/file.h
index 6726240b9279..fb8a5d22531e 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -11,6 +11,7 @@
 #include <linux/posix_types.h>
 #include <linux/errno.h>
 #include <linux/cleanup.h>
+#include <linux/err.h>
 
 struct file;
 
@@ -95,6 +96,7 @@ extern void put_unused_fd(unsigned int fd);
 
 DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
 	     get_unused_fd_flags(flags), unsigned flags)
+DEFINE_FREE(fput, struct file *, if (!IS_ERR_OR_NULL(_T)) fput(_T))
 
 extern void fd_install(unsigned int fd, struct file *file);
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

