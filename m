Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9536470EB4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961882; cv=none; b=HXR7nKqX7TJm/wspLkrHdc0uDajq42s21R492fBbHS05gJLvg5EtfahrhndeTozEPpZfLWuU8kRBjvgv1MFK1eakxvhuVKxpv6ee3mRgHr4GJXRNNAiR2SzYBe6UntejZ9EuqybbLDVl1fJBKRTkmaP05HkdoPvDQZMItAQnOJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961882; c=relaxed/simple;
	bh=Or1MHs7BHU4RwEsjCS87/j+WE5saCqR41FA7BAZ9WfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9LSxpIqa81Yb74mHmeCG1MjxlS/uB9qVsZDK99lVATjK3kzmJRN+GPjXgnlDxU7tlbC8AmmuKdcFYLkRuPd/xt7vZuQWEc9XmTLx/J8lmFBCMhfrld4VlshYBegf6uRjzdbw9Egrwuy7qP3Q7inc6N1YMnDG6Wmm5c7xNa44rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=M4zmHeO+; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="M4zmHeO+"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbb973e6749so1746777a12.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 13:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1785961874; x=1786566674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vi1HjMdF63tIWmwZPIcgrh+hHmXSZEnMc+Ltimo0SR4=;
        b=M4zmHeO+lz0LxE+3Mgj9IrZthMTKMw3vnWABARi91BKVogswr2aB3RpFa0tK4aoBES
         fxhJBNswhgccI4TZ2MNJAaXWwF7dz+Cg0OXzKd2pYSqQJq4JTe5z+m4FV72lcaTYEGaj
         72biZY02Xbr+4mqf9W62EKbZCHafKPQiKZ+1mBfCPebLA0T+9/anzWNelUNMTZe1X+NW
         E6QM3Wg7gmMDgd9VJ65SRIf83TFEqtHqUnfh+N77fIMff+eZdsH6HR8qra4h23zEviIs
         kC3RedC2I/hzIXwth32V2wrKnU7Gp0nxD8mVo8y/1+a73ZLjKScmTI4sDyppeyz1JUyH
         HJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785961874; x=1786566674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vi1HjMdF63tIWmwZPIcgrh+hHmXSZEnMc+Ltimo0SR4=;
        b=UH+l0FexVgvKfJy8tsk6AD3ZnSdRm6LWvs5nNFqOBAeFd/jdHOVdJTlFMECfnL9KeZ
         BF2BlV75OKal8SsLY8x17qc+aoGWXmpZUp5hQ6acD6ajuOxzHO55UY0viS4gfpjQrBMq
         bAgkQ7bxe4VrkqDwYG5+Kj4qlY9sE1qFFIVdCqI/obpG63DBEVSM4geGffhubIaupH2z
         qPeNu+pBENBo+NbYWCilEsB+rDmHi9TktzrNSoQHB/jL84TTbbZ+wcDcjiq3Sp/Ibh7r
         zfFHBKNSaui29TOW4u9iArCuaxuqngFekXX3fVSATjZF8HTg5UuECvZiIGp9+QRfBj2L
         lIpg==
X-Forwarded-Encrypted: i=1; AHgh+RpLi0UJqA7HrXTQ+DcRiEj9JwV2vb++ayvmMD7VnU26y8pQ6b4pPR5RW8eGuFCRwArkXBNs95A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUyN+kL6OwhbSCx/cO9wR3c0wZ5fYC0UNZahaw94DBga6v14E+
	HIucn5D9pSG9T/ZGTP2d9lg8riVdZoix5sPLd1OI2YsLMl1U6MMa6eHiNuqevpPkPkI=
X-Gm-Gg: AR+sD11sEy9ReIyyPb61odL3u/DS1GkF6F9tU/Sjcwx4xzFhJAsMtsV+jBGIcpOsPu3
	oEr5IKTVQvKZ+jVs6LmIUaN7Ib/tAbIJyaM4/MlA84dFthL+MWXHfHV2KkhEJ/imm6BoHfW0nn7
	I7BLDxBjzg7FiOuZ5AWRUl228WNQQKlyrVKemh/prC1ZfacjDP7hDDrrL10ym0v/Z/2XNQZdYaM
	AUxOAccmqBle5FN1CTS+zevWxY2VkMOFylJPB2EflJNJWcndmEemFzORjpGJYlVX7GfvjClG3Hc
	z0OjiCKhEZjX7QUvyUCnjN7jY9uunIBcjzO0xTmkPObkeciXzahMVNJ5OR66zl6QeXoTlce38LK
	jaJFUAdMGLvyZu7JvBcchKMDMv+8mdlbnCU5vkDpSNvkJnEOqU0w9uUkR75XGvudhl7EaNH4Qs8
	adg+y7DLZm+wtuFiVTzUe1VRXLJit4mOmHB3OWu07CMB3H5LvzJF+eFof2lNoMp/u2gh7NfmLvY
	A==
X-Received: by 2002:a05:6a20:734b:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3cb85dcb2efmr10868548637.7.1785961874000;
        Wed, 05 Aug 2026 13:31:14 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca63ce12sm20694924c88.5.2026.08.05.13.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:31:13 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 05 Aug 2026 13:31:05 -0700
Subject: [PATCH v6 06/10] of/overlay: only treat a positive changeset id as
 registered
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-nh-of-alias-overlay-v6-6-74f21d440819@nexthop.ai>
References: <20260805-nh-of-alias-overlay-v6-0-74f21d440819@nexthop.ai>
In-Reply-To: <20260805-nh-of-alias-overlay-v6-0-74f21d440819@nexthop.ai>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Shawn Guo <shawn.guo@linaro.org>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, stable@vger.kernel.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785961866; l=1466;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=Or1MHs7BHU4RwEsjCS87/j+WE5saCqR41FA7BAZ9WfE=;
 b=BI+hMWMEelWji4+07CG+Kl23bVoo3g1r9UXMuhI9QOPfBNP/orkMQKg0Kd65fLCicQGYx2EmA
 h9Lj5k6JHncBCgNMrN7tGo2IbTiIfRvHkXU+gtcNdIqWVZacDuB8Nif
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

