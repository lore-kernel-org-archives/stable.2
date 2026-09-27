Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412B3BE15F
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540980; cv=none; b=IQ4zgKDEA9V51T0NiK0EnILH/dF4ZqQgUSeKOPO9y2UlizwWvjvAZEzLSO9jV6VyxEIGs1Rn5wRAA2VIiMHD4YTWl9MN0FcoSjjtU8D7F4hjbIAl0Op7OmVt79hgBS/4gImkfiSlor6oSHmo2VeR/yQzc8VEsBzoAKz/iSHynRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540980; c=relaxed/simple;
	bh=CCSZzO/knQUMn7bP6cifPp5sPoP3MnpUcM2KLsQ4hTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6Y0xfbdoY+evGX8GalfO0Gxfa1J0ltuleAZg8QdsWqvlud9muGo5+irMS+cq6fE79ntw+JW5KIkOp/Azcjd2dYs/u+IV80APpkPlWukUrsheER6V3rhy/LbyYTfcidfT4K8KLjraL335RCPR6hSAMPyZUaI7uy0CtWB1wBSFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa1A5lL/; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa1A5lL/"
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-79022baa364so601786137.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790540978; x=1791145778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nl+pDpZ/zHEX5u9H3JLRFmOZ4xMUKm7NbKCyuVe6wcs=;
        b=Qa1A5lL/bFiKN6iaDGTe4r6KxGww6TpfZj/cQ5DziMUclzHIYKW5Tna/LeokUljeov
         +r2+AYsRsRjnL3HHvBqrtyYPh7nw+8PJDhneztbPEvCOeg+K0koKayfTG+aqST2U04ws
         a1V3s5qTGY8kDwUf/4bFA92hIb7vYv0U4bIMUiCRgqAjifsRW9CDYj/2NYdoEYsy88KC
         6Rx98QOxBUkEbWVZZglVfbgnXni+L7XYj2Ps9xcni7QyCQZPY8FDafTSiyGbvEhtzspe
         qDO1RJcWykkwmy80527eLyWCFrAry86DE5/S6HfVZmJwSBS6Yb0ZtcsMAMdzjfPVL0Ol
         Xzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790540978; x=1791145778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nl+pDpZ/zHEX5u9H3JLRFmOZ4xMUKm7NbKCyuVe6wcs=;
        b=sQjHch1997YPhJH5lBRfmOtvKGCnMFcfnVC3eOk0YV4jFho224ay4Ba+h4ZEV8d5dl
         to+oRU6Zpu31tkk3qxtUArUqJRTXnUqaGQKiBB5E0N4rLPfPiuBzikjsXJAd0WnY1DUf
         xHjEgipQf51T85OUv95KTMuIyDaN9HYgPdHl5/W9fCF0BhiXS2l1QTEHwhmv/D4cKZkp
         427qpN30R0C7NZExoOpFoAB0y1Aa0hfM1MC4kijHw4naqMXE4aKG3RapyWp+ExZk5cwi
         jXLNQl+w40QkQ/hoO6PN4+30di4FRuvMiLPY9xKjoiCKbN3FwzzuYOOmO88XzdyPn/JC
         R5Wg==
X-Forwarded-Encrypted: i=1; AKwUvBzzWxFdGPSQjFo7rVT+oYikgwX0+MXFYzMNpioPIR6Ifa0s5L1xtfQBjE8qyW8wAACNNbTggLI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPn96A8Ch4tHGKRNprvMnsp6QOvwU1zFzAQsbaEi9hgb0Nu3RP
	+0/XxCA/n78yzH4ORun8vQVAUmTxD0y0Slk73HkmRAXUwtw72V3rDx6nSVeYJkkq
X-Gm-Gg: AYBFou0Vksr3428bW858VfYe1TOmIIh94ThPF1p2QphZrevz6fFmCGRWviu9vPoRfKN
	GbecrpjZz5cmb7kgprivlUZHNI4DYRW+9XG0auhRNvE5GPBKGIxJcm7MFHWOqM+TIQeVN6c8KUR
	lf/VWTGKTBBn7YtS9lTZB9ZOGKvAi5YwrrFXwdFpQ+JUDM0q6c1FkK4yQZrMV7tPHUNz7uWpN0Z
	zbauetzkRu8jwy4IpR5mmmf5toCNCXZEw5+MQ6xwmASyNCD/V2OCuRlvqRo3OL15kKKuWEsXAAh
	W/gRlOFWxDpOoWhclALcFSIoKPDYj8jDVua0yefkymFAFS52PeDiEMO/Bxt0STTNPXKvSJBqowe
	lt/gsfuP2G95+Ifwx02kI7EexSfUpWDxgwfP/IEKTCFBl3oP+RT4Co1zTJYaozKQ9E3+MrrUdOS
	op/fQ5ofQmSCDLZrEGpJdUFLuWGUKVFEPESqRQSz6suHUoZ9REXDF9qRJxBRGsOEU=
X-Received: by 2002:a05:6102:3f47:b0:798:24e8:23f4 with SMTP id ada2fe7eead31-7af1cfa46e2mr3382979137.7.1790540977704;
        Sun, 27 Sep 2026 13:29:37 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b9af306sm6791391137.9.2026.09.27.13.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 13:29:37 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: johan@kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH v2 0/2] debugfs: fix UAF and double-free in debugfs_str read/write
