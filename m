Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44353C5833
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786720445; cv=none; b=oF34p/M+DCUURNFvslQUpe9/dIRAOhd1rVbu8JtTPrsRc9UQuIwjccKgKh+bXZI4RmvKqFE5dHrc8rpYkqWbVwR2ubc1j0hh00WpFsIfUNTcToBUO+gMRNxPijyHwiT11u8s7eHmDsRjZgMCl5h51UNt5C/Q4VqYe0ZXS3HpIRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786720445; c=relaxed/simple;
	bh=qpflxoDz4Q2LAuHcccN97A6fnIkF2G+PGjFWuzstZS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gtaNeU0Dckf3D1DfITfPZGwk31N+uSI0AcFjXOeiewZ0UfsSXYcvNqn6DO6zFg/V1AHXks4nF0CjoLdqTGve6G9hb+4oYLWe15Z0YbJ1JJhVb40zrTZVJI0AevUBe+ztFwVE4jz5tz8jFoOzOnM+dGz/PRR7n8If79uZSPqKFyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geFEbckE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geFEbckE"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caed617615so15817385ad.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786720443; x=1787325243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2AwaiBewPNb0w3Qz67JVI0ysWpkdHoufX6g1rsCJvXo=;
        b=geFEbckE4Lw56iKVwnojpRE74iHpkA0lJqcb6MN4Eywh7En/+adTRTIuPnmyJGPlPi
         8nYMPCfCjQCrBy0N/Uc25/e9viWtj65NBFKccAGzca3bB5AJ/ZqWevDklFr4HsmPetgU
         amWNN0cEVd6qeWxHnWabfej8peHNhWVD7n7pGpMcepGvFqPf2DP7T60tdzzdO5BGuVVk
         QAYVth2VNi8fBk6ATNQp34iinUilhy3hR5CJQBsVKIci44oA4lBJut4auteJ9KBav9if
         aldjze7pr8FyhPPcRLuPAvKGHO/1JMpHGam4OuOfivp2GOLBPQ+4NmfFP1m/nvj5saCw
         anRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720443; x=1787325243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2AwaiBewPNb0w3Qz67JVI0ysWpkdHoufX6g1rsCJvXo=;
        b=Z9pplUGiWwJb6YHHJNBVyIa6gis8hYZsdNA0spZbuBuEgjxsONd04ddwk6kJOrvRsk
         FQjLe2gejiQmE4t7ZFaiLUe136bFCY3m+Ht/1KhIphOEf4oVhWte9ugexAi6LY1lvnSa
         syb2qBwx5hMN9QAhudMowJHsjAFCfwSbz1ZMWGhXlsouKfiDgJmTS/JQXWBJPomvXifR
         IqMP7dPde8SNn6Pupr5cJ6Me2R6shi/TxSVCnag0n9v3gzrAGLTHxCGxch+CX//drnAT
         jOD19lT5Q9zNovBE6RxnGFV3hKlSlDt4xQMwxo3ftGdetnBaCEImAt4s8vcZEtOmB9kA
         T5+A==
X-Forwarded-Encrypted: i=1; AHgh+RqZ0FYDaDRmwoe+PLZl9ZRp14wGdWzWlR93xWMbC5NQ8mxZZEVV0eOujFl84ZU+idG1FT9W+po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yTZnIS0Msp/ea56IYwL742z8s+qELQbCtZMw15XWbC98eKP/
	65eEte815/wYp2FQOVAkCanj0Zbluflsl+oxTWgYWICsblg+JQ+rkKR9
X-Gm-Gg: AR+sD12iLdyHBNWudKn3qTi4sld5P5RhinlW+HuFWAgYg8NMor6UgDoroPzScLe0atl
	+muYDFgZ76QzLzYrxbI4mfnNNiHwjiGPg9H9EcM1SNkqsfDvjBR9iLAATZ9gIhfRorIVP1ZJNQ/
	hlRHhNlmbPRXGyRDbNHUusyRMysYISaZGomx5Lnb+nQTWSbGWFCJ1VRvh4/ljDICmaWh0Peskoj
	9bq3xZUsp/qcbfXeCCYYZDcDdqygcQ02iO0YZh4frQgu4/s/biry+oMXdqLKx67HVwF5zOuBEW3
	DPZww/fLO3Vza3yc73e/2IC/muLTLRCN7KgCcCvdnFBE/pC4vltZ7H3x3sXNgj7+eFez/LbZgYV
	UygUnJEfPTr4P/tN4Z6KoXthqgT1YSwLyJhsXajoZVU+9rSikjxPRx3KQacl+VN1FHi7Q9Bep7i
	6n5HaBSYKob3vG22zUWn25qpPxH0dsndeFXt5cE/mGk5+Lj5dfOKAqt+W+RMw=
X-Received: by 2002:a17:902:fc4e:b0:2d5:2f49:b3de with SMTP id d9443c01a7336-2d52f49c24bmr37915325ad.0.1786720442919;
        Fri, 14 Aug 2026 08:14:02 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aec22f98sm11006395ad.84.2026.08.14.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:14:02 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Fri, 14 Aug 2026 23:13:39 +0800
Subject: [PATCH 1/3] powerpc/spufs: fix gang->alive double-decrement on
 context creation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-spufs-groupa-v1-1-f38f7549ce20@gmail.com>
References: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
In-Reply-To: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@ozlabs.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786720431; l=1857;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=qpflxoDz4Q2LAuHcccN97A6fnIkF2G+PGjFWuzstZS0=;
 b=jOy/AYDd7EIMyxpncNLcvaCapZRp5eD3TFKXnXkKchB1tiySy2Lxb7xaouIDUj8swq8VvCdOl
 r2oHCGZedZqDRTjy8MjdP7EmQbMu6SA+ilnKvxfC4Uj5p9bBZZTcp9Z
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

spufs_create_context() takes a reference on the gang with gang->alive++
and is meant to hold it until the context directory is closed, at which
point spufs_dir_close() -> unuse_gang() drops it again.

The error epilogue instead reads:

	ret = spufs_context_open(&path);
	...
	if (ret && gang)
		gang->alive--; // can't reach 0

spufs_context_open() returns a non-negative file descriptor on success,
which is non-zero whenever the caller already holds an open fd. The
condition therefore fires on the success path too, dropping the
reference immediately; unuse_gang() then decrements it a second time at
close. The unbalanced double decrement can drive gang->alive to zero
prematurely, while contexts still reference the gang, triggering
simple_recursive_removal() of the gang directory too early.

Test the sign of the return value instead, so the reference is only
released on actual failure -- matching the idiom already used by
spufs_create_gang(), which calls unuse_gang() only on ret < 0.

Fixes: c134deabf478 ("spufs: fix gang directory lifetimes")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 2b54afb31529..23619fbe0bd9 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -436,7 +436,7 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 out_aff_unlock:
 	if (affinity)
 		mutex_unlock(&gang->aff_mutex);
-	if (ret && gang)
+	if (ret < 0 && gang)
 		gang->alive--; // can't reach 0
 	return ret;
 }

-- 
2.34.1

