Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6E738D3EE
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789336460; cv=none; b=C/GZigrUzAt1usaWCeRgxN+qMMfHw2R1xWWzXdSijZwtigZ2iFtHqBsV7/KgNxMQGd7ZpwHi1BdYYIwlOxO2YTBbPt6jaEhKOmIGjS0rtb0lUm6ad2JZKr89Wt3gmc4fx4xk8tvhEkgiqRsm9INnVAgmqw5qqucpz34QioHXTlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789336460; c=relaxed/simple;
	bh=/6yRs6phWpHS9WKXgR+JCwbaMv92lsqYofJsXkDL7d8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOHfiwofiljBCvMq1QLJrzpa7bcF8dFrrPNyUrNMi25l1tVInbBuQ2IKrbmM7uDJLKvPH1Vmtc2vqyNFfIch2rQY3VXpUdOiftZDEB0z2WH6Db1wkMzdltITtxuvL5fX0PuNfGwek3zd/tUYlxtVBqADmqjqqEu0NfYJ3eGysKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGjnlbfy; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGjnlbfy"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so4210715e9.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789336456; x=1789941256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/6yRs6phWpHS9WKXgR+JCwbaMv92lsqYofJsXkDL7d8=;
        b=FGjnlbfyl+IVlKfP4YUAjH6olqzs5YGQuEKc9PQ/OyCqfieE4y5auJa/uW1bADqmZ+
         9XFxz9xnhmgBxn8gMUSKwFvo2ofsdl7QXntGf4Fnv87r/tScovnUgVUoMNLN01sUPpTx
         zEO3xbw2TExfNNvOEfmk2/HTdAdsKgHyhYBQltQoJm1yWfd7BC/AEtLi93lfrRQeCz9/
         bJ1Kie7rpo5NvG6pVVyVDvoKrtImBWpY9VPnmLecn9eFtIiqTxUm+3G0gC4C42K9kbsk
         9dHMX5FzoL0SITxjJ3c56PVlwBdLPy31yMr8walT5acDItzJ4OTm7Hwj16w7ExSGYylj
         zHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789336456; x=1789941256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/6yRs6phWpHS9WKXgR+JCwbaMv92lsqYofJsXkDL7d8=;
        b=UBaoWv3kWKv/lz9MGkYlalh9BuqYBEC/D5JxcvHuB1KtGrJGSo7MirzqMpTwg/1hkO
         xkRvx3xePeB9h1YAiD/NB8zIdk0EjsVpUyJpjI4pnC64jhiy5f4dEMKrswtudMn47X2k
         ip++Gj5RKLL+9pa9y/N4tvmNO/AVNXovXVBd0dZZrH1nT3hINA6255euhBYc/UocbNpI
         ts4zfqWZwdh2R1TPtvccGSnKNpHZWMz6D4oF4jbrT9G/huIsK22Y3SsE4uAFvuA3SgZj
         3yj/NH7Xjo0vVuP919acZ4NFVtdkD6IAqQiCYh9/Iu8gRL8OdBExK8yXTKW5O2ezAJR3
         qsqQ==
X-Forwarded-Encrypted: i=1; AKwUvByfWoHhir2k9uUZ8qDD41Mq1m65yYBTI5vk/jgxrRjhUPAUGXWE7s3jtBofAoYaU2Y/TDlFuDg=@vger.kernel.org
X-Gm-Message-State: AFuF++mBM0iAaTdrW8FnrvmyJpB/8h2L8HiHB8NLc59oM0DJm8Y5pGu3
	55esxChSAcbc+CH/oGpn/xw8rr9Xf/AlMS0TLS8i4ycW6GpHciVw8XQF
X-Gm-Gg: AYBFou1NbEfV+o39n4a9VS/HnGPJDUSX0iIWNcYu1UvLfOmYQ8qKMYQV96c9eo2vPBU
	weXfW/QPbWLSGo11/i8iwBtIiMXU81+ffxDduUU7zCpF9AwjLzVv79IzXKjgS3Hp/lZcywGCI/x
	Y4z0RUqiODGyW7YdybFnqPWmwY5gngn4TbKd9aGo2qKLoNNnT6YQhAp/RTDfyMngp75Rqeq5mo7
	fSsij7ewfJw2dUTNs/mZUU4PSnY3p/9M0ZHis8ZKJIK3FISowOQYUfA0KjNZNbvIzU1zkbjgBWi
	33fj36X6C0we9UKOkdXIRLLoR97oK2urPQSTaMWNvWNBoLwj1iSEF97EmyUNjNqSF+veNBTE+SO
	HbMYOnIKJJJiB7p1OpY4QJNnYcCUO/i27PVcR2AHHB3mVy72zsVBTEOnp2tyCFhEjwPwXU6DRex
	rTon0hiyIQCkONH5QSBDvFghV6hjKCadyLjCq3GdF3McfwgTbSGxLi4DSdaLKRmD88bR9TRwegX
	NENzhkMiCVPkWLQdgPqbaoPwb33kZs3kA94hzfKH0meGs+fmdVCWjphSYXYsdr4ocvdvj87ERPf
	pzUlvw6dgThEdhHpmmHQLA9MHc/0FUtLrwKiP7k00AOFL9TNiUIrgwZIMgKDP0FikRdiVQ4pAjQ
	sTMo=
X-Received: by 2002:a05:600c:8b72:b0:49e:6a76:77bf with SMTP id 5b1f17b1804b1-49e6cad489emr77938265e9.15.1789336456197;
        Sun, 13 Sep 2026 14:54:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0e6-2301-7846-2cfb-35f5-6359.310.pool.telefonica.de. [2a02:3100:a0e6:2301:7846:2cfb:35f5:6359])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6fc9c027sm156932495e9.1.2026.09.13.14.54.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 14:54:15 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Meng Yu <yumeng18@huawei.com>,
	Zaibo Xu <xuzaibo@huawei.com>,
	kernel test robot <lkp@intel.com>,
	Hui Tang <tanghui20@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 369/798] crypto: ecdh - move curve_id of ECDH from the key to algorithm name
Date: Sun, 13 Sep 2026 23:54:12 +0200
Message-Id: <20260913215412.5975-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912065525.614310014@linuxfoundation.org>
References: <20260912065516.948645775@linuxfoundation.org> <20260912065525.614310014@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please hold this patch unless 5.10 backports of upstream commits
8fd28fa5046b ("crypto: ecdh - fix 'ecdh_init'") and 6889fc2104e5
("crypto: ecdh - fix ecdh-nist-p192's entry in testmgr") can also be
included.

This backport can leave P-192 registered after a failed module load, with
the crypto registry pointing into freed module memory. It also lets P-192
register without its known-answer test and be used in FIPS mode.

I reproduced both issues on the exact 5.10.270-rc1 tip
f69aa74a82509ee94a2aac2822b4189496f267a8 in QEMU.

For the unwind case, a test module pre-registered the P-256 driver name to
make its registration fail after P-192 had registered. The ecdh module was
then freed, and a P-192 lookup hit the stale registry entry and panicked in
__crypto_alg_lookup() under KASAN. With both fixes applied, P-192 was
unregistered and the same lookup returned -ENOENT.

With fips=1, the unmodified rc1 registered P-192 and a lookup succeeded.
With both fixes applied, P-192 was rejected and the lookup returned
-ELIBBAD.

Thanks,
Karl