Date: Sun, 27 Sep 2026 17:29:27 -0300
Message-ID: <20260927202927.2059816-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026092726-posh-handyman-43a0@gregkh>
References: <2026092726-posh-handyman-43a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Sep 27, 2026 at 06:34:44PM +0200, Greg Kroah-Hartman wrote:
> No LLM was used to generate the patch?
> Again, no LLM for all of this?

I did use Claude Code during the process, but I want to be precise
about how. It did not find the bug, produce the analysis, or generate
the patch for me. sashiko.dev originally pointed out the missing RCU
protection on the read side. I then manually traced the pointer
lifetime and the write path, where I found the concurrent-writer double-free.
I used Claude Code only as an additional reviewer for spelling and grammar,
minor rewording, formatting, and as a sanity check for obvious mistakes.
I wrote the patch and changelog myself, and the technical analysis,
implementation, KASAN testing, reproducer, and verification were all done by me.
Given that limited use, would you still prefer that I add an Assisted-by
tag for the LLM in the next revision? I want to make sure I disclose the
tooling correctly without attributing technical work that it did not actually contribute.

My background is security research -- I spend most of my time auditing
code for memory safety issues and race conditions, among other things,
which is how I ended up looking at this code after sashiko flagged the
missing RCU protection.

> I'd like to see the userspace test scripts for this...

Sure. Below is the reproducer I used.

Result without fix: ~3900 "BUG: KASAN: double-free in
debugfs_write_file_str" on 7.3-rc4.
Result with fix: 0 reports.

In-tree callers of debugfs_create_str() with writable files
(vulnerable to the double-free):

  drivers/interconnect/debugfs-client.c:165  src_node (0600)
  drivers/interconnect/debugfs-client.c:166  dst_node (0600)
  drivers/soundwire/debugfs.c:361            firmware_file (0200)

Read-only callers (drivers/opp, sound/soc/sof, arm_scmi, i915) are
exposed to the read-path UAF but not the double-free.

== debugfs_race.c (kernel module) ==

// SPDX-License-Identifier: GPL-2.0
#include <linux/module.h>
#include <linux/debugfs.h>
#include <linux/slab.h>

static struct dentry *dir;
static char *test_str;

static int __init race_init(void)
{
	test_str = kstrdup("initial_value_1234567890", GFP_KERNEL);
	if (!test_str)
		return -ENOMEM;
	dir = debugfs_create_dir("str_race", NULL);
	debugfs_create_str("test", 0666, dir, &test_str);
	pr_info("debugfs_race: /sys/kernel/debug/str_race/test created\n");
	return 0;
}

static void __exit race_exit(void)
{
	debugfs_remove_recursive(dir);
	kfree(test_str);
}

module_init(race_init);
module_exit(race_exit);
MODULE_LICENSE("GPL");

== poc.c (userspace reproducer, gcc -O2 -pthread -o poc poc.c) ==

#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <pthread.h>
#include <sched.h>

#define PATH "/sys/kernel/debug/str_race/test"
#define ITERS 5000

static volatile int go;

static void *reader_fn(void *arg)
{
	char buf[512];
	int fd = open(PATH, O_RDONLY);
	if (fd < 0) return NULL;
	while (!go) sched_yield();
	for (int i = 0; i < ITERS; i++) {
		lseek(fd, 0, SEEK_SET);
		read(fd, buf, sizeof(buf));
	}
	close(fd);
	return NULL;
}

static void *writer_fn(void *arg)
{
	int fd = open(PATH, O_WRONLY);
	if (fd < 0) return NULL;
	while (!go) sched_yield();
	for (int i = 0; i < ITERS; i++) {
		lseek(fd, 0, SEEK_SET);
		write(fd, "AAAAAAAAAAAAAAAA", 16);
	}
	close(fd);
	return NULL;
}

int main(void)
{
	pthread_t t[16];
	int i, n;

	if (access(PATH, F_OK) != 0) {
		fprintf(stderr, "Load debugfs_race.ko first.\n");
		return 1;
	}

	/* readers vs writers */
	go = 0; n = 0;
	for (i = 0; i < 4; i++) pthread_create(&t[n++], NULL, reader_fn, NULL);
	for (i = 0; i < 4; i++) pthread_create(&t[n++], NULL, writer_fn, NULL);
	go = 1;
	for (i = 0; i < n; i++) pthread_join(t[i], NULL);

	/* writers vs writers */
	go = 0; n = 0;
	for (i = 0; i < 8; i++) pthread_create(&t[n++], NULL, writer_fn, NULL);
	go = 1;
	for (i = 0; i < n; i++) pthread_join(t[i], NULL);

	printf("Done. Check: dmesg | grep KASAN\n");
	return 0;
}

== Makefile ==

KDIR ?= /lib/modules/$(shell uname -r)/build
obj-m += debugfs_race.o
all: modules poc
modules:
	$(MAKE) -C $(KDIR) M=$(CURDIR) modules
poc: poc.c
	gcc -O2 -pthread -o poc poc.c
clean:
	$(MAKE) -C $(KDIR) M=$(CURDIR) clean
	rm -f poc

thanks,
Aldo
