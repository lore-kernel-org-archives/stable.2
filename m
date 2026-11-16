Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855551;
	b=ugmr9JeMxbAyuqNNMVSk2+rn0gFZzngkhAro3wpmMaBFtHWjf8FLXVl9ONmhid+mHb1j
	 6KG29nMrOjJqiJLnmamv/OY7OhAEm1CBCgy7vNrGAOKWGcex2hevYVAxAoVzu+TcBUXiG
	 gWgHZRjRjb2pdS9FAzVSmYVRqdhOiEPHoeEHTiTJHoO0YVI9z8ONHrSgC3wRlKAK6iwaW
	 oJ6xTbqUgspq4XsBzFEFza1PrKYovjPfGbKm1qJA/nWjOgrDWXuqFN5sYqdXiebjX1YVE
	 NIPyUtX4vKaOwRJSlxr4jI+mr3R9zHtucTeC65jn2G6QLVKqMKFu7gcGBRoKlRhMsxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=FLUneRkbL+qJHf1VZuu9bxsENbkqNAwFUbMkZM+yZ/Y=;
	b=la2MRHcy/hrJMcCdFiFsnx+j9GR0L+Ipy+m2MIgrBDDWY7+VgdYACB+mZoo5HeUbzgts
	 nuT7DXL94m0qDZMMpLpwaZdDRkSjyqz4rFwuShWHz6Nu6RSdlwz4ZAKM9l8UeOeB/njCc
	 V2VfdXrtTZKCuXugJ/6j7JvuJMvL85TSDEsH+xmAF+OUtqJ8Y737VGH8rWON2wpFXOGeO
	 a4b7utHqv7sspqCgZHTLxp1z7u2bJUBj7H3gmC9WUU1nPoXgAy1MzuzmeCdK5dccVAsxJ
	 Mn+JrAbfmhXIVfh5DMPo5LlM5oz8TGxwmUqm/5xs2aXf51UQU3UUeGc5dckw33vpnVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b="L+vgXc/c";
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA0606A8A5
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0AA0606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=L+vgXc/c
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a8cc11ac42so3739450c88.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794855547; x=1795460347; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FLUneRkbL+qJHf1VZuu9bxsENbkqNAwFUbMkZM+yZ/Y=;
        b=L+vgXc/c95YQR+K/Kg5grwP4tcPnrRSFG+rEtojk1Jsb7CvY3myZz5MSkHhYdXxZB4
         Ne8TROq92ec6L2ByrCswFbrzGkMflSDBUChVRpaUiCmDvQfWA6lJVdeX8khK6Kih2a5p
         TwMMqNo1+XhfJSxxa1oR5cTvpjzrjZ+ERhsN9hoI2OsafI38qZumDUw2dN+9PFH0cl/R
         GvQdV0WGE+HJ4sY0V7MFXj37Y4Camh7n5qpPy3pr/uva9pvUaYMico7HzsnuDdBJxcjd
         sgDIE1StkjgBcLH2vNmA794IbNoK/9umU6RdcrLQbqo7RcbBATHXGM4Y4ZyC2N+YtaUx
         JmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855547; x=1795460347;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLUneRkbL+qJHf1VZuu9bxsENbkqNAwFUbMkZM+yZ/Y=;
        b=VlOwKt+JxmEIvzzfTTuGTZROvAqcCZiNfad9rWA89hrA780e0dSwntHObXaZeXaFjZ
         UoPBFwoRe5tsJ3HLx8Ko5jS/AdAWzNiZ5kl084SxaopRuGtYDQFbFAzBcii31wmQ/Ewy
         nrcidFJ8kCiMLxSiqOSzA9jMefuISEjdGGwSme0TYg/MqLki/8T78VYHOOrM5WUh4G5m
         44YvcnxzwTkTnIWnH8Brp96qBGNEZzm9MDuze9qcx5rkRQKtQ+jNFeTuzeMHq/LQ7esc
         QHlkK9MuFTKCP21GhqLEqof8R2wiL+XHXd19iWRXAqa03J/eNu5303WT8RbMfhFEz6OO
         S0VA==
