Received: from sender-of-o53.zoho.eu (sender-of-o53.zoho.eu [136.143.169.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E3D279DAF;
	Sat, 22 Aug 2026 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787387513; cv=pass; b=kVLBhNquBR5nNZ6TdSTlxtMezDRQH1ybyAcbauL67rf85FpSq6uNOy9zKuosz/gyQJilB1svhqQOnNnwt/6AT/LKvu9LwkG+KOmHdNseSQK6ade/Dx2tLl4G5YrvYUyQHJX2OG9vxNxeVl0gvTsk9XVzUelYEW+0Ma1zT2wrRUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787387513; c=relaxed/simple;
	bh=+URLRRbTvglnik5XstVBoxLTWTh5sgAxIH220vX0QNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuNZiFQINXozD+ne+MdgiKKQrhSX7MtaKbEoVqpqGi/tQV8iAztvU3Tusj9s5pTre2raU9WONrkkosgMl9h1/5U+qpY7nZjJeLukVZ72x20mv3U2EyzpOfPjKzyTYbD7WBwML8MQ69QoQsVYUJfbEv7wT+ZhG+2MXnxHLgTDx9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=lYqx2e9s; arc=pass smtp.client-ip=136.143.169.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="lYqx2e9s"
ARC-Seal: i=1; a=rsa-sha256; t=1787387467; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HZibCUwR9nVmyyg8mukUyLVKdl9KUanz584a/I5LsSD+6ntKV64hvJM3/weqzNodkQCz1oCTSSHTceLYDaMf8MrX33HjsBSm+HepKTzKauUyqbE+uygJIValgDvJvJB/t0aNEilY7jWr483wjlAYCxR0TfviqYXDkj77rE0lVyU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1787387467; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=j/5LSlBQIZ/fYtizrOhoNwjGhKeQ4H0Myq1aPjDQBwI=; 
	b=RlItVvHxbQzNYCM8xzcCiW7ftqU3YtGjcyY83EWcUJZl/qsHsQfcoBvlmEdBSTuFo8iQ46o+wCpqOcF0GhnhsDfvgnF37gGNup4vIZpktNIwKWvMfwq8Z5lqiWDR5Ka6J1+Fk4e7nv5QyyQOt6tQnLoXIDaBGlpaWOTLAX79c9M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787387467;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=j/5LSlBQIZ/fYtizrOhoNwjGhKeQ4H0Myq1aPjDQBwI=;
	b=lYqx2e9suhvoN/Wm4hbGXo826US0r4Uc6adgmYKrm7BAmeBZb2rwrWtIh5r3hQaf
	OmvYuxwIZIpZjh4zLuaxE/SC8obpZk2gMfPipcbjFuY93YtzP70AQmQ28TukCVH/N4c
	fIyJXz8jz2muMb2ip0rX/dACC+yTIA5QavgwO++c=
Received: by mx.zoho.eu with SMTPS id 1787387465917218.96530455391746;
	Sat, 22 Aug 2026 10:31:05 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jiale Yao <yaojiale02@163.com>,
	SeungJu Cheon <suunj1331@gmail.com>,
	Tim Bird <tim.bird@sony.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize session teardown
Date: Sat, 22 Aug 2026 08:30:49 +0000
Message-ID: <20260822083054.913656-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAAo+4rUJomK9jJ6nHC6LU0AHiR0LhO_Wwp4-Z8iJOo=Za1JR2g@mail.gmail.com>
References: <20260821174514.3034851-1-nicoyip.dev@gmail.com> <CAAo+4rUJomK9jJ6nHC6LU0AHiR0LhO_Wwp4-Z8iJOo=Za1JR2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

I reproduced the splat here with the same recipe, forced unload plus the
two mdelay()s:

  BUG: KASAN: slab-use-after-free in rfcomm_run+0x3dda/0x3f20 [rfcomm]
  Read of size 8 at addr ffff8880037b3140 by task krfcommd/75
  Tainted: [R]=FORCED_RMMOD

faddr2line agrees with your report:

  rfcomm_session_del at net/bluetooth/rfcomm/core.c:713
  (inlined by) rfcomm_kill_listener at core.c:2167
  (inlined by) rfcomm_run at core.c:2190

With your patch applied and the same delays in place, five runs stayed
quiet. I also could not reproduce the other crash I mentioned. With a
delay in rfcomm_session_create(), forced unload would kill the box while
it was executing freed module text. Eight runs with the patch were clean.
So the change does fix the reported race.

The main thing left is the changelog. As written, it sounds like a plain
connect() can race with krfcommd. I don't think that's possible. Without
CAP_SYS_MODULE and delete_module(O_TRUNC), the module cannot be unloaded
while the socket is open. That means rfcomm_kill_listener() cannot run at
the same time as rfcomm_dlc_open(). The trigger here is a forced unload
and the delays need to be mentioned.

I'd also drop Cc: stable and the Fixes: tag. Forced unload requires root,
taints the kernel and is documented as unsafe: MODULE_FORCE_UNLOAD removes
the module "even if the kernel believes it is unsafe". This isn't
something that affects normal users, and Fixes: 1da177e4c3f4 invites
backports into every stable tree.

For consistency I think the change still makes sense. Every other
session_list traversal takes rfcomm_mutex, apart from
rfcomm_security_cfm(), which I mention below, and this one should too.

With a changelog along those lines and without the stable tag:

Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
Tested-by: Ali Ahmet Memis <ali@iusegentoo.com>

I'm not a Bluetooth maintainer and I don't have merge access.
get_maintainer.pl lists me here because of a recent commit to this file,
so this is only a review and test report from me. Whether the change
should be merged is up to the Bluetooth maintainers.

Pauli raised the same two spots while I was writing this. On rfcomm_run()
-> rfcomm_session_add(), I don't think it is reachable. kthread_run() runs
from rfcomm_init() before rfcomm_init_ttys() and rfcomm_init_sockets(), so
there is no socket or rfcomm dev yet and nothing else can touch
session_list.

rfcomm_security_cfm() -> rfcomm_session_get() is the one I'd worry about.
It runs from the hci_cb callback with only hci_cb_list_lock held, while
krfcommd can free the same session under rfcomm_mutex. I haven't tried to
reproduce that one.

I also agree with Pauli that taking the lock is better than relying on the
invariant. My objection is only to the stable tag.

One unrelated nit: the ### headings and fenced text blocks are a bit
unusual for LKML, but I don't see any problem with keeping them.
