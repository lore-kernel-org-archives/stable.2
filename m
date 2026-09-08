Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB763769E7
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848587; cv=none; b=aWogI8JgeH6u972XqZZe3nEJ0ALuCe8bKq8eESnDvxJj5xRYqeRIS+0rUk4sPL2yelwZq1Zlv98owFIXfwyXj5KwP6za9EZvnpRnlyvBtmAQFzwJ48CjM1qBgdq+R6SM9Lhn10AAvU1R3nKhKakMJgRthHZ9qQULqMbqDIawPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848587; c=relaxed/simple;
	bh=c1J2xT/U14EShzoMUdB/kXRkvt4OVaSC2Bb0WvS0Faw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JdlSDwr5qLW4PxO70O3lZJVmWw4yRRGvn7L988AHniLv7skvxosq6asg7KR+684zt/nvEYPfNtbOpWQUdHwQlxPYyzZDvHTzCuI1Sd/ueS0lEelDo1Npd96NoiGjqPNXnMi32uEUBOIKLPsdH1LgMxQZZrzObpAsfkGeu7voxsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZIxLDfCL; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZIxLDfCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1788848580; bh=fM5DPR3tJyA/wXVuy18BdH4ZF+V0RECfzZxUhUjn/JA=;
	h=Date:To:Cc:From:Subject;
	b=ZIxLDfCLbhkRraAnSaEfr9sGnT3732azz8r5RVNROHjhtzQJ5/GVJ54bJeTtp6PYZ
	 eNEAwAMKZrjB+nbx2yDF2OyqCgX/+foJAMhpQ+y5ID2WhjFjXtXIovo44DsKVG/BY9
	 pvV+Kahv09bWqGme1MtbHERiaR3EE/sT8pQmK6Z8=
Received: from [192.168.0.109] ([120.227.46.204])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 5B980836; Tue, 08 Sep 2026 14:22:57 +0800
X-QQ-mid: xmsmtpt1788848577tr3jpvqnw
Message-ID: <tencent_91404E2C53AD34E04CD2445AD2C13D176206@qq.com>
X-QQ-XMAILINFO: Nj+lDvaLCxoMnbyobSucL/xkVCAEEmn3m4PJpK0KMtaWQ9d+TKuLYnA/SGuP+r
	 AEIkCSRSJwE5Jko14piKpBHv5smQ5ibHMfK3Xo0bKhoFQo50gXRDwhIG+oPDXndgG07gA0ARqCRv
	 Lkv4em5bIWi+XIv8Ie6sGJEHmlYe/TcTSRJnoLdoNLGddIUCiOytnb0xnF3JDu6YPx2CWwm3hhW8
	 JGz58M0A9/vyOLLT+2hJ9OIXng5YClzHyRL/C2VeDiIkalWWevKILDcyZ+nvATsN47fSxY8iaok9
	 LYjQkL15uv5tBZT93lKlu21xxtDA6e5J+PCmy9Wq51fk6mGY9oita35UJ1oG94psWB0lhDn+h8n6
	 mf9H9upyQull/s1OVj5LJDKw9d5GeYfFN1kqti1vtwQY1A7QhbyW7fcxANOxfJ0YsvtADF+5etwv
	 1dMvRRyfLgRpJ5egsiKYqR+Clmz3tbn948QnSbxPhW94IgMCYHW2I6UfhydvVvfFPvzaqPnDd8+v
	 Q11+xRUGlODpNb1qHKuYkyFpCO1A12ZW2p/N2e3V4P61pT8PN12tTuTGIeSi+4xD9oxTlaNHSqb+
	 gRb98F/2tdR8lnFXaEGjqdGgRPco6trrzb6AWfg164sd7lGNNY96LtSvNPrkx9ZN8V9GW+KnpogB
	 /vOA0f03WEt4O3Iacl9wuV14CaLLQf7+2OMVVcJ1MisvwXXrxQOMbygNQ4+qNnG2zDD5jMYsnahu
	 axwZXT71gF+irfmFUDCX374nxM3u+/T/UqkfiyHSoE0VLQxJc44bue5qs2AmVoU7Yg2AvO+pR42B
	 VlrEpcMmdqpqKUZhuYUP4uRLSoBYZEe3PqsjinCsnaIYUcR5pOppuC/i8yVc/0DbmPFVyiHFJKcI
	 Gu7J6feLEf1E1EyTJEbb/qG09FtVy9ebtPsxYjfUsLDfNZrRRNYwFbGZP1bIGjd/67WEslC0oDkZ
	 H/kaF5hUT9TTleqKEzjULqskApEGfIH5YfcZtYF09MpEp62gUXv2IutDeq+VhuRHnQDsZxqSbYcz
	 1K3O9Nwg9ZX3Np9JmP8637r8Jbo6EMzUwRdquZwLNVep7B8AFM4XD/oFrcjz771WabyE/3K0k3KI
	 6pvxZibWI/2Ng/kLA=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-OQ-MSGID: <93a32883-ae0f-478c-be1a-9796cd936fde@qq.com>
