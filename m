Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9D36B93F
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319636; cv=none; b=eSRGE+dNlHmU5HWCatIp75zshUOsQ0oqw+B3FXwgZJv6u0Y4O4GUOThKrtXRAtdIi9RcjjpJl1t2u1nIvchdNCyMbZLgt6Th+FrCZ/ZuiYkVOpMIn3sfSaioW6AJwOeFLOO5b4e3XckNPtUCL3OBjx6Xd7AkTYw/VwTRLQCeBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319636; c=relaxed/simple;
	bh=c/rgNWkG8eebV4a+R990wA+dAtE6CX6lxhPqQ7MPdmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VfST8KduwHOOV+ssr8/zcfYen/dca/EF7gj8HRYPn3Z5JhZnmVmKObcgWAWtohyBTD/L0J/Mk6o7pgRkUtU2qqePMS2P4J3fCAnlZ4/bVx9K8LxAjqPwqkSnOP/a/wmfzoDlA9OKviBPH1y8B4VSc4g957ykDRvSPYfm/pCxTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqCfvScj; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqCfvScj"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so1134095f8f.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789319634; x=1789924434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/rgNWkG8eebV4a+R990wA+dAtE6CX6lxhPqQ7MPdmg=;
        b=QqCfvScjgP++xJUCYT7bm72LvoBv/cgEpDq++5sRfk8L6xV/ZadrdVqhhc3OWG27R8
         A5EaGRBH0YCvRn+piaj1Ko69a7IA5jC3QK+V/fdz2d3Tyc9/GUQi97TBaA02AIZLeEZ7
         8JcWHNuWhx5F4v2urjs7dxPOMp4pguKy3wWB5GvIu1Oqu9F6NSwloledltnX1hy78Ot9
         ZTvgMTiOwg7Nr+z3rOWCALCaHkH1Ia+6mK9o1cE2mlBD3zi1eIlo2qvME50/ZPcKClt/
         OtmSDJ39wZaokpKN6A0zA5lCPel6X4e2LkbCWl5t8dHuKII3HSvACsDlksXYuUaq2pAA
         T9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789319634; x=1789924434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/rgNWkG8eebV4a+R990wA+dAtE6CX6lxhPqQ7MPdmg=;
        b=rHuLGT3Jnn4vPrPFhMcytrjDC50jHlbkVsSg5FQIU664neSRwxFzdEvRS/R1pg+Sd7
         IGQJg+uWLQhaWvomOmOJ/WKN8z+Al0Pdh6TT6TCr0AJQMufGsXkCmYw080jQpL6Zb8Vd
         j1va3MF5EcspQICX0AaOduZDCTAGYEBDCJ5vTE2a4iQq/pKcgVpqSjHNIstlmr4CLolP
         LvTSfqKcwbfNL77L1mCEMp0OblmrTxf45nL5Fi87AI7Hzj9s6NzbZ9NawvLNdmqTpe2s
         Ms4FTHZoITFHv2uM3nvvr9LBUNmlh6wI+nHbF2YQcvJv7hsc7NW+q6lI6POBfQtrg5Od
         GaGw==
X-Forwarded-Encrypted: i=1; AKwUvBzutPmtGowrLIdHzLt6XCeNalp/2ALwoUN2m6Hgz8bsQdg6pIUjYkYj/M0NFAm+khQ9gYO5BXA=@vger.kernel.org
X-Gm-Message-State: AFuF++m6zt7jDFX/84pFvfjrkebJJ2O6CuBmrmM5oNGkukncV4noy8SY
	APobTuenOB7Jg80RLDESxO2OHk3rBhzanBCJhlEOyf3kIWipS5s5At18
X-Gm-Gg: AYBFou1O13iAfgD99YFNJtKiXh1L8N1dzAkKCSBxJEhaohT8xpDFJaH5JvVjZB9tD6+
	xwa3LC7kTUxL1Q2q0BUax2wmlQZ4tGXxSCDsDGmu5D1qVtykWlZQd3aTw6RAEhX/o15Hgu3nTn/
	i2XHGeLjCpJtRffvIcMLXOewht25qRDQAaEPVzRjVw/D8AqGahCFyYTsKUdYzYjxgxp2ftCIXMn
	u06Chp7pSrCK+VU1UPJVJq/mdwS5FYmJcBMHkvlAtJnTrjQuabt8k1AT8fJANidFUyw//asptFV
	9u5Mi2aqBI4zgOyjukHbAwmxQgDDT5+LGgmHwcsaJkSjApCv1eudVzZ2mLrgvI8g9IMc/iPt8x3
	VgN0p28TJrh4zfpjdG+f5SjtIddR23mYlHey+sF6Rfmhsp+P6uuETpyCyaSx1P85XCZnYXb9IHU
	bb3sS8/ZXjqDKpXzSTi5aVhFb0OhpW30TGIr5nmYexnaZn2axuA2RyzfuKf21ErWHi+hZc69AoE
	pcmhZeTdFG/hDUxjQJb0Qzelg3c2AZ5AzM8z/J/Q279u+s5wdqBqY8wYVtiNlqhmIxOH28ah76y
	FDMpDlSVUvKe3KmrqVfbkS6SgOEi5Y7JyuXGP3ibv/fOyznEqzQze10sqOLAVPA/MZR3XMS94XQ
	3feMLgL05
X-Received: by 2002:adf:ec86:0:b0:47f:7129:6e2d with SMTP id ffacd0b85a97d-486eb325de3mr23501505f8f.17.1789319633545;
        Sun, 13 Sep 2026 10:13:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0e6-2301-7846-2cfb-35f5-6359.310.pool.telefonica.de. [2a02:3100:a0e6:2301:7846:2cfb:35f5:6359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34f1f7sm20618159f8f.24.2026.09.13.10.13.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 10:13:53 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 535/935] bpf: Sync tail_call_reachable with callee state on entry
Date: Sun, 13 Sep 2026 19:13:47 +0200
Message-Id: <20260913171347.1594-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912065539.091095476@linuxfoundation.org>
References: <20260912065526.833703348@linuxfoundation.org> <20260912065539.091095476@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please hold this patch unless 5.15 backports of upstream commits
01793ed86b5d ("bpf, verifier: Correct tail_call_reachable for bpf prog")
and 54c27ea6dadb ("bpf: Fix tail_call_reachable leak") can also be
included.

This patch resets tail_call_reachable on callee entry, but 5.15 lacks both
the direct-tail-call initialization and the parent-state restoration it
relies on. This can leave the root program falsely unmarked and make the x86
JIT omit required tail-call counter handling.

I reproduced this on 5.15.221-rc1 in QEMU: Linux permits 33 successful tail
calls, so the test must stop after 34 program entries including the initial
invocation. The unmodified rc1 reached 35, bypassing the limit.

With tested 5.15 adaptations of both commits applied, the same test stopped
at the expected 34 entries.

Thanks,
Karl
