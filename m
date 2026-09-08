Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5537A494
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 06:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848500; cv=none; b=oC/uOX+VXV4oiCXxNiq25WKAo1VgVv1ASSLIEXW+70Bkb7pS5nVYM40oambm3gMLNM0eA9pOvopxZNr6mANm7+xRnbTzVyQA+t1r2wB7YCmzg0MrASNURHPFaVWU4eWXoVHbTWHmGKytTeLsGpfDcwjvIy8rh17Ip09W+Nv4tS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848500; c=relaxed/simple;
	bh=cGOJP8fzsdO9eiR+ckMuawjiyo5w2FAT1XizFngxr/U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Tx3DG+S+zM+ZXR9aqBVSq5Pxu6fizhCOya0rWoD4xqE8W8FSJvuPLVj0OBsOKp13L/tm/7X6uHsKYqzaXXRx5AxIiXOt5QxyKqsCwyqcLmnxt34L8PPmT6dIP8/eHLfbifhJCPNOd3DrhQQ2/28YqaJnLuxznndBL+f3K02qVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RbuQKy24; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RbuQKy24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1788848493; bh=1Lbz0a/kGEt/qUOrgwdlDMfdtoNxzF36Z7v4+A/ClrI=;
	h=Date:From:Subject:To:Cc;
	b=RbuQKy24kxoMjRqGO7xYBG8LWR1eQHV6qwmN2OJsBNkp2dhgOV86Ea0ZjUyLKvX1x
	 iHkzM4WSKfJhEUmaaWpZRBY5jqGq8h9w7h4qnYmHeqEnitVQKXhy/aFEy9Vx6U2XVi
	 NIlMOf85JS4YvrNrl+0VdgcgIw4+bsEi8qJOxLoY=
Received: from [192.168.0.109] ([120.227.46.204])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 55EB1ECA; Tue, 08 Sep 2026 14:21:30 +0800
X-QQ-mid: xmsmtpt1788848490tfm5jcx83
Message-ID: <tencent_BB2769F75E03D124478269551A60E678C205@qq.com>
X-QQ-XMAILINFO: MzFuFcyvqEECm8sHqzx5gTxMI92P71buhvFTajeR7K9C5PikRFU3e5WWEPDOkM
	 /XzPF+HLNyGnEhR8ewdob8zml3zs2alFZNBLKuwJBVdF91xkIN74XdQF9o1TObrm/vwQdAH/lkb1
	 GYZrAhyuHL+CDvHiPR4Ttx2nliibln+XU6pNe6GfK2mXJSCNeEVriByZNzFuILryJXhB4iCxBm0K
	 c9FYJvNnZuHQFj4eRx+IBdmYuuEoKK2tmFrr740kHSSav1p7gx6JrJQWiM+NR/XK3V0AIusj7BFv
	 qRPQWm96CND7LdcinYcNeBEaVvBrYSGYOhu1YD3Xsj95BJ9c9BQ92mMiyo18KViTahF/qOj4Cm4E
	 wzb+Ra0ZBc35ruvXdMaF380lfQZYuG2XpEAK6O1J/DT3O6CSFPYE4+ihonitRswdY4VDlyUZepf4
	 RVZDi7lAoW1evA8gbIEHki7TRpVVjVQSAhVy6CadnFCb9cBx1uM7FMabgJRRG4L5Ax1V+kix2x06
	 s5ly6jHTdIB3xCVqepWOxQ/Q7pB3TcvMl7jVIP7OAjN1w988/IhDsUE8JX7RD5OqUpv4AuxsAQT/
	 KrwFVhxkSpKBVf5r6HCM3VKzwBdbtapTdnjj6uoDs6rw9vVGCrlpMJV5AZCaanw2+XA6piHVeXNl
	 s01mPCNwnBPcCJrPBbiVicASl/WjpUQGwYTdczt8wirIxABB0+zRzs625RlxmE+BUBzd4WYbvU5Q
	 N+nmtWPwNwwnllGhM0R98DSm08uM3MFj+HXDwa8H8ePYHlXgdyZN/V7c7xQWHhJM2XZ0VQ7v+Zoe
	 VWVdvL7Q3wSTUeS+Nz2XdDCuiKd5YNntLvr1OxZ57zEkSsgv5/vQ2RaC6asmgIxqNol0lq+jGNFr
	 nH1jqbv4/+MwU06nS/vcun87FDJ76CorjHkKk2SoKCpSwQLXhV2HMlOR0mXWj+MZ+ptsBkR9z/tr
	 qm6u0wlC0xrZY1rqslbC/YoMdiPo+EzkG9yW0D++IL7vY3OIkDNUClvI3A78VxLTeNUtgcRtVm7z
	 zB/wWTLapQO6S8XTyYCJihaGzp6wyaDQf3Dlfv4u+WGwO8UY+ulKb7YJsLF/xkIdMFKaqxQo1tj8
	 c/l1Px/SJ8HDnl4YbMTpPMZZTvC6cxCr2uZuw3IxEU1u7eOjUHtjCq85sI1sE+XvHG8oi86U2Jdf
	 PkRB4=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-OQ-MSGID: <256a93f8-a6d2-41ea-87ee-af5dde130c77@qq.com>