Date: Tue, 8 Sep 2026 14:22:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: security@kernel.org, a.hindborg@kernel.org, w@1wt.eu
Cc: stable@vger.kernel.org, syzkaller@googlegroups.com
From: tms <2478511876@qq.com>
Subject: =?UTF-8?Q?Linux_kernel_v7=2E3-rc2=3A_configfs_rmdir_keeps_the_targe?=
 =?UTF-8?Q?t_dentry_hashed_=E2=80=94_concurrent_symlink=282=29_revives_a_dyi?=
 =?UTF-8?Q?ng_config=5Fitem_=28CWE-416=29?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

# Linux kernel v7.3-rc2: configfs rmdir keeps the target dentry hashed — 
concurrent symlink(2) revives a dying config_item (CWE-416)

Last saved at 2026-09-08

## Asset

Linux kernel (torvalds/linux source tree) — the **configfs** filesystem 
subsystem,
specifically the `configfs_rmdir()` / `configfs_remove_dir()` path in
`fs/configfs/dir.c`, `configfs_get_config_item()` in
`fs/configfs/configfs_internal.h`, and `configfs_symlink()` / 
`get_target()` in
`fs/configfs/symlink.c`.

- Affected version declaration: the audited source tree is **v7.3.0-rc2**
   (`Makefile`: `VERSION = 7`, `PATCHLEVEL = 3`, `SUBLEVEL = 0`,
   `EXTRAVERSION = -rc2`, verified). The defect has existed in every 
mainline and
   stable/LTS branch since configfs was introduced by commit 
7063fbf22611 (2005,
   v2.6.19-rc1). The upstream fix is f06c2d26d199 (`"configfs: unhash 
the dentry
   before dropping the item in rmdir"`, `Fixes: 7063fbf22611`, `Cc: stable`,
   `Reported-by: syzbot+6b16e3d085833cbf3e25`), merged via the 
configfs-7.3-rc3
   pull ⇒ the fix lands after v7.3-rc2 and before rc3, so the audited 
tree sits
   inside the vulnerable range.
- Dependent components: the same allow_link client subsystems as the 
companion
   report (`create_link` UAF) — nvmet, USB gadget, target core fabric, 
vkms, etc.

## Weakness

Use After Free (cwe-416)

## Description

 > **Version declaration:** every reference below was verified 
line-by-line against the
 > v7.3-rc2 tree attached to this submission; the upstream fix patch 
(f06c2d26d199,
 > verbatim) forward-applies cleanly onto this tree's 
`fs/configfs/dir.c`, proving the
 > audited tree is byte-identical to the pre-fix vulnerable version
 > (`workdir/configfs-audit/presence_check.log`: `B_APPLY=OK`). This 
report is
 > **code-level confirmed** (source + patch pre-image differential + 
syzbot KASAN
 > signature comparison + dual-thread race PoC compiled and 
self-tested); the verdict
 > is a source-logic derivation and does not include a dynamic run on a 
real kernel.

### Summary

configfs maintains a liveness invariant: `configfs_get_config_item()`
(`fs/configfs/configfs_internal.h:120-132`) uses **"the dentry is still 
hashed"** as
the proof that `sd->s_element` points to a live config_item, and on that 
premise
executes `config_item_get()` (a kref acquisition). The complete 
`configfs_rmdir()`
timeline **violates this invariant**: during the entire window from 
dirent teardown to
the last item reference being dropped, the target dentry remains hashed 
— VFS only
unhashes it (`d_delete_notify`, `fs/namei.c:5528`) after 
`configfs_rmdir()` returns.
Any concurrent `symlink(2)` inside that window resolves the dying dentry 
normally via
`kern_path()` (`symlink.c:123`); the subsequent 
`configfs_get_config_item()` reads a
`d_fsdata` that may point to an **already-freed dirent** (UAF read), and its
`s_element` is passed to `config_item_get()` — a kref increment on an
**already-freed config_item** (a refcount-reviving UAF write), i.e. the 
dying/dead
item is "revived".

