Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1520027FD51
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566669; cv=none; b=WmOIxEFX+2HQRBsHHUc4KK1TVqGEZuCxsg8KLdprX8rQijiejx+FwxTF9QhDQKv4X0ytKgOO4dIkp/EzhvxRlk+AdJrP7mUmpF9cw6M7gHJlBTGhN6pHEwkUcTi1ijnzqKj29+l/ZxLvB0qFa7+yXyNFbsy0L3iVJug5boGMp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566669; c=relaxed/simple;
	bh=OSQi0fnYoZLN0FaALBw41Iujl6gFOLhSbHvLSxxbDsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPubi8nH8ZUiGZOXz1yb5pqiPe9Jf+qeg98I+q1rfofZGq1QMry4wdDxMbjvvSOVKQxyBWTQ71EEDW7MY6V0u4KpA6/6lLsAnwMlHC3yHG+u8MDt7FabcFxodIH8DgPJVB/TpJtVdBS3GyzdmfdUUm9dRgDtKZxuIhXOys8qGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i34wUUbP; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i34wUUbP"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-304ec41197bso4408937eec.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781566667; x=1782171467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IWtsgQMgLXtZgryprx/woRtK4v3sMFHFdfoF1UZkXmE=;
        b=i34wUUbPp2pdZed9i5ljz0De73kt5VEqSpMCeSuE21/+aeF5zyu5rnHhIDvjbwR8FU
         XeSXkVxKl9FD7laKN2NUeHSaYnOO7Ihupws13fMMlIzrclZZSw4KVk0CWA46fLowHjDr
         +Uyck2XFN0eAGZSWKW3OjqIvN2gJYG00fHxzUbD10PG6eNTYGLnbEcQJcQU9Yr6m2fMe
         7NG0XZBMnOktkT7ClEuJDjAbqV67MWwlO5SZm3YS9oqaKw6RE33pT4LQszjey5lVWZB2
         +YbEsPM1lKMO7KLkirzVDo4xmCH4Bml9f3QPc8hEaLW6rdqKyweAfVNpKhGNu7hUpj+6
         +ULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781566667; x=1782171467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWtsgQMgLXtZgryprx/woRtK4v3sMFHFdfoF1UZkXmE=;
        b=o+Bx4RWacRmjWYXWSfQMcJI7Qlsx1pKkvu6lo7jyty7V6IiIw/Ox48TP3OlaUxH/U1
         U6NIgkOye4cB585HyI58BBsAnXWSaXYgWWMCaBoxyqbzDKOjtRmyc9cU3ndj4xn7CCmR
         fZGP0a1Bii6bwKl++cdO3IQFM9u+p8Y6z38L1MVbI+tCHMOgVMbSKbNEKtRvtgqOpOO9
         FXYRF56OTCaGBYd0JFkUvyKhZ1XDx2g9ZIZsEVIxiV1gSiI2rzOdaWYOlIcy7dbaKqiu
         9T5ajfQcgUhKQ7elb719Jki4l77pgfKEG6g7219/ML+e8jDCrj6nuHjqgQ6Mg/Ff+XNp
         PEUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Xh9CCJrxN8cOEpn7aZ+/tvESu2nFnECuhla5t2wWgdguvIORsJ9fG5YN3hW8tQtO4t0uvLeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBC+3VATv1bCgub7SxQRyN+lLShM5DCISohS0snupVJgTSmABR
	h3BJ2hOXYrl27PD6W1reQIaaSQTXfffPD4JpBo9qBr5dcto+1TYZ78If
X-Gm-Gg: Acq92OHKYrlrqFK2hG2BVFQIRkOt4ugaufrUr32GtsTFq1TWJ1u8DgMcH0AMUO0pHIo
	j6nI1Yr5wZRR4mFJ40KKlUMDD/pw/utvKmTPZxwtV32LBMmAtxg893vuWPIBwhNJlUHhKGDHcko
	PgugF8NE3sehyI8a/yX8dcBHyPPpu5lcOVwQgR8MT1RRTksdLORXjVljiAq/5cJcdncg2THKZwt
	mU/SmfjSZ/PkBHblFImRgL8JtNlv+6NxyTI4pc9s0I68yXkwG2uuTyPslJty4RGqIB5PPM9+/HL
	SSXg3omPhZyd74doXSZ4fBunEcop7Ms8s6y84Qln3w4Is66n3ZndF6BY+qbm+U8Sp1qk05lmWcL
	K9kLzpB2fMRVf00QR65K/zAyCHg5Cv/+FTrZRd6eMHPnB58c1usiV3j3VK1vP200WBZV0L98dpp
	3439gPUbi6qY+F3xrVdoe+17zRxC8yB06s0RvrJ4U8HAd7MNhJX4lm4073pMvAxWFwAZXxEpWlj
	RTDE+5WnRB4fGfFwEK6vZqYpgCc9EH1YkVNyBxtmopoVSG1f7zlZgSAdIMc92AAHXJbiVEfbzHm
	5l6/Jn4O9JXEBj7nng==
X-Received: by 2002:a05:7300:1827:b0:2dd:8ac2:9f7a with SMTP id 5a478bee46e88-30ba59d3517mr869225eec.11.1781566667050;
        Mon, 15 Jun 2026 16:37:47 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0828sm18158501eec.10.2026.06.15.16.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 16:37:46 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sayali Patil <sayalip@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc/uaccess: correct check for CONFIG_PPC_E500 in mask_user_address()
Date: Mon, 15 Jun 2026 16:37:26 -0700
Message-ID: <20260615233729.29386-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mask_user_address() incorrectly checks for CONFIG_E500 instead of
CONFIG_PPC_E500, causing mask_user_address_isel() to not be used on
E500 hardware. Fix the check to use the correct name.

Fixes: 861574d51bbd ("powerpc/uaccess: Implement masked user access")
Cc: stable@vger.kernel.org # 7.0+

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes in v2: Correct explanation and Fixes tag (thanks Christophe)

 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index e98c628e3899..619270bb7380 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -511,7 +511,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
 
 	if (IS_ENABLED(CONFIG_PPC64))
 		return mask_user_address_simple(ptr);
-	if (IS_ENABLED(CONFIG_E500))
+	if (IS_ENABLED(CONFIG_PPC_E500))
 		return mask_user_address_isel(ptr);
 	if (TASK_SIZE <= UL(SZ_2G) && border >= UL(SZ_2G))
 		return mask_user_address_simple(ptr);
-- 
2.43.0

