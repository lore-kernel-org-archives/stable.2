Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459345;
	b=OnGvT7ZEd4fCzor5sE9OUL8reVYkdOjDSaosq54x7r5cw2f5s+UZ4BHzulZc4ptMMZLW
	 Xnq7brC2se1Xs4Cziaw0smVQWSd10AnZAj57kWyP+RH4dzoUS+C4oRLBkGlCwH5QsFV/R
	 FcP273xVYzA29e9uGkVr1TQRQDiZOVEKANfwNEodYFc9ZtoFPsjnGCr4eupvNCs2XW22J
	 hmaOPOi11kKUckf7SwGHgW4Lyc9kFpNIKMvGH963chAlKJqGiWQHivj2YCcHh3Gvxh9Ix
	 EAnv9TPsSqN4iTKUCX6/ET+tayVDWDzscRf/9+JA+pQMBMg0Mom9D7onUBXsKd1HlIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459345;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=G+PkNyLgfk5X4yvRFeI0LZLIdag/c+pOkjeVXeRQyPM=;
	b=qh7G6ca4dAs5RgcZJXGkcyIhdZEMza5LOJj8hoB5bkgCcoG6hng41DZ3NPN1m5Fj+XxP
	 /c4glLBwhiyToJuUtmSYTzd3PZ1/Jwe5ed3BQ45UkXJSaeM13GAAvpT0u4vMxWhA6Jyli
	 e8G1SvOj55ahuE0Qk/wxK2FqzHjK+AAPt0jvWdPhorBobn5EMzoxLsBbyiEqLGyV7/Htb
	 FTqO4yytTrwrSx1BFRYqI6cI+eoqAkpt+6edmEfFXiFl5FhypGtQVLLWpuDCfeZMeeBTD
	 zctd94bj1h3DZm1GqJJiBKCWIA5ErHExJjfiobMxeqXUWyruNaIqmWnpumgb/t/HJrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPn0exm2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E31606A31A;
	Mon, 23 Nov 2026 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPn0exm2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459345;
	b=fKZJVccxH5IViAHwtZ32XEg4RY0tlnA+GuUS527Tx88iDtyPfdhfcbPpk7GyVzkM9A8h
	 IREDvBrGB0MnBDC1ravNkdpAcpTd9dESYxeOdUfckBSpX6AIqhtW1XpuYrCx2zpC0KjtE
	 pR5/TNiIUhsov30sZryDWZrhh7BGHZwbe/JYwFlzshaD1ZRgvaYeUWlwfTCobNGIgz8D8
	 d1FFsQBaubNmpbvBPdlNtcDHuZQFrX1c7HXOFJZD+BEl8gWNRfDsOf0zVgYqYxLVb5gV+
	 H7Afzju2PeXEM46riOUaudvDHcta+x4R0s+NFC8LJvB3Xk8qtZGL86kN6XqoAmbpeUQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459345;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=G+PkNyLgfk5X4yvRFeI0LZLIdag/c+pOkjeVXeRQyPM=;
	b=VrTI0FKSyg3N90JSrQU3hRSgsY0biaDtC08nwljZiF+XcYJPyw8uyu9Sdu2J3+McJZUW
	 GSrzZCUJhyw65YRcuQ7c4NaR+YTSEiKAuvySWgdbzkAMIY8ZW0TyeWc+HhjbdorhE5NFG
	 0VLYF6vhOXzH1NHN0P8mm+o0qyjRrEn6WSMSQUBuU1PB+fM7k94GThhhIYxUOa6lpwa63
	 tT16pj6LCrqC5plEY7VUWemT7bDQZ2Icg4Z50lZBoBImkZqghAZ5jANKrI70JujBBnZFt
	 rhieZ+InO0LY38i/kzqXlEoiwhmRnyCJh4zV2oKVFVBXTCoKRKdyne6k5yR5GL5ijBQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6D4D81F0093E;
	Mon, 23 Nov 2026 18:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459345;
	bh=G+PkNyLgfk5X4yvRFeI0LZLIdag/c+pOkjeVXeRQyPM=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=DPn0exm2EftjDpV6LXwTVqxPy1EzFI4KiunuIS1N4/XJZ3VrjzV3XqQNmVeqg/yxo
	 Cy5Sfb/2fBjcNBhtAaNDmcakr4vbfGi3ZGLlEAxVblh0CsMF254t2xFmKAc7PjPZg/
	 79ZxqkC82mAH2A3fj4yS4kUWPYe2QrxbdZgPjj0h7gw5BYxa6l5imcVNtnAi1VHkG4
	 Rqyn7c2XLNsfafMEgci7QsduaQ+9TUJmMmwFkTQzXl+9qx50H7Pa7qXlJpEB5SewmA
	 O97d2iz/tmWIZntSQ/JQUqxYkulRGC8tGgleUtll7OE/rFI8h9X0Z3H8WaiksEpK6A
	 14woPEasKObSg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 834584C5A7;
	Mon, 23 Nov 2026 18:41:45 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Subject: [PATCH 0/2] Input: sx8654 - fix SX8650 reset and status handling
Date: Mon, 23 Nov 2026 21:41:44 +0300
Message-Id: <20261123-b4-sx8650-fixes-v1-0-b82a881b971d@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNj3SQT3eIKCzNTA920zIrUYt0UE0tL06SktJQUc0sloK6ColSwBFB
 TdCyEX1yalJWaXAIyRqm2FgALnWJKcwAAAA==
X-Change-ID: 20261123-b4-sx8650-fixes-d4995bbfdd79
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459304; l=1195;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=fOKx4+gCcDyeBd94X9G1hP6GxrLI5moZQp1CGVh7qmk=;
 b=Qa1kbX5hZO3j4z/+XWtTl3fu6WLuAZ5EjS8JDJb5FKFxyObXFt5ngtF44SLSfh1wexQIV6XHm
 ROzscsE+D9YAQn8pi25u2QP4VvPR+3P3b20x7bf91QW77o3Eiu+orwQ
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

Fix two independent issues introduced with SX8650 support. Its soft-reset
register is 0x1f, unlike the other supported variants. Also retain the
signed SMBus status return so an I2C error cannot be interpreted as a
conversion interrupt.

On Almond+, writing the old reset address acknowledged but left CTRL2
unchanged; using 0x1f restored the documented reset value. An isolated
harness using the actual driver helpers exercised 39167 cases under
ASan/UBSan, including negative status reads and both reset paths. ARM
built-in and module compilation passed on Linux v7.4-rc4.

These fixes are independent of the Cortina platform series. Local
OpenWrt conversion-rate and recovery policy changes are not included.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
Fil Dunsky (2):
      Input: sx8654 - use the SX8650 soft-reset register
      Input: sx8654 - check SX8650 status read errors

 drivers/input/touchscreen/sx8654.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)
---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261123-b4-sx8650-fixes-d4995bbfdd79

Best regards,
--  
Fil Dunsky <filipp.dunsky@gmail.com>


