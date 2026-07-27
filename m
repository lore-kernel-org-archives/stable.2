Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F16F375ADC
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180271; cv=none; b=JZ5pyC0dtMiIvlWaXYYxDUfGHKVXxafT+I6AgnWkEjzd14+aB0ar4YwWupQZmTEkcgK2ezbgAxDm5jqBjA+rS0XgJ8gKNdwLTpXhP5mDjMCvNmUaWG7BwAhMX7p4/D5JHl/1xzA2UdPafxFwzqaCMyEdvwNmlsZjcgPodHPja1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180271; c=relaxed/simple;
	bh=esdmYYPu9at7es2wz6TMsxzZYgOsgeRj36ZJ2HHjZoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I734ff0t+gWEIxkKiDq40MRTqHnAwxJpnIYa1EBhEhA/LikwbcymDplxz/6GZSRDSuqz5Cuw8/xVD04ZzT3Y7JIRfYxXT6IpUdqNRjTlnGwIgxbTXf3n/8PEcebtbxcfPWlOGJj74SAP/O9S+v9HtMVpFRPWcRreRsTyr9Zocdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJL7Gf8r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJL7Gf8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891F91F000E9;
	Mon, 27 Jul 2026 19:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785180269;
	bh=eNLJlrj8Cw4Agb7dbGX9+ld3zylNYJX7mjFjEllVCX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AJL7Gf8rwSyQy7sON694OaYRYaz5hwO/7IkfsHei9jDsetmESIosOfDaNV4h4zLm4
	 YMpgYdr7XU1ypSmJMI9uSMrqKTp4jhRveruRbErkcThV0/Fe1k6wqohTxygfBa8UFF
	 DoW42LwrNmMCtOtHWh1SQ6SlCAwjPdGev3qHj17NwRn0GCpmQUuXs1RYS4OYEYh9dS
	 LN1lAmAqKyY40lgl8eVevoMsq3aGfZcYRNAQycTJrRuGzhBy5VybLXbrwZHUjMhsVJ
	 tQgP3XRD6x43YJYQCQsMiQHiDBbDp4c0aPkBsG+5w3eO4Lr6tsHCgkIivVJzycLTaq
	 MPbt6CApN/TLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] dm-verity: avoid double increment of &use_bh_wq_enabled
Date: Mon, 27 Jul 2026 15:24:27 -0400
Message-ID: <20260727192427.1724975-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072020-agent-amiss-f82c@gregkh>
References: <2026072020-agent-amiss-f82c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 72e9ec2fe32b00994f41719cf77423fca67d48b2 ]

verity_parse_opt_args is called twice, first with the only_modifier_opts,
first with only_modifier_opts == true and then with only_modifier_opts ==
false. Thus, the static branch &use_bh_wq_enabled was incremented twice
and the destructor verity_dtr would only decrement it once.

Fix tihs bug by only incrementing it on the first call, on the second
call, when v->use_bh_wq is true, do nothing.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Cc: stable@vger.kernel.org
Fixes: df326e7a0699 ("dm verity: allow optional args to alter primary args handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-target.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 53150024d2dd4e..54f9adaf5fcdc6 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1151,6 +1151,8 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
 			continue;
 
 		} else if (!strcasecmp(arg_name, DM_VERITY_OPT_TASKLET_VERIFY)) {
+			if (v->use_tasklet)
+				continue;
 			v->use_tasklet = true;
 			static_branch_inc(&use_tasklet_enabled);
 			continue;
-- 
2.53.0

