Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946DA3C4B68
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179841; cv=none; b=LgiZnwGPc+VIUvLx/vyD95oYjxe5zVPnI4XD4nr9dnqetC5qVn7urnOTvzmr6XjB5Vzhq2jKHdGkm6dl7/TKB5cO4dPvEij/OeV156ia4yyXwmNJe9yNYglYyIWP26q0/oSDGmqKZiOUXmBNbbA6rB/I1oTkSEOCn2jwTuVKsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179841; c=relaxed/simple;
	bh=SvLgvsH7kRwcisqq7Emux8TXw7V1gRO7ojpfVnq2noI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwsI9G2NmhRjOdDlZZpQn3J3USJoVNQfO+qHNGhCR7BqDCVMmEK3BkQIsBMPGfUpR5Q6xy5eGtnsPVoOIVsU7X+9cQxBP4xc8aAjQAiUDKYO147HdE+C9+AWbH8iX48t4CU6P1dv3qc38wqrGoGWxvU/JpuD7R/ANv+pXgQRPmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL/bHjf2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL/bHjf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3E21F000E9;
	Mon, 27 Jul 2026 19:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785179840;
	bh=VBfmxq0CdMSe+8rdnmLGPUc90uOUykNWqnm+0XHSlyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hL/bHjf2Uol3WB5SRbImp6ArwXmSuY+DEbg1fgOnfL1sNPadCQ+zzSqTXTPoAP6Wn
	 jQqgtkwvV6uarYyJGFsdci7+tTdniPoH1tc2lQhYq+1WG9gCkUUgreDZyhRFnTC5Lv
	 sIxSoC/scHkZaG90WFwp1Db/ziQ3QjYdYTnlxJkAWvPv4CnSLHCVrUSgNfn7mfI01G
	 F4YctUNAUhKBnYl+mKx32KHgGhO6xX2V3n/Yq8Ba4yc850KXNFS8U1xghlO1OI6lb/
	 PG07pWxbpvT3Y9Lqszd/oF2oPaZPiKh+sO5BGNfRgYAmlHTEzGxQeft/LPUm5Fpj7q
	 zwQBB8JlKtwUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dm-verity: avoid double increment of &use_bh_wq_enabled
Date: Mon, 27 Jul 2026 15:17:17 -0400
Message-ID: <20260727191717.1692026-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072019-washhouse-dweeb-5963@gregkh>
References: <2026072019-washhouse-dweeb-5963@gregkh>
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
index 6ae5886566d910..5612705c58eda7 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1172,6 +1172,8 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
 			continue;
 
 		} else if (!strcasecmp(arg_name, DM_VERITY_OPT_TASKLET_VERIFY)) {
+			if (v->use_tasklet)
+				continue;
 			v->use_tasklet = true;
 			static_branch_inc(&use_tasklet_enabled);
 			continue;
-- 
2.53.0

