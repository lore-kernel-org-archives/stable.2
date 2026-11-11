Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414192;
	b=eiWp9uOz2s4x7v1wp81N1bEfC1dyz+/RIXnaGhSKBTjGPy/xlfHcbsULDoXGbiRePutX
	 jyszzcZW30qH20RZ8AiWqObbkV5P8GOskczsZGHLU9Zfl6jycQAIIBxwWr0tWHW+6dzmd
	 5JtXqc9LvGZROticrF1UmSHzYRbcrmtIoe5z2jAAJ9ISPCG06/zIXOJK76i5Yj7JJ2ORt
	 qPfW4D1dHFL5AcoQhCsfOQSTuEvrxd8wR0hsNgulKxQmi28nsHUYrvqems6AIPozcoXw3
	 RZSlSjpPktxuM8Pbwn+IsH+BmP1mxZ08PgerdBSN8FMbE0DywCb5+FagQLSaLaFCwfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414192;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=koJ8a3LY8PxZ1Q4v0atgg4yJCs48fK7HBRXY/PYF1qw=;
	b=xEPqbXaPQn5qKZzsJIX6eCIWGKp4vRI4evuYEPVMHHkoExbQhtaNrRfOCH/C+k4Y9WJN
	 C2lAEsFJhAvJGRC7D7YmH2HdbUz6brpDRTHa5EWEua6QIp6Q9ZkxUTZoSvNQr/M9aN1IU
	 BxmHQxRjAQzsDx0yGAC2Pwv28CYsXWC30Cic8IkpfoBaO2wGgb2Q2LaqrcM5gjuNSzq6n
	 vdUnzTtSIxLrPgjIv0nqfEe7Et3dBPGHTF7m4CtYMdllMFrMJa/8ioSeB5ABOBRW3bg48
	 EC+gMFR+rQvUMxxi9kq3PspRYyWK/sLGmbebh46NT8/IAZFjbzxa7coJcJt/0KYwMHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hbIIYNbB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F532606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hbIIYNbB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1451F00A08;
	Wed, 11 Nov 2026 16:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414191;
	bh=koJ8a3LY8PxZ1Q4v0atgg4yJCs48fK7HBRXY/PYF1qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hbIIYNbBy/3gOganQoP0gnGrffA9Y/nkZwNtow27YybWWv6Fzx5Mdw/Bi049AQ5sQ
	 8KXCtqEllXkOa/NNrMVh6igrpP2Ns3REAT44u0W8OdtC0GYxjGOtfe346lo8xhi54b
	 wwF6Y7brfl9qeoPEG8DO/CN0URsmTKqlYaVd/sYL421dNNXkyJC8wyHp0y2caZDTQZ
	 7QV9WolatDT9GK0kPcIeAnOinO+B6YMxOagaUgeUB9MJCmc5tvyswhqPSl0lDdlKUs
	 Zr88BF9D2xS1qKspwtsQscEvEhmyOsR7fc48TM2nHOPS5wYjYPGKz+U/vefQ9PVDPZ
	 M+/CewEid15Ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] ipv6: remove ifaddr from hash during ifdown list cleanup
Date: Wed, 11 Nov 2026 11:23:07 -0500
Message-ID: <20261111162230.3239471-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111162230.3239471-1-sashal@kernel.org>
References: <20261107062657-failed-5.10-6ace56ed7b13@kernel.org>
 <20261111162230.3239471-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daehyeon Ko <4ncienth@gmail.com>

[ Upstream commit 6ace56ed7b13a9c6d4cb7ef0d82d3a3d53324a63 ]

addrconf_ifdown() clears the address hash before snapshotting the
per-device address list. A concurrent ipv6_add_addr() can publish an
address after the hash scan and before the list snapshot.

The ifdown path then removes the address from the device list and drops
the list-owned reference while it is still linked in the hash. Once the
remaining references are released, inet6_ifa_finish_destroy() warns, but
a DEAD address continues to kfree_rcu(). The hash therefore points to
freed memory that later RCU walkers can dereference.

This follow-on was found by source review and was not separately
triggered at runtime.

Remove each non-kept address from the hash immediately before removing
it from the per-device list. Keeping it hashed through the delete
notification blocks same-address publication until NETDEV_DOWN has been
delivered. hlist_del_init_rcu() is safe when the earlier hash scan
already removed the address.

This handles a late publisher captured by the list snapshot. The next
change serializes publication with teardown so an add cannot miss both
observations. Both changes are required when backporting the complete fix.

Fixes: 73a8bd74e261 ("ipv6: Revert 'administrative down' address handling changes.")
Cc: stable@vger.kernel.org
Reported-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/r/20261004135117.GA206930@shredder
Link: https://lore.kernel.org/r/179161099539.434549.2238120015372268173@kernel.org
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20261015050651.1841557-2-4ncienth@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 8429bd481706f..ab65da6e63175 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3909,6 +3909,10 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 		}
 
 		if (!keep) {
+			spin_lock_bh(&net->ipv6.addrconf_hash_lock);
+			hlist_del_init_rcu(&ifa->addr_lst);
+			spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
+
 			write_lock_bh(&idev->lock);
 			list_del_rcu(&ifa->if_list);
 			write_unlock_bh(&idev->lock);
-- 
2.53.0

