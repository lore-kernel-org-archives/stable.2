Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050819;
	b=FTSMAKgYv5kjG1x59TPoGfzogwW1utC5/ZN+3Tqs9u/LhHVztOTXRc5+1xOkgZ8E/C0e
	 J/QW4EpEyzisU3ad+LrErumXi0MDX48o+a0eXtDMOiffI9VfmD5u1ottjmUYHruA0EcjZ
	 BVKrDQU/8yT7Ga0tMUIWBMD86o8i8GSQLD37uafe+rwmm1cc2aUE+qN9YI/+Wg824q84w
	 ezHQl7b+Lak4CAH55E1Lpu1qsizvsEjxVo3OzcySsllY0UnPcaLTlZpSVlJvOziT26i9N
	 +McW3dYhXS836l2Xtmrr+LSIhQi1k5FkGlv2UCBYh1RE9KDfxFLxQhbKrGT5FztPx2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050819;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=guuWOPEngFsnWAkCLiWzArpd3wDvbjhSCDVZKEaqHK0=;
	b=p/4b7n2JVDWZ7D05i+RgUMwrYLOGtPWDCc6dGts6sZp0cokrmvpLeVldDoUYX5qA/xF2
	 8ByR2GOperQt2UEBNv0Tfjs+VoCoPwi9AWr6SPwe40ug01cVpVeeUC5+cSpYNBcl7RN6x
	 nusEgQ0aq9lQGy97TU8zJNbmQ0G6fK51gQaquahjrKuzEL9jKLbFWT9h6XSKWMdzntD+q
	 UTnotQ1S3KUNo2NpnE5iWjHBpCh8LQWO5I9s8cmExA4BMxvu5fGjCyYQGY06lZnV4QqqE
	 4fh8AUkf4AaPCRaYRRNTKMPwMo4HFEyyJVgQ4uJE9QGFftqBKo3AW2J6mADgZ4Suo4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aC0vNiPG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E8606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aC0vNiPG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABC91F0089F;
	Sat,  7 Nov 2026 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050819;
	bh=guuWOPEngFsnWAkCLiWzArpd3wDvbjhSCDVZKEaqHK0=;
	h=From:To:Cc:Subject:Date;
	b=aC0vNiPGVy+qGu1+R0J8GGheXTwJDQGixJOoe8hJMMSo8Tl6kFHNXZptF7utA4F+f
	 8cWAdsYDme5oHnbp0uNkV8QN/UxAmjC4r/m8IxubWQplT7U5qhsORkSiyYdde1f7j3
	 tWQoVYIRLAMVGfoCMfPwfBFXbtDzYRU0iPOd/ueQudZRZT4zdNghztb4ezCRkgrji2
	 FSa59Kzdac1L1L5wIlbx4nRInChrWU3wvyNXpRpQ0mLMWzPzPAwyP4rf+JGEhKbSFW
	 h5HBG7HjlXHE4CNEPECwFZ+uqB9zn4tANjuTNm3f8z/9ivgDttYKDdBlGoc6c+kB4T
	 SJUTr0k/GCECQ==
From: Sasha Levin <sashal@kernel.org>
To: 4ncienth@gmail.com,
	idosch@nvidia.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ipv6: remove ifaddr from hash during ifdown list cleanup" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:26:57 -0500
Message-ID: <20261107062657-failed-5.10-6ace56ed7b13@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6ace56ed7b13a9c6d4cb7ef0d82d3a3d53324a63
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062657-failed-5.10-6ace56ed7b13@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6ace56ed7b13a9c6d4cb7ef0d82d3a3d53324a63 Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Thu, 15 Oct 2026 14:06:48 +0900
Subject: [PATCH] ipv6: remove ifaddr from hash during ifdown list cleanup

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
---
 net/ipv6/addrconf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c90ee6dd7446c..72d7df23f7967 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4019,6 +4019,10 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
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




