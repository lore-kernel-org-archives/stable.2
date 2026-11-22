Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316476;
	b=WhiLlBPnvoHqdixV98pTDvzAmkxLv+ze5zkFNcZuWtb5KIewJqSzI0nVSlPJm1sr/OeW
	 iVczDLOAyayVkCGCnoJDj7nEajtI99+J33sI6AOEompxKPEDYskYZ7JFwooIpKqQmrayE
	 x/kdRdEoMsEcWvOU668EyBIGNbfm2TO2xW8PAmGTYimfh8X/3URCQP7jiUYFLJNwrpfnR
	 ALR4octs9rL4VD/X4RdUwPe0Z5IaA9dPWH58weE8jB1ARIK8eVLVcnpj/iNprH0NQj+KC
	 T8/5uH1DBOMZq5ZZ69LvdELdVg0Yv0g7uhlw3sDxG0qFMPbuZuOT1EzKAS+kYibChCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316476;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type;
	bh=xpRj4OFJd9HB7VdTZ4Si8PRH53tOWMzd7fQbdHzZUy8=;
	b=ARhRZt1H+LVBE1CbTqj1L46VtLQQPUiUXvvTDUytd3j6pWdahXv5vXf+J1kSuBtyC6iX
	 mqpWIKHpAXSIgntgcw15ee0f0jgn0Kh0d1JoixCag4Il5Hbmn6dh1oX8DHDlLGX7Zf/no
	 jCVVC6b+qOtdzdYIP9b0gLa6Sn70i+F7DGVxqiECyFgalvX63TTbnbRAekdFyLCfvUf/F
	 KFIwunS02Ln8JmycERzk8IVh6q/jsxh/VrYXgLH1Mjo6kzMfcBfvTYxUwzYzPpnUAAXZ8
	 65rruIH9ZP4/a7mX2vl36Ias6ASvIA2F6pGr6N9oAsZyhzNtFUG1jIQnqQYryFvhrcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=aEpErZdT;
	arc=none smtp.remote-ip=109.224.244.122
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F6F606A320;
	Sun, 22 Nov 2026 03:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07F6F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=aEpErZdT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795316472; x=1795575672;
	bh=xpRj4OFJd9HB7VdTZ4Si8PRH53tOWMzd7fQbdHzZUy8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=aEpErZdTkuQP/ZfIlfknNYW/6ACAyS9eZihti34nqdJIqSV/vxEDYrDM+kSWwZIKP
	 lQNAqvekmGF4GtRWI92ScS7WYwmEKoMJ6li7wEuKIwCuK7dlj1Bp2uFx4RDPfpfHfF
	 PnTuf1oX1C3AC8xsXwLHkKBDVJ8wu9ww1qoPySebIvOeh5RLSWNj26J4LlKUOtVZ8e
	 RmX3BFQtmTYtRn1RcTDGmsiPB1K1R7sbXq3BSIR5Hueb422Rgdbh1bCj7Nk/JT/WK/
	 9HWEJFTd13iezFz50SbQNSQo4dDpgAbVMlPM98GvEKrfydZqOkdvnikXSlsAZe7WWl
	 nnyBMsYC93EXw==
Date: Sun, 22 Nov 2026 03:01:04 +0000
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
From: YanXin Li <fadouse@pm.me>
Cc: Yue Hu <zbestahu@gmail.com>, Jingbo Xu <jefflexu@163.com>, Sandeep Dhavale <dhavale@google.com>, Hongbo Li <hongbohbli@tencent.com>, Chunhai Guo <guochunhai@vivo.com>, Sheng Yong <shengyong@oppo.com>, Wang Shuai <wangshuai@vivo.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] erofs: validate fsoffset alignment and bound page reads
Message-ID: <20261122030055.8408-1-fadouse@pm.me>
Feedback-ID: 173252840:user:proton
X-Pm-Message-ID: d03e577baa4adf089be24332b70f4d53cd10d283
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------3f70be30fccd01ebfa0f03cfdbb2b7ee21873dc0913c09d884dcccc2d6b93eb7"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------3f70be30fccd01ebfa0f03cfdbb2b7ee21873dc0913c09d884dcccc2d6b93eb7
Content-Type: multipart/mixed;
 boundary=9dd49c951877bc2f15475bccc600003fa0719722f6c6236636b44ccc6c99
