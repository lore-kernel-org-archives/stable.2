Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949477;
	b=GBKAr+8xJ11QJF9Fov2EPLSr9RWM6ySjIWjviXM2gFA9obYLkB32pqse2JzLgFhV8PSo
	 TicGCskqYXs2AZ1XSyaCPraSeiGVed6Kk9SaY1imvEVxBe9vpj6w5hunpsrORXAwgGwa5
	 Ahw8xYlOWv7/Bp41GGly+zH8HxhOOtttqjlcSLe7VzCCv2svsKlCMK5y/lnQbAXOIZlXs
	 YxGWQE9f/ReRAGSMw7uID0bJLuHEkfd+nHBYPmAq4KAuD30+9SS/utiKN8In/Uj9mAXIe
	 QOBrmmjaZ3NgS3hlOqsB6t9ovw7pIwZ+FIb1BoJWwgW3Q1/eadDNNtw0wES4EYUiUdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949477;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QoZ/ne06JK3eIUX8iXVkbXJS2m5jitLoavGyx1etNyw=;
	b=HUi2ZRrnG4qcSSImZL2ympqnEe1P67AfQYBomu/HNBQxvvkxfmzqgisjSdPKfGiSQU+L
	 uUI8nqDf5bzHMm2x34SIUJdCz9wvzUgDJSIsHMi3+GUC0we8sp6O5UW00xmePKFucRLkv
	 4P2eUTjPSyLgTcNJhtn2T6yRp6eA+bP9Ub5+QhXJ0fJcPZnC9hNi9gtICuDCnL2ELg/bp
	 Jt9cUG0TCt3cTh3hJIR/uHDNYMaxGFt6pa0NtPj4S0Nn5/+t547UfVEy7CE3AGvHhTYll
	 3jIq2OPqUdabQmUyF0Dt5JtWS85V3V+LnKj6y4NdoKr8ITdavsBLtBouGXTs0pn6faQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Qo5+2f7s;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jpksZjVX;
	arc=none smtp.remote-ip=202.12.124.140
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2475F606A332
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 07:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2475F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Qo5+2f7s;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jpksZjVX
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 7230C130269C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:17:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 06 Nov 2026 02:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1793949475; x=1793953075; bh=QoZ/ne06JK3eIUX8iXVkb
	XJS2m5jitLoavGyx1etNyw=; b=Qo5+2f7sJv9ANSJluL6zh7y5PfyEU4vjYmVbH
	jos/pm8nJu5AUG8v5zSzolmGyZTkmpNA2en3DdBNVeRXfBd/T1tL9v9AsltS6bt8
	puRg9aTXv70uax5Z2+REvJ96Fc5FVqTnT13SdFsXhKdwqgMwztM+1yhhv+iyZDnd
	ruvcgIJ/78yfgroba70llTMFOSc3v/B//f+vfQITu38KolBzjj7PurdGKU7ixrRZ
	h5TE/c0GEhownSscaWF02hOu9V1YVqX5+nVCDk1xxXOoMuEcd51z8j6u4uxnDecI
	RrHh101cCfkmHWtu/cIk/mMM5VVM8ueKjfsw3lSVM4K7ImkIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793949475; x=1793953075; bh=QoZ/ne06JK3eIUX8iXVkbXJS2m5jitLoavG
	yx1etNyw=; b=jpksZjVX0oxuNP8KjD6sgUX+nwQq4UDwG+Z7RBwAhyIvMlNGVnU
	M/3hHbYgeupnj+xeDhyg+BQZPi+TTA5wwCBQQgJjMY1q0ccMiEunTZbz+PtLoZRN
	SzgyFGG880EKkgOmBwwCu+tZEx7mfiVv+TkRjAQTcFXXMHZbbnXCN/2oJsBNBXz6
	5RjTWemHZy7srAuiHeDEDTJTvyWqWM9KCb3WUxyALwsMd6xmkFv6tcgBLxReFFkU
	mrm3Ke3uvMI2rkr5aDDso957UP2PUW8ocDgzYqOdHSn3mwjc+InnRe6OOsM0iT0Y
	RxMWffDjQ7Le/NjJl8atkL+bNtZ0y81+R7g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793949475; d=pobox.com;
	mf=PG1ucEBwb2JveC5jb20+; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eUjSSnPSf61n78jnEWllRhJsaOHbasIHuI52HdlgjPgie/C
	BsnESH5RgxNvk66EV5S7+1AOG5cAfyLdrgei82ZCjLvyijCtrTMmC8u+7LBhP+Xz
	O+rj06DMlZ2Xfy0O/ns5hIrMfOGJ6KF/rr+4n5iYCTRIXdsIrA2z/rZR4iym5Qc3
	ar0xw0oC0fhhDKL4BTAeFWP+VV09MXleVlWYMstxE5NObup9bZ0OEzRl2F6ltIv7
	ms9xSTQDSDHpIhVuPFijFSoMtNYCZ35DC5gWwjV8Y/qz+39Aj7tS78ruhn/lS28S
	yO0PMeCFLd8AwNqK3dT8ioh+gx0aJOURRZ8CC+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:15dDf4Y0g1fWChhKhRnf/IZQ1qXw/+/2Mvs86IIyt8M=:H4SNGWbTrsXvTior3l/nEZTKtXoe2h8waAOk2TY/6u8=;
