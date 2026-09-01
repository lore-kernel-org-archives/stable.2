Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA63ABD8D
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226175; cv=none; b=U/72cNw7YhpqlEDv9/iT+pCY5zKjaWlQLObSt2QPI3fmdTPJUBdm6RdYZz8uK6lBrgHnign2acAFyFINCb6ksOlrRx3cGfseQVd8h7n1tmwNmlH/i9/UBu0NeaOwW7oq01T0PUQoEt9DPveYe7my+m8NWncGpLsxYpjDcMhsK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226175; c=relaxed/simple;
	bh=ZEr0m0+64zDKVxyN/0o4Ov6n71mrZ2+8QMK6RrzeH1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5b88kaviHX/JUJ57mbSdaomga6RjyaE9E4M4Lzda9AkaSP0mqdJufAyDsZmncGN0CKOLQOzBLB7RiKZpYK01TOs5RfZxucIfjxVEJ21KBFuIs/1XYQQ3B5Qc/r78Fss1Qxt/tYbC/Hw8gV2OhXiO5mQ3StE9keWlnamxfmL6f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=CyNtx+5e; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="CyNtx+5e"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398b3c37877so2995764a91.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1788226171; x=1788830971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hBX4D8QE2oULZc7c2LUsXpSCt3UMpyQ0mFmC05VzQfo=;
        b=CyNtx+5edej+b31Nq+lbzo/25LvgaIkVP56AknZAlQ/TW3i0y5jo4rmfR6qBq4gELZ
         7R8guBLMcHzMEbi3DByKayyxFDWFitfS+t83OWa/CLuBwxzhSsr1zDPPcbKDrBvHauB0
         0oS58idDmmnnDimxxf4YkplyXFdMgvSGYnDXJ+w0zggAI6tv1fIlbhj2h7OLzZA7RhYO
         L+yroD6D197Em5Q43Og5Uw0uV0iFe08ro8niCYLWgf5PID7LPZkI3eR8LtwGhcOA57s4
         cDQejMjn9l6sA/icaOZ7eyBpB9Fg8A/mSzykyxIJLM2DXjsPs+76C3CtaBPHejPz22io
         SX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788226171; x=1788830971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hBX4D8QE2oULZc7c2LUsXpSCt3UMpyQ0mFmC05VzQfo=;
        b=NuzujI+LE5yeUE/m3RxoshXDE64+NzjyLuDpNL9HM1UylPYcOdGP+53lp6l0+tRKjJ
         KPNQLq5JIz2XAQtHmM7bTVtOBxPlL3gEL2obUUeCDo8rTnAlyBmANUepri7ny8BVT0FL
         9PXEuVHp8sG8urpAwCxaJA8cqX4VodDU7R4budFjIIaxVHPS5ULh0MVjzNnSFO/JrGsC
         4BHF1x4zir1DiKHGvfFqtQ6N5ozflptA9ZNyp1SpRa+ch+Gg6e12GwDclk299v3qm97N
         56w3Ig88aTA/p91+S4+QgMGxOgknXS3Oz2EnArCagsuFbv0idYenmtFnWYT3/uNTtrvu
         JcfA==
X-Forwarded-Encrypted: i=1; AKwUvByiQRPPkX4PFBo27cbDJ/6E3bJAhhaAk69MiqFMsqFnvv57aMK3BNKGEDQY2/DSV7fkt06tKpM=@vger.kernel.org
X-Gm-Message-State: AFuF++lUMRvs+tPnFEXMK6oyFZjZBdKa5dkJrNvv/NPD2++dg9z4gb0f
	yEG+31HOyo/cIuWt7BBC7YAAWqbu6LH/6cfDW3SwIwRpZPHyf9woYH+AZW1HJIpFWr4=
