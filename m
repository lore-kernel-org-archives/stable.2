Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE343BB67F
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667434; cv=none; b=XyH2tvO5v49rnWzTMlAOxDjPknv8omUIhgJyC617DSunUoy/aS6WS/6HW1x2RJC/QjZryEVwzRlAIlY9r10qlKG7vgPYaYSvRZZvCY+RxkSDWOAUujnCXEJ1ovLO6Fe6qfxzOOh9QjWoDDbyWnxvyZn9CZqZlbR8P464Dlfjhu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667434; c=relaxed/simple;
	bh=HSLmyNqqlC5f/lDHCkwX2D39xGcapCKnPGT/JRUn8pQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CyyIC6RK9N+HcphrWuuSrHgqfuFRAMTmiWJ7ylkusgNvVoeAKhyFPTTKJcYB9JsliFMq+ZE9PAh6oMLe1W6rjaJL3UX4UYA/XWJ7b21uw/H5iLGw8+PV4H/yEiJ6SvjbLScV6UftnWonfd4I00MTRH6eZM0T2wTY2Ljb4eaxknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q7R2RXrP; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7R2RXrP"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7eb61bbeb25so5254086a34.1
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667431; x=1785272231; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qbpzhZprvzL7jC81RqT6ZTBnFe6RFMUwroybvguCBv0=;
        b=q7R2RXrPGw9+iivRrZn5po2Uewp85S07tfBcR3w+KtU0hnBnGqQifXve40dAUCA5y2
         wbSgWbzzNwK58x8VRpCRrCrStAMxL3KARzNqCvX5TiiTH6KPj5VOH6NLsz3Ta9/eLviA
         LBgIyBO94W55OfNvB0+uUm7MUTugku58FYXSevkA2thBEABQPYltl3sVOyLtvz2bo38f
         YD8o4ZHbKsoZd9F5xMSaCdJ+vaugmIIoNg3/8YJUs7hg5xyp0qTsVU+Z4L4diC4CBcf6
         162bDIqUbZzQaAVkrxxHH5uMPwtHR/RFkPoeZz5dSTYVLiWMwDZ1j20iJAgLaDj/TOWP
         880w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667431; x=1785272231;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qbpzhZprvzL7jC81RqT6ZTBnFe6RFMUwroybvguCBv0=;
        b=QGD2FJ8M0wKCmES1eF9pQ5dKZYwMC673KGupXcqvTkwOE8k2uNWN4BUD3hFvDZ+Lbc
         WA6frGu9DabKrJhfiY52TEN/Shw7voAwQiU2zzDBUGODt0646vo8D2G2xvGasK6NWpkT
         XoXWEKPfpluBhfEsqBeGrdWVa+QYsrvlnutXIqvnNpZtl2aOw1Qj94gEDD3RSW71jSdg
         RP/yH2tzd8BXw+ozxclv6vpRUmw3u0tzPX1wZHQeLH47b5U4/filOvZS9O3URMlUWfNF
         v4mMEGVTr7adCcmFQ9cjR4w5lhH7QQ2wYdxYidKr4vpWhjSNI6KJziiZjroprGIhopJZ
         TUqw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7/X63EA6RnI9h12Vrs7AQEQ29K7Jh7fKSH0n/IiK+dwdlByj475REZQ8DyDTFvrsuwAac1l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCIFFhgPGw2tCC5XjHqOPyGvyY2zC91a303trRIrYLBG+WnJQn
	GEej0e/6dMUo6tr0RQCp1SHvvI2990+EEt9T6ScMKzn1aMc/xg/avCn+
X-Gm-Gg: AfdE7ckijTs31lfyPJVzf5/W3B9j/WHmpPRQ+YymU6C7BHB81vXDcuiMYcg0OSGgtLk
	mfREiOahERoUpxh2fE1ohZyq2X2ON+GGv6Q0YBkY3QwpU3zthC1Bf7vzFYcNtF1gJGHKdLVjQhb
	WggBNfNqXtJ8WnmO3ewWSo8MeRNWbGiQZHXt6EoinDlXfVdOHcbWl2PfLqKVkaWIQePyZXxoPD0
	ake9qbvoiD3I7+55HcT/BVRV07yMCwYE0TDlJWC39SUnOy69ftLVMUjZLFcEPjmrUHMilqKXF2V
	My483By2Blb9PgLyIkRU1UPRWQd6isLGyG6haOOdYA7vjrhXrMsAnyrvAQtdpHeI/7/z8zRm80z
	TC1KaIi/u29fBrTHhlidX/1J2IjWeSmd4nhqJLAGaDaTs1YLQHri2heJ18KYfzkyKPkFCfIGMyh
	6A9xgOwOqAFyvECDXL0dw2YffO9f9Y7yZ1MlB+wIX7IHPPfh8gcs6jRnKisOwbFBBYV8arZ4VKz
	KS1J4SALoZgIe4r5GPVx+7AAQ==
