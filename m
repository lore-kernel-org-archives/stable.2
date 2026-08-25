Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692F63BE15D
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684517; cv=none; b=D5pfKCJI3mkXVtQP1yn+G9BnkOID4YqU7jqDGhU7hy7rWZ+7ZvcvAvmg0gTfLfbpmSrcM2jNuE387i2Zw3yyLDGRYBsB0yb98nL4WwucsSA6BTJgp/vH9+t92IWlrtnQ9igV01qY4a6hXkUVaTy75Z38G9ahUkE2n3gJISp7gxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684517; c=relaxed/simple;
	bh=X7pDA7UIZPtmUoIrYytaWnc2F7tq1z6bTYR4o48PLQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=na20qO5fQjDpw2BCabfo0w1f4167Qej6VOZsLHeXjWQiHFV0SsnDaarsVpfEs0l8HqDCLoD/mYsM2FvXxEWw4DwUHBXCRQttA5E5uwWHMxmllj9XHmpT8qk3buBkpZ8kKhk9cuR+BDzlxC313VlaQIDDl0vGtior3DZSPglBCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g////zy8; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g////zy8"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-836c8cd38beso69127b3.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684515; x=1788289315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JNIaQSwgW/t/fs+u+s8u3C/hO3umWdaKi6RZs9rk2nc=;
        b=g////zy89dXdsf6BcWPmg9PXja2me48gaKL7FAS4Zul+B4sfba//IDhyLHTg2VzLzg
         BWfgZWG39UI+0Tr/568iw225wcOow5Dpc1QQpSidxoMbrVnhA8wRiU87Qdb2bDGNF0OZ
         kKqdzfdj/Sb1U2dX+1HlT5CLX8OmWynn+D3hKA/j7zxl0I7DKmDCdw1iLWJHmqeyfqXc
         ERPHyIN6V3KswZ9frJjwuOnVeDibzthwtd8R/8HPQUOribk+fnfr8AiBnTq/763EvZRA
         B4zXhOajq3IX84eRKFhszNrF9rbf8QybzCrXu5In/jqF0mNmuaKPQ9KwtZhpOPcLraUi
         g6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684515; x=1788289315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JNIaQSwgW/t/fs+u+s8u3C/hO3umWdaKi6RZs9rk2nc=;
        b=a/Frd+4hzV29QflyfEaX0x8TPMHfKYRqtvjgUSinaz12SBwMVVXtT7pgtKmEFvqcJo
         YjMRVhHRr07zMXnzeo8kMbrrIc1WitqRguBLVDIbtCVyCrXmBF0GhfKteOH8g0ifoGon
         xDemEoOYvd9NUCVy0CC9UchwWCi+PJaaGqnNI7KDRiA6lRlFJz/gJ59IN0APCR/opyZ6
         ZCjZZ171RYRWbCYgHXYzarNELkvc8z68DdCit71qZfqQrBz2OFaevXsykliEP3SyKSYe
         YYsDMfVSBoTFd9LF9X2nd6Mcz6GD9D3z+yn1Z5bnyoOviWtUNDnEEYCulMkc7U1iZ8xU
         z/ow==
X-Forwarded-Encrypted: i=1; AHgh+Rr1s3X6UEDQlxakIiMOvkeMzfyTcDmYHx394iN0zMgt9ArfcogOVgX5gSfHvzH7cuIKDjocL+U=@vger.kernel.org
X-Gm-Message-State: AFuF++k1ydyd5tpXc/nDKdNAu2+c+vEzqEoIiSsT8jQrAV7zM9q/PBbB
	o8Gw9eng8EBQLlPVJ2qZSrLSnXYHW9CoRXIEPIqTOEplnqhloLO9npYC
