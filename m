Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8086391836
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976565; cv=none; b=nvQPiItYugDfM7DsECH/wRBngbBi13nIjjMGIBpNSiouHCR/r/Qf0qhAWnUsrbrnG62mAldqRWZrP2CBDHd+69CDBW5z79JXJoGNcs1Cv5K4sbZVP47aTKOqT2lxbNelpjQV2WKu1BfCwsc2uoe2t4rBGhTfyEdSRCcU+nISUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976565; c=relaxed/simple;
	bh=T5ljY0ZtuEw0vDQdvMx2gghbk55TDTHOMDgOdsNpcDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkA1+VPYn0fqYYdFkzZXsgtKozeiuBe+akQOB8jfLnn0sY9ojZ5wrmrFKs8dbp3Y81n3FlYKBr2PBK9cSViQn7m4rB2XKtwKKSMNaX76DFFKwYoL3tRVA64Zu4bwwRLT5IzWlVzE/mAnBZ/hrW7sv50upD92BJq7tE1f2MWxquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkN0S/qx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkN0S/qx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444B41F00898;
	Wed,  9 Sep 2026 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976563;
	bh=3+oDdZgM7DH5bDZ9jBP87wH3aRMUbghGiVujjfyVOqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jkN0S/qxwGBMdovY/YtHTgw1nRoJnh+fKqqWtS6k4NuCeBP+vrYjeItdN3+fLucXL
	 eOVyMdltBTCgpFp2aByiANLgm5Xd+zj8b+O7U5nPVkOkKZZJ5S+4fV74GyzqMJ3gy2
	 Fy8+JAsC89eGp77BRRrKaNAm3TCVTJooyWB72b7WbOBdxm5BSNWnObyd9xwh1UGilp
	 Frt2yrWInocHwN+2gO6tOdTS3P1rdu5MU+qD9av95RhatWh/M3DQgmWtTWSo/qPd/f
	 lbCGx18VC38p6+HSpB/y53ks/+huoChlx4YVDVgvvf2zNjCzssLznlaUdjRbDzzReM
	 ypFZrUA4BfiEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] [AUTOMATED CONFLICT RESOLUTION] Documentation for 1cb9663789c5b7a12fcd419fcca6d6254c398252
Date: Wed,  9 Sep 2026 13:55:59 -0400
Message-ID: <20260909175559.3436094-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909175559.3436094-1-sashal@kernel.org>
References: <2026090334-visor-renewed-f29f@gregkh>
 <20260909175559.3436094-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit documents the automated conflict resolution performed by codex
for upstream commit 1cb9663789c5b7a12fcd419fcca6d6254c398252.

codex's resolution process:
================================================================================
Resolved and committed as **`12b10225f2d26`** — `net: ravb: serialize PTP clock teardown`.

The conflicts came from upstream driver infrastructure absent in Linux 5.10:

- **IRQ handling:** This branch has no separate error/management IRQs or `ravb_setup_irqs()`. Both PTP interrupt paths use `ndev->irq`, so synchronizing that IRQ covers them. The newer IRQ fields and setup changes were unnecessary.
- **Helper functions:** Kept interrupt disabling and synchronization inside the existing `ravb_ptp_stop()`. No functions were added.
- **Clock-index prerequisite:** Backported upstream `1f77af0aaf27` as **`f9b9c59b95a72`**, with minor context adjustments. It caches the PHC index and handles registration errors, preventing ethtool from dereferencing the clock pointer after teardown clears it.

The teardown preserves upstream’s sequence: atomically detach the clock, disable PTP interrupts, wait for existing handlers, then unregister the saved clock. Later handlers see `NULL` and skip clock events. The teardown commit itself changes one file, with 11 insertions and 6 deletions.

Both commits retain their **exact original messages, authors, and author dates**. No custom fixup commits were created.

After committing, I ran **`stable build log` and waited for completion**. Both x86_64 and arm64 builds passed with **zero warnings and errors**. The working tree is clean.

[Build log](/home/sasha/tmp/stable-parse-fail-5.10-1788974275-build.log)
================================================================================