X-Received: by 2002:a05:6830:700a:b0:7e9:e0f3:b914 with SMTP id 46e09a7af769-7ed9aa59b8amr11454589a34.13.1784667431085;
        Tue, 21 Jul 2026 13:57:11 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:10 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 00/29] fix dynamic-debug classmaps API for DRM
Date: Tue, 21 Jul 2026 14:56:49 -0600
Message-Id: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13RS27DIBAG4KtYrEsEw2DsrHqPqgteTpBquwUXt
 Ypy904SVbG9QRqG7xcMF1ZiTrGwY3NhOdZU0jxRYV4a5s92OkWeAtUMBLRCg+Qh8NGmaeHATes
 1gjA9LYzAZ45D+rmHvb1TfU5lmfPvPbvCbfc/Rq1jKnDBXa+MkmCt6NTriVofBz+P7BZT1ZO2Y
 nODqoiildoBSheU31NcU9hQJCp7KxG17rTt9lQ/qdlRTRRwAHD0FjfAnrZraja0Jao6OagYnBC
 o1/T6mGGOX9/0D8tjkMzZEjn1x7Qcm2oOwLNHOnz9A3SSw5K8AQAA
X-Change-ID: 20260521-dd-maint-2-76c542079420
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, stable@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=8836;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=HSLmyNqqlC5f/lDHCkwX2D39xGcapCKnPGT/JRUn8pQ=;
 b=oFSZGGaTYP15h5jzOe5WHoYI0xiibB/2BmYKd1+zJ6fzliY8bP3Mc7kWXJ+scKnr8xqXJrjjY
 +oLZz0O0YrlAR14Qij1VrOtntdWRv13KJp1GGkUmCFKGJvu8CHOUePF
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

This series fixes problems which broke CONFIG_DRM_USE_DYNAMIC_DEBUG=Y.

Briefly, the bug was that the handling of drm.debug settings occurs
when drm.ko is up/ready, long before drm drivers and helper modules
are up/ready.  So they missed the enablement.

The fix is to split DECLARE_DYNDBG_CLASSMAP in 2; a client-server
scheme where drm calls DYNAMIC_DEBUG_CLASSMAP_DEFINE, and drivers call
DYNAMIC_DEBUG_CLASSMAP_USE.  Now when a driver is modprobed, dyndbg
sees the _USE record, follows it to the classmap _DEFINition, finds
drm's drm.debug param which the classmap is wired to, and applies its
setting to the driver module.

The patchset, by chunks:

1. tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
   moved to front
   available from start to validate each following commit
   "fingerprint" based.

2. DRM setup
   enable code under test thru entire series
   remove BROKEN on CONFIG_DRM_USE_DYNAMIC_DEBUG
   fix ccflags-y in Makefile - build with -DDYNAMIC_DEBUG_MODULE
   probably omit this for merge

3. vmlinux fixes for i386 misalignment crash
   cleanups needed,added too.

4. cleanups, preps, etc
   unused code removal
   callchain refactors, struct re-structuring,
   verbose debug reduction

5. The API fix
   new __dyndbg_class_users section
   new test_dynamic_debug_submod.ko
   selftests - reproduce the drm-drivers scenario

Not included:
   a few drm-core adaptation patches
   75+ 1-liner-ish DRM patches to +DYNAMIC_DEBUG_CLASSMAP_USE
   patches validating DYNAMIC_DEBUG_CLASSMAP_* args at compile-time, etc

There are 2 user-visible changes I should note:

1. change an ERROR condition displayed in dynamic_debug/control,
from "class:unknown, _id:1" to "class:_UNKNOWN_ id:1"

This only happens if a classmap is incorrectly defined.  Such a
problem should be caught in review, and should be SHOUTED about.  And
since classmaps are BROKEN for DRM (its only user), this affects no
users.  Followon patches will catch more classmap definition errors,
but not this particular one.

2. change builtin module names, displayed in dynamic_debug/control,
from simple "[main]" to subsystem "[init/main]" etc.  This corrects an
existing naming ambiguity, which is disallowed for loadable modules by
the module loader.  To preserve legacy query behavior, "module main"
will select all of "[*/main]".

NB: the current ambiguity prevents cleanly adding classmaps to
builtins named "[main]".  Such an addition is quite unlikely, so this
change could/can be dropped, but it seemed proper to point it out and
correct it.

3. revert a change in classmaps-v1 (2022) which enlarged __drm_debug
from (unsigned) int to long int.  64 categories of drm-debug is well
past reasonable and useful.  The param is now a u32, for clarity.

NB: 63 class-ids allows 2+ classmaps per module.

PS: shortened cc list to stay under gmail's 500/day limit,
pls cc folks you think should see this.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v7:

- rebased onto v7.2-rc4
- applies clean to mm-nonmm-unstable@376804729797

- move selftest script to front, always there for validating, bisecting.
- substantial rewrite of test script. now fingerprint based.
- move DRM patches to front, for more thorough build-tests
- drop statements-to-expressions, the compile error no longer exists.
- sashiko fixes - all, I hope
- Link to v6: https://lore.kernel.org/r/20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com

