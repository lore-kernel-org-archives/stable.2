Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152B503905;
	Tue, 13 Oct 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901791; cv=none; b=TIV8N3DOLYim2iksce+rnLZM8l3kmzMregwIJG6wmPCMXZLhsp+3faQP2ISoe+UDdz6/zpoCu2CdKnjuGhCybw6hu5fjV+Y4B3xgHpbkgFYp2MkUOqa4kd0hmE4w53j6otO5PxrCjOyCIRqrOrCvkCL67bOQi7oLbFDTTYMG0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901791; c=relaxed/simple;
	bh=q49IPWhrFyVtf6UAvhEZ8EpHVL83S5prLii4ks+8GeU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A21FdWvrMa5R2KDBcs3ivcQf/7ced64Iep2T6mr+79V6a8uhJ3BEEXbDTzxSH3Xs6qjeJQfPnhHw861Lkp7lJVfUB3dhBQ6BgqrDAXcMcJC+XdUPta/22woMWw8jc0DZ3s7kFbwk3BXlueTpRuBpNPl6YmM0LcFaGv72tTqISow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3szDzi9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3szDzi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE441F00898;
	Tue, 13 Oct 2026 14:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901789;
	bh=5s7u5kQzv0gZLbHuIdyyncsESL4MBDIlymJWS97dG3w=;
	h=From:Subject:Date:To:Cc;
	b=h3szDzi94TPbQf4KQHB0WM1sO/H2H+RfMLxpwUfzVb09zeKF6OlT+ZvuSuzYja1C/
	 0031mXn59wSZV41LQdE3nMTK8UPfRzE+pr6SvhfGRU+rVfwUZp002bsUx/yqFIDOaR
	 7yi8K4RN7hUJ7amFM85uNqGFQGZ6DmTa9gQkm7QJ/m5wLcsjYnl9M3cnARRE56duhf
	 LAZYhZDKkNrRh343R05QwvTz2qPgHpiNfdevPS4bCkt8+1GBWPFmy1GT3VFbwdJtBv
	 eBCxDjkMUhbyVN0PfKnUh8wOe0AARBllpcpp9tyzfo1KoNR+OG0lv3X1orbnoBr516
	 0F4bEMZw7UMNA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/4] mptcp: misc fixes for v7.3-rc8
Date: Tue, 13 Oct 2026 16:29:18 +0200
Message-Id: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCQAxFr1KyNjATqbVeRbpoY9QIHYfJKELp3
 Rt1+T7/vQVMiorBqVmgyFtNn8kh7hrg+5hugnpxBgp0iCH0mKTinCtnnNUYr/oRww73WPiIbZz
 GLlIfiQJ4Ihf5HbxwBjdh+I/2mh7C9RuGdd0A5xOZBoUAAAA=
X-Change-ID: 20261009-net-mptcp-misc-fixes-7-3-rc8-51ba71291220
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Quanye Yang <quanyeyang@proton.me>, stable@vger.kernel.org, 
 Ruide Cao <caoruide123@gmail.com>, Kyle Zeng <kylebot@openai.com>, 
 David Lee <david.lee@trailofbits.com>, Vega <vega@nebusec.ai>, 
 Ren Wei <weir@nebusec.ai>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=q49IPWhrFyVtf6UAvhEZ8EpHVL83S5prLii4ks+8GeU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLOOYSlvfms190jPCdIJ2hp1LG1gQWmplVv8mod5zS1P
 Ny9o+5DRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETqGRn+2b/+7s0x4bJn06Sl
 7yTtu+KkUtoflSe23sri/nzz4Fzme4wMt0QYeVYr3xVgjH+sOjFmFRPbAW7LKf/fzrvWGSrRU2b
 LBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are some unrelated fixes:

- Patch 1: fully reset the msk state on early connect failure. A fix for
  v5.9.

- Patch 2: avoid using the subflow status bitfield for a field that is
  used under the msk context, not the subflow one like the other fields.
  A fix for v5.12.

- Patches 3-4: avoid issues with the TCP request migration feature, when
  used with MPTCP connections. A fix for v5.14.

Notes: patches 1-2 are follow-ups from previous minor issues reported by
Clashiko, and patches 3-4 have been posted to the netdev list before,
see this link for the changelog:

  https://lore.kernel.org/cover.1788800732.git.caoruide123@gmail.com

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (1):
      mptcp: fix subflow bitfield misuse

Quanye Yang (1):
      mptcp: reset msk state on early connect failure

Ruide Cao (2):
      mptcp: hold MP_JOIN msk ref when cloning reqsk
      mptcp: fix MP_CAPABLE token migration when cloning reqsk

 include/net/mptcp.h             |  9 ++++++
 net/ipv4/inet_connection_sock.c |  4 +++
 net/mptcp/protocol.c            | 40 ++++++++++++++++++++----
 net/mptcp/protocol.h            | 10 ++++--
 net/mptcp/subflow.c             | 41 +++++++++++++++++++++++--
 net/mptcp/token.c               | 68 ++++++++++++++++++++++++++++++++++++-----
 net/mptcp/token_test.c          |  4 +--
 7 files changed, 156 insertions(+), 20 deletions(-)
---
base-commit: 8bf659bd54e1f00e34cf5244b1d289c506fa47c0
change-id: 20261009-net-mptcp-misc-fixes-7-3-rc8-51ba71291220

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

