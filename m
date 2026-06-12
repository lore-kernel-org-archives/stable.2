Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1863093DD;
	Fri, 12 Jun 2026 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249765; cv=none; b=K0Z5ym7H7vVjmksO9w36xg6jGrDFHY2z5kdG5tdeaigyxA3+47kV7RjMn8jGmMA/qWOkmvHtJjK2BcZmdLlFxWlFhzWDkb5H7v9ATaEwLDYIdXDB3RpHmlK47O8WjzOp999/lImMir32y9YOwuHdmgHzBk0tuaZnNpIeM4g+JZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249765; c=relaxed/simple;
	bh=amWtrN9ebYHEFBhQNOxoiQaXTaktTxRaZK6iSH1pCGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/8D9tjGrpVViJ3127eE2YBjuVDxUMvhTvfdTut+mRLO/HKZKsU7CfXllKAQ/f0P3HWjbvlSOEFx/92ci7YZlgs1qSpSvymR1H2trej1/rDLEeb1by31p2PvgzTFHRmEXIQIXwNZUkyHLHdrvW39W9hli/g3/oE80uNs6dq05Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpHb8phY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpHb8phY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1AF1F000E9;
	Fri, 12 Jun 2026 07:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781249763;
	bh=kOX08Qpl3nLj8+/bGT7gMI+71ks0J39RDfqBI01e/bs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YpHb8phYvCXL//PMNv6jJibMmIvbuZmFBd81SZPjBSMR8ToRShtN3aXcZQR5xRGOF
	 5D1aoLZGabiAlDqIpuffzOCx97pcxQ9zSS0/JgxMXO0J1HfPqTEC0I21xlyTI22bSc
	 rD+sjQ6+hPGHfZzV1cRQjhR1zP4JNTPuaZ+xJ/FAeHV1xlSYiVsoxlMVjMqbpvaDCn
	 qXB2IXqiuMyKCLM/AHpVj7C5sVFvpbcSlfU8SBPVkLFWPROv5ffLzAAo4FsdEkp6Vv
	 GDjbVyismAzQ8Yj41kuEmLVoZ66puCR7NZaY5e7pk5iSCZXrGdKNdkltMZnHJIkraK
	 nd5WalUl+cWLw==
Message-ID: <09ee2ea0-c93f-406c-b5af-1fe3a50c8989@kernel.org>
Date: Fri, 12 Jun 2026 09:36:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup_test: fix race with PIN_LONGTERM_TEST ioctls
To: Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org,
 jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com,
 yang.lee@linux.alibaba.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260608025043.88087-1-cuiyunhui@bytedance.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260608025043.88087-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/26 04:50, Yunhui Cui wrote:
> The PIN_LONGTERM_TEST helpers keep their state in global variables that
> are protected by pin_longterm_test_mutex when accessed from ioctl().
> However, gup_test_release() calls pin_longterm_test_stop() without
> holding that mutex.
> 
> This can race with PIN_LONGTERM_TEST_STOP and let two callers operate on
> the same pages array concurrently, corrupting the test state and possibly
> freeing it twice:
> 
>  CPU 0                              CPU 1
>  -----                              -----
>  ioctl(PIN_LONGTERM_TEST_STOP)
>    mutex_lock(&pin_longterm_test_mutex)
>    pin_longterm_test_stop()
>      if (pin_longterm_test_pages)
>        kvfree(pin_longterm_test_pages)
> 
>                                     close()
>                                       gup_test_release()
>                                         pin_longterm_test_stop()
>                                           if (pin_longterm_test_pages)
>                                             kvfree(pin_longterm_test_pages)
> 
>      pin_longterm_test_pages = NULL
>    mutex_unlock(&pin_longterm_test_mutex)

Okay, thinking about this some more ...

I think what's really required here is that we have two separate "struct file",
because otherwise release() cannot race with unlocked_ioctl().

Which is something we didn't expect when we added this functionality.

I think the proper way to handle this is by moving the state to the
"struct file", to actually cleanly allow concurrent usage.

