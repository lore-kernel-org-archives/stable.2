Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DC537B41E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040741; cv=none; b=LkLP1oP4uPPlDXbILYlOY+j9I4aCnxYcUGO+ro4nPyhGvxsdzAvnAEJ1X0oZhihtC/04VGC8aqjWZ5IUqFRzPJGXUwdUGW/Pgk5ASnwFPGCvY2hBeTh4i4Pm3fA+VcB3kbRXEctbVsdj+GiFWq6lSBd6HRRgAtKB2/3ZoOnalCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040741; c=relaxed/simple;
	bh=cekmeSPsNaK74DRAj/vTJGqJu/UBoV9oKh/e7XJVmu8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Cq+m4QbqdkWn/DYlEK94J/qd+0dUHUS4oPDVJYbGHLsWS6I4KcJ6+n89HfknC76Owc8+ASLESPPu+Mcy3xGCmDkB6WvZUma4YdMeXITESP7VUAIR289F7WEeQC3JpodKrKKW32edOsh2WAdjU+udM3RZY9wzUuDbJPuSQRlpBqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uyOUgueS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uyOUgueS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6651F000E9;
	Tue, 14 Jul 2026 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040740;
	bh=Glpjhtt3PtrqG4Wi4+I+sE9qkAGoeWukzRpqciKCRpk=;
	h=Subject:To:Cc:From:Date;
	b=uyOUgueSk4hGBzpo++sVUX0NGSO2rT4ZRBIgsXc1+G/h0GtYcelRcTokM8MT+4MOX
	 sDJrphxMkOS9R9vAn2CZx10lSTWffoXgMOL6EMsqZX6DBl3itAby0PauTy4W75w6+p
	 dHk1R5Fx262D6vxXgH6QC42oCD6VtHPVsQ+7aQlk=
Subject: FAILED: patch "[PATCH] tools/mm/slabinfo: Fix trace disable logic inversion" failed to apply to 6.1-stable tree
To: wangxuewen@kylinos.cn,18810879172@163.com,sj@kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:52:13 +0200
Message-ID: <2026071413-headway-boaster-b891@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 235ab68d67eadbef1fdbfb771f21f5bacc77a2ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071413-headway-boaster-b891@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 235ab68d67eadbef1fdbfb771f21f5bacc77a2ae Mon Sep 17 00:00:00 2001
From: Xuewen Wang <wangxuewen@kylinos.cn>
Date: Mon, 18 May 2026 14:21:57 +0800
Subject: [PATCH] tools/mm/slabinfo: Fix trace disable logic inversion

The disable trace path in slab_debug() had a logic error where it would
set trace=1 instead of trace=0. This made trace functionality permanently
enabled once turned on for any slab cache.

Fixes: a87615b8f9e2 ("SLUB: slabinfo upgrade")
Cc: stable@vger.kernel.org
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>
WARNING: From:/Signed-off-by: email address mismatch: 'From: wangxuewen <18810879172@163.com>' != 'Signed-off-by: wangxuewen <wangxuewen@kylinos.cn>'
Link: https://patch.msgid.link/20260518062159.80664-2-wangxuewen@kylinos.cn
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

diff --git a/tools/mm/slabinfo.c b/tools/mm/slabinfo.c
index 54c7265ab52d..39f7eae7eecd 100644
--- a/tools/mm/slabinfo.c
+++ b/tools/mm/slabinfo.c
@@ -798,7 +798,7 @@ static void slab_debug(struct slabinfo *s)
 			fprintf(stderr, "%s can only enable trace for one slab at a time\n", s->name);
 	}
 	if (!tracing && s->trace)
-		set_obj(s, "trace", 1);
+		set_obj(s, "trace", 0);
 }
 
 static void totals(void)

