Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB1A3B7B64
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667435; cv=none; b=nAkvUPsHxVptFGHlfF/ySWoiBc1D365AWHRoYc7DbSz77FPa83fEkYVceEfiuChkbLiLo/l+QQOrOUVLO8mVlNIfkR5UuFuzgbYUcxGqO6b9Y9HygQgQhf2EAnUE0O1yyxchidSjjWibABgVWFoS9lQHk3aXq/n8pXqqk0FzW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667435; c=relaxed/simple;
	bh=NjeO3E3aXTlf0Rmaw0bPO/yZw26XHF8e4PdgxVbvO5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LV1o4d6AOok0YAdQI10osmXJNCuNarm2YWyo0pRghhgLi/dObgpqWKGA97cu/2C1NURKEMxyUh3qRQOKpZDS28yQs8oG95qe5TRuwbrAp18pQpgT34nn2iH99YmyiB3k0NXBo0KA9jOBhb8j46SDjk32ZOP+yNa11OUx8Nb5884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUykYl3Q; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUykYl3Q"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so6587394a34.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667432; x=1785272232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pgVpgKXUNJtrWSKTwQbIOxGGmQfqameHK1lD3QBhDhA=;
        b=nUykYl3QoiDu5jbOvn3qCaiKUlwmTqW4BoVrYO9Yhf07IFuXVp3JRaHf2BG+pLQoVN
         bqw4M0HwbYKz1cnjGgYXNvfdoCiryT27iJA/qA6gYpsEDwB7C03tQ1Rz+gLxFYTR8Bs2
         jh6qkca6JXZj0sOY2s28+UAT2A6z2tTf2PxB1+wvuPl/bdLhCU/OC4occQR+UhrGtMiY
         KzB021Dr2nOQeLt/D6v1VFw6L/AR7J6lo9LQv9c9Erv0y71mPNCAbSi8W/NLjyABJizk
         E513I/oTUWt+b9G097P0lGjx9tC5xMtWNmCt90m9hZeAQCFlmJeFODnd5gdgSiGYkOvU
         yOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667432; x=1785272232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgVpgKXUNJtrWSKTwQbIOxGGmQfqameHK1lD3QBhDhA=;
        b=LgGKr0CtvKT6D/xQOhXrTbG+69RFfw16IBa/G6T+MWKgyGuuXCH+8/xTN4uKhjLp+3
         2LoW/lDiVxuaKn5hXEMCOHiDWp710xNILiZ/kx1sVT1tmpF8dr+evgkDN1jg2NrnncsF
         JW5oBB/verMZhMT5UVE7eW9L2TE/fuXs2eF7NjjqFoPJFxyGtc80RFOLMBpfOUghs+FY
         lNHmtBvaOJ+wW/GRNZjDbTwt4Az2AMK++A/A04qIDNerG+qlYNlMFGtwaG9LWGxcdipx
         FZgdQUOm+OiWwV5b9DgTqGALKoQL2g83vOArOLD4nGYUCpYHf9LEEfh4O/TS2v7j7lTS
         QP2g==
X-Forwarded-Encrypted: i=1; AHgh+Rplaq20ofSjAUKkUsAJhqe3H0N/km9pa3J3u6BjbQG1BSyYHNZxuGInrkn3AavDNIEL3xpb5yA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/8wg+rQqRZCXYf6D2qdkFMDYs/6WDehN5hKacA9RjuoGoZWee
	umEcDJ2UfGvEk++w9FGIXb4G4vHtEKlW4geJWgYpYeAwXSGMTJLv4u5S
X-Gm-Gg: AfdE7cmFcvdgO+UytPKunzb0GVWWgKPnuFPvNYFCwCptQnjH7eH7j1tTZe3u5Hs9iZ+
	WKUZvtjnCc6BCi6n3JyucZFQqf6F8XaId/QunJk1zdN7n9ucETCZnHkJUaT7z8P8Rep8SPnPeQS
	ng9I4rbb3sJeIXOusZ1ECFKG8z0XqvlSZdOokHfe/l2R8F2tot862uikgxF3KGw5eVzpzOnPcFq
	FvYobOaGdflNKd5Ycn6dODWWjGAR4URFOpSa6NDcRmpJGHQXiCFfyZ247PHYFGwjHx4neWWvk1D
	mnqSUhLceBasSgtkY+oAsnQC0OEmJK7q56KWspcns0NMkcSz7OM/XkJVR6PxWVQJY8B33pr00G4
	LPKdHTyW29jz3Ii9NCbN2sqQodBTghBwcgni6oGbUU1YZbZFNhD0iBLWMg4X8B0qd3YCKV6wMNp
	iqN1+ky7s+TzKx1arE4pKEVmCfym53a1Zui0FPbHetwqbNAnvKi8x9yU7SgRqZnu5xR51TLOxN9
	5bzbpI0nBVSm4JF9x+pZSQe+g==
X-Received: by 2002:a05:6830:6518:b0:7eb:21d:70b9 with SMTP id 46e09a7af769-7eda0e701bamr9566145a34.22.1784667432329;
        Tue, 21 Jul 2026 13:57:12 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:11 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:50 -0600
Subject: [PATCH v7 01/29] params: fix a pr_debug(" %p ") use - already in
 MM-*
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-1-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1125;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=NjeO3E3aXTlf0Rmaw0bPO/yZw26XHF8e4PdgxVbvO5s=;
 b=JnG4Hd6pByV6cBcRHCdIJRICgp5wUjzEQUOylmvD27efVdhP0Cn/ay5LhcR7goGzLrNO9vFYm
 yTpsgAAsjCpAWnQCPpIRZXIEjFbutFhwOQKtI2azaOPhH5Ccc68vKuf
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

NB: this is already in mm, but I need it in this patchset because
kernel/params is subjected to testing by the selftest script, and the
test depends upon its stability.

kernel/params.c has a pr_debug() which prints the address of a
parameter setter function, this is not legitimately useful.  Since the
value is known and useful to the user, print that instead.

Cc: stable@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 kernel/params.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index a668863a4bb6..5c8a05921e28 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -136,8 +136,8 @@ static int parse_one(char *param,
 			if (!val &&
 			    !(params[i].ops->flags & KERNEL_PARAM_OPS_FL_NOARG))
 				return -EINVAL;
-			pr_debug("handling %s with %p\n", param,
-				params[i].ops->set);
+			pr_debug("handling %s with value '%s'\n", param,
+				val ? val : "no-arg");
 			kernel_param_lock(params[i].mod);
 			if (param_check_unsafe(&params[i]))
 				err = params[i].ops->set(val, &params[i]);

-- 
2.55.0