X-Gm-Gg: AR+sD111aHEhW9znGD1YGTehfL9Fv8r7BAZFLBZVtH2s9oohAdkTguLJdCrK1R+NBE4
	jFSW7b9y3QB/pcxFdmThKJp3+M6WtPmDtsTj6nQn0/bx2vVGj0uw6rji9ijAz2z4JLfEwc1ptp7
	/OSyCWSZPqtfH1aUT7362tUudcoyU4TFmYRj8y1lsurXGim54ncIcktK60WOvzNTRnaiKSLxpPo
	JHVWu08kdLAOn1x73u6BHOKq1u3O4bZ2IBhlYhsAWJQNAF+e16B5s6UQC0E+sSRaxwZEqaD42IE
	xSby0eENAAksfi5nfZxOec1erM9Te9JzeDoY8rgRXkEGTo9ofrriMl41D+pmUrFE/KsSWG7IWQD
	4iLKTCFAgoivts62ZSVpyIdPQHe1EunRnAYWItgn0lsomk7TTB/dhtWVZp7CPc+uo4RNa+jljt4
	xk6KQ2TguPwwo041CnsSKjI+oQTKNrLY0jvj7RvyazYIKa6mzl7Quv6hIJ0PMzMtdmSFSr3/3xr
	r4ZlLw83xWt588yk0bmP6eFDayl82cSt+fXEMUH53Ng7A4Z02WLMe+q1Ght77gVIHpG
X-Received: by 2002:a05:690c:4986:b0:7ba:f0d0:5e9b with SMTP id 00721157ae682-8573fdbda0fmr5047787b3.2.1787684513952;
        Tue, 25 Aug 2026 12:01:53 -0700 (PDT)
Received: from localhost.localdomain (45.78.64.189.16clouds.com. [45.78.64.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8570dfcffb0sm4192987b3.48.2026.08.25.12.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 12:01:53 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] tipc: protect node reset trace dump with node lock
Date: Wed, 26 Aug 2026 03:01:41 +0800
Message-ID: <20260825190141.242219-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824122929.210431-1-nicoyip.dev@gmail.com>
References: <20260824122929.210431-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tipc_node_reset_links trace event asks tipc_node_dump() to walk the
node's link entries. Unlike the other node events that request link data,
this event runs without the node lock.

This permits bearer teardown to free a link while the trace callback is
dumping it:

  CPU 0                                CPU 1
  trace_tipc_node_reset_links()
    tipc_node_dump()
      l = n->links[0].link
                                       tipc_node_write_lock()
                                       kfree(l)
                                       n->links[0].link = NULL
                                       tipc_node_write_unlock()
      tipc_link_dump(l)

tipc_link_dump() then dereferences the stale pointer. KASAN reported:

  BUG: KASAN: slab-use-after-free in tipc_link_dump
  Read of size 4 by task poc/115
  Call Trace:
   tipc_link_dump+0x10cb/0x16b0
   tipc_node_dump+0x4bb/0x740
   trace_event_raw_event_tipc_node_class+0x258/0x360
   tipc_node_reset_links+0x14d/0x1a0
   tipc_rcv+0x13f5/0x3030
   tipc_udp_recv+0x4e3/0x670
  Allocated by task 0:
   tipc_link_create+0x1e1/0x1020
   tipc_node_check_dest+0x7d2/0x11a0
   tipc_disc_rcv+0xdbf/0x1430
  Freed by task 89:
   kfree+0x131/0x3c0
   tipc_node_link_down+0x267/0x4b0
   tipc_node_delete_links+0xec/0x160
   bearer_disable+0x107/0x260

Take the node write lock around the trace event. This serializes the
dump against tipc_node_link_down(delete=true), which frees the link
under the same write lock.

Fixes: eb18a510b5cd ("tipc: add trace_events for tipc node")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
v1 -> v2:
- Use tipc_node_write_lock() instead of tipc_node_read_lock() so the
  dump is exclusive with link deletion.

v2 -> v3:
- Use tipc_node_write_unlock_fast().

 net/tipc/node.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 683a136e53ef..bd91378b7540 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1333,7 +1333,9 @@ static void tipc_node_reset_links(struct tipc_node *n)
 
 	pr_warn("Resetting all links to %x\n", n->addr);
 
+	tipc_node_write_lock(n);
 	trace_tipc_node_reset_links(n, true, " ");
+	tipc_node_write_unlock_fast(n);
 	for (i = 0; i < MAX_BEARERS; i++) {
 		tipc_node_link_down(n, i, false);
 	}
-- 
2.43.0
