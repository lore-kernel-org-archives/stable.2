Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787483E49C0
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287061; cv=none; b=O7POjss85DO/eJflU4Kxz8QYSDMbeKshWgYs+VV/3botEF+iiP8eHRRFH5TSFohktkS7f5PNlOodi+rohsQtCAZRSdw6IDKKvkLXwwm61uQvNoEFynSviPZu5a2WGq/obXAxQ0ZmCMH9OAYNcaztv/B2YL4fG3CCLMBTy6kpEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287061; c=relaxed/simple;
	bh=kKA4kIe5JolGycpkyJbbWIEFH/qK0xn9VlgvCZWhNOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ff4WKT/zeGYKNiNrGJinaos1GSAc5Dmjiqr7Vsizqahwhc6jw1N4qggtMNWmyu9i+9ctVSH6vx9CKXFzQec4M20MpumWLCI8gsIGFEGzCbrDSnpZU8cjyR1YZhGD46cgI0n31CD60zl0Yz2OCBFVh03p01fGKO3I2EOJTf+9n2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHGyzhx9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHGyzhx9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e2e0f3dd40so17807055ad.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791287060; x=1791891860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bqr7EFo80tshg+V79KvdmIRlvhDOgHoI6OjKUQvN6to=;
        b=tHGyzhx9Bs4QanvP8tZEiCVF5ycTCyFaSn+Zgy4/B69OpR5IW1C6QefiJJwM0+H2l7
         Ml3h0Iy0AmJdXzAbKdsRut6xgca6NjJkVjSN7hTzr18Gv46sp9ivmyi7xbIy6Jk3AdB9
         D3AOP+7jBdtp5wsjfCDunPGObrx4HjUrq9LG+q8IaD6Nq9GL2KSD7dXmS/NHe2gAnI9v
         OMjv87Bg8j7OXN31I+xbTsln3mB6XEbu/aejIdys9rA5P3d3UcRow+Q7TB2TXQCEsDOO
         znpuV8uWUkvdJr8x0MJiNc6JYO5K9/icRq3rRslb5TKNUqAebvUiXw6i+rMBMi37xPzb
         AEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791287060; x=1791891860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bqr7EFo80tshg+V79KvdmIRlvhDOgHoI6OjKUQvN6to=;
        b=0CwDLbjG2ZbvHHHRmHUzN3qzZ1n2kl8OEo1d2UVx8UY5JZQo8ya6OoCfWZ6GcBCWf5
         iutlgAEYG9i4aKrgfrxxRI0uEZGUpZRvO9t5uTPz+Ur6e56YDrsM8dkZzRYOcgbP65h9
         pv9SjPZ1okk8x1QeH9ZQp6Eoxfk+tY3wfmpS13/9J4Tnh8ijGnSC4laItaSQ2qn2AQKb
         RnrdVp/Ne9bksytSO6DEcbd0RmSLjt42ISeYjwYZ8Js51y4j/vlslmda9HJJa+Ax8JXu
         C73y6x0Bpy+ufnuXpmY1npmNnhgGdPV1WXjXCPZCZGTNVV07CXG4D3MFNRX+6gdov7/T
         DXyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIBbCm7PVTZ8JYFzILkJVWJuXXfKrkmCPimIUATxTrTE5jTBJo6PaWle/rnypZabOaxboBRBk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBftH2xu87GbVy1q2YVOuYN+oWS/EfzC/q5jpuBGayh7Iih36S
	+RxhcvMaWPzCu4Z0KB9CqFhwzsE7uV6s2gXfjV/wyxSIeqvICPWMS5JS
X-Gm-Gg: AYBFou3Z5ll/IEL0s7j0kNnk77CJcqvLahllk6L4eqxwlQwJo5wBdYnmGqZYpJ/8d+J
	5y3ir3KDTOzFjxcsOToohC22ylB0QwmXzgVnb9bCLyAtEn4YA+ZmPYHfqJ+uQlZSFCBLGdXwuFa
	HWCNYDPmGA/g76r4v9+jWj6ecXvcfq2v3UvF23FEvllDGaGMR69Q08tJfoudkdhM+RxN3OIgVVF
	vUJvc8MRzP5Jk+vC1+F7tFuCuaRxRQecFTWyru/RTRThuL1eqwaxz6RKQ2oWjQbrm0IjFKlsu0G
	hZMh2y7xqH9zegngiPvpZQU1PQWzBp5crQ7hakN9c9E6ewXp7eJgOVTQC7xqVDrLtEz8EDadRkP
	YGV4S8O/UldvQTQXqvCAcqHsVpbCgXeaHTJg/rwsrY5+hYsxrO3SKgmiSrWpU0K9dD4HUaqFeQm
	dapxrDFZZlBSlma9mmqYKWDYzX2jAFZnbTJigJicgWdEShxXCNVhXsJDjixy5QzKr5dfzKabPGK
	vHOJ+ZHFj0/7U9ctazpu46XU0IYcfmXFNEcfqk=