Date: Tue, 8 Sep 2026 14:21:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: tms <2478511876@qq.com>
Subject: =?UTF-8?Q?Linux_kernel_v7=2E3-rc2=3A_configfs_create=5Flink=28=29_d?=
 =?UTF-8?Q?ereferences_freed_target_dentry/dirent_=E2=80=94_symlink=282=29?=
 =?UTF-8?B?w5dybWRpcigyKSByYWNlIChDV0UtNDE2KQ==?=
To: security@kernel.org, a.hindborg@kernel.org, w@1wt.eu
Cc: stable@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

# Linux kernel v7.3-rc2: configfs create_link() dereferences freed 
target dentry/dirent — symlink(2)×rmdir(2) race (CWE-416)

Last saved at 2026-09-08

## Asset

Linux kernel (torvalds/linux source tree) — the **configfs** filesystem 
subsystem,
specifically the `configfs_symlink()` / `get_target()` / `create_link()` 
path in
`fs/configfs/symlink.c`.

- Affected version declaration: the audited source tree is **v7.3.0-rc2**
   (`Makefile`: `VERSION = 7`, `PATCHLEVEL = 3`, `SUBLEVEL = 0`,
   `EXTRAVERSION = -rc2`, verified). The defect has existed in every 
mainline and
   stable/LTS branch since configfs was introduced by commit 
7063fbf22611 (merged in
   2005, v2.6.19-rc1, `"configfs: User-driven configuration 
filesystem"`). The upstream
   fix is a7c1290eef60 (`"configfs: pin the symlink target's dirent 
instead of chasing
   ->ci_dentry"`, `Fixes: 7063fbf22611`, `Cc: stable`), merged via the 
configfs-7.3-rc3
   pull — i.e. the fix lands after v7.3-rc2 and before rc3, so the 
audited v7.3-rc2
   tree sits inside the vulnerable range.
- Dependent components: any configfs client subsystem that provides a
   `ct_item_ops->allow_link` callback (confirmed against live 
implementations in this
   tree: NVMe target, USB gadget, target core fabric, vkms — see Finding C).

## Weakness

Use After Free (cwe-416)

## Description

> **Version declaration:** every reference below was verified 
line-by-line against the
> v7.3-rc2 tree attached to this submission; the upstream fix patch 
(a7c1290eef60,
> verbatim) forward-applies cleanly onto this tree's 
`fs/configfs/symlink.c`, proving
> the audited tree is byte-identical to the pre-fix vulnerable version 
(presence
> verification record: `workdir/configfs-audit/presence_check.log`). 
This report is
> **code-level confirmed** (source + patch pre-image differential + 
dual-thread race
> PoC compiled and self-tested); the verdict is a source-logic 
derivation and does not
> include a dynamic run on a real kernel — see Steps To Reproduce for 
the white-box
> reproduction path.

### Summary

