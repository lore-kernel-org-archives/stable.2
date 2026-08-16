Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709BE35F5ED
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786891960; cv=none; b=sZczIjKXmq/jylEy92Y9ZIChzLDQp5ERkqgTT4kPimcY9j3S1qTmfMud9mQBr9cRgFn/283620YE7+3L8AlioI1ZG41PG/MxS98CFTViR7zrHPLjNpYGEkMQV1W/YeMjWdiz+ch9R+WpKYSVo6hVVE56brz/IYTW6hPx1N0wsQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786891960; c=relaxed/simple;
	bh=TZ/jMhLpSpiWuZYwnBKNAAe642VAkQvXE89J79snnF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E1lvx6NEdXg1EvICcqeprKxdEVsmZS6vWn06wv7LCzXGFVWlrMfuUrJf2w8q5ERnbPo7pBF5rQdHcgOYHCk44uT3dHQ606pkp3YDfEHBbeYLjiIVbkgHtGky94PiAooC+bsigJhooW3kLg/MIbSkNFcjpdgjlJ2ZuowSz75+ElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wn7PqjSR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3mJ0Vpm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wn7PqjSR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3mJ0Vpm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786891958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVhpy17ZCwCJlu7ncEkrfmPtQ9a8yWWDGxgf/0hovtk=;
	b=Wn7PqjSRNWbMg+ZShYhCC6YXCjYZNhL6dWS7JYqichFXsdjavcUO7EE51+RrNF+w1hkaUR
	ewqi9vo0XqTLW4krY9Sp6WxPtwZ2TVy6fFWxiXVwfEelyitlEQ05VqqF4YGm2UQPf7Mlzv
	LRWOv5UNszwI36x2WfhTll3uyhbpsqA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-mVRzbGrdNXqbcTIdYIcrQA-1; Sun, 16 Aug 2026 10:52:36 -0400
X-MC-Unique: mVRzbGrdNXqbcTIdYIcrQA-1
X-Mimecast-MFC-AGG-ID: mVRzbGrdNXqbcTIdYIcrQA_1786891956
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e53b8a302so269098185a.1
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786891956; x=1787496756; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RVhpy17ZCwCJlu7ncEkrfmPtQ9a8yWWDGxgf/0hovtk=;
        b=Q3mJ0VpmOcL35+Cglw8zZrJEvGVCd1/VBVmmW4zVUlKzS7lwNzFlqe/037liYojHrM
         SeD5mBxM9JkJ/NaIk5u/EkMK+L1kFXoIAPXgNXapHGUAOJFAjZjbi33jyegrxakBNnek
         Py0JSn1N9wpGcqFy+2eyFnwudYvbF9XlEciTlkzKoHM6inlZtQzZyecRT4DnO+r/rNPX
         jczBXrMMJ8uvyvHcPNq2tm2u19JJNW+axTdiM+iWE82eyoWQV1KwcwUYK6ALV6LG1Ii1
         ETWD8eZwvnbyu6aP8cT97JXJQZfjR2ESmyzPCoEob6t3mwzHqIwOhHpz/lRnoCOayUbI
         3JtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786891956; x=1787496756;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RVhpy17ZCwCJlu7ncEkrfmPtQ9a8yWWDGxgf/0hovtk=;
        b=Qtcvi3fs0Chyq/6wMcLnV5DPNVXfeBcVxjwy3kPSB5p8YgnhTLbl45Pgea/5jkFYqw
         xmwI1ZS72HpCQr3JOuYEjLuGnp1qZEp8j1dtLfwlhHEdofj/53MBPytLpRyzpx9lJ5gz
         lJ02piPxk1uEJgRRew1ZWEI1cBJlf53xioFSyAm/tE7RtZcL4AQ13fpMD7HDptQCBtOg
         0PZ58vkOqz0I70l5XAsFklxYAPHkRwf43/yP151RRZgo3T/XwoU7jclCBAAzHgEa94G9
         8pW+CURm7pyHcoiaSdgumrrFOpooyE4PZARaRWnbeJYCCTKNSOdsDqPIXTuEad8oGppr
         kONQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwlGVQn9Bufie9ZnOm/l8D18bVFgDInUomejdyi1CYQ1VpMLj9fWC0nZePv1ki/FKETIBXeo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+5RdoY1R/U+8QeGn+WD7HcpAH088b5yF4xtITHB+uG1I4G77F
	IoSaeAjTumpLgq21NkQNVw3LJlJ+x7hITwJ6D6KQGfMs7dwCoXgUDQHqds8zMGZEaAo4DHdfrIe
	eR2pJ4Vl3aCwSPAkpTh4xeuLsigLXrXL0c9PiLQIEJBDDGpy4rSSCWlAGVZz+lyzhrXObh97sqm
	HCGAYZcRPVmYoDPkgYKeR16uJRo23XnhC+dzDqmDk0Q9k=
