Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010349;
	b=5fjZV4bJsiz/gbSqEy+aHQLYRR0uhevYxJqIeFWbXfqWobP+YDKsxPweZXIy5aQqCFQN
	 lBNCwvBz+1ObhHVSZHrrTa9y87YPZNpQ+x2ikpi0gtVJxtfVcbP6UQFtD5N2xb6hKV+le
	 yapPtcUoQOx/nvOtO/Dz6YvS8Ojfzvsppqvln20KvaESE5kgDSaIQj8EQFZFo1amOGdRM
	 xp/xuEDgvLHaX23gj/TQpfMTDrb8A5Zwq/3yowBsEAo5hIq4Sz7ob562CHKNmCjYkVeZm
	 YmJ4RjTsuIHJhXP7nrfU3UgCXphxbxcJQ76zGd8RMecW+uxPyTS4wEikaH1wlMmk4/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=Vz1UPedH0+TGS8xLCVVGdhuOe7MKQFOJiDEnzsXVMKs=;
	b=tX/fjTXz4wDsz2Hku9IX7pKoCT56Kr8Hfu81hewKMR0JNbmXwsyc4peD/35jplND3oYq
	 Ew2jik79k3y4Ato3/Xnc3Bb57YK+Hk9hcLYMk/ODJ1hs/a5cwM1LchwxzJu53nKTTwEOu
	 v9WIrNQ65yzMrKt7BlTvJNEiXH1IqMvbu8cG3KxquKGQEkAh2fwJWp5tWjXu3idwpnPbd
	 pjqxxfY5xQBvqYh/ocvh+H9Xg26rTWcAcY3SkCDAzu8pUVQ03qjDiVLYuzjIKrVFNOOTb
	 mXvD5wUhZZUS6Yu5418aBSbNCjRyFw/+hk+bEyiUPFwYN6b8RCQkHJ19wPUw+aZ4oTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=bJdHS4iy;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD4606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FCD4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=bJdHS4iy
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b546061d58so1351196c88.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795010348; x=1795615148; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vz1UPedH0+TGS8xLCVVGdhuOe7MKQFOJiDEnzsXVMKs=;
        b=bJdHS4iy7EEs1AOAGdLhJeBJep7ZlCshlKH/KOh5AGtjT5T6SASQGhy2BriV7XcUI6
         Ku+6rJfzZX2gKRjjFnH8Qo3YFaMmOB/6g+Zmes0Bo5eJvvKp2JPeKejLgX12hoeUIOoK
         +4+nnbpfMqOGI4w+5CLYFoX0t8aNkDCn/abxZXiycKLqVvM7WV4EMpyocTdeVeapC265
         /rYwO57+gxifyw5v00sImzGBTEpHtVnUG+3MaBNJHs3Jwprtyj/ChXydDGn8FkHyqKAB
         YKlYKCEgxvNMSepPl+mdaTWtbgfRaiTCurCSygm/CjlEloLyWRU5M3lC54Nn0hXddfyI
         qCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010348; x=1795615148;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vz1UPedH0+TGS8xLCVVGdhuOe7MKQFOJiDEnzsXVMKs=;
        b=xrlZCnnDz2sDHd1t+gbRS5dNNcPb5LsumjaW5/ZfXo5QTK3ToHttO8Xfk9gBEEPh3Y
         RMBdvD/2HY74azkXgzp0Wr+eVk9Wa5np6nBNZw3yNo8Ggr9tl+qdy7RG4GgyWsbb5HMA
         2IqGvEKPbT8GsWeHjl5mmAeYtbNCbeRdG/PAyTA1SYxACjmiyZmn0SX8nxmVb93EtChQ
         JGkgceV5W3vCyKBHAHNpQ2s82jbSZbQ98DnxAa+B4dmv4hEogMTAC7AmmYUn95BUJSaD
         niY19/eXkESw6krXUK76QjngeeIiL0nEHh8YtJbOxQ91oFX3uOPUYr/lq3oL+3fZTkAI
         BH4Q==
