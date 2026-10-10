Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1634104E
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666183; cv=none; b=NoXIp8l+oU1H39ZqvJuqntadzRXOGlsJnR/kgUDCY0c0r731U96Wcux/h0bTBc7XjgSvTJ4Zt8yu0aT7+IgGfdmnIjQGw9TMLz+0nKuZXUrSFgQtPJrttG+eyraKbIQiQ0NFP4/goKgIQh83SftPuF0/SWT7GGRkU+vGvbBkkWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666183; c=relaxed/simple;
	bh=wDwpMO5bfAe2juj7XnYLO+oUSR0JSDrrz7wnSP6mO6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hXgbl6pS6q4Xd3AQwcZZUopw578v2kzRxUOT/eozh+06f2BdpAvBhaZgD00c544xj0GMcTQBizLEOP9eDmzA6lHfnQBMm/aDXIA6HvOrZgR6//4MQza93vPEWxNTSrPq/rbLYlx3rBLgCWsLmL6g11w43S7ufPyL7w+UwOmx8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=FRlis76N; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="FRlis76N"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e515769d3so65146085a.3
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791666180; x=1792270980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PH2ZNztxpOnnAOmdxAya78mHgVtF5bOllPXI+YQjWm4=;
        b=FRlis76NAmqidXFhAi68DEp0YJeNUVyZ5Bbn/h9AGOKCfTAjpLA9AVChTjhSN4fV+m
         rAvNX22RYXCMHvR0zmShljjhB7kZBXbBTSi4Ayv+151IAvojiiSjJGFr9ntxJoPJPWAE
         pWc+L2JBMhgm+FKZDko8ptpGuQtJBu73unjH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791666180; x=1792270980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PH2ZNztxpOnnAOmdxAya78mHgVtF5bOllPXI+YQjWm4=;
        b=ivG0uWIuvCemQpiBJOuy9VTxvwuxmPN+/1sX2nlsQcePe4Kp8Ncu7XoFBNKNyyuPeJ
         VWo3nEtpUHM1wISdqn5yyPqzFZjTmxBoWbLg0vPPcaNwSeJCEnS96Mgvhg0EdQWM2sOI
         1EZsOcqfXtVObBoUcRcm+7Dxg2Aj1Gebhcdiny23LxLSd95t64cblIQNZL//n/n3rZfF
         z52TaTi7l/wXYesz7Zo8QzqzoAmwvTZuZjZpu2vzvxFhW6yVlFpwALOeYrFmk9rJv0An
         74bszbQ2TYVKwn6Ikbh+Vrg6zmipesW+U/q4ijC3QQhQ5Pkrmid1zDwO2Baonyd1hMbM
         7KpA==
X-Forwarded-Encrypted: i=1; AKwUvBxUwrmVNsa4964WVtU05eE6IEst1mcgA5XWAqwU2iY3SW73R0fmvMU4XqEnx4AfRHeuNsQP+DA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnhEefcH+fEdxQIbEwuQbqDc9NEksHWGzAazWHkHrS9dbQ1xJR
	DF6oVcW9yJ6HKDFT+6dlzGW78ohq9U4OYv02RyQ/5r0U/OpGsPOrl2HsNd8rx0Xg3w==
X-Gm-Gg: AYBFou0y17HkcPVI6FWM8UqFVw8F0pqk0C+tV+wPL+5vBeD9iL/XHNa8rHdsbMOvH3J
	0ltVfKiLsBCfXY2ZCACRirkJXKuUdIvSS+haHt7/mHgfAqmbpgqcxU33im+40ZdqTcin2Q0O7sd
	7W8K4PP9ZsFz4pwbGUT9Z+EtsurxMiRgKLD0syxr9WCZOhcxFc9XYmxN52+uwCqEAzAWPFIDviC
	wKv1lA2JlgSEpvqqPrI1RNVXN2fxpDpSeQBlrQ39mOYElctQZ8z7a0ie+T/ekGBRniPgI8G3uSg
	JQKNY04iTtYHcjXCoct7xatF6L3gkTPZN6FdT5JrDkG73bV1A4ZQh7vmBToe+15qZRHrX645ZMC
	wWqbC7YMaHvziUj4vx82jnZBvA5g2dRXjfs8MZW6btV5f6LLL04Mi5MZshbhbaYVaEruJshAoKF
	19MlQHiPdbfMpt2rPnnJQV0AdzBxBM/ykSyBoy0rTG/mNMREoh4oSVXzeSUc9bNd8sFyA4Cw9C9
	Z0dq3C2V7WcU2wxp5kWySmfy9kFlr28C0PNUGuv7z/3