Backport verification analysis (via codex):
================================================================================
**The backport is correct for this branch. I found no code defects introduced by the conflict resolution and would accept `107f357e539c9f6787ec17d543d74b4d65e5fb4a` together with its prerequisite, `f9b9c59b95a72`.** The omitted IRQ changes are justified by the older driver’s actual interrupt wiring.

I compared the committed sources, inspected every caller of `ravb_ptp_interrupt()` and `ravb_ptp_stop()`, checked the prerequisite against upstream, and reviewed the supplied build log. There are a few documentation and validation qualifications described below.

The upstream fix’s lifetime protection is preserved completely. The backport’s [teardown implementation](/home/sasha/tmp/stable-parse-fail-5.10-1788974275/drivers/net/ethernet/renesas/ravb_ptp.c:358) performs these operations in order:

1. Set the cached PHC index to `-1`.
2. Atomically replace `priv->ptp.clock` with `NULL`, retaining the previous pointer locally.
3. Disable PTP interrupts and clear their status using the existing `GIC` and `GIS` writes.
4. Wait for handlers on `ndev->irq` to finish.
5. Unregister the saved clock, if present.

That sequence closes both sides of the reported race. A handler that already obtained the old pointer finishes before unregistration can free the clock. A later handler obtains `NULL` and skips `ptp_clock_event()`.

The [interrupt handler](/home/sasha/tmp/stable-parse-fail-5.10-1788974275/drivers/net/ethernet/renesas/ravb_ptp.c:304) reads the pointer once with `READ_ONCE()`, checks that local value, and passes that same value to `ptp_clock_event()`. This avoids checking one pointer value and subsequently using another. Initialization publishes the pointer with `WRITE_ONCE()`.

The synchronization is essential: `READ_ONCE()`, `WRITE_ONCE()`, and pointer detachment alone would not protect a handler that had already captured the old pointer. The backport includes the required wait before unregistration.

I also compared the resulting function bodies mechanically: `ravb_ptp_interrupt()` and `ravb_ptp_init()` are identical to upstream. After expanding upstream’s two helpers and removing the unsupported additional IRQ branch, `ravb_ptp_stop()` is equivalent apart from whitespace.

The differences shown by the comparison script are justified as follows:

| Difference | Assessment |
|---|---|
| Omission of `err_irq` and `mgmt_irq` fields | Correct. This branch has no separately registered error/management IRQs that need these fields. |
| Omission of changes to `ravb_setup_irqs()` | Correct. This branch requests interrupts through `ravb_open()` and `ravb_hook_irq()` instead. |
| Synchronizing only `ndev->irq` | Sufficient for every current caller of `ravb_ptp_interrupt()` in this tree. |
| Keeping disabling and synchronization inside `ravb_ptp_stop()` | Behaviorally equivalent. The upstream helpers do not provide additional locking or lifetime protection themselves. |
| Separate PHC-index prerequisite | Appropriate and necessary to preserve safe handling of clock availability and registration failures. |

The IRQ conclusion is supported by both the handler bodies and their [registration sites](/home/sasha/tmp/stable-parse-fail-5.10-1788974275/drivers/net/ethernet/renesas/ravb_main.c:1334):

| Driver path | Handler that invokes PTP processing | Registered IRQ |
|---|---|---|
| R-Car Gen2 | `ravb_interrupt()` | `ndev->irq`, requested with `IRQF_SHARED` |
| R-Car Gen3 | `ravb_multi_interrupt()` | `ndev->irq`, obtained from the `"ch22"` resource |

These are the only two callers of `ravb_ptp_interrupt()`. The separately registered E-MAC and RX/TX queue handlers do not invoke it or access the PTP clock pointer. Upstream additionally registers `ravb_multi_interrupt()` on `"err_a"` and `"mgmt_a"` for hardware supporting that arrangement; this older branch does not.

Therefore, the backport synchronizes **all relevant IRQ handlers**, despite synchronizing fewer IRQ numbers than upstream. Adding unused fields would not improve coverage.

The prerequisite was also resolved correctly. Comparing `f9b9c59b95a72` against upstream `1f77af0aaf27`, the added and removed lines match after accounting for indentation; the surrounding older-driver context explains the differences.

Its effects are preserved:

- The cached `phc_index` starts at `-1`.
- Successful registration publishes the clock’s index.
- Registration errors are logged and normalized to `NULL`.
- Teardown resets the index to `-1`.
- [The ethtool query](/home/sasha/tmp/stable-parse-fail-5.10-1788974275/drivers/net/ethernet/renesas/ravb_main.c:1256) reads the cached index without dereferencing the clock.
- Existing timestamping capability flags remain unchanged.

This prerequisite matters because clearing the clock pointer would otherwise leave ethtool’s old `ptp_clock_index(priv->ptp.clock)` call unsafe. Error normalization also ensures that teardown cannot treat an `ERR_PTR()` as a successfully registered clock. The configuration where PTP registration returns `NULL` is handled correctly too.

I checked the main potential failure modes introduced by adding an IRQ wait:

- **Deadlock or invalid calling context:** The direct teardown callers cover ring reconfiguration, open-error cleanup, timeout recovery, interface close, probe-error cleanup, and removal. None holds `priv->lock` around `ravb_ptp_stop()`. Timeout recovery calls it from workqueue context. This satisfies the relevant requirement that `synchronize_irq()` may sleep and must not run while holding a resource needed by the handler. Both the [local implementation](/home/sasha/tmp/stable-parse-fail-5.10-1788974275/kernel/irq/manage.c:112) and [Linux 5.10 IRQ documentation](https://www.kernel.org/doc/html/v5.10/core-api/genericirq.html#c.synchronize_irq) establish that requirement.
- **Dependence on later IRQ release:** In close and open-error cleanup, `free_irq()` occurs after PTP teardown. Previously, that later synchronization could not protect a clock already unregistered. The new wait is placed before unregistration, where it is needed.
- **Different Gen2/Gen3 clock lifecycles:** Gen2 registers its clock during open; Gen3 registers during probe and unregisters during removal or probe cleanup. The backport retains those lifecycles. `ndev->irq` is assigned before either initialization path.
- **Missing pointer consumers:** The remaining clock-pointer accesses are the interrupt snapshot, initialization publication, and teardown exchange. Etthool no longer dereferences it.
- **Changes to other PTP interrupt behavior:** The null check guards external timestamp event delivery. Periodic-output processing and interrupt acknowledgement remain unchanged, matching upstream.
- **Repeated teardown:** After detachment, a subsequent teardown obtains `NULL` and skips unregistration, preventing another unregister of the saved pointer. This does not make arbitrary concurrent initialization and teardown safe; the fix retains the driver’s existing lifecycle assumptions.

I found no missing dependency or additional code adjustment required for this fix.

The available validation supports compilation success, with limits. `git diff --check HEAD~2 HEAD` passed. The supplied [build log](/home/sasha/tmp/stable-parse-fail-5.10-1788974275-build.log:5) reports successful x86_64 and arm64 builds with `rc=0` and `W=0`. I reviewed that existing log; I did not rerun those builds or perform hardware testing. The abbreviated log does not include configurations or compilation commands, so it does not independently establish whether `CONFIG_RAVB` was enabled in each build. It also cannot demonstrate the runtime race fix. External timestamp activity during repeated Gen2 open/close and Gen3 removal would provide useful additional runtime coverage.

For the historical record, three details in the conflict-resolution report need qualification:

- **Commit identity:** The report names `12b10225f2d26`, whereas current HEAD is `107f357e539c9`. Both commits have the same parent and identical Git tree IDs. The hash discrepancy therefore reflects metadata changes, not different source code.
- **“Exact original messages”:** Both backports preserve upstream authors and author dates. The prerequisite preserves its original message exactly. Current HEAD adds the upstream-commit reference and Sasha Levin’s sign-off, so its message is no longer byte-for-byte identical to upstream. Those additions do not affect correctness.
- **“Working tree is clean”:** Tracked files and the index are unchanged, but the current checkout contains an untracked `tmp.cmt`. That does not affect the committed backport; the clean-tree statement does not describe the current checkout exactly.

The implementation is minimal, preserves upstream’s protection against the reported use-after-free, and adapts the IRQ synchronization correctly to this branch. No code revision is warranted by this review.
================================================================================

This is an empty commit for documentation purposes only.
-- 
2.53.0

