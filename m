Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94052CCC7
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868282; cv=none; b=t4gfCHKwy0YdSB9B9woy9s9KTnDctU5XW+qMNf/Tm+Et4evjpfBs+H6S7jLNkkmaiVQ2XPh3yyX/nKqzzIZrAFo1gdNBRwabZ86S93lS1g3Jbo9p29JD2iMf6P4K5ACTByp+kSqdvM5hHW9DZD1QbxG+blCKzcyMVFhoWc+hjok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868282; c=relaxed/simple;
	bh=4WQWF5+OUtltfz6w2snpbVpU40IHfEIiSULmc0mqAXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pccYRQAwPB/7dZU31N9GfUHELfaELzpwI1TEuBIK44QQGsZJI105zwtlRk2PWRk0aL2fMQ0srSXFOyCNg0HcHe6+UNdqRQ4NjoXPqffOx9dF/TAxDaGw6ZnGwjckan9rC7YQc3q6ql4tbvn/fuOGV2X0I+/xfuAgpLqPHxK8P0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPd2iV85; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPd2iV85"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-8873070bcd0so912811b3a.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790868280; x=1791473080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=63RaKzWIMFVRr/E5wnyxWJ/zE4DRy1eSD5nRt2ODo5Q=;
        b=FPd2iV85VfSbxypa38SgGyZYc0tuyQkTZyMT4/lNWVKgpsOHcW2sXo5Y0l5LiCsZjW
         h35TDxgTJEN+Ru5JZRJ/FK/jB3t1Uxupi5cH68bcJcs8u7HgPXR2TAtHoyit/IwDdc5q
         uY9pX+aMP1vtIHDBgwVbALpkS0SheYp5+obXdOS1cUvpxVke6A4xUyhL+mcw84+cchFN
         ldfBLOjgTKRU6rSqROVSGR3mrLJbjXx5FZdlsYh/UQT+yE/hsmOyO/lZ/nKa357Jaed0
         gF2NRIeZY3FrSJnj2Ui2M1dzdg/IntI/MgUbZI2WSNM+P40C3Q7d+rYyIaTgUdo3nPbZ
         8hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790868280; x=1791473080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=63RaKzWIMFVRr/E5wnyxWJ/zE4DRy1eSD5nRt2ODo5Q=;
        b=x3qOLrrPb1xmwOyBbPoFphh3MtuCqWLxMK2mrYNq44qC3j3oIvceXNQCT/emn4exmI
         JDVMYfTpecakpa5cDyCB7EshdjCS53dNrRLBtKAT296V3Xq9IsJZvcyznVMnCNEr8u13
         +ODRYZFRSvi9HdMXiQTEY4RAbKwe/MYe07Z91fSiqqmrvOv+1SuepY9DCgYLVjU3n7oU
         l6M3Tn9b5+gbZNGzVYi2ngvxn8EAa0mFjMIwjZy2919PoP80o97e3OZNMMQiDLVQYkmM
         kYuuwkMQ7U5UwcdZx55OPRC2tfrTtWekEE2aOmX+nLoUrpew+Y5+g3RcWyKUQZgnOsp5
         XCCg==
X-Forwarded-Encrypted: i=1; AKwUvByfm0BLYtqdJQ5GjomixRmaXHUUMY1XChbbRtdGtMQrqjgBi9RLsqV8etLgx5PZr9xMxPZIBUE=@vger.kernel.org
X-Gm-Message-State: AFuF++l5MGY51/f0kRP+FdSr8brIWIQX0CicbPS8eIPg6nFkdvaRjsKB
	IUL69zoAjaocz8qun0eE34bXl/VlzlVqXgYa0sC5DjjL2+raSHo0VXFH
