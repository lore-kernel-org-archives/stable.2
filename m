Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED32741A0
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791166359; cv=none; b=am1O00rd9swqDVhou2iwkCMz+bMqMTVW7VfE4VwhjXGJFFdfBXpAPxjoA+7zeJvzXFUEKAKX71mxUACnRx+oeoMK8IA6jkLqTB8uGYjP1ijaZSwSlEvJ0X9i8RtMofvoxaJJBAtvvdBVEwicYsOpFObHxvbjuR97gDQ5oC3SCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791166359; c=relaxed/simple;
	bh=BGUhXXXtcnuShkA03X+V+8ParF89SYrXypmzAkwkIi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ho/U2Qm1TEJLxhVLw15zMNMWn23PZ5BTggWhFbi00xOISnmyIbAW/qFaGKycttGT+Evuaf2/YqpZl8jJMWstram8g8z0QALVSvYSGdatvdIS1Row+FoMaisztT4DG0JR9WVebwBqgWSGAZhDZdYSA1kg/jIQxmZMe02Hu5+4G/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=NxrDoTOA; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="NxrDoTOA"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398beb616f5so443176a91.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 19:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791166355; x=1791771155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F8BtH1wOi3R0dL1LEJcbfIDWWZE0ydiC1A3fSU2odtA=;
        b=NxrDoTOAfNHLf9zKj4gZ02GZ2m+0YCUQhD1TxhTdE07MTFxSiRBGcME/iwa4QrQj/V
         dJmBI9dby9oXwCCKSZjUqzjXFv+OGuByf4mY8yTObEhSEyg/TPmz/v5U7/ZZBubCwLg9
         Ye0AH/M2O3dxqrcpCaAwpjk71Q9F4S/s6jpyv8TaxdFq6mG1ClnL6595rUtMHmPtD/wX
         N6Z7+2hFg1YHc/HSTaDNpBjTRBx1z7DaEfGWtPTgUyM6N2rtragtkPHjD+vZ6VKm78hN
         4HpIgN3TtdVDbsPtk25LFPZhZb9ajWcUkC0apHDDR0IEbhygdbY9uL8nfgySxsVp4FKU
         MVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791166355; x=1791771155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8BtH1wOi3R0dL1LEJcbfIDWWZE0ydiC1A3fSU2odtA=;
        b=m32GUFafZkIjnQqJX5A9HLry6RHDrq89AtOCgrA3GCZLaFv1A1Tv6ntwgf8tbpVECv
         t0GPhdQfPxUe30awg9LFmy8UyQ+Ynu1XFolt81Z8fOXseb/Z805HPUIsEaTKYm5ScQ8C
         LqAW3+2tAAncV4p5JyqdE33l7B1Z9xSviD+4N4YeqWnjw0uBR+hX01NUhnnyqnOTicF5
         OjIB2A4/mO6RblbxMKnQil2/LiKuN2J3zH4pMePtITYbZ2C6LL+8w1GzI7SCToRxyR/l
         FZuYVF0gVz/kvivmhHje5/qEFinrv2Qb0g3mJvDAMRF7LrGUFc5CBZHMiXC8bOFHjpA0
         8+DA==
X-Forwarded-Encrypted: i=1; AKwUvBytkn+LZl3dU7WuVGieXMs74jIikvqvp9prtnd48KCHXJEbWbCT/VLTlQZNpEA+fk1U79MV6BI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoEA4jv5Pg9W4ZyfE2tvfdTdgl3lXqV/9RVFnYgWfxxDL/3LN9
	md7vRah9XPG72kY8QqZ4CiIqw2YeMU7f4zb65x4B8zRxGrfRBMsuTqarfNdA0/X99qBsRpVUYNM
	86waR
