Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574833;
	b=UgcUM9BEd+Zh4LTGr7UPPWZ28PudxwJ3ykwvUjz1d8rOCu1r2PzerBmZM0NOPageZZl+
	 nn4VB/fZVB6ivCS0iBs44wOxEkwXa+qt9Jah4fxVKiyzMTDV3AeEa/sSt77XROPKJIKQA
	 2uFw1EQpJJlM1iT1Yb/EhiWMvPQKEIaKyy0QkSApxfU5SLaGCp4fVjj3Z3GI6/KSj2U4R
	 8N7522zT7o79c9OrUw6SsdOZZlekduhrc61T/K0imOAwMaptqvWY10L/PPUIVCZd0SgKA
	 uv9e1vNWqn6ZZm4ajRcnHx+cR4v0H+YQjWoirJop6KljYHdbHKoDBtQTHgakhZmfRsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9XQkh9lf7wElzJVQsyWKbD5l2m4uqHSi/59IR73vHTg=;
	b=rG+FWK6abX2ygJYlWfNEdMdBWNAO6XZjCEhgJ0r/DSdlo182z1mwkh46/hCI0h6GmtMf
	 jdVS/oq6E70vQ8ydsete7dF0NEJQhH00O5LRRfi62vpyg/oy1ygtt+uA02iHF6GangWWN
	 ljvhn5Sm9CmwWg6pBNKfeL/63v9Ew95Tyeh+jibEhBoF7YmODYxbh1Ebq3simqhFhMNU0
	 SM0eFtPRrlDGuVprPeM9tUC32OKV8KjbBw36SqP828/27KqQqXp+iWbfYfSnu0xY1ZvSh
	 soF16YU3z9BbShnI1qVgiTEXrjEAJSxGOOm3x+0oz9BSYtRlfuzHCk9MstxBs6+cIlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MIJrvosy;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F35606A31F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 09:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2F35606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MIJrvosy
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so2833645e9.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792574831; x=1793179631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9XQkh9lf7wElzJVQsyWKbD5l2m4uqHSi/59IR73vHTg=;
        b=MIJrvosyhchoySA6M2ALuD2hK2i7sP5TXboHiwjpDDDnGVkv8xuog2A30lshVg1tY5
         o64M3aBqnP9h8QfrR+V2mbwqpld/OzqnxelyWx7m5BqaVd1GMG/vWjeHbJO/HsAJguQp
         4uaQZz13+TpRFNm70wAukTI7xNn2ieLfPJtaqrAv99DOsLWIDmud38yU+fczSnZw2G/Q
         7upiFYKPYutM7qQO/kBDezbI4Rha80n3nViPTvlWRJz3vykLrq+wEK3+rMvmm96/K80A
         ZimIIpqyqRA6z1HUiLd3+GlRNkLrLSm7/C6gEYBCl6LPKBqMuQL+ckk/yIRVBDD4NruJ
         FiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792574831; x=1793179631;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9XQkh9lf7wElzJVQsyWKbD5l2m4uqHSi/59IR73vHTg=;
        b=qit4m0iYjUr8tCaYQeHAgKiJmhIqgBUNVrKl8aMaMsVSlnnraFHDv5VpqKbgFc/ahz
         651wtOy3wGszGXXCSZaa/TlPPC6sXWqe9PFUx6M6x1v7ogIPKVNw6qQt254MiR6rAfQX
         9qef1ArzrS11xGG1tU6VAUKd9QD5ymK55u3dTqToQ2QvLFnZX+THKw1RcDK4FcK2xx77
         O9AsX8AQluRWdEu79f1RgyGVcqnSizYZFPEubYKoB0wqTW+OCBKbSN7Mbe1LTIsDz3fY
         I3RVNhlnlX/VfnA7JRD6Rp3ZqxMdVvFflWcVB6Dvf1DRYBsTwsHid0BPkBUVs9lQqa4J
         /Gkw==
X-Forwarded-Encrypted: i=1; AKwUvBzh7Vja26lkDPBsoLoUClKvK6qvWPeAnvsfggkXXmrKUVxi8uFgMHwowUusJgyKdO8lTw0zbvk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPEjowG8x5Voa/flqq/pqWwgMoSrpvKU3JbuBX16dRZlvx7wl9
	7JzO5ke1C8Ld9XGM89yXNoS+Fxgs6SeK2Ba9MyQ5u0r2qEerPq8fz9aY4sePuwyH
