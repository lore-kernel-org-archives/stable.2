Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1680437130
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386631; cv=none; b=TyC45NRGu8oO8arY/pnJXqI55tuZ3RXGWJmVDmhYPyRiImqu6E1zPgGFyRjrOlAzhTvixfw1wIYnPiYf0cxjiEJJHZ92ndWOcaDyAUVFZqKhQJ49Q+Patwe9YZBt18EYhTxcG3UW2gzT8GEpqekFqI9sGBclTexhtMufr2kDXS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386631; c=relaxed/simple;
	bh=e4k9uDCZJqMsaHoGUfEXMC98BegQ+PL0kOH6ev2mS24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oe5UcPgINFEHhxHrA+aLXD11VlN9Sy3Eh6/jAazzsvirA4t8G3I0d5yyCdTlhTmQb8Ss8dyEpZZZisLtI+8YIyhnFU22HgRR24F4FN5ELq/nYwIPedJm2K4Xcxw9u8g6T/dLyam4Q/nL+mZwVpip/JFnpUE9vqQckJug4wgOIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8bbUzyp; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8bbUzyp"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1459884a12.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 11:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386629; x=1786991429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jHGYfRwrvjsJp3TM66oHmnwWqtIxW+4ymQvyIWeruC0=;
        b=Z8bbUzyp4Y5LD4IwgFZYrJgJC/NTv+5P46v8pTIgQFk0O0HsyKxXGa0hSs8ZpNCc5p
         0/tqCVkZhAcXCfXFzeRChhVCdkWot+4G4WFYQ65Oey/j0e6x+RhUFRvIa1xReK8CXyJu
         nv+kmb1T2/dkO6Ifd0YbOYLvLUqm53I56/jq6fp93LTsTfYs+TSU8SgJ6sFRA/PubRkH
         dmkS4mCx4kqhzqgzuKGbWhefPpuI3mOcThky3tmpKfe2k1PdamMjF5z8OtjyYQb/flE5
         4CAlelJ3mhNqxoeTWnoO5kQ2fzLDq/yxnl9yw5tQP7KgxkDjxNsskjLfgSFZ1DXZ7K/s
         FCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386629; x=1786991429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jHGYfRwrvjsJp3TM66oHmnwWqtIxW+4ymQvyIWeruC0=;
        b=dBcE8vXPpPwZT7fcEU5CJ8NEMzXZgLjjz+5Co9z13YHEBUp0RA9BTL4CsnNZeR9ZtY
         J7HRxejj7+McS1yJkHKvT3rMcdMbp3QYCJ+4KBTkikbDQtGlihhErlOlY3Qv5SvnmEMs
         GD23wudSa4t0d+0bSb8dAeiU/aD02ql9p/amRCT9AfRAg2j75VB0OzPhPEQj4HYxTzGw
         Df1cTcT0O36zF3tQ7L+4kpClutaiHfUSk9Ph9HvpTk1szFc4BvFT8aQEC6cndfkBNKmW
         7LHHUhhrgmVtI62bR9BWrUzS+Xdg6MrjGU4Rj9C+UuMnLuKFlxLdrt/WhgaXuNdKH3Xy
         Gz3Q==
X-Forwarded-Encrypted: i=1; AHgh+RqCPtFxgeh26cB1fre2PQWXYpLsPhCpzIPgu+Gp3JZNtQAexoqCr2ofhCnAnkBm/qYALmJ1Tdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIf+l6grh8Y1ACJAVk1FbmUotgL5bRUHLbnb11hhhE3wR5HMm+
	nzk9kJedd8ThVMjGaFNbMimBv19DwcP8Z/hjSYfG5hFouSFuBjSKtjqI
X-Gm-Gg: AR+sD13R4tp6kb5cvNJscmGhxK2t1k8d1MSZKdskryfwvzbZLrsAdusuNgmlkwwkhFv
	vSTNPDCoeXTM5c5WzZVJEv5z6ou9ZShZzMk2YiVNAPyGUUG1qK8BIA8c7/iq98DG0mzm/nvXvLz
	hpkXf6P0lYzn615sNJ5nvBz3IxiNR4KkoGc/XKCsf1R59LLRSUB+UUso1p3409LHrOCcyf1sFnw
	ioN5q40iVbwMt3uJdSV0dXYKPkLxbNFmadmSc8sL2sxJKdl9KpiIKu0uTtV9szhX5eSQ1g3Nd8F
	ollkSrsqmPB3eFM8sqFhIkOouK2Ezc/L+PEgUn7mQMRJu94xNusFgYq60jNS1nBl6qPkvT1faYz
	zgZ5LgB/1/E4XLYPHN4nqyfDv94oixLBlRb2gRYvsoUQvpY8xDHKMVVGEUFns08GLbxr99ymgsk
	BE7M8t9TudWEhlEsmJIJE2eT7jqeMu4qgSYCg5pNtGaImEYdRuTirncD0P5GDlcjYjQs8WXSdFj
	AvmdSLCHaK7fhfKoQ==
