Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795836346;
	b=f9PrzPkLFklH9z31rIgJOpkrT2FPY64+QJh/sGECV3diLZjX1rtR13cDCdkj1AcgqGsi
	 Nz6hg412c7emCBno3NSNhCqDE+Sz6jmhDi4srrTC2jgZlRG5JVpFCvxsiBwu8X2B8c0+P
	 +cAJ6FxV9aojR2i3b0N9zgQ0t8T9U6u/aiNiNfpqpt+bFg8mwJmkQdewBJTmlDOxOsWcU
	 Larv7m7FSDxJOSxNYcbyzMcoM060A9Mbpi90hNSazC3KBJEw6Ca0GMWZj5xYwpg11Kt11
	 kQc1ChNeziL8zJcmnCEly8aQeQwroLU8RnoQqTGPhSqMwaBH9mEFaHCNiuFbLFcwGlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795836346;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=nzpsLzqXf6sPFfruIMYHCD9191WrOb+tGRiWAlSoemk=;
	b=v0bfjlTK/DrhT1JK2e6g2Qvn8MvQI3+1vT46grcw3tORsSYMl4CGFEwciKBDsFV8q/z/
	 icfhATctw1ctp5rmEnyd/46/XLdq8pleP88f7cI5EGncXX6EFb0hn/OSuifumwzufKG4V
	 S9RPgp88xCSk7o4yP9/AUHM9LUoeLGCnVafi5A0pj3EsB34fdHrBfVFog3n8lhe9fucWR
	 9lUyjA5yWGv+LCo5WAwAqtQiZkHkVIabgAq68NtdBtO71mqeSBVymQZbCkxyo9Tk0kGbD
	 wgy0HyEsPACjPVMYMIAGugaO/ggJZ/739nah8OOAtufbsc51XNf1NrNd/8rh0CgDQIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnrImfpi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B5606A31C;
	Sat, 28 Nov 2026 03:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnrImfpi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795836345;
	b=3ixcphRu08AxJnZeyn9PLmJG2gVaAGlmhw8Tuo8giRV41VnQCZLORnENQ3Xw2cTRqfFo
	 rZRl8zYEyuSl8gU8nxkcDx+0cePy14NYY5XBZTrtmfuGWw0nLiiMnFeyYT4MoK2G5wzQw
	 Wy7zJVssVfy97yQDw39HtWe6kPCfLCJWYZuMe7kwyXvMmnXATwT4l5ENWyC2uxk5dMwVy
	 mcrlI4SJT14Wml25MASUjAfWqEgAMps3gxP3DjYRdZSHF+0IGXHdjpLJleeifvfGHqbmb
	 Ffv8XwVNotj+VMlu4o1Y6ZjZw4RknKezFG3OupV+FvUw/RnUWm8d78BCkLbJNveXvhQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795836345;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=nzpsLzqXf6sPFfruIMYHCD9191WrOb+tGRiWAlSoemk=;
	b=KzzabviFjvAeWIXO6a+IxL7EyMg//PLgE0uMBkrfOs2yHBX2b1vrVQyUSCiSt3dOBr0b
	 dty6ulgwY6IJbrNIArdWe7EIPeB0Dx6TgqE+2gK7YU0Fettu6DcmsM+wOC6XN+TnX5ikV
	 5TGXZKMo+4C5ahzTDSbzgCymJ77sGiJ+cVYziFx4aCPp9i7l/5r6uOv1n1AqtuaGbnOn1
	 XRE/cnlcdBRvctYadJ6vA1o2OcBRECvjDIVfREdUSJIDTgimzXPEwERWzzxduIDZaL0Q8
	 GMp50pG7bbZTgwIygupIFJZebws/NNS5Fu7NEfx8I86TQkCy6MsS+i6tilyUcezgVKw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0E5331F000C1;
	Sat, 28 Nov 2026 03:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795836345;
	bh=nzpsLzqXf6sPFfruIMYHCD9191WrOb+tGRiWAlSoemk=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc:Reply-To;
	b=mnrImfpifAQIwHQJSWDcqIIovyf/X3mkOMJfYnqJOsvWOVcYALnrJ9AtnEZJZN9X+
	 xQnn3RQq8mAoA8mE8gxbovuQ9Utu9KvFo2iUEoQBiKYK3YzNcVS3VZaTPmf3rzj6o1
	 IpCfl7EtIGHINJ8pG90a3Y/mq4R1iiWbV1UcmtVyrC8EEmpIYvZXlfDboGHLxIKlvZ
	 lRPPWdXeADY/7MhtiKDWcTHJfySzZilyGyQ0q21iokR+CUq1J9K7vO3C/JUlVApjt0
	 YgFczZ0lKSt6rRmZwy0XuXNFJN4vqV8pxxSyIear1ulLH+DEftp3b4IGgWn3eR1hP1
	 8m1YxNsQ7Si3A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6A06E4DF5A;
	Sat, 28 Nov 2026 03:25:44 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Sat, 28 Nov 2026 03:20:19 +0000
