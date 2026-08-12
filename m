Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F1384CC8
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547892; cv=none; b=fu3XtF5Jn1Xmgy02phnh7/wJk7p/11pAJCLBo0g7nai5Y7eMVj9AGD2RO3jejKNYVMvDs/eoF/3/U3ElNdaAE5NWcdRFpqhq0Td3wW+4PeqNW/7iZ0NmnXYBdV4BdDhUCavzEgyhOeZc/Z10SB33etC+polw9b0NY815FpllDAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547892; c=relaxed/simple;
	bh=4lponhvcBoEj4isXQY9iYKXNBCg2Z0hXTEzAYNInePI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n4GnkHt3VQzn43wRtjZfC36wNXM+zLY/p9EH2FfRiOL3ZthXezXiV4/5kKAoAQzAoXLkD8M1L+yCMBy2w2mitTUkvrJbAOK9xAor+A4FUJFJsKLtNDmq4GfAHXGggN/CUHhNKRl3wi1lVKXFT4+zlQguyF/+SElMPqqlKaYxutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDa0C+Hy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDa0C+Hy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ceaf8a1265so13853585ad.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786547890; x=1787152690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qaa+Sy+sE+8+QMHIV71O2fnlj9rH1hWPcoo3mwjBGow=;
        b=oDa0C+HyO6Lk22tXbulpHjG0uyvopIbMrS4h2CggvlhASYHIb06C8yEXrCPbODd5fi
         j2sbQPc6H+py6zAo5+0V5YBG5lgfExNdx5UHIINNTNDsguNE39btqGfYty5QmIswV3IQ
         CIr03Eavvz01O+UodHEHYt8lIdfyPv4wAFV6Ka7dF7JhFsTxgbOL5Ap5n9ma2YoHtnoz
         /tq2GuH4N4knLqONOyfoKpwg1fCmv4A9GaVXgdSZSzosUsFskDoKEerDBxY3d7MrMeA7
         UHRC2eLQTuw05pZjXuEMng911mK/rWz4484+ARJe8VCj11A+DiHnuFSL5WsO26tuONlw
         lB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786547890; x=1787152690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qaa+Sy+sE+8+QMHIV71O2fnlj9rH1hWPcoo3mwjBGow=;
        b=Fk/BuzZFXWSnvBM2RfMk3itm94pjTgneXOL85pKWqDuaL549/C7eZ7kGyUpD7CXmdB
         nKwnHzrRjWVJzITNtKz48L19EdgREfD+WxZ74/OCULBPx0R/ijf11xtr9h4ZrtTQq+Mm
         N4tejvv8InG0zLh+idg3AU2PtJAw+bc/LoeM4LR09TiaOmJcjxn/QpBbZGrtmiiQwicq
         eHtMVSaUDnNdd/q4g50atqD6mkIIFxsYYREG2kGFZnlWgC6hu7aHcziIteDWhrbb9hsJ
         o/gX8DKkNz7vJyJt/ncZY+WjISMKh+NCyM3rEo+wo8zd+5BiV1UmSxvSp2NMKMrhJQnB
         H5oA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0Odk6hS+bHPzSFoPYs7o5itUSvvyRqb4VuRXatIeRaBs9WBiH4T0/QuKkqvSygHRC2mA89X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTMAoU/BDsTpV1ME6A6Dr8tge5x2rWk80crrGNxaajQkZHL7o4
	CEbWrfp4tpTF6yZhO02q9PxEWQNgE4S6y1bmX+Ud+KzXwNGDlMFfu+T2
X-Gm-Gg: AR+sD11oXRCEzm3MgfJSfUFvH3rge9l61EZ0iksbqx+JNg+7oCVj25v3120WiMxK8Cj
	S3RtIRAc3fzFki6g3vCBpe36haP2XKUVcFHfW2FAYZvPItDH0IaINPASUJ2Bi7tbsnXpjPVPnzv
	CdNrIKALT1ZDHRHoryIFClRjkd0eJXE3qqod9qMzfU5dvAD0RNv6WwQIYhyQyt2x0R5rwGI9AqZ
	N21EotUQY+l3J/HdY/36vCmrOeL98HR8At61EwvAHABLWl/4CO3aEBgyBtAKWI0pzJmGpb3acK/
	w3hlYQMxPAJ840RPTJIiptw8NSbqgLCL1SOoZgZsTWKG+k6hPHnW7EyKiEFaNCCMQQZQF31pYeB
	y6ACZpye1r0jNDKq74hqPdl5CWbjDhUfSoVt/CvXSJ5LjQ+fJrsPKvFDl/vbL6fYevNcOS7qSuC
	SdFHfNcLNYggMaBzcAsKT77Yh8tOTBNhy7/TR0gNEnSWWKSryralDlG/CbuXN7xbQ0SvZ9VrPQK
	uYskVLta70LVHm6ag==
X-Received: by 2002:a17:903:4b46:b0:2cc:f5b8:4c2e with SMTP id d9443c01a7336-2d3453848d4mr85562295ad.9.1786547889806;
        Wed, 12 Aug 2026 08:18:09 -0700 (PDT)
Received: from acer-nitro-anv15-41.entro.com ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3522019d3sm8426135ad.56.2026.08.12.08.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:18:09 -0700 (PDT)
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
Subject: [PATCH v2] cxl/mce: Avoid alias page retirement for corrected errors
Date: Wed, 12 Aug 2026 20:47:59 +0530
Message-ID: <20260812151759.14390-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_handle_mce() offlines the aliased page of an Extended Linear Cache
(ELC) region for any MCE with a usable address in the region. This
includes corrected errors and non-memory errors, needlessly reducing
usable memory.

Restrict ELC MCE handling to uncorrected memory errors. Use
mce_is_correctable() so that MCE_AR_SEVERITY errors continue to retire
the alias when the reported page is handled elsewhere.

Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
---
Changelog:

v1 -> v2:
  - Reworked commit message per review feedback
  - Dropped redundant comment from the code
 
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

 drivers/cxl/core/mce.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
index 65fed913b221..e3c561489a00 100644
--- a/drivers/cxl/core/mce.c
+++ b/drivers/cxl/core/mce.c
@@ -18,7 +18,13 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 	u64 spa, spa_alias;
 	unsigned long pfn;
 
-	if (!mce || !mce_usable_address(mce))
+	if (!mce)
+		return NOTIFY_DONE;
+
+	if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
+		return NOTIFY_DONE;
+
+	if (!mce_usable_address(mce))
 		return NOTIFY_DONE;
 
 	spa = mce->addr & MCI_ADDR_PHYSADDR;

base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.0

