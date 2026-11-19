Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795072725;
	b=irwj8kI9x2zLPe/gSgN7/8NbXRKWdnMaaCLYbQl7pXlEdfJmf4PJomD3ppg0uceL7TeL
	 biJ8qg1yez6e5XFXVYeyES6U7cFOiOse1P/db4SzAgph5WN840uLJwtbyo0nGfGD+jn4K
	 1W3x91jcb/oqvp9E7B2cyIwuwhBhRGLs8k0aTQd4a8cdhbTDGW5+PJN3NccV/z0Yh9yh4
	 wsLv1L3eVKU7BArlbunjBJBiXKUG+ZeIRxzBppZG5/zd91xX7ta6K1ZSYVejQkt+PDT2C
	 DhHcFIvyT0JHJwGAd3a6aOLoTQzPLXrMRU8V/xEFvSY48i9G3/AzsCp0ygFlffEu4Pw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=NsJb7bPA9D+bcQDpZCNr8K9FWLxPII4RzY6xFEDpZMg=;
	b=QefYiwiBYIXohwImY6hY+YC69lxIThwsElMxk+eoxM0de8JTKQiAx6xmIgd9zlBtfVqi
	 XwTnrTBIC/aAhimX4jrmAZvCoK7jWc99PyI/gLM6i8xQHbN3AmDDUlGkkeBk/sXXr4yOe
	 iJJ3lC6hhQfTNBK4XJla4fePbAOaDNr4W5buybk65Hp4GziWjyjIYCPLpbdY7aQUVVsrH
	 GdSnaAWzRTpF/drlge9B0LLlsgKbQcpetuavVRsixIM6OwFRSj1Xca/0W3aA9EFv5XS7E
	 m2QNxl2pBp+n3PabivCgZ4HQKcvgkVUIAxekj9es0PubJga6d8maCXDkPek+10RxXIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BiYz9lJE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B6B606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2B6B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BiYz9lJE
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91f0b9f0b1cso18667206d6.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:18:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795072723; cv=none;
        d=google.com; s=arc-20260327;
        b=k5Z1Xo6k11WDmxrczwlm+U4cD8F7Kx2j3ZgOnnaPUtu9qT6rKv7ZGagoY/6hFJl0yB
         iJjO+g62Sliw0jbTeb56AiQA9+DTB4DAcpoov4O9RSAZ1Danxw7K5TArF7moJboQNkyP
         1RIWydzmGCdeW+VZEdDWUDJ3bKP61RuQjd8Kwk4xYlC2Giej9MdLca5LeUV03+zwN5Hp
         GfnxFbMkK0de7C4yfYtOangcBysCa73PaBiEp3zYjelhzzqzcVq4Cc+s7LbYvE462VPx
         cmu9S4JX6vTJXebSlpmuNmd+5TfhVad6P32E3WQvAbtovZjsdSB9WxT+LFzugHaXdtkA
         McJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NsJb7bPA9D+bcQDpZCNr8K9FWLxPII4RzY6xFEDpZMg=;
        fh=KZI2Q89M/HHGubY/MjjqfSIWYxg6ghIMrJe6w3O4VIs=;
        b=qFc0HjP0yZck/Ji/K3i1FpJncvdlMPQb/qSe0WXHTMhXD2c9QPW5abGbnAqSG3DOW0
         YSrMN84dhw0Pl7QmaXlp5KBKEWY4RXWwnufEOvVDVevYP0rkFPoOpaW9OCwvSV+Ad80p
         SBhjcsjUpaZZpcy7iUpl2yPu/GMX/8/VcjxFCecRlzF6YM5PmX6UnDsiKfWH2EgkLwr/
         WxFlJTfTt/xjndeIooyll7Seww4b++x1/qoGmUsQ3npqKtOZ8P75301/PxOCDe40QFRv
         fYVkIfGKNDEoVepY2Z7jWRBRUnCg2YmEQMHf3y62yk1VVELZDxfj5kwN0nT8lExTR4eL
         ekQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072723; x=1795677523; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NsJb7bPA9D+bcQDpZCNr8K9FWLxPII4RzY6xFEDpZMg=;
        b=BiYz9lJEERcoGyT04qVsDnpRknGsxOdwQXMrJP2DZ0x60fmfzVOwGDIuuevls3tQMs
         zUiTqUTqMaicg0A7nLQnAKQ0qWMGNRz9Eyfkit0HCAKT2RO7h7/feC4jKf7Mrxd0uNhN
         7ke0RwaLAtJfKR+Naq23c4Soy7izzkKkA5ym+gAF6r9zNrT4/dQY5uX8AX6+hGoR727/
         zo/Jzi/4JfRR5CNJrfEZkQvTb0FPbHezGUG9C8Ur3SLvaIOA6pgvSMzOatU26oziQC8N
         IlMEWUJinVPHrekV5H17XucfZBm1tw40lFH5qAFi7W4uWziYQRpAdJUw0n7uHZjh2/N7
         ZeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072723; x=1795677523;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NsJb7bPA9D+bcQDpZCNr8K9FWLxPII4RzY6xFEDpZMg=;
        b=qstqUBPQCa2JqP2yc7UFhB8s8YKwysDqn7PEkXuy9Sd26HZ38/lz7RDMvPFKnOrY74
         8yE4z1sj8tccgxWcOcT0kQ0zakwFp5QbBxR2UUdgI1gAJSallEBpcqKAWNau51luGAlP
         0vRnZMADLfN+zYsFsOlyXwigzyFukjAqYmmdvNJ8whOAGW+I5hBVpGHJanCwsfPoo5/D
         1LW7NBQL0rNtfJgES6HrvDbmuwB97noARKQgSSB1cyqscKNj0VaFEYjnXa2vCVByZFxX
         Q0mD/+5J93biod8yd0vgxAbXwdcbTiTj2xNnLlNV+qIsf0mYE1tulXvm56BzP3NGhkKV
         taqQ==
