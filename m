Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BFF2E737D;
	Thu,  9 Jul 2026 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636218; cv=none; b=n4ed8xwj4Cj9CcH1Uq1Xmk3t96cwAAB7j3WqpHGZHTTUYKJiz6wZP7pcznghuPJibR1UO49r7vGZ/sMVTGAlUyyk/J5HoKLxxX3NLH3O4G45x4xHdbifFMg/mCyrS8Y+YTSY59bm4sYwNU6ivngNwZvSnjZaw3i8pVvwxDGeisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636218; c=relaxed/simple;
	bh=O/cickC6NJoi8fvGwVtPbnnxQPKMcPn36PywjR+AOYA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GsaKsclhRP8+N9DVCE+wTELuA9YASuEzxmh2olk/lhHuZ+7xCZlVx82lmNUKop2sMysTz2Yt91b/lUGjshxpbRsGnJxjQza2ywaPoaezV1TdW1fyDWtFsu4KbPsjtUGK9KCOirjC4oHv52q8/bkyILa/mxCho7Wp5sDWK84rYRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kpqnw+ve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kpqnw+ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70DB1F000E9;
	Thu,  9 Jul 2026 22:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636216;
	bh=0EyJr0/xAe7avOLcVrbyCwP6jqYeJsuARR8e8XI8AfY=;
	h=From:Subject:Date:To:Cc;
	b=Kpqnw+ve3+9UW3cJQqw64p+5ga50Zy83nVzL36o2r88lhFRV4fRR3pjS5POG/Q58R
	 Ufj85CJr+d1t9rJzjw0kAZQmfzJvSpnfOcbbu0aX1gxi6opni3nYUxXhwRB3RoBWsC
	 YJ3xl0OfLEL3GoWGEgv6BVx9Rgtd7VccWJHZetVUvYTFaeyvfVTWaCkybDA0QaQJ/2
	 Ueb8SX8FaNy6q2UdG2h/V/w2QzpDXJAzTIf99ciQ5Ll5FPTMEMobwku4d2k+MsdG+e
	 99hNp6IzOyeDBP8GbiaU3BRfhHrEUzJ1/qzGiTsGaI9ZxLiSfg2kQwf3sIs+RqmNkZ
	 yeMiTIK4vu1KQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 00/23] binfmt_misc: write access fixes, RCU handler
 lookup and cleanups
Date: Fri, 10 Jul 2026 00:29:55 +0200
Message-Id: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOMgUGoC/42OXQ6CMBCEr2L67JK2iqhP3sMY058FVqQ1W0SN4
 e5SvYCP32Tmy7xFQiZMYr94C8aREsUwg14uhGtNaBDIzyy01BtZyS08IndgKdT9cO4pObhG11F
 oQJWrdeVrpdFtxTy/Mdb0/KqPpx+nu72gG7IvN6xJCJZNcG2OepMG5GKsCg3sVG60lIbIr++7U
 WXTH0dGBRKMlDvvS1tuvD10yAGvReRGnKZp+gBDWBS49QAAAA==
X-Change-ID: 20260708-work-binfmt_misc-locking-15347df12ec8
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6831; i=brauner@kernel.org;
 h=from:subject:message-id; bh=O/cickC6NJoi8fvGwVtPbnnxQPKMcPn36PywjR+AOYA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHz9pMSr/Olnjlyr6Kb23+npDJr5K3Qi7HUtjI7rC
 Z8/28/fUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJETzgx/BY8xTQp6kxjHPeVF
 UAEr027PkiMaCxrXdZ9t3NElceBZJyPDjQMeV/wa3thtLw3zEXn2fYnXqmtsd9XmbYjtnHV0z1R
 tZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The first two patches fix two i_writecount imbalances on
MISC_FMT_OPEN_FILE interpreter files that turned up while auditing
the file for the rework below and are marked for stable: removing an
entry never restored the write access denied by open_exec() at
registration, leaving the interpreter unwritable until its inode gets
evicted, and the write denial taken on the interpreter clone during
exec is not paired with the FMODE_FSNOTIFY_HSM aware release the exec
machinery uses, so pre-content watches make execs leak write denials.

The rest reworks the locking and tidies the file up.

Once binfmt_misc is loaded load_misc_binary() runs for every execve()
on the system since binfmt_misc registers at the head of the formats
list. Every exec therefore performs read_lock() and read_unlock() on
the entries_lock of the relevant binfmt_misc instance, i.e., two
atomic read-modify-writes on a shared cacheline, in the common case
just to conclude that the binary matches no handler. User namespaces
without their own binfmt_misc mount fall back to an ancestor's
instance so on container-heavy systems every exec on the machine
typically ends up hammering the cacheline of init_binfmt_misc. On
PREEMPT_RT the rwlock additionally turns the handler lookup into a
sleeping lock on the exec fast path.

