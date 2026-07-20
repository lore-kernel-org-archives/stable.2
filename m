Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FCF42DA2D
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560077; cv=none; b=TSFj81i+tsosvk2cfWt2rhoht6/eBSpu/3WhUqLgnLHFUfR7N5N+xeohricPdFTh+9auXdKHZBLrAt6lpdR0oD/zVBXamdurM85d/IMSKZIerSdMSqqrYxvIg8HzmB0wpGlFkXwUbCmOgVrF2fyLMSjpYKFGqQWJQ7OQxlV3WtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560077; c=relaxed/simple;
	bh=phrSv+0KEs+WkcrRsASVNK9mSBmlYiJTB6ldzFSYO6E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HSTgv9LnUrq15JwdNW8yQHeYC2Rudhw+/EpKuC+a/6SQYPWSAfwkLjUjiXxqzxq8STXj2HJ/h8tcms/KCDrrNB/N0XFYx8n+BJ3IVlInp+Wtgu2EEoiVXKUh57avMiTNTQr926WvC3fuCNIwmTfC2wW+vs49AZ8C421rcoL8Tk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TqN2eHYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TqN2eHYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4304C1F000E9;
	Mon, 20 Jul 2026 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560075;
	bh=Xpj0YM0w70Kc5S/lUAzT41BN40HDOFNwsUBGtYrzYtQ=;
	h=Subject:To:Cc:From:Date;
	b=TqN2eHYVWzjMEOqaiVqt+XkkMyABQHSmyl7mdDY+KXav5IOiRMVv6e5YyTwDFiqsk
	 9ZbbWU+DuzaUsUD3alarSRjcZsBQIjSjRGfT38f8mAdXns8cdXNg9eu+psFFxfIVQl
	 AgQnXqpZwNnnURrzN5Koo30b3XXIz/vKqonSoBY4=
Subject: FAILED: patch "[PATCH] tcp: Decrement tcp_md5_needed static branch" failed to apply to 6.12-stable tree
To: 0x7f454c46@gmail.com,kuba@kernel.org,q.h.hack.winter@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:07:46 +0200
Message-ID: <2026072046-unworn-conductor-0b8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6f6e860e370c9e4e919b92118a25e9e1f82e9180
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072046-unworn-conductor-0b8e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6f6e860e370c9e4e919b92118a25e9e1f82e9180 Mon Sep 17 00:00:00 2001
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 25 Jun 2026 19:21:41 +0100
Subject: [PATCH] tcp: Decrement tcp_md5_needed static branch

In case of early freeing an unwanted TCP-MD5 key on TCP-AO connect(),
md5sig_info is freed right away (and set to NULL). Later, at
the moment of socket destruction, the static branch counter
is not getting decremented.

Add a missing decrement for TCP-MD5 static branch.

Reported-by: Qihang <q.h.hack.winter@gmail.com>
Fixes: 0aadc73995d0 ("net/tcp: Prevent TCP-MD5 with TCP-AO being set")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
Link: https://patch.msgid.link/20260625-tcp-md5-connect-v3-3-1fd313d6c1e0@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bc03809ca3af..d7c1444b5e30 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4334,8 +4334,8 @@ int tcp_connect(struct sock *sk)
 			tcp_clear_md5_list(sk);
 			md5sig = rcu_replace_pointer(tp->md5sig_info, NULL,
 						     lockdep_sock_is_held(sk));
-			if (md5sig)
-				kfree_rcu(md5sig, rcu);
+			kfree_rcu(md5sig, rcu);
+			static_branch_slow_dec_deferred(&tcp_md5_needed);
 		}
 	}
 #endif

