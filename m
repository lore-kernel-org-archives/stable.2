Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661119;
	b=Fd5QTf7l0MZGtsGdMchETpaJJ/hj4dVKq3tL/aID0GtPXaJi6ushNS4kUcQ6NaE+XSi8
	 0r6GsQYl7HF7cFE6bzfPNqjm6XCjpOfgcsBgHtrM2B5BjDUo/C0E+t1ZFK6VoIbyB1ZN7
	 NU7lHEnOOnsDUc1rw8/EcWQU9TzKTvuHgw9xUywQ+VJf+5RGBlUuN6oEuSN1UK8QylUXy
	 F7Fpop3dybfXaW90YsopFNdUjHZrxRf8sIYjUMUN5/G6yN9fOtRPCwsDH7+eOujGxQw2v
	 CV6CsTSk1NoysxzqnzJbKL08bjOZRxalt4JEENJiffzb7sulcfDdaxGj3f4vzgCQltQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=qyZ3Z/w9Fggbci4w4XggEaIjph37o7PsqDHHOvsTEb4=;
	b=H0IkLeUC+BN4ZEa5eDyvdGQx0n7u+EUcMebrnAHIx+fMQGb5sDt7KObnuNnb01e0GpWp
	 Szg3ZKi1WPU7gXfj8Bbxnly6zhLHVqPp6caKylmam+NychUH6sVRaUQ2qcPZKan0p6uhN
	 WmT4Rbje8Hr42E3beuOHBUSqFCIWhSSDCYfe97g/LESISR6ePzNeSWx5TTwkGuzy1c7jV
	 xxIooQxhvOo1lOv9X8quvA7Q9uQjHVRyy/Fg1ZWNv5WKb6hLJ/tssii0wmpyaoRFhbq4I
	 4GnmDoi/eNwDGCCsPGP9zQOLq7qOSU/aFfuNhfmkNfXMPSZj2B5eHlbeaki+J/U88eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=HrEBjPHq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD9606A68B
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CAD9606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=HrEBjPHq
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67da7d18f2fso7398830d50.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661118; cv=none;
        d=google.com; s=arc-20260327;
        b=LtqZvJp1qD9IkIK0Q/Zu8hMc/rI8Njv5Hyi+/yd3EXHHbaxK9fZs4c5WkObFOCk5Et
         6mhoUcO6UtZ+ObLIcChszwRZMR0F3v0Zw5f+rsCHMy1a5FFeGdDGJ6hewLTJ3XErX0w7
         uTWN3lZB126BnuoJ8OZC48tAHwTR4uMXl7uKpVpSbSRWBQK6T1Jk9OaUHXlddr1qF1+w
         MykNThMVKL1nPhANzKMsT1khxWjvQhGbZY9cOiOC4f+5D8p8t+cdSMuS76JHx7i5wZM0
         q9WLjlXyBleumeeiR7cEERy+Jb0FLCP+xwVfbjuoQr7QzxL7XUk3JwL+3+M4LCuz9C88
         H2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qyZ3Z/w9Fggbci4w4XggEaIjph37o7PsqDHHOvsTEb4=;
        fh=AIrBuAclZrkW2rl1AKI6uFjmcQF/pUVlMaxQw55Yq2o=;
        b=Oc3J4oRkHjK/iymfL75EM7rIh3A7C+J2Yn4qgddQFm90JjSfrBg9/LQtrJYDTC6zXe
         IItj0nEvZfJ1lLkE1RUtsFgbbHeNzWCbW+nrJRJEWZRLab26HAjPpFWOVx1B/pGXoGQi
         jNeTYU5m1Qn32TwTqeAFsdr0XcH47a73b/KZ9yxD+9ABmbZNFO6I0fMu85Nv/sL0pIbG
         OmGOqcTa+QOwNRUJUHb9lBjYcytPXkoZP06ZZmracxo5x9rquAT7LShx/o8KH9N43cqS
         LOE2mz77gLvEH62OC2N0PGE/DMcnuktXlxdAptWvfSqiI7pwIAV6HClscYqmNhSsTvuw
         w5vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661118; x=1796265918; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qyZ3Z/w9Fggbci4w4XggEaIjph37o7PsqDHHOvsTEb4=;
        b=HrEBjPHqvFckSbp20U4PYhmcVd0d7yDI+xF63Vhxvb09eZ3NPzGWHq4Qf4o4o7hGdb
         aSFJJ4AfTFJDISadOuKKOTkJxI9rDP5A2C7YaJAV7MyuG+BzD5Z/SJdzmK86lwXOkerP
         uySVlG5MN8ZUsuHjn2qjHa8XpCKliStV1EzKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661118; x=1796265918;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qyZ3Z/w9Fggbci4w4XggEaIjph37o7PsqDHHOvsTEb4=;
        b=abpK97ErvhdSt2zdxdmXXlmB7BOMHlllQflvkON7gTMuUhHs5VE2RfSs2arQr6/Zcs
         tbrY45zmyVuIG1XlMXCnFJbZ1SwlspKakEBidmofCf6Y1cOhutrfHyE8M0Fto3H821y3
         EdJexdYD/LRUMErq0sy1EOLOQNu+DdtIwZhHIFzs+I6pz2cj16Nn2kYpMhIYJqZk1nlW
         z75VfwlHvcDHANB4Y5Lt1VbkuGsvVricecruus7HUGm5fy4hBDky8Rg2m4JIyqAPbCrM
         XmIrQThYEMmUYte5530BtwtT0K7wpRcvmGtlKt8BS3bKJyV+6Lsy3uZxPwRXQl/qnQKD
         ChtQ==
