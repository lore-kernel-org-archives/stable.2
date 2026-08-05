Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8F73D566D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961872; cv=none; b=IuzJXtIeG8A7uePmTaZws+h/SlUSov8U8YM+xIfDJPWItnIZuY0oz6jcuZ2zXvC6MD6903D3+VHuNBnmnGPzVX+ot6J4e+GdkIzCY+1jHMA0SSssJDyHlNVX56wPt884pjoGj1smt61Py3wQWuPyNIQyIG3Vk/ljFy2icoMSM1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961872; c=relaxed/simple;
	bh=wrr4/D+OKqTYgZgpPyBQ9CQH9d1XPFS5Uj1KLAWTDd8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MtBiPqaqJTt1XFnMnYlZqnry+qGXDFIG6ccKpKx8EwQgdNWao9FOkLzIiQ5c7rhWb4+LTVXtP4IqwahEj5OI21AOJdNvhNKHxVBx1mNN2R2z1VQQytwb6oHXLB++vmGJv99gm9dy7ykGsh7ZfNLD2mt+S/4D9tAk1F4U+sKX0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=VU5ZNMjN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="VU5ZNMjN"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso1034818a12.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1785961869; x=1786566669; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BnBbz+tc05lB5jEMyqvjakg3EaNmYx6MvuBMmxBy/t0=;
        b=VU5ZNMjN0BHs+tnZicsMJoM7zhs2i0nW5l2aQPK4TdBZFZmeXPNMzJdg2gUubFOg24
         YcyxQI0/LAler0hmZZ8Wo859sFVBFSvFvkadEzxP980Ya6dRkZ0gYOdjlnlXnCz/++HL
         SNo2jLcVczdjy/lbayPMvT2KKl9RdZusyd2j9vFEwLPqVkG1QwMAfUzZM0sppYAU/HVF
         bc+tRNR8MmnFfxwoVG+q8ZLY7A2G93Vo76c/96+LapxcU2rgtyrnZlk2/mvFkRLflz20
         azi9j4AExRGrUR73zfj+wKKS0eQGP8lZVNhGZSP0bqDCI0u6RFCHkvqINAdsjv1FmQG6
         voJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785961869; x=1786566669;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BnBbz+tc05lB5jEMyqvjakg3EaNmYx6MvuBMmxBy/t0=;
        b=tOok0ycjtWfa+3hv+fBc1bjAyQCwo4o88TOO5xptaDS//1xxN22OQoeBJKooD90WcM
         1Uud1ubQd5x7SujdC+Do48R1QE5x93bcyBnZyW84zdJcwk/kCwfIGXPmq6z1HS/61poB
         eYuRCwSLF5jvCMD2eiHumEMleeugUuKRLaypmdSvmKwM8ubTyoL5H4uMayAPDWV7HNnr
         DfhnpgEm30vlwAkf+FIRbtLxuNVVjJ+JvrbbbtEUh0Y8UoPF8JzlkcqE8ErFrjQkT/xU
         oiw9lO4csyyAsNuGB32FgYHPRUHeL67vM8TJzQZ+P0JoQOfL3emGV4J5HaJiAfUThEBY
         JF/w==
X-Forwarded-Encrypted: i=1; AHgh+RpZI1PAxZzSnbG53g8khKg86Ss4yYXp3t2QWOb9ze00Y6nhAw0sSsaFNzfmsUOsewdg+CfOggA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyncWtm81Pln18zubsF5xCiNuKkAb07S8OzoyyUjYhn65JCprdx
	adlf+N19Gb2azITyaI52WIfgUpzECSOb0t+hvKymWo5dBZEk1LFp0i8v3DKdthk4RT0=
