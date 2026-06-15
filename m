Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7214C2E54D3
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544094; cv=pass; b=Ojz37xyhdxgnTU9vhlXA2bGxBsbVw+FC7xaUidGJTdfv2fUvhucuxVl6PAhF3Qm7B8O14cyBlzwDuZuhQiou7DjpgM3Zt4JZ0srDR9D5j/sL5wE4FMcte5AGLtbu593clrk/OHwXm6bAGu5+VoDWmy06rLnmDAECMdiVz2FBHo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544094; c=relaxed/simple;
	bh=wF5HKc3NlWnMYgKJPWbT+7KgZJa0XNXIuSPTgCwQhwY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZLuGAiN2u42O4LJ9y+jSHeoj0RNOff52mDYx1vEnhk9X5RKhp0hrIenOdNlTbcIVj/d16iJTX2s624Uu96xYF5mmjRf+iau4hPfJZg/RC66EG9gW++8Gx8Wv/Ookik9WkX8gHlcM4bqw0g/HeHGZigSDotC9IkjSxYk2v/8zatU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVUZTgsJ; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVUZTgsJ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-660512d80b4so3574345d50.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 10:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781544092; cv=none;
        d=google.com; s=arc-20240605;
        b=D0QkypkdQUq5czTepC6yFVWzZwpF30mYjX62xTOy8u89v5EfkJ5oueuvP2wmtluwUZ
         dQqUi+shL8s3AtCEX5H6Q+Ky2TUD6F9G9MIcsguaOqB9ucYISNSYlGrjEYR2yQkVZvE3
         Jsg1fBQp8eGq+fHcqyQyrOoyChFAM1t62Bz7hMxrAXSc4fiiWsCOvXbx8nEHI8CCJuo/
         1LvpvQNFBHwXi13ZQmaUPN5KYGFH3lAMpYEsHn+Y8je9t2PGQWwWbjFoyJwlZYz0tbi6
         UxAvyixjMw7tEcxR0h4p3dt2q+EH69ggD4XujHdXJTGI47GSVtyCrKzmPnIDsVqVWg7V
         fgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=wF5HKc3NlWnMYgKJPWbT+7KgZJa0XNXIuSPTgCwQhwY=;
        fh=dFRubkO4IQjg/G7Ad7vKgDQE1myXg2zlQSpzOScAk1Q=;
        b=RrXMAXE9DbyyOzq0x3OsmrBJlwmPTI83vqVKDG+oujlO+Qb+QqkStpORdjg2cdUKH/
         7sbFfXgMy9qFwBvvWTJBBM8CDy5plzYxebqvi8bqDGI8LlCun231t90ztht8Leg38mdd
         ony381vhw0blUJgOvf3A6iSvjtw2nkui7OxpYe0bn6yMWqUCn7HazDm2VeZqiphzhZs4
         cspfG+0eO4b1qsueqHcWhtwMoAQkMjqgq+rZwCGUvZlfNQAkqBCf4VmFDzYx84leVlOV
         7qVVeJ82JyHE/XagJtkCNlWTgB5BI0c7cqfjUqe02pJZgMaS+C7uW7JFAieLY1cBsfgF
         tYsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781544092; x=1782148892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wF5HKc3NlWnMYgKJPWbT+7KgZJa0XNXIuSPTgCwQhwY=;
        b=XVUZTgsJJ6eT7IthbeqM3ghLvmfW5405ufh59NCt/8p3KkajgW6mhvPpwEWqrMTDkn
         zGTkl6KWr/GHCx/C6DtIVFfoBQDqYGRw9wtvEMNn3P+Mk60I85KCiVvi1nXq49w0x158
         l7SNshYnYleTZgyo0WXlpsHqjbuJHzpvHLmP8YkWlKvAP1/UMylbb9QHE1+/IX8LmRgJ
         4Ul833jIYYeefVIesXRJUzD0I7v/iq4p1GmgJIs8jDq6ut4RsyccfO7lUwqjeXYYpdat
         R6cPhyvrJhiWYqh7u8nrqA/xUhgLvXUrSWrXmu1FgT4XdjhWzUjXXiOYSNOWf67HlVQD
         Z/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544092; x=1782148892;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wF5HKc3NlWnMYgKJPWbT+7KgZJa0XNXIuSPTgCwQhwY=;
        b=QS0nuPQDcMH+0Eu40hLvdceVsCvWkWWsPifA00vZOgDpDpMDPFfZvzQJNvc9XisMC5
         HEW+V+d0ST/d+DTpBEZLcPnblT5khkxn5QxzPaQXxIyIHqJLXxh83axyJcTiFuZVaJiG
         D4yjmWw836n7jp261F2+jCsNUC+7XfFk4F3n86Yazqa3hoOFwLazxEYRS3KCEM2VYMYe
         uay9QbN7zwt+uCKGaYMj2mJo1m7Cix9ltx1bVAU/RLCUCrTG2Rh6QHeuPy1tRArOEBBt
         jbCBJSEa8p08GJyBnJGLew4bkViqLiZ6pN0G5fA0lPD8EpXc9WIIgHkBIZ/8arF39W5E
         6LXA==
