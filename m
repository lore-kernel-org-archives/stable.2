Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794757833;
	b=obyKa1X5QKR+H5kxSiTYxP1C6FvxlC7qRwqb3JRohDaIy6SFRaeJgZAFHPuXnNZm0TXR
	 +qCjty+fANdROo4qC193fKjbdCpOi3sGFzt1IuN2iJQ7RC67ciTm1Ttn4/54fVLXuLHHz
	 kx1j84z1LiPdL5yUNJvxkywp7qjfHgcYwIvcGBwICSWhV1Bpjy1PE+GkmAoUi0gB65KNV
	 6UnFmeoSmwKGuyiLFUwCVSv0Ozv3UAF/d1ZjAsGwW3btILt+df/9ToBBvfJ0Vsq4Dd9TA
	 /KWRpsrXMXln0XdL8sA7IJldBZax8LkaA/VJxipu0MPzSC9XISSaU8UQF9t+CjkDPsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/PhaNSy9coHnaQyrzpEu4F6oxj7CCEXWUr77VrKeBFQ=;
	b=tBq/VHUvUU0ynpjdgVElfL+DXWN18/BE1athHX9PKAS5X5wNSc2sA5uSyLROgYlfSsaP
	 rMLGtOFxg7tuGK6atpsmJ1VImW/jozwF3BqE3x/iz2yM5wsBvpXDRDBFFMVBqFJ/TLavr
	 oPGBSeL7yOSkpevaqiJKBxEmTXCa+09NNxa0Li1MGvQkutk/v8hm91fgQSarxPpkB6jvK
	 YS1gxEV+1rvmPJk8V1a/QGtkgkzwhScSEMCYE6fQ7ZtPrOvh613bv6sot3lKdrxwD7eRI
	 cbjwzpeZv7I1ZP0CGRmcQqR1qYFjYu7OpQyV9CgLBgC8Y9n4Ev/lPIrrsyNhrJGtf8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RhK5fzVY;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90319606A31F
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 15:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90319606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RhK5fzVY
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3282db206d3so7853494eec.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 07:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794757832; x=1795362632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/PhaNSy9coHnaQyrzpEu4F6oxj7CCEXWUr77VrKeBFQ=;
        b=RhK5fzVYiPoen8qtpdo3n7NLlJOuG8woWahQeYq338fQj7LKDngxf5J/JhhkR8LEQN
         AfZxBsfrEqXRpC07/vWF1P3Yaqj2cN64l6/Ds9fOoV5iMJdXillL6Yo7mR/MP0Tp25FR
         pWfx4iUriMbhYt/+WSocDpR029emJ779asRkMTG1XzW7iQgsdW/0GRkeZcphvCm18Yre
         q86UE5h+9egVRVge6c5nbuSNpWg3qUqy1ItsqbE8MrydgzNmfc+giKbVgyhFX2Tom/vv
         A80GFu4GsUfOfheXpF5MKTJm09nrjJ5P1z8KydNNaZBvJlrdX4uAB22HULO6BVRn7KrA
         iy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794757832; x=1795362632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/PhaNSy9coHnaQyrzpEu4F6oxj7CCEXWUr77VrKeBFQ=;
        b=jP4/FqTANczh03pzIV7TVaGCdE34mh70DwpfYsfnT0K6QiLQUig3R9MlbPKmFcuxZb
         38UYlK9Syb9MDhKT1rLnMdWGgt4dN4j6jDisxfa5OsweFeUHtiNMo7yf4OVjBbis6YMZ
         cUxkXPWXhFANq4dFQ4WL2bH3GhZlCobLX1CAmzFxzZ3HUZoBlyHNKeJHOzZZsphYCQVZ
         XtkG3jK0v+zy/G74e+9nBlX/qQ8AHTax33F5tV4w/z6NSxlyuFxZA+spXF2hpjExW5eK
         zyGDBw9QAuJmGU9xUNdbsBW36ypH2XUx23c76W7AkNbWdGTDcyDGgb5T/D/H5nG0Jaac
         KjgQ==
X-Forwarded-Encrypted: i=1; AL+hErHclQh7Ra/mMZt1Rere0WhiyjdURVPirGoI6oyg9sN2Y+4F5RULobjBUOzc2Hv/bwA/jowtSAY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2a63ni8cONvpdHZ2Dpd8G+FIMy9SrFZF4UToSy1l1YfN5AVwY
	6PsFwpqCOYFiboYoZbgcvcMYaiAJE2ftLojEZXv+xeVVaL9tEjlqoqgu