X-Gm-Message-State: APuU4Z+z6CtkJy/oARjO2R0XIINSvfU1gA1zuqYAe3YdanZY/Jx19HKV
	SKylb6fi27lFIqSMQE2k1JVxFO/ysAoOcvWuHbnzzP8I8Jvdqz7ozVP8HEWyPLmR4UKQus2JwRu
	Jr8fe
X-Gm-Gg: AYBFou1/elBdzhNzAPFdjpFf6deAJLAqZh3+Hjw9UgiQiQJnUcf/U2KykxluicEkfLz
	aJ0VpI7PObf1xgQoVrqM938v76fOLYlSyqA9zaUDE7ksi+VplZKyGt2TTGJtEHVnPXB0SBKox+T
	RtNqCtR4SHAHPKaXnjPjUcABQM8UEl3IcRs1+kBqbq1cRqKRex0/ZAyzVUdWwfJrYVMqy8KJcPu
	CoE+4wAsZdYpm7rJVe9McN5uDCWZtsN/35HialIur0EvuM7kiRj4ArpfD5RIG5XF7WCAnP8U4ot
	d7jQlLAb2Ny8bNoAAINqZizeMWohs2OEvu/C+w5h99tm6d1kr0vx5u1BZDQFqzSwAlElDTCYLRp
	lhcd3vFxsrUrynwRYjZQpYBhF3LILEtv+epot87t0vY6uXo9nOecr7tBvus9tnnLq0u2ZbSi75o
	/iIzu5wNztyK2KjLZwn4hN98v1Gm89G+33VMy4XOelgUOykLvW37sIIwFBh6FQPizZRejfddiiT
	zj+tfthWwFrmZMgxRopRP1G1zldVT7yXUv1VM/LEaZGnbNMbR/41Yfb/wVhfsQVhoB5uC/mkmBz
	y2b42h4HvEc6qOILh1g8mg==
X-Received: by 2002:a05:7022:41:b0:1b3:abd2:2eb2 with SMTP id a92af1059eb24-1b5030d521dmr12898648c88.10.1794855546720;
        Mon, 16 Nov 2026 10:59:06 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm30409996c88.7.2026.11.16.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:59:05 -0800 (PST)
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
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-7=2E3=2Ey=3A_=28build=29/tmp/kci/?=
 =?utf-8?q?linux/include/linux/mmap=5Flock=2Eh=3A604=3A25=3A_error=3A_?=
 =?utf-8?q?=E2=80=98struct_mm=5F=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 16 Nov 2026 18:59:05 -0000
Message-ID: <179485554520.208229.11749221775995021420@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-7.3.y:

---
/tmp/kci/linux/include/linux/mmap_lock.h:604:25: error: ‘struct mm_struct’ has no member named ‘mm_lock_seq’ in arch/arm/kernel/asm-offsets.s (arch/arm/kernel/asm-offsets.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from /tmp/kci/linux/arch/arm/kernel/asm-offsets.c:12:
/tmp/kci/linux/include/linux/mmap_lock.h: In function ‘vma_end_write_all’:
/tmp/kci/linux/include/linux/mmap_lock.h:604:25: error: ‘struct mm_struct’ has no member named ‘mm_lock_seq’
  604 |         if (unlikely(!mm->mm_lock_seq.sequence))
      |                         ^~
/tmp/kci/linux/include/linux/compiler.h:77:45: note: in definition of macro ‘unlikely’
   77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:32ca5ce7d28f723d8a6b1b017d5e27539ef78cd1
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  2a640ccd9d0b0927413e9778fa8970767b7d97d5

# Builds where the incident occurred:

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afb3c5699c74e1a99619167

#kernelci issue maestro:32ca5ce7d28f723d8a6b1b017d5e27539ef78cd1

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
