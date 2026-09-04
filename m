Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC93328E6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511560; cv=none; b=n2Y3kkNnBeLRdJoLcpLykdIDsfTf1GLzbISy0SdFNOjIQwy7XMjllinqHIlO7HStX3wCctuE4RaVkLhkA7MyKu8SJzdz1611TIz4aNEKbLCeCFjglY1R8KhD1ga9WfeBE1mV5+rqbf6ACsdbD17SzQ3viAi4VT2bMOlhl7il9lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511560; c=relaxed/simple;
	bh=FLDEsSAa2+m6S4EF/ompTgTPij3OOK6Am7uPxLgE5r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJAI9dJnP6z+CkAP9apnAyhb3FqmHLxHjDzYAclPtXiAc6yuPMQ/b1dgVSRYUXwxuDZe8ESqhYFPNt9ShYsKcPqrNvBC7OGp3GsVNpJEaZiUhyu2jq7pWGEd+HM/Z3reQ9Zyjo81ezEZvt/W/6LJxodZagXjiCrSjUKTre23vIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-48437cc1b11so178428f8f.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 01:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511557; x=1789116357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4uh/02DDJMZW39qbmvm10HhjW9DgxMQJRjUYEQ1IFzY=;
        b=Ad4q+uUJ8CgkrI670LYCUhKZCrMoAtvOKQEcDjLJostluWZ214Rv12Uiujcyoclrca
         XphPC2quwGlPvgP52kAHDbFFjO7wSW6pYFEOb8LPCVC6AgxEXCEdIjwDzaSrXvVj2pnJ
         bnhAlaIcULpborFwoDgo+DJ/5kmRX5ia5mZ5CnwxUNmagvjvzHhcFzVHQxldGbu0y45B
         wI6RZDHEq9hD3euCifSmxsE3Aj7g6uoNvo/XCUXFm9u3pyigVXGQwq9b4D2LPzSojcBG
         m5cSW+gLmgjYExVUPqm5MxsYN/OAd+7b32qIOToc7gD9pSkSS+PMR6nqChosuAo7ACgb
         5aZQ==
X-Gm-Message-State: AFuF++nFlPVzoZknsPAiWBGZ6XzWluL/i25tjtlAYagGFdIMgBsVXp4J
	X5fpFdHMNsd2WY1aumiI09323fkuGHY4rJKMd5sXZ9Jv2H1zCykXp5RHPmGn29rh
X-Gm-Gg: AYBFou1w3FihFPyOwqatdXTh6bmCCDcgeKcK/yKEiAEsxTsc3iaFC0TVl7LNMKmaUc7
	Livmg1ehoPRwM86ElD4Nd6eslhX/Lz3NxVErasdQwyK9OPz/pbJfya2gHwJccg+4FLdE9NQaxqq
	kKEZHR/2dgKxX7WrSGpx6OqgAmpnkvT7gUPUNSrSqyYL4XC/DBTjC61aGhEEuBZjFYcm75d7Xmi
	lIs9n9pBDkzR6B9wFMTU5s8iYW6TmCQaecUnHavP66+2WZL3Srp7BlbDizectE7mKg2o7oQ8YEw
	o9OfIwSzizivUPII05xLRDaiu5gXUGvXuqVQIG6/8BwjAPCh9G53yarI8PRib0O/u01X8xMrPlV
	i8y7pI9nJ3AoRrq5Nrpu99sm6jqfhTuSCLbM+2i0Azci3o+nUoeTYJW+LVDZa53WD1vHIKrPuep
	RkbVXO+u++bi1L0CZlfmZoxahYalmE3zqAbCtVzfkDW7+7UM+PC1kOn6lK3DaSMvtcHxITt90zN
	MTpWkiIdrpFqBmv9xI=
X-Received: by 2002:a05:6000:178e:b0:485:8c17:9770 with SMTP id ffacd0b85a97d-4858c1799a8mr1577504f8f.50.1788511556732;
        Fri, 04 Sep 2026 01:45:56 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfe14sm4751944f8f.35.2026.09.04.01.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:45:56 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jongmin Jang <payload.jang@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] net: skbuff: don't touch shared zerocopy state in skb_tx_error()
Date: Fri,  4 Sep 2026 10:45:33 +0200
Message-ID: <20260904084540.1802837-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090310-contort-crabmeat-e1bf@gregkh>
References: <2026090310-contort-crabmeat-e1bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Norbert Szetei <norbert@doyensec.com>

[ Upstream commit f66bdb1cc0fcd227a062378f8be0b5873aa5600a ]

skb_tx_error() completes the zerocopy uarg and clears
SKBFL_ALL_ZEROCOPY, and skb_zcopy_downgrade_managed() clears
SKBFL_MANAGED_FRAG_REFS. Both live in skb_shinfo(), which every clone
shares, while the caller only owns the reference it is about to drop.
Through a clone it tells the producer its pages are free and drops
SKBFL_SHARED_FRAG for an skb that is still in flight.

Open vSwitch reaches this with a non-last OVS_ACTION_ATTR_RECIRC:
clone_execute() sends a skb_clone() into ovs_dp_process_packet() while
do_execute_actions() keeps forwarding the original, and skb_clone()
does not privatise the frags here -- skb_orphan_frags() returns early
on SKBFL_DONT_ORPHAN. A flow miss on the clone then strips the marker
from the packet still being forwarded, and a later local ESP delivery
decrypts in place over frags it does not own privately.

Skip it for a cloned skb. Nothing is lost: skb_release_data() clears
the zerocopy state once the last reference to the shared data goes.

Fixes: 25121173f7b1 ("skb: api to report errors for zero copy skbs")
Cc: stable@vger.kernel.org
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Tested-by: Jongmin Jang <payload.jang@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/CFAB292A-674B-4C14-BB2C-BB8830AD5659@doyensec.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ There was no 'if' on 5.x as there is no skb_zcopy_downgrade_managed(). ]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/core/skbuff.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 793b58979e5ca..9d7ebb9216773 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -825,10 +825,14 @@ EXPORT_SYMBOL(skb_dump);
  *
  *	Report xmit error if a device callback is tracking this skb.
  *	skb must be freed afterwards.
+ *
+ *	Does nothing for a cloned skb: the zerocopy state lives in
+ *	skb_shinfo(), which the clones share.
  */
 void skb_tx_error(struct sk_buff *skb)
 {
-	skb_zcopy_clear(skb, true);
+	if (skb && !skb_cloned(skb))
+		skb_zcopy_clear(skb, true);
 }
 EXPORT_SYMBOL(skb_tx_error);
 
-- 
2.55.0