X-Forwarded-Encrypted: i=1; AFNElJ+IoWTZOpHmxFyosslgj7XNgJkMMHZhCC/QPoLFydwdYEt7FYiAp5oxQorv/tlFiluShVlNiMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrf7TsNPILd6yeTS8K9OoGykTGCARkVn562sFfPwm6F3NahuID
	HG2pqSx4lEfqD1qPZW3ZniY1tz/I3djrMDGF+oHMNSL5eXAXgLta2CI4yZ8R5X1lwAPBFDBUUjL
	xzWsp4FTPKIIzrGrmtOg5FVIKdfQOcF6OdA==
X-Gm-Gg: Acq92OHzUOrqp+ghZWxzaMIXN1IIzNL5oPs0AzksoRpeDHtJia5SnW4e/DKtZWQ7mig
	kasSnODp8Ueu4WAOEmk0tGVxjn7+jDNWGKbWeaRe0vcp5x3jV9ykpSzi/WK2UMmZF1u0DFOpnln
	nn9WysOAEB2QzwdP7kbliuV4VTyQrUF5LjrmTNMN+P4lIPmEgWbaGy8LB5sqE8LX4vmhDy8Al0N
	+npxsesiwTQM+6eOLRn8xqViDkqYymBXdHP4nMMWozX+oALhgpvkgHcCB0myRf4ZrmSbGmE5Cco
	hdTucg4=
X-Received: by 2002:a05:690e:43ce:b0:651:d0a5:cd8 with SMTP id
 956f58d0204a3-662b49b16a6mr232309d50.16.1781544092547; Mon, 15 Jun 2026
 10:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
Date: Mon, 15 Jun 2026 19:21:21 +0200
X-Gm-Features: AVVi8Cfx2WLvuC07gWkUHIYLkqC8GRswBa4fvWRv9pAp9jc9hAVjLgw_TGpHFzM
Message-ID: <CAFAa3YBfk2UOjAktrLq3_9+563m6UZuKv9XdBjfp2aB1twV1HQ@mail.gmail.com>
Subject: [stable request] ROSE memory-safety fixes for 7.0.y and earlier
 (merged out-of-tree in linux-netdev/mod-orphan)
To: Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, linux-hams@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Jakub, Greg, and stable maintainers,

(Resending in plain text; the previous copy was rejected by the lists
because it carried an HTML part.)

I am Bernard Pidoux, F6BVP, an old-timer ham radio user of the Linux
ROSE implementation. ROSE and AX.25 no longer have an official kernel
maintainer; I am one of the people still running this code on real
nodes and fixing it when it breaks.

Over the past weeks a series of fifteen memory-safety fixes for
net/rose that I wrote was reviewed and merged by Jakub Kicinski into
linux-netdev/mod-orphan. They fix real, reproducible kernel bugs that
affect any node running AX.25 networking over the ROSE protocol:

- several use-after-free conditions in the ROSE teardown paths
(neighbour timers fired after free, socket freed under an open fd,
sockets reaped from the heartbeat while still owned by userspace);
- a rose_neigh refcount underflow in rose_kill_by_device();
- netdev reference double-holds in rose_make_new() and
rose_rx_call_request();
- dev_put()/neighbour reference leaks in the loopback timer path;
- a notifier unregistered too early in rose_exit().

These are crash bugs (use-after-free writes, refcount underflow) that a
remote peer or normal session teardown can trigger. They have been
soak-tested on production ROSE nodes and confirmed to remove the
crashes and the kmemleak reports.

The problem is the path to the stable trees. ROSE was removed from
mainline in 7.1 and is now unmaintained, so these fixes were merged
into the out-of-tree mod-orphan repository rather than into Linus'
tree, and therefore have no mainline commit ID. The normal
"cherry-pick from upstream SHA" stable procedure cannot apply.

However the affected code is still present and still buggy in every
stable series that predates the removal: 7.0.y first of all (the last
line that ships net/rose), and the older long-term branches that carry
essentially the same ROSE code. Distributions tracking those kernels
currently ship the crashes with no official way to receive the fix.

My request: would you accept these as stable-only patches applied to
7.0.y and to the earlier stable series that still contain net/rose, so
that distributions pick them up? If a stable-only submission is the
right vehicle, I will send the series rebased per target branch, each
patch with a proper changelog and the bug it fixes; if you would rather
route them another way, please tell me and I will prepare whatever form
you need.

I can attach the patches in git-format-patch form for any branch you
name.

Thank you for considering this. ROSE is a small and quiet corner of the
kernel, but the nodes that run it are real, and these fixes matter to
them.

73,
Bernard Pidoux, F6BVP
bernard.f6bvp@gmail.com