The syzbot report's KASAN signature `slab-use-after-free in config_item_get`
(symlink.c:128, inlined into configfs_symlink:185) matches this window 
line by line.

### Finding A: Reference acquisition that trusts `!d_unhashed` as a 
liveness proof

**File:** `fs/configfs/configfs_internal.h:120-132` (verified verbatim)

```c
static inline struct config_item *configfs_get_config_item(struct dentry 
*dentry)
{
	struct config_item * item = NULL;

	spin_lock(&dentry->d_lock);
	if (!d_unhashed(dentry)) {
		struct configfs_dirent * sd = dentry->d_fsdata;
		item = config_item_get(sd->s_element);      /* a dying/dead item gets 
a reference */
	}
	spin_unlock(&dentry->d_lock);

	return item;
}
```

Key observations:

- The only liveness evidence is `!d_unhashed`; dentry unhashing, dirent 
delist/free
   and item release happen on **different code paths at different 
times** — no lock
   ordering enforces the invariant.
- `sd` comes from `d_fsdata`: if the dirent was already freed by
   `configfs_remove_dirent()` (`dir.c:271-280`, freed back to 
`configfs_dir_cachep`
   via `release_configfs_dirent` (`configfs_internal.h:134-141`) when 
the count hits
   zero), `d_fsdata` is dangling — the `:126` read and the `:127` 
`config_item_get`
   are both UAFs.
- `get_target()` in `configfs_symlink()` (`symlink.c:117-132`, calling 
this helper at
   `:128`) and `configfs_symlink()` for the parent (`:152`) both rely on 
this helper.

### Finding B: The rmdir-side timeline — never unhashed

**File:** `fs/configfs/dir.c:1545-1576` (verified verbatim)

```c
	/* Get a working ref for the duration of this function */
	item = configfs_get_config_item(dentry);              /* dir.c:1545 */

	if (item->ci_type)
		dead_item_owner = item->ci_type->ct_owner;

	if (sd->s_type & CONFIGFS_USET_DIR) {
		configfs_detach_group(dentry);
		...
	} else {
		configfs_detach_item(dentry);                 /* dir.c:1560 */
		...
	}

	client_drop_item(parent_item, item);                  /* dir.c:1567 */
	mutex_unlock(&subsys->su_mutex);

	/* Drop our reference from above */
	config_item_put(item);                                /* dir.c:1571 — 
last reference dropped */

	module_put(dead_item_owner);
	module_put(subsys_owner);

	return 0;                                             /* dir.c:1576 */
```

Key observations:

- `dir.c:1560 configfs_detach_item` (`:836-841`) → `configfs_remove_dir()`
   (`:410-424`): `:414 configfs_remove_dirent(d)` (`:271-280`: delist +
   `configfs_put(sd)`; the dirent can be freed on the spot); then `:417 
simple_rmdir`
   (`fs/libfs.c:787-822`: only drop_nlink + timestamps; `:808/:819 
d_make_discardable`
   (`fs/dcache.c:1046-1054`) only clears `DCACHE_PERSISTENT` and drops the
   self-reference) — **no unhash call anywhere in this sequence**.
- `dir.c:1571 config_item_put(item)` releases the last item reference; 
when the
   config_item's kref hits zero it is `kfree`d via the release callback in
   `fs/configfs/item.c`.
- Only after `dir.c:1576` returns and `fs/namei.c:5528 d_delete_notify` 
executes is
   the target dentry unhashed.
- Throughout the window `:1560` → `:1576`: **the dentry is still hashed, 
the dirent is
   delisted (or already freed), and the item is dead or dying** — the 
invariant is
   violated systematically.

### Finding C: The concurrent-symlink side — kern_path hits the dying 
dentry and revives the item

**File:** `fs/configfs/symlink.c:117-132, 184-206` (verified verbatim; 
same code as in
the companion report)

- `symlink.c:184-186`: `inode_unlock(dir)` then `get_target()`;
- `symlink.c:123 kern_path(symname, LOOKUP_FOLLOW|LOOKUP_DIRECTORY)`: 
VFS path lookup
   matches hashed dentries, so it hits the still-hashed dying dentry 
normally (holding
   a path reference that temporarily blocks dentry reuse);
- `symlink.c:128 configfs_get_config_item(path.dentry)`: under `d_lock`,
   `!d_unhashed` holds ⇒ `:126` reads `dentry->d_fsdata` (the dirent may 
already be
   freed ⇒ UAF read) and `:127 config_item_get(sd->s_element)` performs 