X-Gm-Message-State: APuU4Z+cs9x1yNPpegRruLrAw7wi8t/XTZXfqPxtFZY9nKEVXOM2gO5Q
	GNuIOdZ2fgJ4nbZ6MzAXtq7KEa5TCwfaZr8exetArNGhE+NQ+fuZNJfHMmaYreDSUFQoNOOQicA
	euQ8z
X-Gm-Gg: AYBFou2rI8vkbD092HJRNh6YJgiobPlbYh1S2ek3aRhuqoTRGm/PK2/B70SRNjGZKgM
	f4Pdc0Vv6YlZKM0aBDgQTdl0d7MDBlYSlUQUWCU1CilNXcT3OkgdLBOuFLhad0bSkL5pfng3Afh
	WkM0IamHGLzH+bj3g4iF+xRFjAXEXKjMQtbhNaYO0He8fLGn5iBDP75i8gPb7qcxVNjfL+7290d
	ui/WltITe3c6X+y9ooCc4DyQKq4m9ONHsyCrdZP5CDeYX9fiAoYV2EeiVUkHbRwyjvWm+d/bQM3
	3Udmndv+pa1OqD8ScZDLf/rjv+8RDg8BLf1/UlYkXZ++hcWhIgPlJpL6jnC+ETTBVVhIZyuJ/ly
	ycYnxOl239e7eSyN7iOXj5kmRDhkJW/BFcjwKBRuUtXLUXxRinXQmd5Zbbd4PiPWdU+bu6bKihP
	W9Ra987cysJyL8D58m60mhm6x4gQWBHWG28fW/PcEv+chIWkOMIahHgnGL1Yy9BueZEedstelon
	iLdHawZSeLkt2OPJvbUyYAYFLIfQQnMkUpY3rkqPJutmS/fMCdlnxN3LFwLlQXRIs76EBOW2Oni
	btSED+cJCXMPUcYUcBFFpA==
X-Received: by 2002:a05:7022:282:20b0:19b:39f4:88c9 with SMTP id a92af1059eb24-1b547c99c5cmr1240478c88.10.1795010347751;
        Wed, 18 Nov 2026 05:59:07 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447f468asm6780289c88.12.2026.11.18.05.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:59:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)no previous prototype for
 function
 'hub6_match_port' [-Werror,-Wmis...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 13:59:07 -0000
Message-ID: <179501034399.303994.1678108687169067517@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.18.y:

---
no previous prototype for function 'hub6_match_port' [-Werror,-Wmissing-prototypes] in drivers/tty/serial/8250/8250_hub6.o (drivers/tty/serial/8250/8250_hub6.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
drivers/tty/serial/8250/8250_hub6.c:44:6: error: no previous prototype for function 'hub6_match_port' [-Werror,-Wmissing-prototypes]
   44 | bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
      |      ^
  CC [M]  drivers/gpu/drm/tests/drm_kunit_helpers.o
drivers/tty/serial/8250/8250_hub6.c:44:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   44 | bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
      | ^
      | static 
drivers/tty/serial/8250/8250_hub6.c:50:12: error: no previous prototype for function 'serial8250_hub6_init' [-Werror,-Wmissing-prototypes]
   50 | int __init serial8250_hub6_init(void)
      |            ^
drivers/tty/serial/8250/8250_hub6.c:50:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   50 | int __init serial8250_hub6_init(void)
      | ^
      | static 
drivers/tty/serial/8250/8250_hub6.c:55:6: error: no previous prototype for function 'serial8250_hub6_exit' [-Werror,-Wmissing-prototypes]
   55 | void serial8250_hub6_exit(void)
      |      ^
drivers/tty/serial/8250/8250_hub6.c:55:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   55 | void serial8250_hub6_exit(void)
      | ^
      | static 
3 errors generated  CC [M]  drivers/reset/reset-scmi.o
.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:88b7d0ef2189a3c9daa96318c2969e40b2739f7f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  cdba173620176f2471d7dc1897b8a59fa7a85fcf

# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-6afd942599c74e1a997d450a/.config
- dashboard: https://d.kernelci.org/build/maestro:6afd942599c74e1a997d450a

#kernelci issue maestro:88b7d0ef2189a3c9daa96318c2969e40b2739f7f

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
