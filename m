Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069200;
	b=gEG4J8t9FDra9NsU9H19YM3tU222AP1XpqKqZHLLB1zUwA6Yv+ECD8qNmZyI/qPlAbZ2
	 qMZz4IoNOOr62g2X1c/UmOB0euFfipnS4LUMbQNw47/hmbZTVdDL3H9gp1bFoclKky8kt
	 n0SUOrrvINTZ9ytx98bZZInHA+9MXg70Waah2f8StqjDq0KqL6oblLnsdGcEvfgqkFSYM
	 SwtDKaLUUDELkIAMHTtTo6WLFs5b7qTVyOJXKFi4PJvKx4GFMdbTOWxqTFQpTtJo4sOXV
	 l/0g+r2xdIZCtlsBxYAk87900F5K7K4SeZSjcdofvqiurPGo+yghPbuA9TN7UVOCGVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=xoCndVwrvCSfCd0BaHKCqL9ELaacWGRyWSDCytAWBDI=;
	b=ZWTDGb4eb7IcRbFZJY9HBRxmnFIucrKbf6pYIGJnHAyNE4HI6tLV0wd+Lv86ooVCpDKL
	 4zZxRu+FfeM8jB6gN3GA6nMy9k5xsoDcX0wiFivzrmFkbfLWX0cO2SszC93tIjd9QcmAD
	 SlqXfEH6zOUXNMgam+luNsPM4X2ziSNBVPd1FYCmipNu8O7S2vtb2+L6S/JJaAj6UBIwK
	 iWHmiGsEPs5Vb8cgb5bGiGfvBvHX5+Czz/FAkgyfTUvnqwK7QY85legZgcRKVRwWeJ38b
	 Lnx3ht7R0pW7jt+Mah/CgcKyODiOJN83CesZzbCmhp9wRjGxiKpFgnHtR79Rs3yM7uA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UT7r6HIM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB5606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12AB5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UT7r6HIM
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-9212dac247aso755266d6.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:19:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795069199; cv=none;
        d=google.com; s=arc-20260327;
        b=GFD9QnY0gAk/jgw01N1TS6jWtSgR+aCEBVck58VRkUQUbGUhUnhNB9Rg6hlfxScbX3
         tEmk8sSq9le/RxlssTuvIG6mtaHdoR19oyXePwFeyD69WEWZocvj4aqKAR4dZ0mouBct
         PzRqqN3QCfQCJsIV7OOW9ttMGZTpYu5Eu69lBhfjrKzsyG7h0jucyuiSxMFRzLRcQlAZ
         s3qRRNLex9M/JXFTchtIUOL8wndGbAbQ6+bCMiy5UMI2L2gqqiULwr82ZjBfrpLG8Tq+
         +8FB1ZbYUip2lYFql8+0LHd9s9UyxhNKD8hpZl+A9huG9s3MNZRpXwrEno+9YFRXfZ2o
         /pMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xoCndVwrvCSfCd0BaHKCqL9ELaacWGRyWSDCytAWBDI=;
        fh=doG9+8O0Hg1Y4xQ4XjYNx49rTNCOX5bZawSPjAuqGKY=;
        b=WaSocDodZbk1kaY7PLf/GT3U6axoPMDv/Rov94kYbcwF02s1aJPHy3CJlCJFli5p+C
         H6pazSA1zB58AHMjcW5KV+WtKw/7nvcwrvcOTTkZvDjL/yFRf0FCYOYRbh15VukkAPSY
         f1WMGF/dPXFdhcz2ViBHRzTUtdcR8SWqAbKwLWqTL32U1OmB1nwqRdm6kiQmH8z9ZMRY
         FAPojXc78FeTgGMwxKX+xHnA8CAHvs4pHiaMbbBLutNSqw8CVVFVKEmsmxjQb/eSeTCF
         U1RIjceAPv+jqy63XVbAj5ojNKwiW9Z9K2SXbny2parXuELGNlBuvcaLK6L9f7DTr8lc
         IaFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069199; x=1795673999; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xoCndVwrvCSfCd0BaHKCqL9ELaacWGRyWSDCytAWBDI=;
        b=UT7r6HIMP8x6DmYZaQezLkvtfE9jNe8QAZNjoZ+BDLGzqxB4OhFh83dq2c2fciCrs0
         7fuwCWV8wQqIvxi9O3MUE0IR/oZMWHzvUTGYfc1aN+Z//8i+lhbV8PKSw89euW0ZQk+H
         8q5pGCTpngISoL3G/Cb+omZLqqhIVPdvAFuv6b2+g7FV5AWky6L+uVa71XJbPqKri9I1
         dZXoe+f8xzF4CDQJKfgEocHcqWxhEpQOfdD3u1P1GtLbiAv6i41ol3ck/rANGAfP9rnU
         Gug2I0Kyk+h0n1UkYk86LPFEZ1RNs0GugUbSr7SGaIIAhH6643rg0QYLZACAQp2am9Bp
         BvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069199; x=1795673999;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xoCndVwrvCSfCd0BaHKCqL9ELaacWGRyWSDCytAWBDI=;
        b=LwXe4H7ARSGxc7+Ywg418z3RAEQqF6FloaEZ6jcgEVFjfpy/nG4991phYJJsqmv9rL
         OPuHtjpGOoXeVPJINSMiYuTK0GIrdRUXspATPLnQpq1YWUKbAYZ6ix/qQ5nxqjdUEj49
         eUSh/moflRwLL2tcHt6H2Xkh4mWpIpoz/1RiBOqWj7E1y3BEzk7aCGPzTAWs4VZSUWjV
         CmUmOSmfmD8XECo+pgC3AFGZVjAa/4K81TtnIar59UosHqDeELsB1zSS/eMGMB7pSaxW
         Zhvnw5l4Qih4AgmXUVSwD3X0xOxojAO/TbZqueLKV19j6A4FnhWJEdoBzO6Tck3gvfC6
         UN5A==