X-Gm-Gg: AR+sD10us/q4BzQ0BOw7I4xF7kAEK9MsQo4JEQSVfBaWlDO6rCnAoPnqS5zaDy59rkJ
	w3jzkEeG4xVL/xvLsNthCsLLicVY+yBu5h2PLYnF/RbcyLQwTb7n5x8JoLK+p9+sMJ3b+pBFOJF
	pqqqxNPL4PKVJJ9l8AyY9QMAJNyD+BlMVW+ZiAtCGya8uKS0hjKA927pLtWWBwMVA52VjvnoAhg
	Ks/TGJuIOBG9b+RrrfsNvnmK6jJWPyIXmxJEshT9ffM2AmpXfa6XUTwsTWwgJTQeiYEcDVfJ1O5
	G2F2iNSgv787TGF0e+RZET6l4zr1rhPGCUloinZW4g771e5OBw2jK6s7XglbSvFw2IYMEMlL70E
	+AhrVte/XWzUNyDQ/lczv8W5o8N8KJtip3lZvBizamABREY6xny493NdWDb41QjfMAbM5hnuzon
	ku6VEA+lMm59yeSn696a+KNOmvGaXSILMZrRP8tQySMzQt6UoZ+B09mVHcqhhUONE=
X-Received: by 2002:a05:6a21:e58b:b0:3a3:a9c4:3d60 with SMTP id adf61e73a8af0-3cb85f5c2b0mr11887982637.27.1785961868030;
        Wed, 05 Aug 2026 13:31:08 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca63ce12sm20694924c88.5.2026.08.05.13.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:31:07 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH v6 00/10] of: teach overlay code to keep /aliases in sync
Date: Wed, 05 Aug 2026 13:30:59 -0700
Message-Id: <20260805-nh-of-alias-overlay-v6-0-74f21d440819@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43PzW4CIRQF4FcxrEsDV2Bmuup7GBf8XDo0ZjAwE
 o2ZdxesC42z6PIk534n90oypoCZfG2uJGEJOcSpBvWxIXbU0w/S4GomwECxjg90Gmn0VB+CzjQ
 WTAd9oQolMicVcDCkXh4T+nC+q7v9X84n84t2blRrjCHPMV3us4W33mMB2OpC4ZRR6JxWveid6
 8X3hOd5jMdPHUibKNtnhK8j24p0jHEGvUfw8g0RzwisI6Ii3g5KC+agU/wNkf9AZHtHGwRjBuu
 MfUGWZbkBYC5ptZgBAAA=
X-Change-ID: 20260719-nh-of-alias-overlay-6e5e0d56212b
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Shawn Guo <shawn.guo@linaro.org>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, stable@vger.kernel.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785961866; l=24252;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=wrr4/D+OKqTYgZgpPyBQ9CQH9d1XPFS5Uj1KLAWTDd8=;
 b=DiA8mFbrc1Li8Pw7kqi+fSJeTuFtZGIuqcoY8anqZC5hT9nYaz4dTBdSJs9E1wZdpSJQzAWB9
 5tICkL66zHwDjcSsQPishsAdTa9Kp10SxaOnHI74OPo0PFemIArkzSA
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

/aliases entries added by a device-tree overlay are stored in the live
tree but never enter the global aliases_lookup list that of_alias_scan()
builds at boot. As a result, of_alias_get_id() returns -ENODEV for
aliases declared inside overlays, and any driver that relies on
alias-based numbering (i2c-xiic, spi, tty, mmc, ...) silently loses its
pinned id and falls back to auto-assignment.

The gap has been public since 2015 [1] and reproduces trivially: apply
an overlay that declares e.g. `i2c99 = &foo;`, ask
of_alias_get_id(foo, "i2c") -> -ENODEV. Bootlin's ELCE 2025 talk on
PCI DT overlays [2] enumerates "i2c muxes" as one of the subsystems
broken by dynamic overlays; alias pinning is the underlying cause.

The core fix (patch 3) is a reconfig notifier that mirrors /aliases
property changes into aliases_lookup. Patch 1 is a standalone fix for
an out-of-bounds read in the existing stem parser. Patch 2 prepares
the alias path lookup for /aliases becoming dynamic. Patches 4, 8 and
9 are the overlay-code changes the use case needs; patches 5-7 fix
pre-existing bugs on paths the series exercises. Patch 10 adds a
unittest.

Prior art
---------

Geert Uytterhoeven posted a 3-patch RFC in June 2015 [1] with the same
alias-tracking design shape. Grant Likely reviewed positively; merge
was gated on missing unittests and an object-lifetime concern the
author self-flagged, and the series was never reposted as non-RFC. Ten
years later, drivers/of/overlay.c still contains zero references to
aliases, of_alias_scan, or aliases_lookup.

Series contents
---------------