When creating a symlink, `configfs_symlink()` 
(`fs/configfs/symlink.c:135`) treats a
**config_item reference** on the target as a guarantee that the target's
**dentry/dirent** remain alive. Those lifetimes are decoupled:

1. `get_target()` (`symlink.c:117-132`) only takes an item reference via
    `configfs_get_config_item(path.dentry)`; the reference on the target 
dentry lives in
    `struct path __free(path_put)` and is dropped when the function returns.
2. The `configfs_symlink()` body runs `inode_unlock(dir)` → `get_target()` →
    `inode_lock(dir)` (`symlink.c:184-186`), then still executes the 
user-timed
    `allow_link` callback (`symlink.c:196`) — between `get_target` 
returning and
    `:199 create_link()`, **the symlink thread holds no lock and no 
reference on the
    target dentry or dirent**.
3. The only resident pin on a live item's dentry is the `DCACHE_PERSISTENT`
    self-reference set by `d_make_persistent()` (`dir.c:319`, 
`dir.c:389`). But
    `configfs_remove_dir()` on the rmdir path (`dir.c:410-424`) tears 
that pin down
    **while the item is still alive**: it first runs 
`configfs_remove_dirent(d)`
    (`dir.c:271-280`: delist + `configfs_put(sd)`; when the count 
reaches zero the
    dirent is freed back to the dedicated slab `configfs_dir_cachep` via
    `release_configfs_dirent`, `configfs_internal.h:134-141`), then 
`simple_rmdir`
    (`fs/libfs.c:787-822`, whose `d_make_discardable` 
(`fs/libfs.c:808/:819`,
    implemented in `fs/dcache.c:1046-1054`) clears `DCACHE_PERSISTENT` 
and drops the
    self-reference). The last item reference is only released at
    `dir.c:1571 config_item_put(item)`; VFS unhashes the target dentry
    (`d_delete_notify`, `fs/namei.c:5528`) even later, after 
`configfs_rmdir()` returns.

The result is a release race window: **the rmdir thread can complete the
PERSISTENT teardown and free the target dentry (dentry slab) and dirent
(`configfs_dir_cachep`) while the symlink thread is parked between `:196 
allow_link`
and `:199 create_link`.** `create_link()` then dereferences 
`item->ci_dentry->d_fsdata`
bare at `:81` — a UAF read of the freed dentry — and the stale dirent 
pointer read from
freed memory is touched at `:85` and `:92` — a UAF read plus a 
refcount-reviving write
on a freed `configfs_dirent`.

### Finding A: Broken reference chain — the item reference does not keep 
`->ci_dentry` alive

**File:** `fs/configfs/symlink.c:117-132` (verified verbatim)

```c
static int get_target(const char *symname, struct config_item **target,
		      struct super_block *sb)
{
	struct path path __free(path_put) = {};
	int ret;

	ret = kern_path(symname, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &path);
	if (ret)
		return ret;
	if (path.dentry->d_sb != sb)
		return -EPERM;
	*target = configfs_get_config_item(path.dentry);   /* :128 takes an 
item ref only */
	if (!*target)
		return -ENOENT;
	return 0;
}   /* __free(path_put) drops the dentry reference on return */
```

Key observations:

- `configfs_get_config_item()` (`configfs_internal.h:120-132`) takes
   `config_item_get(sd->s_element)` under `d_lock`, using `!d_unhashed` 
as the liveness
   proof — **it grabs an item reference, not a dentry reference and not 
a dirent
   reference**.
- The fix commit a7c1290eef60's own comment acknowledges the break: "An 
item reference
   alone would not keep ->ci_dentry alive." The fix pins the dirent in 
`get_target`
   (`configfs_get(sd)`) as well; the audited tree, confirmed via the 
patch pre-image,
   contains no such second reference.

### Finding B: The zero-reference window and its user-controlled amplifier

**File:** `fs/configfs/symlink.c:184-204` (verified verbatim)

