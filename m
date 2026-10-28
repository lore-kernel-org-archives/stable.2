Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213950;
	b=xfnms5QftIIyJRixspAJUUd0yA9QQ7/MWh/8zi0d3+i1jSVSgCdfQcJouIFW+E716RiZ
	 f1o3L+VmsqUzmG6HnI3v2OVzuIwlzVDXi8GtuxyUb27IO8QMlzGKZ8AZtZd3A5o/aaCpF
	 WkXS6292zuzN4hOcJhWJtsIVqYaUOeuQXjKaANIBH6OezOD4EZ1XFIABoyq7o/4d6ShbW
	 Z8GTEfOavMmjEVWzIHl6O2mm8Rgq6mDt0lPAjw1YO+jTHdKfYTle3w061mynX0yTKhmx6
	 GCaVAs7klubBTQ+s6S8HvPhlCcu1uTrir2x82D7++4zFHvbn8Umqz9o4xQVPLBN0dVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=Rv9WOnLOKd8KzksjJxkJ9bnWW9QwLvVUPbM07savGVk=;
	b=q/SL/yK9LSUOga6C+BJZ0DRt+HIesjsXYZmTT0pB2Eyb8MBFgCwtwACaB3YQaDLcRqvY
	 STjyksIhcfWfOi15vDB6mKBb3Xdc58mqRGFmfVMqLhA38KrsWfT7tz8AKkEF9Aj3FZlpc
	 gTYlwmxyond1Z6L5YPph+9dBS4moKlDCUm30orLwh/MWUb17g2bUv4EoTWcoQsTT0ycvB
	 peELiYdjfbtrM18zFIiUe1UdCLgyV0SkSBwQBPfHgW9yRhYbWWFuzLTXP/YmnbMfVvW1v
	 1iZQKg0Jf3YekVd3Tz8EhWNoydo97jxNKS5UwAc1Z4o77RBH/x9tnIERGJnt3sJjByg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Xx0Ydg5o;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146C606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3146C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Xx0Ydg5o
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a3c08d6928so1834670c88.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793213949; x=1793818749; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Rv9WOnLOKd8KzksjJxkJ9bnWW9QwLvVUPbM07savGVk=;
        b=Xx0Ydg5oZjgO2Bv+C7yMeCmwY8sboXdi3RkvN/MM07i83sRFFgpbpjPDSdhvUXUjZX
         6PqOLXv5o+LDU/JnKMtANQD917djrQ3Vxe7SDhflvbH+8pLS4QxD+tW8Qe0p72vITqLn
         Xna9Upxw76aM5bblgjL/nw5rw44upjaBLeAAPt4N+HmQsj8xTKh4C2fGPIwF3B/z5+yn
         XiCQQdMIMcd/hv42tniZMF8TwjMGn71tsAUHajf811asW8AjZIqn4X7nj2/ereO5cVeR
         +v2GgV9ncfqQ1mlFIZsBHy6ZvF+AlHYiR/o+5yM6DXhe1MSZBImj/VwOPE1gVvOb0SdC
         1wlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213949; x=1793818749;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rv9WOnLOKd8KzksjJxkJ9bnWW9QwLvVUPbM07savGVk=;
        b=HyBMUnEMb+BH1YwZot/JbXASjOS32ENoL2Tm11ghJ9C2xBjPp97l+2z/BZ2yVmKMKC
         QyzqkIM9Jk62+yxIq4lAL0RkQCOk6CsoUk2EzVLNlE2OITlwGCLA+M+RALBBAvlMMcO9
         k6Lqnm+uMhwpbFE19YgsjW8jPA3S7CqjLVVh6ZP8+urf6c1nWJk2hyLZXYLklkz1R2ID
         mvWOtSU10MSMl5G5StyphK24SCuv/d5UCIUuFNaC+DZ1Dll4C8dtDuugfrXibVQmxIhr
         2qli2bvYIIcL8kII7C4MxuBBcaZqT/lV7dfxMeCrjTRR339a2eNQ0KGipfOagUmciElc
         v8Cw==
