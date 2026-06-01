Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D27821257E;
	Mon,  1 Jun 2026 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283431; cv=none; b=hNNpQIbx1BNI74ooJkOLXRkH4h4wnrWJ8pIJtcBpkpBpLta5i3KTJQkQxJCuGemyfD+dgFmj6Ff3RwfJO5gbt7p6ygv9DpakHBinWO3dTMBeu8pop8hO7YyjqKUUHJ3lkY3HWVycTgxek9M5ZNTqcujL13IDkERFFJTjAIhOi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283431; c=relaxed/simple;
	bh=ne+DJHD93LLyymoAeSSDLgFRQhj1Q3IEaR9V1l8aPNA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BDPCWdYbiMv+9wrsY8Olo8vj7OV0T0yqbK2pSN839eLFxlxMsrm4PeliC64QC22FnM1xOHiqQWb3D60GWbtMNPBedUqAYNC4cjyW3u4jjSdO9on1VuDrrs49/RNER+9gWpeT8gsZqGn8uNDG8Wcj5MQTENjDChQNj6hoWCfwsGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQhM+l1k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQhM+l1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839C21F00893;
	Mon,  1 Jun 2026 03:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780283430;
	bh=qOInkgrH4hk12Hs+AqpAJkTYyJwCGH22KfY2gfjsZ0w=;
	h=From:Subject:Date:To:Cc;
	b=XQhM+l1kZD0iM581UzqiOx2CvebDkvV9bc2TuP6IsgXpYpDrg0u2IAo3hvHeoak1H
	 +rIwYhhtlKEOnWeS4n1wQ07MmeyuTSVPNSjxwVBn0JtGOTfUSNvUNMmWVDadB08Ww2
	 m5zMifo1ZtXrtsvpIvkhBMoraFEvBny+NmkWriY1Yz3w+DsoSacqg8CM9PfKoRq6zp
	 67ZageuR7Mozq5Rkaf1LselAgMm2cYBMT9j27TyVKHvCgcxavH7MbuXZW4HIeqiRM7
	 v/v1CKR/FDDNRIomFt0SXkoU5Toi9sjzhavzoBCvO9zwjTodrsb6qODV1xeg/j6RFq
	 nheZJDSf9KKUg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 00/10] mptcp: misc fixes for v7.1-rc7
Date: Mon, 01 Jun 2026 13:09:56 +1000
Message-Id: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMAxFf4X02SZsTEB/hfggpWpNmMs6CQnh3
 636eG7uORsoZ2GFc7VB5kVUXtHAHSqgxzXeGWUyBl/7tj42DiMXnFOhhLMo4U1WVuzQYaYOm9D
 3gU6jD+0ElkiZfwcrDGAmXP6jvscnU/mGYd8/HaOACYUAAAA=
X-Change-ID: 20260531-net-mptcp-misc-fixes-7-1-rc7-34884c9b246d
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Tao Cui <cuitao@kylinos.cn>, Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Hannes Reinecke <hare@kernel.org>, linux-rt-devel@lists.linux.dev, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2224; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ne+DJHD93LLyymoAeSSDLgFRQhj1Q3IEaR9V1l8aPNA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHPgetCAlRRs5NJvuXuaCLQNMSOUzpOYc+yyIK
 YyOEqVBbcGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahz4HgAKCRD2t4JPQmmg
 c96RD/46EzUoWxTwKhuU47LoUgTR+tUa4qxJc+WagSu32vb2ISXt1yibna8sVpSu3kJjF3/abxH
 XALPE8bZK3zhDRvvV8WsFYTZqeDAa8SlVQZRx1Why93vtFkUdXqu0QVt24Pg7DHasksNQ40isl7
 fDo1HtzKoKhci0c6+5buJY9rDcTXz1K/xnKUzF5XvlgtivLfP1RT07jCCX8WU0D9tXqtYyCBiFN
 w0irMcLVjd489SEVig0/aUR8aSipWa7r16UK0DkXnqKJ/q/0BWVql8Cj9lMYyXRUDlEVTlPXIY0
 U5qcW//ZiunkUylea4EmPyq+2XKfjr0KjtHHErIx/Geihe6kAQYXvqiG2GYjJ8xBmXkBvgHEJKV
 w2jnnXL6FfmQsEFFtrm8XauYLgXHWiq1b6ilM8T9eq6Dhtxgqprw/m4UdAPuy3CWugbSF6RK7TT
 d49d26ikFLnH4JikxhC4pxGsPfq30Lx4c9UgSpOtqQuh00DHHdHwV2xC/X6BFDvnkbXyAxptPQ4
 p8hVMuljjAJpBfUPjMkHoabbKwskqoAkoL/34gVrJdRr3xbQ2eK7C30/82BCQGzMtPoq4ZkRvez
 olfPKUvPAbAhi/thfnf7h3UuZ0r89v3Gtp4ZPvNpY9JUXJE0i1KXNyf3wItko4ZWCVOzNmkPusk
 wh1JOfZ4chCXvTQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various unrelated fixes:

- Patch 1: fix missing wakeups when multiple threads are reading from
  the same fd. A fix for v5.7.

- Patch 2: fix retransmission loop when MPTCP checksum is enabled. A fix
  for v5.14.

- Patch 3: fix a TOCTOU race while computing rcv_wnd. A fix for v5.11.

- Patch 4: allow subflows receive window to shrink if needed. A fix for
  v5.19.

- Patches 5-6: avoid 'extra_subflows' to underflow with the userspace
  PM. A fix for v5.19.

- Patch 7: report errors if one subflow cannot set SO_TIMESTAMPING. A
  fix for v5.14.

- Patch 8: try to set TCP_MAXSEG on all subflows, before reporting
  errors, if any. A fix for v6.17.

- Patch 9: avoid a lockdep splat when PREEMPT_RT is used. A fix for
  v5.10.

- Patch 10: check desc->count in read_sock, to act as expected. A fix
  for v7.0.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Gang Yan (1):
      mptcp: check desc->count in read_sock

Matthieu Baerts (NGI0) (3):
      mptcp: sockopt: check timestamping ret value
      mptcp: sockopt: set sockopt on all subflows
      mptcp: pm: avoid sleeping while holding rcu_read_lock

Paolo Abeni (4):
      mptcp: fix missing wakeups in edge scenarios
      mptcp: fix retransmission loop when csum is enabled
      mptcp: close TOCTOU race while computing rcv_wnd
      mptcp: allow subflow rcv wnd to shrink

Tao Cui (2):
      mptcp: pm: fix extra_subflows underflow on userspace PM subflow creation
      selftests: mptcp: add test for extra_subflows underflow on userspace PM

 net/mptcp/options.c                             | 43 ++++++++++++++-----------
 net/mptcp/pm.c                                  | 18 +++++------
 net/mptcp/pm_userspace.c                        | 14 ++++----
 net/mptcp/protocol.c                            | 10 ++++++
 net/mptcp/sockopt.c                             | 15 ++++++---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 +++
 6 files changed, 66 insertions(+), 38 deletions(-)
---
base-commit: 78ef59e7a6459b16f8102e0ee1c718443323d1af
change-id: 20260531-net-mptcp-misc-fixes-7-1-rc7-34884c9b246d

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