Changes in v6:

previous versions split the 1st chunk into a separate submission, in
an attempt to get past gmail's 500 msgs/day limit, and to ease review.

This complicated application; although the 2nd chunk had the b4
dependency on the 1st, this fact was missed by sashiko, which
therefore couldnt apply it.

A followon series adds compile-time and runtime checks to fail-fast if
classmaps are used incorrectly.

Changes in v5:

move KBUILD_MODFILE ahead of array-slice, to address sashiko
complaints which were fixed by later patches in V4.

Changes in v4:

Dyndbg previously used KBUILD_MODNAME to provide module-name, this
works well for loadable modules (module loader requires unique module
names), but for builtin modules, is effectively kbasename, and is not
guaranteed unique.

So we get 4 modules named "main": init/main, kernel/power/main,
kernel/base/power/main.  This ambiguity is visible in user-space since
the beginning of dyndbg.

Now suppose kernel/{,base}/power/main want to define classmaps to
categorize the various pr-debugs they have.  The current code finds a
module's classmaps by strcmp on modname, so init/main will match
against classmaps defined by both kernel/{,base}/power/main.

The current code will also map "main" classes to kernel/*/power/main,
so they will probably work at first, but 2 independent classmaps can
both use class-ids 0-N, but will conflict if they're both used by a
module.  Then we have classmap overlaps and unpredictable results.

v3:
- move #includes to top of files,
- drop redundant ALIGN(8) in dydnbg.lds.S: DYNDBG_SECTIONS macro
- add Reviewed-by tag (thx Petr)

v2:
- avoid BOUNDED_SECTION in modules, dont need _start & _end symbols.
- sets 0 address to the sections, not just whatever current is.

---
Jim Cromie (29):
      params: fix a pr_debug(" %p ") use - already in MM-*
      selftests/dyndbg: Add kselftest script to verify dynamic-debug
      drm: Fix incorrect ccflags-y spelling inside Makefile
      drm: fix config dependent unused variable warning.
      drm: Mark CONFIG_DRM_USE_DYNAMIC_DEBUG as unBROKEN
      vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into bounded_sections.lds.h
      vmlinux.lds.h: drop unused HEADERED_SECTION* macros
      vmlinux.lds.h: Fix ALIGN(8) omission causing NULL ptr on i386
      vmlinux.lds.h: remove redundant ALIGN(8) directives
      dyndbg.lds.S: fix lost dyndbg sections in modules
      dyndbg: factor ddebug_match_desc out from ddebug_change
      dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
      dyndbg: reword "class unknown," to "class:_UNKNOWN_"
      dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
      dyndbg: drop NUM_TYPE_ARGS
      dyndbg: bump num-tokens in a query-cmd from 9 to 15
      dyndbg: reduce verbose/debug clutter
      lib/parser: add match_wildcard_hyphen() for agnostic matching
      dyndbg: use KBUILD_MODFILE for unique builtin module names
      dyndbg: refactor param_set_dyndbg_classes and below
      dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
      dyndbg: replace classmap list with an array-slice
      dyndbg: macrofy a 2-index for-loop pattern
      dyndbg: pin class param storage to u32
      dyndbg,module: make proper substructs in _ddebug_info
      dyndbg: move mod_name down from struct ddebug_table to _ddebug_info
      dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module
      dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
      selftests/dyndbg: enable FT_classmap_inheritance

 Documentation/admin-guide/dynamic-debug-howto.rst  |  42 +-
 MAINTAINERS                                        |   2 +
 drivers/gpu/drm/Kconfig.debug                      |   1 -
 drivers/gpu/drm/Makefile                           |   3 +-
 drivers/gpu/drm/drm_print.c                        |   7 +-
 include/asm-generic/bounded_sections.lds.h         |  32 +
 include/asm-generic/dyndbg.lds.h                   |  22 +
 include/asm-generic/vmlinux.lds.h                  |  68 +-
 include/drm/drm_print.h                            |   2 +-
 include/linux/dynamic_debug.h                      | 257 +++++--
 include/linux/parser.h                             |   1 +
 kernel/module/main.c                               |  15 +-
 kernel/params.c                                    |   4 +-
 lib/Kconfig.debug                                  |  24 +-
 lib/Makefile                                       |   3 +
 lib/dynamic_debug.c                                | 607 +++++++++------
 lib/parser.c                                       |  58 +-
 lib/test_dynamic_debug.c                           | 145 ++--
 lib/test_dynamic_debug_submod.c                    |  14 +
 scripts/module.lds.S                               |   2 +
 tools/testing/selftests/dynamic_debug/Makefile     |  10 +
 tools/testing/selftests/dynamic_debug/config       |   8 +
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 847 +++++++++++++++++++++
 .../dynamic_debug/syslog_hash_validation.sh        | 384 ++++++++++
 24 files changed, 2089 insertions(+), 469 deletions(-)
---
base-commit: 6946cd5d0aa4dd10a414ddcb7a10844fdb0ad345
change-id: 20260521-dd-maint-2-76c542079420

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

