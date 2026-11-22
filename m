Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795320368;
	b=KXieMwVLWY1rbnc8+P68jEWHlAx1iT4WgO6mSGsQQqSXszrcor8XbZFN5pT2j8FKxLrF
	 nJiW1NK9HHcSNQY7kRy7Mi82TuKGxL0QJPF5FPECi1FK1M1aPVCdAhQy4hZSiCj+uRXJk
	 8ZVKtqEr7okXOVpQKEr06UP+pCVxZI/6R3p5cPWdmY+bDxu2Pt5SBB3ng5StUvVRH7Oc/
	 QYO2XF3HHtCe5bGnl9tqYLrTtx+9YGlaQuhrhrdnvGkUgbTEWe/AudSnaJys4qaF/LZtr
	 l//zg7VAtkVIt5WPn4eJ7FaRnGQLyQhhOhEuvYsxj52UB9ceVBWTGtCqidWCuxyC2hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795320368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9PuR6BxW1bsGd2uW0XkZ13RLiKGF+CwssnUyvB4C4G8=;
	b=pam+Dc1uv6tptVuXFSdTnul+MoVTBSZoJZDyH8LvGaww1mdMQMBtxyBOcag9UApIVC0Z
	 zyImUMl4N7vvuj20ihxdDbAv63DSukqjv4rRwxKLvWprgKFDgayMGugJ+o5WITMDqwqXs
	 MxAqone/7eR3U5rCElZBLJ4DAFWYRuIZfmgw2vel36XeyVB0Kt2MCS7fdhUEUfKjPdbQX
	 +OLxnPlSPpRbJg/gaUo/Flbzmdt3YGYBG5inVEfmOtcM23QKVFj7IIr/sKTM0YdQbjV5W
	 Z86GZtwIVyQdN8/H7r7doFAxnw3eOBEXDhy9jPnaTKdUznxVq2/rpfaVdjzgy4DF4+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=evJm+oLs;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2E606A330
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 04:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FE2E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=evJm+oLs
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f0213202fdso11314755ad.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 20:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795320368; x=1795925168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PuR6BxW1bsGd2uW0XkZ13RLiKGF+CwssnUyvB4C4G8=;
        b=evJm+oLsq+4kzc84VKAr4CtJzo3IfsCj/gVq3bR6b4/RunCaPdIAKKDRdB60FHOri/
         kXkXUd0mdLQsZD09OcorgB7ZMX+ElbW8SGM/rhASv2H/S4TvQ/n74BdpSG623qt//u5z
         j/uJNP4KhMU6uyWbwCttDb9FMO4E1+Q/ZvKCu+sot3am8SunnqGZPV5NgSDEKslxjHgm
         wiUGdjewEbxDdTxs2y/9gUKe2RNXOeRrSAiMr5oJT+4Z0P/P8FvOXQOm2AGNtYLiI9N4
         lSlvhzjKnZRdrISEPM0wO7qK2abATsVypk4L5e8RDNAkPgWRh158PSz+CsDiimAzaEyy
         EXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795320368; x=1795925168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9PuR6BxW1bsGd2uW0XkZ13RLiKGF+CwssnUyvB4C4G8=;
        b=m9zI9s6fZtvTrx2Gywst+ZeHg26DpeE5SGlzp2+3Gvq1gkYI+DUdw78rwKA+M2IyYI
         xekMYPoL3H0CcBPRjbOdPlx4XMp5HrdUvLbjcvUElp8Ke4ADSAocnXXwX1T96uxztLe9
         9BCO9ppFJGm+ingRj05rrtnaRL7+VnwSaOgX+8KC/vtNyB/8jNtK0coMDWqTPH1zNTRu
         4OMMCCqFDxXNWjEzQHwFMfzUubQ5/Sz9IwhQByuQ13UdrGloHbCD+1yGL6OQMhOqfHvF
         CrLAlSQoxLRrhULdQmp5OXpo0TRPfdo9Ra4EY66O5FyVP2TH3j3RvzE8dPjjQ4OEDDzo
         djFQ==
X-Forwarded-Encrypted: i=1; AL+hErG0CY3WB+FhNd0Fn7N0/vbQstumWoOHQdAmIgOx1PnGSCYsxyWNPmuka1xOjXeusQjoi4xTE0Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jnN91KB1fxgCptWQZSSnvPiqM0u9PFn4rN3XcgGThJJjivgWw
	fCW1QtRtpvNkJJGBiXThgwK7EBhpeIZLO/3WFgsMkSMutrqR1NioWbi5
