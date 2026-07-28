Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8EF2EF67A
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206780; cv=none; b=WAznHDQw7p1ppxGIqCKb26q5nz3FuxvOHkMamyr3De5qFORZASWt7dfZko/F4am2iT/gqWnNeAZJKHAaPr24kVh3vDlH8mUNZkmzQNjxxZe0x9URgTr6yLKwNvmA4tWMY3FP6h/KuAGD1jZHmmB/X8mDrqQlEfDkTbUxkngdpxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206780; c=relaxed/simple;
	bh=HG7ruP1U6GraA7p1atst30hEVjUCXq6mh9W3a3rLal0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub8W7Oem3FQMq46ubR2cPEWAq2gttc4FvXNYPkvc68ZEDz2gsVUH6+1Qvy/W2MTE2MXm8tyL8eUbSAbuEUkTL3TDQ8AnRwY8hhebqeaAk6Ur+RY8ZMjaLza72/KwLdw86d81/Wboyi6yiKQaorl/gxOnJAobMG8oiQJUJD62DwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLO+bExp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLO+bExp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C04F1F00A3A;
	Tue, 28 Jul 2026 02:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785206779;
	bh=2T1/dDRUz5fx9oKG0yXke4gE/q8T7l8tTW+Q4CG0Z5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YLO+bExpuT1yE5iFfKdH6RjgWgx8x1pxXvRTJf1QtwEoHtT5kBiJwT3gULRnaoveb
	 18OV6K9Q/4yHuAApXK9pZ/uLRRk+NAgPMkmuCGro5TKEOAQwpC6kIpYWIQz664OgTa
	 igrGpYk1xaERVvB7MoQHbPXkp94b9S9aaAI5oQEvvqixjKPrhLrsksFVq8xJS88uPM
	 DvcRH7X4Il0YdDywXr7yycbM8/3a7VDjQ8c/fAIf2mbfYZF/GH1C8f5Bn8IjN5NEk8
	 mEudpJuRrRPN/Mvgj1u98qR3S4cUeloVBcozKAiZ7nBUCS47e+gMF2hJR5XHWdnRTK
	 Re34bLe9ZZcsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
Date: Mon, 27 Jul 2026 22:46:16 -0400
Message-ID: <20260728024616.3054017-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072010-postnasal-lisp-2633@gregkh>
References: <2026072010-postnasal-lisp-2633@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maoyi Xie <maoyixie.tju@gmail.com>

[ Upstream commit aa6dcd5c8dd9ba1d7d0f60093bcda41c0d6d438d ]

lbtf_free_adapter() calls timer_delete(&priv->command_timer), which does
not wait for a running command_timer_fn() callback. lbtf_free_adapter()
runs on the teardown path right before ieee80211_free_hw() frees priv,
both in lbtf_remove_card() and in the probe error path. command_timer is
armed by mod_timer() in lbtf_cmd() whenever a firmware command is sent.
command_timer_fn() dereferences priv. If a command times out as the
device is removed, command_timer_fn() runs concurrently with teardown and
dereferences priv after it has been freed.

This is the same use-after-free that commit 03cc8f90d053 ("wifi: libertas:
fix use-after-free in lbs_free_adapter()") fixed in the sibling libertas
driver. The libertas_tf variant has the identical pattern and was left
unchanged. Use timer_delete_sync() so any in-flight callback completes
before priv is freed.

Fixes: 06b16ae53192 ("libertas_tf: main.c, data paths and mac80211 handlers")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Link: https://patch.msgid.link/178211481807.2212567.8773346114561900100@maoyixie.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/libertas_tf/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index 74c4942b9a5a00..651eb3131b83a8 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -174,7 +174,7 @@ static void lbtf_free_adapter(struct lbtf_private *priv)
 {
 	lbtf_deb_enter(LBTF_DEB_MAIN);
 	lbtf_free_cmd_buffer(priv);
-	del_timer(&priv->command_timer);
+	timer_delete_sync(&priv->command_timer);
 	lbtf_deb_leave(LBTF_DEB_MAIN);
 }
 
-- 
2.53.0

