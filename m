Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A2E429CD9
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786724787; cv=none; b=dvrfB7fljmY1d7EUnkOqlFR+5QAG/Q80uzlk41DlBXmAAr+UFo6RLDODBnGx/UvWO1/r71jaRF2vp6P6QARtUSYcWm32o3r8hut5RGSh10k+zfweCAGSiWvyE7hh7zEGF8whWz9QMALHpwBCAfl9uIJWU7RG49gJA3ssBHEzGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786724787; c=relaxed/simple;
	bh=Ud2n/hmwzLtK4efyOOGTQKvorxABAOfcIwF+JM/Wplk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJkeksSy5/+a7oId/npdXEt4BYQcx1sqiJl9fx+5PRC0mlujFr8s/X2vMidTChst1v1p+Nwc5XwpUhwld7uZ2+SH7YATOFqT+4SXbI0bHwhDJW/S+5Iv4AeXeIP5WS5TF5y32facHNBORfja1YyRjCIMKKVh11r8s78Vc5GnztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY/d+aLz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY/d+aLz"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so979738b3a.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786724785; x=1787329585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y8L9gAWKHdFbBHmHBP3V1LTHp9D98CyhXqgwBwp5N0U=;
        b=AY/d+aLze/Kbu7l3z4N5k/V86Xm5JOJ11VOte55XVgKsVdtzxVI4sZVs5I3R02rJKg
         x5Io0hvpt7/RxDCBzArrRggx869aM3jQJv5bN415ZM/+toC0L1MFIc23co5Qy6h/YoAv
         jin57IzuMYx+k7SuUf+Q9/VgxPHcrWU1i+eqLZPEPsKCgkoe2wFTEQHcA6yRyzCGeQpw
         4Y9Rt1qwq3VBCDZPr+w8cdFUtPCsRBL8i4W5BUfkb2Ch7VZEpYA6XQM7H4fdGMt8pcoM
         ilLaCyY3q2JJq8YVAbnjyQFuzLWd2a4FuineRh0B7jxToAAUJNcUDH03toyx3abeBoE5
         zvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786724785; x=1787329585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y8L9gAWKHdFbBHmHBP3V1LTHp9D98CyhXqgwBwp5N0U=;
        b=P85RqhYU+M6JouQEUrBg0huAIA2nvSEEJbxU69Wb6Pq1or+Xvoj9xtLAoVmK6tQn/f
         Dw9NKnnCiJ0dHmmaJI65EfdZys2kccX500Zj7BF8+3LT8ZYDtyvdbDmKDAgvAywAjveA
         4wsnVVy9cSYAJXGLVIYJWo7dgsHUI0dilAXGlgWzR76Yy++AWcdZ/eRVN+HHbgZVWOBe
         IgPU2d4VCtPCkLGXbEQNHkdOdBaN+dem/iFkY/A9eELWFYCXBH41FsWFU2IVUzmT0NjE
         v1UuhTRjcWue7bWHwS7IRsWgjxS+jqEgaVpUduG/8Y5qMIt7EF/LqpUWm4R0nrVn/WgN
         DRUQ==
X-Forwarded-Encrypted: i=1; AHgh+RokQqDlaOSZ0zJz4u0IlsdpxEnqO5EcuBzbxuWSYO4IFQTEozRREWOHAn/jORKRyhJRVpJXSek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEw359nawaHpvwji1kuSTV+29wmckprT60Cxma+0+q5k5rXNyM
	EyM3cx+vTK5fuI5R5KOpx44N8aqHj36nqZdOEw0TSK0gPkFj/ngJ324v
X-Gm-Gg: AR+sD11D84PpkDp3HN/Vvf5y+bHpeN+xxZKx9o2EzPD7+nNh/NPAVo9Yk9IjTioXeah
	mADF2gJsVGUMZvGUeEwVyTQguydY5FH4EWmdG+IjehoDMzr2vTvN6X4ZBevMP65m4vqiScIQhOz
	0bybr5+lxXoSV2MGPPBLzkI2QOYTd4n2UAuQ7+hMZ066LARBb0bMhrQ7ZbP7cUreQX+PIyeCEP/
	E8ugYRbfG7ktzlc5hLwewoVQUGOyx2DiTa/VLv2xCB9m1D6bxPdLeuYtZqpqMW8NN0hmlbCa1Wq
	hgPYdt/uHNBLPqvdn7N+9BCq9mbKr56mr2tSVD9Fnf3gQPiHWv0lO+dXzacmkIyV5gQhTghJ6ki
	lypMi8IHVsxvq6Auct6tXwgVPu9XO4RdWG1aDGh6jkAmfHxXZ8nrN2KZ1i1hz4WisMjiuAAd9XY
	lWt2ob90CpDycrWIT/MpkQgcVcEb7vkDlquQLy+DQO/YvT9XuC2WiXY9K6f1M=
X-Received: by 2002:a05:6a00:1c9e:b0:845:ba94:a56 with SMTP id d2e1a72fcca58-84fddfbf1cbmr7727022b3a.5.1786724784867;
        Fri, 14 Aug 2026 09:26:24 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc095a1fd06sm854391a12.17.2026.08.14.09.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 09:26:24 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Paul Mackerras <paulus@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org,
	Zhenhao Wan <whi4ed0g@gmail.com>
Subject: Re: [PATCH 0/3] powerpc/spufs: fix a refcount, a type confusion and a coredump underflow
Date: Sat, 15 Aug 2026 00:25:38 +0800
Message-Id: <20260814162538.669042-1-whi4ed0g@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
References: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up on testing: this series now builds cleanly with no new
warnings on powerpc cell_defconfig (clang 17, LLVM=1) -- the two
affected objects,

  arch/powerpc/platforms/cell/spufs/inode.o
  arch/powerpc/platforms/cell/spufs/file.o

compile without error. It is still untested at runtime, as I do not
have Cell/PS3 hardware.

Apologies for the "not build-tested" note in the cover letter; that
was accurate at submission time and has since been addressed.

Thanks,
Zhenhao
