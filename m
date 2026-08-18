Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E0190462
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787095648; cv=none; b=pBJ06grHjXxL10gZmuO4w83tT6f2R+/+HvzYCq4PLWsys0fT59mUectYS+Lq0XYKueBE1+hGVmPXkpqyEuJCwUYEjlxzAK0pL8Um2HV5MDfINnYgwedezHwckfgQwSEkhfD+sV1iAmAcN0FCoqU53h5QdVLZ5kOR8OWwAUkNqM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787095648; c=relaxed/simple;
	bh=lyDIECmSOWi793V2brRWIoDx9dp5wsCcYTA18C2Lt2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DStcugIcHBHDpAGsrMtGbHJjLrgOak2mCbwcbEQIcb/uQWl+0H3z1E3eGzmABbxpzvdJSe0Ns3ISa8UyD6nCYLfJYur4bEm/BMx5dKImauqaopio7pg6UKfclVrg5c1YMI2JpkYO0ylPTM0VrGldnI3LnITb3Iy9ik1Fk46X+ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nPJfGIHB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nPJfGIHB"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 6B04E20B7168; Tue, 18 Aug 2026 16:26:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B04E20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787095618;
	bh=5+I1gkjyb1pTSSglXz/sWx1s+E06BOgwmSlxgcpQGs4=;
	h=From:To:Cc:Subject:Date:From;
	b=nPJfGIHB+kEa0ekhgKbdG2xZqmHPBs3wD0jX9TRK+lWeKlt4LGyybAmzss4VrbA7j
	 xqk6+z3qU+uGgtCvyizUKxSh0V+pXhxNurBoWcIz1UBeqnKI6PrjkZBzs+GGIZ7Qbt
	 EjxozHWNLRMkyOpIbp9GoduLC5DhYQz5T12nRgj4=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 6.6.y] net: mana: Fix EQ leak in mana_remove on NULL port
Date: Tue, 18 Aug 2026 19:25:31 -0400
Message-ID: <20260818232531.102559-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

[ Upstream commit 65267c9c4f28199985505977bc2c628c82fc50ef ]

In mana_remove(), when a NULL port is encountered in the port iteration
loop, 'goto out' skips the mana_destroy_eq(ac) call, leaking the event
queues allocated earlier by mana_create_eq().

This can happen when mana_probe_port() fails for port 0, leaving
ac->ports[0] as NULL. On driver unload or error cleanup, mana_remove()
hits the NULL entry and jumps past mana_destroy_eq().

Change 'goto out' to 'break' so the for-loop exits normally and
mana_destroy_eq() is always reached. Remove the now-unreferenced out:
label.

Fixes: 1e2d0824a9c3 ("net: mana: Add support for EQ sharing")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Link: https://patch.msgid.link/20260420124741.1056179-6-ernis@linux.microsoft.com
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ hmahfooz: resolve conflict in mana_remove() due to missing commit
  3b194343c250 ("net: mana: Implement ndo_tx_timeout and serialize
  queue resets per port.") ]
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 6aaf646a6307..2b0759b02c7b 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3442,7 +3442,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 		if (!ndev) {
 			if (i == 0)
 				dev_err(dev, "No net device to remove\n");
-			goto out;
+			break;
 		}
 
 		/* All cleanup actions should stay after rtnl_lock(), otherwise
@@ -3470,7 +3470,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	}
 
 	mana_destroy_eq(ac);
-out:
+
 	mana_gd_deregister_device(gd);
 
 	if (suspending)
-- 
2.55.0