X-Forwarded-Encrypted: i=1; AL+hErEigH+U8CiV4AvsOxdFmOGrRvDv68d1qSdSzGWq2JfuLPzvc4iZllVONLU3prbJx0DSiqYgMxo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8V/gWHzyvgodM9na9PgPSfr0P+rcTI67ufJGrwGEoTl9gFcRAI
	8FniYn2fsRQ/FkbZgqqmMrOKCS85AmftTuDg3QZNf95CnHhejhu8jLbYVFKvavTfdaehu32F+IN
	b+5QH11kugzpx7CkubHoKhKWCs+XiPwo=
X-Gm-Gg: AZFdTZeiqHJGDePT8fvKT002RsVdcE0dvZgrJk6LqAzXuqosXm/F3jDWS+Hd83crWEd
	Q3XF2ftQtHFRwLVt+pTlZU5HuaWH5B8D+2t8A+QqoRO6KOzoPx/XrV45wOZUG+Fn4ajAZ73hnj8
	9YiudWPO1WFj11/XOvYQyWju+7kjiWByUN+gwt5D3r2dJAvfsZBz34noUbADsumjPNlWExOB0Nm
	1NxMfeHXYvswEaPNlNWVL8uYRUl6zrbEqe5HzEjvQqabGsrisCEpolAWREM9ZvoB+2/fKXX6ECt
	5ujW6Dm+cjU6EPE4jH5a1a12hQqnjU6vHXo33NGP7v0+NV6NJoCZlGB1mWa2iQq7M72F07e9xy+
	YwNOah3QiFOBC93d9ehmnGXYI7GNIbyx0NVK3IcJj4tauiMePGNptY/CyO2PMn4P8It19EZTPHo
	sDeduQo9MnhC16ExN4PQ==
X-Received: by 2002:a05:6214:2484:b0:91f:10b6:2743 with SMTP id
 6a1803df08f44-92114f68851mr74072936d6.36.1795072723595; Wed, 18 Nov 2026
 23:18:43 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 02:18:29 -0500
X-Gm-Features: Aa3M54pxDoYxauvJoi_1hEHlnijhpNFabeXJ38e3q8jAEIPpcdRwokeVm9U0kZs
Message-ID: <CAMcAce-ytH2Xt_0+1fKXzxy+a8fi0Md-4SSoLZ1RQxKQoLq-tw@mail.gmail.com>
Subject: [PATCH bpf v2 1/3] bpf: Replace DECLARE_EVENT_CLASS names in raw_tp_null_args[]
To: bpf@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org, linux-nfs@vger.kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, stable@vger.kernel.org
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
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
v1 -> v2:
  - Correct sender identity and Signed-off-by with real legal name per DCO.
  - Remove drafting notes.
  - No functional code changes.

 kernel/bpf/btf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a123456..b234567 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6605,10 +6605,13 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "bcache_journal_entry_close", 0x20 },
  { "bch2_journal_entry_close", 0x20 },
  { "fsnotify_bump_event_seq", 0x20 },
- { "nfs4_inode_callback_event", 0x200 },
- { "nfs4_inode_stateid_callback_event", 0x200 },
+ { "nfs4_cb_getattr", 0x200 },
+ { "nfs4_cb_recall", 0x200 },
  { "nilfs2_transaction_entry", 0x4 },
- { "iptfs_ingress_postq_event", 0x1000 },
+ { "iptfs_first_dequeue", 0x1000 },
+ { "iptfs_first_fragmenting", 0x1000 },
+ { "iptfs_first_final_fragment", 0x1000 },
+ { "iptfs_first_toobig", 0x1000 },
 };

 static bool is_raw_tp_null_arg(const struct bpf_raw_tp_null_args *entry,
-- 
2.43.0