Subject: [PATCH 6.1.y] iio: frequency: admv1013: fix NULL pointer
 dereference on str
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261128-admv1013-61b-v1-1-c9c20290b9be@certik.com>
X-B4-Tracking: v=1; b=H4sIAHJICmsC/02NSQ7CMBAEvxLNGQePiczyFcTBy5gYgR15QgSK8
 ndiuHDsUnf1DEwlEsOpmaHQFDnmtAbcNOB6k64kol8zKKk0ojoI4x8TStwJjVaoEI4obeg6vYd
 1MhQK8fXVnUG32L7h8sP8tDdyY1XVojVMwhaTXF8RU/JjzndR+fb/ApblA6Mm9zqkAAAA
X-Change-ID: 20261128-admv1013-61b-2ff910bf4467
In-Reply-To: <2026050125-bullfrog-earring-0c74@gregkh>
References: <2026050125-bullfrog-earring-0c74@gregkh>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795836018; l=3298;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=acstfVNnYL2yFV1bAV5V3kbzxfSp/mALpENhHosfVzE=;
 b=/75Jkk946WcbJgqEtH/uIbE1Ldg/SYaSC2V5alserJC0uMI7+rNaWiG+45XE3FRmC8MKUukEc
 4jjb8FZk/HjAnFgmejOirpt4FBDI/HF3SjceV0N88VLHlX+87eAAUTS
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit aac0a51b16700b403a55b67ba495de021db78763 upstream.

When device_property_read_string() fails, str is left uninitialized
but the code falls through to strcmp(str, ...), dereferencing a garbage
pointer. Replace manual read/strcmp with
device_property_match_property_string() and consolidate the SE mode
enums into a single sequential enum, mapping to hardware register
values via a switch consistent with other bitfields in the driver.

Several cleanup patches have been applied to this driver recently so
this will need a manual backport.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ adapted to 6.1.y: keep strcmp() parsing, fall back on unknown values ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
This failed to apply to 6.1.y, which still has the older property
parsing and the original register encodings. Rather than pulling in the
enum rework and device_property_match_property_string(), this keeps the
read_string()/strcmp() code and only looks at str when the read
succeeded. As upstream, an unknown value now falls back to the default
mode (IQ, and differential for adi,quad-se-mode) instead of failing the
probe.

Tested on 6.1.193: W=1 build of admv1013.o, base vs patched, no new
warnings, and the patched kernel boots under QEMU. I don't have the
hardware, so the probe path was checked in the source.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.
---
 drivers/iio/frequency/admv1013.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 5238dfdb1de5..a274576bc8f3 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -536,26 +536,24 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 	ret = device_property_read_string(&spi->dev, "adi,input-mode", &str);
 	if (ret)
 		st->input_mode = ADMV1013_IQ_MODE;
-
-	if (!strcmp(str, "iq"))
+	else if (!strcmp(str, "iq"))
 		st->input_mode = ADMV1013_IQ_MODE;
 	else if (!strcmp(str, "if"))
 		st->input_mode = ADMV1013_IF_MODE;
 	else
-		return -EINVAL;
+		st->input_mode = ADMV1013_IQ_MODE;
 
 	ret = device_property_read_string(&spi->dev, "adi,quad-se-mode", &str);
 	if (ret)
 		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
-
-	if (!strcmp(str, "diff"))
+	else if (!strcmp(str, "diff"))
 		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
 	else if (!strcmp(str, "se-pos"))
 		st->quad_se_mode = ADMV1013_SE_MODE_POS;
 	else if (!strcmp(str, "se-neg"))
 		st->quad_se_mode = ADMV1013_SE_MODE_NEG;
 	else
-		return -EINVAL;
+		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
 
 	st->reg = devm_regulator_get(&spi->dev, "vcm");
 	if (IS_ERR(st->reg))

---
base-commit: 1ca1436ccc68275d0b43b6a730b3940fcc46b7c2
change-id: 20261128-admv1013-61b-2ff910bf4467

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