a kref
   increment on an already-freed config_item (a refcount-reviving UAF 
write =
   "revival");
- If the item's references have not yet reached zero at hit time, the 
revived flow
   continues: `:196 allow_link` → `:199 create_link` → appends a 
reference to the
   delisted/freed dirent and `s_links++` (symlink.c:92/:100 — the same 
sinks as the
   companion report) — the dying item is spliced into a fresh symlink 
dependency graph,
   completely corrupting both lifetimes.

### Differential verification and syzbot comparison

The upstream fix f06c2d26d199 forward-applies cleanly onto the audited 
tree's
`fs/configfs/dir.c` (`workdir/configfs-audit/presence_check.log`: 
`B_APPLY=OK`); the
fix adds `d_drop(d)` in the `simple_rmdir` success branch of 
`configfs_remove_dir()`
(unhash before dropping references), and that line is absent from the 
audited tree by
grep; the line-by-line diff between the audited tree and the fixed tree 
is archived
(`workdir/configfs-audit/local-vs-fixed-B-dir.diff`, 18 lines). The fix 
commit's
`Reported-by: syzbot+6b16e3d085833cbf3e25` and its KASAN report
(`slab-use-after-free in config_item_get`, symlink.c:128 inlined into
configfs_symlink:185) correspond line by line to the source-level window 
above.

### Versions Verified

| Version | rmdir never unhashes | `configfs_get_config_item` takes an 
item ref on `!d_unhashed` | Fix in tree |
| --- | --- | --- | --- |
| v7.3.0-rc2 (audited tree) | ❌ Present (dir.c:410-424/1560-1576) | ❌ 
Present (configfs_internal.h:120-132) | No (fix f06c2d26d199 lands in 
the rc3 window) |

The defect dates back to the introduction of configfs (7063fbf22611, 
2005) and the
upstream fix carries `Cc: stable`; all current mainline and stable/LTS 
branches are
expected to be affected as well. No compensating mechanism restoring the 
violated
invariant was found anywhere in the audited tree.

---

## Steps To Reproduce

**Pre-conditions:**

- configfs mounted (typically `/sys/kernel/config`; mounting requires
   `CAP_SYS_ADMIN` in the initial namespace, and the directory commonly 
exists on
   default configurations).
- Attacker has write permission on some configfs client tree (typically 
root, or a
   regular user authorized via DAC).
- The link parent directory's `ct_item_ops->allow_link` is non-NULL
   (`symlink.c:156-158` checks for the callback's existence first; the 
`get_target` UAF
   happens at `:185`, before the callback invocation at `:196`, but the 
existence check
   at `:156-158` must pass). Usable implementations: nvmet
   (`drivers/nvme/target/configfs.c:1056/:1126`), USB gadget
   (`drivers/usb/gadget/configfs.c:426/:519`), target core fabric
   (`drivers/target/target_core_fabric_configfs.c:224/:713`), vkms
   (`drivers/gpu/drm/vkms/vkms_configfs.c:243/:280`), etc.
- Trigger surface: a dual-thread race between `symlink(2)` and 
`rmdir(2)`, purely
   user-space input.

**White-box reproduction steps (source-logic derivation):**

1. Target and parent selection as in the companion report:
    `/sys/kernel/config/nvmet/subsystems/poc_uaf_t` (a rmdir-able client 
item) and
    `.../ports/poc_uaf_p/subsys_link` (the allow_link parent directory).
2. Thread R (rmdirer): pinned to a core, loop `rmdir(target)` + `mkdir` 
to recreate
    (retry on `-EBUSY`), so the system spends as much time as possible 
in the window
    after `configfs_remove_dirent` has completed but before 
`d_delete_notify` runs.
3. Thread S (symlinker): high-frequency `symlink(target, parent/lkN)` so 
that
    `get_target`'s `kern_path` repeatedly resolves the dying dentry and 
lands in
    `configfs_get_config_item` at `symlink.c:128`.
4. Hit observation (either of the following):
    - KASAN kernel: `slab-use-after-free in config_item_get` 
(symlink.c:128, inlined
      into configfs_symlink:185) — the original syzbot report signature;
    - non-KASAN kernel: the `WARN_ON(!s_count)` at 
configfs_internal.h:146, a
      config_item kref_get refcount WARN, or post-revival lifetime 
confusion (rmdir has
      already returned `-EBUSY`/succeeded while the object is still 
referenced by a
      symlink).