From: YanXin Li <fadouse@pm.me>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Yue Hu <zbestahu@gmail.com>,
	Jingbo Xu <jefflexu@163.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <hongbohbli@tencent.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Sheng Yong <shengyong@oppo.com>,
	Wang Shuai <wangshuai@vivo.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] erofs: validate fsoffset alignment and bound page reads
Date: Sun, 22 Nov 2026 11:00:55 +0800
Message-ID: <20261122030055.8408-1-fadouse@pm.me>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0

--9dd49c951877bc2f15475bccc600003fa0719722f6c6236636b44ccc6c99
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

erofs_fc_parse_param() stores an arbitrary 64-bit fsoffset= mount
option into sbi->dif0.fsoff without checking alignment, and
erofs_fc_fill_super() calls erofs_read_superblock() before checking
whether fsoffset is aligned to sb->s_blocksize.

In block-device mode, erofs_init_metabuf() sets buf->off to
sbi->dif0.fsoff, and erofs_bread() maps a single PAGE_SIZE page via
kmap_local_page() and returns buf->base + ((buf->off + offset) &
~PAGE_MASK).  erofs_read_superblock() calls erofs_read_metabuf(&buf,
sb, 0, false) and adds EROFS_SUPER_OFFSET (1024) to the returned
pointer.  When (fsoffset & ~PAGE_MASK) + 1024 + sizeof(*dsb) exceeds
PAGE_SIZE (including a valid 1024-byte-aligned fsoffset=3072 on a
1 KiB-block image, or an unaligned fsoffset=4095), dsb points past
the end of the mapped page.  On a 1 KiB-block EROFS image mounted
at fsoffset=3072, Generic KASAN reports:

  BUG: KASAN: use-after-free in erofs_fc_fill_super+0x2b04/0x36c0
  Read of size 4 at addr ffff88800f8c
1000 by task test_erofs_fsof/102
  ...
  erofs_fc_fill_super
  get_tree_bdev_flags
  erofs_fc_get_tree
  vfs_get_tree
  fc_mount
  path_mount
  __x64_sys_mount

The KASAN classification reflects that the adjacent physical page was
free; the source-level operation is an out-of-page read at offset
0x1000 past the mapped folio page.  Two related out-of-page reads
occur on the same path: erofs_superblock_csum_verify() checksums up
to (1 << blkszbits) - 1032 bytes past dsb->checksum before fsoffset
alignment is checked (reading up to 2048 bytes past the page for a
4 KiB-block image at fsoffset=2048), and erofs_read_metadata() bounds
each memcpy() chunk by sb->s_blocksize - erofs_blkoff(sb, *offset)
without accounting for buf->off (reading past the mapped page during
z_erofs_parse_cfgs() even for a valid block-aligned fsoffset=2048).

Mounting EROFS on a block device requires CAP_SYS_ADMIN in the
initial user namespace.  A relevant boundary is a privileged image
mounte
r or container runtime passing a caller-influenced fsoffset=
option or mounting an EROFS image embedded at a sub-page block
offset.

Reject fsoffset values that are not 512-byte aligned in
erofs_fc_parse_param(), read the superblock via
erofs_read_metabuf(&buf, sb, EROFS_SUPER_OFFSET, false), verify
fsoffset alignment against (1UL << sbi->blkszbits) in
erofs_read_superblock() before erofs_superblock_csum_verify(), pass
dsb directly to erofs_superblock_csum_verify(), and clamp each copy
in erofs_read_metadata() by PAGE_SIZE - offset_in_page(buf->off +
*offset).  With this change, a valid 1 KiB-block image at
fsoffset=3072 and a valid 2 KiB-block compressed-config image at
fsoffset=2048 mount cleanly without KASAN reports, while misaligned
fsoffset=2048 (4 KiB blocks) and fsoffset=4095 are rejected with
-EINVAL before any checksum or out-of-page access.  Z3 SMT checking
confirms all three out-of-page conditions are unreachable for any
valid block size and offset after th
e fix.  A test case and full
validation logs are available on request.