X-Gm-Gg: AYBFou1MsNiCX96E1iY0TPqhp5LJKjVpU3ykC7sAK81AA7D7JvfRQi5BAkEaMel/mq0
	Cjjnb2cEJ+cU4unh7do7EBFygS6kW+1QU/ECimYKtaMAnaOe+c661vpPQB1wnaW5EJ2EBKL2Qfj
	jrqoMhOlxoX2H/sD3M+RaKQ9GBNgPAURhvNBg8HI/TjkhVYleyX4yAMHK7BtvVG0lxlLl1Qna/0
	+P7bE5CSzH4lrr0qygH30ak8+unTPFMmsymb+wQpCZmgA2WVsMslEj0bNgRIFYVWczTU4GUUA0Y
	Gsowa8VUP3VeeFHFWZ3MJ1nir4JwmGET3e4v38+sTOWyZkncZc/BgHaHBN2c/ztLSKNekEGRXsM
	B00KAAEAaoQr1qvRMk8ZCX2DxZsOiQcYDW/hyemR9hP7Bc7X6EaFIb9w0m7kCfVJ4r2uwFAJE7C
	5UKwqHGCk6MJ0oSwp2bg2lAueYWvj+3yTuC1JxRjaaRzrrwG07AosFQG4+iynH6dE=
X-Received: by 2002:a17:90b:3910:b0:398:9beb:5c17 with SMTP id 98e67ed59e1d1-3989beb6373mr27864091a91.18.1788226170796;
        Mon, 31 Aug 2026 18:29:30 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b5bef7683sm19390817eec.12.2026.08.31.18.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:29:30 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 31 Aug 2026 18:29:23 -0700
Subject: [PATCH v7 05/10] of/overlay: only treat a positive changeset id as
 registered
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-nh-of-alias-overlay-v7-5-02754604805a@nexthop.ai>
References: <20260831-nh-of-alias-overlay-v7-0-02754604805a@nexthop.ai>
In-Reply-To: <20260831-nh-of-alias-overlay-v7-0-02754604805a@nexthop.ai>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Shawn Guo <shawnguo@kernel.org>, 
 Grant Likely <grant.likely@secretlab.ca>, 
 Grant Likely <grant.likely@linaro.org>, 
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>, 
 David Daney <david.daney@cavium.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, stable@vger.kernel.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788226164; l=1525;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=ZEr0m0+64zDKVxyN/0o4Ov6n71mrZ2+8QMK6RrzeH1A=;
 b=hOe8J1vYL2U09NmjwTYJSOrQFA7DNmF3EOkLkPXnYsNk+jJbWbFKlsze1cF9Yq0lUHJ8KfHMI
 7J0cR1HTouxC43Hs5CV3JfLFr+LvPKVX6Z7V1+3GCJoKm8nCYIdCStj
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

of_overlay_fdt_apply() stores the idr_alloc() return value in
ovcs->id before checking it. On failure the stored id is negative,
free_overlay_changeset()'s "if (ovcs->id)" check passes, idr_remove()
is called with a negative id and list_del() runs on ovcs->ovcs_list,
which is not initialized until after the id allocation. An allocation
failure at that point dereferences NULL.

Make free_overlay_changeset() treat only a strict-positive id as
registered. The rest of the function already copes with a
partially-initialized ovcs, so the error path stays a plain
goto err_free_ovcs.

Fixes: 61b4de4e0b38 ("of: overlay: minor restructuring")
Cc: stable@vger.kernel.org
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Assisted-by: Claude:claude-fable-5 [Claude Code]
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/of/overlay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 284c9bc6c9cf..9b9f198a1d70 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -860,7 +860,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 	if (ovcs->cset.entries.next)
 		of_changeset_destroy(&ovcs->cset);
 
-	if (ovcs->id) {
+	/* a failed idr_alloc() leaves its negative error in ovcs->id */
+	if (ovcs->id > 0) {
 		idr_remove(&ovcs_idr, ovcs->id);
 		list_del(&ovcs->ovcs_list);
 		ovcs->id = 0;

-- 
2.54.0

