Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045948;
	b=0OYwWGSnIZzmsyZobFF82kAi1AjpVTyAL+2Oec5siRHfifE/SFDF0MU22ylsJ3+duecc
	 frHCkXNxdNPP00srcVi2L9VOISBeD2CfZc9CnBI4iMPXeYIqTKOxl5pWPAZWao9DREXsP
	 TnyjJFRaGR/DXiOQwVZpsXrJwm/dlu8ElRdCj/LLxQzQ/pHiQHFlOgGIQhD3n2tuXZBRh
	 k/Y7NkN0srJuduJoaCkCBoiT+D/Vh45FPEpHk7vzcynFe0cAi3wV0CIgUU0sseZuG6nJo
	 Xk6ALH64O8+QssqzTPj+1eqWuxYZiCG6UcOzxORMJW5Tvcq5n4WolY/2ajdNikLco9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045948;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vi4yLzJbnSE2mouNBSs3TZmVINJwKqFPAnLshbppfV4=;
	b=hkPdFgxajKiJZ+aFl5u/wEDGuJq6Xo4LjUqdVlVEuF2ZNfBkfLeajBtlSHnTTZyBTARH
	 9IGhuMOnvy86lIY706w4SMojq2go+yKt/USOwT0Q/RDSJfAyeZDwdEMGPZmCUVpKgvhiM
	 wnUJd5DHCx+AXc9tc/m4k7Oz5VJ5UCVLtvFpoxudd0XjS5lwmhBBSjl8hQQxieyFPhEKi
	 Fx+SMwxa4rudIGiQjm0U7SzABhX/uHBtvwJYqQ1rhNJimT9+csSK+4BVKJfg2rfUPN+xE
	 OPlNpjY00SS9W0hvERZDcmmX2X/d/3okePDmaGuwHurRe/1SfyPTtRZre1TbIDCMiRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Iutzp9x/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B2606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iutzp9x/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C451F008A1;
	Sat,  7 Nov 2026 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045947;
	bh=vi4yLzJbnSE2mouNBSs3TZmVINJwKqFPAnLshbppfV4=;
	h=From:To:Cc:Subject:Date;
	b=Iutzp9x/gKyuOATGpJjGh2gZaGxlHL44dn1+QBcBmNCa77uijUzdGNLsxTuYqvH+1
	 8DR/xqFAvBTPoN6DMCI2MGdEI+QuEDNo18ekGkb8/DffgeLS3r39x18fzGavawgjP5
	 vWlkw+UEGSzqiVFY2biAvbXg4ajaASPP+SCsj7Az7p3H90xyoaSMpWCuZqQ3HsXCZQ
	 qi0Mp/OuByEIaOg3XERyGs31tnDcanh3bpm5+TMxF9mZQ329jtsL8C7j3IC5TAuJnx
	 qmd/nK+gQC6P2B1L88cPhtOL66eoItnzqla9hBf4oVSgEbEbkvrFCPRwmujztuHPwo
	 fiD4VCT0uvNOA==
From: Sasha Levin <sashal@kernel.org>
To: rafael.j.wysocki@intel.com,
	len.brown@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] intel_idle: Adjust state names and descriptions for _LPI states" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:46 -0500
Message-ID: <20261107050546-failed-7.3-403524796685@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 4035247966859152a6523bc041f81cb9905695a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050546-failed-7.3-403524796685@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4035247966859152a6523bc041f81cb9905695a5 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 21 Oct 2026 17:56:08 +0200
Subject: [PATCH] intel_idle: Adjust state names and descriptions for _LPI
 states

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
index a045a384b949d..9f5e1c47aba29 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1903,8 +1903,13 @@ static void __init intel_idle_init_cstates_acpi_lpi(struct cpuidle_driver *drv)
 
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