X-Gm-Message-State: AFq9FYLqBk/4G6gAzSykUXHWDyLel13vgwksAluCNvePe+b/xF7/RWc6
	frTCXSAlVShVhtyG/t1gv6ACVqaoOrQfX6e2TyJNbFEVudBzFggHdEfI00TcnuYWMekQpqaoEHk
	VT9tv
X-Gm-Gg: AYBFou3LhpEIIZ7TS8rW/Xw0u+5xOzjIXNZ0wvDpiLqvFLy8/xDdzgxDVY/lSeu2VvC
	FyQZFlGyXfs5FHtp3KOlcXGvb31YEw1JLDEu0EHQ8m42k5ITbNy82kuwcviZP3CqDpq4a8BQBLM
	6VRBquVSQGIWTASd3o0Dk7A5BpyJOp0pIDFtKZT5fT4Zw46L+YO534aw/OfhQXTTXMTT+LeRJKU
	TYIwjPLxvfUmO0qAYXGCS6Gri5bRH+RYcHlWn7VSTNf7Sa0KBxlN/b/o7Sr9tFMnMMHoY34aw0T
	beWJ6vf/Qg3ybx2rfnjQFqfZSf5Ldx/CmzDiWlk2VZT+ccgcYniH2kIPg3TwHeXJpeXDNK5vsyX
	TuuAj1yH+mCrtCenPBcfWnnaXZQfFMAAlcujxTMfUL6UGcWKUYq4mcUEeGzm8JtUh07UX2xykiH
	GWijNKu/2DAuhxVQwC489GQsAjjjpMlWiEgnmfBDPpJdkT+kIN4ZBm9lSosuN8my91Pp9EPxCTG
	Bfu1BQXhiitFbdZ5hk4rDNe1TULH/AWgsvqTR9TJCCXOJmVbBSG0OwJfxlHpQoEH5UST9J6hAd0
	PP7dF7IJuBo60BEAQeUE4Q==
X-Received: by 2002:a05:701b:4589:b0:190:af51:d56c with SMTP id a92af1059eb24-1a6cf447afbmr4193251c88.31.1793213948984;
        Wed, 28 Oct 2026 11:59:08 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75c81490csm8867450c88.8.2026.10.28.11.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:59:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
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
Subject: [REGRESSION] stable-rc/linux-6.1.y:
 (build)/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit decl...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 18:59:08 -0000
Message-ID: <179321394816.45576.10537962173561390455@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration] in mm/filemap.o (mm/filemap.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
                 from /tmp/kci/linux/mm/filemap.c:23:
/tmp/kci/linux/include/linux/highmem.h: In function ‘memcpy_from_folio’:
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^~~~~~~~~~~~~~~~~~
      |                     folio_test_hugetlb
In file included from /tmp/kci/linux/kernel/sched/core.c:9:
/tmp/kci/linux/include/linux/highmem.h: In function ‘memcpy_from_folio’:
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^~~~~~~~~~~~~~~~~~
      |                     folio_test_hugetlb
In file included from /tmp/kci/linux/include/linux/bvec.h:10,
                 from /tmp/kci/linux/include/linux/blk_types.h:10,
                 from /tmp/kci/linux/include/linux/writeback.h:13,
                 from /tmp/kci/linux/init/main.c:50:
/tmp/kci/linux/include/linux/highmem.h: In function ‘memcpy_from_folio’:
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^~~~~~~~~~~~~~~~~~
      |                     folio_test_hugetlb

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:15bdc5f973ed4ecabfc4c67b2e16e07903ad7173
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  cf976d6a55753dce91f48c978098f1ebfafc42ed

# Builds where the incident occurred:

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae235985c0836a8c2f178d2

#kernelci issue maestro:15bdc5f973ed4ecabfc4c67b2e16e07903ad7173

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