Patch 1 fixes a one-byte out-of-bounds read in of_alias_scan()'s stem
parser (bound checked after the read since 2011); split out from the
notifier patch on Geert's request.

Patch 2 makes of_find_node_opts_by_path() hold a reference on
of_aliases across the alias walk (the walk itself stays lock-free;
devtree_lock covers only the pointer load, pairing with patch 3's
detach path) and validates alias values before dereferencing them.

Patch 3 adds a reconfig notifier that mirrors /aliases property
changes into aliases_lookup. It also refactors of_alias_scan()'s
per-property body into a helper of_alias_create() shared by the
boot-time scan and the runtime notifier. A one-bit `owned` flag on
struct alias_prop distinguishes kmalloc'd (overlay-time) entries
(kstrdup'd alias name, of_node_get'd target) from memblock-backed
(boot-time) ones so the remove path can't kfree the wrong storage.
The notifier keys off structural properties of the target node
(name + root-parent) rather than the of_aliases global, so overlays
that create /aliases from scratch on a system without a boot-time
aliases node are covered too. All aliases_lookup readers and writers
serialize on a dedicated aliases_mutex.

Patch 4 fixes find_target() so an overlay applied with a non-NULL
target base can still reach the DT root via target-path="/foo". The
current code unconditionally concatenates base + target-path via
"%pOF%s", so target-path="/aliases" resolves to "<base>/aliases" and
target-path="/" produces "<base>/" (never a valid node). After this
patch, an empty target-path continues to mean "the target base
itself" — preserving the shape used by drivers/misc/lan966x_pci.c,
the only in-tree caller of of_overlay_fdt_apply() that passes a
non-NULL base — while any non-empty target-path is looked up
absolutely.

Patch 5 fixes a pre-existing double-free in add_changeset_property():
a property freed on the of_changeset_add_property() error path stayed
linked in the target node's deadprops list and was freed again at
node release.

Patch 6 fixes a pre-existing NULL dereference in
of_overlay_fdt_apply()'s idr_alloc() error path (negative id stored,
list_del() on an uninitialized list head) by only treating a positive
id as registered in free_overlay_changeset().

Patch 7 fixes pre-existing "//" result paths from
dup_and_fixup_symbol_prop() when a fragment targets the root node.

Patch 8 converts dup_and_fixup_symbol_prop() to return ERR_PTR so
callers can tell malformed values, not-overlay-internal paths, and
allocation failures apart — /__symbols__ errors stop being reported
as -ENOMEM regardless of cause — and makes it verify the value
actually descends through the matched fragment's __overlay__ node
before slicing, instead of cutting at an assumed prefix length.

Patch 9 rewrites /aliases property values from the overlay's internal
fragment path ("/<fragment>/__overlay__/...") to the live-tree path
that the node will occupy after apply. The overlay code already does
this for /__symbols__ via dup_and_fixup_symbol_prop(); /aliases uses
the same textual convention and can reuse the same helper. Without
this, patch 3's notifier receives paths that never resolve in the
live tree, so of_alias_get_id() still returns -ENODEV. Values that
don't resolve inside the overlay (legacy string aliases, malformed
junk) are copied verbatim and stay inert — consumers validate before
dereferencing — so no overlay that applied before this series stops
applying.

Patch 10 adds a unittest — overlay_alias.dtso plus
of_unittest_overlay_alias() — that applies an overlay with a
non-NULL target_base, declaring a labeled node under the base and an
`testcase-alias99 = &that-label` entry in DT-root /aliases, then
asserts of_alias_get_id() on the grafted node returns 99 after the
apply and of_alias_get_highest_id() reports the stem gone after the
revert. Missing any one of the three functional patches (notifier /
absolute-target-paths / alias path rewrite) causes the assertion to
fail.

Changes in v6
-------------

Addresses Geert's review of v5 and two automated-review findings the
list replies already acknowledged:

New patch 1 (Geert):
  - The out-of-bounds read fix in the stem parser is split out of the
    notifier patch as a standalone, backportable fix.