```c
	inode_unlock(dir);
	ret = get_target(symname, &target_item, dentry->d_sb);   /* :185 */
	inode_lock(dir);
	if (ret)
		goto out_put;

	if (dentry->d_inode || d_unhashed(dentry))
		ret = -EEXIST;
	else
		ret = inode_permission(&nop_mnt_idmap, dir,
				       MAY_WRITE | MAY_EXEC);
	if (!ret)
		ret = type->ct_item_ops->allow_link(parent_item, target_item);  /* :196 */
	if (!ret) {
		mutex_lock(&configfs_symlink_mutex);
		ret = create_link(parent_item, target_item, dentry);            /* :199 */
		mutex_unlock(&configfs_symlink_mutex);
		...
	}
```

Key observations:

- `:196 allow_link` is a client-subsystem callback whose duration is 
user-controlled
   (it may block or loop); during this window the symlink thread holds 
no reference and
   no lock on the target dentry/dirent.
- On the rmdir side (`fs/configfs/dir.c:1560 configfs_detach_item(dentry)` →
   `:410-424 configfs_remove_dir()`), the PERSISTENT pin is torn down 
and the dirent can
   be freed while the item is still alive (Summary point 3); the item 
survives until
   `dir.c:1571 config_item_put(item)` — i.e. "target item still alive" 
and "target
   dentry/dirent already freed" can coexist.
