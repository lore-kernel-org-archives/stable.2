Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8E3F58CE;
	Fri, 10 Jul 2026 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676003; cv=none; b=gyJT5/wzdWVy/qB9WvhLqatlVbJNzCHBo/PlSUFiQAwh1ImeLMtquc8hzeX2JhZwjF1GGBUQ1slQpog/g3//IVy5hlvSmo5VIfhPOQj8R9ZwsxD9Oh//DGdW7Dv/MokmSHxcZx0Kn/0mzPntscU8ZQHQGhMJA49NaAauFRUhZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676003; c=relaxed/simple;
	bh=SJzYgy+FDiwAvoKv4ayMdK66KOsj8R4Za9eWqpZz9zY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P07TEPD1SoK6g0mpdJSlvPS4bYrsJAZngHaoOShYslAv4tWMMYvHaipWzVxE1+LVPMdHmfY/btTOdPkJmhiG7LTda9F6DJC6R6JhOa1ILiqdPBlJY5PQiZa53TIvxpCDlWhBf/S0AsgUKIaYYtX5KT3fobFkZg5A8qXpJt+bJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpncGmf3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpncGmf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1111F000E9;
	Fri, 10 Jul 2026 09:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676001;
	bh=Cupg3BA8kLDD00ofoemHrt7+K30GSRvx4gIS1hIu6mE=;
	h=From:Subject:Date:To:Cc;
	b=TpncGmf3QumrUV4gQ+24YgqSHQLUNXGZMPJ4tgFmQtrckM4rovPoltNHcLFgkMRGe
	 LzYGGP3b5ZYAIgK5CS92v0xOOSYexd7gkyT/gpmaoRkJugyQT17HpF8PPQbh75rQo3
	 rNeIFmi5wAYZE8PDBuhbi0iTg2oQlR6hynZYCuML5bF3Rm0SGpDtnSn63CW9kB6Eq3
	 r8O2QDzWV85HWuERrXiJa1W1TGpmfY8io6xeRrBv0OHOLp0+P3hg9q/XkXw2CXoYTY
	 hIP8rV8z0fKDo7ty0RyFzVbK4d6CvrX0+WocIWK1YiCi+smcqp6GHIcBkQEy1Rd9mq
	 ep+7fufYJI3mA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 00/24] binfmt_misc: write access fixes, RCU handler
 lookup and cleanups
Date: Fri, 10 Jul 2026 11:33:01 +0200
Message-Id: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE28UGoC/43OTU7DMBAF4KtUXjOR7TRJ6Yp7IIT8M0mGNDYaB
 0NV5e6N203ZIJZv9ObTu4iETJjEcXcRjJkSxbCF+mkn3GjCgEB+y0JL3cpOHuA78gSWQj8v7zM
 lB6foJgoDqKbed75XGt1BbO+fjD393OjXt3tOX/YD3VK80rAmIVg2wY3lNJu0IFe5qzSwU6UxU
 loin2/rsirSP4ZkBRKMlM/eN7ZpvX2ZkAOeqsiDKEuyfpCU/EPSm6SNcrXfK92a7pe0rusVXam
 PpD8BAAA=
X-Change-ID: 20260708-work-binfmt_misc-locking-15347df12ec8
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6522; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SJzYgy+FDiwAvoKv4ayMdK66KOsj8R4Za9eWqpZz9zY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7Iktmj6Br106fGn0NSm1/DmTHrHMYun4tjRsC2tSm
 X5Kq5JNRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQU9Rn+ma1LkL6U/Ud1noaa
 2D7b9/tLuj4/5l/mcuv6kcv7N3+/msLIsHCn1J/lO6vuL9dYf3mX+8nyuSa75TMFXm54vKLgQCi
 /LDsA
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

Also, a register string whose delimiter is one of the flag characters
('P', 'O', 'C', 'F') makes the flag scan in create_entry() run past the
end of the register buffer. Reject such a delimiter up front.

The rest reworks the locking and tidies the file up.

The current rwlock protects very little. Entries are immutable after
publication except for the Enabled bit which is already toggled
locklessly via set_bit()/clear_bit() and entry lifetime is already
handled by the users refcount. The read lock's only remaining job is to
make "the entry is still linked" and "take a reference" atomic with
respect to the unlink sites.

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
one exception. Handler removal semantics are unchanged. An exec that
acquired a reference just before its handler was unregistered already
completes with the removed handler today. The read lock never protected
against that, it only made the window smaller.

With this an exec that matches no binfmt_misc entry no longer writes
to any shared cacheline at all.

The fifth patch annotates the long-standing lockless ->enabled accesses
for KCSAN and the three patches after it make the entry flags proper
enums and give struct binfmt_misc_entry a name that isn't Node.

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

The penultimate patch adds what the comment in remove_binfmt_handler()
had been suggesting for years: entries can now be removed via unlink(2)
in addition to the -1 write. The status and register control files
refuse removal.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v3:
- Reject a register string delimiter that is also a flag character.
  A flag-char delimiter made the create_entry() flag scan read past
  the end of the register buffer. Stable-marked, added as the last
  patch.
- Link to v2: https://patch.msgid.link/20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org

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
Christian Brauner (24):
      binfmt_misc: restore write access when removing an entry
      binfmt_misc: use exe_file_deny_write_access() for the interpreter clone
      binfmt_misc: reject a flag character as the field delimiter
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
 fs/binfmt_misc.c                          | 839 +++++++++++++++---------------
 include/linux/binfmts.h                   |   4 +-
 kernel/user.c                             |   4 +-
 4 files changed, 433 insertions(+), 417 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260708-work-binfmt_misc-locking-15347df12ec8

