Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694884;
	b=hVwTQJ+ht1Hu0t4d+L6PPJ79TZZVDImVVIQuUMDz/lV5cvhNU7PNFyxooKef++6AU0wf
	 TltFAde/owImSgPpjXxEBM5pZrm+zI1KYvBIvn7c8YxuslRODHSCOut0/sFWXuqSHsSmM
	 tI06uZSvN9OT0JD8SMJ2/VZTboyJZOttpRNH7f1YzBkmWgXm+97VKCl2dj/u/6bbA02Wj
	 YE5UjSGFzz8FqmEDkvGBs3Hsc3X5FtC3DD2E5rizvleLQiCzoPMB8El+xI9Qp/1MV1AYJ
	 +zIW7iIB2q4A/42GnQk8ORQ8nyjvF7ixkJHkKAM4RrJ8ZqccCEeqmvdECD7SReY/dbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694884;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=iXihXJUZiRcyhz06nhVB/zy3BWmg+wdNRE4618SH1bE=;
	b=mFSZAWyrHiqA87w/xcY1DRLZAidDPfvE+plordBof8uzniSppLF3pvUMj+FFBrFK99Od
	 OA0al8zq6T4ZuI3umXHtCqFDqbgN5YOL4ZCjRwTH7QYvTLQyxzFyJ662e1OF+rc7xXQRy
	 8GBPyArCPPvh2XYnoYQQmaxcmFk1llwRyo54HZ5QgZQ/ZewqIdC/0JvwDxX3v5v++klxg
	 wa+EEZImX5DcQYfWMSYOWrB6lmIb7Wef1WxCsv/NP+CvyWrNOS4Nz8neEBb1BUl/Hf3v/
	 n7tFdb5rmu5tKtGOSlInOWHnlYY012mQZmbF7n0+zIztIK1V7CfldEVg5F/XXTa6z/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=ULPGn0tr;
	arc=none smtp.remote-ip=220.197.31.8
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE9B606A33D;
	Tue,  3 Nov 2026 08:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FE9B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=ULPGn0tr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=iXihXJUZiRcyhz06nhVB/zy3BWmg+wdNRE4618SH1bE=;
	b=ULPGn0trtEIuH1ItAI7Al8o1iBVxxYZzSH443PnwE1q6MvYpni6ltJNWr5vIlS
	QclktdtFucemnvzVKMX+B0v3bxl12PIjvF93iSlaT1+K2lRZbrNdE2gROIZJrNiM
	Ex16D8oszTa2SFOsEnzJZy8I3+dWrOWUsYqlcqcYBLcPc=
Message-ID: <d02b00db-d916-412b-ad6c-21959c63c43a@126.com>
Date: Tue, 3 Nov 2026 16:33:57 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] l2tp: fix use-after-free in l2tp_udp_encap_recv()
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, gnault@redhat.com, kuniyu@google.com,
 michael.bommarito@gmail.com, alice.kernel@fastmail.im,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn,
 stable@vger.kernel.org
References: <20261027063657.1359170-1-xiaolinkui@126.com>
 <179340002340.3131.5823454250644987437@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179340002340.3131.5823454250644987437@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3n7Z1nOlqrY+CCg--.63128S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWUGryrWFWrJrW8GF17KFg_yoW5GrW3pF
	yxWF4DJr1vqrs7Zw4qy3WUXr1fGa1SkayrJa48CFy3Zws0g3ZaqrW2ya1Yvay3ur1vk3yj
	ya10g3y8Jr4vkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UajgsUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqBdZMGrpnHfAngAA3g



On 2026/10/31 06:40, netdev-bot+sashiko@kernel.org wrote:
 > - [Medium] The commit message describes a use-after-free that no code
 >   path in the current tree can trigger.
 >
 > Can the backlog path described here actually be reached?

Agreed -- it cannot.  pppol2tp_backlog_recv() is the only
sk_backlog_rcv callback that calls l2tp_udp_encap_recv(), and nothing
ever queues skbs on a PPPoL2TP socket's backlog: sk_add_backlog() is
only reached from __sk_receive_skb(), tcp, sctp, tipc and x25, and the
__sk_receive_skb() callers (pppoe, pptp, l2tp_ip, l2tp_ip6, phonet and
vmci) all target their own socket families, never a PF_PPPOX /
PX_PROTO_OL2TP socket.  pppol2tp_recv() delivers payload with
sock_queue_rcv_skb(), which does not use the backlog either.

 > The live entry point is the UDP encap hook set up in
 > l2tp_tunnel_register():
 >
 > 	.encap_rcv = l2tp_udp_encap_recv,

Right.  That hook is only called from udp_queue_rcv_one_skb() and
udpv6_queue_rcv_one_skb(), under the rcu_read_lock() taken in
ip_local_deliver_finish() and ip6_input(), so the receive path always
holds an RCU read-side reference.  Combined with the kfree_rcu() in
l2tp_tunnel_free(), the tunnel memory cannot go away while it is being
dereferenced, and a strict grace period still cannot end inside a
read-side section, so CONFIG_RCU_STRICT_GRACE_PERIOD cannot expose it
either.  The description of __release_sock() in my commit message was
accurate in itself, but the path is unreachable, so presenting this as
a reachable use-after-free was wrong.

 > The reordering itself looks correct as hardening. Would it be more
 > accurate to describe it that way, and to drop or justify the
 > Cc: stable tag, rather than present it as a reachable use-after-free?

Agreed.  I will respin with the reorder described as hardening: it
removes the dependency on every caller of l2tp_udp_encap_recv()
holding an RCU read-side reference, which holds today but is fragile.
The subject changes accordingly and I drop the backport tags, since
there is no reachable bug to backport.

 > Also, pppol2tp_backlog_recv() appears to be unreachable, and it passes a
 > PPPoX sk to a function that expects a UDP tunnel socket. Could it be
 > removed as part of a respin?

Agreed that it is dead code.  Since it is a cleanup rather than a fix,
I would rather not mix it into this series.  Its removal is already
covered by Qingfang Deng's in-flight net-next series ("l2tp: ppp:
remove unused backlog callback"), so I will leave it to that thread
instead of posting a duplicate.

pw-bot: cr

