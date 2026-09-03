Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C04446E3
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424527; cv=none; b=W6uLx11v/xhhKvZzJj1XYGSEe834Po8mIfgL+F7i2xTRTF0AJ4YotMknZMXivxnWxemy9cTJdqx8qAjoDzgOZEaeQek2/duRMQWh/2kBOfsJ6/0EhRAVWh9s2E2T1iYsORG+6BUBixapJqnvOU5rgsbdPp7TScvH0sZJ0LhzunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424527; c=relaxed/simple;
	bh=/MjYt2ta9mFvbu69n1CKfGpTEP3/Cm6uJX62W/imdDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=plCKV3Fja2Aj1BzxW9oogA+ptuwCTpORI0geX3dHkwT6RvgIMSrgnKn4gCp/I31t010WiXC0Tg/kc9nSkqr0UJRvko3X9scrCTRgBsJEWn+UlQT1tm905A7OCTSEmOogZMtA7nJlrlWaHDcx+WC3RjckSyuwsOq7mVx7d5D9bnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mISsdnk1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mISsdnk1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49cd9add88aso13042315e9.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788424522; x=1789029322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=66m0kEzVw0wUaLA90qEFlh+4kl2dF1iPNWHMpLLgPYk=;
        b=mISsdnk1YY0+ldzoPogWGOc6F4mxcxV64grlq/F0zjzxKJTbPbX88Up4uF2BK09NYY
         P1E12TKBvM7BjsEPlo8cvfnnLsYbjmp/tmZaq00SujVJvmS51ZzdA95hH7qkmImA2nvc
         updZxhje0S5zBgx3aXD1jJJ+zRmzQYdb2Bf7veyevz51UOSC2pwp4/yPyDeUQxbeiE3y
         OJiBgRk3F6fw4XuMIICM4DFX+Zl0E5t8ilfUck9UoZCoFQsA/24KLBDdJlK04zD6OmYg
         DMJB52nS4ILaBfRqny/o/mQ6afFhTd3ThCrFY8NkylSglmR65/qZkxalDaWkjmPnJ/I5
         SOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788424522; x=1789029322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=66m0kEzVw0wUaLA90qEFlh+4kl2dF1iPNWHMpLLgPYk=;
        b=XFv9Z/sD2Ok03EfScxJjtDX308EUJpr14/EsteOWzONXngxeD3idr/xixCkG+o3vja
         SsW8IdlaSxZciSg4MeqRxScMPj2cvOTP0n1OnvOu2i9iVM75fLt62flAJTnAkKZ5QFSJ
         FVPfjk5U80AMTmySAa0a0KmD3lHr3TFxubcllcokAr/B85FfwbCYkKxWOtrPSbsb/aly
         rxcI+130lvJuSU8lEbuTRqePsOY4IT/OP8rdaLSNS2uPYmLBYb8z7Z8TOIJ4UwUnNEEh
         XKDTjLss20DAw6QSs0DN8KPj6iVBpZgfx0NGwWgfSV+inz6V+m0cmUwIEgztVZ7EHMV9
         e1ag==
X-Gm-Message-State: AFuF++mdurYgPbSXG7L1BFjQNnKvCACOwqRF7y1rwmphWqypClGYfE8S
	/NPlslxfFRA5JoyxQIjgaypbBrG3HSY3p0t7pOfIvyp6M/DH+q+lw/E0+6P+CQ90
X-Gm-Gg: AYBFou1ezuHaBA5GV4rO6SshZK2S4HFdW4j1na/a11eDn6hTbUwtLsoJMl3/5DM5Yxz
	7u27gv4FjvZz34Q7fAqTV2Cg6tHs8vx19TaXpHHOQs7hZMKCSucfoz+72MVa49Dq+fveq2qCSBn
	zMPxzAIA1/28f5bJix/FXU8y3Z8iqIgTxiFJe3O7udBV+1zjKyJsjCWFlZLG0Ll2gHvZUeDMLoV
	T2+FLh4BZ8BO9AfCE3a//GhaTZuQ/BRGQ6mhxXRfND26hrx67T/1AVl1ZXBvE8bzZe26UtUi2sN
	/EqWl89WcvtK4uVVsvg/tOcHSCWYOWqa01U7YMIOvmjRW4cxF1nuqIUYIBm/naswK8DJVpVHsUe
	2frRUield3n7ENLBIrd9LxDm4nAstr9QtBziJZQjxldYJOZmD2uYfqJBVQDvU22Tg7kKyJaU4id
	2r51RvIWvu0nTcxHAVQtwLtPamljiZbmu6aUEZq1c65ZCB7FMxoZ5rQF1rNl1xZXIAYdnx/Zir/
	UtL0/zEOkIfJZtfRW6/pVO8+2Q/kXsCWLIgz51gQ4/q5DHs+Qyp7tl4cHhDZvCkYT5/UNxvFhEq
	eHVxY7Nh9RgIO3AjBnXyBvLiW4e9puTuiiMmpR6yx3frDnKwsM4WddvLEMlVea/TNOLyYxjpkYY
	z4C2Y
X-Received: by 2002:a7b:ca42:0:b0:49b:92df:87be with SMTP id 5b1f17b1804b1-49ce55fbdbemr129735745e9.4.1788424521705;
        Thu, 03 Sep 2026 01:35:21 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm228357425e9.0.2026.09.03.01.35.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 01:35:21 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y 1/2] mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
Date: Thu,  3 Sep 2026 10:35:11 +0200
Message-Id: <20260903083512.99864-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260903083512.99864-1-kmehltretter@gmail.com>
References: <20260903083512.99864-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

[ Upstream commit 9634cb35af17019baec21ca648516ce376fa10e6 ]

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to a new 'exit' label to call
__sock_put() (which will become sock_put() in the next commit) to fix
this potential leak.

While at it, drop the '!msk' check which cannot happen because it is
never reset, and explicitly mark the remaining one as "unlikely".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-4-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Karl Mehltretter: applied to pm_netlink.c; retained v5.10's ID 0 guard
  and routed it through the common refcount drop. ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 net/mptcp/pm_netlink.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d4d56f0af3e0a..aee3a8dd9287a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -217,14 +217,11 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto exit;
 
 	if (!entry->addr.id)
-		return;
+		goto exit;
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
@@ -253,6 +250,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 out:
 	bh_unlock_sock(sk);
+exit:
 	__sock_put(sk);
 }
 
-- 
2.53.0