5. Companion PoC: `workdir/configfs-audit/poc_configfs_uaf_race.c --mode b`
    (the same harness as the companion report; compiles with zero 
warnings; the thread
    machinery was self-tested on a plain filesystem, see
    `workdir/configfs-audit/build_check.log`). The PoC refuses live-fire 
by default;
    live-fire requires an explicit flag on a disposable environment.

**Actual result (white-box logic reproduction):** every link in the 
impact chain closes
at source level — `kern_path` (user-controlled path) → hashed dying dentry →
`configfs_get_config_item` (configfs_internal.h:120-132) → 
`config_item_get` UAF
write → the subsequent `create_link` dirent sinks; the audited tree's 
exposure is
further proven by the byte-exact patch pre-image comparison. **Passed 
white-box logic
reproduction.** No dynamic trigger on a real kernel environment is 
claimed; running
the PoC above on a disposable KASAN kernel is the recommended final dynamic
confirmation.

**Expected result (of the fixed behavior):** a race hit causes a UAF on 
freed objects
(KASAN slab-use-after-free / refcount WARN), contradicting the safe 
expectation that a
dying item cannot acquire new references.

---

## Impact

| Aspect | Detail |
| --- | --- |
| **Attack requirement** | configfs mounted + write access to a client 
tree (root or DAC-authorized user) + non-NULL `allow_link` on the 
parent; the trigger is a race between two ordinary syscalls |
| **Permission boundary** | Mounting requires `CAP_SYS_ADMIN` in the 
initial namespace; exposure widens where containers rw-mount configfs or 
DAC-loosened client trees are deployed |
| **Confidentiality** | UAF reads of freed dirent/config_item memory 
regions (`s_element` etc.); with controlled cross-allocation, stale 
kernel data can be read across objects |
| **Integrity** | A `kref_get` UAF write on an already-freed config_item 
(refcount revival): after rmdir completes and the object is `kfree`d, 
the attacker still holds a "legitimate handle-grade" reference and can 
`config_item_put` it again — a double free on a generic slab 
(`fs/configfs/item.c`); the revived item can also be spliced back into 
the `s_links` dependency graph via `create_link`, corrupting the whole 
lifecycle state machine |
| **Availability** | A hit is WARN/BUG/kernel crash (local DoS) |
| **Severity** | Medium-High. CVSS 3.1 
`AV:L/AC:H/PR:H/UI:N/S:C/C:H/I:H/A:H` ≈ **6.6**; a revived reference 
plus controlled cross-allocation on a generic kmalloc-x slab (with 
controllable name/parent fields) provides even more general 
LPE-primitive conditions than a dedicated slab — raised where a 
less-privileged user can write the client tree |
| **CVE eligibility** | Yes. Memory-safety defect (CWE-416), present in 
every mainline/stable branch since 2005 (7063fbf22611); upstream fix 
f06c2d26d199 carries `Cc: stable` and is corroborated by a syzbot KASAN 
report; suitable for a CVE ID via the kernel CNA (security@kernel.org 
process), referencing the fix commit and the syzbot report |
| **Submission channels** | ① GitHub private vulnerability reporting 
(`https://github.com/torvalds/linux/security/advisories/new`, verified 
302→login flow = enabled form; the GitHub tree is a read-only mirror); ② 
the kernel's official security policy mailbox `security@kernel.org` 
(explicitly designated at `Documentation/process/security-bugs.rst:281` 
— the authoritative channel); ③ maintainer public mailbox 
`torvalds@linux-foundation.org` (MAINTAINERS "THE REST" entry); ④ the 
MITRE CVE form 
(`https://mitre.github.io/mitre-cve-roles/cve-id-request/`, the official 
redirect target of cveform.mitre.org) as fallback. VulDB's submission 
entry could not be verified (anti-bot 403) and is not listed |

Additional notes:

- This defect and the companion report "configfs `create_link()` 
dereferences freed
   target dentry/dirent" are **two independent root causes** under the 
same trigger
   surface: the root cause here is the invariant violation on the rmdir 
side (fix
   f06c2d26d199: `d_drop(d)` inside `configfs_remove_dir` before 
references are
   dropped); the companion's root cause is the bare dereference of 
`->ci_dentry` in
   `create_link()` (fix a7c1290eef60). The two upstream fix commits exist
   independently and both carry `Cc: stable`.
- Fix rationale: `configfs_remove_dir()` executes `d_drop(d)` in the 
`simple_rmdir`
   success branch so the dentry is unhashed before the item's last 
reference is
   released, restoring the "hashed ⇒ item alive" invariant at the root.

