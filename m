Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34331396572
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512495; cv=none; b=NFCuh76RkG8MLru4+sHps+0ZkEkVgodGEcxMOLjdJLQfCa/TVQYKU4MYDHnnOWE/gKyoT460gVUZBXL1Ak6fLVIns5k1Fd7l2vVjkEawJdPQF/3NcljuzjEthP1pqN9Wrsd98bGvejGTW0XV4smmsHPtKjQMrwk/1irxqc6hmz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512495; c=relaxed/simple;
	bh=gDL/hg+2WEG/7PcJz5KWczRdzrOB3XMr36RY5ZXjVNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+7Bl77QZ1JD9R38anLMcdu4i0V+LNA9d88HHyM+sZiuvxYMi1EY6poQib/mi07QRA+9EEsk5Xiy/Y3jFsx1I2VwzLgzgGiKRvEyz1jJFTh1XWKHWFfxBoZ3xG/0Gi8AS9EdurNxPGy7XQRkRS9jz1UuN2YIP6WJIIUmleJ6uTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-49ced856e8dso3567865e9.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512492; x=1789117292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FePwHtd70ZMIjpwGmXnNY3f09kVjN5UbT4TYuLUrn7Q=;
        b=jQoEVhruYFqirckBqLhOy/UPitkJzPdFAqL9zG4v+sCdA3EmfhuHLlWxucuyzLF769
         jVRdhpgJ5JOtvTtX5IDhGA63nj8pIqEFAivng5rgqKpuv4oNKt2qKgsy76uEY7n9OoVV
         f/whydbI/Cy1EAvWst3ArQAhpxd3Q15Vt6sHc3tcuaa85tVMiYyE2QWB7iiYPuNAxSiB
         14dSKH0PIF/dz5ou7zeUPC+stwByALne2jXfMknhQ2lfQVG/6sahM2GNEfitHIzppPgQ
         xyt1MGtF1JUN6i1+NQxJiGbtTni1cjR6E1Pdo4NV14JUGqk+xT9WL+WKMkvnx1+4pWGI
         Q+aQ==
X-Gm-Message-State: AFuF++nu203qO1NzztR/sWsn0gRDSXXfHcRXk2b+tRr0uZ35mGrHPlYX
	O4vn/GLiXpopKq6njaFVXXwX98YW3E4UuG36/repsmDbnUCOi4BpJR5YFOKQpANT
X-Gm-Gg: AYBFou3cnahC/uHnRZMuBs19O/SgojgeM9oATfShd3BfV9nGKpJYt7qGtuUVAf7c2p4
	8EWZk8rpMyPdTHQD9t7NheQHaOa+cBtLZ8fucKLgsFA4uNcwQGYFm8eHNAllKcwkiGbDdEKCJiy
	qo78Pv8peoaPxqom4CNbTd/1bh0sZEMiKqRLQ8aIJpJ/Fbgfvcd3bSlH8FzqC9m1fkSfCTGZP0q
	mD442eHSd+DBxSMTD4CD7XqYKrnBPPKF3nTHxLqGwgIqkTZnALUQj3Ga84NEJrhOm2zg5G3SHVv
	D11YVHRfLZjPqxBw4ZS1d8sj4g7CasYcYEUXyLk1UI+QoJEIR3taC52mMsuKi8Bv4eSWrUPZ2TS
	tFo0NVUe/n0LM1D7/c/ItaUseRLCZBYr4Yh/g5fFgezvAfQmCEYz5UAlBDRjA85GP/4oFkCdAXd
	SAdmninG9Qm85AJ4TLw80Upwst53hTY0SVp+c5lK9oCp3TvqzvuXjchiOlySK4tr2P1Vz2mR9lL
	nba8yhGEuCHqX12KVXi+oEqc9N+Rw==
X-Received: by 2002:a05:600c:6383:b0:49c:e88b:b7ce with SMTP id 5b1f17b1804b1-49cf823f147mr69679495e9.11.1788512490765;
        Fri, 04 Sep 2026 02:01:30 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm377191895e9.0.2026.09.04.02.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:01:30 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Fri,  4 Sep 2026 11:01:23 +0200
Message-ID: <20260904090128.1806869-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090319-starless-primp-b336@gregkh>
References: <2026090319-starless-primp-b336@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Norbert Szetei <norbert@doyensec.com>

[ Upstream commit 8ece906150128d5ec2462aabcc978c568433eca4 ]

skb_zerocopy() copies frags from @from into @to. On an
skb_orphan_frags() failure it calls skb_tx_error(@from), a destructive
operation on the source skb the copy helper does not own. That completes
@from's zerocopy uarg and clears SKBFL_ALL_ZEROCOPY, including the
SKBFL_SHARED_FRAG page-ownership marker.

Both callers already report the failure on their own drop path.
nfnetlink_queue does it at nla_put_failure, and Open vSwitch does it in
the flow-miss drop arm of ovs_dp_process_packet(), so nothing is lost by
dropping it here.

On Open vSwitch's OVS_ACTION_ATTR_USERSPACE path the skb is not freed on
this error: do_execute_actions() ignores output_userspace()'s return
value and, unless the upcall was the last action, keeps forwarding the
same skb through the flow's remaining actions. The uarg is completed
while that skb is still in flight, telling the producer its buffers are
free, and SKBFL_SHARED_FRAG is cleared on an skb the rest of the stack
still handles. That flag is what makes esp_input() call skb_cow_data()
instead of decrypting in place, so a later local ESP delivery can
decrypt over frags the skb does not own privately.

Leave error reporting to the callers.

Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in skb_zerocopy and handle errors")
Cc: stable@vger.kernel.org
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/6E3A780D-FB87-421F-9964-B1D457D7D106@doyensec.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ 7.2 and earlier do not have the put_page() call on the error path ]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/core/skbuff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index dcb5d025dc08e..78e99a70dc2cb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3844,10 +3844,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 
 	skb_len_add(to, len + plen);
 
-	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC))) {
-		skb_tx_error(from);
+	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC)))
 		return -ENOMEM;
-	}
+
 	skb_zerocopy_clone(to, from, GFP_ATOMIC);
 
 	for (i = 0; i < skb_shinfo(from)->nr_frags; i++) {
-- 
2.55.0

