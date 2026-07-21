Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A883C5837
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625418; cv=none; b=e8qCJnRusuBqSI7tIOmQBFNKa22nNmOjetwxLcEh9LA++lYAt2kNTgWOlTpHlAxG+iKi/Wk816taEqPoShGU+YwR8GkgTmyyXiNaVyjPSxcxu+8upy4xg6u4Jf0VrfVTApa4dSzN5+2GkihagDtcyyT/YS9Zzm+xgsXTTd3KzQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625418; c=relaxed/simple;
	bh=4vjwub4yy0gB41/V4YbVsFI0jSKS7uErXdKEqkPGQxc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ciNwHqxvMEE6sWDBSD0yLAYoB9lsKvQysMAD30+7rbISS5iv/Jr00qAhckotpfaehp8Qy3o54ajLFNd/deQr+wX3XJUyjrPXRe8g2+MPp6HSYcyH/Oyh/NVk7YFaSuV5OOwk0FCJFPI1G3E5XTbSuwiTkeiwSV10Dyxbt1cuLcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KNVQc0Nm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KNVQc0Nm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7895E1F00A3A;
	Tue, 21 Jul 2026 09:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625417;
	bh=PF72qY/YQPtKlcTmTdDL5f6zHUyHJKa3iV0Q+DjS5H8=;
	h=Subject:To:Cc:From:Date;
	b=KNVQc0NmFaeOk8CwkWOTId51yYHd+vWiyYAG9juGy1cnpqWOVivhrUzQsQYXjW5ML
	 mFlhVv7GLDqiwd903QJtXQ/P8wkZwoL6+Mupej8g/WR8iTEL7045QI0MgQV3eV8OYo
	 kZ4rNSfAV7FTpwCqCpem88crec5F7Bbke7dE0NRE=
Subject: FAILED: patch "[PATCH] tracing/osnoise: Call synchronize_rcu() when unregistering" failed to apply to 6.1-stable tree
To: crwood@redhat.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:16:47 +0200
Message-ID: <2026072147-clang-iguana-51e4@gregkh>
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
git cherry-pick -x fe58f457ad8d0a2bef4e053cfecca4b5cd266b1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072147-clang-iguana-51e4@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fe58f457ad8d0a2bef4e053cfecca4b5cd266b1a Mon Sep 17 00:00:00 2001
From: Crystal Wood <crwood@redhat.com>
Date: Mon, 8 Jun 2026 23:54:30 -0500
Subject: [PATCH] tracing/osnoise: Call synchronize_rcu() when unregistering

This ensures that any RCU readers traversing the instance list
have finished, before releasing the reference on the tracer that
the instance points to.

Cc: stable@vger.kernel.org
Fixes: a6ed2aee54644 ("tracing: Switch to kvfree_rcu() API")
Link: https://patch.msgid.link/20260609045430.1589786-1-crwood@redhat.com
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 5e83c4f6f2b4..0e1265acd1cc 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -179,7 +179,9 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	if (!found)
 		return;
 
-	kvfree_rcu_mightsleep(inst);
+	/* Do a full sync to ensure that tr remains valid, not just inst */
+	synchronize_rcu();
+	kvfree(inst);
 }
 
 /*

