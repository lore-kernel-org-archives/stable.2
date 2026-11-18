Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013946;
	b=TDd2anFd7EGxa2tubKtl8kShA1roTCa2pgq5h0hAe1k7UxYIC1GpxNQwlyI2nvAKWHPQ
	 q8D6SyVzKDQe6CgCz+e3VL5+OW4ez+jQkIvKkK82Y8fgKjS0ejfQRtLMs6xDowiNwPgB+
	 keuG+WxHVH9vBPUrlIM+qAinoSG2re8KpU8Mwg09ZclfJfDvVvRacXNrrBInhDVG7Oq6J
	 kBFAPER2MkT5u3BJxWzfLgDKrOhY5/uPZ4oKg2ivILSAEEhifXX8HeJT4vSpaNttWYaCy
	 Qh9IUALLDbREVkPPGbeB2WxGi6ecWe0w76b40loX4VrQ4YZGfH2hCOVtYMLjJmaDHiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=yPbgTxDMOJTw2icVLMgPkVenVze8mUM/OoHkGT8StNU=;
	b=YFPdVOpwuvILB9XW747XTE7DW8oIdjy0P/sUD55BmtTRE2D3Y5wXts5Jc/DF1BfX3Avj
	 ICNLboctDtGnPjIvUKH5rkGm6dKwlSRGKTw/ZhZDIcfXqd8cY+Gc7xHRUDGgwFZcssqtO
	 YaOGdmIcXciqwg2v18UDKPQm28EBad7QufskTk8hQZODtDLIxztgbVRQVOgNiwPsHzi3+
	 Seq5NoPgQ/mgxyaaWm4/QU5nQ7kU2SQenJrAtEp7RZJjHad3jO7vj62e2jFweSq517mpS
	 7l2SbfXOA/QIiYLrUa2lwPtBub7EZwbGXDVXpV5A/oLWMfl/4XMRjIq3vZzMntpv6hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=U1rgh7WD;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02D606A331
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA02D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=U1rgh7WD
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso1693878eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795013945; x=1795618745; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yPbgTxDMOJTw2icVLMgPkVenVze8mUM/OoHkGT8StNU=;
        b=U1rgh7WDM0DKAdxXrYaBVBgZrkFoKX+T98gmp8aexfFPYbQ2KoUqmAPdS0mFmdxtoQ
         Eqg7OnK6Q80MFk2yZl+iOpZX0ZlB19VLI2wx1HbW7jzNkLKXW/Pz6FbfnUntCpZTmmVS
         9NGF/9qSMCNn3dgWHmGWgM8fl3Zp2PRIVayXQx54IWPRfncV7DMU6iT7y2sRJAjeVZmp
         bBrFA8jTacYWNGn4wzTy1v5osShhU0fr2x3FemsUWYJLBEv4pklmBq2xq3bob8a9CMOX
         0LjifJ9R8hUuU9RemKnyTA8i4fxyfF4fzyF5NjSHkV+lUpUbvODYdfduCIPSUNwz6nwz
         KNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795013945; x=1795618745;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yPbgTxDMOJTw2icVLMgPkVenVze8mUM/OoHkGT8StNU=;
        b=mk9qktXfhRm1me/LX4FRV0a9k3+Mmm9BdAX6rVVVJVvNlmyJvmH+175XNXVfOl7TYy
         2R29jyszaLnkj+cLhuMdYy3v0725ax8ZOkHzF/cxuem4piyZDhTJQB0o1OEqfZUIU+QE
         kH6dtbO4+5FFW0XIt/4pRfOYtVRkd1VSqwIEQQ8WnUqLYnsKAwR0pE3WhLB2nB3R8F9m
         94zxVf3C2MEc09bb7kMw4KRPxvmf8utPpJmOYCsLYgghD85UM681Z0I8JzvgcbRNQKxg
         SQ4fdf9VYWBUVYh5TfgD5+1XdFmYDYca7bKOQ1ntEgpI7pRhM/ffPoBobcP7IhoXa9Pq
         RKag==
X-Gm-Message-State: APuU4Z9xEKYDd7+/J6u3t3xhmzwg935uOvKLeIH3AO+FEN2Zc3lspzAh
	fzUVgi97Tdkl3DKIK+WOr6dYZ49U5XaTS2nYPIu9KK+DB70PJKx7EY+bPQuD/LhTEi2ud1fFRMn
	Gv6Gl