X-Forwarded-Encrypted: i=1; AL+hErEV33gaJ4WVot/2H6IK/ssvVoWkQX+VSpFmbd9V5Hb/sLAEBlY3fKqPf18GHcwGNQUpNIYRDfA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/W17jYpSHTsGuRK/BH8hr1tgmDITACt28jJKI2Xvk7QjluLgsW
	X5ppKneG88JPOOh5jIhK6c8bpaLwK5xCevavt8/johLdmhvBt2Ko2Ql8h+9nHwbjOm20iCY5MHi
	zlhHyYuPe91WNTfbc0tPT5V+0miac8K0=
X-Gm-Gg: AZFdTZdcfEhs0CN1MsmfrUiQ/c6RXrBFeMUxTznjmFJfQ6FRQ63+x4pobrqxztXSxmo
	bgL11lxy6IxQXsFugCXBtuQ0edtq562xqk9TltYX7a+tokVu3tLv3VtuO9ssdTj5AhJ6SH8T4Wy
	6xmfhksgj+rEFFPxfVtEGm5dRPZCBTdRoA9RRRR8g/n41Mm3b7wBvhvks3d4rOmLtFWtEfWRxCl
	R7NQyqKQ3FR7AZ9i1lG8yk0AKgYxFsHpfNRrKCXMgxq3H/WTzW0f3Sd0NSpUDS6PyxLi2jJg7D/
	nm+NC938E7MyJED3jeZyBwRjEwmkLg73hLZHQ1AxERAUQ+wx2f4zTT72fjKHggb8Owwi21/ykPK
	7VTiYzznf6NHBGrwTzdP//Fs/pZDYl6EEEDrKYJJMGAxdrlrXxPgbubdxhgqKEKjiKMLXN3aiX1
	k1mqbb39XnKsILJrLpuw==
X-Received: by 2002:a05:6214:21e3:b0:91c:7a3f:f548 with SMTP id
 6a1803df08f44-92114f7d496mr80145356d6.49.1795069198906; Wed, 18 Nov 2026
 22:19:58 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 01:19:46 -0500
