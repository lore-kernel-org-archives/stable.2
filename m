Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A011356771
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632606; cv=none; b=G93K0/T0jOag0b2jfq1Mw3Ed45irnXhnuPndcFSAkVdItkqIESYpnX8Efmke4a7bA2cCU27rqXQMsOWa9Sxkt5miMrZZcutz60oQ8FzdB4MdDUGdyhLTKaetxW2lMOhXeA9YE/P+fbw932AbcZLLIXs5r2LvT8j1GyoXIU6jJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632606; c=relaxed/simple;
	bh=zTBX4uJ2je0sZHFIO4v5F3vRjCpVCYmo9zYr4T5Pizo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+LRx0HTEzCLwVguDvuTk/MM1q4y7v5Vu6H+hSE8gGxsApLctO6q0eire2c4oZuqT2A9QaIIoyU0EoEhYBFooAu8a59n20rCoP9np82ZwPqFInYKcw7e9NbQn4LU6unFb+Y/sLbgVIBBMy0G74SvTeZkB43ZdJVv5eH0QHu+tiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TuytHM4N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1QB0+Hc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuytHM4N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1QB0+Hc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789632602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxpwaWgqlb3l6AI1MIqjUVNiDYcws9hnLKUyrIEJE2Q=;
	b=TuytHM4N5vxx1sK390bPleroBqMOd8qGfzwTD5prDRCIqb2xlC75OXAT95WRwVhj3EmFeB
	mmYvK8oZhyRgx1r3fk8b50D12ux58uKRgTdlJl7+wqawLQt6GacqSaURIdcvsylYlHrlf6
	u1NoFBKXGiKTns2kxDSDn4v/TgKehao=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-Hpyhwcv7OTKv_aXJaNJfAQ-1; Thu, 17 Sep 2026 04:10:01 -0400
X-MC-Unique: Hpyhwcv7OTKv_aXJaNJfAQ-1
X-Mimecast-MFC-AGG-ID: Hpyhwcv7OTKv_aXJaNJfAQ_1789632600
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-482e8e1ac69so271774f8f.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789632600; x=1790237400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uxpwaWgqlb3l6AI1MIqjUVNiDYcws9hnLKUyrIEJE2Q=;
        b=J1QB0+Hcn38E+Q29javUrajdxaCiCO75PNfX5FdW9DEzGGSuvfajFIUgNaqPsce1fd
         wgAZAVxBCB4mndB43aG236sr1pYCgYPdNoWrYimWkQbDxKMTVokwe6eLkcvUPGdHl2Z2
         TVhGbksqXqRnFltjtuTSTOuGk8KIW9B74liKyU9qIpl7Z8UtQwj0BGEWNOmOC49v+Ea+
         Ube4X7VoWi2LeKLB+gP3OWI5PoGoC3XqIfRqIfD53GFR2Jp0tE3dTtQGcPZqOXiOOQ6K
         ry0BcGIHpDSJV+jr++sCweZ+q7ktwrTxu7B8eHQBiljlzwMA6Zv6ogBxiNKWz+c9s/lr
         eoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789632600; x=1790237400;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uxpwaWgqlb3l6AI1MIqjUVNiDYcws9hnLKUyrIEJE2Q=;
        b=TD3d7RZb4oakMMpqxbIjPO2sxRI7E1vJ9OK0DaQLiDaJebyn3HB7KSO8W8FfzS42Gs
         5IwDaHUOwEQY8O2o3edhwyXTC4bRwbZlJkQJTQeTMSzptKC1/jfHwdYHuZj9zVBpKjJQ
         JUBGQTpLI3HZvTjx5bcA5m6Czx+a7zS/yA6BPtUy9FFs4TBppUBVjJ41ADHZYbpPEa9a
         aFDIg2gqTSecRWirC+5xpsfRxsluNNU3F7TOknwLlKxbgmZBkw9/acG5kVGnT5SguqIw
         AYLAcocUMOL+8K8zm5i25L0neVgWeWfdmorFj3Of2OsUIIJrxxP0k69ULOhV+FrT6J2b
         iIog==
