Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA5363C77
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955076; cv=none; b=f9E1TFLj0/mHiRYJqv9rfKxyhqlQt8oZxEpaiUcdB9SFuS2d7gxUpfsRXOXYthQycnETJVwQYh2hkv0X1iGw2wfuYlTsXgdILf2Y4IOIMcS5mWukEgulBbOQYApEsKi7OY29H68KRd9yOJta9vl37btkVMjKR/imbPX5cBep8hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955076; c=relaxed/simple;
	bh=yLKKBSXUsGhyPa2pLH2oRJo2N+mOGa5effE3cKzB+pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFrhkFirYO17Sftgg7aEz/vx0HtJSdYSufumsTTiWbm+r+bTgIwjM/iL3VHnaiFc+AWXlCHoedx0e1s42+jumdSWtAsZyW5El5ZPrOqhXc3rdvAt93nIi5McVp4neMR+fhwzQ9dWHxjsu9x5lJkSePsseM8Ffdxa6TWcDSgcKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrvT37kA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrvT37kA"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so1013430f8f.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785955073; x=1786559873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLKKBSXUsGhyPa2pLH2oRJo2N+mOGa5effE3cKzB+pI=;
        b=VrvT37kANDH9ATvwsUvLo+6dDzk9t/oCuEt+H+tmrHcZiIw+Vy7mZL2F0lz7oE5yF8
         m/jeZY2XjjIw1NISFNMjXY+pYxZxlx254R6TlLlJ97VNl8sD9gnWWzQal+ujRR6FU+6J
         OgjY9DvsP1NZRnbAJn7IMn8kdu/wDUdoSskutEzHQQRurdIuxzMdurzPyLHkJXQTxaLM
         yqTXzwrQxJZZnOPVX8Bn87yWoQyi2sojTn3tFl8Suk0n7carPapU4DikRm324de2xX+4
         J023orVzIHaRAXskS21nQ4sHAWzTnu5prr7uobdRYgNQvmSYZ+nBDh0UyfpbFjzVHq79
         kIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785955073; x=1786559873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yLKKBSXUsGhyPa2pLH2oRJo2N+mOGa5effE3cKzB+pI=;
        b=A4QZ7uyfZFnWuH0r0imFuTWjlAvnqybUgaVKUwrKVKzT3+Tmg8IHSz9GoLqLeQaVxd
         S6VXm62mXjJE1KqNgH6l4mN000ilKF5yKX1Km7Xt/GMbZr43m6teRuZ+gc/803ORdE3Q
         wg5xX+QRoF8nN46bO7XBOgewg/7G59oO8vdmTPzNHcb09KxkWtSl/FujxaKGq2kf6rsX
         z3Z3QATweCSgjwQ+sOUAEkPW4x2JCcYkmXtD/lBA0P4JxamCT+m9wJLY48k1OpuSWO4A
         VuzR4LIQRVq5leW/NKrHyLtIvGiRkYrSNLMfSt/5Vtu5tRFIyx/zDvQZu0aKaPkBIeM8
         vzEQ==
X-Gm-Message-State: AOJu0YxrQxQEf3pA/EqXepxDBR0NQJyCL9Rj8UFlk6piLFJuhitcOTbr
	CvLdhaBQmt/+TpNA7B9vBf/bXZbpbldEIIYjw4JnATCBb+N7HiU5Ev9T
X-Gm-Gg: AR+sD109IFUHVMn3fTKmxku2JdSZlbVBz5M1NCJnVdu16tL7phhi6XE1A1BqNsyXP7Y
	vwQ4SfeC2uu9Bob/Vwxs109ozbwMe0P3NY+Hppd3jpP0LtD/c28bhLQvw6+LH2h2F/6pMAqt1gA
	vwaLkfv/1QvLUBNLnCn4kQJWsbqVGpQ8E6h7gNzNzGrBp9xgJW+8VCe8i+66c8SXzfYQidAEavj
	BriHOFTyu4YoLiwtMTRtAqXxjghTJgKVpDMV2x9OBws891PJouE/rz4QkxxkVMAyAK79TVe5vLQ
	sTaKe3FJOEDaSNt6/4nTSuorHFIYhSAeOBxG5Hp6x8z7MhPEA36EftCmQmQgDvrEPqbFc7qNHkn
	s8OM7ZY2HIEEaE4xz4pDYUgkDNFSafauXDIskrcIE2g0G0z9oGBgQ0vTd6Rcyr1AuWgakC0IdZz
	5uVqf0uHKR4AQKsL5Wwy/6NFKRepIDORjD0QcWu6muNyg1Xd5DLyxPt8r1SoKC9qptfIA=
X-Received: by 2002:a05:6000:1cd0:b0:47f:51bc:efe2 with SMTP id ffacd0b85a97d-47fec4f11d9mr12406712f8f.11.1785955073079;
        Wed, 05 Aug 2026 11:37:53 -0700 (PDT)
Received: from arbab-X395 ([139.135.44.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff5def8e8sm285662f8f.20.2026.08.05.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:37:52 -0700 (PDT)
From: Arbab Haider <arbabhaider649@gmail.com>
X-Google-Original-From: Arbab Haider <arbabhaider4494@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yun Zhou <yun.zhou@windriver.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Arbab Haider <arbabhaider6494@gmail.com>
Subject: Re: [PATCH 7.0.y 1/5] net: mvneta: re-enable percpu interrupt on resume
Date: Wed,  5 Aug 2026 23:37:46 +0500
Message-ID: <20260805183746.118542-1-arbabhaider4494@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805164000.stable-0008@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arbab Haider <arbabhaider6494@gmail.com>

Hi Sasha,

Yes, it is. My mistake. 7.0.y went end-of-life with 7.0.14
(2026-06-27), and I overlooked that when preparing the series.

For context: these five patches are backports of mainline fixes
that I carry in a private 7.0.14 tree used on embedded boards that
are not moving off the 7.0 series in the near term. I sent them
to stable intending to add them to the stable queue, but an EOL
branch is the wrong target. Please drop them.

Since all of them are already in mainline, and therefore in
7.1.y and the longterm branches, nothing further is needed there.
I will keep the backports as out-of-tree patches for the private
tree.

Sorry for the noise.

Thanks,
Arbab
