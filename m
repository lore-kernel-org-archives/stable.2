Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2A4B2CD7;
	Tue,  8 Sep 2026 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876892; cv=none; b=OTvFrwIv2OCX3DSSBH157v0OkOWTcWc+raAM8BzIx3XNRrmFLkGP9ILptEc5HHlUT1Dne7/YDqXGrIE/ulYfvwBJmnKv3PErOO088C8SGJxw69Xgl9QEJkpiyJLvO5D8KnWKlNNrh3vtvSTjRgJ3AalXRX71q8wSMnXbb5P8I3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876892; c=relaxed/simple;
	bh=rDbSGSAmVFbg0E1fLJuj2J9IXWeWyHNTwxjz99I+YJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHrgVF0Bax6M7y7cIfgquNZX6vsfI77nj+x4D06X7bgzbSIXFtfipE7i+S3EfBc1d8FknpnbJbXvKLzXL6STrzzYlbB9n6hjVANgTMPDI96veFsA3Vokn3fHsUenei6cdtzP+XioFgqNsEGaLX7WRigYsyPPuv38O+oEc5GQySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU0ApHEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU0ApHEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B921F00A3E;
	Tue,  8 Sep 2026 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876877;
	bh=zr04WX9th+houH+FrgG3Exh8ghBTSa1pugxeGkEkLuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MU0ApHEWWaK64ETlIc2Aw3tiSFKFaoJt16hfHpBZuCyDGV7dgXJFOprXtYFynTb8M
	 TDC6sOyN6E9zItE5n9a0/MywJJHNaaEa4KUWFpb8A3A34Df8/gytelGmmob+xyjxT3
	 Rf6Tll7DSJn3y1Mc5uBRT9+15eJPbxUm2HiWFxtvLLOI+JfCZWLcuSOUDnITytZAAC
	 is6EAmeY24mywRhrQp/CZ7Qdl2T+78wSzz1nAWYshv6oKKTqZ/21t1Hup6uji7r2Ah
	 fyqTQrgzh704aowWaYViVGNv2oDbR44DWKkLY8+3IThyfdyOh69ak1ztmSyRmT8LQi
	 fTmH+flhdFv2w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:14 +0200
Subject: [PATCH net v2 09/15] mptcp: pm: reset retrans_time when ADD_ADDR
 entry is reused
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-9-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Kishen Maloor <kishen.maloor@intel.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rDbSGSAmVFbg0E1fLJuj2J9IXWeWyHNTwxjz99I+YJg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSOgKerSa9qp1LGBZ33pZMchO61vyKoYdgmrvCpS3L
 Ff1X8rSUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBG25YwM17ff3tvZIvf+lznD
 wYJFLKsvXXs+13JfweVHxyOvT1rzlonhf7GywLH3OXPqfDzOLBZi8FNJqApNvVkg1GT4yGx+cdc
 GZgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR entry is reused, the timer is re-armed, because the
goal is to re-announce an ADD_ADDR, and eventually retransmit it if
needed.

In this case, the retransmission counter should be reset as well, so the
re-announced address gets its retransmissions back instead of relying on
what was left before, and possibly not being able to retransmit it.

Fixes: 304ab97f4c7c ("mptcp: allow ADD_ADDR reissuance by userspace PMs")
Cc: stable@vger.kernel.org
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org?part=4
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8b68868255c5..b0b71adefb8f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -462,10 +462,10 @@ bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 
 	add_entry->addr = *addr;
 	add_entry->sock = msk;
-	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->timer, mptcp_pm_add_addr_timer, 0);
 reset_timer:
+	add_entry->retrans_times = 0;
 	add_entry->timer_done = false;
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)

-- 
2.55.0