X-Gm-Gg: AR+sD11H8+5X67b2b0z7W+gCAERe4bk/Hp9EXg0tFcjBp334KRov/oav1per7FL9CSp
	8vgDlJ2+cvvEKm/dchTWv2Vrne96rgUQlCm1UfhxK6J7XFSopurZzSij5fRK+KJeeR185P9wdHA
	cjA0HDlRc55EEfDwIhmpag0gdvg3IGZoWTXGN5W5zc359Q2N6ERm75+ZQkT99amCKzbnKymr77S
	IUzPAG2ICP3eRIqvV+eI8lW8dph4c7M4Ld9d7atjzgCT3o+vas+Q5O4m+Fi+1Bk/OagJXuKunV0
	2sWtTZPOJtMdSBQed05y3FGM0Jfd0RjOAy5PY/6usi0v1/Q2tvucHmgWqtVFzg3Oqhf5FAFV0V8
	jdtRVx7H2EZD3oSYMy8+Tx1KGgkvb
X-Received: by 2002:a05:620a:7103:b0:936:dbf1:f4c6 with SMTP id af79cd13be357-936dbf20ccbmr1613142485a.25.1786891956082;
        Sun, 16 Aug 2026 07:52:36 -0700 (PDT)
X-Received: by 2002:a05:620a:7103:b0:936:dbf1:f4c6 with SMTP id af79cd13be357-936dbf20ccbmr1613137385a.25.1786891955558;
        Sun, 16 Aug 2026 07:52:35 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce250c20sm760155685a.47.2026.08.16.07.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 07:52:35 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  dev@openvswitch.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH net] net: openvswitch: fix flow mask use-after-free on
 flow deletion
In-Reply-To: <20260815005915.1097270-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Sat, 15 Aug 2026 02:58:56 +0200")
References: <20260815005915.1097270-1-i.maximets@ovn.org>
Date: Sun, 16 Aug 2026 10:52:33 -0400
Message-ID: <f7t5x1anmmm.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ilya Maximets <i.maximets@ovn.org> writes:

> The commit in the Fixes tag below made so flow->mask free is scheduled
> via RCU right after it is removed from the flow table.  The pointer
> stays in the flow structure and it can be accessible while in the same
> RCU critical section.  This is done to avoid requiring ovs_mutex for
> the ovs_flow_free().
>
> However, while removing the flow during processing of CMD_DEL, we do
> not take RCU read lock before the removal, and ovs_flow_cmd_fill_info()
> uses the flow->mask pointer afterwards.  The RCU read lock is taken,
> but it's already late at that point.  The comment on that line
> acknowledges that the lock is cosmetic and doesn't serve a real purpose.
>
> This leads to use-after-free if the RCU grace period passes between
> removal and the filling.  It is a short race window, but it is there
> and can lead to a real crash in case memory allocation for the info
> takes a bit longer:
>
>  BUG: KASAN: slab-use-after-free in __ovs_nla_put_key
>              net/openvswitch/flow_netlink.c:1996
>  BUG: KASAN: slab-use-after-free in ovs_nla_put_key+0x2463/0x2e30
>              net/openvswitch/flow_netlink.c:2250
>  Read of size 4 at addr ffff88801ee89970 by task ovs_flow_del_ec/9487
>
>  Call Trace:
>   <TASK>
>   __ovs_nla_put_key net/openvswitch/flow_netlink.c:1996
>   ovs_nla_put_key+0x2463/0x2e30 net/openvswitch/flow_netlink.c:2250
>   ovs_flow_cmd_fill_info+0x420/0x9c0 net/openvswitch/datapath.c:930
>   ovs_flow_cmd_del+0x53a/0x970 net/openvswitch/datapath.c:1467
>   ...
>   netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2556
>   </TASK>
>
>  Allocated by task 9487:
>   mask_alloc net/openvswitch/flow_table.c:967
>   flow_mask_insert net/openvswitch/flow_table.c:1012
>   ovs_flow_tbl_insert+0xea2/0x1a90 net/openvswitch/flow_table.c:1084
>   ovs_flow_cmd_new+0x7e3/0xd90 net/openvswitch/datapath.c:1086
>   ...
>   netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2556
>
>  Freed by task 9485:
>   rcu_free_sheaf+0x1e/0x100 mm/slub.c:5978
>   rcu_do_batch kernel/rcu/tree.c:2645
>   rcu_core+0x59c/0x10c0 kernel/rcu/tree.c:2897
>   handle_softirqs+0x1e4/0x9a0 kernel/softirq.c:622
>   ...
>   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062
>
> ovs_flow_tbl_remove() must be called after the ovs_flow_cmd_fill_info()
> to avoid this race.  This also helps with cleaning up the forced cast
> and the cosmetic RCU read lock.  Before the commit in the Fixes tag the
> order did not matter as long as the flow object itself was not freed.
>
> A wider RCU critical section could be another option, but we have a
> GFP_KERNEL allocation in the way.
>
> Reported by Trend Micro's Zero Day Initiative as ZDI-CAN-32042.
>
> Fixes: 56c19868e115 ("openvswitch: Make flow mask removal symmetric.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