X-Received: by 2002:a05:620a:44c1:b0:93e:6e59:ad16 with SMTP id af79cd13be357-93ebd1dfd74mr921864985a.29.1791666179722;
        Sat, 10 Oct 2026 14:02:59 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984845csm498538085a.14.2026.10.10.14.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:02:58 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	martin.lau@kernel.org,
	daniel@iogearbox.net,
	horms@kernel.org,
	qmo@kernel.org,
	bpf@vger.kernel.org,
	jiri@resnulli.us,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	victor@mojatatu.com
Subject: [PATCH net v2 1/3] netdevsim: reject cls_bpf programs bound to another device
Date: Sat, 10 Oct 2026 17:02:48 -0400
Message-Id: <QDISC-PYC7.v2.20261010165947-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
References: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue:
nsim_bpf_setup_tc_block_cb() installs any device-bound SCHED_CLS program
without checking that its offload device matches the target netdev.  The
core cls_bpf attach path rejects a mismatching program, but a netdev that
joins a shared block later is replayed the stored filter by
cls_bpf_reoffload() before it is inserted into block->ports, so the
attach-time check cannot see it.  The driver callback is the
authoritative per-device acceptance boundary and must enforce the match
itself, as nfp already does in nfp_net_bpf_offload().

Without the check, replaying a device-bound program onto a different
bpf_offload_dev installs it into that device's netdevsim state, which
trips the WARN in nsim_bpf_uninit() (ns->bpf_offloaded set on a foreign
device) and can dereference a NULL prog->aux->offload in
nsim_prog_set_loaded().

The Fix:
Reject a device-bound program whose offload device does not match the
target netdev, with -EINVAL and an extack so the rejected replay is not
silent.  The check is intentionally narrower than nfp's: it fires only
for a dev-bound program, so nsim's bpf_tc_non_bound_accept mode (which
admits an unbound program onto the device) is unaffected.  Teardown is
never blocked: the guard is on the program being installed and an unbind
passes cls_bpf.prog = NULL.

Conditions to recreate the bug:
  - CONFIG_NETDEVSIM=y, CONFIG_NET_CLS_BPF=y
  - load and pin a dev-bound SCHED_CLS program for netdevsim device B
  - install the program on a shared block owned by B
  - add an independently backed netdevsim device C to that block; the
    bind replays the filter to C's callback, and C's
    ports/0/bpf_offloaded_id takes the B-bound program id.

The reported Sashiko review is at
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809094418.901607-1-jhs@mojatatu.com

Fixes: 31d3ad832948 ("netdevsim: add bpf offload support")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu.com/
Link: https://lore.kernel.org/netdev/QDISC-PYC7.v1.20261003103747@mojatatu.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2 (v2 of an on-list patch; v1 posted 2026-10-04):

- Finding (nipa Sashiko High, v1) -- FIXED: the
  every-member predicate is enforced only at add/replace, but a netdev
  joining a shared block later is replayed the stored filter by
  cls_bpf_reoffload() before it is inserted into block->ports
  (tcf_block_offload_bind precedes the xa_insert).  Neither
  cls_bpf_reoffload() nor nsim_bpf_setup_tc_block_cb() checked
  bpf_offload_dev_match(), so the B-bound program was installed on the
  joining device (re-opening the 120977e2c096 mixed-block defect).
  Fixed by enforcing the device match in nsim_bpf_setup_tc_block_cb()
  (drivers/net/netdevsim/bpf.c), mirroring nfp.
- Style (gemini + nipa Low) -- FIXED: the shared-block comment opens with
  /* on its own line.
- The companion selftest exercises shared-block and late-join coverage,
  pinning both the all-members predicate and this callback's replay gate.
- Split the single v2 draft into [PATCH net v2 1/3] netdevsim,
  2/3 cls_bpf and 3/3 selftests, each with its own Fixes: and stable
  metadata.
---
 drivers/net/netdevsim/bpf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index 16aa88278398..a73ea8b07682 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -144,6 +144,18 @@ int nsim_bpf_setup_tc_block_cb(enum tc_setup_type type,
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * A dev-bound program can be replayed here when a netdev joins a
+	 * shared block, after the core attach-time check has run; enforce
+	 * the device match as nfp does.
+	 */
+	if (prog && bpf_prog_is_dev_bound(prog->aux) &&
+	    !bpf_offload_dev_match(prog, ns->netdev)) {
+		NSIM_EA(cls_bpf->common.extack,
+			"program bound to a different device");
+		return -EINVAL;
+	}
+
 	if (cls_bpf->command != TC_CLSBPF_OFFLOAD)
 		return -EOPNOTSUPP;
 
-- 
2.43.0