X-Gm-Gg: AZFdTZcyDiiYGxIW64Q12wku7pfFmmyrVuDE7fyN4lyhIyZCSTibcvdk7SW2xLQC2eZ
	PgKnvsaRRpbSJG0Be48wIkDawO6BSkCEI6vDoFtKGwyG1BbPy1S3QzwDeGvsYJHibAxpc4jrUTG
	xBIAqYu27kmCzjEd7IvaphBa4L2WTiDruA0x9LguqPHqBzeg8Pqv6ToLDoycMCKOO6FbEtrhYVu
	lyADpSuF9NyaQs2AWywn1/LCRdTfsvWAWWI86ZopIbbsrmRIHvy213aQiP+Nzz2iDf3qu7JQ3bL
	muNHwZHT+wbhSa3HWry24o7qcgCDhavQz/AKu49vDD3VA5ZqsSUASiNT1eIH4iR3pHMDXEGKq5t
	pgxsEk4X8/oheWGJzKyvB2Invak1DUfE6UW1mj5RiFHbxWxQJlkbv9D/4106XikJtfDoDqEoIzC
	fwylXP+Psw661mo5Joen3q+AY5917I61OVvcOlF2zMywBdKeKI1dj10//uXahpuM1nV/GAac9Ok
	orWWntNkaI6+XtP2A1KQwwxtUsts9ROGOzBfLalt+JS8+xmH8OACDHdHDRCgCqNOP11cOGnZJ8R
	PgYWwmk1kVCuSCDTRsc52VQ11O14Q8g6zg==
X-Received: by 2002:a17:90b:3d92:b0:3b1:2237:3c93 with SMTP id 98e67ed59e1d1-3b41c8de8d7mr6039371a91.18.1795320367746;
        Sat, 21 Nov 2026 20:06:07 -0800 (PST)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm10947018a91.13.2026.11.21.20.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 20:06:07 -0800 (PST)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-mips@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix genex.S build with LLVM before 21
Date: Sun, 22 Nov 2026 12:05:59 +0800
Message-Id: <20261122040559.1120594-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <alpine.DEB.2.21.2611040746160.6502@angie.orcam.me.uk>
References: <20261104030147.3117325-1-shingekinocore@gmail.com> <alpine.DEB.2.21.2611040746160.6502@angie.orcam.me.uk>
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

Sorry for the late reply: your mail did not reach my mailbox, and I did
not check the list archive until now.

On Wed, 4 Nov 2026, Maciej W. Rozycki wrote:
>  Shouldn't this use:
>
> Cc: <stable@vger.kernel.org> # 6.6.x: 56651128e2fb: MIPS: Fix idle VS timer enqueue
> Cc: <stable@vger.kernel.org> # 6.6.x: 2b6d718c8dbe: MIPS: Fix whitespace damage in r4k_wait from VS timer fix
> Cc: <stable@vger.kernel.org> # 6.6.x
>
> then to get this all picked up?

Yes, with one more prerequisite after 56651128e2fb: b713f27e32d8
("MIPS: Move r4k_wait() to .cpuidle.text section"). I will send v2
with it added to your tags.

56651128e2fb adds a .previous after END(r4k_wait), and the .section
that it pairs with only comes with b713f27e32d8. With only your three
tags, on 6.12.118 and 6.6.162, all the code after r4k_wait in genex.S,
handle_int and the other exception handlers included, is placed in
.init.text, and a malta kernel hangs under QEMU about when the init
memory is freed.

With the four tags, the cherry-picks and this patch apply cleanly on
both trees. For malta_defconfig, genex.o builds with GCC 8.1 and 16.2
and with LLVM 13.0.1, 17.0.1 and 21.1.8 (on 6.6.162 also 11.1.0), and
kernels built with GCC 16.2 and LLVM 17.0.1 boot under QEMU. On 6.1.y
and older, 56651128e2fb conflicts in idle.c, so 6.6.x is as far back
as the cherry-picks apply cleanly.

> Or is it unsupported annotation syntax
> where a prerequisite matches a Fixes: tag?

It has worked before: the prerequisite named by 4409df5866b7 is
its Fixes: target, and 6.1.76 and 6.6.15 took both.

Thanks,
Tzu-Ching
