Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174AC43803B
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926226; cv=none; b=bFwKgkY96jtty4E+5hYDBUqAjrW5o04KCswQhzScTEpqJXcqAqnK90scIRksDfqvEu2hRQ1jxcwng0bEm9TheMWuJaxNnheUiZJANa6hf3z3SWwze9qNN4AWSuJ15ZkMXj1JTl3JYGRn8q8eQo43HNEV3q/b0lKIYZvhlbYQqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926226; c=relaxed/simple;
	bh=6aGdNFh9whOrRi+BQXiYmM7hLgb2d4eYY0bEvW7ugcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/MkrBYYjX8O+xTfLsQHUKbveM73Lwlyb7TDZCUWA5YvjCz4q2XT8pkBR7DcoPUMlWOBdTGeSDQCKEC7iceaeUFFOPhefWRWyxXXgGjKi6umZ05MAIFAjPIgdInwG23wxygqv8gO3/UKlsGI0hYeLw5UZHvil5ZGvi5y21XWnnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alWx9UXd; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alWx9UXd"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34abf779ac9so2763880eec.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790926224; x=1791531024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oqH+bsEtJSN9lgBpbEOnPSfNHTOAD1Oxka8Dmeox68w=;
        b=alWx9UXdzsXLkVS01Dr3eGwQmyEIq7O2vH2MUWqj3+BIrQmZ0yjjP8wVcWKxmL3tek
         w5AWiWJqqNVHH/82JNm4+hNt1EyBuymyg278pPhVdqt8v0d+KzMJ97tofttTZGBCsICP
         qv+7nUqs9GCoF5U5YpUm3zMok1WincS03TYP38e7trrhThdw0y4+6XjGCMiiexyaxrtY
         zXl0zgJngqldVvAdMGa2ReNAAOadQPG3l8A5R9jCMfqDv1VJ6HMU9XD0zjq+6pA9QGy+
         fuI778y5jNeYNAD6VKipGb96+FnyirsAgvhysITdv0lTYiqnG87U4pfYxpfBDz/xmGPK
         SOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790926224; x=1791531024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oqH+bsEtJSN9lgBpbEOnPSfNHTOAD1Oxka8Dmeox68w=;
        b=Na/A7/LupBevOgv18yVfZ/cQlgcmXMliG5hz3l0D+CUldlxKv0x6FUtDaukXaHRJsz
         YQIRlmtrw0qsRVRZVYQOSki+rmn3+yICszVhIPvONEAKhsT8RayyxAX275bmsYas6beL
         SRJjegMUYRLuTCRL85NIaum4sgNPqNfxqnD2bXtiHmRHWvo840tMmuJ80RinURAxkMsl
         vBCc656dQIwtRnWQYhTlQHE6UvMEYTTlIIf/BDfBBZKoJyDl6uF3jZNTVRfYL/3R6T5k
         jCSQSS0v1a9DemumxUsbTvMmfINihHkcHuDjoFbsfqHNVlWr85SrtIfzD2ILNJoZ/ZFt
         MS2w==
X-Forwarded-Encrypted: i=1; AKwUvBxuW+zYSiDYvCX0V4HXEvJjqZDB3P3EBDJI1ZFa60tPZtg+S/72Z76Tlc7/TG3Pwrn9DSOpXqk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcmRhROyG+TmAo0mQWh8hLR+fy2/9f7euEZxCU/aJscnY2yF4F
	x2kb4kMyUD9yiKIoM84O4PHGxpSzr0gaQlRIo54EeQ+Rsaz3euvWcv3uw/HejhAWcicLrA==