X-Forwarded-Encrypted: i=1; AKwUvBx8gkgu+iPM2WgXfygntDD2crxToMoxikPMSVcJDEM4dq052hB5OvWhUoUAQW1ep9xOPz/i5PE=@vger.kernel.org
X-Gm-Message-State: AFuF++mYEPoQTXeagqOetr+XuFhuG5hvhJWSkgAeooySZPkFJfC2i061
	/zaPduvGy8hAMWyDrE6hMFHx4T2kKgBQdf6/Wz+Xm2NHTGoD2uyXLURbZTFrBFZYRmvVMk6fpjS
	Ei1bxRIUfChX5UPMbyzoTGmKVaH6WulmTztnWyOTYV30mhfiWOIpTtLJwqQ==
X-Gm-Gg: AYBFou3lNx4g7YbUYJ5eNzycKs3AI4RkORm7jA7iyfQ17LLVjavuE1fHkx4z/EkSlXr
	D+kAisqB1ltd3JhXNLucPdvcBZrpiuSZ0uH2B9jc9EQwkgG6LAyJjZI62N2Uu6tLtB786XXRKoS
	L5dMLMbgcy7+28OfPNN244ZKhmS/VtoFoEEfrdftJoTGQ/mS0woWorIjaM/3jPBBWz7PVSq0/2N
	m5BsV71UEJ0f+NsyRYomsaEzsstUe+Gn+7yr2gkP6ZGXQ37QcxTA4LXRhxeMHDrYw8L7ESY3ZNJ
	Xjmtg7rNYS+hjhmwmvhIIqwIuB+X23cRB6tRl4e0C6ZM8+HFgPJlB5Lr30UxpdbR44NmZRWokCt
	BFEKWJAWvLg1zuA8pepYgM7Zi5a5SRoKB3hiVzYF8Q0o6uqu79rM6ds0dEuNbu6JxaxD+ZuJcgQ
	==
X-Received: by 2002:a05:600d:8643:20b0:49e:7c8c:bc77 with SMTP id 5b1f17b1804b1-49fbd1c9005mr22472685e9.7.1789632599794;
        Thu, 17 Sep 2026 01:09:59 -0700 (PDT)
X-Received: by 2002:a05:600d:8643:20b0:49e:7c8c:bc77 with SMTP id 5b1f17b1804b1-49fbd1c9005mr22472315e9.7.1789632599375;
        Thu, 17 Sep 2026 01:09:59 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd17051fsm57323325e9.0.2026.09.17.01.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 01:09:58 -0700 (PDT)
Message-ID: <126c1419-0df6-49b5-9cef-cb9f45c716c0@redhat.com>
Date: Thu, 17 Sep 2026 10:09:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tipc: reject invalid and unexpected GRP_ACK_MSG to
 prevent bc_ackers underflow
To: edumazet@google.com, tung.quang.nguyen@est.tech
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jamesburton@meta.com,
 stable@vger.kernel.org, security@1seal.org, jmaloy@redhat.com,
 netdev-bot+sashiko@kernel.org
References: <20260913044233.193927-1-edumazet@google.com>
 <178936156410.22033.16977639465746131797@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178936156410.22033.16977639465746131797@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/14/26 06:52, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0