Patch 2:
  - Corrected the lock-free-walk description: a racing walk can see a
    stale view (a removed property's ->next points into deadprops);
    what the node reference guarantees is that nothing reachable is
    freed. The code is unchanged.

Patch 6 (Geert):
  - The guard moved into free_overlay_changeset(): only a
    strict-positive id is treated as registered, replacing the
    ovcs->id reset at the error site. (A plain "goto out_unlock"
    would leak the ovcs allocation; free_overlay_changeset() is safe
    to call on a partially initialized ovcs.)

Patch 7 (was patch 6):
  - Keep the "/" target path when the rewritten value names the
    fragment root itself; dropping it unconditionally produced an
    empty string for that case.

Link to v5: https://patch.msgid.link/20260722-nh-of-alias-overlay-v5-0-2abe2bb9cdbc@nexthop.ai

Changes in v5
-------------

Numbering note: the 7-patch series posted on 2026-07-22 went out
mislabeled as a second v4 (a tooling mistake on my side). This
posting supersedes both v4 threads.

Addresses Krzysztof's review of the first v4 posting and the
automated review of the second:

Patch 1 (Krzysztof):
  - The property walk is lock-free again; devtree_lock covers only
    the of_aliases pointer load and of_node_get(). Removed properties
    stay on deadprops with ->next intact, so the node reference is
    what a walker needs — the loop never needed the lock. Retitled
    accordingly.
  - The commit message no longer refers to overlay-writable /aliases
    in the present tense at a point in the series where it isn't.

All patches (Krzysztof):
  - Commit messages rewritten and shortened.

New patch 5:
  - Fix a pre-existing NULL dereference in of_overlay_fdt_apply():
    a failed idr_alloc() left a negative id in ovcs->id, so
    free_overlay_changeset() ran idr_remove() with a negative id and
    list_del() on an uninitialized list head.

New patch 6:
  - Fix pre-existing "//" paths from dup_and_fixup_symbol_prop()
    when a fragment targets the root node; the malformed path made
    symbols (and now aliases) in such fragments unresolvable.

Link to the mislabeled second v4: https://patch.msgid.link/20260722-nh-of-alias-overlay-v4-0-fc96a40d2761@nexthop.ai

Changes in the second v4 posting (2026-07-22, 7 patches)
--------------------------------------------------------

Addresses the automated review of the first v4 posting (its patches
2, 3, and 6 drew no findings).

Patch 1:
  - of_alias_value_ok() additionally requires the value to be an
    absolute path (per the DT spec). A relative value naming another
    alias — including itself — sent of_find_node_by_path() into
    unbounded mutual recursion with alias resolution and exhausted
    the kernel stack; the shared helper closes it for the path
    lookup and of_alias_create() alike.

New patch 4:
  - Fix the pre-existing double-free in add_changeset_property():
    a property freed on the of_changeset_add_property() error path
    stayed linked in the target node's deadprops list and was freed
    again by of_node_release(). The property now goes onto deadprops
    only after the changeset entry is recorded, so the error path
    frees an unreferenced property. Flagged on every revision of
    this series; fixing it beats re-deferring it.

Patch 5 (was patch 4):
  - dup_and_fixup_symbol_prop() now verifies the value textually
    descends through the matched fragment's __overlay__ node before
    slicing. Previously only the first path component was resolved,
    so an absolute live-tree alias sharing its first component with
    a hand-named fragment (or a bogus /__symbols__ value) was sliced
    mid-string and rewritten to garbage. Prefix mismatch and
    too-short values are -ENODEV (not overlay-internal), no longer
    -EINVAL.

Link to v4: https://patch.msgid.link/20260721-nh-of-alias-overlay-v4-0-8ad097e31e36@nexthop.ai

Changes in v4
-------------

Addresses the automated review of v3, plus findings from a local
adversarial review pass over the v4 candidate.

New patch 1:
  - of_find_node_opts_by_path() walked of_aliases' property list with
    no lock and no node reference. Racy against devtree_lock-protected
    property surgery since the walk was introduced, but only reachable
    in practice once overlays can create and destroy /aliases.
    Prerequisite for the DETACH change below.
  - The reader also validates the value's shape (of_alias_value_ok())
    before dereferencing it as a C string — raw of_add_property()
    producers are not validated anywhere — and no longer passes the
    NULL value of an empty alias property to of_find_node_by_path().

Patch 2 (was patch 1):
  - DETACH_NODE now drops the reference taken at ATTACH_NODE after
    clearing the of_aliases pointer under devtree_lock. v3 kept the
    reference to protect lockless readers, but a kept reference
    violates the changeset-destroy contract —
    __of_changeset_entry_destroy() expects refcount 1 — so every
    apply/revert cycle of an /aliases-creating overlay logged
    "ERROR: memory leak" and permanently leaked the node. With the
    reader from patch 1 taking its own reference under devtree_lock,
    the put is safe.
  - The aliases_lookup sweep now runs only when the detached node is
    the tracked of_aliases, so a stray duplicate root node named
    "aliases" can no longer wipe entries backed by the real node; the
    node match is an exact-name compare (of_node_is_aliases()) since
    of_node_name_eq() would also match "aliases@1".
  - The notifier machinery is compiled only for CONFIG_OF_DYNAMIC;
    the of_reconfig_notifier_register() stub returns -EINVAL, so the
    unconditional core_initcall_sync failed on every non-dynamic DT
    kernel.
  - Per-entry teardown factored into __of_alias_del(); shared
    of_node_is_aliases()/of_alias_value_ok() helpers in of_private.h
    replace open-coded copies in base.c and overlay.c.

New patch 4:
  - dup_and_fixup_symbol_prop() returns ERR_PTR, distinguishing
    malformed values (-EINVAL), not-overlay-internal paths (-ENODEV),
    and allocation failure (-ENOMEM) — the discrimination v3's
    "/fragment@" prefix heuristic approximated, and the reason a
    structural failure was previously misreported as -ENOMEM.

Patch 5 (was patch 3):
  - Drop the "/fragment@" prefix heuristic: init_overlay_changeset()
    accepts fragments with any node name, so a hand-named fragment's
    alias would silently stay unrewritten (the bug this series fixes),
    and a live-tree path starting with "/fragment@" would fail apply.
    Discrimination now comes from where the value actually resolves
    (patch 4).
  - Malformed alias values no longer fail the overlay apply with
    -EINVAL; they are admitted verbatim with a warning and stay inert
    (consumers validate before dereferencing). An overlay that applied
    cleanly before this series keeps applying.
  - Exempt pseudo-properties from the /aliases handling: the
    is_pseudo_property() skip at the top of add_changeset_property()
    is gated on target->in_livetree, so a phandle (a raw cell, not a
    C string) of a newly created /aliases node could fail the string
    checks and abort a valid overlay.

Patch 6 (was patch 4):
  - Drop the grafted-node reference before of_overlay_remove();
    holding it across the revert trips the same changeset-destroy
    refcount check (kernel ERROR + leaked node).
  - Assert alias removal via of_alias_get_highest_id() — keyed by
    stem, needs no node reference — with a matching precondition
    check before the apply.
  - Wrap the apply in EXPECT_BEGIN/END for the standard "memory leak
    will occur" warning printed for properties added to a node the
    overlay didn't create.

Patch 3:
  - Document the empty-vs-absolute target-path contract in the
    kernel-doc for @base/@target_base and find_target(); the old text
    predated the semantic change.

Link to v3: https://patch.msgid.link/20260721-nh-of-alias-overlay-v3-0-7001028fe2f5@nexthop.ai

Changes in v3
-------------

Addresses the automated review of v2.

Patch 1:
  - of_device_uevent() in drivers/of/device.c now walks aliases_lookup
    under aliases_mutex; the previous of_mutex path could race with
    the reconfig notifier that mutates under aliases_mutex.
  - Drop the defensive ATTACH_NODE property scan. Overlay attach
    queues each property as a separate ADD_PROPERTY changeset entry,
    so per-property notifications cover the case that matters;
    walking rd->dn->properties without devtree_lock could race with
    concurrent DT mutations. A direct of_attach_node() caller that
    pre-populates /aliases loses tracking for those entries, matching
    pre-series behavior.
  - Replace DETACH_NODE's per-property forget with a single scan of
    aliases_lookup itself (same rationale). Boot-time entries are
    unlinked; memblock-backed struct + alias name are not freed.
  - of_alias_destroy() now of_node_puts() the target for every
    matching entry, closing a leak of the reference
    of_find_node_by_path() took at of_alias_scan() time for boot-time
    entries.

Patch 3:
  - Enforce non-empty + null-terminated-within-pp->length up-front
    for every /aliases property value. Values that don't match
    "/fragment@" now flow through __of_prop_dup() only after that
    validation, closing a pre-existing hole where a malformed alias
    value could reach the live tree.

Patch 4:
  - Hold a reference on the grafted target node across the revert
    so the post-remove assertion queries the right np, not the
    base. of_alias_get_id(base, ...) would trivially return -ENODEV
    regardless of whether removal actually cleaned up the alias.
  - On of_overlay_fdt_apply() failure, reclaim the (possibly
    partially-populated) ovcs_id via of_overlay_remove() to avoid
    leaking the unflattened FDT and partially-applied nodes.

Additional fixes from local review of the v3 candidate:

All patches:
  - Trim inline comments to the constraint being enforced; rationale
    and use-case narrative moved to the commit messages.

Patch 1:
  - of_alias_create() releases the target-node reference on every
    error path, not only for owned entries — restoring the original
    of_alias_scan() error behavior for boot-time entries.
  - Correct the struct alias_prop @owned kernel-doc: every entry holds
    a reference on @np (removal drops it regardless of @owned); the
    flag only selects whether the struct and alias name are kfree()d.
  - Correct the notifier-registration comment and commit message:
    of_alias_scan() runs pre-initcall from unflatten_device_tree() /
    of_pdt_build_devicetree(), not from of_core_init().
  - DETACH_NODE clears the of_aliases pointer but keeps the reference
    taken at ATTACH_NODE: of_find_node_opts_by_path() reads of_aliases
    and walks its properties locklessly, so the node must outlive any
    concurrent reader.
  - Call out (in the commit message) the pre-existing one-byte OOB
    read in the stem parser that the refactor fixes: isdigit() was
    tested before the end > start bound.

Patch 3:
  - Correct the commit-message claim that a NULL return from
    dup_and_fixup_symbol_prop() can only mean -ENOMEM; unresolvable
    fragment paths also return NULL and are reported as -ENOMEM,
    matching the existing /__symbols__ handling.

Patch 4:
  - Fix the .dtso label: dtc labels cannot contain hyphens, so
    testcase-target failed to compile. Now testcase_target.
  - Do not add overlay_alias.dtbo to the fdtoverlay static build
    test: fdtoverlay cannot resolve the empty (base-relative)
    target-path, so static_test_1.dtb would fail to build.
  - Drop the unnecessary #address-cells/#size-cells from the grafted
    node (dtc W=1 avoid_unnecessary_addr_size).

Changes in v2
-------------

Addressed the automated review of the RFC posting.

Patch 1:
  - Guard rd->old_prop before dereferencing in the UPDATE_PROPERTY
    handler; some notifier producers pass NULL.
  - Handle OF_RECONFIG_ATTACH_NODE and OF_RECONFIG_DETACH_NODE for
    /aliases nodes attached or detached with pre-populated properties.
    (v3 pared this back — see above.)
  - Serialize aliases_lookup with a dedicated aliases_mutex; readers
    (of_alias_get_id, of_alias_get_highest_id) and the reconfig
    notifier both hold it. Boot-time of_alias_scan() stays lockless
    (single-threaded during init).
  - Destroy path unlinks matching entries irrespective of ownership
    (freeing storage only for owned ones), so an overlay UPDATE
    against a boot-time alias no longer leaves duplicate stem+id
    entries in aliases_lookup.
  - Owned entries kstrdup the alias name and hold an of_node_get()
    reference on the target — released in the destroy path — so a
    property freed by overlay revert can't dangle into aliases_lookup.
  - of_aliases is refcounted lazily on ATTACH/DETACH.
  - Validate pp->value is non-empty and null-terminated within
    pp->length before feeding it to of_find_node_by_path() — prevents
    a stray malformed alias entry from causing an OOB read.

Patch 3:
  - Only route /aliases properties through dup_and_fixup_symbol_prop()
    when the value looks like a fragment-internal path. Other alias
    values pass through the raw duplicator unchanged. This removes
    the previous unconditional fallback that would silently propagate
    a raw dup on ENOMEM.

Patch 4:
  - Rewrite the .dtso to actually exercise all three functional
    patches: a labeled node under a fragment with target-path="" plus
    an /aliases fragment with target-path="/aliases" (absolute) and
    a value referencing the label via `&`. The RFC test bypassed
    patches 2 and 3.
  - Rewrite the runner to call of_overlay_fdt_apply() directly with a
    non-NULL target_base and assert against the grafted node's np.

Link to v1: https://patch.msgid.link/20260720-nh-of-alias-overlay-v1-0-27da6848dd84@nexthop.ai

Open items
----------

None outstanding. Pre-existing issues surfaced by the automated review
are unrelated to this series and are being tracked separately:
  - fragment target/overlay refcount leak on init_overlay_changeset()
    error paths (ovcs->count still 0 when free_overlay_changeset()
    runs),
  - node duplicated by __of_node_dup() leaked in add_changeset_node()
    when of_changeset_attach_node() fails,
  - of_node_put() under devtree_lock (raw spinlock) reaching
    fwnode_links_purge(),
  - of_overlay_fdt_apply() callers (lan966x_pci_probe(),
    tilcdc_panel_legacy_probe()) not reclaiming a populated ovcs_id
    on failure.

Verification
------------

The OF unittest was run under QEMU (x86_64, OF_UNITTEST=y, v7.2-rc3
plus this series): of_unittest_overlay_alias() passes and the full
run reports 415 passed, 0 failed, with no unexpected "OF: ERROR:"
lines or changeset-destroy refcount complaints in the log. base.c
also builds with CONFIG_OF=y and CONFIG_OF_DYNAMIC=n (the notifier
machinery compiles out).

The series was also backported onto a 7.1-based image and boot-tested
on an x86 Nexthop switch with two PCI-attached Xilinx FPGAs whose
i2c-xiic controllers come from driver-embedded DT overlays applied
with a non-NULL target base. Before this series, i2c bus numbers
auto-assigned regardless of what /aliases said and shifted across
boots depending on which FPGA won the probe race. After: 95 i2c
adapters with /dev/i2c-N numbering matching the overlay aliases
exactly and stable across reboots, sensors reading live telemetry
through mux channels, and dmesg free of WARN/BUG/Oops and unexpected
OF errors. Runtime overlay revert via driver unbind was exercised on
the same hardware: the changeset revert removed all 153 of the
overlay's /aliases entries through the reconfig notifier with no
refcount or of_node_put errors, leaving the other overlay's 12
entries intact. (The revert then hangs in device teardown, in a
pre-existing i2c-xiic i2c_del_adapter() issue unrelated to this
series; the complete apply/revert cycle is covered by the unittest
under QEMU.)

[1] https://lore.kernel.org/lkml/1435675876-2159-1-git-send-email-geert+renesas@glider.be/
    Geert Uytterhoeven, "[PATCH/RFC 0/3] of/overlay: Update aliases
    when added or removed", 2015-06-30.
[2] Hervé Codina, "Using Device Tree Overlays to Support Complex PCI
    Devices in Linux", ELCE 2025.
    https://bootlin.com/pub/conferences/2025/elce/codina-pcie-dt-overlay.pdf

Assisted-by: Claude:claude-fable-5 [Claude Code]
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Abdurrahman Hussain (10):
      of: fix out-of-bounds read in of_alias_scan() stem parser
      of: hold a reference on of_aliases during alias path resolution
      of: update /aliases lookup on reconfig notifications
      of/overlay: look up absolute target-paths absolutely
      of/overlay: put property on deadprops only after changeset add succeeds
      of/overlay: only treat a positive changeset id as registered
      of/overlay: don't create "//" paths for fragments targeting the root
      of/overlay: return ERR_PTR from dup_and_fixup_symbol_prop()
      of/overlay: rewrite /aliases path values to live-tree paths
      of: unittest: cover /aliases updates from overlay apply/revert

 drivers/of/base.c                           | 230 ++++++++++++++++++++++------
 drivers/of/device.c                         |   4 +-
 drivers/of/of_private.h                     |  22 +++
 drivers/of/overlay.c                        |  99 ++++++++----
 drivers/of/unittest-data/Makefile           |   5 +
 drivers/of/unittest-data/overlay_alias.dtso |  25 +++
 drivers/of/unittest.c                       |  73 +++++++++
 7 files changed, 378 insertions(+), 80 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260719-nh-of-alias-overlay-6e5e0d56212b

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

