Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530403;
	b=pNlzLfqUT7KDG2j73UzKzd+qtUndWmrTOKyYWyMOWSsTWVxdfjTXNRKk5Ym2ntxKtrZs
	 qCGOhsweZ631PSF7RZFa/G3QJDVK6A8TIuS2UYjjtcZivrbc/CGv/wQNNR59wgXkgMVNk
	 vF5KdJl/XiMivjcDbRNOYIguIXbTJ0l+s56ABeatCv1X7orbRL8HTe7RqtPbNLseAyZx+
	 gXv8dVV8LvdRu8XKHdwMJ98ef+2FKLYKPdRUuJckB8BgpFLAQEwVx5fL45j9SULOL1PaZ
	 2PSQ08Njkw5jFHzdcOrGCK+rijDDohVqkR2g0ls1V9GqNbdOMzrc4HA40r1e0Jr8wXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+d6eEbZKJ/aNP1yn+6FnJEHBwBfqiaSaba+IM01vpDY=;
	b=R5/k579CIwZeDicdT1PtIYpgbAW+DpI3XWOWk+qqYqghj1gU9JpvJ4ftjsPhSx0h4FGC
	 +gUvyc2tpuN/MHwW6RQSpEjYkF2FzidtSOGSUgubCv8Fdx+YsL8Nyn2/HnOcGMdt7trw8
	 Urwk6QNW9J9xxDjv4EtfltpBe/SkcQOUTzdRkJcnQ3bvxoXRKLK6Lyx+Ns59ToQkw4Ase
	 1Cn/VDsZYsNgwIg0AeWi4V8zK/bmMgd0eHXZ0PyW02QGeXoLxg+4JaIXDqeC6OGSyiM7k
	 d/NAmk3SShCLjWG8VjQIKd7Ol2fof/SZgP8RcnzPWLMn5Yw8XqC6Iq7JWgk0lVO0ljg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LvzNWWQw;
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7B606A31F
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1D7B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LvzNWWQw
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-1433e7b05b0so3258c88.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 14:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792530402; x=1793135202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+d6eEbZKJ/aNP1yn+6FnJEHBwBfqiaSaba+IM01vpDY=;
        b=LvzNWWQwUrnlVEXkdxA1pQnsUttbPFEoCibBVemm1J2KWDVc9LAjs08388l95wtvNY
         C9nsApf9w0rfW33dyL9NJiZ+wTnHPWqyWuU2xw6q82oWMW2JcifkTYP75TUgUyJLPcNL
         atwsqngnfR5TiRmKRHtzA7IsKLYRze9YSvpdamh2O/2OMpgPj6tQb9dpEFSu/sNBs6oS
         gvJz9eqNQsmmpk4DC07BukVzEWdmNO2GbGPn5h7936WTPrAhLr5NlSSkBS4MCKvl47pR
         ixsq2XKLrj3SGn8wwejV421oTHkuXB15XzqAh0dFnPfJGv4V/WKt77wiyzCa/bGuyoeQ
         2AsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792530402; x=1793135202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+d6eEbZKJ/aNP1yn+6FnJEHBwBfqiaSaba+IM01vpDY=;
        b=V1GnNuXd4wT1cJ/9FizFo9tGjOBDpar+tAHqJkYhitcJZmRthsBvQji2QktK6JAXQm
         eUxS7jHwAmnuNSnecWMhmreeD+tC7NF5lp1jp4ui/wLAvFz97mM4PVeNg4960IoXtpHb
         tD+z17FZQnxS0lUvbNks5GiVbzNUTT6oqp2UUyEGNOPaSpViBYzJT7FA1CZJPAHmjNjN
         WVkG+bUfpK43so8I1Nu8nzcSKUPnl9i/FS3bB1qVVzj7ZK716orNuKbsuAa4fuuKGMCv
         tsLRz+/EQxGrAaOjUYFP+jpbcAmwhNjEhTZWgo+XZWlGUgnNoO+qrwlHYeyInXMAqgNF
         af+w==
X-Forwarded-Encrypted: i=1; AKwUvBzWBmxy1A3sVPHSe+tJzV2NFytlSu7mKXgTul68KCv01qLe54TG4BDSg93MdsmFNiGu+MLtrQw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVrIBWT+Uofq+JE3+h3z2FmrsE3D2DiZ2cxfnGNDLHfObIBi+a
	yM/rss41Hial8z1VYVJiC3phS87jm5GUA9m7dyF6q1PSJf4hKSbNV3BP
X-Gm-Gg: AYBFou1xFaPTXRiy+CfTspKP9HWyw3gOUZEK3JyRcB5IxrWuCte99E3dUfPy3sNq6Cw
	LM9n/v7KpRaqFAQGK8UfdmrXXRspXam0njS2Ozt4NyGhkGkyC1OqF0GLZ0k7LBbSGAuTxOaPICn
	dFwMLMM6TX/QVF1P/R9pi0r9d4CYBdJ9kXCRIEXXMWdBvEb9fh485si8Mnnvd60+Xi1u7+s0iJ+
	Qilu8RYB2JEUKqYvLaTCvl3sR6OLOO2w8Ei8X0NAfuypSi6YWSngaYrLiB/S3vCxkUF7HjbTqtk
	BH9nearu30YqUkgqP+gO8BtCziGtGt2MIPlXn0szJSaf4Qdi4aYR4QAOzQASJcN+fmP8I961AHG
	MdvPKfyc9pDcEfRKcyzqE4jscljIUwX0h1c9iaJAR6rVr4t9bAeS4HnmuBQcgvjvcbSFJplWejD
	M75VV1AlCLbQ/FTAxF+scAQP3fMxeENMSLvE9ppfdXZaSmxXB/rdNNLVvNKOZzkuheZhyHzb4LK
	zETYT8TKxwsB2+B0g+sGtYxqA==
X-Received: by 2002:a05:7301:4549:b0:366:9f06:3c4c with SMTP id 5a478bee46e88-3674df47e40mr439488eec.32.1792530401643;
        Tue, 20 Oct 2026 14:06:41 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e15353csm1703196eec.2.2026.10.20.14.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 14:06:41 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: arnd@arndb.de
Cc: akpm@linux-foundation.org,
	tglx@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] compat: Avoid double rounding in times()
Date: Tue, 20 Oct 2026 21:01:57 +0000
Message-ID: <20261020210157.52057-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

do_sys_times() already converts CPU time to USER_HZ ticks. The compat
path converts each value back to jiffies before converting it to
COMPAT_USER_HZ. This round trip can lose precision even when the two
userspace rates match.

With HZ=250 and USER_HZ=COMPAT_USER_HZ=100, one user tick becomes two
jiffies and then zero compat ticks. Every odd tick count loses one
tick, so any of the four tms fields can underreport CPU time by an
additional 10 ms.

Return the value directly when the native and compat units match. Keep
the existing conversion for differing rates.

Fixes: f06febc96ba8 ("timers: fix itimer/many thread hang")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 kernel/sys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index 35b538ba843c..755bfa5ccd92 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1077,6 +1077,9 @@ SYSCALL_DEFINE1(times, struct tms __user *, tbuf)
 #ifdef CONFIG_COMPAT
 static compat_clock_t clock_t_to_compat_clock_t(clock_t x)
 {
+	if (USER_HZ == COMPAT_USER_HZ)
+		return x;
+
 	return compat_jiffies_to_clock_t(clock_t_to_jiffies(x));
 }
 

base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
-- 
2.43.0

