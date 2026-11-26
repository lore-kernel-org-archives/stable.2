Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664444;
	b=jDZWrUJidjEL30uqcmyB4FOXWDVJF1G+KJV0yYMQfaybNX7k+7F/AAPAKUquLgj/KAaI
	 qMG/gCgH/bcHiY7mP0GneortEAyBHKMlnvoZma2ND8m245nQkVbbPf1zujvdGzkXP/BJQ
	 ouFvXnTP1kMuXUTd6HI29NTvcSG92TNkKeUr3ZVCsMob5Yu3V1zuVaRZS/VkYWsXvEu0f
	 siRwzJcMjX2Oi6ZM05HMMYWcGdvITv+wwZ5PqBnb49ZuIVpaBUmuRKS2jLeX0gIMaqRf3
	 wfDpdbOwAaCWm2wyVtLYpXwe5gy00Zsim8BJV3zj8CnMGIdZ2tHeL0m9kaY9YoocxtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664444;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=zCl4XACFfxLoFxR7/97+DR7w+83N8h8sXqXdDNDJGZ0=;
	b=QWDVCYL8bllumzuEWlLlqsDbEdIslXa7WO/ZZmkMJ9sOgG/Mbamu/73X5cUDpSIng6Vi
	 xRilKdtilOs6X5i1MUT2KY9dhDRsk1OVjOL2hdmfayg+Znf0HuT8BYPl5NMSKg6+KnvGy
	 HPBALh4yGuo9kX4E8NjJ1aWYmeKgITvkFASgvCMR5p2ZsFrxqHRjQeXWT6q1uhjt5SOPY
	 9SX1VnPQn/1fm8XEoJOKB84txzPXm4RQlzeQaO4jcfCK0wiM2jL8Z8LGW2tMxXAXg4O9K
	 ScxNhDZxk8M1bp2C6cu/6kRI9Vjr+DwTjgEOzYaX71CDSTY09zKa7wjkOTu9q3mwXzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EyQJamoQ;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF17606A32D
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAF17606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EyQJamoQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID; bh=zCl4XACFfxLoFxR
	7/97+DR7w+83N8h8sXqXdDNDJGZ0=; b=EyQJamoQ/ozvNwlA+xA6aO227a66nU2
	fQK5LDdd84mg3nME7undIgr/zCvtkKmlq+ALBW4yZ6zYW04zyWUX3qWur9GxMpGR
	Scz2jnEl8dp2W8me6H24taVlTXLDl140eBLeNkW+ifOVF5jK8oLXTwOrKhpqUsqy
	LDuPFXNW3zCI=
From: shaos <shawnq1@163.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: preserve hole marker when trimming a run
Date: Thu, 26 Nov 2026 03:40:27 GMT
Message-ID: <179566442733.1993761.672618205872204854@163.com>
X-CM-TRANSID:PygvCgCH74QrqgdrvLbtIA--.60447S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFWUtF18GF13KrWfXr1xuFg_yoW5tr48pF
	s7AF45Krn0y3W3AwsFqF18Xr909rZ7ta1jka4DJw18uanxJ3WIyFy0k34Yga18Zrs5CrWF
	vrnYq347uryDZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvjgsUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8QxSYGsHqiyuJAAA3v
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Hello,

When run_unpack() starts decoding at a VCN inside a mapping-pairs run,
it trims the already-consumed clusters from that run. For a sparse run,
the LCN is SPARSE_LCN64. Adding the skipped cluster count to that
sentinel changes it into a non-sparse value, and run_add_entry() then
maps the remaining hole to physical cluster zero.

On a crafted NTFS volume, an unprivileged writer can trigger this by
writing across a split $DATA attribute. A subsequent read returns
NTFS boot-sector bytes where the file contains a sparse hole. The
reproducer demonstrates disclosure of volume data; it does not
demonstrate arbitrary memory disclosure or privilege escalation.

HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
Git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
Source version: Linux 7.4.0-rc4
Compiler:       gcc 11.4.0, GNU ld 2.38
Test runtime:   QEMU 6.2.0, x86-64 TCG

The evidence and reproduction helpers are in this unlisted Gist:

https://gist.github.com/shaos26/d1f7fc9e3398d728f104867ea1880df6

Console output:
https://gist.githubusercontent.com/shaos26/d1f7fc9e3398d728f104867ea1880df6/raw/5b1ad414981bb3f8f2ab77862441dc81db6c2b50/console-output.txt
Exact console bytes (base64):
https://gist.githubusercontent.com/shaos26/d1f7fc9e3398d728f104867ea1880df6/raw/5b1ad414981bb3f8f2ab77862441dc81db6c2b50/console-output.raw.b64
Kernel config:
https://gist.githubusercontent.com/shaos26/d1f7fc9e3398d728f104867ea1880df6/raw/5b1ad414981bb3f8f2ab77862441dc81db6c2b50/kernel-config.txt
PoC source:
https://gist.githubusercontent.com/shaos26/d1f7fc9e3398d728f104867ea1880df6/raw/5b1ad414981bb3f8f2ab77862441dc81db6c2b50/poc.c

The readable console file escapes the non-UTF-8 bytes printed from the
boot sector; the base64 file preserves the original console bytes.

Clone the fixed Gist revision and run the vulnerable positives and
boundary control with:

    git clone https://gist.github.com/d1f7fc9e3398d728f104867ea1880df6.git repro
    git -C repro checkout 5b1ad414981bb3f8f2ab77862441dc81db6c2b50
    chmod +x repro/*.sh
    ./repro/reproduce.sh

This runs two fresh vulnerable positives and the split-boundary
control. The patched-kernel trigger and boundary controls are included
in the console log. The vulnerable runs each returned
3935/4096 zero bytes and identified the remaining 353-cluster hole as
physical LCN 0. The boundary control returned 4096/4096 zero bytes.
With this patch, the same trigger image returned 4096/4096 zero bytes,
and MFT inspection showed the run remained sparse.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Cc: stable@vger.kernel.org
Signed-off-by: shaos <shawnq1@163.com>

---
 fs/ntfs3/run.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 6e3ef89fc6660..d51d953f65c4a 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1151,8 +1151,9 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		} else if (next_vcn > vcn) {
 			u64 dlen = vcn - vcn64;
 
-			if (!run_add_entry(run, vcn, lcn + dlen, len - dlen,
-					   is_mft))
+			if (lcn != SPARSE_LCN64)
+				lcn += dlen;
+			if (!run_add_entry(run, vcn, lcn, len - dlen, is_mft))
 				return -ENOMEM;
 		}
 
-- 
2.34.1