X-Received: by 2002:a05:6a00:3a11:b0:847:9188:e492 with SMTP id d2e1a72fcca58-84f9c9b6d6bmr3399185b3a.22.1786386628920;
        Mon, 10 Aug 2026 11:30:28 -0700 (PDT)
Received: from acer-nitro-anv15-41.entro.com ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3d3422sm4335399b3a.19.2026.08.10.11.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:30:28 -0700 (PDT)
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	tony.luck@intel.com,
	bp@alien8.de
Cc: linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH] cxl/mce: Only act on uncorrected memory errors
Date: Tue, 11 Aug 2026 00:00:13 +0530
Message-ID: <20260810183013.47085-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_handle_mce() offlines the aliased page of an ELC region on any
record with a usable address; it does not check MCI_STATUS_UC or
filter non-memory errors. uc_decode_notifier(), the equivalent
handler for plain memory on the same chain at the same priority,
filters on mce->severity and leaves corrected errors untouched.
cxl_handle_mce() has no such gate, so a corrected error - which
the generic handler ignores - still causes the alias to be
permanently retired via memory_failure().

Corrected errors do reach the chain: machine_check_poll() logs
them via the same mce_gen_pool_process() path that feeds
x86_mce_decoder_chain, and cxl_extended_linear_cache_resize()
extends p->res to cover the DRAM half of the ELC pair, so a
routine DRAM CE carries an address inside the region resource.