X-Gm-Gg: AYBFou3PRWKmad5YoOicvaF5rKOCFC3urI+rrOb5/vwAlykZ7/hxXXhAHSBJHm5DoFv
	9DI1oXnlWPh6gp8z9Ckf/jycaFEn9HTnl/cD9LmQMb6Zw2OoHyr+vw2u3tlhLw9vDCsq5cJ6hXI
	e9Rh5ERhrxuDgtSQ3Fq58OxRlfD3Vsk6dXhIvjB6rIff3lRDcDDyoe3B5cQocwEv/eN2XNtcYmr
	q7AMlnWZpPD11wmkh1XM5YpndzKT54NsLufiZWM1rdG3WJmoPOE4DSbIULLxSmACuQSCgAsrJqD
	/2GAh/pHRpuSp8e8ivPc3hsasN7/rWicIrJtTVShpvyaOd/Mokrj/YW9Jvr5lCxC7LThvsxui9o
	bEzvVisqatDw3INsZwuqKd1vs7ajytDAnZx1fzCqDqRV13ScgrUe4rDBcQ5kbCv5p8Qr6iTiUoR
	Gm7rAIj/h8PjkBQpVEfxh89GU8OZV1I12u99w2oyMejD4vcWoGcHFPUnTsAK/Tnt7cxMUmDheGr
	UORz44deerXwTieuTJKYd82eGpNLKCMWbJK/1Ow6GJH61is6inVfQb0W9VwgBVJgp5uCZGuw9Vp
	/QNBaY6Gq3RwE53BcHJefifqu+0P7Dh05KIK8cef9jF/Q+uDlbn6MRkoztk=
X-Received: by 2002:a05:693c:8951:20b0:346:7bfd:8504 with SMTP id 5a478bee46e88-34f219b4be6mr2208586eec.41.1790926223683;
        Fri, 02 Oct 2026 00:30:23 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3510850f86bsm934095eec.11.2026.10.02.00.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:30:23 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 0/6] fs/qnx6: fix buffer head leaks, double free, and inode validation
Date: Fri,  2 Oct 2026 15:30:19 +0800
Message-ID: <20261002073019.2208696-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260930081947.511613-1-benquike@gmail.com>
References: <20260930081947.511613-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hui,

Thanks for keeping at this series, and for taking the 1/6 wording on
board.  I think something went wrong when v5 was generated, though: it
does not apply to mainline 551c722f4080, the base your cover letter
names.  git am stops at 1/6, and git apply rejects 1/6, 2/6, 5/6 and
6/6 on their own (4/6 is reported as corrupt).  The context lines refer
to code that is not in fs/qnx6, such as a bad_inode label in
qnx6_iget() and labels out1 and out2 in super_mmi.c, so it looks as if
it came from a different tree than v4, which applied cleanly.  Could
you regenerate it from v4 on a clean checkout of mainline?

While comparing it with v4 I also noticed a few things that may have
been lost along the way:

2/6: the brelse(bh) is now inside if (!bh), where bh is NULL, so it
has no effect.  The leak v4 fixed is on the qnx6_check_blockptr()
failure path.

3/6: the bh1 = NULL and bh2 = NULL assignments from v4 are gone, so the
double brelse() comes back.  With only this 3/6 applied to mainline
(KASAN and UBSAN, under QEMU), the double-brelse image gives the same
two "Trying to free free buffer" warnings as unpatched mainline; v4
gives none.  The qs->sb_buf release itself looks right.

1/6: the text says QNX6_PTR_MAX_LEVELS is 3, but
include/linux/qnx6_fs.h defines it as 5, so inodes with 4 or 5 levels
are valid.  The check uses the macro, so only the text needs fixing.

Fixes: 1da177e4c3f4 is the 2.6.12-rc2 import, which predates qnx6, and
3377755f1064 is not in mainline.  v4's 5d026c724220 ("fs: initial
qnx6fs addition") added both inode.c and super_mmi.c.

Could you also drop my Tested-by and Reviewed-by from v5?  I haven't
been able to test it as posted, and 2/6 and 5/6 have changed since I
reviewed them.  I'll gladly re-test the next version and give them
again.

Thanks,
Matthias
