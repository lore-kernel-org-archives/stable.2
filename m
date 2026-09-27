Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25FE846A;
	Sun, 27 Sep 2026 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790470654; cv=none; b=D8d99eMFIXBuOa5w+guphAOOJ6XBlKCdZRlxbTK/4AHjM5fpbM9RTl3zrF+4F03C1kYZhIAO90fIZOLBMgIanGbG4N+X/fT1oQOx/ShkOH3JE/YAtzWI5/r9jqdqbJMPOaNCe0GR3VHckWwz5LbpgECSW5EHZzUxNoTsFw+Oz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790470654; c=relaxed/simple;
	bh=kWIOhGRUlAQyfvB6LGJ7tanRtsf+WUVQo1enbwMxuLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5nF/nu12ApivQ5SxDdZNYQTGVEfhs9GhSO1fqyTpYoLvNME6EfV3jpfUOg5RlH+40trOOeudKvMotsvW/7NXTVbs/xZSI78ycEDOPoXk7hLXStMGKQi0M18FQN3ycb/iyTkWmKA3omdimyGioSrbDiPM6kiCFdXj/YlV5w4r2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFvrXsK4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFvrXsK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19A51F000FF;
	Sun, 27 Sep 2026 00:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790470653;
	bh=mlGblNF0KjkLghO+zmfgnegg8eN2gwMPX91bcyPsmTw=;
	h=From:To:Cc:Subject:Date;
	b=BFvrXsK4Z2evgqJht13bk8twZr1rA0W6y6Yaj44gk28lZyGl0o8dM3b5S3YtNlIZO
	 knkE1+eFF4LZz0OKFCTu57sY7YDLFZ66brfNeEEiMkgSlqeuTW0fXMyrPqo4NIxJy0
	 2cEv1Hq+MtNqi4xsqMjNkDIqi/QZUaXZX1kzGrWynoipmap3GGaYp8fSr+9dbPX/OW
	 fFETXxYRJmchojdxtrMcryp8iABdQFNRJskE740OCGbnbCP8cTZnEYnCViv800SUnA
	 V5zSw/KKRU8PZTO4dOxNhjEsSBCiZtm7oEDeNu0rERl5d7Dku1IYwTqSYYXeT3e8sg
	 rjZX0B6Vm/HLA==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] math-emu: fix wrong word index in _FP_FRAC_CLZ_4
Date: Sun, 27 Sep 2026 02:56:30 +0200
Message-ID: <20260927005630.8202-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_FP_FRAC_CLZ_4 picks a word by testing X##_f[3], X##_f[2] and X##_f[1]
in turn and counts the leading zeros of the first non-zero one. The
X##_f[1] branch passes X##_f[2] to __FP_CLZ, a word already known to be
zero, so the result is 3 * _FP_W_TYPE_SIZE - 1 whatever X##_f[1] holds.

Normalizing a quad then shifts by up to a word too much whenever the
leading set bit falls in word 1. sparc traps every quad operation to
do_mathemu(), so hex floats parsed by strtod() and scanf() in ordinary
user code come back wrong.

With this, the affected float-parse tests pass on a SPARCstation 20.
The wrong index has been there since 2.1.97.

Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---

Notes:
    - _FP_FRAC_CLZ_4 is the generic 4-word helper in include/math-emu/op-4.h,
      which is why LKML is on Cc.
    - The checkpatch error "space required after that ','" is the
      surrounding soft-fp idiom: every neighbouring line in op-4.h is
      written __FP_CLZ(R,X##_f[N]).
    - No Fixes: tag: this has been broken since 2.1.97, before the git
      history. checkpatch asks for one to go with the stable@ Cc, but
      there is no commit to name.

 include/math-emu/op-4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/math-emu/op-4.h b/include/math-emu/op-4.h
index ba226f8237a6..429c8f5cbf8a 100644
--- a/include/math-emu/op-4.h
+++ b/include/math-emu/op-4.h
@@ -170,7 +170,7 @@
     }					\
     else if (X##_f[1])			\
     {					\
-	__FP_CLZ(R,X##_f[2]);		\
+	__FP_CLZ(R,X##_f[1]);		\
 	R += _FP_W_TYPE_SIZE*2;		\
     }					\
     else				\

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.47.3

