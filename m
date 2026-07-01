Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC1192D8A;
	Wed,  1 Jul 2026 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913181; cv=none; b=sgYuAbI4K9EwxWll1W8Yq6qpY6uijv7wtYBrHSbTlVg0hkkL+Sqmgj8W8pScYEQYDfRse9wf9bp9aFZ/dXQaz01f1QKK4J6ZNxT8O7z1GK628KsH9dUddqcIr7EgAIfIxdsHxrQknoQEnQ+9aVsjF16m+0ePQ0ClcAq6TIchlVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913181; c=relaxed/simple;
	bh=30WZdNdAZDgJNhuINEGyNlJTTmfcrpsaavdPxn8+9Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPuzb2brSR+r0iAPRdAlXYcodY3deN/7pt6XAu94VVkQsQBeEdwpMcaqiQtp/C8Mj/kZlO6+t0+NoixBLlmhMEO/NhhIAXwpvusdNGgF56WDtOZfgGFiQYWXPP2MO0WE+E0RMmt/mvON+lHtIO9BNRKHDPdnm7l/r0GXWNnAyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z3DuxW3R; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z3DuxW3R"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782913175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOWwwSP9za3ySnqUIp4QGZCVBjvliudu4EI+ddMn/CU=;
	b=Z3DuxW3RXG5bPxSjNZ6Xmvz0/d4zgq9/zKKmlJJuPrmwf893SfcECPBy70K0jrB4k9rUWT
	JwY83ElJsPO9FvEf+2eZhq7ScxLSVVw6zXpnDCpM+GFxsIv6xY/kYvCtWlllCVEByMYofO
	JN1qxyY/nBUzfmwX9TJ7UVs1RqpZmW4=
From: Junjie Cao <junjie.cao@linux.dev>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	caojunjie650@gmail.com,
	junjie.cao@linux.dev,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH 2/2] backlight: aw99706: Validate all DT property values consistently
Date: Wed,  1 Jul 2026 21:39:18 +0800
Message-ID: <20260701133918.33487-2-junjie.cao@linux.dev>
In-Reply-To: <20260701133918.33487-1-junjie.cao@linux.dev>
References: <20260701133918.33487-1-junjie.cao@linux.dev>
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
index abacf5a6c8ae..a00a4144f160 100644
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

