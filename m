Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795864556;
	b=fwQC7hEHs7E4gkqI5GpB2gkLgbW1GA2yJcZSQ7y0GbrGOBJTxQkqffYwVvNEiZxqO3X9
	 ReNxqTSPYVasJ43XSDB7t1xbyYOHYHeQ/6r+8PnUHfKopp+AGAC+HZMxdy57v9+Kvqfp9
	 ecZOR8MUtSaDMAlOU+I/jKpDOkuuRcD+NlgIANYfMoIBelHHMGAsYm2ttr7SMNVVUCP1U
	 nilwJwTLKgzFXJ1Z1wjHPHtzSWDPIr+Dk8/OICrJTqquDAvWUq8APV75zzI1x0+uwGzZi
	 bIxvJfWRTtm6S9MdWNxl12T8Ed8Xr8S4i7iGWXqtd9Y9DZi7DNjKLeX1pKrTmcYsSDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795864556;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=DsvK1cIGUgxB4kmDCLPIl7jxz8Pe1k7ijonzyD/9LtI=;
	b=MvfBBh4xSvAz8BpWa66PVcET/11f3hcZafcY6Uaf+qgYkei85m/ziL3tx4qwXN5GQsfv
	 cO0mNY7eA7rCLtCVJlHKrzqY2m/UFEWrrbOJVl2TsF/Hmw5GWzoLmcOjKgC3PEXpqc1MH
	 p04BuRQ3wFOg3wCWtFrt8R3w7Bgv6psvs2MeiL93VBNBcn84SCo4b3wPUTjXdWWzzM6FL
	 6qMGMFmEIAg8GxSS0MeK5kREDARv9mZ3ZhlJVrL58bFrKeHpOBRtHBnHIcarnML11Eb0C
	 gadfpqWh5BdOs2pGO6yc28LlAayPhKPNtzru6myRjqAqyM0BRqSclKsk/BAoopva/6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=A3juzhPz;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5DC606A334;
	Sat, 28 Nov 2026 11:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E5DC606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=A3juzhPz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ds
	vK1cIGUgxB4kmDCLPIl7jxz8Pe1k7ijonzyD/9LtI=; b=A3juzhPzENpaP/l5PE
	3ACWUPgGrmo7qp3N3cE+44mibFOpi8AhyCl42KGKZTcBzhNTXWamhN25AwGDQk/B
	AwvmbEBURL8KIQXCH/vbM9te4CycLz3tR2v0KIHF33XL/bktzaldg0G3BuM/+iNY
	0SP5vTOSmPe4Hjrw1lIpWSUA4=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3H0HhtwprzMsqLA--.12800S2;
	Sat, 28 Nov 2026 19:15:46 +0800 (CST)
From: shaos <shawnq1@163.com>
To: luisbg@kernel.org,
	salah.triki@gmail.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] befs: fix indirect index in double-indirect mapper
Date: Sat, 28 Nov 2026 11:15:45 +0000
Message-Id: <20261128111545.3210159-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H0HhtwprzMsqLA--.12800S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF13Wr17ZrWftw4UGw13XFb_yoWrCw1xpa
	yqk3WFkFs8C3W5J3Z3uF4jvw1xWw1DJa43G3Z8J348Cws8Jrn2v34Ikw1Y9F1kKr1kGa90
	qF1jga4FgayDGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UN6pPUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzwODkWsKt+NIDQAA3u

Hello,

befs_find_brun_dblindirect() computes the index within the indirect
block as dblindir_leftover / diblklen.  Since dblindir_leftover is the
remainder modulo diblklen, that quotient is always zero.  The divisor
must be iblklen, the number of file blocks described by one indirect
entry.

With a valid-layout image whose direct and indirect ranges are both
non-empty, reads from the second data run in the double-indirect range
return data from the first run plus the logical offset.  The PoC reads
file blocks 6 and 7 as WRONG_BLOCK_024 and WRONG_BLOCK_025; the correct
blocks contain RUN1_BLOCK_200 and RUN1_BLOCK_201.

