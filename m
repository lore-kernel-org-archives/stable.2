Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793566689;
	b=JYn59PFS/SEd2GHpM7K53pP5M5kAX9YkFlvhwn/oEAPdkHiaJmtfNVhmyzbFW7QYRUG6
	 vX0Ylw+6oM7WgZpC0/sM21sAgALz56BElbwyzxGwLfmnOK1rULSIwYtx8F04hUJzCDh3P
	 uCFYpbP6gEScq/yFWq9z6YKGN1wtyC85hZ7JO3vPndhHYoHoKVgKs/wNdyUb1dcLXPyyH
	 S1vegjmwnyWgubhnCdtX8lWrfMTH6AuOcEtpfxkTK2T/qrQUBwqBAKsGQ4cgwQKo50WDr
	 1883qtyUPdKbA7qGrdaHP7b2xSXx0yyzlhZET9xjAD8zfKMfqrv7p1+OSKKNqg/z39Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793566689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rLQnSUGCT9AoEeSMPunujD66mYyzWc6DQOYtm8J5kh8=;
	b=G7G63Y2FwHHCNyLngy9vKtW/73+ndbE/A/BeK4kKuuzjamyICRRCyLAf7KOU3XUHu96t
	 4yNCnqV9SNG9Wvb59b3FneCiF1PH4o4U4d/C4FDE8gVPCoTXTVakWuuYsT5XQGLUozUHZ
	 v3bowo+MMUjxkdKLuDBMyGy1J9du4H2NhwLK/xDniNKPHsUu34s9o1F3W0P7yczmmnhCV
	 msdPLDVssT3V/N5rksgKKbCog0x3DtbLUcdSqMIBSKYr+rqhG8IWqW8QlhFYafmhjRWDI
	 hDcEIDOkcwuNIjjhgprC1ISBJWJjMN/fz6QTo+cvVb9thY5RSxlT/VH2usfp6gHMcig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e2qI6CUn;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C982606A327
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 20:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C982606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e2qI6CUn
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso23090505e9.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793566686; x=1794171486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rLQnSUGCT9AoEeSMPunujD66mYyzWc6DQOYtm8J5kh8=;
        b=e2qI6CUnZ3aotOnqIvC8QILPds9SrwHY00NEUcbxzP6NsvYFSURfUJ3iTKg1w3ALfb
         zDXd8gfvXOAWe3WPeKwqxzm+ceirz/PUTkjSXKwMdaUJItt9j8c9c2ynQ1vn69Q9g7I0
         GWRl//DupX/Zs0xz9rT5nmggGpqelOdj/iDV+swzYv5VsmXy0Q9wAXI8m3CKzWoxvbBD
         g6dFJH7olniFyoKhBApFiBRbh5+HKAj5DOAV9k/agS5moqqylnrB6dzNmR47C7JkEH70
         zDjkHNZAEB6dnqUj93bQVflyvpn+nmhBSZwoWWA4IjuhtVYD6IvUNP46usgvWH6SM0Cy
         Pyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793566686; x=1794171486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rLQnSUGCT9AoEeSMPunujD66mYyzWc6DQOYtm8J5kh8=;
        b=U6+h5wQW6/6bCIHyLRTIZ4VwpyNEYAtqP2ZwyZ2u1IqVK0d0/sJ7vyumrZYV9yKSCV
         RS40xRfpPlfwN1kHXeyU13jUOvp1wuzHj7lGHHEyTx31OyNhkg+FPLAecPOyW3g1DQ8i
         cxOFUzxCUdbueR2wR6/V7r8QapWGfFUSb2mSfnCEgmxmUgACSuvt/sbAkhYW1M7i3tnJ
         hs0gAw/WcHUbCcEmqojxxizjsMkdsB0KidEF/oeP3ueRg4B93Sm49mwYjPVzJCnmurJz
         VHwIlprouybpXerp1N9NYKYAXVytiD10hxqQPYxjAjOhLYdvcueBOkul5LUwiPDjjdGH
         uqAQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6QPht0Hi1858ZDnrhtlsoGTlBtn7PaNv0lap6vpwStyyM6lSyAmfN4wTL8l/RH6mf50hSZng=@vger.kernel.org
X-Gm-Message-State: AFq9FYKW0jfcxOOBxrdt2ZcaQ+fvAZfWorTZHUueg1e9/uQYEM3SFflB
	S8r/KqtJ1uxa7QqU4U4KphKWL/Txou+NO6n0TJ0GiOKFVQWoXECchNI=
X-Gm-Gg: AYBFou11cekvxZCD21YeiD8E10quXWJMHLYnHGXjHVAkOXPoy/CxYnIxg71/cjVKoLP
	L5an03mX4JPrbfKh7XnrNFI8t+6juTBf0J+Z/bmIJy86bR/qnA8OmBd761KV6j6YPdqC48PDR37
	0twQbD/mXrC70qDaewp99LV767EV2laitIn0VbQCHqUhrvG52g7OH1b022FLFtsL8aFBbMlgZCQ
	5+ek20reANVjahhKvxfeXxselsLmYXkdmbiz+DTHfwaU5vFq//QIjxHmc7NypcXRT4e3ZS2yVIL
	K6L5kpUrc9N/PkoDW30Qo5OxUA8IfiiTbWOvrlRx/vorSHcbvjcg1pkAXYGFXDNxYeBgNRffjiV
	fFsEs7Jpqsr5eCmYG2WimxJud9JlUJrV6CBKrXToKEcwnflMYGcbVKCULWF8sGAd8HuRvUyiMQd
	XJdfH56E4eD5p/A70omK7Q7jvZWgVsXHwzYfccMVxRND6711FFZcvxStkOkarnR20eOITBNnHfO
	CRikzsSx7vUByrjFL58zkc0YzielBKE0XXNwmHyxfM+r4aQGwEZ8C2ntXkhA2jwYLsnlgdOWRh8
	E/2r/RPxaYIlbyjxV2Q=
X-Received: by 2002:a05:600c:6212:b0:4a4:de70:2ad4 with SMTP id 5b1f17b1804b1-4ac17ffa395mr177259785e9.22.1793566686402;
        Sun, 01 Nov 2026 12:58:06 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9eaeesm16002280f8f.49.2026.11.01.12.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:58:04 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 0/3] wifi: mwifiex: firmware response validation fixes
Date: Sun,  1 Nov 2026 20:57:59 +0000
Message-ID: <20261101205802.2909524-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

Three input validation fixes for the mwifiex driver:

  1/3: The ADDBA response handler uses a 4-bit TID value (0-15) to
       index an 8-entry array. Values >= 8 result in out-of-bounds
       array access.

  2/3: The multichannel event handler uses intf_num from a TLV to
       iterate a flexible array without checking it fits the TLV
       data.

  3/3: The IBSS connected event handler replaces a buffer-bounded
       length with the TLV header length, which may exceed the
       event buffer.

Tristan Madani (3):
  wifi: mwifiex: validate TID in ADDBA response handler
  wifi: mwifiex: validate intf_num in multichannel event handler
  wifi: mwifiex: cap TLV length in IBSS connected event handler

 drivers/net/wireless/marvell/mwifiex/11n.c       | 6 ++++++
 drivers/net/wireless/marvell/mwifiex/sta_event.c  | 6 ++++++
 2 files changed, 12 insertions(+)

-- 
2.47.3
