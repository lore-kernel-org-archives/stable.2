Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA52BD00C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789534496; cv=none; b=jQPHoTlWMV5NG2X6NujvNBdm6HYnp/Pyt9YsBLECmI7lMiX06/cd3svyAFdqtRh/mJyRb6FvUSFmAPiUWQOY6hj69jHW2rsYeh0yBm+6n00p7enAhRye6EXYisrNOgouU9u6dfVws3972EBxRoTyhX21EpBw4dYs0vJfAgRDaYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789534496; c=relaxed/simple;
	bh=aymB0R99XzwkhJfCjT93r5MDNgUoxKgZwoOzkeuJnMo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LCRPqaQ8MkKoj/gjLjM5mgG4/WQ7ExA7wfwIJ7NdE9apPxFimy4rkeS/L14QN7rIIsC3oURyoWh8MWyaeqKdo2G0Efea7pM0lqB9JEs+ZdoUA3LkizAD21JNgVvb/kpVOqI9kqafaPhnrjgefgMSpTYJyc6n96Tm4ex1KN29iwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=davidbq.me; spf=pass smtp.mailfrom=davidbq.me; dkim=pass (2048-bit key) header.d=davidbq.me header.i=@davidbq.me header.b=KAr7iBzf; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=davidbq.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidbq.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidbq.me header.i=@davidbq.me header.b="KAr7iBzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidbq.me;
	s=protonmail; t=1789534483; x=1789793683;
	bh=CyOXeE6i0ncJPpnLpU4cK321JD0Qn5HzLC4YC6ejAGg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KAr7iBzfELZTG/LVsWQbHjF0jl0IIknayWfclVPQudUBWGiboaLWlON0zVbAgUHop
	 MWRUh032xOzIEzJU+TW8JtHWYWXDTOVr0xOtVMFvmThYfcUYNnFEmfor7U32Lz7lFw
	 jfOr5Ijosy4wEU61SSg2BqModTadVKhVnRcbVb4Z/KtzgQW7vW0Prj1tOFCNHX9MI3
	 o18fLa0mbLXWkCxJcovM1Krkv2lyLbb/6TtqqJKsy8j+sU2tGSpEoZoGZhTTLZDmPd
	 F7+Ig2nPhpdWzYC/8iVwhi/wTOwVpqsZ/22xd+T3bL/F3f2v+rLW+Mxjj/njv5oYdp
	 KH7i5S3LpbEng==
Date: Wed, 16 Sep 2026 04:54:39 +0000
To: stable@vger.kernel.org
From: David Ballesteros <linux@davidbq.me>
Cc: kuniyu@google.com
Subject: [stable backport request] af_unix: Unlink scc_entry in unix_del_edge()
Message-ID: <20260916045435.168613-1-linux@davidbq.me>
Feedback-ID: 221125243:user:proton
X-Pm-Message-ID: f5093493c60f2d574ae94e4c290576aae5d0f901
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Please consider backporting the following mainline commit to the 6.1.y,
6.6.y, 6.12.y and 6.18.y stable trees:

  594d905195024b228c962627ae5ae7c17bd582a4
  ("af_unix: Unlink scc_entry in unix_del_edge().")
  Fixes: 4090fa373f0e763c43610853d2774b5979915959
         ("af_unix: Replace garbage collection algorithm.", in v6.10)

It fixes CVE-2026-80521, a slab use-after-free in the AF_UNIX garbage
collector: unix_del_edge() moves a vertex to the to-be-freed list without
unlinking vertex->scc_entry, so after the kfree the persistent SCC circle
still points at freed memory, and the next GC round writes to it. The bug
is reachable by an unprivileged user via SCM_RIGHTS fd passing and close().

The fix is a one-liner and applies cleanly; the target block in
unix_del_edge() is identical across all four affected series:

  =09if (!vertex->out_degree) {
  =09=09edge->predecessor->vertex =3D NULL;
  =09=09list_move_tail(&vertex->entry, &fpl->vertices);
  +=09=09list_del(&vertex->scc_entry);
  =09}

Why these trees: the fix is already in mainline, 7.1.y (>=3D 7.1.10) and
7.2.y (7.2.6), but is missing from the currently-supported LTS lines.
Checked today against the stable tags (net/unix/garbage.c):

  fix PRESENT : v7.2.6, v7.1.13
  fix MISSING : v6.18.52, v6.12.110, v6.6.157, v6.1.188  (all vulnerable)
  unaffected  : v5.15.221, v5.10.270 (older GC, no SCC rework)

The introducing commit landed in mainline v6.10, but the SCC garbage
collector was also backported into two older LTS lines, so the affected
supported LTS range is wider than the CVE record's "6.10" suggests:

  6.1.y  : vulnerable from v6.1.145  (v6.1.140 still had the old GC)
  6.6.y  : vulnerable from v6.6.94   (v6.6.92 still had the old GC)
  6.12.y : vulnerable from v6.12     (native, >=3D 6.10)
  6.18.y : vulnerable from v6.18     (native, >=3D 6.10)

6.1.y in particular ships in widely deployed distributions.

Verification: I reproduced the UAF on a freshly built v6.18.52 with KASAN
(tarball GPG-verified, live build-id attributed):

  BUG: KASAN: slab-use-after-free in __unix_gc
  Write of size 8 ... by task kworker/u8:0   (events_unbound __unix_gc)
  Allocated by: unix_prepare_fpl <- unix_scm_to_skb <- unix_dgram_sendmsg
  Freed by:     kfree <- unix_destroy_fpl <- unix_destruct_scm <- __unix_gc
  kmalloc-96, 40 bytes in (=3D=3D vertex->scc_entry)

Found during an audit that noticed the deployed 6.18.y LTS carried the
vulnerable code without the fix. Reproducer available on request.

Thanks,
David

