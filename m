Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332606;
	b=4gPsWZJEq7hOROdrDlUkTY+OBqPfhXLTzisjB3Cj6NuaFAbm0n4ZNy021uw5z5ajTyU/
	 YIg01uY270rHNy1k7XNLndHKkCcRKaVzRXod2SFX3cAiDUqzgB8rkKevL9h7BJ6x1Hnid
	 WoiYGmVN6aMz/CboCgsJnzQxGj1ZxyrelyuOZwpFtV9F56wI1FWNwhCpD7EP4qruSN7Gu
	 xJgFJ/OE5Nfw7QYM3uGiwqosbrEqSiCgMbNK8lcHOdss0iaNcjcFsCShYl1oX73YnJg/I
	 tKiYRm/HQzcHc8lvEuOcqbI1WC+cYOlQm0NwjWuDDlVzGJmcqTskB10X4V6CmG7cSiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ej+8xGsvKhmfUS19CpoFncFEZaT5ucU9ZWYsLkBjTig=;
	b=tZ/sTFBNrLDIHNwLAHVEiscxOTQr86Fb+krmPJzZMXA3rNeYisajKXSuj/qh8WjCVPig
	 3R/hpCp8hZMiM+bl2jgVxZtglIqngFTYsqG9RjjDaGna270XeVmpDnckJsv6NZPZ5CxVE
	 NHJ2pvVv2KkUFDD9sLQSexshkJLTCNklJkDxx+2thFjWBvrn7JFG1nnmgZpPEwXErVz2z
	 2grkVdak86Ee1JcqVCt46E7ky62b4TUJD8WFrwzXv4PdIW2T7Z0mTq3gULR5MtVFs3fk4
	 2UIQfqgpLIZ1pCTS7PUzbRnm0GFJFSrZel8rAU0QeisTUaTLvL+SnT3Fdu39YcGtsWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjOhmd2o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70A606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjOhmd2o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689C01F008A2;
	Tue, 10 Nov 2026 17:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332606;
	bh=Ej+8xGsvKhmfUS19CpoFncFEZaT5ucU9ZWYsLkBjTig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GjOhmd2otSWlV/YT7idlOnMg97XZ5QHUJF77CklHIyld51JnQ+DafdBXeUzykmVdZ
	 90lEJpU1aUkQrCHndH0RqdILKWntMGgwyc9UBoIRIPyAyVM+gIZleWAXWldbAjvrvt
	 hivAAyGrrKO7ldYhiYCMjvUhqIlWFE1aTTRJBl97BEK4sNpDQTYW20nYOM8avgmvTd
	 lW93ZAp5UrNlwKJN/xRqimjibaDVGsnhDf26+jnVEcLonmbq4Xikjkhj6FAZGicQ8F
	 +Y89A5ytTfH+3ETZ1YYCrfxny/EngfK1tH4ps1q1h93x1H15OtmWB/vUsClvfLOHe+
	 v9bdAXMlKG7og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] intel_idle: Adjust state names and descriptions for _LPI states
Date: Tue, 10 Nov 2026 12:43:23 -0500
Message-ID: <20261110174312.2985582-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110174312.2985582-1-sashal@kernel.org>
References: <20261107050546-failed-7.3-403524796685@kernel.org>
 <20261110174312.2985582-1-sashal@kernel.org>
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

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 4035247966859152a6523bc041f81cb9905695a5 ]

The value of the _LPI "State Name" field is used as the description of
the given idle state (that is, the value of its "desc" attribute in
sysfs) which is not consistent with idle state descriptions used when
the idle state information comes from an ACPI _CST object.

To rectify that, use the _LPI "State Name" field value as the value of
the "name" sysfs attribute of a given idle state and use the MWAIT hint
value from the _LPI register address value to derive the value of its
"desc" sysfs attribute in analogy with the _CST case.

Fixes: abc5c103c66d ("intel_idle: Add ACPI _LPI support")
Tested-by: Len Brown <len.brown@intel.com>
Cc: 7.3+ <stable@vger.kernel.org> # 7.3+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ rjw: Adjusted scnprintf() format string, tweaked changelog ]
Link: https://patch.msgid.link/6061409.DvuYhMxLoT@rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/pm/intel_idle.rst | 12 +++++++-----
 drivers/idle/intel_idle.c                   |  9 +++++++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
index 996e5bd83c425..d1a6251790b80 100644
--- a/Documentation/admin-guide/pm/intel_idle.rst
+++ b/Documentation/admin-guide/pm/intel_idle.rst
@@ -145,11 +145,13 @@ for the other idle state types (C2 and C3) the target residency value is 3 times
 the exit latency (again, that is because it reflects the target residency to
 exit latency ratio in the majority of cases for the processor models recognized
 by ``intel_idle``).  The name of the idle state (to be returned by the ``name``
-idle state attribute in ``sysfs``) is either "Cx_LPI" (if it comes from ``_LPI``
-processing) or "Cx_ACPI", where x is the index of that idle state in the final
-list (note that the minimum value of x is 1, because 0 is reserved for the
-"polling" state), and its target residency is based on the exit latency value.
-All of the idle states in the final list are enabled by default in this case.
+idle state attribute in ``sysfs``) either is equal to the state name value that
+comes from ``_LPI`` processing (with the possible fallback to "Cx_LPI" if the
+state name is not provided) or it is "Cx_ACPI", where x is the index of that
+idle state in the final list (note that the minimum value of x is 1, because 0
+is reserved for the "polling" state), and its target residency is based on the
+exit latency value.  All of the idle states in the final list are enabled by
+default in this case.
 
 
 .. _intel-idle-initialization:
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c5b65f7d7271c..ec951c148d4a2 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1905,8 +1905,13 @@ static void __init intel_idle_init_cstates_acpi_lpi(struct cpuidle_driver *drv)
 
 		state = &drv->states[drv->state_count++];
 
-		scnprintf(state->name, CPUIDLE_NAME_LEN, "C%d_LPI", index + 1);
-		strscpy(state->desc, lpi_state->desc);
+		if (strlen(lpi_state->desc) > 0)
+			strscpy(state->name, lpi_state->desc);
+		else
+			scnprintf(state->name, CPUIDLE_NAME_LEN, "C%d_LPI", index + 1);
+
+		scnprintf(state->desc, CPUIDLE_DESC_LEN, "ACPI LPI MWAIT 0x%02llx",
+			  lpi_state->address);
 		state->exit_latency = lpi_state->wake_latency;
 		state->target_residency = lpi_state->min_residency;
 		state->flags = MWAIT2flg(lpi_state->address);
-- 
2.53.0