X-Received: by 2002:a17:902:e54b:b0:2e2:be61:a882 with SMTP id d9443c01a7336-2e5dcd90aeemr10289505ad.11.1791287059556;
        Tue, 06 Oct 2026 04:44:19 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5ecf461sm20805515ad.53.2026.10.06.04.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:44:19 -0700 (PDT)
From: Yiming Qian <yimingqian591@gmail.com>
To: security@kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	yimingqian591@gmail.com
Subject: [PATCH net] mptcp: pm: in-kernel: fix C-flag endpoint accounting on family mismatch
Date: Tue,  6 Oct 2026 11:42:27 +0000
Message-ID: <20261006114409.117190-1-yimingqian591@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fill_local_addresses_vec_c_flag() clears the endpoint ID bit in
id_avail_bitmap before checking whether the endpoint's address family
matches the remote ADD_ADDR.  If it does not match, the loop skips the
endpoint without incrementing local_addr_used, leaving id_avail_bitmap
and local_addr_used inconsistent.

Removing that SUBFLOW endpoint later calls
__mark_subflow_endp_available(), which sees the cleared bit, expects
local_addr_used to be non-zero, and triggers a WARN and, with
panic_on_warn=1, a panic.

Keep the endpoints that are skipped during this specific C-flag
iteration available by tracking them in a local bitmap passed to
select_local_address(), instead of clearing their IDs in the per-socket
bitmap.  Only IDs of endpoints actually used for a subflow are now
cleared and accounted for.

Fixes: 4b1ff850e0c1 ("mptcp: pm: in-kernel: usable client side with C-flag")
Cc: stable@vger.kernel.org
Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
---
 net/mptcp/pm_kernel.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a77508132354..a5952dd0ae125 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -120,6 +120,7 @@ static bool has_subflow_daddr(const struct mptcp_sock *msk,
 static bool
 select_local_address(const struct pm_nl_pernet *pernet,
 		     const struct mptcp_sock *msk,
+		     const unsigned long *skip,
 		     struct mptcp_pm_local *new_local)
 {
 	struct mptcp_pm_addr_entry *entry;
@@ -135,6 +136,9 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
 			continue;
 
+		if (skip && test_bit(entry->addr.id, skip))
+			continue;
+
 		new_local->addr = entry->addr;
 		new_local->flags = entry->flags;
 		new_local->ifindex = entry->ifindex;
@@ -401,7 +405,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		if (signal_and_subflow)
 			signal_and_subflow = false;
-		else if (!select_local_address(pernet, msk, &local))
+		else if (!select_local_address(pernet, msk, NULL, &local))
 			break;
 
 		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
@@ -574,22 +578,28 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 	u8 endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_local *local;
+	DECLARE_BITMAP(skip, MPTCP_PM_MAX_ADDR_ID + 1);
 	int i = 0;
 
+	bitmap_zero(skip, MPTCP_PM_MAX_ADDR_ID + 1);
+
 	while (msk->pm.local_addr_used < endp_subflow_max) {
 		local = &locals[i];
 
-		if (!select_local_address(pernet, msk, local))
+		if (!select_local_address(pernet, msk, skip, local))
 			break;
 
-		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-
-		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
+		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote)) {
+			__set_bit(local->addr.id, skip);
 			continue;
+		}
 
-		if (local->addr.id == msk->mpc_endpoint_id)
+		if (local->addr.id == msk->mpc_endpoint_id) {
+			__set_bit(local->addr.id, skip);
 			continue;
+		}
 
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.local_addr_used++;
 		msk->pm.extra_subflows++;
 		i++;
-- 
2.34.1