Filter the record as nfit_handle_mce() does. Commit fc08a4703a41
("acpi, nfit: Fix the memory error check in nfit_handle_mce()") and
commit 5d96c9342c23 ("acpi/nfit, x86/mce: Handle only uncorrectable
machine checks") established this filter for an equivalent handler
on the same notifier chain; the consequence here is more severe, as
the CXL handler calls memory_failure() rather than recording a bad
block.

mce_is_correctable() is used instead of copying
uc_decode_notifier()'s AO/DEFERRED test because the alias must
still be offlined on MCE_AR_SEVERITY, where kill_me_maybe() owns
the reported page but nothing owns the alias.

Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")

Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
---
Reproduced under QEMU/vng. QEMU's cxl-type3 does not emulate the HMAT
extended-linear address_mode bit, so ELC was forced locally for testing
via a one-line debug hack in cxl_region_probe() (not part of this patch):

	if (!p->cache_size && p->res)
		p->cache_size = resource_size(p->res) / 2;

Steps:
1. Boot with an Intel CPU model under TCG (KVM host-passthrough will
    otherwise leak the host's real vendor ID, and AMD/SMCA takes a
    different mce_usable_address() path than the one under test):
vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu Skylake-Server-v4,+mce,+mca -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'

2. modprobe mce-inject
$cxl list -M
$cxl list -D
$cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
$dmesg | grep "DEBUG: forced cache_size"
$modprobe device_dax
$modprobe kmem
$ls /sys/bus/dax/devices/
$daxctl reconfigure-device dax0.0 --mode=system-ram
$lsmem
it will show as below:
dax0.0
[   42.857642] Fallback order for Node 0: 0 
[   42.857828] Built 1 zonelists, mobility grouping on.  Total pages: 1010805
[   42.858446] Policy zone: Normal
[
  {
    "chardev":"dax0.0",
    "size":536870912,
    "target_node":0,
    "align":2097152,
    "mode":"system-ram",
    "online_memblocks":4,
    "total_memblocks":4,
    "movable":true
  }
]
reconfigured 1 device
RANGE                                  SIZE  STATE REMOVABLE BLOCK
0x0000000000000000-0x000000007fffffff    2G online       yes  0-15
0x0000000100000000-0x000000017fffffff    2G online       yes 32-47
0x0000000190000000-0x00000001afffffff  512M online       yes 50-53

Memory block size:       128M
Total online memory:     4.5G
Total offline memory:      0B

3. Load the injector if not loaded earlier and derive the two MCi_STATUS values.

    modprobe mce-inject

    MCi_STATUS bit layout used here (arch/x86/include/asm/mce.h):
      bit 63  VAL     - record valid
      bit 61  UC      - uncorrected (0 = corrected error under test)
      bit 60  EN      - error reporting enabled
      bit 59  MISCV   - MCi_MISC valid
      bit 58  ADDRV   - MCi_ADDR valid
      bits[15:0] MCACOD - bit 7 set = memory-error signature, per
                          mce_is_memory_error()'s Intel branch

    python3 -c "
    VAL, UC, EN, MISCV, ADDRV = 1<<63, 1<<61, 1<<60, 1<<59, 1<<58
    MCACOD_MEM = 1<<7                      # memory error signature
    ce = VAL | EN | MISCV | ADDRV | MCACOD_MEM
    uc = ce | UC
    print(f'CE status = {hex(ce)}')
    print(f'UC status = {hex(uc)}')"
    # CE status = 0x9c00000000000080
    # UC status = 0xbc00000000000080

    MCi_MISC: address-mode field, bits[8:6], must be 2 (physical):

    python3 -c "print(hex(2 << 6))"
    # misc = 0x80

4.  $ cd /sys/kernel/debug/mce-inject
$echo sw > flags
$echo 0x9C00000000000080 > status
$echo 0x80 > misc
$echo 0x190010000 > addr
$echo 9 > bank
[  221.813395] mce: [Hardware Error]: Machine check events logged
[  221.814716] cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
[  221.816200] cxl_mce_debug: spa=0x190010000 contains=1
[  221.817089] cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
[  221.817655] cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
[  221.821504] Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
[  221.823903] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
[  221.824617] mce: [Hardware Error]: TSC a605ccda40 ADDR 190010000 MISC 80 
[  221.824997] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786375908 SOCKET 0 APIC 0 microcode 1
root@virtme-ng:/sys/kernel/debug/mce-inject# 
root@virtme-ng:/sys/kernel/debug/mce-inject# grep HardwareCorrupted /proc/meminfo
HardwareCorrupted:     4 kB

CE without this patch:
  cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
  Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
  HardwareCorrupted: 4 kB
------------------------------------- 
CE with this patch:
  (no "Offlining aliased SPA" message logged)
  HardwareCorrupted: 0 kB

$cd /sys/kernel/debug/mce-inject
$echo sw > flags
$echo 0x9C00000000000080 > status
$echo 0x80 > misc
$echo 0x190010000 > addr
$echo 9 > bank
addr  bank  cpu  flags	ipid  misc  README  status  synd
[   61.681659] mce: [Hardware Error]: Machine check events logged
[   61.683442] cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
[   61.684528] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
[   61.684974] mce: [Hardware Error]: TSC 2eeae32fe0 ADDR 190010000 MISC 80 
[   61.688880] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377156 SOCKET 0 APIC 0 microcode 1
[   86.504456] clocksource: Watchdog remote CPU 11 read timed out

$grep HardwareCorrupted /proc/meminfo
HardwareCorrupted:     0 kB
-------------------------
For UC, same steps only status bit information will change :
$cd /sys/kernel/debug/mce-inject
$echo sw > flags
$echo 0xbc00000000000080 > status
$echo 0x80 > misc
$echo 0x190010000 > addr
$echo 9 > bank
$dmesg | grep cxl_mce_debug
$grep HardwareCorrupted /proc/meminfo
[  313.398747] mce: [Hardware Error]: Machine check events logged
[  313.400518] cxl_mce_debug: entered status=0xbc00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
[  313.401727] cxl_mce_debug: spa=0x190010000 contains=1
[  313.402157] cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
[  313.402663] cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
[  313.405999] Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
[  313.408375] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
[  313.408999] mce: [Hardware Error]: TSC e9dd2869e0 ADDR 190010000 MISC 80 
[  313.409367] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377750 SOCKET 0 APIC 0 microcode 1

Patched, UC: alias still offlined, confirming uncorrected handling is unchanged by this patch.
    cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
    Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
    HardwareCorrupted: 4 kB

 drivers/cxl/core/mce.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
index 65fed913b221..ee70c1c9f9b9 100644
--- a/drivers/cxl/core/mce.c
+++ b/drivers/cxl/core/mce.c
@@ -18,7 +18,14 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 	u64 spa, spa_alias;
 	unsigned long pfn;
 
-	if (!mce || !mce_usable_address(mce))
+	if (!mce)
+		return NOTIFY_DONE;
+
+	/* Only uncorrected memory errors warrant taking down the alias page */
+	if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
+		return NOTIFY_DONE;
+
+	if (!mce_usable_address(mce))
 		return NOTIFY_DONE;
 
 	spa = mce->addr & MCI_ADDR_PHYSADDR;

base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.0