X-ME-Sender: <xms:In_tasgnR-NiidilCboZh8Z1zAk5SF1c3GIqZzApiFB99_43bVVb4Q>
    <xme:In_tahCeIbAwXrbQ0gS9gQHaUk1U8_-9AgbFKbsXpJad22B7lTQyzbafV6xjZFgvY
    nQaQj0aHtjOGzyGyqk3YUfHulqM1S7tSC7ErbacKKJL2SR7mXyZZbA>
X-ME-Received: <xmr:In_tamT91UtePJQ_BtH79V_Or3nNl7EGGrSIRk5hSzzcQcexL-FwZC-sHQN-iv_qj4AWl8Pt8w>
X-ME-Proxy-Cause: dmFkZTGlCztvlMjvAmpB78f2p1N35vckEhhpDHoEToHd3P+g9c5a5eSfxQf9+VB6QlyPkf
    2/xNIQhyqVDRM6qMDwz7U0K/neFLSojnWmCP+EDdgN+R44ipysueea9RdzMILHA1IvPSL1
    ya3xaErVGX1qQz4T0deRsHPJlIygESsz5nX7BY7A5DZha2iTKT0gs2W6NqYmrnEKeioTfT
    AzgixfZK/PL8CtXS1E0ixeTdFNT7feBSWkzC++xdl8okijZenDgvJdKMBGO01KLyFE1GwD
    z/F/Z+TJt9uZto2OTJmaMHHc+mRxOBjaSYibuE2+GeksmrW9OJlUeEXfCv5UUsrDY6FoGT
    UnCOqW5WUEo0fqdTocLaeoCKcaUvf9xCTflIwjwT6qrJCeypLZ7fPYcF4ud6+rMsLS2Syj
    HUdA0wVrnx0pNeGyvdS1NcTWwWAbL+1KQ1hrwbPlCwq8bOQTpvW7va0rUP+YuM2Uk+2nYq
    8QZswnNHNgJUNJbQ2bSHb+zL23/hGjmSGS/XHcxcVjzeVcCXqSoo0xswbd9jBb97pUbSsU
    GOuiKLwZVwSy746pPaxdqMYez/g7Hz+DYIw6WjCbKc4/k5Tg7OqvvAMMpP/C0uWRHFX9tX
    HXiQWlwcLeU9HuPAKb4ZHU+jaZmgDbrAuN9AT2KaA4Ny77HYnejOELmZUy/A
X-ME-Proxy: <xmx:In_tauWbqA6XSkKVjyl2HcZu8d2EPZ5xDvCvQh0GVlgCUBq7DL52ww>
    <xmx:In_tanfzE46ZvDAl3LO-9o8_xR4AVTE1qROMPZON-26tcSP2jKodtA>
    <xmx:In_taiJJfBycwtvRTI7QXuq59Yz8ihIcMFBaxnOo4gRy_qkkKiL1Zw>
    <xmx:In_takzfdzNof6TBwY3Mmo2HXHWw7K2B94RWMpPATh_gw0tcECN3DQ>
    <xmx:I3_tau0JZ1TxpEZZAH58UTuvH1IPtdlUVnQmGl4j4P0tTrlfkZbfSeOK>