X-Gm-Gg: AYBFou2BbTenHaSBdZa7j89o1Gj1sfN8yI00bzdDmEVG8p3qJkfIh9ax3mhBIM6toCr
	3DZFBW4a14s7f63wTYRBw4c4a/qGb+7U35MqN7Wf9gwHEUtPm1mVjLEx9uzuen4zrOcl7FvF0sn
	rx4JHYKNLvMXjcMjwoicHEHdHJ7W6oEIVzjb9GTyfmHjYVQF4KuRWcpCQy7hEGEAi7nzp0jMK+y
	CHumWkh07NnZbwJwrhkrTw3V48pAeZ3S2F4Oh8BspS8ptYihMPic33OSxaf6rWxGznBh28/OM6G
	IjfDT/1futetFUvGqjUv2EiMXNSbLG55zSLWS+8MLTAkGhVGRUh/j4SwHvhIdNW5xgiao8xH9qa
	/gkcki+Bo8IZqn68ubLbCrHbz088dWxYe82WSvZAn9wqHB9LaVVGwihRkwlPtgucTqInMyVZkGB
	1v6zyEQr4eubxB5VERahQj3aKBXg9QpEmv8tDhp0UqKsmpiPq3GS6qzJUtV89x5x2zBjS0CnZmh
	yQMFXYofj+BFdv9OPska/0asJVx5fhEaTQZs5zUTlPHf6osGG95YwmuV7gFxZ2Z1Ww=
X-Received: by 2002:a05:600c:34c4:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4a1fdd37971mr30903995e9.19.1792574830916;
        Wed, 21 Oct 2026 02:27:10 -0700 (PDT)
Received: from foxbook (bfd231.neoplus.adsl.tpnet.pl. [83.28.41.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d1e8ebsm129038025e9.3.2026.10.21.02.27.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Oct 2026 02:27:10 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:27:05 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, wenxiong@us.ibm.com, Brian King
 <brking@linux.vnet.ibm.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] xhci: Reset controller on xhci shutdown
Message-ID: <20261021112705.19fd90b8.michal.pecio@gmail.com>
In-Reply-To: <5510281a5d91bbd435d9920431a3fa75@linux.ibm.com>
References: <20261001222527.11742-1-wenxiong@linux.ibm.com>
	<20261002102931.3cb06009.michal.pecio@gmail.com>
	<561d22493c3d078b26f547dd8f6f6f46@linux.ibm.com>
	<20261002161828.365ff859.michal.pecio@gmail.com>
	<55a53022d1c6f671a3ed549d8cf7cd1a@linux.ibm.com>
	<20261006125546.10471489.michal.pecio@gmail.com>
	<64515dfd9a6cd8c3f5665e72a6bf6b81@linux.ibm.com>
	<20261015103307.3ba25345.michal.pecio@gmail.com>
	<5510281a5d91bbd435d9920431a3fa75@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 15:40:24 -0500, Wen Xiong wrote:
> Above patch is similar like my V1 patch.
> It works fine and all usb devices are showed up after executing a kexec.

Thanks for testing. The big difference is that my patch does nothing
if the preceding xhci_halt() completes successfully. So if it helps,
this tells us that xhci_halt() fails and the chip most likely locks up
right there, during xhci_shutdown().

It probably fails due to some devices that are connected and haven't 
been shut down normally; I suspect that nothing bad would happen if
you disconnect all devices or unbind xhci_hcd before kexec, but we
still need to cope with surprise shutdown somehow.

In such case your suggestion to PCI reset may be the simplest way out.
It seems we could either call it always on TI chips, or automatically
as a fallback when xhci_shutdown() fails to halt the xHC.

Mathias, any preferences?

The latter is perhaps a bit cleaner and more generally useful, though
I must say that I tested rebooting with a bunch of devices connected
to a few different HCs and all of them passed through xhci_shutdown()
successfully, so the issue isn't widespread. I don't have TUSB7340.

Regards,
Michal