X-Gm-Gg: AYBFou0oY8DWZP3YrHoIigBwGipgQ6CfM8JVSL1I1NRDWZTkyvb0lvqvETfsC7wtikR
	HKbOtS7mo6x+LgnZS4A8XSQiOXdYAeFc/knLHck123AzDYG/gsq3ZlB4wo0D80zx/xcIrolQ6xN
	c5FiLrOZ5Pad5oK6bsziBwYCWWJNitSd8D+nGdcJwBbnkHRMf7LL35oQjolCKUrQ+xzoMamiSVF
	b8MkGqJ//OU4jwRal29OrvrY+Y9CjH5vKfrArjR5huI35iGUmfVsJaM3VpAsPZoxnCcfArUH77w
	I1hXTskMO0cyE4nqcS2lZ/O5kJmGl08od/mSLz+gVH+y/+m7mKkYRUnj7MpAvu6gMCeHwlxZCfn
	A7zoppIHjhNf1oiR9mDxDoMqhjj6CgM1FjpymALwHb7FxCfzJNd5OXWcFMLtTRCo2EsfZKD8m2g
	YrNlkt95EiW8kPbInP7Sk25lFZJqieiNn6R5ToHDdKOpZINkBkcJeyGnX1rJOu+Y6+h49MTnEV6
	wZHayQkI+Yr1EsymnpgZzxze02RsQDxzBmSXeNAvey+S7vU2R9zEJ7jGWdnL16Gu7nZ36edMyJ8
	dNdbnZGLqXMxdf5C0qJOiPrxu5ZkC0Ca4/3+vHQ7rCiDL/6D7lnH7SjJe2pj
X-Received: by 2002:a05:7300:dd03:b0:36a:437a:4c00 with SMTP id 5a478bee46e88-37967314a08mr7409773eec.24.1794757831293;
        Sun, 15 Nov 2026 07:50:31 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:d1be:2710:af83:9beb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm25382225eec.10.2026.11.15.07.50.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 07:50:30 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless v3] wifi: mac80211: parse wrapper TPE elements without an extension offset
Date: Sun, 15 Nov 2026 23:50:00 +0800
Message-ID: <20261115155000.82185-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
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

From: Zhao Li <enderaoelyther@gmail.com>

Commit d160663ca2fa ("wifi: mac80211: fix TPE in channel switch wrapper
parsing") replaced cfg80211_find_ext_elem() with for_each_element_id() for
Transmit Power Envelope elements inside a Channel Switch Wrapper, but kept
the offset that skipped the Extension ID. The parser now drops the first
byte of each element and misreads the rest.

ieee80211_parse_tpe() takes a u8 length, so for a zero-length element
0 - 1 wraps around to 255 and the parser reads past the element. Received
beacons are parsed this way when the BSS table is updated, with or without
a connection, so a frame sent over the air can trigger it.

Pass the element body and length unchanged, as for a top-level Transmit
Power Envelope element.

AI assistance was used.

Fixes: d160663ca2fa ("wifi: mac80211: fix TPE in channel switch wrapper parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Changes in v3:
- Send through git send-email; the Gmail connector line-wrapped v1 and
  v2, so neither public revision applies.
- No code changes.

Changes in v2:
- Preserve the author name in the mail metadata; no code changes.

v2: https://lore.kernel.org/linux-wireless/CACHPgzyxGEYJVCyGH6GJBvUdqG8zsfyRn5zxDiuj14tw3byXBw@mail.gmail.com/
v1: https://lore.kernel.org/linux-wireless/CACHPgzwtaykrULWEDNuWU0ZacnNf4s4uSsiYmxE_vJhS4jO0GA@mail.gmail.com/

Tested the in-tree parser with a ten-case KUnit extension under KASAN,
applied identically to the base and fixed kernels. The base fails three
decoding cases and reports a slab-out-of-bounds read for a zero-length
nested TPE. All ten cases pass with the fix, without KASAN reports;
the existing TPE suite also passes on both kernels.

Compile-tested with no new W=1 GCC/Clang, sparse or smatch warnings.

 net/mac80211/parse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index f3c5a9f6ec7c..7564d655919f 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -698,8 +698,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			for_each_element_id(subelem, WLAN_EID_TX_POWER_ENVELOPE,
 					    pos, elen)
 				ieee80211_parse_tpe(&elems->csa_tpe,
-						    subelem->data + 1,
-						    subelem->datalen - 1);
+						    subelem->data,
+						    subelem->datalen);
 			break;
 		case WLAN_EID_COUNTRY:
 			elems->country_elem = pos;

base-commit: 831e33ad02ff884ecc793c07a9c9bd9e06941fe5
-- 
2.56.1
