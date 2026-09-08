Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661854CF77;
	Tue,  8 Sep 2026 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876868; cv=none; b=lw8LlaZ8Tf/W1v8SV4P4ViT4QX3nb2dOf4yqIY9E4/TFTDjU0T2HtFEinzJJUbJd+h5jw2MUxNUhdgwx4p/DnMGJGeMKf6pMOfCJN2EQnrRPn8MqGBFjA1EKBTJjUIdbICupaNBcKHYNM+y2ugfrK4krJ1RD31r8nc3O+sg/6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876868; c=relaxed/simple;
	bh=1h+Lab5toORnoE2SALIUzpaq/tlwRchV+leKtaGmqOQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KBRwR7Yje6cVDNCOvs5vzVb9Ybac8IflJo3amNE8ag24ArH89QIvmOE0xVJKoTyttIk9SVKHPYV3F5crRJVHW080rW6cNXEqXrErHpaxmEgkxczA3c6uB+qKs1n2WGAIGZ45h3fD/4LfaDBTzK/GZvGbY9x7R7avqzbs0xPfZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F97qIjGB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F97qIjGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262EE1F00A3A;
	Tue,  8 Sep 2026 14:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876855;
	bh=hO2C5qse25Rtv1VvfRm5MLVLOHwlFJsEB4XqrQ/G6OU=;
	h=From:Subject:Date:To:Cc;
	b=F97qIjGBWg7BICw2e122rGAg4LdMXVk1ydLCbv/Gw7P3WrQZkfequPTfpU891/WHe
	 MNsjZIYq6TRtFdIHewUm/44RgfJ0ld1uBHgLU13rVhmGgsPYdvtjYeE8Qg+pgJkztm
	 ElRkEm3qjmSmELbF4HH0xo1+GCKB83FOHqunz9OrXqXTTRjn2YFYLzQnOLUDAe5BYJ
	 7wLdNdMUs66R+0+7Q1FC+Sk6wk+nyemtISGLgZ+JlkU8obm4q7yevErqd5B2+813Fj
	 Bu7SDec/hKeBY/zh4BUWfa2ibZSetaw8N31A2og6GT9gUej9ZaiSdhlUdOqxMib8XY
	 JcHKlhwYjRVIA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net v2 00/15] mptcp: misc fixes for v7.3-rc1
Date: Tue, 08 Sep 2026 16:07:05 +0200
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0Jm7Zh2ICiuvIdhUcsIVSlkWomGc
 HcLXsDln7x5/88QWBwHOGUzCE8uuMGnQLsMbGd8y+ialIEUlepIBXqO2I/Rjti7YPHm3hzwgDm
 K1ViaoimJcraFhqQYhTcgGS6QPqH+HcPremcbV/GKdS7EQT7biElv8H99k0aFpqJcVY0mbc35w
 eL5uR+khXpZli/Klb/v4AAAAA==
X-Change-ID: 20260824-net-mptcp-misc-fixes-7-3-rc1-6a4d6223ec41
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Florian Westphal <fw@strlen.de>, 
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com, 
 Tao Cui <cuitao@kylinos.cn>, Gang Yan <yangang@kylinos.cn>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
 Qing Luo <luoqing@kylinos.cn>, Kishen Maloor <kishen.maloor@intel.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Keita Morisaki <kmta1236@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4031; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1h+Lab5toORnoE2SALIUzpaq/tlwRchV+leKtaGmqOQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSKgyMmWJb6sp9Hi7TnbH9Wkm2q57b6ScFP3540RKu
 hhHqWNtRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQ8njMyPHA72xXZ+G1a0cwP
 fvyJE1hOTn9z9/MZB62P50Td2NU42xn+p9y6v+Fc2pcJ974qBdhmz06zmRV79uypf7ZRjsmGyzv
 d+AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various unrelated fixes:

- Patch 1: Do not reschedule the RTX timer for sockets that fell back to
  TCP. A fix for v5.7.

- Patch 2: Avoid copying thmac which will not be used and could be
  uninitialised. A fix for v5.7.

- Patch 3: Re-set the request backup flag when SYN cookies are used. A
  fix for v5.9.

- Patch 4: Drop pending ADD_ADDR when removing ID0, and avoid a WARN. A
  fix for v5.13.

- Patch 5: Handle invalid suboptions where the checksum is requested in
  the MP_CAPABLE 4th ACK with data, but not added in the option. A fix
  for v5.14.

- Patch 6: Prevent a race between mptcp_disconnect() and the retransmit
  timer. A fix for v5.17.

- Patch 7: Fix a use-after-free in the selftests that could lead to
  false positive. A fix for v5.17.

- Patch 8: Limit new addresses with the userspace PM to avoid an address
  ID overflow. A fix for v5.19.

- Patch 9: Reset the ADD_ADDR retransmission counter when the timer is
  reused. A fix for v5.19.

- Patch 10: Remove unneeded and confusing READ_ONCE() annotations. A fix
  for v6.13.

- Patches 11-12: Get nstat counters for the current test, not since the
  creation of the netns. A fix for v6.19.

- Patch 13: Fix an uninit-value in mptcp_write_data_fin for a corner
  case now that only a part of the tcp_out_options struct is reset. A
  fix for v7.1.

- Patches 14-15: Two follow-up patches addressing minor comments
  discovered after the human review. A fix for v7.3-rc1.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 1: Invert RTX disabled/enabled logic to catch more cases.
- Patch 2: Note for Sashiko's false positive.
- Patch 3: Update Fixes tag.
- Patch 4: Fix new helpers name + note.
- Patch 5: Note for Clashiko.
- Patch 6: New, addressing a previous comment from Clashiko.
- Patch 10: Remove Cc stable.
- Note: I guess I should stop mentioning the version target: because of
  Clashiko's reviews delaying the fixes, it is hard to predict it.
- Link to v1: https://patch.msgid.link/20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org

---
Gang Yan (1):
      selftests: mptcp: fix an UAF in mptcp_connect.c

Kalpan Jani (1):
      mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

Matthieu Baerts (NGI0) (7):
      mptcp: subflow: no need to copy thmac during ulp_clone
      mptcp: syncookies: remember the request backup flag
      mptcp: options: handle MPC data + csum reqd + no csum
      mptcp: pm: reset retrans_time when ADD_ADDR entry is reused
      selftests: mptcp: lib: dump nstat for the right test
      selftests: mptcp: lib: get counters for the right test
      mptcp: options: fix uninit-value in mptcp_write_data_fin

Paolo Abeni (5):
      mptcp: do not reschedule the RTX timer for fallback sockets
      mptcp: prevent race between disconnect() and rtx
      mptcp: remove unneeded READ_ONCE() annotation
      mptcp: being below memory limit is a likely() condition
      mptcp: avoid pruning for OoW data

Qing Luo (1):
      mptcp: pm: userspace: fix address ID overflow

 net/mptcp/options.c                               |  8 +++--
 net/mptcp/pm.c                                    |  2 +-
 net/mptcp/pm_kernel.c                             |  8 +++++
 net/mptcp/pm_userspace.c                          | 18 +++++++---
 net/mptcp/protocol.c                              | 41 +++++++++++++++--------
 net/mptcp/protocol.h                              |  1 +
 net/mptcp/subflow.c                               |  1 -
 net/mptcp/syncookies.c                            |  5 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect.c |  4 ++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 26 ++++++++------
 10 files changed, 78 insertions(+), 36 deletions(-)
---
base-commit: e0554c6276da957b6e72849520c70a97404cd1ae
change-id: 20260824-net-mptcp-misc-fixes-7-3-rc1-6a4d6223ec41

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