The vulnerable code is present in upstream mainline v7.4-rc3.
Runtime verification and fix validation were performed in an x86-64
QEMU/KVM guest running v7.4-rc3 with Generic KASAN, UBSAN, and
lockdep.

Fixes: c36ec00d7f67 ("erofs: add 'fsoffset' mount option to specify filesystem offset")
Cc: stable@vger.kernel.org
Signed-off-by: YanXin Li <fadouse@pm.me>
---
 fs/erofs/super.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e92a7fa90ae..66ba9dbd8ff 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -38,9 +38,9 @@ void _erofs_printk(struct super_block *sb, const char *fmt, ...)
 	va_end(args);
 }
 
-static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
+static int erofs_superblock_csum_verify(struct super_block *sb,
+					struct erofs_super_block *dsb)
 {
-	struct erof
s_super_block *dsb = sbdata + EROFS_SUPER_OFFSET;
 	u32 len = 1 << EROFS_SB(sb)->blkszbits, crc;
 
 	if (len > EROFS_SUPER_OFFSET)
@@ -109,7 +109,7 @@ void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 	*lengthp = len;
 
 	for (i = 0; i < len; i += cnt) {
-		cnt = min_t(int, sb->s_blocksize - erofs_blkoff(sb, *offset),
+		cnt = min_t(int, PAGE_SIZE - offset_in_page(buf->off + *offset),
 			    len - i);
 		ptr = erofs_bread(buf, *offset, true);
 		if (IS_ERR(ptr)) {
@@ -268,16 +268,14 @@ static int erofs_read_superblock(struct super_block *sb)
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_super_block *dsb;
-	void *data;
 	int ret;
 
-	data = erofs_read_metabuf(&buf, sb, 0, false);
-	if (IS_ERR(data)) {
+	dsb = erofs_read_metabuf(&buf, sb, EROFS_SUPER_OFFSET, false);
+	if (IS_ERR(dsb)) {
 		erofs_err(sb, "cannot read erofs superblock");
-		return PTR_ERR(data);
+		return PTR_E
RR(dsb);
 	}
 
-	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 	ret = -EINVAL;
 	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
 		erofs_err(sb, "cannot find valid erofs superblock");
@@ -289,6 +287,11 @@ static int erofs_read_superblock(struct super_block *sb)
 		erofs_err(sb, "blkszbits %u isn't supported", sbi->blkszbits);
 		goto out;
 	}
+	if (sbi->dif0.fsoff & ((1UL << sbi->blkszbits) - 1)) {
+		erofs_err(sb, "fsoffset %llu is not aligned to block size %lu",
+			  sbi->dif0.fsoff, 1UL << sbi->blkszbits);
+		goto out;
+	}
 	if (dsb->dirblkbits) {
 		erofs_err(sb, "dirblkbits %u isn't supported", dsb->dirblkbits);
 		goto out;
@@ -296,7 +299,7 @@ static int erofs_read_superblock(struct super_block *sb)
 
 	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
 	if (erofs_sb_has_sb_chksum(sbi)) {
-		ret = erofs_superblock_csum_verify(sb, data);
+		ret = erofs_superblock_csum_verify(sb, dsb);
 		if (ret)
 			goto out;
 	}
@@ -56
9,6 +572,10 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 			clear_opt(&sbi->opt, DIRECT_IO);
 		break;
 	case Opt_fsoffset:
+		if (result.uint_64 & (SECTOR_SIZE - 1))
+			return invalfc(fc,
+				       "fsoffset %llu is not 512-byte aligned",
+				       result.uint_64);
 		sbi->dif0.fsoff = result.uint_64;
 		break;
 	case Opt_inode_share:
@@ -758,9 +765,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			return -EINVAL;
 		}
 	}
-	if (sbi->dif0.fsoff & (sb->s_blocksize - 1))
-		return invalfc(fc, "fsoffset %llu is not aligned to block size %lu",
-			       sbi->dif0.fsoff, sb->s_blocksize);
 
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && sbi->blkszbits != PAGE_SHIFT) {
 		erofs_info(sb, "unsupported blocksize for DAX");
-- 
2.43.0


--9dd49c951877bc2f15475bccc600003fa0719722f6c6236636b44ccc6c99
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - fadouse@pm.me -
 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"
Content-Type: application/pgp-keys; filename="publickey - fadouse@pm.me -
 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuMTAuMAoKeGpNRWFVdU9NUllKS3dZQkJBSGFS
dzhCQVFkQXRuWWxTekhUTEhBMkl6dU5FMUF5OEpyS1VDeDZoUCsvdGM0TApEWENucmV6TkhXWmha
RzkxYzJWQWNHMHViV1VnUEdaaFpHOTFjMlZBY0cwdWJXVSt3c0FSQkJNV0NnQ0RCWUpwClM0NHhB
d3NKQndrUXVaMWd0K1htMlhSRkZBQUFBQUFBSEFBZ2MyRnNkRUJ1YjNSaGRHbHZibk11YjNCbGJu
Qm4KY0dwekxtOXlaem0wQnAzZUVYUldrbklnQ2xXd3ZkeFptbzFYblZiNkZrYWpYVFZNMUIvakF4
VUtDQVFXQUFJQgpBaGtCQXBzREFoNEJGaUVFbVVoYW8zWi9BbkJJNExCWXVaMWd0K1htMlhRQUFM
cTJBUUQ3OEs2cGVkU1gzbGROCnlxZDNPSDF1TWpPM3Y3TFlNaE8rbDdjblNMV3JFQUQrT0NTcTEx
U2VhS29ic1ZHckxlalRNc21Nc1BCOGpueGYKaWQzaENOK3Bld1RPT0FScFM0NHhFZ29yQmdFRUFa
ZFZBUVVCQVFkQXdYZHpWSXFFSC94OEhaalIvUE90MkFpRgpiRW02WXFYWDJqMnYyaUtEc1FNREFR
Z0h3cjRFR0JZS0FIQUZnbWxMampFSkVMbWRZTGZsNXRsMFJSUUFBQUFBCkFCd0FJSE5oYkhSQWJt
OTBZWFJwYjI1ekxtOXdaVzV3WjNCcWN5NXZjbWRkS05RWURGV2NFVmQzeE9IZVFwNnMKeW43OU5G
cE5xa0h6K2l6cElMQm5VZ0tiREJZaEJKbElXcU4yZndKd1NPQ3dXTG1kWUxmbDV0bDBBQUR6UWdE
LwpjSUowODlKa25vZ1RzNnZ2UVorSjNMUklEYUk5K1FtK1Q1cU9tTms0eVhFQkFMUElsSkNTOGFo
NWRCWVphOUwrCkhxamJEbWVTZ0RvNTh1U3graVd3KzZVTAo9TXVzVAotLS0tLUVORCBQR1AgUFVC
TElDIEtFWSBCTE9DSy0tLS0t
--9dd49c951877bc2f15475bccc600003fa0719722f6c6236636b44ccc6c99--

--------3f70be30fccd01ebfa0f03cfdbb2b7ee21873dc0913c09d884dcccc2d6b93eb7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wqsEARYIAF0FgmsCWu8JELmdYLfl5tl0NRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeEvm8zizGPBQQzOwWuSv7KFiEEmUhao3Z/AnBI
4LBYuZ1gt+Xm2XQAABfJAP983pfy4jsiclrJeMQnaxPnAiH2ATIBgttVn8hz
B+W6GQD/WtmwMvX7Tx5zaZ+aUwoP+g4j3H/Uaoj3aSTckKJLwQs=
=Hbg+
-----END PGP SIGNATURE-----


--------3f70be30fccd01ebfa0f03cfdbb2b7ee21873dc0913c09d884dcccc2d6b93eb7--

