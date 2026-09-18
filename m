Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872051CF65
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760763; cv=none; b=H6A6Ug/LM7e7P7y2gUgS3Dkv/x0PHFiY2pzLw7Tty/BQWv5R6LEMedt+PPc0l/6qyfmSWgXD3/j3Mj4HL1kcVpZ+yViD7iULF/1KdcLnpwbZ6vPOokB5jl3Pv+uk5GKzQRPbaaGAQmdYi3zIyxmJq+PQRyfJ8yjOhY8fQOA53Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760763; c=relaxed/simple;
	bh=8qzfFL2oxrizSjd1qa+767IuEE8a1w7yLOT9blyylTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujlf2lU/Xf/7or7AKIOJVCoR/cv5l1uZ6NLRLhjkashlEyKml4xdhWJYfzrC5VzUN2z0gHmQmxkjKbl3bSJugD3fe0UB8cwz4YQnLxPFa+oyY/xPoGy7F+7jjrb/GerPsolyhFWNPDDdElk5rrsO1Zb/e6PlKTWCcJodhVpNp+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3D89Cqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3D89Cqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA5F1F00898;
	Fri, 18 Sep 2026 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789760760;
	bh=sbFEtDXq0dp4t34lEbYfe3Qi3hs/YneIRi1bTm64CAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J3D89CqjU4l/KxA87078rfCLqT9PHOpWtZH6lFdm5/EVQ3UFX+oLHLwKfZvwvJabU
	 z87BeskXEL4yjVePx6sjcGu32m66Utncy8hqGi54BoHsrxSALIjqxlPV5DShss55GI
	 sK4YQYdLTaRaDMew66PnOS3VRpEfoewEcWNnknwaJmxCi3//bXD2A+rfU0zdzJNIse
	 WwCdVlQL271cRaKU9pvx0S0EZelT/Z8HH/JLPBLaa1KGKr7h3Kvogwf9LkxeHDitgQ
	 RTNOJg+++TTgXZ08MprbgGNGc+q8HGAzjm22dgapP+U4UpJvwEQHkgc9z1JniQQl9Z
	 Id7xR/AoyqZLQ==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>,
	Kevin Hao <haokexin@gmail.com>
Subject: =?UTF-8?q?Re=3A=20=5BREGRESSION=5D=20stable-rc/linux-6=2E6=2Ey=3A=20=28build=29in=20expansion=20of=20macro=20=E2=80=98container=5Fof=E2=80=99=20in=20drivers/net/ethernet/ti/cps=2E=2E=2E?=
Date: Fri, 18 Sep 2026 15:45:40 -0400
Message-ID: <2026-09-18-daily-reply-0013-re-cpsw-rx-mode-work@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178965354369.144182.3820631599752867786@kernelci.org>
References: <178965354369.144182.3820631599752867786@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> /tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:310:34: note: in expansion of macro 'container_of'
>   310 |         struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
> /tmp/kci/linux/include/linux/stddef.h:16:33: error: 'struct cpsw_priv' has no member named 'rx_mode_work'

The queue took 0b8c878d1173 ("net: cpsw: Execute ndo_set_rx_mode callback in a
work queue") without its sibling c0b5dc73a38f ("net: cpsw_new: Execute
ndo_set_rx_mode callback in a work queue"), which is the commit that adds
rx_mode_work to struct cpsw_priv. It is dropped from 6.12, 6.6 and 5.15 now.
Note that the cpsw.c half applies textually clean on all three trees on its own
and only fails at compile.

Kevin, could you send a backport of the pair for 6.12, 6.6 and 5.15? 6.6 and
5.15 have no disable_work_sync(), so those two need adapting. 6.1 and 5.10 do
not need it, the Fixes: commit 1767bb2d47b7 ("ipv6: mcast: Don't hold RTNL for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.") is not there.

-- 
Thanks,
Sasha
