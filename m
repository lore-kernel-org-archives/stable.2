Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC22391E60;
	Tue, 28 Jul 2026 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258741; cv=none; b=T77I4nU3HQrVhh+wjUsk+mDedN43+taQU+0iaB9S1kM2CODv0Qd6O9zHLXpUW0U6Yo3c6/xD4DS4fLm8W0tocQRA1UaUkRflQPHHOtT4iMdWBHe001cpu/C35a7U5FhVfpBgNF6NCy6O+wxEe/MzAXiPe1GGsLA6FmOT1n8aCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258741; c=relaxed/simple;
	bh=39SJI6nbfPCq6jazkdh+Ef0zaW/4Ir6aLgzCnpxisZw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tv6xSbb8Id/mc/QSUdmPNYaBgc59zlUchcHD726x6dgvBRYwqrPSa2QPXw1SO44xkfosgalD1w4JVSUr9NLTavS8fXAPe5dJXQoC/niyuncZjyTLIi4llzQnEHNRUDhvk6un0WeHIjzjJK17dKzbC6LwqExatt8bAKVnhO2H55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg7eJA+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg7eJA+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5DA1F000E9;
	Tue, 28 Jul 2026 17:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258740;
	bh=t8Ck7QsvjL1lYC+thT3eYL6lWrgVxJ3UpquI7048FSM=;
	h=From:Subject:Date:To:Cc;
	b=Wg7eJA+2nsL8ecYpJPu3VXVei/OPRMI75/mTLo3f8Yq4sr62o7xWkn1Lcvofqo3xL
	 ICDlCPS9BuFpsHj7ei4ZvREgs/LSSRqneCKfT8HvEOEmexsXGrE6jwhWpouuVO2GRz
	 qOVouPK/DDIpHJ17SGoe9pY2uVrCdOa0i64nfDTmko4VGaNA1enNBuAoT0iq031yA2
	 ZKM6zOuXz3fugVQPTYGgUY0RNjhgObN6eIUCWRC52Hdq2JQhhszHBqpfr8GPjFq8gI
	 GwAgKJ4jpc6neaV4mvu6u62nv3SoamdltYu+x9GxVmOVY9bYjSGg/UPi+zQoHXoYQ8
	 ddNsqRibLbbuQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/5] mptcp: misc fixes for v7.2-rc6
Date: Tue, 28 Jul 2026 19:11:56 +0200
Message-Id: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCQAxFr1KyNtBGnCleRVzUmGoKHYfJtAild
 zfq8n3+exuYFBWDc7NBkVVNX8mhOzTAzyE9BPXuDNRSaCP1mKTinCtnnNUYR32LYUTCwgGJqDt
 yCDLGE3giF/kdvHABN+H6H225TcL1G4Z9/wBver0thQAAAA==
X-Change-ID: 20260728-net-mptcp-misc-fixes-7-2-rc6-22213c66ef75
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Florian Westphal <fw@strlen.de>, 
 Davide Caratti <dcaratti@redhat.com>, Christoph Paasch <cpaasch@openai.com>, 
 Qing Luo <luoqing@kylinos.cn>, Gang Yan <yangang@kylinos.cn>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
 Wyatt Feng <bronzed_45_vested@icloud.com>, Yuan Tan <yuantan098@gmail.com>, 
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>, 
 Zhengchuan Liang <zcliangcn@gmail.com>, Xin Liu <bird@lzu.edu.cn>, 
 Ren Wei <n05ec@lzu.edu.cn>, Dmytro Shytyi <dmytro@shytyi.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=39SJI6nbfPCq6jazkdh+Ef0zaW/4Ir6aLgzCnpxisZw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIyHr2er8Ho9fL4MoGTbFWPPBpnvlDif+OwYVminueib
 8aN3lOmd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEyEuZfhn9WavYkLj2b6vkvN
 SOQ9/CDlT4b+Vk2mGROOMMeLOM3/U8vwvzyOa3d0/TklgYuRHEZLxRKSVtd+XqSg6DhVPqVqrng
 xGwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various unrelated fixes:

- Patch 1: harden incoming MPTCP suboptions parsing by rejecting
  non-combinable ones. A fix for v5.6.

- Patch 2: fix a data race in the ADD_ADDR timer callback. A fix for
  v5.13.

- Patch 3: correctly catch data corruption during the MPTCP join
  selftest by marking tests as failed, instead of only printing a
  warning. A fix for v5.18.

- Patch 4: deal with MPTFO with a valid token, but no data in the SYN. A
  fix for v6.2.

- Patch 5: reclaim forward-allocated memory in case of error on the
  receive side. A fix for v6.19.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Gang Yan (1):
      selftests: mptcp: join: mark tests with data corruption as failed

Matthieu Baerts (NGI0) (1):
      mptcp: avoid combining some incoming suboptions

Paolo Abeni (1):
      mptcp: reclaim forward-allocated memory on RX path errors

Qing Luo (1):
      mptcp: pm: fix data race in add_addr timer callback

Wyatt Feng (1):
      mptcp: fastopen: only mark MPTFO subflows with SYN data

 net/mptcp/fastopen.c                            |  7 ++--
 net/mptcp/options.c                             | 55 +++++++++++++++++++++++++
 net/mptcp/pm.c                                  |  6 ++-
 net/mptcp/protocol.c                            |  7 ++++
 net/mptcp/protocol.h                            |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 +-
 6 files changed, 73 insertions(+), 7 deletions(-)
---
base-commit: 78f75d632f74b8de0f081a128588f7c37d0d1164
change-id: 20260728-net-mptcp-misc-fixes-7-2-rc6-22213c66ef75

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

