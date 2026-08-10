Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A29239E6C
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352348; cv=none; b=pN2L9iXyopqUn5/GkhHL1NfgB+Tkg8jb7nrQi523F7iMG/SxniEFYjc2Kk1ksoj3oMWiEC7OqrdwPcH6qXp9TBhrRcw7Wz/bQX05DTo2SQm1gMz3Z00mw9fSCtsAUnl0RhamcpiBb9T+rtTAiBZ0T2m1DAgsvL6LIdc3LaZSCdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352348; c=relaxed/simple;
	bh=Hk8cW0uaXVz4JBFUEpMkdv9QkfYRYlB6IN/xfMy2uUc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=NndculkBVjn7UxPWRddyKoaUtuZqKUbd8yuk2SiBhMYUmQAVyn52GW+Uo01cpraH+EpBJvxlDJeknpxVr+E/6ZnFrVjTWWf4sgYfT79yq+ywtWUQQOvYYrY6qy2LvlOMRJCZ6jqOWt+hqKoBNmmN7dy6jdNe+NcwdCitDwFQacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=QZYKj/f2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="QZYKj/f2"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1524243a91.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1786352346; x=1786957146; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=95QXzKPRYkepnQr8mp5Bt6sgxyPnPvfomNa0tdG5d/k=;
        b=QZYKj/f2zr4A2wYOuI+qz1l2b/Gm2dG06yJRmZp/ZaAqMsKABhdmQNDG/uj9f+9O02
         bFHzEKBkg8vKWJ+y7Go4r70yo3VnvkzVtJeeIPCZCZHEm49OpJLx3/YSKj2oBPW2GeGQ
         T/3LQM+/xr2b4gppd805+ohTzzZHKC+KUWnH/PXC+DdD8UvaTBu9jaoa6qPiv5cW5uB9
         iIfWv97w1Z94ls6+hJ7KFXvGBIpciNgdwEP2TvrsikFABBbh7u/TfEsKduUgDofSJ6Zf
         VkCvDF2DZKv5K3vUd0Xncui8My3TsyMtNi+swDBwh4Pb0HTex8B+wCi0HmJTL6PFwnoc
         ZOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786352346; x=1786957146;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=95QXzKPRYkepnQr8mp5Bt6sgxyPnPvfomNa0tdG5d/k=;
        b=rNqV1TWrSKBUItQ1mOuOp0Lm/sALQpm8VYkcXqP0oI5eVHk8BDrOYhpNzqWWrwFQXi
         N/rysRSxHgVfUgIvJjYMuaVRTQRt8YsaX4JS+HxP7eQG6ze41gzzRfv2rZh04TiF/0io
         9AkAlehrk+US4pFoYOpsmSlm4gqHEjGXohrS3e9G7vawXEy/WPXiuvzLU6TKnSq4whAc
         c+cl1hZUSV78a/WNB95+buFimNgadeoJJDGAIMPGj64RoL1wXOC/4ZyNQW8b5iGcvZjS
         F6yF9QrYkJG/qSmYCmWLa0oMxR0IG1500xkBtNbyXeTei5WTINdnskeMiqWr3MuwjLbW
         /7Nw==
X-Gm-Message-State: AOJu0YzMVm3CQBoeNDPkec3uMU5PhtEiSkDBF68L0ikrME1YjGEf1g4B
	fL2GZELi4M17Mwn7PEVD29CTtUWAQgxgcaCOXOMr6Ozd8iY94Xqt8q1ur/4Ikte4h0BbQ4lounq
	32CFn
X-Gm-Gg: AR+sD12W4D9EavhhJfnqI9zmtJVIzgFKhb/l1GbDLQTs+FcvIxiAV2FDz2RR6eRSZRH
	rIlHGENLW7iEIrkR7DetJugR0ac/6d5UErh/pBvDhk+2zsgMItoDD5fc7+j4C9BA/bFYVS5hslS
	SGPxwSxx86YfFKHPtmVi93qgjJNDeX6S+RgPv2D7/G5lrMAxQ2K543Ah3NrQhSllRHgeYnRAHY6
	d856p8Q688ulvSA84zCr/reY9/nvibQ8aw0RgazvREfe163oZmFh325XuclqmhaqJtTo13dCjWV
	2mdu/HtUdTK9/tcqZVgFhWhCawaxnJBxOdJCRnqmVKWKYldbTesQQIkChDeYkn4kwm2jlIBsaP8
	9xBqEuLn8pmUA7HdksjDPAxkrNU1uOT2mtpf7MccpGddG+bJiyDmYIWKhmFH6B+4xOJlYm7G55e
	rmyacSgnHpwx6vzl2JOdnuosI+sOo4ua6NXUcZKQV+NYQFdzvPOz0Ahg==
X-Received: by 2002:a17:90b:2d84:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-3903c538263mr41435592a91.8.1786352345703;
        Mon, 10 Aug 2026 01:59:05 -0700 (PDT)
Received: from 9a65d8f5b626 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7a772sm33608752c88.12.2026.08.10.01.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 01:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) mm/slab.h:572:24: error:
 duplicate 'inline' declaration specifier ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 10 Aug 2026 08:59:04 -0000
Message-ID: <178635234375.1348.6486004617778303035@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
 mm/slab.h:572:24: error: duplicate 'inline' declaration specifier [-Werror,-Wduplicate-decl-specifier] in mm/mempool.o (mm/mempool.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from mm/mempool.c:21:
mm/slab.h:572:24: error: duplicate 'inline' declaration specifier [-Werror,-Wduplicate-decl-specifier]
  572 | static __always_inline inline bool need_kmalloc_no_objext(void)
      |                        ^
././include/linux/compiler_types.h:249:16: note: expanded from macro 'inline'
  249 | #define inline inline __gnu_inline __inline_maybe_unused notrace
      |                ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:7c5e63727edb7ab8fe66c182c096b19973dc4c24
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  993a046a044df0f29fc81dc45039a2a90dd4ae67

# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-6a75eadc62f33761c0901384/.config
- dashboard: https://d.kernelci.org/build/maestro:6a75eadc62f33761c0901384

#kernelci issue maestro:7c5e63727edb7ab8fe66c182c096b19973dc4c24

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
