Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88637F30E
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604302; cv=none; b=iePwoUxOQWsYCwIMeXXiFrsvgae2Kp2KLA8spM03CFEplGE0jiGMElaEPQGfqy5aH9wLFWaXFlVs8byRK3h9AIzsGgVXJW4CbpkTIiAgeLjPQICsJRvlqmLrBzCB40aHtHX4nSWNK77V6LkiQ9VKgGB0E9/FrchaEWCxzizNODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604302; c=relaxed/simple;
	bh=ArA+w71w1BaEj9a+G3Ctm79DsTHOAgfSfPNsAtEyqFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgiHmN0q9LffhgV97emV17D5ftaTZkpbhB/mVjm5cIjv5IxdUYajmw7sVFxcDcOkwZrSIxTHdv9i6P2kvTdxVaRqW7ZmAa2QQWXqJQAfp7cYOcthStjt9qDXYoJN+od2GvyoK9F3VFmuh+myGMh9mofJUri0ADG+G/VhNMJDG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0f2ju7w; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0f2ju7w"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bcd17f3a93so226975e87.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 20:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791604299; x=1792209099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oHTcdU7BDJRK9HJIi4NfQxgJw/5DvdcfPlbURZ+9Mwc=;
        b=c0f2ju7wLux0deMtGRTjh7mrTXUx/NkCBhsgy3dpEE8jZgG4XUeydApj6WdXTUCCXp
         noYfti7x65zfUpTtk7XiQEAo4JPI1ffZnk7Y0FRAVt35ETnuZqNfOjo1jDo3vo8dMW3i
         AkfKszqRy++qEph248hpj/NbX5l7HitxShJYxCuwTZyfjSj6hFz2bjJrapyKtCKYQJBF
         KAeSUF+mealzPMMzwfRP/g14cSjbd+D30VXWOFW4S4fg4sQZapf0rS6AAy1wHbeRy9rc
         3x40WfZ4Jx8OKYKFBsKh/DlHf3RrL4gI+Ps+ePeoHZSnHoAZ1fvyI3uC25+GafryF5cN
         XMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604299; x=1792209099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oHTcdU7BDJRK9HJIi4NfQxgJw/5DvdcfPlbURZ+9Mwc=;
        b=FdoTEZYclmIuaTJKJ1/XNG17WS4GtojK8GHY0vXmckMpVS2govYsqIRqRasVETklQk
         u6Q0z0fUL+mJ+Z0BkutWH0xHkibSiRVsQ8BodTZNXxTVa53MM5jF/HEAtXW3bNJCOxj5
         +W3JelxejWPf5Vy1Kocr35igHc9jn93S1KVUGlzpT/2aRJrWNVq0L2CmIGVCvV2tySWa
         +4tz60ztaT+scr9KLa1vQ2Qwn8pBbfKuFrBw4ht1Ty48Ru1EBgjneyeGDZ7655gPQ5T0
         RR3IL8lSzwaZodbCYhaAokbak9lGw+1iOI2NHLCcgW69vSGHz31X0TxK4n7bRttXCs1J
         DKaQ==
X-Gm-Message-State: AFq9FYIJ02nrnaEXDzJQNz2xFwDmyqgz8ROrQF+BPBY08k5EgfoHv/K6
	OyevPihwGbqRCfm1NSV5xN7mtyECVpPacYIPO6nc12fe4KtO2Raj/zVVDDskai3ITb4=
X-Gm-Gg: AYBFou1vU2IUkz88cvajFk5p80aR34D9D+BnAKBG+IIa+nI7MO6YFoE1pnukmUTjJWv
	EExoQNq37WFjXdBJCxlpXmhh9ko8DMYLfLUi4H3iBD+9RGt7tckgjGQNN9BiIhK1vKX0FK78EkS
	c30RURaUhzVG1gv6tRvavOtjwZiiffPXyPObZe4Az71b8/yJeylbSTlJQkwBqWejUYCvObJ8m6W
	AseEFNPBOePYjCMohrst10uxVtQYzUphicqqyA0SHsx2YKMsTxphdsTePrCoQjbFvMn0s1tGNzr
	U1WzHGyjf0sx4c+52S7C0LdvpcFneMuViUfsDYVBXQzcux6y42yjECdVWv03fPxT9n9MWTtOdY4
	pOAQy0uf+g6nqHxOo93NzBM9sOjhbvwkpyHwj0MPB1z37vTgqyhvqWVXdab9oKGQfoov7nntjuN
	h4qw9EEgzsEI3lTwF/RICVLmu2l7tM/vwZv14VrA+YiBODA1Tezj4MBukpr68egDBFzsmyFvP5m
	+de+OXtqXKeis2iftY3b0tchC493RKOOzwv/LEL0Xc=
X-Received: by 2002:ac2:4e08:0:b0:5ba:3f72:3c61 with SMTP id 2adb3069b0e04-5bcde8ce984mr1402306e87.62.1791604298863;
        Fri, 09 Oct 2026 20:51:38 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.131.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcdde9c924sm1161984e87.36.2026.10.09.20.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:51:38 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Rachel Menge <rachelmenge@linux.microsoft.com>,
	netdev@vger.kernel.org
Subject: [PATCH 6.12.y 4/4] doc/netlink: netlink-raw: Add max check
Date: Sat, 10 Oct 2026 06:51:16 +0300
Message-ID: <20261010035116.578385-5-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261010035116.578385-1-littlesmilingcloud@gmail.com>
References: <2026060807-egging-prune-a3ae@gregkh>
 <20261010035116.578385-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Remy D. Farley" <one-d-wide@protonmail.com>

commit bf5a54bc0e3d8962474fcd611f1266eba036232f upstream.

Add definitions for max check and len-or-limit type, the same as in other
specifications.

Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
Link: https://patch.msgid.link/20260303195638.381642-2-one-d-wide@protonmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 Documentation/netlink/netlink-raw.yaml | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index d8ae7f7365b0..d6d58ac63b7c 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -13,6 +13,12 @@ $defs:
     type: [ string, integer ]
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
+  len-or-limit:
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
+    type: [ string, integer ]
+    pattern: ^[0-9A-Za-z_-]+$
+    minimum: 0
 
 # Schema for specs
 title: Protocol
@@ -270,7 +276,10 @@ properties:
                     type: string
                   min:
                     description: Min value for an integer attribute.
-                    type: integer
+                    $ref: '#/$defs/len-or-limit'
+                  max:
+                    description: Max value for an integer attribute.
+                    $ref: '#/$defs/len-or-limit'
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
-- 
2.47.3