The lock protects very little. Entries are immutable after publication
except for the Enabled bit which is already toggled locklessly via
set_bit()/clear_bit() and entry lifetime is already handled by the
users refcount. The read lock's only remaining job is to make "the
entry is still linked" and "take a reference" atomic with respect to
the unlink sites.

So make the lookup an RCU walk that acquires a reference via
refcount_inc_not_zero() and free entries via kfree_rcu(). The removal
paths need to detect whether an entry has already been unlinked and
rely on list_del_init() reinitialization for that today, but
reinitializing the forward pointer of a removed entry would make a
concurrent lockless walker standing on it loop indefinitely. hlists
support exactly this pattern: hlist_del_init_rcu() keeps the forward
pointer of a removed entry intact for concurrent walkers and only
zeroes ->pprev with hlist_unhashed() serving as the linked test. Hence
the third patch converts the entry list to an hlist so the RCU
conversion in the fourth is a pure locking change.

Writers remain serialized by the inode lock of the root dentry with
one exception: bm_evict_inode() unlinks entries during umount without
holding it. A spinlock stays around the unlink sites to make that
exclusion explicit instead of relying on superblock lifetime rules to
provide it implicitly.

Handler removal semantics are unchanged. An exec that acquired a
reference just before its handler was unregistered already completes
with the removed handler today. The read lock never protected against
that, it only made the window smaller.

With this an exec that matches no binfmt_misc entry no longer writes
to any shared cacheline at all. The fifth patch annotates the
long-standing lockless ->enabled accesses for KCSAN and the three
patches after it make the entry flags proper enums and give struct
binfmt_misc_entry a name that isn't Node.

The remaining patches are a cleanup pass over the whole file: remove
the VERBOSE_STATUS and USE_DEBUG compile-time toggles, convert the
entry file to seq_file, factor out entry matching, entry removal and
the register string field parsing, make the entry/register string
allocation a flexible array member, give the parse_command() results
names, let cleanup.h unwind the entry registration and exec error paths
and prune the include list down to what is used. Aside from
seq_lseek() now bounding seeks on entry files and the ETXTBSY
propagation in the second patch the cleanups have no user-visible
effect.

The last patch adds what the comment in remove_binfmt_handler() had
been suggesting for years: entries can now be removed via unlink(2)
in addition to the -1 write. The status and register control files
refuse removal.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v2:
- Allow removing entries via unlink(2).
- Add two stable-marked fixes restoring i_writecount balance for
  MISC_FMT_OPEN_FILE interpreter files, first so they apply to
  mainline directly.
- Turn the entry bit numbers and behavior flags into proper enums and
  rename Node to struct binfmt_misc_entry.
- Add a cleanup pass over the whole file: remove the VERBOSE_STATUS
  and USE_DEBUG toggles, convert the entry file to seq_file, factor
  out entry matching, entry removal and register string parsing, use
  a flexible array member for the register string, name the
  parse_command() results, use cleanup.h for the entry error
  unwinding in registration and exec and prune the include list.
- Link to v1: https://patch.msgid.link/20260708-work-binfmt_misc-locking-v1-0-a009dd5b56db@kernel.org

---
Christian Brauner (23):
      binfmt_misc: restore write access when removing an entry
      binfmt_misc: use exe_file_deny_write_access() for the interpreter clone
      binfmt_misc: convert entry list to an hlist
      binfmt_misc: use RCU for the handler lookup
      binfmt_misc: annotate racy accesses to ->enabled
      binfmt_misc: turn the entry bit numbers into a proper enum
      binfmt_misc: turn the entry behavior flags into an enum
      binfmt_misc: rename Node to struct binfmt_misc_entry
      binfmt_misc: remove the VERBOSE_STATUS toggle
      binfmt_misc: use print_hex_dump_debug() for the register debug output
      binfmt_misc: convert the entry file to seq_file
      binfmt_misc: factor out the entry matching
      binfmt_misc: rename load_binfmt_misc() to current_binfmt_misc()
      binfmt_misc: return errors directly in load_misc_binary()
      binfmt_misc: give the parse_command() results names
      binfmt_misc: factor out the entry removal
      binfmt_misc: simplify check_special_flags()
      binfmt_misc: use a flexible array member for the register string
      binfmt_misc: split the field parsing out of create_entry()
      binfmt_misc: use __free(kfree) in bm_register_write()
      binfmt_misc: assorted small cleanups
      binfmt_misc: include what is used
      binfmt_misc: allow removing entries via unlink(2)

 Documentation/admin-guide/binfmt-misc.rst |   3 +-
 fs/binfmt_misc.c                          | 835 +++++++++++++++---------------
 include/linux/binfmts.h                   |   4 +-
 kernel/user.c                             |   4 +-
 4 files changed, 429 insertions(+), 417 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260708-work-binfmt_misc-locking-15347df12ec8

