Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D08442BE87
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 04:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785816813; cv=none; b=dH6Pf8bNwIx4fE4wfbGtFgPv7kcDJnxG6sWC+qN/lMlpKZyRgm3HDKqxKb5krndX1h7+m0UGs/3W0zDE2qkPDco1OocGQZ6/tUPFCAVpLMCX8jzvDTDuEUvsClU/fgzRzY0PMwOc/iVq2KaU+SqW+XdOSQf6rLzsNifv9qzA3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785816813; c=relaxed/simple;
	bh=zOsNl7dm8Jh+c1eFsWbSZxoNtUVsVhYaAb51Cicyugk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHkK7c+5moluxbxgdNKn91FEEv0iA74O640z1DusarZmsdtlF6nyJ603yPFd099fyIwcolG/b7iE0Z/XbWIL+HQZvm50ktVy+W4dLHp/HyUvt/TAnf8cjQXTRAjWR+8AdEZj43yre+hsK4khYAuXGhgn++7+XOgvMR1/nOt//cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pINP2BR6; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pINP2BR6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785766412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JTAeAiLR7FZoz7bzMQxt1bZ/Rk+neEXLlOIYc9iR9Q8=;
	b=pINP2BR60s/h71BfJ0kzf4E01YbQfOpHBrsGUicUHfQUMCKGqwtkoqu5B+vhw0j4EjhOLx
	aVl1S7/ml/cuU75338oYQpXDNdf0vmLCwgeriKI+5diikUWOWpokNkBGqLhAHrXokjS0FD
	KKYHKCrK9bAFFc60WHb/8l9xWIF3fvQ=
From: Junjie Cao <junjie.cao@linux.dev>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 2/3] backlight: aw99706: Validate all DT property values consistently
Date: Mon,  3 Aug 2026 07:13:09 -0700
Message-ID: <20260803141310.1379194-3-junjie.cao@linux.dev>
In-Reply-To: <20260803141310.1379194-1-junjie.cao@linux.dev>
References: <20260803141310.1379194-1-junjie.cao@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The lookup helpers for dim-mode and ramp-ctl take a shortcut when
lookup_tbl is NULL: they accept any u32 value without range-checking
and return success unconditionally. Out-of-range values get silently
truncated by regmap_update_bits instead of triggering the dev_warn +
default-fallback path that the other properties use.

Add a field-width check for the NULL-table case so that values
exceeding the register field maximum are rejected the same way a
table-lookup miss is.

While here, also switch the error returns to -EINVAL for consistency.

Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 drivers/video/backlight/aw99706.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index e130f164303a..dfb4b38b5b4c 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -94,6 +94,8 @@ static int aw99706_dt_property_lookup(const struct aw99706_dt_prop *prop,
 	int i;
 
 	if (!prop->lookup_tbl) {
+		if (dt_val > (prop->mask >> __ffs(prop->mask)))
+			return -EINVAL;
 		*val = dt_val;
 		return 0;
 	}
@@ -104,7 +106,7 @@ static int aw99706_dt_property_lookup(const struct aw99706_dt_prop *prop,
 
 	*val = i;
 
-	return i == prop->tbl_size ? -1 : 0;
+	return i == prop->tbl_size ? -EINVAL : 0;
 }
 
 #define MIN_ILED_MAX	5000
@@ -116,11 +118,14 @@ aw99706_dt_property_iled_max_convert(const struct aw99706_dt_prop *prop,
 				     u32 dt_val, u8 *val)
 {
 	if (dt_val > MAX_ILED_MAX || dt_val < MIN_ILED_MAX)
-		return -1;
+		return -EINVAL;
+
+	if ((dt_val - MIN_ILED_MAX) % STEP_ILED_MAX)
+		return -EINVAL;
 
 	*val = (dt_val - MIN_ILED_MAX) / STEP_ILED_MAX;
 
-	return (dt_val - MIN_ILED_MAX) % STEP_ILED_MAX;
+	return 0;
 }
 
 static const struct aw99706_dt_prop aw99706_dt_props[] = {
-- 
2.43.0

