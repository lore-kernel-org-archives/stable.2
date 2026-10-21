Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551948;
	b=Yo2MROsXYz3rPrdJzQ68X1gAwKgl7GoV7/a1KPMx74ryPG6thR1y3JucoHOI2SYvpPZC
	 QfnOjaxU4wK7sUFoCcJOAKFHn5lJvLrzlzBdDP8Bq6L8mUtOQGuvYTNsci2uJmVM/h7s7
	 2J9ct2jB4R/PqeYshbGhwUoZLVisH/BQkwcviV9o+2V+pas0UFgpjS/bL2WOQmtUUYeaG
	 taAo6GHFZF6x4DtzkzgBcbxJBEzCOhNqK+H4Yi/n4ocNMfaReaPyvzUYppnH9KuJMnLTM
	 mA3EAcrpm9cxzFAFVDszh9B1LcE9XhN03VJ2ODPw9KvnV9VTWLvSiMGSipEYTrJToLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=gDndSD0GZIvZyUTYE/Z9F/DZP122ym6cCPQpCZSHgLk=;
	b=0CWqC3C19WitpvVpMDEsFBKPe9449bFZCARvIGdWqUZ3LVVC9lH3+VlcOIfX6/2ECUPF
	 nTto2KnwhtH4a6KsG2ruyvk9t5NA+erRrPavdMQhxhNTmi9XBdfZ38cBQVDcbHuFyQQ2i
	 0k1qbY3DRuz6o3DBglTPM7Xx81DFOXJkxix8QGbMJGROlXLkf4LGX+U0W8CE2AijE6bmq
	 wFMVc4Lr4/n1IEPyjk831/miSdw93gNLct7veJ2UPik+bLA6jSp+kFyEKxB8YfeHcwqBG
	 tz4aIhLE8IA4VGpPpnspYgKPlw0coN+lbnQuiJVLFZM86afCBbvRjhcFD8SMAUKoODw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iyEoV8X7;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DCF606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29DCF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iyEoV8X7
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e22b83de6so28826f8f.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792551946; x=1793156746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gDndSD0GZIvZyUTYE/Z9F/DZP122ym6cCPQpCZSHgLk=;
        b=iyEoV8X7OnT+MoWdag8gC0LlhSjG7fzgL/q3idOwMs/rP3y1qFo81s/SJIcmiuci0l
         JW3akbq18jxuXt1DhdQIkCEJ0PjMVP3Qz8Bz0rntL/+Bgo+LklOQ3JlRFtkGq3NK/vzF
         7QoPp9ApQZpD9f+xyJvxbas5mgubXjROp7Lpilj8ZihGbffu6fYjpyQbEKxwQ4SzaOv6
         mwuIMtSVVhl5qgeHNW24LzzX00EWYzh/op64Y2O0Yq4o5rWgYq6ezPlrOlLEiJpCX3hA
         6EaK/HTlFVvVxwgQH5qj3852iR7qUcXJjMGerXZgpcN/ax9CaojSVLA+IewPINQoiwD1
         BIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792551946; x=1793156746;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gDndSD0GZIvZyUTYE/Z9F/DZP122ym6cCPQpCZSHgLk=;
        b=DwzUUDyXua6pyrkmV1bI07szAivhB5OFj9T/IlPwYDU9rFh+OUl06mOoU5tzBqQ4HR
         agas+9r93lqwvkAakBQs0uyWj7kJt83pcnCvfk1J5TmIWqZNC/3Q5YlPvWrG8ZN0WUpj
         +M8q002LVzZ4ZqlXMyflpAZz77HFnbaddk2Gm+aee5TwmjH3sdfTqE/+FisaunO/+J2e
         Fq6W7MQd1bgz3L28XPnVKyT2ag8w5BY5AWdW8nU0UakJ2NgoRTpGm/RT+5hLyKIBkzRz
         74Gjw+sJbakX0cdtkM9m7P6XhtozlqMSwjwnoV92su15pNRmqEnxs2F+hw1fu0UNJlKw
         ZF/w==
X-Gm-Message-State: AFq9FYIWw0LIp8L3ItqIqqmpycV4CkpecVSVszJDDSttU/YvR04CW+0o
	X9tqkNoInNvuQHcncTFbOTO3qiSpCiGXCH7qYCz9jRA+8jDW0e0v3169