Feedback-ID: ie71e4a86:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 02:17:51 -0500 (EST)
From: Mark Payne <mnp@pobox.com>
To: Richard Weinberger <richard@nod.at>
Cc: Zhihao Cheng <chengzhihao1@huawei.com>,
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
	Adrian Hunter <ext-adrian.hunter@nokia.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mark Payne <mnp@pobox.com>,
	stable@vger.kernel.org
Subject: [PATCH] ubifs: fix integer overflow in pad node length validation
Date: Fri,  6 Nov 2026 17:15:03 +1000
Message-ID: <20261106071503.4333-1-mnp@pobox.com>
X-Mailer: git-send-email 2.43.0
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

ubifs_scan_a_node() validates the padding length of a UBIFS_PAD_NODE
with:

   if (pad_len < 0 || offs + node_len + pad_len > c->leb_size)

offs, node_len and pad_len are all signed 32-bit ints, so the sum can
overflow. ubifs_check_node() has already bounded node_len (28 bytes for
a pad node) and guarantees offs + node_len <= c->leb_size, but pad_len
is taken straight from the image. With offs = 0x20 and
pad_len = 0x7fffffc4:

   offs + node_len + pad_len = 0x80000000 (INT_MIN) -> passes the check
   node_len + pad_len        = 0x7fffffe0 (positive, 8-byte aligned)

so the following alignment check also passes and ubifs_scan_a_node()
returns 0x7fffffe0.

ubifs_scan() then does offs += ret, buf += ret and len -= ret, leaving
buf 2 GiB past the scan buffer and len negative. The trailing
empty-space loop (for (; len; offs++, buf++, len--)) dereferences buf
and faults on unmapped memory:

  BUG: unable to handle page fault for address: ff799130402f9000
  #PF: supervisor read access in kernel mode
  RIP: 0010:ubifs_scan+0x24f/0x2a0
  Call Trace:
   ubifs_replay_journal+0x13e/0x18a0
   ubifs_get_tree+0x5f7/0x2410
   vfs_get_tree+0x2a/0x100
   path_mount+0x36d/0xcf0
   __x64_sys_mount+0x12b/0x160

On an unclean image the same wrapped length reaches ubifs_recover_leb(),
where clean_buf() computes c->leb_size - empty_offs with empty_offs ==
INT_MIN; this sign-extends to a huge size_t and the following
memset(*buf, 0xff, ...) writes out of bounds. In practice the read
fault above is hit first.

Bound pad_len by the remaining space instead:

   pad_len > c->leb_size - offs - node_len

offs + node_len <= c->leb_size already holds after ubifs_check_node(),
so the right-hand side cannot underflow, and the comparison no longer
depends on a sum that can overflow.

Built and boot-tested on Linux 7.4.0-rc1 under QEMU with nandsim
(128 MiB Samsung, 128 KiB PEB, 2 KiB page). On the unpatched kernel,
mounting the crafted image oopses in ubifs_scan(); with the fix the pad
node is rejected ("bad pad node at LEB 3:32") and mount fails cleanly
with -EUCLEAN, while a normally-built UBIFS image still mounts and scans
without error.

Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Cc: stable@vger.kernel.org
Signed-off-by: Mark Payne <mnp@pobox.com>
---
 fs/ubifs/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/scan.c b/fs/ubifs/scan.c
index cbff2d800e27..441b2f04a0ae 100644
--- a/fs/ubifs/scan.c
+++ b/fs/ubifs/scan.c
@@ -86,7 +86,7 @@ int ubifs_scan_a_node(const struct ubifs_info *c, void *buf, int len, int lnum,
 
 		/* Validate the padding node */
 		if (pad_len < 0 ||
-		    offs + node_len + pad_len > c->leb_size) {
+		    pad_len > c->leb_size - offs - node_len) {
 			if (!quiet) {
 				ubifs_err(c, "bad pad node at LEB %d:%d",
 					  lnum, offs);
-- 
2.43.0