X-Gm-Features: Aa3M54oxphJvWdfM-fUHq_7nMxHgG-ail465DDEoF5yzwUuPEfq0cOpWCDpLL0o
Message-ID: <CAMcAce-4z6mGO70Bb32quoTj0aRmVERxPKCfb2VpY_w3wHjaRQ@mail.gmail.com>
Subject: [PATCH bpf 1/3] bpf: Replace DECLARE_EVENT_CLASS names in raw_tp_null_args[]
To: bpf@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org, linux-nfs@vger.kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, ast@kernel.org, 
	daniel@iogearbox.net, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

btf_ctx_access() strips the "btf_trace_" prefix from attach_btf_id
and matches tname with strcmp(tname, raw_tp_null_args[i].func). Because
each attachable tracepoint typedef corresponds to a DEFINE_EVENT() name
rather than its DECLARE_EVENT_CLASS() template, three existing entries
in raw_tp_null_args[] never match any program:

  1. "nfs4_inode_callback_event" and "nfs4_inode_stateid_callback_event"
     are DECLARE_EVENT_CLASS templates in fs/nfs/nfs4trace.h whose
     DEFINE_EVENT instances are nfs4_cb_getattr (:1455) and
     nfs4_cb_recall (:1518). fs/nfs/callback_proc.c:50,106 pass literal
     NULL for arg 2 (const struct inode *inode), and TP_fast_assign
     (:1424, :1481) checks !IS_ERR_OR_NULL(inode). Keeping 0x200
     (0x2ULL << (2 * 4)) sets ptr_err_raw_tp = true so btf_ctx_access()
     assigns SCALAR_VALUE to ctx[2], rejecting any pointer dereference
     even under if (inode) and matching existing raw_tp_null_args[]
     0x2-nibble convention (0x300 yields the identical SCALAR_VALUE).

  2. "iptfs_ingress_postq_event" is the DECLARE_EVENT_CLASS template in
     net/xfrm/trace_iptfs.h:108 whose DEFINE_EVENT instances (:130-148)
     are iptfs_first_dequeue, iptfs_first_fragmenting,
     iptfs_first_final_fragment, and iptfs_first_toobig.
     net/xfrm/xfrm_iptfs.c:2025 and :2051 pass literal NULL for arg 3
     (struct iphdr *iph), requiring mask 0x1000 (PTR_MAYBE_NULL).

Replace these dead template names with their DEFINE_EVENT tracepoints.
Verified in QEMU on x86_64 7.4.0-rc3 (iptfs_first_{fragmenting,
final_fragment} and nfs4_cb_{getattr,recall} flip from LOADED to
REJECTED) and 6.12.118 (nfs4_cb_{getattr,recall} flip from LOADED to
REJECTED; iptfs_first_* absent in 6.12).

Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
Cc: stable@vger.kernel.org # 6.12+ (nfs4_cb_*)
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/bpf/btf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7e866bf..0044156 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7403,8 +7403,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  /* nfs4 */
  { "nfs4_setup_sequence", 0x1 },
  { "pnfs_update_layout", 0x10000 },
- { "nfs4_inode_callback_event", 0x200 },
- { "nfs4_inode_stateid_callback_event", 0x200 },
+ { "nfs4_cb_getattr", 0x200 },
+ { "nfs4_cb_recall", 0x200 },
  /* nfs from pnfs_layout_event */
  { "pnfs_mds_fallback_pg_init_read", 0x10000 },
  { "pnfs_mds_fallback_pg_init_write", 0x10000 },
@@ -7441,8 +7441,11 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "btree_path_free", 0x100 },
  /* hfi1_tx */
  { "hfi1_sdma_progress", 0x1000 },
- /* iptfs */
- { "iptfs_ingress_postq_event", 0x1000 },
+ /* iptfs from iptfs_ingress_postq_event */
+ { "iptfs_first_dequeue", 0x1000 },
+ { "iptfs_first_fragmenting", 0x1000 },
+ { "iptfs_first_final_fragment", 0x1000 },
+ { "iptfs_first_toobig", 0x1000 },
  /* neigh */
  { "neigh_update", 0x10 },
  /* snd_firewire_lib */