X-Gm-Gg: AYBFou03B+SDGXjGpRiNSvohwtbid9s1kE3pxk6lEowGt/o2/jZeONnoiofyaCvicBX
	Lvntsai1NYi1vzMdpR2DmW/FbE23tR+Z98HFwOSHss4ECletrl2Kj77ylQcR2XiOsDXggrv3bOe
	htPUkUA4/EYzIsWFj9Nrca8y5PS4ZLNUuIy7wzRxQiWBS8HOgj5SrZXJ5ZvJnfyVTOMga2nmr31
	YX0XSz336AOJGIqX29D57Q0YRN/0jm2aaAOVZcn9QGnenLPUUahZr0LFHCVO8f/eG2jkePv4eki
	b8SPllIpyscsotPejtRJfmPtY+pLqSLKw8nWWVb+3Afpw2ccOpNWWV9v/9bbRHXNk6UogjBV94R
	3gwWYyN9yYvRfIlkwGvA0VWvbrCn2efZ+2H4Nr1BX5a89VYj54NfCtxwAE9Na3WcII8S9VL9B4+
	4vN8k+QCceqmpKSS9SZIMFvS0U1Rrde3XpULG51rHLOPYSirwXVrcknN/4rImJBW7iahW0SjP/+
	9KPipR/9ruCs+qjqIXnRvjGsK/TLleXcadfn2zC6rlHl27hTk6sY7UeRx3Z4n7JxBQcZ6dK87u/
	nJ22vRmrPd82rI8pLYTiT/mxOAEKEGY2rlUI
X-Received: by 2002:a05:600c:3e87:b0:4a1:d899:b633 with SMTP id 5b1f17b1804b1-4a1fdae0e9cmr9334205e9.1.1792551946307;
        Tue, 20 Oct 2026 20:05:46 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2e8daffsm131033835e9.4.2026.10.20.20.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 20:05:45 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@nabladev.com,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org,
	achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.6 0000/1651] 6.6.160-rc2 review
Date: Wed, 21 Oct 2026 05:05:42 +0200
Message-ID: <20261021030542.1434603-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020075535.084584701@linuxfoundation.org>
References: <20261020075535.084584701@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Oct 20, 2026 at 09:57:46AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.160 release.
> There are 1651 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 Oct 2026 07:53:04 +0000.
> Anything received after that time might be too late.

Built 6.6.160-rc2 (c578c158a368) and 6.6.159 for x86_64 with BlueZ's
doc/tester.config (KASAN, lockdep) and ran the BlueZ CI TestRunner
suites on both in QEMU/KVM (emulated controllers, no Bluetooth
hardware). Four of rc2's fixes show up as intended:

- "Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING":
  mgmt-tester "Start Discovery - Simultaneous Inquiry Late" fails on
  6.6.159 (Start Discovery answered Busy) and passes on rc2, 3 of 3.
- "Bluetooth: MGMT: Fix status of pending commands flushed on power
  off": a vhci reproducer gets Command Status 0x00 for Start Discovery
  on 6.6.159 and 0x0f (Not Powered) on rc2, 2 of 2.
- "Bluetooth: MGMT: fix crash in set_mesh_sync and set_mesh_complete":
  mesh-tester "Mesh - Enable 2" hits KASAN stack-out-of-bounds in
  set_mesh_sync and then a GPF in mgmt_pending_remove on 6.6.159; on
  rc2 it passes.
- "Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect":
  l2cap-tester "L2CAP Ext-Flowctl Client - Defer limit" fails on 6.6.159
  and passes on rc2, 3 of 3.

No other case that ran on both kernels passes on one and not on the
other: mgmt-tester (rc2 465 passed, 37 failed, 6 timed out; 6.6.159
464, 38, 6), mesh-, iso-, sco-, rfcomm-, bnep-, smp-, ioctl-, userchan-
and 6lowpan-tester, and l2cap-tester up to "L2CAP Ext-Flowctl Server -
Accept 2 Close 1", which hangs on both. No kernel warnings, sanitizer
or lockdep reports were found on rc2 in these runs.

Tested-by: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
