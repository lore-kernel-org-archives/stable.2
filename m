Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312C4D9564
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583842; cv=none; b=ZVT1D1w663DQf9FjTHZbzznanvBZinQeC//6GoTjO2E//ImwhRQKLf6+V1n6ADOsp+P6T2wYoH2ega27LWihT30oGFIw+wb72s/fY/lGDbKExrRY0f5wUO/ysA2aO28y9z+dupgO4y4nuZ3YjrfL8KN8tMlZDvQSkpC2fHjRYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583842; c=relaxed/simple;
	bh=8+lIgI8YMgqp/20HlLIcIAClnpvAP+d1d76pzxAfUIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edux66RuGOKeBZaTBCWaIR1zHoMOjnDi/+y5fpkVTuRhFcwb6OS99LtMDaYHHLIzoQ/GadV+u6IF1ha1m4bEsWuiXARjJhBuCgUP0xa9d4UKYpLcst2TYp8re/lCi6tDKKxnPPkcQWaFCxxVqe5BUiEPpeqTQBiCS+7LUeQJck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3RjdtO7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3RjdtO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE73D1F00899;
	Wed, 16 Sep 2026 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583818;
	bh=C+HRoRmYjmV6D/I9E9T1Bxl8eI+z1wdtBHICeRF5L18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R3RjdtO7tysjyo1LHWMK8pWIwbpHrm0h4WjMLLhEqCDsfI+ICA5VCXpf6325sCr1K
	 kOXGBWzuu/q7UjsCUFu7qsOi/ZE4tk3q6oY4ZxGPfwt4G/wBY3xPAVnDcupEx6unEe
	 13cZ4ABJlUxHvDm6cr6HWr8zVITkQ1CNY0/41TiAXp4HTlxAYNSWcaNDz8HNzPi/SM
	 HeMdc90DSWzRWYpRwJR5qVuowzZJpLonmGOHiak8E0fKCXFrwwehFLIxJYR+2g1F/O
	 UBNLQcMKyBHdZ4oYmN32vUbHYrlR0P3lRaydYlc1Amzw1wuz4qbSFkz+frVfMD+zdY
	 9rmIf8PoXkiAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] tracing: Free histogram var refs regardless of how often they are referenced
Date: Wed, 16 Sep 2026 14:36:55 -0400
Message-ID: <20260916183655.1773427-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916183655.1773427-1-sashal@kernel.org>
References: <2026091621-debtor-hazelnut-dfc6@gregkh>
 <20260916183655.1773427-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

[ Upstream commit 4bddcb346a6cf4615ca77f69a589623b877ca267 ]

Using the same variable three or more times in one hist trigger leaks the
variable reference and its strings when the trigger is removed.

commit 656fe2ba85e8 ("tracing: Use hist trigger's var_ref array to destroy
var_refs") made a trigger's var_refs[] array the only owner of a var ref:
destroy_hist_field() returns early for HIST_FIELD_FL_VAR_REF, so the field
expressions never destroy one. One entry, freed once, no count needed.

commit 8bcebc77e85f ("tracing: Fix histogram code when expression has same
var as value") then made repeated references share one object and added a
count of them. Only the increment side exists, since those expressions
still return early and never drop a reference, so __destroy_hist_field()
sees how many references were created rather than how many are left. It
frees when the decremented count is 0 or 1, so two references work and
three or more leak.

Sharing kept one array entry per object, and create_var_ref() searches and
appends within a single trigger, so nothing outside it holds the object.
Removing a trigger whose variables are still referenced is already refused
by check_var_refs() with -EBUSY. Drop the count and free unconditionally.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260906124025.3550596-1-donggeunyoo.kernel@gmail.com
Fixes: 8bcebc77e85f ("tracing: Fix histogram code when expression has same var as value")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9596bb513ad3a..b9641fecb8c5b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -146,7 +146,6 @@ struct hist_field {
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	struct hist_trigger_data	*hist_data;
 	enum hist_field_fn		fn_num;
-	unsigned int			ref;
 	unsigned int			size;
 	unsigned int			offset;
 	unsigned int                    is_signed;
@@ -1629,16 +1628,8 @@ static int contains_operator(char *str)
 	return field_op;
 }
 
-static void get_hist_field(struct hist_field *hist_field)
-{
-	hist_field->ref++;
-}
-
 static void __destroy_hist_field(struct hist_field *hist_field)
 {
-	if (--hist_field->ref > 1)
-		return;
-
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
 
@@ -1685,8 +1676,6 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (!hist_field)
 		return NULL;
 
-	hist_field->ref = 1;
-
 	hist_field->hist_data = hist_data;
 
 	if (flags & HIST_FIELD_FL_EXPR || flags & HIST_FIELD_FL_ALIAS)
@@ -1907,10 +1896,8 @@ static struct hist_field *create_var_ref(struct hist_trigger_data *hist_data,
 	for (i = 0; i < hist_data->n_var_refs; i++) {
 		ref_field = hist_data->var_refs[i];
 		if (ref_field->var.idx == var_field->var.idx &&
-		    ref_field->var.hist_data == var_field->hist_data) {
-			get_hist_field(ref_field);
+		    ref_field->var.hist_data == var_field->hist_data)
 			return ref_field;
-		}
 	}
 	/* Sanity check to avoid out-of-bound write on 'hist_data->var_refs' */
 	if (hist_data->n_var_refs >= TRACING_MAP_VARS_MAX)
@@ -2771,7 +2758,6 @@ static struct hist_field *create_var(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
-	var->ref = 1;
 	var->flags = HIST_FIELD_FL_VAR;
 	var->var.idx = idx;
 	var->var.hist_data = var->hist_data = hist_data;
-- 
2.53.0

