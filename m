Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD61830677D
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881163; cv=none; b=citwUYKulAEb5DI2DM3KWyPcY0URLNRzZJWeAFI9di+6LsqtYtIRF2OpAkJzqSNV+WhD7nW6VFl7yYRXbWWZgAGU6EzcL4lQIgci7fmAl3rieFe4QIf+m6nzugpivM8V5k6bdkMJTdnhJPVYzg++Qx6F5X6ydXowxafqL94nxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881163; c=relaxed/simple;
	bh=C4DPjZRWPUMXX3xECIA8+kcIUFCzquihhDLXlumQIS8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BtPLxLC4ZJrTEsyb/0vb4sdvnj+wZu8HsgYjp0pRbaPPNxB58otADVrpfJFF0x3XZ3PxWVxzXR5r9ehEF9a2NkFxdqidImC859FjJ85K/CDfvb18xdLehTYOMMHdNGFr4M72EMc1BHqqjm+LKjQaSE0ZkaNFKCC/29fUhZDNVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=nsJMKOx8; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b="nsJMKOx8"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ghgjF1fBqzBKX;
	Fri, 19 Jun 2026 16:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1781881152;
	bh=q4pLR8MGAZ8d9SmRRP76vD76u+1xaZltcCBwaFGE/2w=;
	h=From:Subject:Date:To:Cc:From;
	b=nsJMKOx8Z1w0QYVP6wjFyw3dKLPGb+kiHzpY7AZYcvYAwA+TYDlgps+Gp7bcQo1YA
	 lVjx9EG6iSQ/YxpbP9CIIgTjFqtjxmMy3vvxRyfdTcaOi+cEBIRO/kVvLsx/IXGI0i
	 KtbJaqSK6LeAvMkNYqbgehukIMNucZM6SnmU+ub0/Lm8dzVMMS8djZWZPgdiP18ffZ
	 2qcKgUeXTkD3DcS8KIgpvGOc53Uq2bbysjbDyGD0EvdqrxWSekww3u19zilE6akhGS
	 4dgLj+HMb5DkREkA103scsi9cLKU7jT2iSpTT142Sg12qfjmhG9Chld0wmRRJC90sj
	 DC1dkFoPF9Pww==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ghgjB391lzsBb;
	Fri, 19 Jun 2026 16:59:10 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH 6.12.y 0/7] eventpoll: backport
 a6dc643c69311677c574a0f17a3f4d66a5f3744b
Date: Fri, 19 Jun 2026 16:58:40 +0200
Message-Id: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CQAwAv0J6toQWqNGvGA9Qu1gPaHaVaAh/Z
 8HjTDIzQ7LoluBczBBt8uTPMQMdCtB7Nw6GfssMXLFUQicUJEadDDeDjXDD2NdqIeixrTuCXL6
 iBf/u1wtISVz+4Pr36dM/TN/bEpZlBbeyVXV/AAAA
X-Change-ID: 20260619-6-12-cve-2026-46242-b3ceffc753a1
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Soheil Hassas Yeganeh <soheil@google.com>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jaeyoung Chung <jjy600901@snu.ac.kr>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha

Backport a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll /
struct file UAF") to 6.12.y. So the patch applies cleanly, commit
86e87059e6d1 ("eventpoll: move epi_fget() up"), commit 0bade234723e
("eventpoll: rename ep_remove_safe() back to ep_remove()"), commit
0feaf644f718 ("eventpoll: drop vestigial __ prefix from
ep_remove_{file,epi}()"), commit e9e5cd40d7c4 ("eventpoll: kill
__ep_remove()"), commit 0f7bdfd41300 ("eventpoll: split __ep_remove()")
and commit 3d9fd0abc94d ("eventpoll: use hlist_is_singular_node() in
__ep_remove()") are also backported.

Note that backport of commit 86e87059e6d1 ("eventpoll: move epi_fget()
up") conflicted due to missing commit 90ee6ed776c0 ("fs: port files to
file_ref") and its dependent commit 08ef26ea9ab3 ("fs: add file_ref").
The original commit is simply moving a function earlier in the file, so
we do the same even if the content of the function is actually slightly
different. I opted for this instead of backporting the other two commits
because they look a bit more involved than I would like to for stable.
They also do not apply cleanly so I drew the line before those two
"dependencies" and didn't add them to the list of backported patches in
this series.

Note that backport of 0bade234723e ("eventpoll: rename ep_remove_safe()
back to ep_remove()") is not necessary (e.g. 6.18.y doesn't have it), it
just makes git-range-diff even smaller so I thought it was nice to add
it. Maybe it'll make future backports easier too /me shrugs.

The changes between 3d9fd0abc94d^..a6dc643c6931 (commit log excluded)
and this series is (according to git-range-diff):

"""
      ## fs/eventpoll.c ##
     @@ fs/eventpoll.c: static void ep_free(struct eventpoll *ep)
    @@ fs/eventpoll.c: static void ep_free(struct eventpoll *ep)
     +  struct file *file;
     +
     +  file = epi->ffd.file;
    -+  if (!file_ref_get(&file->f_ref))
    ++  if (!atomic_long_inc_not_zero(&file->f_count))
     +          file = NULL;
     +  return file;
     +}
    @@ fs/eventpoll.c: static __poll_t __ep_eventpoll_poll(struct file *file, poll_tabl
     -  struct file *file;
     -
     -  file = epi->ffd.file;
    --  if (!file_ref_get(&file->f_ref))
    +-  if (!atomic_long_inc_not_zero(&file->f_count))
     -          file = NULL;
     -  return file;
     -}
"""

in patch 6.

Note that this series cleanly applies to v6.6.y as well but fails to
build with the following error:

/home/qschulz/work/upstream/linux/fs/eventpoll.c: In function ‘ep_remove’:
/home/qschulz/work/upstream/linux/fs/eventpoll.c:804:16: error: cleanup argument not a function
  804 |         struct file *file __free(fput) = NULL;
      |                ^~~~
make[4]: *** [/home/qschulz/work/upstream/linux/scripts/Makefile.build:243: fs/eventpoll.o] Error 1
make[4]: *** Waiting for unfinished jobs....

hence why I made this series 6.12.y-specific.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Christian Brauner (7):
      eventpoll: use hlist_is_singular_node() in __ep_remove()
      eventpoll: split __ep_remove()
      eventpoll: kill __ep_remove()
      eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
      eventpoll: rename ep_remove_safe() back to ep_remove()
      eventpoll: move epi_fget() up
      eventpoll: fix ep_remove struct eventpoll / struct file UAF

 fs/eventpoll.c | 142 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 79 insertions(+), 63 deletions(-)
---
base-commit: 0b8f247169e487eff2d4c2dd531bc43f7efda2cb
change-id: 20260619-6-12-cve-2026-46242-b3ceffc753a1

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