X-Gm-Gg: AZFdTZcd4dkzN7Gkrw9Zohce+fZB3WFCZKQ0z8uT4IuP17o4iAybCJPcqglpTgLqa5A
	DZjnUGuIYxFrI8OqaDgUK27vzjE0k1WHs3eLFgTa/Fe4SG9SqjEga3YWJl2NnPaCGBmgf0vyUTN
	1Q+0Ji6YH2wbooIFvAasdAz1IGIphbjqo2GiuXFRdUiokAUCEyib3bzEvNxNDwgIBybuVrxERZT
	B7jv8fkSVklIriWAZJcByiMsWUHHQf1nAXIlWrU+6QHfgZvdIGe3n+BuP4HanLwoc4GeRCcbMtM
	e/MNZvCfq4QDVfwJgIu9AxAyNa3lNsXq0Y+AmbN3b0jfcJ4jlc1FDfQoqzyO0PAfqtxUZl0J6qF
	+DM04ZcKeI3GMSmpmCsy1dkHC2gpS77vKeL05CRSJX81KPnSB5yDgO03DH+kzsRCwPoY/0VqLNh
	9KvYmYTmuGFDFsMBhEqxriiVqcHirjpwS99MUY2wpc+KuleqIrW2HAddWh9RQMG5S7OgkitfoY1
	lW9YrBExFT5LK1FG/awkqNwaoJPjs38xJSdzrnXg15vsYGpSKUWRN8B80aK58BNrsZcBgkim4F5
	BgJ28zBZWlSdeGM37bBY3A==
X-Received: by 2002:a05:7300:7314:b0:381:1580:cb4c with SMTP id 5a478bee46e88-38281023cfemr3520732eec.24.1795013944791;
        Wed, 18 Nov 2026 06:59:04 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a45260a8sm15025613eec.3.2026.11.18.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:59:04 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-7.3.y: (build)unknown type name
 'class_mon_sel_lock_t'; did you mean 'class_local...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 14:59:04 -0000
Message-ID: <179501394391.306181.16199227889239789757@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-7.3.y:

---
unknown type name 'class_mon_sel_lock_t'; did you mean 'class_local_lock_t'? in drivers/resctrl/mpam_devices.o (drivers/resctrl/mpam_devices.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/resctrl/mpam_devices.c:1766:3: error: unknown type name 'class_mon_sel_lock_t'; did you mean 'class_local_lock_t'?
 1766 |                 ACQUIRE(mon_sel_lock, guard)(msc);
      |                 ^
/tmp/kci/linux/include/linux/cleanup.h:429:34: note: expanded from macro 'ACQUIRE'
  429 | #define ACQUIRE(_name, _var)     CLASS(_name, _var)
      |                                  ^
/tmp/kci/linux/include/linux/cleanup.h:302:2: note: expanded from macro 'CLASS'
  302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |         ^
<scratch space>:4:1: note: expanded from here
    4 | class_mon_sel_lock_t
      | ^
/tmp/kci/linux/include/linux/local_lock.h:86:1: note: 'class_local_lock_t' declared here
   86 | DEFINE_LOCK_GUARD_1(local_lock, local_lock_t __percpu,
      | ^
/tmp/kci/linux/include/linux/cleanup.h:562:49: note: expanded from macro 'DEFINE_LOCK_GUARD_1'
  562 | __DEFINE_CLASS_IS_CONDITIONAL(_name, false);                            \
      |                                                                         ^
/tmp/kci/linux/include/linux/cleanup.h:490:3: note: expanded from macro '\
__DEFINE_UNLOCK_GUARD'
  490 | } class_##_name##_t;                                                    \
      |   ^
<scratch space>:13:1: note: expanded from here
   13 | class_local_lock_t
      | ^
/tmp/kci/linux/drivers/resctrl/mpam_devices.c:1766:3: error: use of undeclared identifier 'class_mon_sel_lock_destructor'; did you mean 'class_local_lock_destructor'?
 1766 |                 ACQUIRE(mon_sel_lock, guard)(msc);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:429:34: note: expanded from macro 'ACQUIRE'
  429 | #define ACQUIRE(_name, _var)     CLASS(_name, _var)
      |                                  ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:302:34: note: expanded from macro 'CLASS'
  302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
<scratch space>:6:1: note: expanded from here
    6 | class_mon_sel_lock_destructor
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/local_lock.h:86:1: note: 'class_local_lock_destructor' declared here
   86 | DEFINE_LOCK_GUARD_1(local_lock, local_lock_t __percpu,
      | ^
/tmp/kci/linux/include/linux/cleanup.h:562:49: note: expanded from macro 'DEFINE_LOCK_GUARD_1'
  562 | __DEFINE_CLASS_IS_CONDITIONAL(_name, false);                            \
      |                                                                         ^
/tmp/kci/linux/include/linux/cleanup.h:492:29: note: expanded from macro '\
__DEFINE_UNLOCK_GUARD'
  492 | static __always_inline void class_##_name##_destructor(class_##_name##_t *_T) \
      |                             ^
<scratch space>:15:1: note: expanded from here
   15 | class_local_lock_destructor
      | ^
/tmp/kci/linux/drivers/resctrl/mpam_devices.c:1766:3: error: call to undeclared function 'class_mon_sel_lock_constructor'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1766 |                 ACQUIRE(mon_sel_lock, guard)(msc);
      |                 ^
/tmp/kci/linux/include/linux/cleanup.h:429:34: note: expanded from macro 'ACQUIRE'
  429 | #define ACQUIRE(_name, _var)     CLASS(_name, _var)
      |                                  ^
/tmp/kci/linux/include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
  303 |                 class_##_name##_constructor
      |                 ^
<scratch space>:8:1: note: expanded from here
    8 | class_mon_sel_lock_constructor
      | ^
/tmp/kci/linux/drivers/resctrl/mpam_devices.c:1766:3: note: did you mean 'class_local_lock_constructor'?
/tmp/kci/linux/include/linux/cleanup.h:429:34: note: expanded from macro 'ACQUIRE'
  429 | #define ACQUIRE(_name, _var)     CLASS(_name, _var)
      |                                  ^
/tmp/kci/linux/include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
  303 |                 class_##_name##_constructor
      |                 ^
<scratch space>:8:1: note: expanded from here
    8 | class_mon_sel_lock_constructor
      | ^
/tmp/kci/linux/include/linux/local_lock.h:109:1: note: 'class_local_lock_constructor' declared here
  109 | DECLARE_LOCK_GUARD_1_ATTRS(local_lock, __acquires(_T), __releases(*(local_lock_t __percpu **)_T))
      | ^
/tmp/kci/linux/include/linux/cleanup.h:554:33: note: expanded from macro 'DECLARE_LOCK_GUARD_1_ATTRS'
  554 | static inline class_##_name##_t class_##_name##_constructor(lock_##_name##_t *_T) _lock;\
      |                                 ^
<scratch space>:55:1: note: expanded from here
   55 | class_local_lock_constructor
      | ^
/tmp/kci/linux/drivers/resctrl/mpam_devices.c:1766:25: error: initializing 'class_local_lock_t' with an expression of incompatible type 'int'
 1766 |                 ACQUIRE(mon_sel_lock, guard)(msc);
      |                 ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:429:47: note: expanded from macro 'ACQUIRE'
  429 | #define ACQUIRE(_name, _var)     CLASS(_name, _var)
      |                                               ^
/tmp/kci/linux/include/linux/cleanup.h:302:20: note: expanded from macro 'CLASS'
  302 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |                           ^
/tmp/kci/linux/drivers/resctrl/mpam_devices.c:1767:9: error: call to undeclared function 'class_mon_sel_lock_lock_err'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1767 |                 ret = ACQUIRE_ERR(mon_sel_lock, &guard);
      |                       ^
/tmp/kci/linux/include/linux/cleanup.h:430:34: note: expanded from macro 'ACQUIRE_ERR'
  430 | #define ACQUIRE_ERR(_name, _var) __guard_err(_name)(_var)
      |                                  ^
/tmp/kci/linux/include/linux/cleanup.h:426:28: note: expanded from macro '__guard_err'
  426 | #define __guard_err(_name) class_##_name##_lock_err
      |                            ^
<scratch space>:10:1: note: expanded from here
   10 | class_mon_sel_lock_lock_err
      | ^
/tmp/kci/linux/drivers/resctrl/mpam_devices.c:1767:9: note: did you mean 'class_local_lock_lock_err'?
/tmp/kci/linux/include/linux/cleanup.h:430:34: note: expanded from macro 'ACQUIRE_ERR'
  430 | #define ACQUIRE_ERR(_name, _var) __guard_err(_name)(_var)
      |                                  ^
/tmp/kci/linux/include/linux/cleanup.h:426:28: note: expanded from macro '__guard_err'
  426 | #define __guard_err(_name) class_##_name##_lock_err
      |                            ^
<scratch space>:10:1: note: expanded from here
   10 | class_mon_sel_lock_lock_err
      | ^
/tmp/kci/linux/include/linux/local_lock.h:86:1: note: 'class_local_lock_lock_err' declared here
   86 | DEFINE_LOCK_GUARD_1(local_lock, local_lock_t __percpu,
      | ^
/tmp/kci/linux/include/linux/cleanup.h:562:49: note: expanded from macro 'DEFINE_LOCK_GUARD_1'
  562 | __DEFINE_CLASS_IS_CONDITIONAL(_name, false);                            \
      |                                                                         ^
/tmp/kci/linux/include/linux/cleanup.h:497:10: note: expanded from macro '\
__DEFINE_UNLOCK_GUARD'
  497 |                                                                         \
      |                                                                         ^
/tmp/kci/linux/include/linux/cleanup.h:379:29: note: expanded from macro '\
__DEFINE_GUARD_LOCK_PTR'
  379 |         static __always_inline int class_##_name##_lock_err(class_##_name##_t *_T) \
      |                                    ^
<scratch space>:23:1: note: expanded from here
   23 | class_local_lock_lock_err
      | ^
5 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:5d409e914d49546f8510607755be286d66c50a44
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  be4dd9d66786975bc12243b4d744f97150649f63

# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd949299c74e1a997d48b7

#kernelci issue maestro:5d409e914d49546f8510607755be286d66c50a44

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