X-Gm-Message-State: APuU4Z/yt0fZMwo6ByFyNqIJNLFFi5+HI3bMfR0yPmeq3Rk1fte5aXVv
	ECylmYPTGJoWxR3uSfPVI07YhaCWo5RyDZGe/k2Eg+xo0rn+LFdE/xrHPhTNta4Dt4frNmz31Bz
	XA4Mb2tuHZ+dNH+hyRdumr6ENTEeLZTef7SgUB6beCSHTey0ug2h4lho=
X-Gm-Gg: AZFdTZdd9M7s4Tt5FwNsas9gW7xRsZTFEwUpK3grzpSP13WAd7jROiqoYAtAUEnBJUK
	V2fMpQERaeCMIS4m8SkeliPMSzZmgPcXt7jn3g2ty5kvsVuimbSzcNHd7rIr4Ck8bda2jy9J22U
	Vg7riaoxkXzo1soZQorPvkrVS7Y3X+zNWQlAmNtQHZlLkgNSiwq9/lZ6LjfEFgAJ9CalXg9gp9+
	rtMmvZorbjKJZZHvhnilA0hdD47YV9p6AvEBWUBkKWMD6DCBlLxCMosDMbQ6tp3pZaQzOVVs94m
	2uxHmq6sv3t86iZUEi/Vp7yI5IcYehOUR5pNRB32NOZ8LwolaE7NLF7PP8SlOSIIcJDUFBPXdaK
	UA7p+J/UHyw8xP14OzMTdNcoajrDkVI1EGESvmKk3wFSQucuIRMX774r0gf2k2cBaVNZccHBXIS
	yLtRD0kKjEly8f9qYSjZjNR5fodgbUNmoichTb2qab8mw9pQciKq72zvkjBsiKqnsq9EMgo1SDE
	bNyVFJkIu6yWE5tCvXqvvWoHFpjt2JTuhoS
X-Received: by 2002:a05:690e:1c09:b0:67d:bc4d:4524 with SMTP id
 956f58d0204a3-67dec47a61bmr9629241d50.30.1795661118097; Wed, 25 Nov 2026
 18:45:18 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 20:45:17 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 20:45:17 -0600
X-Gm-Features: Aa3M54qDUVBD0UobwvN0Np77hp-ieqmfIJ36B90oCQ98uHa_LiRVanYCvb5mk9I
Message-ID: <CAFaZ9epYnFzn_EE9Q+g_hn-rmPc70PPC07TXm+9yScHN68hLEA@mail.gmail.com>
Subject: [PATCH 5.15.y 0/2] pid_namespace: prevent TIF_NOTIFY_SIGNAL from
 interrupting the reaper
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

This backports the fix for CVE-2026-99244 to 5.15.y:

  22b7f491be8f signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
  5c0985dd3c32 pid_namespace: prevent TIF_NOTIFY_SIGNAL from
interrupting the reaper

6.1.y and newer already have both. Two changes for 5.15:
- 0x00800000, the bit upstream uses for PF_NO_NOTIFY_SIGNAL, is still
  PF_SWAPWRITE here, so patch 1 uses the unused 0x01000000 instead.
- Patch 2 calls no_notify_signal_save() and no_notify_signal_restore()
  directly instead of guard(no_notify_signal)(), restoring at the
  function's single return. guard() in the middle of that block adds a
  W=1 declaration-after-statement warning on this branch.

Tested on v5.15.226:
- x86_64 allmodconfig W=1 build of the touched signal and pid namespace
  objects, base vs patched, no new warnings
- defconfig boots under QEMU/KVM, and the existing pid_namespace
  regression_enomem selftest passes on base and patched
- No existing test forces task work to interrupt the reaper, so that
  path itself is untested.

Same two as the 5.10.y series I just sent.

The two patches follow as separate mails with the same "5.15.y n/2"
subjects. My mail setup can't thread them under this one, sorry about
that.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

Thanks,
Dickson