So instead, I think we should do the following (untested):

From 29e3d6fe00c4bd843d11bb548efa89bca478436c Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 12 Jun 2026 09:22:25 +0200
Subject: [PATCH] mm/gup_test: keep longterm pin state per file

The pin longterm test currently stores its data globally, shared among
multiple concurrent users of the interface (multiple open file
descriptors -> multiple "struct file"'s). That makes
the gup_test interface problematic to use concurrently: two users, such
as concurrent selftest runs, can interfere with the same longterm
pin state.

While this has not been observed as a problem so far in practice, let's
just handle it cleanly. There could be a way to trigger selftest
failures by e.g., running the cow.c and gup_longerm.c selftests
concurrently, but we usually run them sequentially. Let's add a "Fixes"
tag to be safe.

Fixes: c77369b437f9 ("mm/gup_test: start/stop/read functionality for PIN LONGTERM test")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup_test.c | 93 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 32 deletions(-)

diff --git a/mm/gup_test.c b/mm/gup_test.c
index 9dd48db897b9..16916056677e 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -8,6 +8,12 @@
 #include <linux/highmem.h>
 #include "gup_test.h"
 
+struct gup_test_data {
+	struct mutex longterm_mutex;
+	struct page **longterm_pages;
+	unsigned long longterm_nr_pages;
+};
+
 static void put_back_pages(unsigned int cmd, struct page **pages,
 			   unsigned long nr_pages, unsigned int gup_test_flags)
 {
@@ -204,23 +210,20 @@ static int __gup_test_ioctl(unsigned int cmd,
 	return ret;
 }
 
-static DEFINE_MUTEX(pin_longterm_test_mutex);
-static struct page **pin_longterm_test_pages;
-static unsigned long pin_longterm_test_nr_pages;
-
-static inline void pin_longterm_test_stop(void)
+static inline void pin_longterm_test_stop(struct gup_test_data *data)
 {
-	if (pin_longterm_test_pages) {
-		if (pin_longterm_test_nr_pages)
-			unpin_user_pages(pin_longterm_test_pages,
-					 pin_longterm_test_nr_pages);
-		kvfree(pin_longterm_test_pages);
-		pin_longterm_test_pages = NULL;
-		pin_longterm_test_nr_pages = 0;
+	if (data->longterm_pages) {
+		if (data->longterm_nr_pages)
+			unpin_user_pages(data->longterm_pages,
+					 data->longterm_nr_pages);
+		kvfree(data->longterm_pages);
+		data->longterm_pages = NULL;
+		data->longterm_nr_pages = 0;
 	}
 }
 
-static inline int pin_longterm_test_start(unsigned long arg)
+static inline int pin_longterm_test_start(struct gup_test_data *data,
+		unsigned long arg)
 {
 	long nr_pages, cur_pages, addr, remaining_pages;
 	int gup_flags = FOLL_LONGTERM;
@@ -229,7 +232,7 @@ static inline int pin_longterm_test_start(unsigned long arg)
 	int ret = 0;
 	bool fast;
 
-	if (pin_longterm_test_pages)
+	if (data->longterm_pages)
 		return -EINVAL;
 
 	if (copy_from_user(&args, (void __user *)arg, sizeof(args)))
@@ -259,12 +262,12 @@ static inline int pin_longterm_test_start(unsigned long arg)
 		return -EINTR;
 	}
 
-	pin_longterm_test_pages = pages;
-	pin_longterm_test_nr_pages = 0;
+	data->longterm_pages = pages;
+	data->longterm_nr_pages = 0;
 
-	while (nr_pages - pin_longterm_test_nr_pages) {
-		remaining_pages = nr_pages - pin_longterm_test_nr_pages;
-		addr = args.addr + pin_longterm_test_nr_pages * PAGE_SIZE;
+	while (nr_pages - data->longterm_nr_pages) {
+		remaining_pages = nr_pages - data->longterm_nr_pages;
+		addr = args.addr + data->longterm_nr_pages * PAGE_SIZE;
 
 		if (fast)
 			cur_pages = pin_user_pages_fast(addr, remaining_pages,
@@ -273,11 +276,11 @@ static inline int pin_longterm_test_start(unsigned long arg)
 			cur_pages = pin_user_pages(addr, remaining_pages,
 						   gup_flags, pages);
 		if (cur_pages < 0) {
-			pin_longterm_test_stop();
+			pin_longterm_test_stop(data);
 			ret = cur_pages;
 			break;
 		}
-		pin_longterm_test_nr_pages += cur_pages;
+		data->longterm_nr_pages += cur_pages;
 		pages += cur_pages;
 	}
 
@@ -286,19 +289,20 @@ static inline int pin_longterm_test_start(unsigned long arg)
 	return ret;
 }
 
-static inline int pin_longterm_test_read(unsigned long arg)
+static inline int pin_longterm_test_read(struct gup_test_data *data,
+		unsigned long arg)
 {
 	__u64 user_addr;
 	unsigned long i;
 
-	if (!pin_longterm_test_pages)
+	if (!data->longterm_pages)
 		return -EINVAL;
 
 	if (copy_from_user(&user_addr, (void __user *)arg, sizeof(user_addr)))
 		return -EFAULT;
 
-	for (i = 0; i < pin_longterm_test_nr_pages; i++) {
-		void *addr = kmap_local_page(pin_longterm_test_pages[i]);
+	for (i = 0; i < data->longterm_nr_pages; i++) {
+		void *addr = kmap_local_page(data->longterm_pages[i]);
 		unsigned long ret;
 
 		ret = copy_to_user((void __user *)(unsigned long)user_addr, addr,
@@ -314,25 +318,26 @@ static inline int pin_longterm_test_read(unsigned long arg)
 static long pin_longterm_test_ioctl(struct file *filep, unsigned int cmd,
 				    unsigned long arg)
 {
+	struct gup_test_data *data = filep->private_data;
 	int ret = -EINVAL;
 
-	if (mutex_lock_killable(&pin_longterm_test_mutex))
+	if (mutex_lock_killable(&data->longterm_mutex))
 		return -EINTR;
 
 	switch (cmd) {
 	case PIN_LONGTERM_TEST_START:
-		ret = pin_longterm_test_start(arg);
+		ret = pin_longterm_test_start(data, arg);
 		break;
 	case PIN_LONGTERM_TEST_STOP:
-		pin_longterm_test_stop();
+		pin_longterm_test_stop(data);
 		ret = 0;
 		break;
 	case PIN_LONGTERM_TEST_READ:
-		ret = pin_longterm_test_read(arg);
+		ret = pin_longterm_test_read(data, arg);
 		break;
 	}
 
-	mutex_unlock(&pin_longterm_test_mutex);
+	mutex_unlock(&data->longterm_mutex);
 	return ret;
 }
 
@@ -371,15 +376,39 @@ static long gup_test_ioctl(struct file *filep, unsigned int cmd,
 	return 0;
 }
 
+static int gup_test_open(struct inode *inode, struct file *file)
+{
+	struct gup_test_data *data;
+	int ret;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = nonseekable_open(inode, file);
+	if (ret) {
+		kfree(data);
+		return ret;
+	}
+
+	mutex_init(&data->longterm_mutex);
+	file->private_data = data;
+	return 0;
+}
+
 static int gup_test_release(struct inode *inode, struct file *file)
 {
-	pin_longterm_test_stop();
+	struct gup_test_data *data = file->private_data;
+
+	pin_longterm_test_stop(data);
+	kfree(data);
+	file->private_data = NULL;
 
 	return 0;
 }
 
 static const struct file_operations gup_test_fops = {
-	.open = nonseekable_open,
+	.open = gup_test_open,
 	.unlocked_ioctl = gup_test_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.release = gup_test_release,
-- 
2.43.0



Can you review+test that change? Thanks!

-- 
Cheers,

David