X-Gm-Gg: AYBFou3q7T/G3IUeDvU4kSckQUC4/fdCqXaMBgwEQaFrKWNDvOOMgiIVJFlSFxt5O7c
	lPCZwl6Tqep2gT/WrC/1e0R5hFt17uJPYRIYt6TwLVQI/MCKGIp2t+qNJHP/jD8SO6LgiHmLgox
	3lgfo6JTFMiRBkAe43SrR2Go38RF6MypvoPT0iGRf3B03B8tpiwWpT1o1eJBOaKdUK4sHnK5roD
	I3udYv1qBqGG9S2kOnR49PbnrV1HM7PsFMYm1rXM4Jrbu/IA3U9gV2LPuHuCzM0MnOlxf07iN6z
	2kneHl/UytcwnFZyRRRlpp7LobgeSPz9OtI1pxD+yMSplPN+AReVnJ0BlCidfLDxIhA44rPomur
	zuYcl55ELhLKm1xFoMJIrygBwS3JP8/01FRwzbJRRAT2sN4a9M6HredXBZxnSUiJtHoxJkOkcC5
	ji/lPt2roNGS5ECIEzJy0sopA8ENuPqgyQ1ZbZA/i1vFHxi7WYs3ByQwXQrpVfry3RbU5nRVwfr
	epWX+YFNvYDvbwXuLjs
X-Received: by 2002:a05:6a00:3491:b0:881:7ff5:606f with SMTP id d2e1a72fcca58-8874c5db447mr4206416b3a.43.1790868279823;
        Thu, 01 Oct 2026 08:24:39 -0700 (PDT)
Received: from localhost.localdomain ([112.171.72.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8881871bdc7sm1325282b3a.14.2026.10.01.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:24:38 -0700 (PDT)
From: Youngsung Ahn <ays511.kr@gmail.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org,
	Youngsung Ahn <ays511.kr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] RDMA/rxe: validate inline sge_offset in finish_packet() before indexing inline_data[]
Date: Fri,  2 Oct 2026 00:24:33 +0900
Message-ID: <20261001152433.3259573-1-ays511.kr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930182216.2510953-1-ays511.kr@gmail.com>
References: <20260930182216.2510953-1-ays511.kr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a user QP, rxe_post_send() takes the qp->is_user branch and
never runs init_send_wqe(), so
dma.length/resid/num_sge/cur_sge/sge_offset all come straight from
the mmap'd SQ ring. In the inline send path finish_packet() uses
sge_offset directly as an index:

	u8 *tmp = &wqe->dma.inline_data[wqe->dma.sge_offset];
	memcpy(payload_addr(pkt), tmp, payload);

inline_data is a flex array whose capacity is qp->sq.max_inline, but
sge_offset is a u32 from user space, so the source pointer is
displaced arbitrarily past the WQE and the memcpy reads out of
bounds.
commit 126c757e4cd4 ("RDMA/rxe: Validate num_sge/cur_sge before indexing wqe->dma.sge[]")
added num_sge/cur_sge checks on the send path but not sge_offset, the
third attacker-controlled index in the same struct.

Read sge_offset once with READ_ONCE() and bound it (and the payload
that follows it) by qp->sq.max_inline before indexing, so the value
that is validated is the value that is used.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Youngsung Ahn <ays511.kr@gmail.com>
Assisted-by: LLM
---
Notes (not part of the commit):
Reproduced on 7.3-rc4 as uid 1000: "BUG: unable to handle page fault ...
memcpy+0xc/0x30" from rxe_requester, 4/4. Present unchanged in mainline
551c722f4080 (2026-09-29) and rdma for-next. Compile-tested (KASAN+RDMA_RXE),
not runtime-tested. Found through manual review; per security-bugs.rst this is
public and a reproducer can be shared on request.

v2: the WQE lives in the mmap'd ring, so read dma.sge_offset once with
READ_ONCE() into a local and validate/index that local, closing the TOCTOU
noted in automated review (v1 re-read the field after the bounds check).
Dropped security@kernel.org Cc.

 drivers/infiniband/sw/rxe/rxe_req.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 24f5c044363f..06e24d818075 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -510,7 +510,14 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,

 	if (pkt->mask & RXE_WRITE_OR_SEND_MASK) {
 		if (wqe->wr.send_flags & IB_SEND_INLINE) {
-			u8 *tmp = &wqe->dma.inline_data[wqe->dma.sge_offset];
+			u32 sge_offset = READ_ONCE(wqe->dma.sge_offset);
+			u8 *tmp;
+
+			if (unlikely(sge_offset > (u32)qp->sq.max_inline ||
+				     payload > (u32)qp->sq.max_inline - sge_offset))
+				return -EINVAL;
+
+			tmp = &wqe->dma.inline_data[sge_offset];

 			memcpy(payload_addr(pkt), tmp, payload);

--
2.43.0