> 
> - [Medium] Incomplete ACK accounting in tipc_group_proto_rcv()
>    (net/tipc/group.c:799-808): the new validation gates the decrement of…
> 
> Pre-existing issues:
> - [Medium] Pre-existing (not introduced or claimed by this patch): in
>    tipc_send_group_bcast() (net/tipc/socket.c:1131-1137) the packets…
> 
> --
> 
> tipc: reject invalid and unexpected GRP_ACK_MSG to prevent bc_ackers underflow
> 
> This tightens the GRP_ACK_MSG path in tipc_group_proto_rcv() so that the
> message is dropped when grp->bc_ackers is zero, and so that only an ACK
> whose value equals grp->bc_snd_nxt (and which is not a repeat of the
> member's own last ACK) is allowed to decrement grp->bc_ackers.
> 
>> diff --git a/net/tipc/group.c b/net/tipc/group.c
>> index 14e6732624e28..74f6d3dac0784 100644
>> --- a/net/tipc/group.c
>> +++ b/net/tipc/group.c
>> @@ -797,10 +797,10 @@ void tipc_group_proto_rcv(struct tipc_group *grp, bool *usr_wakeup,
>>   		tipc_group_open(m, usr_wakeup);
>>   		return;
>>   	case GRP_ACK_MSG:
>> -		if (!m)
>> +		if (!m || !grp->bc_ackers)
>>   			return;
>>   		acked = msg_grp_bc_acked(hdr);
>> -		if (less_eq(acked, m->bc_acked))
>> +		if (acked != grp->bc_snd_nxt || m->bc_acked == acked)
>>   			return;
>>   		m->bc_acked = acked;
>>   		if (--grp->bc_ackers)
> 
> [Severity: Medium]
> The new test gates the decrement on the sequence value and on per-member
> duplication.  Does it also need to check that the acking member was one of
> the members actually counted into grp->bc_ackers for the current round?
> 
> tipc_group_update_bc_members() counts and re-arms receivers only:
> 
> net/tipc/group.c:tipc_group_update_bc_members() {
> 	u16 prev = grp->bc_snd_nxt - 1;
> 	...
> 	for (n = rb_first(&grp->members); n; n = rb_next(n)) {
> 		m = container_of(n, struct tipc_member, tree_node);
> 		if (tipc_group_is_receiver(m)) {
> 			tipc_group_update_member(m, len);
> 			m->bc_acked = prev;
> 			ackers++;
> 		}
> 	}
> 
> 	/* Mark number of acknowledges to expect, if any */
> 	if (ack)
> 		grp->bc_ackers = ackers;
> 	grp->bc_snd_nxt++;
> }
> 
> A member in MBR_JOINING or MBR_LEAVING is therefore neither summed into
> ackers nor re-armed, so it keeps a stale m->bc_acked.  The same holds for a
> member created after the round was published, since
> tipc_group_create_member() sets:
> 
> 	m->bc_acked = grp->bc_snd_nxt - 1;
> 
> In both cases m->bc_acked differs from grp->bc_snd_nxt, so a GRP_ACK_MSG
> from that member passes both new conditions and still executes
> --grp->bc_ackers although it contributed no increment.  The lookup on this
> path, tipc_group_find_member(), applies no state filter.
> 
> Can that let grp->bc_ackers reach zero while a counted receiver still owes
> an ACK?  The number of accepted decrements per round looks bounded by
> grp->member_cnt rather than by the counted acker set.
> 
> If bc_ackers is cleared early, tipc_group_bc_cong() stops reporting
> congestion:
> 
> net/tipc/group.c:tipc_group_bc_cong() {
> 	/* If prev bcast was replicast, reject until all receivers have acked */
> 	if (grp->bc_ackers) {
> 		*grp->open = false;
> 		return true;
> 	}
> 
> so the sender releases the next group broadcast while the previous replicast
> round is still outstanding, which is the ordering guarantee from
> 2f487712b893, one of the Fixes tags on this patch.  The zero-transition
> branch also runs list_del_init(&m->small_win) and *m->group->open = true for
> the acking member, which need not be a receiver, and the genuine acker's
> later ACK is then swallowed by the new !grp->bc_ackers guard, so its
> small_win / tipc_group_update_member() bookkeeping never runs.
> 
> The commit message states that "each member can acknowledge at most once per
> round" - that part holds per member, but does it cover members that were
> never counted for the round?
> 
> Would a per-round marker set in tipc_group_update_bc_members(), or accepting
> only members whose m->bc_acked == grp->bc_snd_nxt - 2, close the remaining
> gap?
> 
> The u16 wrap to 65535 itself does look closed by the new !grp->bc_ackers
> guard, so what is left here is the premature clearing of the counter that
> item 2 of the commit message also mentions.

My reading of the above is that it's a slightly different problem, that 
could/should deserve a separate patch. WDYT?

/P