The trigger requires a crafted BeFS image to be mounted from a block
device, which requires mount privilege.  The reproducer mounts the
image read-only and reads a regular file.  It demonstrates incorrect
file contents; it does not demonstrate a panic, memory disclosure, or
privilege escalation.

HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
source version: v7.3-23088-g8d7fe9885c62f (Linux 7.4.0-rc4)
compiler:       gcc 11.4.0, GNU ld 2.38

Console output:
https://gist.githubusercontent.com/shaos26/6be5e0efeaa44a6715bdba598ca6c2f6/raw/c1fcaab9327372c7021788ebfcdddac66810cb26/console-output.txt
Kernel config:
https://gist.githubusercontent.com/shaos26/6be5e0efeaa44a6715bdba598ca6c2f6/raw/c1fcaab9327372c7021788ebfcdddac66810cb26/kernel-config.txt
PoC:
https://gist.githubusercontent.com/shaos26/6be5e0efeaa44a6715bdba598ca6c2f6/raw/c1fcaab9327372c7021788ebfcdddac66810cb26/poc.c
Image builder:
https://gist.githubusercontent.com/shaos26/6be5e0efeaa44a6715bdba598ca6c2f6/raw/c1fcaab9327372c7021788ebfcdddac66810cb26/make_befs_image.py

Build the kernel from the revision above using kernel-config.txt:

    work=$(mktemp -d /tmp/befs-dblindir.XXXXXX)
    cd "$work"
    gist_id=6be5e0efeaa44a6715bdba598ca6c2f6
    gist_revision=c1fcaab9327372c7021788ebfcdddac66810cb26
    gist_base=https://gist.githubusercontent.com/shaos26
    gist=$gist_base/$gist_id/raw/$gist_revision
    for file in console-output.txt kernel-config.txt poc.c \
        make_befs_image.py; do
        curl -fL "$gist/$file" -o "$file"
    done
    git clone \
        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    cd linux
    git checkout 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
    mkdir build
    cp ../kernel-config.txt build/.config
    make O=build olddefconfig
    make O=build -j"$(nproc)" bzImage
    cd ..

Build the image and initramfs:

    gcc -O2 -static -Wall -Wextra -o poc poc.c
    python3 make_befs_image.py befs.img
    mkdir -p root/dev root/mnt
    cp poc root/init
    (cd root && find . -print0 | cpio --null -o -H newc) | \
        gzip -9 > initramfs.cpio.gz

Run the positive case with the image attached read-only:

    timeout 30 qemu-system-x86_64 -machine pc,accel=tcg -cpu max \
        -m 1024M -smp 2 -display none -monitor none -serial stdio \
        -no-reboot -kernel linux/build/arch/x86/boot/bzImage \
        -initrd initramfs.cpio.gz \
        -append 'console=ttyS0 rdinit=/init panic=-1 loglevel=7' \
        -drive file=befs.img,if=virtio,format=raw,readonly=on

The unfixed kernel reads WRONG_BLOCK_024 and WRONG_BLOCK_025 for file
blocks 6 and 7.  The same image and initramfs on the fixed kernel read
RUN1_BLOCK_200 and RUN1_BLOCK_201.  Blocks in the direct range, the
first indirect range, and the first double-indirect run match on both
kernels.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: shaos <shawnq1@163.com>

Thanks,

shaos

---
 fs/befs/datastream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/befs/datastream.c b/fs/befs/datastream.c
index 4f5825a336f1c..9f610e775321a 100644
--- a/fs/befs/datastream.c
+++ b/fs/befs/datastream.c
@@ -456,7 +456,7 @@ befs_find_brun_dblindirect(struct super_block *sb,
 
 	dblindir_indx = dbl_indir_off / diblklen;
 	dblindir_leftover = dbl_indir_off % diblklen;
-	indir_indx = dblindir_leftover / diblklen;
+	indir_indx = dblindir_leftover / iblklen;
 
 	/* Read double indirect block */
 	dbl_which_block = dblindir_indx / befs_iaddrs_per_block(sb);
-- 
2.34.1

