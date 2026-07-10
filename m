Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA653AE6E9;
	Fri, 10 Jul 2026 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670340; cv=none; b=s+AkAnsTredLalGgb7XYjWriJKY6UNi9fhC2+Yk5mDNFjxZlpWgbqfUP3r9t9pyIFsvKG2kxCVeVTQd3lqusjYKMdlQJ3hbi4kRmyyJMjyfO8IJkGO6wAjG3ykoQkge+iX9EkR5cZTydqd1C6fvQHvvTadvuib/4c7FtUkk5euU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670340; c=relaxed/simple;
	bh=i+9k/qCZC42axD9e/Q5BsbX8vqk8Mlzz3oda8wQw/FE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=X/IXIPO7nR/6MVem3MSR3HnGKzf5/5nMUh4lVA/ya/l5s1oLZnSCaBuscSSs9A2Li1V8LZAlHXDmgy7cHkcPHJ4PJO2EFxWChqHNN7ygikdq9mbjVkbguvNroERiFR3ll816BkWw+Z0JN1owyzxm+Tu1iXxXnjEgmzCz0LNQVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT9ruq9V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT9ruq9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39F11F000E9;
	Fri, 10 Jul 2026 07:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783670339;
	bh=7z64Yjh6oprdYOkOccqXqa+zyIEaBTLMckJTU03fgvM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=XT9ruq9VLPkDmgX6GaPHCeU92R+VAHAxOgUyPGuxt/IgDJuTSU+rJO8dxJUNP7oWm
	 f4qi9Wt1H8sn0KRTRJoQHNDNDF5YgfZnE1XEwPFLQkGwimI1HMTAcFRFK+5zRT+cWt
	 DzlY1CmYhH7cncVFJhzjeNYgKGWjxrh5SjcvRzGRX+XNirRHPgnU59ODeSJ2fyaGfB
	 k75/kXY3FuJedD7aZEXU0cpMRutjOM4MHXuNINZ20BnW+Spgu8OrEV9gzCsz+T1s2D
	 Bpb2Cj+6bEH2zMEaovvnpBRJt6d8H9aaUYPHYl9hxnRSjc6xmzqwct99h8wIHWG4EF
	 zz1TnhESfcQHQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/23] binfmt_misc: write access fixes, RCU handler
 lookup and cleanups
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com, 
 stable@vger.kernel.org
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
Date: Fri, 10 Jul 2026 09:58:54 +0200
Message-Id: <20260710-holzweg-berechenbar-unbeirrbar-83c525ecee0a@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5229; i=brauner@kernel.org;
 h=from:subject:message-id; bh=i+9k/qCZC42axD9e/Q5BsbX8vqk8Mlzz3oda8wQw/FE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFLHOMVJHT6usLvxh7edclrWmb14Qe+vnAVnrDj3vzf
 wgdP/f1U0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEzNwZGc7v+TShIvdgeWX9
 Y5+dTdJdU1er5RoeKl8gG5ilGOnptYeR4R93y7wHErWqnr/9uHa+keKK2iByu+vSutdxhzhWLF7
 yjxcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> The first two patches fix two i_writecount imbalances on
