Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645544606D
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046726; cv=none; b=rYY6Fx4C5wAd+ZDrkJZstqKnjoUIxWitFMl9mAGHS3gLcujuNw27MgL8lt4YslH3MCQR7zArT3T5LjkxB4NOFLKVSYOKdOGYF6JDVy4cLNzGDLUCY8nHAsiXf8sTlbwje+zJ8ffOeK4lzuRZMnqiK9uUXu/IFSaXbAVYoDlrKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046726; c=relaxed/simple;
	bh=SAjw7KZbx2DnNq9czRuoPLFL9JLvlzBz/0g93jxh6Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mje/5ecBm5AEj1J4bs/k/V7YTMxmQlS76DcXe8en+R8aBs7CpyapiBI9w+z+N+a2cpOL2tClRXwwUW1XKw9HA1FY928+lNjDnLeSZan1H3fO34EXo+t2hQaxe4sFPN6Mwuu+VsLNtQQ5qABxz5KYn2zXOJT73Gn99FSQYU5b0fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mt5Mcd7J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mt5Mcd7J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787046723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RscoxvoxcOd9204f8avF2YPEREX3y6Muq3c1K0CGqQ=;
	b=Mt5Mcd7JX9coCiTU/6vqhPC4NRd71AWgatnBBHnAJd91DABmIAd1vCOP1oJpKQ9RTEIFfA
	LOj8SztTuDiU7gxyJIBvQHB8TOMbZKj1iNR3p/IaRq0xYKSMwC18hg7HDxjjFWxk8APLdi
	29xo/J1+3qOMQWdMgStXORmZUf5ojXM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-eJphZz6iPuKdR_N0CvMqjw-1; Tue,
 18 Aug 2026 05:51:59 -0400
X-MC-Unique: eJphZz6iPuKdR_N0CvMqjw-1
X-Mimecast-MFC-AGG-ID: eJphZz6iPuKdR_N0CvMqjw_1787046718
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1C6718002C0;
	Tue, 18 Aug 2026 09:51:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.207])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84EEB1956042;
	Tue, 18 Aug 2026 09:51:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jedrzej.jagielski@intel.com
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	aleksandr.loktionov@intel.com
Subject: Re: [PATCH net v2 2/3] net/sched: cls_u32: fix linked hash table refcount leak
Date: Tue, 18 Aug 2026 11:51:39 +0200
Message-ID: <20260818095139.103947-1-pabeni@redhat.com>
In-Reply-To: <20260813122242.1690024-3-jedrzej.jagielski@intel.com>
References: <20260813122242.1690024-3-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net/sched: cls_u32: fix linked hash table refcount leak

The patch drops the reference on n->ht_down at the errunbind label of
u32_change(), so that a newly created filter carrying TCA_U32_LINK does not
leave the linked tc_u_hnode refcount elevated when u32_replace_hw_knode()
fails.

Closes: https://sashiko.dev/#/patchset/20260807100356.1083774-1-jedrzej.jagielski%40intel.com

Two questions, one about the Fixes tag and one about the sibling error path
in the same function.

> Fixes: af69afc51a56 ("net/sched: cls_u32: Fix reference counter leak leading to overflow")

[Severity: Medium]
Does this SHA resolve anywhere?  In this tree:

  $ git show af69afc51a56
  fatal: ambiguous argument 'af69afc51a56': unknown revision or path not
  in the working tree.

The commit whose subject matches verbatim is 04c55383fa56 ("net/sched:
cls_u32: Fix reference counter leak leading to overflow", Lee Jones,
2023-06-08), and that one resolves fine, so it looks like the digits in the
tag got mangled.

Beyond the typo, is 04c55383fa56 the right blame target?  The leak fixed
here is on the u32_replace_hw_knode() failure path of the new-node branch of
u32_change().  git blame of that area points at the addition of the
errunbind label (9cb36faedeaf) and, for the offload error goto itself, at
d34e3e181395, whereas 04c55383fa56 only reordered the INDEV/LINK validation
inside u32_set_parms().

Since the patch carries Cc: <stable@vger.kernel.org>, would it make sense to
correct the tag so the stable tooling can compute the affected trees?

> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 1374da97836eb..f8be2894db85b 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -875,7 +875,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
>  		      struct netlink_ext_ack *extack)
>  {
>  	struct tc_u_common *tp_c = tp->data;
> -	struct tc_u_hnode *ht;
> +	struct tc_u_hnode *ht, *ht_down;
>  	struct tc_u_knode *n;
>  	struct tc_u32_sel *s;
>  	struct nlattr *opt = tca[TCA_OPTIONS];

[ ... ]

> @@ -1192,6 +1192,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
>  
>  errunbind:
>  	u32_unbind_filter(tp, n, tb);
> +	ht_down = rtnl_dereference(n->ht_down);
> +	if (ht_down && refcount_dec_and_test(&ht_down->refcnt))
> +		kfree(ht_down);

[Severity: Medium]
This isn't a bug introduced by this patch, but with the create path now
balanced, does the sibling "replace existing knode" branch of u32_change()
still hold an unowned reference on the linked hash table?  That branch does:

  net/sched/cls_u32.c:u32_change() {
	err = u32_replace_hw_knode(tp, new, userflags, extack);
	if (err) {
		u32_unbind_filter(tp, new, tb);

		if (tb[TCA_U32_LINK]) {
			struct tc_u_hnode *ht_old;

			ht_old = rtnl_dereference(n->ht_down);
			if (ht_old)
				refcount_inc(&ht_old->refcnt);
		}
		__u32_destroy_key(new);
		return err;
	}

The increment is applied to n->ht_down, i.e. the old node's linked table,
while the only later release is __u32_destroy_key(new), which drops
new->ht_down.

Walking it through for n->ht_down == A and a request linking to B:

  u32_init_knode()      new->ht_down = A, refcount_inc(A)
  u32_set_parms()       refcount_inc(B), new->ht_down = B,
                        refcount_dec(A)      /* consumes the ref above */
  error handler         refcount_inc(A)      /* no owner */
  __u32_destroy_key()   drops new->ht_down == B

so A ends up permanently at +1.  The same +1 happens for TCA_U32_LINK with
handle 0, where new->ht_down becomes NULL.

Does that then make the linked table undeletable, given u32_delete():

  net/sched/cls_u32.c:u32_delete() {
	if (refcount_dec_if_one(&ht->refcnt)) {
		u32_destroy_hnode(tp, ht, extack);
	} else {
		NL_SET_ERR_MSG_MOD(extack, "Can not delete in-use filter");
		return -EBUSY;
	}

Each failed offload on a change of an existing key node with TCA_U32_LINK
would add another reference, and the tc_u_hnode is then leaked.

For the record, this block is deleted by the later patch in the series,
"net/sched: cls_u32: remove erroneous refcount_inc()", so the two paths are
only inconsistent at this commit.  Would it be worth reordering the series
so the two error paths are never out of sync?
-- 
This is an AI-generated review.

