Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206750;
	b=ng8UVDSUyAmEX9gfDqUG/BjK7AOv9aLpfk0O5DVnUHe8a0+d01qYonc2RT+CxTXamOrU
	 iYqrNztQdHcUWhPE2OGrm0amcod4B+bexjVcjzXu0bFJhJL35wkesrzEeV2TY+lPVHF3I
	 uNojNqCgz1TAsDlgGq4AjBAq5RU6jd/CxxDyQ2o1exARRxWvcziAow0dwFrUSs7EXGqap
	 CDO3UN3BZwUR+4H43lPf5+Ghw2+smBcn1JBTW7i8F5h7cxgYoW9dtRfqt9R082XHUxLW2
	 epVae8OgtToflLQphYXO1k/QmwN4nXNXa0zKMIa7nnnfMTKqDyidl6SE3vhQouSPXJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=ORywBDHhQh6y9AtzRcI52rOL4WgidQtLFbKA4yI6us4=;
	b=LZHSlpcjdym3x9E5WXSaahBr7W4PjHJdI5LY828odUIeVTQbVVm1pGdb0aoVOaZH+HGo
	 12gOeaWNCvQBwWrSeWmdVWJ3HS3k2svtuqJ1WPMbHX5h5Q3sizbKL5ZYN5XrqPA7EgUer
	 dHymZnbvSUVtnFVfQ7QYtbZfs5fgpz3EnPcqYFdYpGvDfy05xO/o+0eR6Rb5tWzerDpAz
	 +UVfm0xKWH0B28ip+bLm4F5g8BksMBXYQqlWvwByBOqjW0wCPvKikfOSCQZmxzOmaKalZ
	 gskug7+EtZuWxmtmFFGqiyq7ZrRIoZs7RQ+h4eNEA2WjeEe/DCgqn6n9vFnHl7YKLSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Ki0zcDD2;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A735E606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A735E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Ki0zcDD2
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a17a332ecso1648085eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793206749; x=1793811549; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ORywBDHhQh6y9AtzRcI52rOL4WgidQtLFbKA4yI6us4=;
        b=Ki0zcDD2Oe66XI2Rx+Rku5JZUv8J15oKqj1qH5Zx9Yym+QkgWiu0Oi9bskbXt3g4oN
         uzmUuf6cdiQTk6IoCYJUwygGJaIXvq2V4NH5ffK8++2ScKQjDFFjV72RCUsYA6l7xj0A
         i17SOP8EgcQDtr6KwBNSriTAdTSxD9IwfqeCEImHvcmHOxwzPvHBRyfNR3Snd8NGazjT
         2QdmCQG1H82wj2v5PXkQjuJLh8MWpT6MxC7k3N9FAdlZ/dNJo3aNzYiP+JRQs3IJJeqm
         tLcjBCDbgiF1s80mXTucRL2V20/SHaKN4Jo93QrFYkTxUgh7WpLZB74ibYXLpKGMox4V
         gQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206749; x=1793811549;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ORywBDHhQh6y9AtzRcI52rOL4WgidQtLFbKA4yI6us4=;
        b=LTNcNLUHZeXzLEZlwq3solcsLNSVshxlEuVuEc2aJW95fyboOq22O2RxdkOJ8j+5Jq
         dAsnzX5bHh5vdMrH6g/uAQPbu+tdfQNoihfgmRGCic/tT0HHFVAqL+Ve6ck3z0yDYMwS
         Tg92bK3tDO7CMumow5LAAvr14ButkurTAkl0J1moCJCnXyxglf453SlwsngBXyGJd/LU
         6WjsuYTwwBY9QxQ2fFOgclXnWWFo9hIcoEzNOhhc/yb/IphGcWs9Ca8UdjqBbv2e1zbR
         ybzuTchouM8uLj5eVIQIAW1kS53BnQApUZ5fupMY7LuQ0LI6MBaA9JUU03fqYlOvTg42
         TSXw==
X-Gm-Message-State: AFq9FYIiM9X2PMZ2rXxYHnGeI478OMeFtgZpN9o55oEZiGYk5AD6OEk7
	jXz+zFk8DBusFLote4uUvQY3YZ+pZxGXIFGVcMNfbnSIhNW8aNhysZcc7ANdaAHKziNbfVIn01m
	T5XLy