> MISC_FMT_OPEN_FILE interpreter files that turned up while auditing
> the file for the rework below and are marked for stable: removing an
> entry never restored the write access denied by open_exec() at
> registration, leaving the interpreter unwritable until its inode gets
> evicted, and the write denial taken on the interpreter clone during
> exec is not paired with the FMODE_FSNOTIFY_HSM aware release the exec
> machinery uses, so pre-content watches make execs leak write denials.
> 
> The rest reworks the locking and tidies the file up.
> 
> Once binfmt_misc is loaded load_misc_binary() runs for every execve()
> on the system since binfmt_misc registers at the head of the formats
> list. Every exec therefore performs read_lock() and read_unlock() on
> the entries_lock of the relevant binfmt_misc instance, i.e., two
> atomic read-modify-writes on a shared cacheline, in the common case
> just to conclude that the binary matches no handler. User namespaces
> without their own binfmt_misc mount fall back to an ancestor's
> instance so on container-heavy systems every exec on the machine
> typically ends up hammering the cacheline of init_binfmt_misc. On
> PREEMPT_RT the rwlock additionally turns the handler lookup into a
> sleeping lock on the exec fast path.
> 
> The lock protects very little. Entries are immutable after publication
> except for the Enabled bit which is already toggled locklessly via
> set_bit()/clear_bit() and entry lifetime is already handled by the
> users refcount. The read lock's only remaining job is to make "the
> entry is still linked" and "take a reference" atomic with respect to
> the unlink sites.
> 
> So make the lookup an RCU walk that acquires a reference via
> refcount_inc_not_zero() and free entries via kfree_rcu(). The removal
> paths need to detect whether an entry has already been unlinked and
> rely on list_del_init() reinitialization for that today, but
> reinitializing the forward pointer of a removed entry would make a
> concurrent lockless walker standing on it loop indefinitely. hlists
> support exactly this pattern: hlist_del_init_rcu() keeps the forward
> pointer of a removed entry intact for concurrent walkers and only
> zeroes ->pprev with hlist_unhashed() serving as the linked test. Hence
> the third patch converts the entry list to an hlist so the RCU
> conversion in the fourth is a pure locking change.
> 
> Writers remain serialized by the inode lock of the root dentry with
> one exception: bm_evict_inode() unlinks entries during umount without
> holding it. A spinlock stays around the unlink sites to make that
> exclusion explicit instead of relying on superblock lifetime rules to
> provide it implicitly.
> 
> Handler removal semantics are unchanged. An exec that acquired a
> reference just before its handler was unregistered already completes
> with the removed handler today. The read lock never protected against
> that, it only made the window smaller.
> 
> With this an exec that matches no binfmt_misc entry no longer writes
> to any shared cacheline at all. The fifth patch annotates the
> long-standing lockless ->enabled accesses for KCSAN and the three
> patches after it make the entry flags proper enums and give struct
> binfmt_misc_entry a name that isn't Node.
> 
> The remaining patches are a cleanup pass over the whole file: remove
> the VERBOSE_STATUS and USE_DEBUG compile-time toggles, convert the
> entry file to seq_file, factor out entry matching, entry removal and
> the register string field parsing, make the entry/register string
> allocation a flexible array member, give the parse_command() results
> names, let cleanup.h unwind the entry registration and exec error paths
> and prune the include list down to what is used. Aside from
> seq_lseek() now bounding seeks on entry files and the ETXTBSY
> propagation in the second patch the cleanups have no user-visible
> effect.
> 
> The last patch adds what the comment in remove_binfmt_handler() had
> been suggesting for years: entries can now be removed via unlink(2)
> in addition to the -1 write. The status and register control files
> refuse removal.
> 
> ---
> Changes in v2:
> - Allow removing entries via unlink(2).
> - Add two stable-marked fixes restoring i_writecount balance for
>   MISC_FMT_OPEN_FILE interpreter files, first so they apply to
>   mainline directly.
> - Turn the entry bit numbers and behavior flags into proper enums and
>   rename Node to struct binfmt_misc_entry.
> - Add a cleanup pass over the whole file: remove the VERBOSE_STATUS
>   and USE_DEBUG toggles, convert the entry file to seq_file, factor
>   out entry matching, entry removal and register string parsing, use
>   a flexible array member for the register string, name the
>   parse_command() results, use cleanup.h for the entry error
>   unwinding in registration and exec and prune the include list.
> - Link to v1: https://patch.msgid.link/20260708-work-binfmt_misc-locking-v1-0-a009dd5b56db@kernel.org

I'll send a v3 in a bit with one more fix.

-- 
Christian Brauner <brauner@kernel.org>