- The target item must be a rmdir-able client item (default groups 
return `-EPERM` at
   `dir.c:1480-1481` and cannot be rmdir'ed directly) — nvmet 
subsystems, USB gadget
   functions, etc. all qualify.

### Finding C: Dangerous sinks — the bare deref at `:81` and the dirent 
touches at `:85`/`:92`

**File:** `fs/configfs/symlink.c:77-101` (verified verbatim)

```c
static int create_link(struct config_item *parent_item,
		       struct config_item *item,
		       struct dentry *dentry)
{
	struct configfs_dirent *target_sd = item->ci_dentry->d_fsdata;   /* :81 
UAF read of dentry */
	char *body;
	int ret;

	if (!configfs_dirent_is_ready(target_sd))                        /* :85 
UAF read of dirent */
		return -ENOENT;

	body = kzalloc(PAGE_SIZE, GFP_KERNEL);
	if (!body)
		return -ENOMEM;

	configfs_get(target_sd);                                          /* 
:92 UAF read+write of dirent */
	spin_lock(&configfs_dirent_lock);
	if (target_sd->s_type & CONFIGFS_USET_DROPPING) {
		...
	}
	target_sd->s_links++;                                             /* 
:100 write to freed dirent */
	spin_unlock(&configfs_dirent_lock);
	...
}
```

Key observations:

- `:81`: the dentry pointed to by `item->ci_dentry` has been unpinned 
and freed by the
   rmdir path (dentry slab) — the `d_fsdata` read is a stale pointer 
taken from freed or
   reused memory.
- `:85`: `configfs_dirent_is_ready()` (`dir.c:358-368`) reads 
`sd->s_type` under
   `configfs_dirent_lock` — a UAF read of the freed dirent.
- `:92`: `configfs_get()` (`configfs_internal.h:143-150`) executes
   `WARN_ON(!atomic_read(&sd->s_count)); atomic_inc(&sd->s_count);` — a 
UAF read plus a
   refcount-reviving write on the freed dirent.
- `configfs_dirent` is allocated from the dedicated slab 
`configfs_dir_cachep`
   (`configfs_internal.h:64`, `dir.c:193 kmem_cache_zalloc`); an 
attacker can groom it
   precisely with mkdir/rmdir floods, making heap cross-allocation fully 
controllable.

### Differential verification (why this is a kernel configfs defect)

The upstream fix a7c1290eef60 forward-applies cleanly onto the audited 
tree's
`fs/configfs/symlink.c` (`workdir/configfs-audit/presence_check.log`: 
`A_APPLY=OK`),
and the fix's newly added dual-reference code is absent from the audited 
tree by grep;
the line-by-line diff between the audited tree and the fixed tree is 
archived
(`workdir/configfs-audit/local-vs-fixed-A-symlink.diff`, 76 lines). The 
fix changes
`create_link` to use a `target_sd` pinned by `get_target` inside the 
dentry's live
window instead of chasing `item->ci_dentry->d_fsdata`, closing this 
window at the root.

### Versions Verified

| Version | Bare deref of `->ci_dentry` at `:81` | Zero-reference window 
(`get_target` returns → `create_link`) | Fix in tree |
| --- | --- | --- | --- |
| v7.3.0-rc2 (audited tree) | ❌ Present (symlink.c:81) | ❌ Present 
(symlink.c:184-204) | No (fix a7c1290eef60 lands in the rc3 window) |

Because the defect dates back to the introduction of configfs 
(7063fbf22611, 2005) and
the upstream fix carries `Cc: stable`, all current mainline and 
stable/LTS branches are
expected to be affected as well; no compensating mechanism closing this 
window was
found anywhere in the audited tree.

---

## Steps To Reproduce

**Pre-conditions:**

- configfs mounted (typically `/sys/kernel/config`; mounting requires
   `CAP_SYS_ADMIN` in the initial namespace, but subsystems such as 
netconsole trigger
   the mount routinely via `configfs_pin_fs`, so the directory commonly 
exists on
   default configurations).
- Attacker has write permission on some configfs client tree (typically 
root, or a
   regular user authorized via DAC).
- The link parent directory's `ct_item_ops->allow_link` is non-NULL. Live
   implementations confirmed in this tree:
   `drivers/nvme/target/configfs.c:1056/:1126` (nvmet port `subsys_link`),
   `drivers/usb/gadget/configfs.c:426/:519` (USB gadget),
   `drivers/target/target_core_fabric_configfs.c:224/:713`,
   `drivers/gpu/drm/vkms/vkms_configfs.c:243/:280` (vkms).
- The trigger surface is just two ordinary VFS syscalls racing: 
`symlink(2)` ×
   `rmdir(2)`; no special ioctls, no special capabilities.

**White-box reproduction steps (source-logic derivation):**

1. `mkdir` a rmdir-able target item under 
`/sys/kernel/config/nvmet/subsystems/`
    (e.g. `poc_uaf_t`); choose the link parent directory
    `/sys/kernel/config/nvmet/ports/poc_uaf_p/subsys_link` (its item_ops'
    `allow_link` is `nvmet_port_subsys_allow_link`).
2. Thread R (rmdirer): loop `rmdir(target item)`; on success immediately 
`mkdir` to
    recreate; retry on `-EBUSY`. This thread executes
    `dir.c:1560 configfs_detach_item` → `configfs_remove_dir` (tears the 
PERSISTENT
    pin, frees the dirent) → `dir.c:1571 config_item_put` → returns → 
VFS unhash
    (`fs/namei.c:5528`).
3. Thread S (symlinker): loop `symlink(target, parent/lkN)`, `unlink` on 
success.
    Use scheduling priority/affinity so that S lingers as long as 
possible in the
    `:196 allow_link` → `:199 create_link` range after `get_target` 
returns; R's rmdir
    completes the PERSISTENT teardown and the dentry/dirent free inside 
that range.
4. Hit observation (either of the following; both are the necessary 
expression of the
    source logic):
    - KASAN kernel: `slab-use-after-free` in `create_link` 
(symlink.c:81, dangling
      dentry) or in `configfs_dirent_is_ready` / `configfs_get` 
(dangling dirent,
      slab `configfs_dir_cachep`);
    - non-KASAN kernel: the `WARN_ON(!s_count)` in `configfs_get`
      (configfs_internal.h:146), corrupted dentry/dirent fields, or 
symptoms of a
      revived `s_count` being released twice.
5. Companion PoC: `workdir/configfs-audit/poc_configfs_uaf_race.c --mode a`
    (dual-thread race harness, compiles with zero warnings; the thread 
machinery was
    end-to-end self-tested on a plain filesystem, see
    `workdir/configfs-audit/build_check.log`). The PoC refuses live-fire 
by default
    (safety gate); live-fire requires an explicit flag on a disposable 
environment.

**Actual result (white-box logic reproduction):** the source control 
flow, data flow and
required conditions all close — attacker input (two syscalls) → race 
window (the
zero-reference range symlink.c:184-204 including the user-controlled 
allow_link) →
releaser (rmdir thread, configfs_remove_dir, dir.c:410-424) → sinks
(symlink.c:81/:85/:92) all hold at source level. **Passed white-box logic
reproduction.** No dynamic trigger on a real kernel environment is 
claimed; running the
PoC above on a disposable KASAN kernel is the recommended final dynamic 
confirmation.

**Expected result (of the fixed behavior):** a race hit causes a kernel 
UAF (KASAN
reports slab-use-after-free; non-KASAN hits WARN/BUG), contradicting the 
safe expected
behavior of returning `-ENOENT`.

---

## Impact

| Aspect | Detail |
| --- | --- |
| **Attack requirement** | configfs mounted + write access to a client 
tree (root or DAC-authorized user) + non-NULL `allow_link` on the 
parent; the trigger is a race between two ordinary syscalls |
| **Permission boundary** | Mounting requires `CAP_SYS_ADMIN` in the 
initial namespace, yet the surface is commonly exposed in 
multi-tenant/container deployments (nested environments rw-mounting 
configfs, DAC-loosened netconsole/nvmet trees) |
| **Confidentiality** | UAF reads of dangling dentry/dirent fields; with 
a controlled cross-allocation on the dedicated slab, stale kernel 
pointer data can be read across objects |
| **Integrity** | `:92 atomic_inc(&sd->s_count)` revives the refcount of 
a freed dirent so the same object can be released twice 
(`release_configfs_dirent`, configfs_internal.h:134-141); `:100 
s_links++` corrupts the state of a reallocated object and breaks the 
link dependency graph |
| **Availability** | A race hit is WARN/BUG/kernel crash (local DoS) |
| **Severity** | Medium-High. CVSS 3.1 
`AV:L/AC:H/PR:H/UI:N/S:C/C:H/I:H/A:H` ≈ **6.6**; raised where configfs 
client trees are writable by less-privileged users (containers 
rw-mounting configfs / DAC-loosened trees), where controlled 
cross-allocation on a dedicated slab plus double-free forms a mature 
local privilege escalation primitive |
| **CVE eligibility** | Yes. Memory-safety defect (CWE-416), present in 
every mainline/stable branch since 2005 (7063fbf22611), upstream fix 
a7c1290eef60 carries `Cc: stable`; suitable for a CVE ID via the kernel 
CNA (security@kernel.org process), referencing the fix commit and the 
associated syzbot report |
| **Submission channels** | ① GitHub private vulnerability reporting 
(`https://github.com/torvalds/linux/security/advisories/new`, verified 
302→login flow = enabled form; note the GitHub tree is a read-only 
mirror); ② the kernel's official security policy mailbox 
`security@kernel.org` (explicitly designated at 
`Documentation/process/security-bugs.rst:281` — the authoritative 
channel); ③ maintainer public mailbox `torvalds@linux-foundation.org` 
(MAINTAINERS "THE REST" entry); ④ the MITRE CVE form 
(`https://mitre.github.io/mitre-cve-roles/cve-id-request/`, the official 
redirect target of cveform.mitre.org) as fallback. VulDB's submission 
entry could not be verified (anti-bot 403) and is not listed |

Additional notes:

- This defect and the companion report "configfs rmdir leaves the target 
dentry hashed —
   concurrent symlink revives a dying item" share the same pair of 
syscalls but are
   **two independent root causes**: this report is the bare dereference 
of `->ci_dentry`
   in `create_link()` (fix a7c1290eef60); the companion is
   `configfs_get_config_item()` using `!d_unhashed` as the liveness 
proof (fix
   f06c2d26d199). Each has its own upstream fix commit, both carry `Cc: 
stable`, and
   both share the syzbot `syzbot+6b16e3d085833cbf3e25` KASAN crash-stack 
association.
- The upstream remedy is already implemented: `get_target()` pins the 
dirent as well
   (`configfs_get(sd)`) inside the dentry's live window, and 
`create_link()` uses that
   `target_sd` to build the link instead of chasing `->ci_dentry`.