X-Gm-Gg: AYBFou3IZwBVyTtmza1s+zss63mpgmIPGmD201dK7VPV0iU5LSqv2k+y1aX8r3WtaSG
	SrOwOtjAzfTW7PV1RARG6SG5yArYiz3CVJevoY/yLeryxolLiNdQHHR5JDQhnZd2pPfLzn9BYIn
	kzVJBvEmRJJhZFb36OCbfNe0xa4FXrP31F1IqmFVkpFGPjUiwY/uVROC+y8pFCoyKV/90nc4jMA
	ileGB/Zc4XnV2raQH1H9l+37Y49Ea9/gneXRvbUmLRiiS6hdC6kzilNTz4Yy8hnoNpuNzOJsICf
	Ws9eoF0KrDU09WL0IcptOpyeevnIvSYrH/ep7u0sLXS2W+N+WnbKm8jcCJ8L75SKJJd5gdBt4o8
	xaEWUWbrVsc4arYL+FspzLXqVkewidXCxj2PNu2+L27089cEaTEGC6N1a3Lv3yPIuI9BKleZzSU
	zwxis6LW7bT7nepkv4tmwyZY/UF5dz2u23rYLlNi+0tSVOiTZ1ofGR2ltV3Vn0M4xC165NriGAu
	lAdjwsAAB3rGmY83o5Q84k5Ozqr6iKwbdClOkjfXvrUbp8e29IWhpBk+fPuIBP25JalLrGglGur
	6BtDXOadHxivExU9YlQgDg==
X-Received: by 2002:a05:7300:559e:b0:369:ec31:8fd5 with SMTP id 5a478bee46e88-36a1ffc5706mr4136411eec.3.1793206748423;
        Wed, 28 Oct 2026 09:59:08 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237bc445sm7275689eec.1.2026.10.28.09.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:59:07 -0700 (PDT)
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
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build)use of undeclared
 identifier
 'class_no_notify_signal_t'; did you me...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 16:59:07 -0000
Message-ID: <179320674728.41040.11625609999667448439@kernelci.org>

New build issue found on stable-rc/linux-5.15.y:

---
use of undeclared identifier 'class_no_notify_signal_t'; did you mean 'clear_notify_signal'? in kernel/pid_namespace.o (kernel/pid_namespace.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
kernel/pid_namespace.c:216:2: error: use of undeclared identifier 'class_no_notify_signal_t'; did you mean 'clear_notify_signal'?
  216 |         guard(no_notify_signal)();
      |         ^
./include/linux/cleanup.h:109:2: note: expanded from macro 'guard'
  109 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^
./include/linux/cleanup.h:86:2: note: expanded from macro 'CLASS'
   86 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |         ^
<scratch space>:147:1: note: expanded from here
  147 | class_no_notify_signal_t
      | ^
./include/linux/sched/signal.h:351:20: note: 'clear_notify_signal' declared here
  351 | static inline void clear_notify_signal(void)
      |                    ^
kernel/pid_namespace.c:216:2: error: expected ';' after expression
  216 |         guard(no_notify_signal)();
      |         ^
./include/linux/cleanup.h:109:15: note: expanded from macro 'guard'
  109 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^
./include/linux/compiler-clang.h:20:29: note: expanded from macro '__UNIQUE_ID'
   20 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
      |                             ^
././include/linux/compiler_types.h:60:22: note: expanded from macro '__PASTE'
   60 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^
././include/linux/compiler_types.h:59:23: note: expanded from macro '___PASTE'
   59 | #define ___PASTE(a,b) a##b
      |                       ^
<scratch space>:145:1: note: expanded from here
  145 | __UNIQUE_ID_guard279
      | ^
kernel/pid_namespace.c:216:2: error: use of undeclared identifier '__UNIQUE_ID_guard279'
  216 |         guard(no_notify_signal)();
      |         ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/cleanup.h:109:15: note: expanded from macro 'guard'
  109 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~~~~~~~~
./include/linux/compiler-clang.h:20:29: note: expanded from macro '__UNIQUE_ID'
   20 | #define __UNIQ  CC      kernel/test_kprobes.o
UE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:60:22: note: expanded from macro '__PASTE'
   60 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~~~~~~
././include/linux/compiler_types.h:59:23: note: expanded from macro '___PASTE'
   59 | #define ___PASTE(a,b) a##b
      |                       ^~~~
<scratch space>:145:1: note: expanded from here
  145 | __UNIQUE_ID_guard279
      | ^~~~~~~~~~~~~~~~~~~~
3 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:5ee69aa82e9599e8f47acccaf4743cc50bf9382f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  d13d47e9d31a6bab5dce791c8491d672dbb24627

# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-6ae227f85c0836a8c2f03cc8/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae227f85c0836a8c2f03cc8

#kernelci issue maestro:5ee69aa82e9599e8f47acccaf4743cc50bf9382f

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
