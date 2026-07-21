Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607403B6BE5;
	Tue, 21 Jul 2026 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672107; cv=none; b=buYnsgPLG8VPM3qCCx2optjSWcMZWJRAEF6/hoNHCuXQZgYH+kp2B6k5MtpKCVCIMCQ7/fkFjMkmu+iaDZ07lTPXUJCYnvRIa5BtscHIiUTgX2cS3cpMmwuuhHkXHK9NRN/tVAQjni4GyxjI05TbA05FopkjOkK/d5Fz7MYnB7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672107; c=relaxed/simple;
	bh=1b2Y/gzcf6sosMCli43waBWN3mbmIYO/rHB7iPILqys=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LNS/HK25UEVma8SjavLYh7gBWfFGkgmJpN4yiXOX1VtHspRqBZ6cdUlsGY8Ecik2XZoVMuYVCu6RXxqInLhdbYux8+uZS+84CFzpwHWIRzg1UpI7gamU6YMN5ZMWt9gWB8nN1yuwkP4U55I0Vk72YReKd2rnqiOqJfFbEVnxNPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdSiMhIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdSiMhIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FD01F00A3D;
	Tue, 21 Jul 2026 22:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784672106;
	bh=msJ/ZTiNT8bHZHrX5GeIl08hHqY6G9pClI7pFaDtIH8=;
	h=From:Subject:Date:To:Cc;
	b=TdSiMhIEF05AcYi0/RQsr5hbrVQRuH42tUo224p3MZkt+YRvMwtMEX2Sz4Qs3e7wq
	 F2pwcQhZmQQhnQJhy/chbh6sdTJL2H3ndhGhRuENdKgPSFd4FiHxF4m0RpMd7XnmnQ
	 +EEqbNW4WZWVgQ116X7ocRrrPP2V0kaZoYyPTna5CALa/2ZJcJU/neZcXHtmAxLkCH
	 6ZIX9DfWLLKGjw4OjeOd99kW6wC13d0Qpwiym5FsNKf2evAxLeGx7v5GHimvJ3HGhz
	 7Jv/OOytMlITrclrpuSO6CGoHtv95KGDZ0LTwA+25ftp5QGfAQMAonhSV1ZpEjXSod
	 mS6ucukcmSzUA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/5] mptcp: misc fixes for v7.2-rc5
Date: Wed, 22 Jul 2026 00:14:37 +0200
Message-Id: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-0-6fb595bc86ef@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMAxFf4X02SZsKgv+ivEBSoWaMJd1GhLCv
 1vk8dzcc1ZQzsIKt2qFzF9ReUcDd6qApi6OjDIYg699UwfvMHLBORVKOIsSPmVhxYAeM12xac/
 u0nLnwkBgiZT5f7DCHcyExzHqp38xlT0M2/YDHHqh84UAAAA=
X-Change-ID: 20260721-net-mptcp-misc-fixes-7-2-rc5-693149ea17dc
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chenguang Zhao <zhaochenguang@kylinos.cn>, stable@vger.kernel.org, 
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>, 
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Frank Ranner <frank.ranner@intel.com>, 
 kernel test robot <lkp@intel.com>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1b2Y/gzcf6sosMCli43waBWN3mbmIYO/rHB7iPILqys=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLi3ydF7H8rOqc2nHNi5IK54rHHZpyzulgkvfhnsGCqs
 dr6iwrhHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO58ZWRYbIn7++Ot/K8S89a
 KtxQWbf5ga8Xl9XVF0yNxn51r6eFr2D4w3nqYHaNP0/Yms91nw7r/jVd0KN2KvXeyYXL24L2zj5
 9lgsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various unrelated fixes:

- Patch 1: decrement extra subflows counter in case of errors with
  passive MP_JOIN. A fix for v5.7.

- Patch 2: fix use-after-free in userspace_pm_get_local_id. A fix for
  v5.19.

- Patch 3: fix stale skb->sk reference on subflow close, in case of
  concurrent read operation. A fix for v6.19.

- Patch 4: wait on the correct port in the userspace_pm.sh selftest. A
  fix for v6.19.

- Patch 5: fix a BUILD_BUG_ON on legacy ARM config. A fix for v7.1.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Chenguang Zhao (1):
      mptcp: decrement subflows counter on failed passive join

Geliang Tang (2):
      mptcp: pm: userspace: fix use-after-free in get_local_id
      selftests: mptcp: userspace_pm: fix undefined variable port

Kalpan Jani (1):
      mptcp: fix stale skb->sk reference on subflow close

Matthieu Baerts (NGI0) (1):
      mptcp: fix BUILD_BUG_ON on legacy ARM config

 net/mptcp/options.c                               |  5 +---
 net/mptcp/pm_userspace.c                          |  7 +++--
 net/mptcp/protocol.c                              | 34 +++++++++++++----------
 tools/testing/selftests/net/mptcp/userspace_pm.sh |  2 +-
 4 files changed, 27 insertions(+), 21 deletions(-)
---
base-commit: eaa39f9f8ac8c1d032cd26b9cd572804e9d7683f
change-id: 20260721-net-mptcp-misc-fixes-7-2-rc5-693149ea17dc

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