X-Gm-Gg: AYBFou01cF+rvorbuqYXNgENPk1JDRGAhaku1vRllJ4aTzQoTglZBO6erZyF4mXlkhR
	HX/JP87gC2+wY3/VwYgFet49NZLP4X/iYiRv3gZv51Hhe17w0PE2rt+mPj5PY+ksA8KQ3kcH83k
	bWW2ySClPSirX0vRKTPkAgSuGvVoR8XAcszjx/QRex/nyjQn8Nw+fx6XHu9pNhH6joZWPcgjl10
	fl3nvgD0Yd9uxuq71gaIyZKUpvTlQusIdMEc/N8LeiyPuu5IPsoysco+ccH0fBleUVlipqACxNB
	z05qCnrpEFrQLEODGYb1Q4VVU/g1C2tHkLQWXSz2VZH9pZzxJDgTKEVIea5uhXYS9Tc5yTHOxAy
	QqbLWefhxzbYQFnqcaiJlcmbv0DoPMcC6PKQphugne4XahODSjuk2J5uweajZh0qdwGC+HKPjRu
	EjTBjHTjFGjGTImzlMe1Y89ZhF/bMTek/RbUNlWEkJximGhmgWx40zlKBFBZ/6yMSPA39Oc8S9/
	a+z2fvrSkVXJFcpt4BQgw==
X-Received: by 2002:a17:90a:701:b0:3a6:d2ac:74ce with SMTP id 98e67ed59e1d1-3a6d2ac75d9mr3440094a91.19.1791166355134;
        Sun, 04 Oct 2026 19:12:35 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:7020:baaa:df0e:eada])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e61386csm9241660a91.17.2026.10.04.19.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 19:12:34 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xenproject.org,
	stable@vger.kernel.org
Subject: [PATCH] 9p/xen: validate the response size from the backend
Date: Mon,  5 Oct 2026 11:11:55 +0900
Message-ID: <20261005021157.207947-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

p9_xen_response() takes the length of an incoming response from the ring
-- the first field of the 9p header, which the Xen transport reuses as
its framing header -- and uses it to advance the consumer index, but
never checks that it is at least the header size or no larger than the
number of bytes the backend has actually produced.

A malicious or buggy backend can post a response whose size is smaller
than the header (for example 0). The consumer index then never advances,
so the response work re-reads the same ring contents instead of making
progress. In testing this raced with the teardown that the malformed
reply triggers and dereferenced a freed p9_client:

  9pfs 9pfs-0: Wrong req tag=ffff
  BUG: kernel NULL pointer dereference, address: 0000000000000060
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 7.2.0-rc5 #6 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
  Workqueue: events p9_xen_response
  RIP: 0010:idr_find+0x4/0x10
  RSP: 0018:ffffbf5d80063de8 EFLAGS: 00010202
  RAX: 0000000000000001 RBX: ffffa229c21195a0 RCX: ffffa229c2400000
  RDX: ffffa229c11c2200 RSI: 000000000000ffff RDI: 0000000000000050
  RBP: 000000000000ffff R08: 3fffffffffffdfff R09: ffffffffffffffff
  R10: 3fffffffffffdfff R11: ffffffff87a60e80 R12: 0000000000000050
  R13: 0000000000000000 R14: 000000000000ffff R15: 0000000000100000
  FS:  0000000000000000(0000) GS:ffffa22a7661c000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000060 CR3: 000000003ac34002 CR4: 0000000000770ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   p9_tag_lookup+0x2b/0x90
   p9_xen_response+0x17c/0x2e0
   process_one_work+0x16a/0x3a0
   worker_thread+0x172/0x2e0
   kthread+0xdd/0x110
   ret_from_fork+0x18b/0x240
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  Modules linked in:
  CR2: 0000000000000060
  ---[ end trace 0000000000000000 ]---

Reject a response whose size is outside [sizeof(header), queued] before
using it, matching the validation the backend already applies to
incoming requests.

Fixes: f66c72bea129 ("xen/9pfs: receive responses")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 net/9p/trans_xen.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index f9fb2db7a0663..685523be16f0a 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -200,6 +200,14 @@ static void p9_xen_response(struct work_struct *work)
 				     masked_prod, &masked_cons,
 				     XEN_9PFS_RING_SIZE(ring));
 
+		if (h.size < sizeof(h) ||
+		    h.size > xen_9pfs_queued(prod, cons,
+					     XEN_9PFS_RING_SIZE(ring))) {
+			dev_warn(&priv->dev->dev,
+				 "bad response size %u from backend\n", h.size);
+			break;
+		}
+
 		req = p9_tag_lookup(priv->client, h.tag);
 		if (!req || req->status != REQ_STATUS_SENT) {
 			dev_warn(&priv->dev->dev, "Wrong req tag=%x\n", h.tag);
-- 
2.43.0

